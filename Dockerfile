FROM alpine:latest

RUN \
  mkdir /monyog && \
  cd /monyog && \
  wget http://downloadfiles.idera.com/products/IderaSQLDiagnosticManagerForMySQL-Linux-x64-tar.zip && \
  unzip IderaSQLDiagnosticManagerForMySQL-Linux-x64-tar.zip && \
  tar xvzf IderaSQLdmforMySQL-8.8.0-0.x86_64.tar.gz

ADD wrapper.sh /monyog/
RUN chmod +x /monyog/wrapper.sh

EXPOSE 5555

CMD ["/monyog/wrapper.sh", "/monyog/MONyog/bin/MONyog start"]

