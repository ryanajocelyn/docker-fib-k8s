docker build -t abijeethdarwin/docker-fib-client:latest -t abijeethdarwin/docker-fib-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t abijeethdarwin/docker-fib-server:latest -t abijeethdarwin/docker-fib-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t abijeethdarwin/docker-fib-worker:latest -t abijeethdarwin/docker-fib-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push abijeethdarwin/docker-fib-client:latest
docker push abijeethdarwin/docker-fib-server:latest
docker push abijeethdarwin/docker-fib-worker:latest

docker push abijeethdarwin/docker-fib-client:$SHA
docker push abijeethdarwin/docker-fib-server:$SHA
docker push abijeethdarwin/docker-fib-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=abijeethdarwin/docker-fib-client:$SHA
kubectl set image deployments/server-deployment server=abijeethdarwin/docker-fib-server:$SHA
kubectl set image deployments/worker-deployment worker=abijeethdarwin/docker-fib-worker:$SHA
