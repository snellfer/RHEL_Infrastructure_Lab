# RHEL_Infrastructure_Lab
This is a high-availability Enterprise Linux Lab built on AlmaLinux nodes, fully automated via Ansible.  The environment features a 6-node architecture: a Control Node for orchestration, a Load Balancer distributing traffic to redundant Web Servers, a centralized NFS Storage/DB node for data persistence, and a dedicated Monitor Node running Prometheus and Grafana for real-time observability.  Every component, from package installation, user management, firewall hardening and persistent mounts is handled via Idempotent Playbooks; demonstrating a Security-First, Infrastructure-as-Code (IaC) workflow.


                       
                       
                       [       control_node       ]
                       +--------------------------+



                       |   Ansible Control Node   |
                       |    AlmaLinux 9 (Host)    |
                       +------------+-------------+



                                    |
                                    | (SSH / Ansible Automation)
                                    v
+---------------------------------------------------------------------------------+



|                                 VIRTUAL NETWORK                                 |
|                                                                                 |
|  +--------------------+   +--------------------+   +--------------------+       |
|  |        web1        |   |        web2        |   |       web_lb       |       |
|  | AlmaLinux 9 Target |   | AlmaLinux 9 Target |   | AlmaLinux 9 Target |       |
|  |  - Nginx Web Server|   |  - Nginx Web Server|   |  - Traffic Routing |       |
|  |  - Rsyslog Client  |   |  - Rsyslog Client  |   |  - Rsyslog Client  |       |
|  +--------+-----------+   +--------+-----------+   +---------+----------+       |
|           |                        |                         |                  |
|           | (NFS Mount)            | (NFS Mount)             | (Rsyslog Stream) |
|           +-----------+    +-------+                         |                  |
|                       |    |                                 |                  |
|                       v    v                                 v                  |
|                 +---------------------------------------------------+           |
|                 |                        db                         |           |
|                 |                AlmaLinux 9 Target                 |           |
|                 |   - Shared Storage Volume                         |           |
|                 |   - Central Rsyslog Server                        |           |
|                 +-------------------------+-------------------------+           |
|                                           |                                     |
|                                           | (Prometheus Scraping)               |
|                                           v                                     |
|                                 +--------------------+                          |
|                                 |      monitor       |                          |
|                                 | AlmaLinux 9 Target |                          |
|                                 |  - Prometheus      |                          |
|                                 |    (Port 9090)     |                          |
|                                 |  - Grafana Engine  |                          |
|                                 |    (Port 3000 View)|                          |
|                                 +--------------------+                          |
+---------------------------------------------------------------------------------+
