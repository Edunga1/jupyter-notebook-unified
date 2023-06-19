FROM jupyter/minimal-notebook:latest

USER root

# Install language dependencies. for ijavascript: https://github.com/n-riesco/ijavascript
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libssl-dev \
    libzmq3-dev \
    default-jdk

# Clean up apt-get
RUN apt-get clean -y \
    && apt-get autoremove -y \
    && rm -rf /tmp/* /var/tmp/* \
    && rm -rf /var/lib/apt/lists/*

# Switch back to jovyan to avoid accidental container runs as root
# Install ijavascript
USER $NB_UID
ENV NODE_PATH /home/${NB_USER}/node_modules
ENV PATH ${NODE_PATH}/.bin:${PATH}
RUN npm install --prefix /home/$NB_USER ijavascript \
    && ijsinstall

# Install kotlin kernel
RUN conda install -c jetbrains kotlin-jupyter-kernel

WORKDIR $HOME/work
CMD ["start-notebook.sh", "--NotebookApp.token=''"]
