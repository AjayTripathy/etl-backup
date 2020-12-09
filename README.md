# etl-backup
Back up Kubecost's ETL data to your local filesystem. Execs into the kubecost pod, tars the contents of the ETL files, and `kubectl cp`'s them down to your local machine.

Usage: 

With your kubectl connected to the cluster whose data you want to back up:

```
git clone https://github.com/kubecost/etl-backup.git
cd etl-backup
./download-etl.sh <kubecost-namespace>
```
