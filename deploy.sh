docker build -t gushtime/multi-client:latest -t gushtime/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t gushtime/multi-server:latest -t gushtime/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t gushtime/multi-worker:latest -t gushtime/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker
docker push gushtime/multi-client:latest
docker push gushtime/multi-server:latest
docker push gushtime/multi-worker:latest

docker push gushtime/multi-client:$SHA
docker push gushtime/multi-server:$SHA
docker push gushtime/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gushtime/multi-server:$SHA
kubectl set image deployments/client-deployment client=gushtime/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gushtime/multi-worker:$SHA