# NGTをビルドするためのDockerfile

[NGT](https://github.com/yahoojapan/NGT/blob/main/README-jp.md)は高次元ベクトルデータに対する近似近傍検索のためのコマンドライン、ライブラリーです。

## Dockerイメージを作る
```sh
$ docker build -t ngt .
```

## Dockerコンテナを作る
```sh
$ docker run -it -d --name ngt-example ngt
```

## ngtを起動する
```sh
$ docker exec -it ngt-example ngt
```

あるいはコンテナ内に入って`ngt`を起動する
```sh
$ docker exec -it ngt-example /bin/bash
# ngt
```
