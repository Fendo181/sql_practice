-- 実行するたびにまっさらな状態にする
drop database if exists myapp;

-- databaseを作成する
create database myapp;

grant all on myapp. * to myapp_user@localhost identified by '****'

