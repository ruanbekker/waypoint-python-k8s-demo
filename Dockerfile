FROM python:3.7-alpine

RUN pip install fastapi uvicorn
ADD src/main.py /app/main.py
WORKDIR /app

CMD ["uvicorn", "--host", "0.0.0.0", "--port", "5000", "main:app"]
