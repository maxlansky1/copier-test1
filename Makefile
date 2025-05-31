# Makefile for Docker-based workflow

# Название Docker Compose файла (если нужно — можно менять)
COMPOSE_FILE=docker-compose.yaml

# 📦 Собрать и запустить контейнеры (в фоновом режиме)
up:
	docker-compose -f $(COMPOSE_FILE) up -d --build

# ⛔ Остановить все контейнеры
down:
	docker-compose -f $(COMPOSE_FILE) down

# 🧹 Полная остановка + удаление томов (данных)
clean:
	docker-compose -f $(COMPOSE_FILE) down -v

# 🔍 Просмотреть логи всех сервисов
logs:
	docker-compose -f $(COMPOSE_FILE) logs -f

# 🛠️ Перезапустить контейнеры (например, после изменений)
restart:
	docker-compose -f $(COMPOSE_FILE) down
	docker-compose -f $(COMPOSE_FILE) up -d --build

# 🧪 Зайти внутрь контейнера (по умолчанию — первый сервис)
# Используй: `make bash SERVICE=имя_сервиса`
bash:
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE) /bin/bash
