PROJECT_NAME=njsrw
BASE_DC=docker-compose.yaml
DEV_DC=docker-compose.dev.yaml
TEST_DC=docker-compose.test.yaml
PROD_DC=docker-compose.prod.yaml

dev:
	docker-compose -p $(PROJECT_NAME)_dev \
		-f $(BASE_DC) \
		-f $(DEV_DC) \
		up --build
test:
	docker-compose -p $(PROJECT_NAME)_test \
		-f $(BASE_DC) \
		-f ${TEST_DC) \
		up --build --abort-on-container-exit
prod:
	docker-compose -p $(PROJECT_NAME)_prod \
		-f $(BASE_DC) \
		-f $(PROD_DC) \
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

