FROM amazonlinux:latest

LABEL maintainer="tendgine-dev container rebased to amazonlinux for reasons"

RUN set -x \
    && yum -y update \
    && yum -y install amazon-efs-utils make automake gcc git pcre-devel zlib-devel openssl-devel perl perl-devel perl-ExtUtils-Embed libxslt libxslt-devel libxml2 libxml2-devel gd gd-devel GeoIP GeoIP-devel \
    && git clone https://github.com/alibaba/tengine.git \
    && cd tengine \ 
    && ./configure && make && make install \
    && ln -s /usr/local/nginx/sbin/nginx /bin/tengine;


EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["/bin/tengine", "-g", "daemon off;"]
