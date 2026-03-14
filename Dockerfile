FROM python:3.12-slim

ENV INFLUX_HOST="localhost" \
    INFLUX_PORT=8086 \
    INFLUX_USER="" \
    INFLUX_PASS="" \
    INFLUX_DB="modem-test" \
    SLEEP_TIMER=30 \
    MODEM_HOST=192.168.100.1 \
    MODEM_USER=admin \
    MODEM_PASS=password \
    LOG_LOCATION="/logs" \
    LOG_LEVEL=INFO

WORKDIR /app

RUN apt update && apt upgrade -y \
  && apt clean \ 
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /logs

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY mb8600/ mb8600/

COPY data_export.py reboot.py get_data.py ./

CMD ["python3", "data_export.py"]
