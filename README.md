# FPGA VGA Oscilloscope

## Overview

This project implements a real-time FPGA-based digital oscilloscope using **Verilog HDL** on a **Xilinx Artix-7 (Basys 3) FPGA**. The system samples analog signals through an **AD7819 Analog-to-Digital Converter (ADC)**, stores the digitized data in a circular memory buffer, and renders live waveforms on a VGA display using a custom hardware controller.

The project demonstrates FPGA-based digital system design, real-time signal acquisition, VGA controller development, memory management, and hardware validation.

---

## Key Features

* Real-time analog waveform acquisition and visualization
* Custom VGA controller with HSYNC and VSYNC timing generation
* AD7819 ADC interface for continuous signal sampling
* Circular memory buffering for live waveform updates
* Support for square and triangle waveform visualization
* Hardware implementation on a Xilinx Basys 3 (Artix-7 FPGA)
* Simulation and hardware validation using Xilinx Vivado

---

## System Architecture

The oscilloscope is implemented as a hardware pipeline using custom Verilog modules that coordinate data acquisition, buffering, and display generation.

```text
Analog Input
      ↓
AD7819 ADC
      ↓
FPGA Sampling Controller
      ↓
Circular Memory Buffer
      ↓
VGA Timing Generator
      ↓
Pixel Mapping Logic
      ↓
640×480 VGA Display
```

The FPGA synchronizes ADC sampling with VGA refresh timing to provide continuous real-time waveform visualization.

---

## Design Methodology

### FPGA Development

* Developed the oscilloscope using Verilog HDL
* Designed custom VGA timing logic for HSYNC and VSYNC generation
* Implemented FPGA control logic for ADC communication and waveform acquisition
* Utilized circular memory buffering for continuous waveform rendering

### Hardware Integration

* Interfaced the AD7819 ADC with the Basys 3 FPGA
* Synchronized ADC control signals with the FPGA clock domain
* Mapped 8-bit ADC samples to VGA pixel coordinates for real-time display
* Incorporated signal conditioning techniques to improve waveform quality

### Verification & Hardware Validation

* Verified functionality using Xilinx Vivado simulation
* Validated waveform acquisition using square and triangle wave inputs
* Confirmed correct VGA timing generation and real-time display through laboratory hardware testing

---

## Technologies Used

* Verilog HDL
* Xilinx Vivado
* Xilinx Basys 3 (Artix-7 FPGA)
* AD7819 ADC
* VGA Interface
* Digital Logic Design
* FPGA Development
* Hardware Verification

---

## Repository Structure

```text
Report/
    FPGA_VGA_Oscilloscope_Report.pdf

Results/
    Hardware validation images
    Oscilloscope results

Source_Code/
    Verilog source files
    Testbenches
```

---

## Engineering Challenges

* Synchronized ADC control signals (`CONVST`, `CSB`, and `RDB`) with the FPGA clock to ensure reliable sampling
* Implemented circular buffering to support continuous real-time waveform updates
* Developed VGA timing logic for accurate waveform rendering
* Integrated analog signal acquisition, digital processing, and video output within a single FPGA design

---

## My Contributions

* Developed and verified Verilog modules for waveform acquisition and VGA display
* Assisted with FPGA integration of the ADC interface and memory buffering
* Contributed to timing synchronization, debugging, and hardware validation
* Participated in system testing, documentation, and final project presentation

---

## Project Outcome

This project successfully demonstrated a real-time FPGA-based digital oscilloscope capable of acquiring analog signals, storing sampled data, and displaying live waveforms on a VGA monitor.

The project strengthened practical experience in FPGA development, Verilog HDL, digital system design, hardware interfacing, VGA controller implementation, and real-time hardware verification.

---

## Academic Context

**California State University, East Bay**

**CMPE 480 – VLSI Circuit Design/Layout**

**Spring 2026**

**Team Members**

* Inderpal Singh
* Jaskaran Singh Mann
