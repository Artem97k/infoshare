#!/bin/bash

cd gateway-service

bundle install

cd ..

(cd gateway-service; rails s -p 3000) & (cd auth-service; rails s -p 3001) & (cd profile-service; rails s -p 3002) & (cd article-service; rails s -p 3003) & (cd series-service; rails s -p 3004)
