# Управление трафиком внутри кластера Kubertnetes

[Настройки сетевых политик](non-admin-api-allow.yaml)
 
Запускаем minicube
``` shell
minikube start --vm-driver=docker --cni calico
```

Применяем политики
``` shell
kubectl apply -f non-admin-api-allow.yaml
```

Создаем сервисы
``` shell
kubectl run front-end-app --image=nginx --labels role=front-end --expose --port 80
kubectl run back-end-api-app --image=nginx --labels role=back-end-api --expose --port 80
kubectl run admin-front-end-app --image=nginx --labels role=admin-front-end --expose --port 80
kubectl run admin-back-end-api-app --image=nginx --labels role=admin-back-end-api --expose --port 80
```

Проверяем разрешенный трафик
``` shell
kubectl run test-$RANDOM --namespace=front-end --rm -i -t --image=alpine -- sh
/ # wget -qO- --timeout=2 http://back-end-api

kubectl run test-$RANDOM --namespace=admin-front-end --rm -i -t --image=alpine -- sh
/ # wget -qO- --timeout=2 http://admin-back-end-api
```

Проверяем запрещенный трафик
``` shell
kubectl run test-$RANDOM --namespace=front-end --rm -i -t --image=alpine -- sh
/ # wget -qO- --timeout=2 http://admin-back-end-api

kubectl run test-$RANDOM --namespace=admin-front-end --rm -i -t --image=alpine -- sh
/ # wget -qO- --timeout=2 http://back-end-api
```