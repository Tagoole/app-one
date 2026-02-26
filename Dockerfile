FROM python:3.13-slim AS builder

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 

COPY requirements.txt /app/

RUN pip install --upgrade pip && \
    pip install --no-cache-dir --prefix=/install -r requirements.txt

COPY . /app/

FROM python:3.13-slim

RUN useradd -m -r appuser && mkdir /app && chown -R appuser /app

WORKDIR /app

COPY --from=builder /install /usr/local

COPY --chown=appuser:appuser . .

RUN chmod +x /app/entrypoint.sh

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 


USER appuser

EXPOSE 8000

CMD ["/app/entrypoint.sh"]