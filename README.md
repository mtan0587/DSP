# ELEC3305 Digital Signal Processing — Lab Notes

Raw lab notes and practical exercises for **ELEC3305 Digital Signal Processing** at the University of Sydney, practised by **Matthew Kimi Tanoyo**.

This repository is a personal study record — not polished coursework submissions. It contains worked implementations, explorations, and experiments done alongside the unit.

---

## Primary Reference

**Digital Signal Processing** — Alan V. Oppenheim & Ronald W. Schafer (with John R. Buck)
Prentice Hall, 2nd Edition

Additional references:
- **Discrete-Time Signal Processing** — Oppenheim & Schafer, 3rd Edition
- ELEC3305 lecture materials, University of Sydney
- MATLAB Signal Processing Toolbox documentation
- NumPy / SciPy documentation for Python implementations

---

## Repository Structure

Labs are split between **MATLAB** (`.mlx` Live Scripts) and **Python** (Jupyter notebooks `.ipynb`).

### Python Labs

| Folder | Topic |
|--------|-------|
| `Convolutions and Filtering/` | Discrete convolution, linear filtering in Python |
| `Discrete-Time Fourier Transform/` | DTFT analysis and properties |
| `Fast Fourier Transform (FFT) & Discrete Cosine Transform (DCT)/` | FFT algorithms and DCT for image compression |

Each Python lab folder contains its own `.venv` virtual environment and a Jupyter notebook.

### MATLAB Labs

| Folder | Topic |
|--------|-------|
| `Filter Types, Hilbert Space & Group Delays/` | FIR filter types, Hilbert space interpretation, group delay |
| `FIR IIR Filter Designs/` | FIR and IIR filter design methods |
| `FIR Voice Filtering/` | Applying FIR filters to voice/audio signals |
| `Hilbert Transform/` | Hilbert transform and spectral analysis |
| `PRACTICAL Speech/` | End-to-end speech processing practical |
| `PRACTICAL Image/` | End-to-end image processing practical |

### Toolbox

`Toolbox/` is the shared MATLAB function library, based on the companion code from Oppenheim & Schafer. It includes:
- Signal generation: `impseq.m`, `stepseq.m`, `sigadd.m`, `sigshift.m`, `sigfold.m`, `sigmult.m`
- DFT/IDFT: `dft.m`, `idft.m`
- Ideal filters: `ideal_lp.m`
- Filter structure conversions: `dir2cas.m`, `cas2dir.m`, `dir2par.m`, `par2dir.m`
- FIR type functions: `hr_type1.m` – `hr_type4.m`
- Quantisation utilities: `QFix.m`, `QCoeff.m`, `Q_Rounding.m`, `Q_Truncation.m`
- Overlap-add / overlap-save convolution: `OverLapAddConv.m`, `OverLapSavConv.m`
- Audio utilities: `PlayRecordAudio.m`, `RecordAudio.m`
- Supporting subdirectories: `Sounds/`, `standard_test_images/`, `exm_2014/`

---

## Getting Started

### MATLAB

1. Open MATLAB and navigate to the `Toolbox/` directory.
2. Run the setup script to add all required paths:
   ```matlab
   startELEC3305
   ```
3. Open any `.mlx` file from its lab subfolder and run it.

> **This step is required every MATLAB session.** Without it, toolbox functions like `dft`, `impseq`, and `ideal_lp` will not be found.

### Python

Each notebook folder has its own virtual environment. Activate it and launch Jupyter:

```bash
cd "Convolutions and Filtering"
.venv\Scripts\activate          # Windows
# source .venv/bin/activate     # macOS/Linux
jupyter notebook ConvolutionsPy.ipynb
```

---

## Topics Covered

- Discrete-time signals and systems
- Convolution and linear filtering
- Discrete-Time Fourier Transform (DTFT)
- Discrete Fourier Transform (DFT) and Fast Fourier Transform (FFT)
- Discrete Cosine Transform (DCT) and image compression
- FIR and IIR filter design
- Hilbert transform and analytic signals
- Group delay and phase response
- Voice and image processing practicals
