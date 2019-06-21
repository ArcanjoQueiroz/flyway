# Generic Flyway Docker Container

## How to use

### Running

There is an example below of a docker-compose.yml that uses alexandre/flyway:1.0.2 to migrate the SQL files inside the  **migrations** directory:

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
        command: >
          sh -c "wait-for-postgres --host postgres --port 5432 --user root --password root --database root --seconds 20 --maxAttempts 10 
          && flyway -url=jdbc:postgresql://postgres:5432/root -schemas=root -user=root -password=root migrate"
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

Save the target database JDBC Driver used by Flyway inside the **drivers** directory.

This container uses [wait-for](https://github.com/ArcanjoQueiroz/wait-for) to wait for PostgreSQL database.

### Licensing

[Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0.html)
