# NetWrapper 
**NetWrapper** is a powerful shell script designed to enhance the capabilities of the **netexec** tool by generating detailed HTML reports. Simplify your network execution tasks and visualize the results with style and clarity.

<p align="center"> 
  <img src="https://github.com/Edd13Mora/NetWrapper/blob/main/Netexec.png" alt="Pacman Logo" >
</p>

<H2>SMB Shares Enumeration</H2>
<p align="center"> 
  <img src="https://raw.githubusercontent.com/Edd13Mora/NetWrapper/main/demo1.png" alt="Shares Enum" >
</p>
<H2>Kerberoasting Demo</H2>
<p align="center"> 
  <img src="https://raw.githubusercontent.com/Edd13Mora/NetWrapper/main/demo2.png" alt="Kerberostable users" >
</p>

## Features

- **Easy to Use**: Simply wrap your existing netexec commands with NetWrapper to create beautiful HTML reports.
- **HTML Report Generation**: Automatically generates a well-structured HTML report of netexec output.
- **Visual Enhancements**: Highlights important details and protocols (e.g., SMB, LDAP, FTP, SSH) with colored and icon-based indicators for quick analysis.
- **Custom Styling**: Incorporates Bootstrap for a responsive and clean design, with custom CSS for enhanced readability.

## How It Works

1. **Run Your Commands**: Use NetWrapper to execute your netexec commands.
2. **Generate Reports**: NetWrapper captures the output and converts it into an HTML report.
3. **Visualize**: Open the generated report in your favorite browser to explore the results.

## Installation

Make sure you have `netexec` installed and available in your system's PATH. Then, simply download the `NetWrapper` script:

```bash
git clone https://github.com/Edd13Mora/NetWrapper.git
cd NetWrapper
chmod +x net.sh
