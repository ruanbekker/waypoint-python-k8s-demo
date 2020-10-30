FROM python:3.7-alpine

RUN pip install flask
ADD src/main.py /code/main.py
WORKDIR /code

CMD ["python", "/code/main.py"]
