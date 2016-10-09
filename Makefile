.PHONY: mysql

CONTAINER_NAME=disposable-db
LOCAL_DATA_STORE=./.data

intro:
	@echo "    ___  _                        __   __    ___  ___  "
	@echo "   / _ \(_)__ ___  ___  ___ ___ _/ /  / /__ / _ \/ _ ) "
	@echo "  / // / (_-</ _ \/ _ \(_-</ _ \`/ _ \/ / -_) // / _  |"
	@echo " /____/_/___/ .__/\___/___/\_,_/_.__/_/\__/____/____/  "
	@echo "           /_/                                         "
	@echo "                   Make SQL Cool Again                 "
	@echo "                                                       "
	@printf "\r\t                 ( •_•)                          "
	@sleep .33
	@printf "\r\t                 ( •_•)>⌐■-■                     "
	@sleep .33
	@printf "\r\t                 ( •_⌐■-■                        "
	@sleep .33
	@printf "\r\t                 (⌐■_■)                          "
	@sleep .5
	@printf "\r\t                 (⌐■_■)                        \n"
	@sleep .5
	@echo " "
	
	@make help

help:
	@echo "Available Commands:"
	@echo "-------------------"
	@echo "  clean"
	@echo "    remove local data stored by mysql. Note: this will remove any data inside your container"
	@echo "  install"
	@echo "    remove any existing containers and data and rebuild"
	@echo "  mysql"
	@echo "    attach to the mysql prompt of the running container"
	@echo "  rebuild"
	@echo "    remove existing data and rebuild the container"
	@echo "  reset"
	@echo "    remove existing data and delete the container"
	@echo "  run"
	@echo "    bring the database container up in the foreground"
	@echo "  start"
	@echo "    start the database container in the background"
	@echo " "

clean:
	-rm -rf $(LOCAL_DATA_STORE)

install: reset run

mysql:
	docker exec -i -t $(CONTAINER_NAME) mysql -uroot -p1234 -v dd

rebuild: clean run

reset: clean
	-docker rm $(CONTAINER_NAME)

restart: clean start
	@echo "It may be a few seconds before you're able to conncet to the database"

run:
	docker-compose up --build

start:
	docker-compose up --build -d
