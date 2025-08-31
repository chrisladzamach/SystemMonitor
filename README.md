# System Monitor Script (PowerShell)

## English

This project is a **System Monitoring Script** written in **PowerShell** (`.ps1`).  
It collects key information about the system and exports it into **CSV and HTML reports** for analysis.

### Features
- CPU usage monitoring.
- RAM usage (total, used, free, and percentage).
- Disk usage (per drive: used, free, total, percentage).
- Top 5 processes by CPU consumption.
- Export results to:
  - **CSV** (for data analysis).
  - **HTML** (for easy visualization).

### How to use
1. Clone or download this repository.  
2. Open PowerShell and navigate to the project folder.  
3. Run the script:  
   ```powershell
   .\SystemMonitor.ps1
   ```
4. Reports will be saved in the `Reports` folder with a timestamp.  

### Example use cases
- System administrators who need a quick snapshot of server performance.  
- Developers who want to monitor resources during software testing.  
- Personal use to check system performance over time (scheduled task).  

---

##  Español

Este proyecto es un **script de monitoreo del sistema** escrito en **PowerShell** (`.ps1`).  
Recopila información clave del sistema y la exporta en **reportes CSV y HTML** para su posterior análisis.

### Características
- Monitoreo del uso de CPU.  
- Uso de RAM (total, usada, libre y porcentaje).  
- Uso de discos (por unidad: usada, libre, total y porcentaje).  
- Top 5 procesos que más consumen CPU.  
- Exportación de resultados a:
  - **CSV** (para análisis de datos).  
  - **HTML** (para visualización fácil).  

### Cómo usar
1. Clone o descarge este repositorio.  
2. Abra PowerShell y navege hasta la carpeta del proyecto.  
3. Ejecute el script:  
   ```powershell
   .\SystemMonitor.ps1
   ```
4. Los reportes se guardarán en la carpeta `Reports` con un sello de tiempo.  

### Casos de uso
- Administradores de sistemas que necesitan una vista rápida del rendimiento del servidor.  
- Desarrolladores que desean monitorear recursos durante pruebas de software.  
- Uso personal para revisar el rendimiento del sistema con el tiempo (tarea programada).  
