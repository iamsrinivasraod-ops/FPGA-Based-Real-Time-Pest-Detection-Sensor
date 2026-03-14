# FPGA-Based-Real-Time-Pest-Detection-Sensor

This project implements a **real-time pest detection system on FPGA** using basic image processing and environmental sensing.  
The system was developed during a **36-hour Hacktronics hackathon** and demonstrates how edge detection combined with environmental sensor data can be used to detect potential pest presence in agricultural environments.

The design processes incoming pixel data from an image stream and combines it with environmental conditions such as humidity, temperature, and spectral information to determine whether pest activity is likely.

---

# System Overview

The system consists of three main modules:

1. **Image Processing (Edge Detection)**
2. **Environmental Condition Monitoring**
3. **Pest Classification Logic**

The system detects potential pests when **strong image edges are present and environmental conditions favor pest activity**.

---

# Architecture

```
Camera Pixel Stream
        │
        ▼
   Sobel Edge Detector
        │
        ▼
 Edge Magnitude Output
        │
        ▼
Environmental Conditions
(humidity, temperature, spectral)
        │
        ▼
 Pest Detection Logic
        │
        ▼
   pest_detected Output
```

---

# Module Descriptions

## 1. Top Module: `hacktronics`

This is the **main module** responsible for pest detection.

### Inputs

| Signal | Description |
|------|-------------|
| `clk` | System clock |
| `rst` | System reset |
| `pixel_in[7:0]` | Incoming pixel intensity |
| `humidity_high` | Indicates high humidity |
| `spectral_high` | Indicates spectral signature associated with pests |
| `temp_high` | Indicates high temperature |

### Output

| Signal | Description |
|------|-------------|
| `pest_detected` | High when pest presence is detected |

### Detection Logic

Pest detection occurs when:

- Edge magnitude is strong
- Humidity is high
- Spectral signature indicates pest activity
- Temperature is high

```
if (edge_out > 50 && humidity_high && spectral_high && temp_high)
    pest_detected = 1
```

Once detected, the signal **remains latched** until reset.

---

## 2. Edge Detection Module: `sobel_simple`

This module performs **simplified edge detection** using pixel differences.

### Operation

The module compares the current pixel with the previous pixel:

```
difference = pixel_in - previous_pixel
edge_strength = absolute(difference)
```

If the difference exceeds a threshold, the module outputs a **strong edge signal**.

### Output Behaviour

| Condition | Output |
|----------|--------|
| Strong edge | 255 |
| Weak edge | magnitude value |

This provides a simple approximation of **Sobel edge detection** suitable for FPGA implementation.

---

# Testbench

The testbench `tb_hacktronics` simulates the entire system.

### Features

- Generates a clock signal
- Applies reset
- Loads image data from memory
- Simulates environmental conditions
- Streams image pixels into the design

### Image Input

A **64 × 64 grayscale image** (4096 pixels) is loaded from:

```
image.mem
```

The testbench feeds one pixel per clock cycle into the system.

---

# Simulation Flow

1. Reset the system
2. Load image pixel data
3. Stream pixels sequentially
4. Perform edge detection
5. Evaluate environmental conditions
6. Trigger pest detection when criteria are met

---

# File Structure

```
fpga-pest-detection/
│
├── hacktronics.v        # Top level pest detection module
├── sobel_simple.v       # Edge detection module
├── tb_hacktronics.v     # Testbench
├── image.mem            # Image pixel data
│
└── README.md
```

---

# Applications

- Smart agriculture monitoring
- Early pest detection systems
- Precision farming
- Edge AI for agriculture

---

# Possible Future Improvements

- Full Sobel convolution implementation
- Camera sensor integration
- FPGA acceleration for image pipelines
- Machine learning based pest classification
- Cloud-connected smart farming systems

---

# Author

Sriteja S N  
Electronics / Data Science Student  
Developed during Hacktronics Hackathon
