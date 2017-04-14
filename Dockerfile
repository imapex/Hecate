##
## Dockerfile for Hecate project
##
FROM python:2-alpine
MAINTAINER Steve Luzynski <sluzynsk@cisco.com>
EXPOSE 5000

RUN pip install --no-cache-dir setuptools wheel

ADD ./app /app
WORKDIR /app
RUN pip install --requirement /app/requirements.txt
CMD ["python", "app.py"]
