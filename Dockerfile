FROM fedora:42

RUN dnf makecache
RUN dnf install -y rpm-build rpmdevtools jq
RUN rpmdev-setuptree

WORKDIR /root/rpmbuild/SPECS

COPY cursor.spec cursor.spec
COPY run.sh run.sh

ENTRYPOINT ["bash", "run.sh"]

