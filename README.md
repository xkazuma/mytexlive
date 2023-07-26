# mytexlive
This repository manages my dockerfile of texlive.

## Requirements:
- Docker (>= version 24.0.4, build 3713ee1)

## Build
You can build this docker settings to execute the below command:
```
docker build -t mytexlive:tl2022 \
    --build-arg UID=$(id -u) \
    --build-arg GID=$(id -g) \
    -t mytexlive:tl2022 .
```

## Usage
You can execute texlive commands by the below docker-run command:
```
docker run --rm \
  -v ${CURRENTDIR}:/workspace \
  -w /workspace \
  --env DISPLAY=${DISPLAY} \
  --env WAYLAND_DISPLAY=${WAYLAND_DISPLAY} \
  --env XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR} \
  mytexlive:tl2022 \
  <TeX Live command>
```

If you'd execute `latexmk`, you execute the following command:

```
docker run --rm \
  -v ${CURRENTDIR}:/workspace \
  -w /workspace \
  --mount type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix \
  --mount type=bind,source=/run/user/$(id -u),target=/run/user/$(id -u) \
  --env DISPLAY=${DISPLAY} \
  --env WAYLAND_DISPLAY=${WAYLAND_DISPLAY} \
  --env XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR} \
  mytexlive:tl2022 \
  latexmk -pvc
```

You use WSL2 (WSLg), then, you add a mount option into above command like this:
```
docker run --rm \
  -v ${CURRENTDIR}:/workspace \
  -w /workspace \
  --mount type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix \
  --mount type=bind,source=/run/user/$(id -u),target=/run/user/$(id -u) \
  --mount type=bind,source=/mnt/wslg,target=/mnt/wslg # added \ 
  --env DISPLAY=${DISPLAY} \
  --env WAYLAND_DISPLAY=${WAYLAND_DISPLAY} \
  --env XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR} \
  mytexlive:tl2022 \
  latexmk -pvc
```
