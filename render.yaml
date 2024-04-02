services:
  - name: clickhouse
    env:
      - key: CLICKHOUSE_CONFIG_FILE
        value: /etc/clickhouse-server/config.xml
      - key: CLICKHOUSE_USERS_FILE
        value: /etc/clickhouse-server/users.xml
    disk: 10
    plan: starter
    instanceType: web
    environment:
      - key: NOFILE_SOFT_LIMIT
        value: '262144'
      - key: NOFILE_HARD_LIMIT
        value: '262144'
    ports:
      - 8123
      - 9000

  - name: clickhouse_older_version
    env:
      - key: CLICKHOUSE_CONFIG_FILE
        value: /etc/clickhouse-server/config.xml
      - key: CLICKHOUSE_USERS_FILE
        value: /etc/clickhouse-server/users.xml
    disk: 10
    plan: starter
    instanceType: web
    environment:
      - key: NOFILE_SOFT_LIMIT
        value: '262144'
      - key: NOFILE_HARD_LIMIT
        value: '262144'
    ports:
      - 8124
      - 9001

  - name: clickhouse_tls
    env:
      - key: CLICKHOUSE_CONFIG_FILE
        value: /etc/clickhouse-server/config.xml
      - key: CLICKHOUSE_USERS_FILE
        value: /etc/clickhouse-server/users.xml
    disk: 10
    plan: starter
    instanceType: web
    environment:
      - key: NOFILE_SOFT_LIMIT
        value: '262144'
      - key: NOFILE_HARD_LIMIT
        value: '262144'
    ports:
      - 8443
      - 9440

  - name: metabase
    image: metabase/metabase:v0.49.0-RC2
    env:
      - key: MB_HTTP_TIMEOUT
        value: '5000'
      - key: JAVA_TIMEZONE
        value: UTC
    disk: 10
    plan: starter
    instanceType: web
    environment:
      - key: MB_HTTP_TIMEOUT
        value: '5000'
      - key: JAVA_TIMEZONE
        value: UTC
    ports:
      - 3000
