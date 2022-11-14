# this project is kubernetes devops files collection
I view a list that in the cluster

## node
- master
- node1 
- node2 

## network policy
- flannel 
  type "vxlan"

## cluster database
- etcd 

## cicd
- jenkins
  ユーザID: Berserker
  名前: XiangWeiGuan
  パスワード: 別管理

## ingress install

    1. kubectl apply -f configMap.yaml 
      to create userspace
      to create serviceaccount/role/clusterrole/clusterrolebinding for ingress-controler
    2. kubectl apply -f ingress-webhook.yaml
      to create ingress-webhook
      to create serviceaccount/role/clusterrole/clusterrolebinding for webhook
    3. kubectl apply -f ingress-controller.yaml
      to create controller
      to create service
      to create ingressclass 

## to view log detail

to add parameter -Dorg.jenkinsci.plugins.durabletask.BourneShellScript.LAUNCH_DIAGNOSTICS=true in JAVA_OPTS

## gitops => argocd

    kubectl create namespace argocd
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d|xargs -n1 echo

