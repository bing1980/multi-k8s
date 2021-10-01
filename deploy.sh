docker build -t johnywind2015/multi-client:latest -t johnywind2015/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t johnywind2015/multi-server:latest -t johnywind2015/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t johnywind2015/multi-worker:latest -t johnywind2015/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push johnywind2015/multi-client:latest
docker push johnywind2015/multi-server:latest
docker push johnywind2015/multi-worker:latest

docker push johnywind2015/multi-client:$SHA
docker push johnywind2015/multi-server:$SHA
docker push johnywind2015/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=johnywind2015/multi-server:$SHA
kubectl set image deployments/client-deployment server=johnywind2015/multi-client:$SHA
kubectl set image deployments/worker-deployment server=johnywind2015/multi-worker:$SHA
