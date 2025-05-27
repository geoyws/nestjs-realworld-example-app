PROJECT_NAME=njsrw
BASE_COMPOSE=docker-compose.yml

dev:
	docker-compose -p $(PROJECT_NAME)_dev \
		-f $(BASE_COMPOSE) \
		-f docker-compose.dev.yml \
		up --build
test:
	docker-compose -p $(PROJECT_NAME)_test \
		-f $(BASE_COMPOSE) \
		-f docker-compose.test.yml \
		up --build --abort-on-container-exit
prod:
	docker-compose -p $(PROJECT_NAME)_prod \
		-f $(BASE_COMPOSE) \
		-f docker-compose.prod.yml \
		up --build
ddown:
	docker-compose -p ${PROJECT_NAME}_dev down
tdown:
	docker-compose -p ${PROJECT_NAME}_test down
pdown:
	docker-compose -p ${PROJECT_NAME}_prod down
dlogs: 
	docker-compose -p ${PROJECT_NAME}_dev logs -f
tlogs:
	docker-compose -p ${PROJECT_NAME}_test logs -f
plogs:
	docker-compose -p ${PROJECT_NAME}_prod logs -f
dps:
	docker-compose -p ${PROJECT_NAME}_dev ps
tps:
	docker-compose -p ${PROJECT_NAME}_test ps
pps:
	docker-compose -p ${PROJECT_NAME}_prod ps
