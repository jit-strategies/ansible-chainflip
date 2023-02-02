jitstrategies.chainflip.cli
=========

This role runs the Chainflip CLI.

Requirements
------------

- `chainflip-cli` installed on the host you are targeting. This should already be done if the [Node](../node/README.md) role was used to setup the node.

Role Variables
--------------
The role uses the following variables:

|Variable|Description|Default Value
|---|---|---|
|`retries`|Number of times to retry a failed request|3
|`delay`|Delay between retries in seconds|6
|`config_path`|Path to the config file|`/etc/chainflip/config/Default.toml`
|`signing_key_file`|Path to the signing key file|`/etc/chainflip/keys/signing_key_file`
|`ws_endpoint`|Websocket endpoint to connect to the statechain node|`ws://127.0.0.1:9944`
|`ignore_errors`|whether to ignore errors or not|`false`
|`command`|The command to run|

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
---
- name: Run chainflip-cli Commands
  hosts: all
  collections:
    - jitstrategies.chainflip
  gather_facts: true
  become: false
  tasks:
    - name: Run CLI
      ansible.builtin.include_role:
        name: jitstrategies.chainflip.cli
      vars:
        command: "activate --help"
```

License
-------

Apache License Version 2.0

See [LICENSE](LICENSE) for the full text.
