### Steps to Reproduce -

- Load dalekosaur/object.mat
- Load camera_lego_data.mat - which holds parameters saved after mapping points between 3D lego object and 2D lego image captured from camera. Run Section tagged as Part 2 to extract K_checker values needed to run later section
- Load calibrationSession.mat - that holds intrisic parameters obtained from checkerboard calibration
- Pics folder holds output images of Part 3 section. Images are named after the surface they are placed on and Orientation number says about difference rotation, translation and lighting

## REPORT

### Points mapping 3d object and 2d image

![Capture](https://github.com/nipun-davasam/Computer-Vision/assets/151178533/42b96390-67a5-455f-9699-47126b981867)

### Snapshot of the mesh superposed onto the image in your report

![superposed_mesh_image](https://github.com/nipun-davasam/Computer-Vision/assets/151178533/826763b7-f71c-41ac-8583-e42ae9683359)

### K using lego object

| 1                | 2                | 3                |
| ---------------- | ---------------- | ---------------- |
| 5355.24075432269 | 50.1538939803481 | 3433.31616072442 |
| 0                | 5247.90529800860 | 2195.02206739659 |
| 0                | 0                | 1                |

### K using checker board

| 1                | 2                | 3                |
| ---------------- | ---------------- | ---------------- |
| 5509.79498864168 | 0                | 4026.07770780940 |
| 0                | 5553.33785324771 | 2966.24901766546 |
| 0                | 0                | 1                |

#### Observation :

The non zero value at cell (1,2) in intrinsic parameter matrix obtained from lego object shows that the sensor is skewed, while intrinsic parameter matrix obtained from checkboard has a zero value stating that the camera sensor is a clean rectangle.

Reason for such a change might be due to human error while calibrating.

### Inserting the 3Dmodel using K and K_checker

### 1. Using K through lego object calibration

![Surface 1 using K camera parameters and Orientation 2](https://github.com/nipun-davasam/Computer-Vision/assets/151178533/0cfcc7e8-65ce-4534-9be2-6055575603b5)

### 2. Using K through checker board calibration

![Surface 1 using K-checker camera parameters and Orientation 2](https://github.com/nipun-davasam/Computer-Vision/assets/151178533/104466a0-aeff-4fa2-99f5-85a2d3f131a1)

### Difference in perceptual quality between the images created using K and K_checker

1.  K_checker includes additional parameters specific to the calibration pattern used such as the size and spacing of checkerboard squares
2.  The accuracy of the camera calibration process significantly impacts the perceptual quality of images produced.
3.  Characteristics of the camera lens, such as lens distortion, aberrations, and sharpness does influence the image quality.
