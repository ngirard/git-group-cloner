# Generate the static call graph
gen_call_graph:
    callGraph -language sh -ignore '(log|error)' -start main git-group-cloner --output docs/call_graph.svg
