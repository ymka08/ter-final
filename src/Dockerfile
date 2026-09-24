FROM python:3.12-slim AS builder

WORKDIR /app

RUN pip install --no-cache-dir --prefix=/install flask mysql-connector-python

COPY final_app.py .


FROM python:3.12-slim

WORKDIR /app

COPY --from=builder /install /usr/local
COPY --from=builder /app/final_app.py .

EXPOSE 80

CMD ["python", "final_app.py"]
