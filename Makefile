run: run_db run_server

run_db:
	docker-compose up db -d

run_server:
	mix phx.server

stop:
	docker-compose down
