
# Project Title

Estimate Transforms of an Image


## Description

To estimate transform using matrix multiplication

Steps to Transform Image
1. Start with domain (x’,y’) of result I’.
2. Set up transform matrix A.
3. Invert the transform matrix A to get A-1.
4. For each (x’,y’) in I’, get corresponding (x,y) in I.
5. For each (x’,y’), set I’(x’,y’) <-- I(x,y) using interpolation.
x =ˆx/ˆw
y =ˆy/ˆw
6. Wrapping the final output within bounding box 


## Examples

![Image_1](https://github.com/nipun-davasam/Computer-Vision/assets/151178533/b24e6353-61ed-4213-a603-9804afb6486f)
![Image_4](https://github.com/nipun-davasam/Computer-Vision/assets/151178533/ae3eaff6-fca8-4646-9940-364bf1bee960)

## License

[MIT](https://github.com/nipun-davasam/Computer-Vision/blob/e4ac4596bb2c1fd61a692ea3cd4fe74902449025/LICENSE)

