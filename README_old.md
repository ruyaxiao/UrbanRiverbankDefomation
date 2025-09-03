# Unwrapping Error Optimization and InSAR Time-Series Analysis

This repository contains the source codes and supplementary materials for the manuscript titled "Decadal Earth Observation-Informed Analysis of Urban Riverbank Deformation: InSAR Insights into Soft Ground Dynamics in Nanjing, China" submitted to *International Journal of Applied Earth Observation and Geoinformation*. It facilitates the full reproduction of the methodological workflow, including InSAR unwrapping error optimization and subsequent time-series analysis.

## 🚀 Repository Overview

This project provides Bash and MATLAB scripts to:
1.  **Optimize InSAR unwrapping errors** using a custom Bash-based pipeline.
2.  **Analyze the resulting time-series** using Mann-Kendall trend tests, wavelet analysis, and amplitude calculation implemented in MATLAB.

## ⚙️ System Requirements & Dependencies

### Software
-   **Bash**: A Unix shell (*e.g.*, comes pre-installed on Linux/macOS. For Windows, use [WSL](https://docs.microsoft.com/en-us/windows/wsl/install) or [Git Bash](https://gitforwindows.org/)).
-   **MATLAB**: Version R2019b or higher.
-   **GAMMA Software**: [GAMMA](https://gamma-rs.ch/gamma-software) software suite (versions released after 2023 are recommended) for InSAR data preprocessing.
-   **SNAPHU**: Statistical-Cost, Network-Flow Algorithm for Phase Unwrapping [SNAPHU](https://web.stanford.edu/group/radar/softwareandlinks/sw/snaphu/) developed by Stanford Radar Interferometry Research Group.

### Dependencies
The MATLAB code relies on no third-party custom functions beyond the specified Toolboxes. The Bash script uses standard GNU tools and requires a functioning GAMMA installation to execute commands (*e.g.*, `swap_bytes`, `mcf`, `create_offset`).

## 📊 Datasets

The `/datesets_insar_timeseries/` directory contains InSAR results and temperature time-series datasets in the paper.

## 📋 Code File Description

| File Name | Type | Purpose | Key Variables to Modify | Usage Example |
| :--- | :--- | :--- | :--- | :--- |
| **`optimize_unwrapping.sh`** | Bash Script | Optimizes InSAR phase unwrapping errors | Set `INPUT_DIR`, `OUTPUT_DIR` paths at the top of the script. | `./optimize_unwrapping.sh data_list.txt` |
| **`snaphu_parallel.sh`** | Bash Function | parallel for optimization | -- | `./snaphu_parallel.sh $top_dir $date $width $coherence_thre` |
| **`wavelet_analysis.m`** | MATLAB Script | Main script to perform wavelet analysis on prepared time-series data. | Modify `InSAR_input` and `Temp_input` variables at the beginning of the script. | `>>wavelet_analysis.m` |
| **`Mann_Kendall.m`** | MATLAB Function | Computes Mann-Kendall trend test statistics | -- |`[H P_value Z]=Mann_Kendall(data,alpha)` |
| **`cal_Amp.m`** | MATLAB Script | calculate the amplitude and phase | Modify `InSAR_input` variables at the beginning of the script. | `>>cal_Amp.m` |



