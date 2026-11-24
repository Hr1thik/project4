FROM python:3.10-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY project4/ /app/
RUN python manage.py migrate --noinput && adduser --disabled-password --gecos "" appuser && chown -R appuser:appuser /app
USER appuser
EXPOSE 8000
CMD ["gunicorn", "project4.wsgi:application", "--bind", "0.0.0.0:8000"]
