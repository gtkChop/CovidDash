FROM ubuntu:latest
ENV LANG en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get install -y \
    python3 python3-pip git libpq-dev libevent-dev uwsgi-plugin-python3 \
    nginx supervisor 

# Add user dash
RUN useradd -ms /bin/bash dash
ADD ./covidviz /home/covidviz
RUN pip3 install virtualenv

# Set working direcotory and virtual environment
WORKDIR /home/covidviz/
ENV HOME /home/covidviz/
ENV PY_ENV /home/covidviz/covidviz_env
ENV COVID_APP /home/covidviz/covid_dashboard
RUN chown -R dash:dash $HOME
USER dash
RUN python3 -m virtualenv --python=/usr/bin/python3 $PY_ENV
RUN /bin/bash -c "source $PY_ENV/bin/activate"

# Install all necessary packages
RUN $PY_ENV/bin/pip3 install -r $COVID_APP/requirements.txt

RUN $PY_ENV/bin/pip3 install uwsgi

# Install all the app
RUN cd $COVID_APP && $PY_ENV/bin/python3 setup.py develop

# Expose port 8050
EXPOSE 8050

CMD ["/home/covidviz/covidviz_env/bin/uwsgi", "/home/covidviz/uwsgi.ini"]

