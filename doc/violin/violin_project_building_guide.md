## local env build

### 1. mongodb build

#### 1.1 start a mongo server.

    cd "E:\Program Files\mongodb\bin"
    .\mongod --dbpath "E:\Program Files\mongodb\data\db"

#### 1.2 open another terminal to connect server.

    cd "E:\Program Files\mongodb\bin"
    .\mongo mongodb://localhost:27017/

#### 1.3 create database violin and collection in the commond line.

    use violin
    db.t_tenant.insert({
      "tenantId": ""
      "account": ""
      "tel": ""
      "authority": 2
      "avatarUrl": ""
      "storageAccount": ""
      "wikiName": ""
    })
 
### 2. redis build

  as a cache database, we use it to save token.
  we use docker to run a redis server.

#### 2.1 run a redis server

    // use redis-cli
    docker run -it --name violin-redis redis /bin/sh

#### 2.2 connect to redis server 

    docker exec -it containerId /bin/sh
    cd /usr/local/bin/
    redis-cli

#### 2.3 security settings on the command line

    // set auth password
    config get requirepass
    config set requirepass 123456
    
    // 验证密码是否正确
    auth 123456

    // 切换到指定的数据库
    select 3 

### 3. mysql build

  related database, we use docker to run a mysql server.

#### 3.1 run a mysql server.

    docker run --name violin-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 -d mysql:latest

#### 3.2 enter the mysql env.

    docker exec -it violin-mysql bash

#### 3.3 connect mysql server on a commond line.

    mysql -u root -p
    123456
    create database violin;

### 4. run violin-auth/violin-bookmark/violin-wiki/violin-cloud/violin-onenote

  violin-xxx project depend on violin-common module.
  to add violin-common module into violin-xxx project

#### 4.1 edit project application.yml
    
    change [active: prod] -> [active: dev]

#### 4.2 run ViolinXXXApplication

