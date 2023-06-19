# Jupyter Notebook Python 3 + NodeJS + Kotlin

Image Base: [jupyter/minimal-notebook](https://hub.docker.com/r/jupyter/minimal-notebook)

Usage:

```bash
$ docker build -t jupyter-notebook .
$ docker run --rm --name jupyter -p 8888:8888 -v $(pwd):/home/jovyan/work jupyter-notebook
```

or

```bash
$ docker-compose up
```

# References

* javascript notebook: https://github.com/n-riesco/ijavascript
* kotlin notebook: https://github.com/Kotlin/kotlin-jupyter
