# Consul Cluster on EC2 with TF and Packer

Upon loss of leader, momentary errors on both peers: 
- Error querying Consul agent: Unexpected response code: 500 (Raft leader not found in server lookup mapping)
- Error querying Consul agent: Unexpected response code: 500 (rpc error getting client: failed to get conn: dial tcp {{IPs here}}: connect: connection refused)

New leader immediately promoted and requests resolved w/in seconds.
