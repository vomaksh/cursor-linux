FROM fedora:42

# RUN echo "fastestmirror=true" | tee -a /etc/dnf/dnf.conf
# RUN echo "max_parallel_downloads=20" | tee -a /etc/dnf/dnf.conf

RUN dnf makecache
RUN dnf install -y rpm-build rpmdevtools jq
RUN rpmdev-setuptree

WORKDIR /root/rpmbuild/SPECS

COPY cursor.spec cursor.spec
COPY run.sh run.sh

ENTRYPOINT ["bash", "run.sh"]

