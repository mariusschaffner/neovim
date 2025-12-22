;; Ansible win_powershell → PowerShell highlighting
(
  (block_mapping_pair
    key: (flow_node) @key
    value: (block_node (block_scalar) @injection.content))
  (#match? @key "^script$")
  (#set! injection.language "powershell")
)
