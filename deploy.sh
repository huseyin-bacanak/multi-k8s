docker build -t hbdevacc/multi-client:latest -t hbdevacc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hbdevacc/multi-server:latest -t hbdevacc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hbdevacc/multi-worker:latest -t hbdevacc/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hbdevacc/multi-client:latest
docker push hbdevacc/multi-server:latest
docker push hbdevacc/multi-worker:latest

docker push hbdevacc/multi-client:$SHA
docker push hbdevacc/multi-server:$SHA
docker push hbdevacc/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hbdevacc/multi-server:$SHA
kubectl set image deployments/client-deployment client=hbdevacc/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hbdevacc/multi-worker:$SHA

