FROM dart:stable

RUN apt-get update && \
    apt-get install -y python3 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

EXPOSE 10000

CMD ["python3", "editor/compiler_server.py"]