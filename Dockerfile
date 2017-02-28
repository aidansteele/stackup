# escape=`
FROM microsoft/windowsservercore
SHELL ["powershell", "-Command"]

RUN Set-ExecutionPolicy -ExecutionPolicy Bypass
ENV chocolateyUseWindowsCompression false
RUN iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
RUN choco feature enable -n allowEmptyChecksums

RUN choco install -y -r ruby
RUN iwr https://curl.haxx.se/ca/cacert.pem -OutFile C:\\cacert.pem
RUN [Environment]::SetEnvironmentVariable(\"SSL_CERT_FILE\", \"C:\\cacert.pem\", \"Machine\")
RUN gem install --no-doc stackup -v 1.1.1

ENTRYPOINT ["stackup"]
