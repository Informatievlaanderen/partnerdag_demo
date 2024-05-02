# Example LDES Consumption
Simply start de [client workflow](./config.yml) containing the LDES client as follows:
```bash
docker compose up -d
```

Now watch your message sink accept each observation:
```bash
while :; do curl http://${HOSTNAME}:9003; echo ''; sleep 300; done
```

You can request the (first 100) members at http://localhost:9003/member.
