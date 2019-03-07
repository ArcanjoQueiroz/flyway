# Generic Flyway Docker Container

## How to use

### Running

Below there is an example of docker-compose.yml that uses alexandre/flyway:1.0.1 to migrate the SQL files from the directory named migrations:

```yml
version: '2'
services:
    postgres:
        image: postgres
        restart: unless-stopped
        ports:
          - "5432:5432"
        environment:
            POSTGRES_USER: alexandre
            POSTGRES_PASSWORD: alexandre
        networks:
          - postgres
        volumes:
          - $HOME/postgresql:/var/lib/postgresql
          - ./init.sql:/docker-entrypoint-initdb.d/init.sql

    pgadmin:
        image: fenglc/pgadmin4
        restart: unless-stopped
        ports:
          - "5050:5050"
        environment:
            DEFAULT_USER: "alexandre.queiroz@live.com"
            DEFAULT_PASSWORD: "alexandre"
        networks:
          - postgres
        links:
          - postgres:postgres
        volumes:
          - $HOME/pgadmin:/root/.pgadmin

    schema:
        image: arcanjoqueiroz/flyway:1.0.2
        entrypoint: wait-for-postgres --host postgres --port 5432 --user alexandre --password alexandre --database alexandre --seconds 20 --maxAttempts 5
        command: flyway -url=jdbc:postgresql://postgres:5432/alexandre -schemas=alexandre -user=alexandre -password=alexandre migrate
        volumes:
          - ./migrations:/flyway/sql
          - ./drivers:/flyway/drivers
        depends_on:
          - postgres
        networks:
          - postgres

networks:
    postgres:
        driver: bridge

```

You have to mount a directory with a database compatible JDBC Driver into /flyway/drivers.

This container uses [wait-for](https://github.com/ArcanjoQueiroz/wait-for) to wait for PostgreSQL database.

### License

Apache 2
