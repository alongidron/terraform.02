# Dockerfile
FROM python:3.9-alpine

WORKDIR /app
COPY . /app

RUN pip install flask psycopg2-binary sqlalchemy

CMD ["python", "app.py", "--host=0.0.0.0"]
