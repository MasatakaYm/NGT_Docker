# NGTをビルドするためのDockerfile

[NGT](https://github.com/yahoojapan/NGT/blob/main/README-jp.md)は高次元ベクトルデータに対する近似近傍検索のためのコマンドライン、ライブラリーです。

## Dockerで環境構築する

###
Dockerイメージを作る
```sh
$ docker build -t ngt .
```

NGTのバージョンを指定する場合は、
```sh
$ docker build --build-arg NGT_VERSION=2.0.9 -t ngt .
```
とする

### Dockerコンテナを作る
```sh
$ docker run -it -d --name ngt-example ngt
```

### ngtを起動する
```sh
$ docker exec -it ngt-example ngt
```

あるいはコンテナ内に入って`ngt`を起動する
```sh
$ docker exec -it ngt-example /bin/bash
# ngt
```

## NGTで遊んでみる

1. データを登録する。
```sh
# データ(インデックス)を登録 (10次元、5000データ)
$ ngt create -d 10 index-poincare-5k ./data/poincare-input-5k.tsv

# インデックス名と同じディレクトリが作成されて、何かオブジェクトファイルが生成されている
$ ls index-poincare-5
grp  obj  prf  tre

# インデックスの情報を確認する
$ ngt info index-poincare-5k
NGT version: 2.0.9
CPU SIMD types: avx avx2
The number of the objects:	5000
The number of the indexed objects:	5000
The size of the object repository (not the number of the objects):	5000
The number of the removed objects:	0/5000
The number of the nodes:	5000
The number of the edges:	99890
The mean of the edge lengths:	0.3499721909
The mean of the number of the edges per node:	19.978
The number of the nodes without edges:	0
The maximum of the outdegrees:	211
The minimum of the outdegrees:	10
The number of the nodes where indegree is 0:	0
The maximum of the indegrees:	211
The minimum of the indegrees:	10
#-nodes,#-edges,#-no-indegree,avg-edges,avg-dist,max-out,min-out,v-out,max-in,min-in,v-in,med-out,med-in,mode-out,mode-in,c95,c5,o-distance(10),o-skip,i-distance(10),i-skip:5000:99890:0:19.978:0.3499721909:211:10:9.081525478:211:10:9.081525478:15:15:10:10:62.072:10:98.8:10:0.3303691094:0:0.3303691094:0
```

2. データを検索するには`ngt search -n [検索結果数]　[インデックス名] [クエリファイルパス]`を実行する。

```sh
$ ngt search -n 10 index-poincare-5k ./data/poincare-query.tsv
Query No.1
Rank	ID	Distance
1	4861	0
2	1899	0.142611
3	4143	0.146373
4	804	    0.155453
5	2353	0.167493
6	2327	0.169294
7	4345	0.173776
8	3902	0.174144
9	3379	0.174223
10	3339	0.179446
Query Time= 5.8774e-05 (sec), 0.058774 (msec)
Average Query Time= 5.8774e-05 (sec), 0.058774 (msec), (5.8774e-05/1)
```

3. 登録したインデックスを消去するには、(多分)単純に生成されたディレクトリを消せばよい。
```sh
$ rm -r index-poincare-5k
```

# 参考文献
1. [NGT コマンドクイックリファレンス](https://github.com/yahoojapan/NGT/wiki/%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%AF%E3%82%A4%E3%83%83%E3%82%AF%E3%83%AA%E3%83%95%E3%82%A1%E3%83%AC%E3%83%B3%E3%82%B9)
2. [高次元ベクトルデータの近傍検索を「NGT」で試してみる](https://www.na3.jp/entry/20190527/p1)