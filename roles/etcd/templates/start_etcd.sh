etcd --name {{ ansible_hostname }} --initial-advertise-peer-urls http://{{ ansible_hostname }}:2380 \
  --listen-peer-urls http://0.0.0.0:2380 \
  --listen-client-urls http://0.0.0.0:2379,http://127.0.0.1:2379 \
  --advertise-client-urls http://0.0.0.0:2379 \
  --initial-cluster-token 38ae8726-8e20-43fe-9605-5fe97a347c24 \
  --initial-cluster {% for node in groups.etcd_nodes %}node={{ node }}http://{{ node }}:2380{% if not loop.last %},{% endif %}{% endfor %} \
  --initial-cluster-state new
