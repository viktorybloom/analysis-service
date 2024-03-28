# Start from a core stack version
FROM jupyter/all-spark-notebook:x86_64-ubuntu-22.04
# Install from the requirements.txt file
COPY --chown=${NB_UID}:${NB_GID} ./jupyter/requirements.txt /tmp/
RUN pip install --no-cache-dir --requirement /tmp/requirements.txt && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
