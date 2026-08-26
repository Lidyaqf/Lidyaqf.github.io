---
title: redis
date: 2025-04-16 11:58:45
tags:
---
## 目录

[redis-token缓存](#redis-token缓存)
[jwt跟redis存token的区别](#jwt跟redis存token的区别)  
[redis相关知识](#redis相关知识)  
[推荐](#推荐)


## redis-token缓存

* redis.js创建

  ```node
  const redis = require("redis");
  
  // Redis 链接的配置内容
  const client = redis.createClient({
    socket: {
      host: '192.168.64.2',  // Redis 服务器地址
      port: 6379,             // Redis 端口
    },
    password: '123456'        // Redis 密码
  });
  
  // 连接到 Redis
  client.connect()
    .then(() => {
      console.log('Connected to Redis');
    })
    .catch((err) => {
      console.error('Redis connection failed:', err);
    });
  
  // 处理连接错误
  client.on("error", (err) => {
    console.error('Redis error:', err);
  });
  
  // 定义 Redis 操作方法
  const redisOps = {
    // 创建值
    set: async (key, value, expiration = null) => {
      try {
        value = JSON.stringify(value);
        if (Number.isInteger(expiration) && expiration > 0) {
          // 如果设置了有效时间并且是整数，使用 SETEX 命令
          await client.setEx(key, expiration, value);
        } else {
          // 否则直接使用 SET 命令
          await client.set(key, value);
        }
        console.log(`Key "${key}" set successfully with expiration: ${expiration || 'no expiration'}`);
      } catch (err) {
        console.error('Error setting value:', err);
      }
    },
  
    // 删除值
    del: async (key) => {
      try {
        await client.del(key);
        console.log(`Key "${key}" deleted successfully`);
      } catch (err) {
        console.error('Error deleting key:', err);
      }
    },
  
    // 获取值
    get: async (key) => {
      const result = await client.get(key);
      console.log('99999=', result)
      try {
        return result; // 尝试解析为 JSON
      } catch (error) {
        // 如果不是 JSON 格式，直接返回原始值
        console.warn(`Warning: Value for key "${key}" is not JSON formatted.`);
        return result;
      }
    },
  
    // 获取键的 TTL
    ttl: async (key) => {
      try {
        const timeLeft = await client.ttl(key);
        console.log(`Key "${key}" has TTL: ${timeLeft}`);
        return timeLeft;
      } catch (err) {
        console.error('Error getting TTL:', err);
        return err;
      }
    },
  };
  
  module.exports = redisOps;
  
  ```

  

* redis的使用

```node
const redisOps = require("./redis.js");
const moment = require('moment-timezone');

let token = jwt.sign({ id: user.userid, username: user.username }, secretKey, { expiresIn: '1h' });

await redisOps.set(user.userid.toString(), token, 60 * 60)
```

```node
//token校验
const verifyToken = async (ctx, next) => {
    const userid = ctx.headers['cookie'];
    const match = userid.match(/userid=(\d+)/);
    const userId = match ? match[1] : null;
    
    if (!userId) {
        ctx.status = 401;
        console.log('No token provided');
        ctx.body = { message: 'No token provided' };
        return;
    }

    try {
        const startTime = moment(); // 记录开始时间
        const getuserid = await redisOps.get(userId)
        const endTime = moment(); // 记录结束时间
        const duration = moment.duration(endTime.diff(startTime)); // 计算持续时间
      
        console.log(`Request completed in ${duration.asMilliseconds()} ms`); // 以毫秒为单位输出耗时
        if(getuserid){
            await next();
        }else {
            throw err;
        }
       
    } catch (err) {
        console.log('Token verification failed:', err.message);
        ctx.status = 401;
        ctx.body = { message: 'Failed to authenticate token' };
    }
};
```



## jwt跟redis存token的区别

| 维度 | **JWT**                                                      | **Redis**                                                    |
| ---- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 性能 | \- 无需查询数据库或访问外部存储，验证速度较快<br/>\- 适用于简单的身份验证场景 | \- 需要与 Redis 服务器进行通信，可能会有网络延迟<br/>\- 适用于复杂的会话管理和存储需求 |



## redis相关知识

* redis本质上是一个key-value类型的内存数据库，性能最快的key-value数据库。

* 正常情况是把数据存储在数据库 ，数据库把数据存在磁盘。但越上层的存储器存储效率越高，内存位于磁盘之上。而redis是一款基于内存的存储系统，数据都存在内存里，所以从redis读取数据会比从数据库读取要快。

* 内存有限，存储不了太多数据。出现故障时，用主从复制、哨兵法。集群就是一套完整的redis多机解决方案。他有效解决了单机redis的所有问题。当你在集群中为某个节点配置从机的时候，主从节点间同步就是主从复制。主节点挂掉之后，从节点的选取，内部逻辑与哨兵机制相似。

* 支持发布/订阅模式，可以作为一个简单而高效的轻量级消息代理，用于实现消息队列、实时通知等。

  
## 推荐

- [娱乐一下](https://edunextgen1.com)