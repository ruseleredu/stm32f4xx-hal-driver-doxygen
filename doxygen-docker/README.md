
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
