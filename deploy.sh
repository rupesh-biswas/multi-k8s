docker build -t rupeshbiswas/multi-client:latest -t rupeshbiswas/multi-client:$SHA -f ./client/Dockerfile ./client

docker build -t rupeshbiswas/multi-server:latest -t rupeshbiswas/multi-server:$SHA -f ./server/Dockerfile ./server

docker build -t rupeshbiswas/multi-worker:latest -t rupeshbiswas/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rupeshbiswas/multi-client:latest
docker push rupeshbiswas/multi-server:latest
docker push rupeshbiswas/multi-worker:latest

docker push rupeshbiswas/multi-client:$SHA
docker push rupeshbiswas/multi-server:$SHA
docker push rupeshbiswas/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=rupeshbiswas/multi-server:$SHA

kubectl set image deployments/client-deployment client=rupeshbiswas/multi-client:$SHA

kubectl set image deployments/worker-deployment worker=rupeshbiswas/multi-worker:$SHA