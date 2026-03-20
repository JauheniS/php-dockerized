# 🐘 PHP 8.5 Dockerized Environment 🚀

Welcome to the **php-dockerized** project! 🐳 This project provides a fast and convenient CLI environment for working with **PHP 8.5** and **Composer** on Linux and macOS (including Apple Silicon/M-series chips).

Stop worrying about system-wide PHP installations or version conflicts. ⚡ Switch between versions easily and keep your main server/workstation clean!

---

## ✨ Key Features

- **PHP 8.5-cli** 🐘 (The latest and greatest!)
- **Composer** included 📦
- **PIE (PHP Installer for Extensions)** 🥧
- **Auto-detection for macOS (ARM64)** 🍏 and **Linux (AMD64)** 🐧
- **Pre-installed Extensions**:
    - `gRPC` & `Protobuf` (via PIE) 📡
    - `PDO` & `PDO_MySQL` 🗄️
    - `BCMath`, `GD`, `Sockets`, `MBString`, `Zip` 🛠️
- **Opcache** pre-configured
- Simple **Makefile** for common operations 🏗️

---

## 📋 Prerequisites

Before you begin, ensure you have the following installed:
- [Docker](https://www.docker.com/) 🐳
- [Docker Compose](https://docs.docker.com/compose/) 🐙
- [Make](https://www.gnu.org/software/make/) (for easier command usage) 🛠️

---

## 🚀 Quick Start

Get your environment up and running in seconds:

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/JauheniS/php-dockerized.git
    cd php-dockerized
    ```

2.  **Build and start the container**:
    ```bash
    make run
    ```

3.  **Enter the PHP container**:
    ```bash
    docker exec -it php bash
    ```

---

## 📁 Usage & Project Mounting

By default, the environment is configured to mount a `./projects` directory from your host machine into the container at `/projects`.

1.  Place your PHP projects inside the `./projects` folder in this repository.
2.  Inside the container (`docker exec -it php bash`), your projects will be available in the `/projects` directory.
3.  Run `composer install`, `php artisan`, or any other CLI command directly!

---

## 📦 What's inside the box?

The `Dockerfile` is optimized for a full-featured PHP 8.5 development environment:

- **OS Base**: Debian (via `php:8.5-cli`)
- **Composer**: Latest version
- **PHP Extensions**:
    - `grpc` & `protobuf`
    - `pdo_mysql`, `pdo`
    - `mbstring`
    - `bcmath`
    - `gd`
    - `sockets`
    - `zip`
- **System Dependencies**: Includes `make`, `git`, `curl`, `libssl-dev`, `zlib1g-dev`, `libgrpc-dev`, `protobuf-compiler`, and many more for building extensions.

---

## 🔧 Configuration

PHP configuration can be adjusted by modifying:
- `confd/opcache.ini`: Opcache settings.
- `Dockerfile`: Memory limit and other environment-specific settings.

---
