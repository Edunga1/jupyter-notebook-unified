FROM jupyter/minimal-notebook:latest

LABEL author="Maximilian Fellner <max.fellner@gmail.com>"
LABEL maintainer="goonr21@gmail.com"

# Add a Python 2.x environment.
# Ref. https://jupyter-docker-stacks.readthedocs.io/en/latest/using/recipes.html#add-a-python-2-x-environment
RUN conda create --quiet --yes -p $CONDA_DIR/envs/python2 python=2.7 ipython ipykernel kernda && \
    conda clean -tipsy
USER root
RUN $CONDA_DIR/envs/python2/bin/python -m ipykernel install && \
    $CONDA_DIR/envs/python2/bin/kernda -o -y /usr/local/share/jupyter/kernels/python2/kernel.json

# Install ijavascript dependencies. See https://github.com/n-riesco/ijavascript
ENV DEBIAN_FRONTEND noninteractive
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libssl-dev \
    libzmq3-dev \
    && apt-get clean -y \
    && apt-get autoremove -y \
    && rm -rf /tmp/* /var/tmp/* \
    && rm -rf /var/lib/apt/lists/*

# Install nodejs
ENV NODE_VERSION 10.15.3
ENV NODE_PACKAGE node-v$NODE_VERSION-linux-x64
RUN mkdir -p $HOME/.node-gyp
RUN wget -q https://nodejs.org/dist/v${NODE_VERSION}/${NODE_PACKAGE}.tar.xz \
    && tar xf ${NODE_PACKAGE}.tar.xz \
    && cp -R ${NODE_PACKAGE}/bin/* /usr/local/bin \
    && cp -R ${NODE_PACKAGE}/include/* /usr/local/include \
    && cp -R ${NODE_PACKAGE}/lib/* /usr/local/lib \
    && cp -R ${NODE_PACKAGE}/share/* /usr/local/share \
    && rm -r ${NODE_PACKAGE} \
    && rm ${NODE_PACKAGE}.tar.xz

# Switch back to jovyan to avoid accidental container runs as root
# Install ijavascript
USER $NB_UID
ENV NODE_PATH /home/${NB_USER}/node_modules
ENV PATH ${NODE_PATH}/.bin:${PATH}
RUN npm install --prefix /home/$NB_USER ijavascript \
    && ijsinstall

WORKDIR $HOME/work

CMD ["start-notebook.sh", "--NotebookApp.token=''"]
