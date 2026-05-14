# STM32F4xx HAL Driver Doxygen Documentation

## Build latest master:

```bash
docker build -t doxygen:alpine .
```

Release_1_17_0 

```bash
docker build --build-arg DOXYGEN_REF=Release_1_17_0 -t doxygen:alpine .
```


# 2. Run the build using the shell variable
```bash
docker build --build-arg DOXYGEN_REF=Release_1_17_0 -t ruseler/doxygen:alpine .
```


## Quickstart

```bash
docker compose up --build
```

The generated HTML docs are written to ./docs/html on your host.


```bash
docker compose down -v
```