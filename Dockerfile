FROM jupyter/datascience-notebook:latest
RUN pip install openai
USER root
RUN pip install --upgrade pip  # Ensure pip is up-to-date
RUN pip install --upgrade pyarrow pandas  # Upgrade these
RUN pip install jupyter-app-launcher
RUN pip install --upgrade numexpr bottleneck
RUN mkdir /usr/local/share/omni-engineer
RUN pip install jupyter_ai
RUN pip install jupyter_ai_magics  # Install the magics package
COPY bearborg_ai-0.1.0-py3-none-any.whl /tmp/
RUN pip install -v /tmp/bearborg_ai-0.1.0-py3-none-any.whl
RUN mkdir /usr/local/share/icons
COPY BearBorgIcon.svg /usr/local/share/icons
COPY OmniBorgIcon.svg /usr/local/share/icons
COPY jp_app_launcher.yaml /usr/local/share
COPY omni-engineer /usr/local/share/omni-engineer
RUN pip install -r /usr/local/share/omni-engineer/requirements.txt
ENV JUPYTER_APP_LAUNCHER_PATH="/usr/local/share"

# make sure ipython_config.py is loaded
# Create the IPython profile directory
RUN mkdir -p /home/jovyan/.ipython/profile_default

# Copy the ipython_config.py file
COPY ipython_config.py /home/jovyan/.ipython/profile_default/ipython_config.py

# Set correct ownership (important for permissions)
RUN chown -R jovyan:users /home/jovyan/.ipython

# Optional: Clean up (remove the config file from the build context)
# RUN rm ipython_config.py

WORKDIR /home/jovyan


# Expose the default notebook port
EXPOSE 8888

# Set the default command to start JupyterLab
CMD ["start-notebook.sh"]
