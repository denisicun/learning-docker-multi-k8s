docker build -t denisicun/multi-client:latest -t denisicun/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t denisicun/multi-server:latest -t denisicun/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t denisicun/multi-worker:latest -t denisicun/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push denisicun/multi-client:latest
docker push denisicun/multi-client:$SHA

docker push denisicun/multi-server:latest
docker push denisicun/multi-server:$SHA

docker push denisicun/multi-worker:latest
docker push denisicun/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=denisicun/multi-server:$SHA
kubectl set image deployments/client-deployment server=denisicun/multi-client:$SHA
kubectl set image deployments/worker-deployment server=denisicun/multi-worker:$SHA
