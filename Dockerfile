FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py train.py test_train.py config.json ./
COPY dataset/ dataset/
ARG GIT_COMMIT=local
ENV GIT_COMMIT=${GIT_COMMIT}
RUN python train.py && pytest -q
EXPOSE 8000
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
