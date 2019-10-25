FROM python:3-alpine

WORKDIR /app
COPY . .

RUN pip install --user -r requirements.txt

ENTRYPOINT [ "python", "src/main.py" ]