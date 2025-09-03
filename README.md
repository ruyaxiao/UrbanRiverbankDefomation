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

## 📋 Code File Description

| File Name | Type | Purpose | Key Variables to Modify | Usage Example |
| :--- | :--- | :--- | :--- | :--- |
| **`optimize_unwrapping.sh`** | Bash Script | Optimizes InSAR phase unwrapping errors | Set `INPUT_DIR`, `OUTPUT_DIR` paths at the top of the script. | `./optimize_unwrapping.sh data_list.txt` |
| **`snaphu_parallel.sh`** | Bash Function | parallel for optimization | -- | `./snaphu_parallel.sh $top_dir $date $width $coherence_thre` |
| **`wavelet_analysis.m`** | MATLAB Script | Main script to perform wavelet analysis on prepared time-series data. | Modify `InSAR_input` and `Temp_input` variables at the beginning of the script. | `>>wavelet_analysis.m` |
| **`Mann_Kendall.m`** | MATLAB Function | Computes Mann-Kendall trend test statistics | -- |`[H P_value Z]=Mann_Kendall(data,alpha)` |
| **`cal_Amp.m`** | MATLAB Script | calculate the amplitude and phase | Modify `InSAR_input` variables at the beginning of the script. | `>>cal_Amp.m` |

## 📊 Datasets

The `/datesets_insar_timeseries/` directory contains InSAR results and temperature time-series datasets in the paper.

## 📁 Data File Description

The provided example data files include both time-series for specific monitoring points and ancillary datasets used in our analysis. The following table details their content and the location where they are utilized or presented in our manuscript:

| Data File | Description | Manuscript Reference |
| :--- | :--- | :--- |
| `JB01` - `JB05` | InSAR monitoring results on typical points in **Jiangbei New Area (JBA)**. | **Fig. 8** |
| `HX01` - `HX05` | InSAR monitoring results on typical points in **Hexi New Town (HXT)**. | **Fig. 10** |
| `HRLB`,&nbsp;`HRRB`,&nbsp;`HR01`&nbsp;-&nbsp;`HR05` | InSAR monitoring results on typical points in **High-Speed Railway (HR) Nanjing Yangtze River Bridge**. LB: left bank, RB: right bank.| **Fig. 11 & Fig. 13** |
| `DSLB`,&nbsp;`DSRB`,&nbsp;`DS01`&nbsp;-&nbsp;`DS03` | InSAR monitoring results on typical points in **Dashengguan (DS) Bridge**. | **Fig. 11** |
| `Temperature.csv`| Daily temperature data of **HR bridge** for wavelet analysis. | **Fig. 13** |
| `baselines_info.txt`| Baseline information of InSAR interferograms. | **Fig. 1** |

**Note:** The precise locations of all these typical InSAR monitoring points are explained in detail within the manuscript.

The InSAR deformation time-series data are provided in CSV format, structured as follows:

| Longitude (°) | Latitude (°) | Rate (mm/yr) | Defo_date1 (mm) | Defo_date2 (mm) | ... | Defo_dateN (mm) 
| :------------ | :----------- | :----------- | :----------- | :----------- | :-- | :---------- |
| 116.1234      | 39.5678      | -15.6        | 0.0          | -1.2         | ... | -54.3       |

**Column Definitions:**
*   **Longitude, Latitude**: Geodetic coordinates (WGS84) of the measurement point.
*   **Rate**: The mean linear deformation velocity derived from the time-series.
*   **Defo_date1 ... Defo_dateN**: Cumulative surface displacement (in mm) relative to the first acquisition date (`Defo_date1`). 

The Temperature data are also provided in CSV format, structured as follows:

| Temp_date1 (°C) | Temp_date2 (°C) | ... | Temp_dateN (°C) |
| :----------- | :----------- | :-- | :---------- |
| 12.5          | 17.9         | ... | -2.3       |

