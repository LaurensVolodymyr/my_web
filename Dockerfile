# Используем официальный базовый образ с Python
FROM python:3.9-slim

# Устанавливаем рабочую директорию в контейнере
WORKDIR /app

# Копируем файл зависимостей в контейнер
COPY requirements.txt requirements.txt

# Устанавливаем зависимости
RUN pip install -r requirements.txt

# Копируем остальные файлы приложения в контейнер
COPY . .

# Запускаем приложение
CMD ["python", "app.py"]
