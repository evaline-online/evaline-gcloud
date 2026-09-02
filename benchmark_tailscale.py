#!/usr/bin/env python3
import subprocess
import json
import time
import sys

def run_cmd(cmd):
    try:
        res = subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=90)
        return res.stdout.strip(), res.returncode
    except subprocess.TimeoutExpired:
        return "Timeout", 1

def run_speedtest():
    print("Running speedtest...")
    out, code = run_cmd("python3 speedtest.py --json")
    if code == 0 and out:
        try:
            data = json.loads(out)
            dl_mbps = round(data.get("download", 0) / 1e6, 2)
            ul_mbps = round(data.get("upload", 0) / 1e6, 2)
            ping = round(data.get("ping", 0), 2)
            return {"ping": ping, "download": dl_mbps, "upload": ul_mbps}
        except Exception as e:
            print(f"Error parsing json: {e}")
    return {"ping": 0, "download": 0, "upload": 0}

def main():
    print("=== Tailscale Speed Benchmark Test ===")
    
    # 1. Check direct speed
    print("\n1. Measuring speed WITHOUT Exit Node...")
    run_cmd("sudo tailscale set --exit-node=")
    time.sleep(2)
    direct_res = run_speedtest()
    print(f"Direct Result -> Ping: {direct_res['ping']} ms | Download: {direct_res['download']} Mbps | Upload: {direct_res['upload']} Mbps")

    # 2. Check speed with Exit Node
    print("\n2. Measuring speed WITH evabot-agent-vm Exit Node...")
    out, code = run_cmd("sudo tailscale set --exit-node=100.66.98.4")
    time.sleep(3)
    
    if code != 0:
        print("Could not set exit node (might need approval in Tailscale Admin Console).")
        exit_node_res = {"ping": "N/A", "download": "N/A", "upload": "N/A"}
    else:
        exit_node_res = run_speedtest()
        print(f"Exit Node Result -> Ping: {exit_node_res['ping']} ms | Download: {exit_node_res['download']} Mbps | Upload: {exit_node_res['upload']} Mbps")
        run_cmd("sudo tailscale set --exit-node=")

    print("\n=== Test Summary ===")
    print(f"Without Exit Node: {direct_res}")
    print(f"With Exit Node:    {exit_node_res}")

if __name__ == "__main__":
    main()
