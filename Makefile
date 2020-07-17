all:
	make build-docker-node
	make build-docker-router

build-docker-node:
	docker build -f ./hmq/Dockerfile -t fhmqnode:latest ./hmq

build-docker-router:
	docker build -f ./router/Dockerfile -t fhmqrouter:latest ./router

launch-router:
	docker run \
	-p 9888:9888 \
	--name fhmqrouter  \
	-d \
	fhmqrouter:latest

launch-hmq1:
	docker run \
	-p 11883:1883 \
	-p 30001:30001 \
	--name hmq1  \
	-e "ROUTER=fhmq:9888" \
	-e "CLUSTERPORT=30001" \
	--add-host="fhmq:172.21.4.71" \
	-d \
	fhmqnode:latest

launch-hmq2:
	docker run \
	-p 21883:1883 \
	-p 30002:30002 \
	--name hmq2  \
	-e "ROUTER=fhmq:9888" \
	-e "CLUSTERPORT=30002" \
	--add-host="fhmq:172.21.4.71" \
	-d \
	fhmqnode:latest

sub1:
	mosquitto_sub -h localhost -p 11883 -t /test123

pub1:
	mosquitto_pub -h localhost -p 21883 -t /test123  -m "abcdefg"
pub2:
	mosquitto_pub -h localhost -p 21883 -t /test123  -m "abcdefg"
