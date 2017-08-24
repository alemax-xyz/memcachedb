## Memcachedb docker image
MemcacheDB is a distributed key-value storage system designed for persistent.
It is NOT a cache solution, but a persistent storage engine for fast and reliable key-value based object storage and retrieval.
It conforms to memcache protocol, so any memcached client can have connectivity with it.
MemcacheDB uses Berkeley DB as a storing backend, so lots of features including transaction and replication are supported.

This image is based on official memcached package for Ubuntu Xenial and is built on top of [clover/base](https://hub.docker.com/r/clover/base/).
