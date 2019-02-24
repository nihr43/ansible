etcd --name {{ ansible_hostname }} --initial-advertise-peer-urls http://{{ ansible_hostname }}:2380 \
  --listen-peer-urls http://0.0.0.0:2380 \
  --listen-client-urls http://0.0.0.0:2379,http://127.0.0.1:2379 \
  --advertise-client-urls http://{{ ansible_hostname }}:2379 \
  --initial-cluster-token {{ cluster-token }} \
  --initial-cluster {% for node in groups.[mygroup] %}{{ node }}=http://{{ node }}:2380{% if not loop.last %},{% endif %}{% endfor %} \
  --initial-cluster-state new
