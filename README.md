# Ansible Collection - jitstrategies.chainflip

_The efficient cross-chain swapping protocol_

This collection contains roles and playbooks to deploy and manage Chainflip nodes and validators.

## Features

- Chainflip blockchain node deployment (includes State Chain node and Engine).
- Run arbitrary commands using CLI role
- Backup keys and configuration (TBD)

## Requirements

- Ansible 2.10+
- Ubuntu Linux is the supported distribution for the nodes and validators. For details check [Chainflip documentation](https://docs.chainflip.io).

## Usage

### Installation

**Ansible Galaxy**

This command will get the whole collection from galaxy:

```bash
ansible-galaxy collection install jitstrategies.chainflip
```

### How to deploy a node

As a best practice, you should generate a fresh private Ethereum key and provide it encrypted to the playbook, so the key is not sitting in plaintext in your playbook. There are many ways to provide secrets to an Ansible playbook, but here's an example using Ansible's vault. First encrypt the key, replacing ETH_PRIVATE_KEY you your actual hex encoded private key. If there is a `0x` at the front, please **remove** it:

```bash
ansible-vault encrypt_string "ETH_PRIVATE_KEY" --name 'engine_eth_private_key'
```

The command should output a variable like the following:

```yaml
engine_eth_private_key: !vault |
  $ANSIBLE_VAULT;1.1;AES256
  62303838316663633739383664383831336464653235386631373137616430633363333636666237
  3036376665623638616232616361313765636130393531640a373431643335343462623839393766
  64633263363634373537623836663164663664663239333733633265646665323435393039613866
  3565333734366461650a353663333435376630316138313039373239373430633337653837633235
  34633438343865353738316634633466626464663538393633356561386236363137313938666361
  33363366613162363935656636316662346434353934623465336263643730376437323838666263
  63346630333064643038626231323533386430636239316331656363636466303338333437383735
  30353565643637383334
```

Then, you can use this in the a playbook like `playbooks/node_deploy.yml` and configure the node variables to you needs, like this example:

```yaml
---
- name: Provision validator
  hosts: all
  collections:
    - jitstrategies.chainflip
  gather_facts: true
  become: true
  tasks:
    - name: Deploy Chainflip node
      ansible.builtin.include_role:
        name: jitstrategies.chainflip.node
      vars:
        node_archive: true
        node_validator: true
        engine_eth_private_key: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          62303838316663633739383664383831336464653235386631373137616430633363333636666237
          3036376665623638616232616361313765636130393531640a373431643335343462623839393766
          64633263363634373537623836663164663664663239333733633265646665323435393039613866
          3565333734366461650a353663333435376630316138313039373239373430633337653837633235
          34633438343865353738316634633466626464663538393633356561386236363137313938666361
          33363366613162363935656636316662346434353934623465336263643730376437323838666263
          63346630333064643038626231323533386430636239316331656363636466303338333437383735
          30353565643637383334
        engine_eth_ws_node_endpoint: "wss://goerli.infura.io/ws/v3/3bff9a8745d1952291aa895d3fd42097"
        engine_eth_http_node_endpoint: "https://goerli.infura.io/ws/v3/3bff9a8745d1952291aa895d3fd42097"
```

Then create an inventory file with the hostnames and/or IPs where you want to install and deploy Chainflip:

```yaml
[validators]
my-validator.example.xyz
```

And run the playbook:

```bash
ansible-playbook --ask-vault-pass -i inventory --user=ubuntu vault_deploy.yml
```

At the end of the playbook run, the public keys of your node will be shown as in the following example:

```
TASK [node : Print the P2P pubkey] *********************************************
ok: [validator01] => {
    "msg": "Node configured with P2P public key: 12D3KooWHy2Q5vGBwkJd4TqcUkQ3UjXWRwzujuLidWDnU27jyjs1"
}

TASK [node : Print the SS58 address] *******************************************
ok: [validator01] => {
    "msg": "Node engine configured with SS58 address: cFL3w9ZmieVYnjtNKVMsiNphg1RrMFd51fs8WUui1a2GugtEy"
}

```

## Roles

- [Node](roles/node/README.md)
- [CLI](roles/cli/README.md)

## Testing

This repository uses the [Molecule](https://molecule.readthedocs.io/en/latest/) Ansible testing framework.

### Contributing

#### Prerequisites
If you would like to contribute to this project, we would ask you to use the following environment setup to ensure that your changes are compatible with the CI pipeline:
- [Docker](https://www.docker.com/)
- [pyenv](https://github.com/pyenv/pyenv)

#### Setup
1. Clone the repository: `git clone https://github.com/jit-strategies/chainflip-ansible-collection.git`
2. Install and activate the correct Python version: `pyenv install 3.10.9 && pyenv shell 3.10.9`
2. Run the following command to setup the virtual environment: `make setup`
3. Activate the virtual environment: `source .venv/bin/activate`

## License

Apache License Version 2.0

See [LICENSE](LICENSE) to see the full text.
