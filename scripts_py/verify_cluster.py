import subprocess

targets = [
    ["kubectl", "get", "pods", "-n", "control-system"],
    ["kubectl", "get", "svc", "-n", "control-system"],
    ["kubectl", "get", "pvc", "-n", "control-system"],
]

print("\n=== CONTROL PLANE HEALTH REPORT ===\n")

for cmd in targets:
    print(f"\n>>> {' '.join(cmd)}")
    out = subprocess.run(cmd, capture_output=True, text=True)
    print(out.stdout)
