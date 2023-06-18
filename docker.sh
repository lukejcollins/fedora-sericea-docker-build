set -e

cd /home/lukecollins/git/silverblue-sway-build-dockerfile

sudo docker build -t lukejcollins/sericea-custom-build:v1 .

sudo docker push lukejcollins/sericea-custom-build:v1

#sudo rpm-ostree rebase ostree-unverified-registry:docker.io/lukejcollins/sericea-custom-build:v1

sudo rpm-ostree upgrade
