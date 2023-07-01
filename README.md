# Pxblog

Blog web application on Elixir and Phoenix

From https://medium.com/@diamondgfx/introduction-fe138ac6079d

Translate to russian:
1. https://habr.com/ru/articles/311088/
2. https://habr.com/ru/articles/313482/
3. https://habr.com/ru/articles/315252/
4. https://habr.com/ru/articles/316368/
5. https://habr.com/ru/articles/316996/
6. https://habr.com/ru/articles/317550/
7. https://habr.com/ru/articles/318790/
8. https://habr.com/ru/articles/323462/
9. https://habr.com/ru/articles/332094/
10. https://habr.com/ru/articles/333020/
11. https://habr.com/ru/articles/335048/

## Start database
    $ docker-compose up db

## First configure
Configure your database in `config/dev.exs` and run:

    $ mix setup 

to install and setup dependencies

## Start Phoenix
    $ mix phx.server

or inside IEx with

    $ iex -S mix phx.server

## Make scripts
- Run database and server `$ make run`
- Stop database container `$ make stop`

Now you can visit [`localhost:10000`](http://localhost:10000) from your browser.
