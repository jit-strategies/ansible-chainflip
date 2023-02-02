jitstrategies.chainflip.node
=========
This role installs and configures a Chainflip Validator node. It streamlines the node setup process described in the [Chainflip Perseverance Documentation](https://docs.chainflip.io/perseverance-validator-documentation/).

Requirements
------------

- Ubuntu Linux 20.04 LTS

Role Variables
--------------
The role uses the following variables:
|Variable|Description|Default Value
|---|---|---|
|`chainflip_chain`|The chain to run the node on.|`perseverance`
|`ubuntu_release`|The Ubuntu release to use.|`focal`
|`chainflip_release`|The Chainflip release to use.|`{{ chainflip_chain }}`
|`chainflip_apt_repository_url`|The URL of the Chainflip APT repository.|`https://repo.chainflip.io`
|`chainflip_apt_repository_key_id`|The ID of the Chainflip APT repository GPG key.|`FB3E88547C6B47C6`
|`health_check`|Whether to run the health checks.|`true`
|`node_chaindata_path`|The path to the chain data directory.|`/etc/chainflip/chaindata`
|`node_chainspec_file`|The path to the chainspec file.|`/etc/chainflip/{{chainflip_chain}}.json`
|`node_p2p_key_file`|The path to the node's P2P key file.|`/etc/chainflip/keys/node_key_file`
|`node_systemd_override`| Whether to override the systemd service file.|`true`
|`node_dev_mode`|Whether to run the node in development mode.|`false`
|`node_validator`|Whether to run the node as a validator.|`true`
|`node_archive`|Whether to run the node in archive mode.|`true`
|`node_prometheus_external`|Whether to expose the Prometheus metrics externally.|`false`
|`node_state_cache_size`|The size of the state cache.|`0`
|`node_bootnodes`|The bootnodes to connect to.|`""`
|`node_rpc_port`|The port to expose the RPC interface on.|`9933`
|`engine_enabled`|Whether to enable the engine.|`true`
|`engine_generate_eth_key`|Whether to generate an Ethereum key for the engine.|`false`
|`engine_p2p_key_file`|The path to the engine's P2P key file.|`{{ node_p2p_key_file }}`
|`engine_p2p_port`|The port to expose the engine's P2P interface on.|`8078`
|`engine_state_chain_ws_endpoint`|The WebSocket endpoint of the state chain.|`ws://127.0.0.1:9944`
|`engine_state_chain_signing_key_file`|The path to the state chain signing key file.|`/etc/chainflip/keys/signing_key_file`
|`engine_eth_ws_node_endpoint`|The WebSocket endpoint of an Ethereum node or Ethereum RPC Provider|`ws://127.0.0.1:8080`
|`engine_eth_http_node_endpoint`|The HTTPS endpoint of an Ethereum node or Ethereum RPC Provider|`https://127.0.0.1:8080`
|`engine_eth_private_key_file`|The path to the Ethereum private key file.|`/etc/chainflip/keys/ethereum_key_file`
|`engine_health_check_host`|The hostname to use for the health check.|`127.0.0.1`
|`engine_health_check_port`|The port to use for the health check.|`5555`
|`engine_signing_db_file_name`|The name of the signing database file.|`data.db`
|`engine_polkadot_rpc_ws`|The WebSocket endpoint of a Polkadot node.|`ws://127.0.0.1:8081`

Example Playbook
----------------

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
        engine_eth_private_key: "0x0000000000000000000000000000000000000000000000000000000000000000"
        engine_eth_ws_node_endpoint: "wss://goerli.infura.io/ws/v3/3bff9a8745d1952291aa895d3fd42097"
        engine_eth_http_node_endpoint: "https://goerli.infura.io/ws/v3/3bff9a8745d1952291aa895d3fd42097"
```
License
-------

Apache License Version 2.0

See [LICENSE](LICENSE) for the full text.

