FROM python:3.6

WORKDIR /app

COPY nf-spike .

ENTRYPOINT ["python", "nf-spike"]
