v2 Concepts
===========


1. src/product_module - elixir + maru demo
2. src/cart_module - python + django+drf demo
3. src/order_module - ruby + grape demo

### Install

1. brew install elixir : elixir: stable 1.5.1 (bottled), HEAD (erlang18)


### Make

```
make build-product-module
```



### Elixir

```
ab -n 10000 -c 100  http://127.0.0.1:8880/

Server Software:        Cowboy
Server Hostname:        127.0.0.1
Server Port:            8880

Document Path:          /
Document Length:        17 bytes

Concurrency Level:      100
Time taken for tests:   0.856 seconds
Complete requests:      10000
Failed requests:        0
Total transferred:      2080000 bytes
HTML transferred:       170000 bytes
Requests per second:    11681.83 [#/sec] (mean)
Time per request:       8.560 [ms] (mean)
Time per request:       0.086 [ms] (mean, across all concurrent requests)
Transfer rate:          2372.87 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        1    4   0.5      4       6
Processing:     1    4   0.5      4       7
Waiting:        1    4   0.5      4       6
Total:          4    8   0.8      8      11

Percentage of the requests served within a certain time (ms)
  50%      8
  66%      9
  75%      9
  80%      9
  90%     10
  95%     10
  98%     10
  99%     11
 100%     11 (longest request)
```
