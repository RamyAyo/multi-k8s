docker build -t ramyayoub/multi-client:latest -t ramyayoub/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ramyayoub/multi-server:latest -t ramyayoub/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ramyayoub/multi-worker:latest -t ramyayoub/multi-worker:$SHA -f ./worker/Dockerfile ./worker
#Build our images
#Now push them to docker hub
docker push ramyayoub/multi-client:latest
docker push ramyayoub/multi-server:latest
docker push ramyayoub/multi-worker:latest
docker push ramyayoub/multi-client:$SHA
docker push ramyayoub/multi-server:$SHA
docker push ramyayoub/multi-worker:$SHA
kubectl apply -f k8s
#apply all config files in the k8s directory

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ramyayoub/multi-server:$SHA
kubectl set image deployments/client-deployment client=ramyayoub/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ramyayoub/multi-worker:$SHA