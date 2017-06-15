FROM scratch
ADD drone-build drone-build
ADD data data
ENV PORT 8000
EXPOSE 8000
ENTRYPOINT ["/drone-build"]
