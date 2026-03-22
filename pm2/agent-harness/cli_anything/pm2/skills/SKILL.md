---
name: pm2
version: 1.0.0
backend: pm2 (subprocess)
state: stateless
entry_point: cli-anything-pm2
groups:
  - process
  - lifecycle
  - logs
  - system
---

# PM2 Skills

Skills for the PM2 CLI-Anything harness. Add agent skills here as `.py` files.

## Available Command Skills

| Skill           | Group     | Command                                    |
|-----------------|-----------|--------------------------------------------|
| List processes  | process   | `cli-anything-pm2 --json process list`     |
| Describe process| process   | `cli-anything-pm2 --json process describe <name>` |
| Get metrics     | process   | `cli-anything-pm2 --json process metrics`  |
| Start process   | lifecycle | `cli-anything-pm2 lifecycle start <script> --name <name>` |
| Stop process    | lifecycle | `cli-anything-pm2 lifecycle stop <name>`   |
| Restart process | lifecycle | `cli-anything-pm2 lifecycle restart <name>`|
| Delete process  | lifecycle | `cli-anything-pm2 lifecycle delete <name>` |
| View logs       | logs      | `cli-anything-pm2 logs view <name> --lines 50` |
| Flush logs      | logs      | `cli-anything-pm2 logs flush [name]`       |
| Save process list| system   | `cli-anything-pm2 system save`             |
| Startup script  | system    | `cli-anything-pm2 system startup`          |
| PM2 version     | system    | `cli-anything-pm2 --json system version`   |

## Planned Skills

- **auto-restart**: Monitor processes and auto-restart on crash
- **health-check**: Periodic health checks on all PM2 processes
- **log-rotate**: Automated log rotation and cleanup
- **deploy**: Rolling restart with zero-downtime deployment
