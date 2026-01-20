# Imprint Rescue ISO (KDE Edition)

This repository contains the build scripts and configuration used to create the **Imprint Rescue ISO** — a lightweight, KDE‑based live environment designed for safe, reliable offline backup and restore operations using **Imprint**.

The ISO provides a clean, modern environment with excellent hardware support (including USB4/Thunderbolt enclosures, NVMe bridges, and newer chipsets), making it ideal for full‑system imaging and recovery.

---

## What Is Imprint?

Imprint is a modern, Linux‑native front-end for partclone that can be used from inside your operating system.
It provides a clean, safe, and fast way to back up and restore partitions using partclone, with strong integrity guarantees and a simple Zenity‑based UI.

**Main project:**  
https://github.com/jalongx/imprint

The rescue ISO in this repository is simply a convenient way to run Imprint on any machine — even when the main OS cannot boot or when system partitions must remain unmounted.

---

## Features of the Rescue ISO

- **KDE Plasma desktop:** Lightweight, focused configuration  
- **Arch Linux base:** Excellent hardware and driver support  
- **Imprint preinstalled:** Ready to run out of the box  
- **Network support:** Wired and wireless networking  
- **Maintenance tools:** Useful CLI and GUI utilities for troubleshooting  
- **Recovery‑focused environment:** Clean, minimal, and purpose‑built for imaging tasks  

---

## Booting the Rescue ISO

The Imprint Rescue ISO is not Secure Boot–signed. Boot behavior depends on how you launch it:

### Recommended: Ventoy - https://www.ventoy.net

Imprint boots reliably on Secure Boot systems when launched through Ventoy.

- Boot Ventoy
- Enroll Ventoy’s MOK when prompted
- Copy the Imprint ISO to the flashdrive data partition
- Select the Imprint ISO after ventoy has booted

After the MOK is enrolled once, Secure Boot can remain enabled.

### Direct ISO Boot

Booting an ISO that has been burned directly to a flashdrive will usually fail with Secure Boot enabled.
To boot directly, you must either:

- Disable Secure Boot, or
- Manually sign the kernel/initrd and enroll your own MOK

Ventoy is the simplest and supported method.

---

<img width="1920" height="1080" alt="imprint_iso_kde-desktop" src="https://github.com/user-attachments/assets/c4ca652f-6eeb-4834-91c4-74ef7cb33d4b" />

---

## Building the ISO

The ISO is fully open‑source and reproducible.  
You can build it yourself using the included scripts.

### Requirements

- Arch Linux or an Arch‑based environment  
- `archiso` package installed  
- Sufficient disk space (approx. 3–4 GB)

### Build Steps

```bash
git clone https://github.com/jalongx/imprint_iso_kde
cd imprint_iso_kde
sudo mkarchiso -v -w work -o out .
```

The finished ISO will appear in the out/ directory.

### Notes

- Building must be done as root (required by mkarchiso)
- The build process may take several minutes depending on hardware
- The ISO includes the latest version of Imprint available at build time

---

## Related Repositories

- Imprint (main project):  
    https://github.com/jalongx/imprint
- Imprint Rescue ISO (this repo):  
    https://github.com/jalongx/imprint_iso_kde
