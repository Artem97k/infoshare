#!/bin/bash

cd gateway-service

bundle install

cd ..

(cd gateway-service; rake db:migrate) & (cd auth-service; rake db:migrate) & (cd profile-service; rake db:migrate) & (cd article-service; rake db:migrate) & (cd series-service; rake db:migrate)

(cd gateway-service; rails s -p 3000) & (cd auth-service; rails s -p 3001) & (cd profile-service; rails s -p 3002) & (cd article-service; rails s -p 3003) & (cd series-service; rails s -p 3004)
