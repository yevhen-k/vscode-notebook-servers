ARG BASE_IMG=<base>
FROM $BASE_IMG

USER root

RUN pip3 install jupyterlab notebook ipykernel

USER $NB_UID

RUN jupyter lab --generate-config

EXPOSE 8888

CMD [ "sh", "-c", "\
    cd $HOME && \
    jupyter lab \
    --notebook-dir=$HOME \
    --ip=0.0.0.0 \
    --no-browser \
    --allow-root \
    --port=8888 \
    --ServerApp.token=\"\" \
    --ServerApp.password=\"\" \
    --ServerApp.allow_origin=\"*\" \
    --ServerApp.base_url=$NB_PREFIX \
    --ServerApp.authenticate_prometheus=False" ]

