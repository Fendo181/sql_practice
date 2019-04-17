-- 実行するたびにまっさらな状態にする
drop database if exists myapp;

-- databaseを作成する
create database myapp;

-- myapp_userにmyappDBを操作する全権限を与える

grant all on myapp. * to myapp_user@localhost identified by '****'

