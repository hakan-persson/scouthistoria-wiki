# Scouthistoria wiki
This repo contains a Docker file to build a pre-configured Scouthistoria Mediawiki image. It is based on the https://hub.docker.com/r/bitnami/mediawiki container (source at https://github.com/bitnami/containers/tree/main/bitnami/mediawiki).

The deployments options are the same as the Bitnami container.

**The image is still under development!!!**

## Installing

The preferred install method is to use [Helm](https://helm.sh/).

helm install scouthistoria-wiki bitnami/mediawiki --repo https://charts.bitnami.com/bitnami --namespace scouthistoria --create-namespace -f helm.yaml

[helm.yaml](templates/helm.yaml) contains parameters for the necessary install options. These can be modified if needed.

It's is also possible to use other tools that support Helm, i.e., Portainer, to install the Wiki. 

## Upgrading (incomplete)

https://docs.bitnami.com/general/how-to/troubleshoot-helm-chart-issues/#credential-errors-while-upgrading-chart-releases<br/>

'mediawikiPassword' must not be empty, please add '--set mediawikiPassword=$MEDIAWIKI_PASSWORD' to the command. To get the current value:<br/>

`export MEDIAWIKI_PASSWORD=$(kubectl get secret --namespace "scouthistoria" scouthistoria-wiki-mediawiki -o jsonpath="{.data.mediawiki-password}" | base64 -d)`<br/>

'mariadb.auth.rootPassword' must not be empty, please add '--set mariadb.auth.rootPassword=$MARIADB_ROOT_PASSWORD' to the command. To get the current value:<br/>

`export MARIADB_ROOT_PASSWORD=$(kubectl get secret --namespace "scouthistoria" scouthistoria-wiki-mariadb -o jsonpath="{.data.mariadb-root-password}" | base64 -d)`<br/>

'mariadb.auth.password' must not be empty, please add '--set mariadb.auth.password=$MARIADB_PASSWORD' to the command. To get the current value:<br/>

`export MARIADB_PASSWORD=$(kubectl get secret --namespace "scouthistoria" scouthistoria-wiki-mariadb -o jsonpath="{.data.mariadb-password}" | base64 -d)`<br/>
