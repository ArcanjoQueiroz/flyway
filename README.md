# Generic Flyway Docker Container

[![Build Status](https://travis-ci.org/ArcanjoQueiroz/flyway.svg?branch=master)](https://travis-ci.org/ArcanjoQueiroz/flyway)

## Usage

### Running

The following docker-compose.yml example uses **arcanjoqueiroz/flyway:1.0.3** to migrate the SQL files inside the  **migrations** directory:

```yml
version: '3'
services:
  postgres:
    image: postgres:11-alpine
    ports:
      - "5432:5432"
    environment:
      POSTGRES_USER: alexandre
      POSTGRES_PASSWORD: alexandre
    networks:
      - postgres
    volumes:
      - $HOME/docker/postgresql:/var/lib/postgresql
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql

  pgadmin:
    image: fenglc/pgadmin4
    ports:
      - "5050:5050"
    environment:
      DEFAULT_USER: "alexandre@oracle.com"
      DEFAULT_PASSWORD: "alexandre"
    networks:
      - postgres
    links:
      - postgres:postgres
    volumes:
      - $HOME/docker/pgadmin:/root/.pgadmin

  schema:
    image: arcanjoqueiroz/flyway:1.0.3
    command: >
      sh -c "wait-for --type postgres \
      	--host postgres \
      	--port 5432 \
      	--user root \
      	--password root \
      	--name root \
      	--seconds 20 \
      	--maxAttempts 10 && \
        flyway \
          -url=jdbc:postgresql://postgres:5432/root \
          -schemas=root \
          -user=root \
          -defaultSchema=root \
          -password=root migrate"
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
