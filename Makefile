PROJECT_NAME=njsrw
DC=docker-compose
BASE_DC=$(DC).yaml
DEV_DC=$(DC).dev.yaml
TEST_DC=$(DC).test.yaml
PROD_DC=$(DC).prod.yaml

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
