# Jupyter Notebook Python 3, 2 + NodeJS

Image Base: [jupyter/minimal-notebook](https://hub.docker.com/r/jupyter/minimal-notebook)

Usage:

```bash
$ docker build -t jupyter-notebook-nodejs .
$ docker run --rm --name jupyter -p 8888:8888 -v $(pwd):/home/jovyan/work jupyter-notebook-nodejs
```

or

```bash
$ docker-compose up
```
