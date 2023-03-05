# Statically linked procps

> ℹ️ procps container image does not include ncurses based utilities
> such as `top` or `watch`

Statically linked [procps] container image with [Bash]

> 2,6M (1,1M bash)

```bash
ghcr.io/awesome-containers/static-procps:latest
ghcr.io/awesome-containers/static-procps:4.0.3

docker.io/awesomecontainers/static-procps:latest
docker.io/awesomecontainers/static-procps:4.0.3
```

Slim statically linked [procps] container image with [Bash] packaged with [UPX]

> 1,3M (578K bash)

```bash
ghcr.io/awesome-containers/static-procps:latest-slim
ghcr.io/awesome-containers/static-procps:4.0.3-slim

docker.io/awesomecontainers/static-procps:latest-slim
docker.io/awesomecontainers/static-procps:4.0.3-slim
```

[procps]: https://gitlab.com/procps-ng/procps
[Bash]: https://github.com/awesome-containers/static-bash
[UPX]: https://upx.github.io/

<!--
```bash
image="localhost/${PWD##*/}"

podman build -t "$image:latest" .
podman build -t "$image:latest-slim" -f Containerfile-slim \
  --build-arg STATIC_PROCPS_IMAGE="$image" \
  --build-arg STATIC_PROCPS_VERSION=latest --no-cache .

echo "$image:latest"
podman inspect "$image:latest" | jq '.[].Size' | numfmt --to=iec
echo "$image:latest-slim"
podman inspect "$image:latest-slim" | jq '.[].Size' | numfmt --to=iec

```
-->
