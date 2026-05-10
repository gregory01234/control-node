import subprocess
import time
import requests
from kubernetes import client, config

ANSIBLE_PLAYBOOK = "ansible/site.yml"


# =========================
# 1. RUN ANSIBLE
# =========================
def run_ansible():
    print("[1] Running Ansible bootstrap...")
    subprocess.run(["ansible-playbook", ANSIBLE_PLAYBOOK], check=True)


# =========================
# 2. WAIT FOR K3S API
# =========================
def wait_for_k3s():
    print("[2] Waiting for K3s API...")

    while True:
        try:
            r = requests.get("https://localhost:6443/healthz", verify=False, timeout=2)
            if r.status_code == 200:
                print("[OK] K3s is ready")
                break
        except:
            pass

        time.sleep(3)


# =========================
# 3. LOAD K8S CONFIG
# =========================
def load_cluster():
    config.load_kube_config()
    print("[3] K3s config loaded")


# =========================
# 4. DEPLOY OLLAMA INTO CLUSTER
# =========================
def deploy_ollama():
    print("[4] Deploying Ollama into K3s...")

    apps = client.AppsV1Api()

    deployment = client.V1Deployment(
        metadata=client.V1ObjectMeta(name="ollama"),
        spec=client.V1DeploymentSpec(
            replicas=1,
            selector=client.V1LabelSelector(
                match_labels={"app": "ollama"}
            ),
            template=client.V1PodTemplateSpec(
                metadata=client.V1ObjectMeta(labels={"app": "ollama"}),
                spec=client.V1PodSpec(
                    containers=[
                        client.V1Container(
                            name="ollama",
                            image="ollama/ollama",
                            ports=[client.V1ContainerPort(container_port=11434)]
                        )
                    ]
                )
            )
        )
    )

    apps.create_namespaced_deployment(namespace="default", body=deployment)
    print("[OK] Ollama deployed into cluster")


# =========================
# 5. NODE CONTROLLER LOGIC
# =========================
def node_controller_loop():
    print("[5] Node Controller running...")

    v1 = client.CoreV1Api()

    while True:
        pods = v1.list_pod_for_all_namespaces()

        running = len(pods.items)
        print(f"[STATE] Pods in cluster: {running}")

        time.sleep(10)


# =========================
# MAIN FLOW
# =========================
def main():
    run_ansible()
    wait_for_k3s()
    load_cluster()
    deploy_ollama()
    node_controller_loop()


if __name__ == "__main__":
    main()