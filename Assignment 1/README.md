
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


## Usage/Examples

1. https://github.com/nipun-davasam/Computer-Vision/tree/e4ac4596bb2c1fd61a692ea3cd4fe74902449025/Assignment%201/Image2

2. https://github.com/nipun-davasam/Computer-Vision/tree/e4ac4596bb2c1fd61a692ea3cd4fe74902449025/Assignment%201/Image2

## License

[MIT](https://github.com/nipun-davasam/Computer-Vision/blob/e4ac4596bb2c1fd61a692ea3cd4fe74902449025/LICENSE)

