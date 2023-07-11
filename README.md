helm install traefik traefik/traefik --values traefik-values.yaml
helm uninstall traefik

$~/work/traefik/v2$ kubectl get svc
NAME                      TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)                      AGE
kubernetes                ClusterIP      10.152.183.1     <none>           443/TCP                      14h
org-oucala-back-service   ClusterIP      10.152.183.146   <none>           8080/TCP                     14h
org-oucala-app-service    ClusterIP      10.152.183.247   <none>           3000/TCP                     14h
traefik                   LoadBalancer   10.152.183.81    192.168.240.10   80:30537/TCP,443:31897/TCP   44s

$~/work/traefik/v2$ kubectl get pods
NAME                                                              READY   STATUS    RESTARTS       AGE
storage-nfs-cyu-nfs-subdir-external-provisioner-5df655bfd6m9rwp   1/1     Running   1 (159m ago)   172m
org-oucala-back-deployment-6675cf94c5-4b5rg                       1/1     Running   3 (159m ago)   14h
org-oucala-app-deployment-696fd79bb5-vvtbv                        1/1     Running   3 (159m ago)   14h
org-oucala-db-deployment-7866799775-h2r4n                         1/1     Running   3 (159m ago)   14h
traefik-56fbf54fb7-2l86d                                          1/1     Running   0              86s

kubectl apply -f oucala.yaml
helm upgrade --install traefik traefik/traefik --values traefik-values.yaml
kubectl apply -f pvc-db.yaml
