docker build -t ajmason/multi-client:latest -t ajmason/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ajmason/multi-server:latest -t ajmason/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ajmason/multi-worker:latest -t ajmason/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ajmason/multi-client:latest
docker push ajmason/multi-server:latest
docker push ajmason/multi-worker:latest

docker push ajmason/multi-client:$SHA
docker push ajmason/multi-server:$SHA
docker push ajmason/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=ajmason/multi-client:$SHA
kubectl set image deployments/server-deployment server=ajmason/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ajmason/multi-worker:$SHA