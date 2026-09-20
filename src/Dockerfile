FROM python:3.12-slim

WORKDIR /app

RUN pip install flask mysql-connector-python

COPY final_app.py .

CMD ["python", "final_app.py"]
