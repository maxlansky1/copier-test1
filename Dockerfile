# ================================================
# 📌 Этап 1. Сборка зависимостей
# Используем slim-образ Python для минимального размера
FROM python:3.11-slim as builder

# Устанавливаем рабочую директорию для сборки зависимостей
WORKDIR /install

# Устанавливаем необходимые системные библиотеки для сборки C-зависимостей
# (Добавляй или убирай зависимости по необходимости)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \         # gcc, g++, make — для сборки C-зависимостей
    libglib2.0-0 \            # Для OpenCV
    libgl1 \                  # Для OpenCV
    libxml2-dev libxslt1-dev \ # Для lxml
    libjpeg-dev zlib1g-dev \  # Для Pillow
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Копируем только requirements.txt на этапе сборки — это позволяет использовать кеш, если deps не изменились
COPY requirements.txt .

# Ставим pip и собираем зависимости в wheel-файлы (архивы Python-библиотек)
RUN pip install --upgrade pip && \
    pip wheel --no-deps --wheel-dir /wheels -r requirements.txt


# ================================================
# 📌 Этап 2. Финальный минимальный образ для запуска приложения
FROM python:3.11-slim

# ✅ Устанавливаем переменные окружения:
ENV PYTHONDONTWRITEBYTECODE=1  # Не создавать .pyc — меньше мусора
    PYTHONUNBUFFERED=1 \         # Логи сразу выводятся
    TZ=Europe/Moscow             # Устанавливаем часовой пояс

# ✅ Рабочая директория приложения
WORKDIR /app

# ✅ Копируем wheel-файлы зависимостей из builder
COPY --from=builder /wheels /wheels
COPY requirements.txt .

# ✅ Устанавливаем зависимости из wheel-файлов — быстро, оффлайн, без компиляции
RUN pip install --no-deps --no-index --find-links=/wheels -r requirements.txt

# ✅ Копируем код приложения
COPY . .

# ✅ Добавляем безопасного пользователя и переходим на него
RUN adduser --disabled-password --gecos "" appuser && \
    chown -R appuser:appuser /app
USER appuser

# ✅ (Опционально) Делаем основной файл исполняемым (если он запускается напрямую)
RUN chmod +x ./src/main.py

# ✅ HEALTHCHECK для мониторинга доступности приложения
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD curl -f http://localhost:8000/health || exit 1

# ✅ Явно прописываем CMD
CMD ["python", "-m", "src.main"]

# ================================================
# 📌 Пример .dockerignore (создай в корне проекта):
# .git
# __pycache__/
# *.pyc
# .env
# .vscode/
# node_modules/
# *.log
# tests/   # если тесты не нужны в образе
