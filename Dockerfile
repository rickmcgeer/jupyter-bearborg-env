FROM jupyter/datascience-notebook:latest
RUN pip install openai
# Copy the .whl and .tar.gz files into the Docker image
# COPY bearborg_extension-0.1.0-py3-none-any.whl /tmp/
# COPY bearborg_extension-0.1.0.tar.gz /tmp/

# Install the JupyterLab extension using pip
# RUN pip install -v /tmp/bearborg_extension-0.1.0-py3-none-any.whl
USER root
RUN pip install jupyter-app-launcher 
RUN mkdir /usr/local/share/omni-engineer
COPY jp_app_launcher.yaml /usr/local/share
COPY omni-engineer /usr/local/share/omni-engineer
RUN pip install -r /usr/local/share/omni-engineer/requirements.txt
ENV JUPYTER_APP_LAUNCHER_PATH="/usr/local/share"
WORKDIR /home/jovyan

# Expose the default notebook port
EXPOSE 8888

# Set the default command to start JupyterLab
CMD ["start-notebook.sh"]
