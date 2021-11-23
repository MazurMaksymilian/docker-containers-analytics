#!/bin/bash

wget https://files.grouplens.org/datasets/movielens/ml-latest.zip -P ./db
unzip ./db/ml-latest.zip -d ./db/
rm ./db/ml-latest.zip