??
?"?!
:
Add
x"T
y"T
z"T"
Ttype:
2	
x
Assign
ref"T?

value"T

output_ref"T?"	
Ttype"
validate_shapebool("
use_lockingbool(?
~
BiasAdd

value"T	
bias"T
output"T" 
Ttype:
2	"-
data_formatstringNHWC:
NHWCNCHW
8
Const
output"dtype"
valuetensor"
dtypetype
?
Conv2D

input"T
filter"T
output"T"
Ttype:
2"
strides	list(int)"
use_cudnn_on_gpubool(",
paddingstring:
SAMEVALIDEXPLICIT""
explicit_paddings	list(int)
 "-
data_formatstringNHWC:
NHWCNCHW" 
	dilations	list(int)

y
Enter	
data"T
output"T"	
Ttype"

frame_namestring"
is_constantbool( "
parallel_iterationsint

)
Exit	
data"T
output"T"	
Ttype
W

ExpandDims

input"T
dim"Tdim
output"T"	
Ttype"
Tdimtype0:
2	
^
Fill
dims"
index_type

value"T
output"T"	
Ttype"

index_typetype0:
2	
.
Identity

input"T
output"T"	
Ttype
:
Less
x"T
y"T
z
"
Ttype:
2	
$

LogicalAnd
x

y

z
?
!
LoopCond	
input


output

q
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:

2	
?
MaxPool

input"T
output"T"
Ttype0:
2	"
ksize	list(int)(0"
strides	list(int)(0""
paddingstring:
SAMEVALID":
data_formatstringNHWC:
NHWCNCHWNCHW_VECT_C
N
Merge
inputs"T*N
output"T
value_index"	
Ttype"
Nint(0
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(?
=
Mul
x"T
y"T
z"T"
Ttype:
2	?
2
NextIteration	
data"T
output"T"	
Ttype

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
X
PlaceholderWithDefault
input"dtype
output"dtype"
dtypetype"
shapeshape
~
RandomUniform

shape"T
output"dtype"
seedint "
seed2int "
dtypetype:
2"
Ttype:
2	?
a
Range
start"Tidx
limit"Tidx
delta"Tidx
output"Tidx"
Tidxtype0:	
2	
E
Relu
features"T
activations"T"
Ttype:
2	
[
Reshape
tensor"T
shape"Tshape
output"T"	
Ttype"
Tshapetype0:
2	
?
ResizeBilinear
images"T
size
resized_images"
Ttype:
2
	"
align_cornersbool( "
half_pixel_centersbool( 
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0?
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0?
P
Shape

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
H
ShardedFilename
basename	
shard

num_shards
filename
N
Squeeze

input"T
output"T"	
Ttype"
squeeze_dims	list(int)
 (
?
StridedSlice

input"T
begin"Index
end"Index
strides"Index
output"T"	
Ttype"
Indextype:
2	"

begin_maskint "
end_maskint "
ellipsis_maskint "
new_axis_maskint "
shrink_axis_maskint 
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
:
Sub
x"T
y"T
z"T"
Ttype:
2	
M
Switch	
data"T
pred

output_false"T
output_true"T"	
Ttype
{
TensorArrayGatherV3

handle
indices
flow_in
value"dtype"
dtypetype"
element_shapeshape:?
Y
TensorArrayReadV3

handle	
index
flow_in
value"dtype"
dtypetype?
d
TensorArrayScatterV3

handle
indices

value"T
flow_in
flow_out"	
Ttype?
9
TensorArraySizeV3

handle
flow_in
size?
?
TensorArrayV3
size

handle
flow"
dtypetype"
element_shapeshape:"
dynamic_sizebool( "
clear_after_readbool("$
identical_element_shapesbool( "
tensor_array_namestring ?
`
TensorArrayWriteV3

handle	
index

value"T
flow_in
flow_out"	
Ttype?
s

VariableV2
ref"dtype?"
shapeshape"
dtypetype"
	containerstring "
shared_namestring ?"serve*1.14.02v1.14.0-rc1-22-gaf24dc91b5Ʃ

global_step/Initializer/zerosConst*
value	B	 R *
_class
loc:@global_step*
dtype0	*
_output_shapes
: 
?
global_step
VariableV2*
dtype0	*
_output_shapes
: *
shared_name *
_class
loc:@global_step*
	container *
shape: 
?
global_step/AssignAssignglobal_stepglobal_step/Initializer/zeros*
T0	*
_class
loc:@global_step*
validate_shape(*
_output_shapes
: *
use_locking(
j
global_step/readIdentityglobal_step*
T0	*
_class
loc:@global_step*
_output_shapes
: 
?
image_tensorPlaceholder*
dtype0*A
_output_shapes/
-:+???????????????????????????*6
shape-:+???????????????????????????
U
	map/ShapeShapeimage_tensor*
T0*
out_type0*
_output_shapes
:
a
map/strided_slice/stackConst*
valueB: *
dtype0*
_output_shapes
:
c
map/strided_slice/stack_1Const*
valueB:*
dtype0*
_output_shapes
:
c
map/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
?
map/strided_sliceStridedSlice	map/Shapemap/strided_slice/stackmap/strided_slice/stack_1map/strided_slice/stack_2*
end_mask *
_output_shapes
: *
Index0*
T0*
shrink_axis_mask*

begin_mask *
ellipsis_mask *
new_axis_mask 
?
map/TensorArrayTensorArrayV3map/strided_slice*
tensor_array_name *
dtype0*
_output_shapes

:: *
element_shape:*
dynamic_size( *
clear_after_read(*
identical_element_shapes(
h
map/TensorArrayUnstack/ShapeShapeimage_tensor*
_output_shapes
:*
T0*
out_type0
t
*map/TensorArrayUnstack/strided_slice/stackConst*
valueB: *
dtype0*
_output_shapes
:
v
,map/TensorArrayUnstack/strided_slice/stack_1Const*
valueB:*
dtype0*
_output_shapes
:
v
,map/TensorArrayUnstack/strided_slice/stack_2Const*
dtype0*
_output_shapes
:*
valueB:
?
$map/TensorArrayUnstack/strided_sliceStridedSlicemap/TensorArrayUnstack/Shape*map/TensorArrayUnstack/strided_slice/stack,map/TensorArrayUnstack/strided_slice/stack_1,map/TensorArrayUnstack/strided_slice/stack_2*
shrink_axis_mask*

begin_mask *
ellipsis_mask *
new_axis_mask *
end_mask *
_output_shapes
: *
Index0*
T0
d
"map/TensorArrayUnstack/range/startConst*
value	B : *
dtype0*
_output_shapes
: 
d
"map/TensorArrayUnstack/range/deltaConst*
value	B :*
dtype0*
_output_shapes
: 
?
map/TensorArrayUnstack/rangeRange"map/TensorArrayUnstack/range/start$map/TensorArrayUnstack/strided_slice"map/TensorArrayUnstack/range/delta*#
_output_shapes
:?????????*

Tidx0
?
>map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3TensorArrayScatterV3map/TensorArraymap/TensorArrayUnstack/rangeimage_tensormap/TensorArray:1*
T0*
_class
loc:@image_tensor*
_output_shapes
: 
K
	map/ConstConst*
value	B : *
dtype0*
_output_shapes
: 
?
map/TensorArray_1TensorArrayV3map/strided_slice*
element_shape:*
dynamic_size( *
clear_after_read(*
identical_element_shapes(*
tensor_array_name *
dtype0*
_output_shapes

:: 
]
map/while/iteration_counterConst*
dtype0*
_output_shapes
: *
value	B : 
?
map/while/EnterEntermap/while/iteration_counter*
T0*
is_constant( *
parallel_iterations
*
_output_shapes
: *'

frame_namemap/while/while_context
?
map/while/Enter_1Enter	map/Const*
parallel_iterations
*
_output_shapes
: *'

frame_namemap/while/while_context*
T0*
is_constant( 
?
map/while/Enter_2Entermap/TensorArray_1:1*
parallel_iterations
*
_output_shapes
: *'

frame_namemap/while/while_context*
T0*
is_constant( 
n
map/while/MergeMergemap/while/Entermap/while/NextIteration*
T0*
N*
_output_shapes
: : 
t
map/while/Merge_1Mergemap/while/Enter_1map/while/NextIteration_1*
T0*
N*
_output_shapes
: : 
t
map/while/Merge_2Mergemap/while/Enter_2map/while/NextIteration_2*
N*
_output_shapes
: : *
T0
^
map/while/LessLessmap/while/Mergemap/while/Less/Enter*
T0*
_output_shapes
: 
?
map/while/Less/EnterEntermap/strided_slice*
T0*
is_constant(*
parallel_iterations
*
_output_shapes
: *'

frame_namemap/while/while_context
b
map/while/Less_1Lessmap/while/Merge_1map/while/Less/Enter*
T0*
_output_shapes
: 
\
map/while/LogicalAnd
LogicalAndmap/while/Lessmap/while/Less_1*
_output_shapes
: 
L
map/while/LoopCondLoopCondmap/while/LogicalAnd*
_output_shapes
: 
?
map/while/SwitchSwitchmap/while/Mergemap/while/LoopCond*
T0*"
_class
loc:@map/while/Merge*
_output_shapes
: : 
?
map/while/Switch_1Switchmap/while/Merge_1map/while/LoopCond*
T0*$
_class
loc:@map/while/Merge_1*
_output_shapes
: : 
?
map/while/Switch_2Switchmap/while/Merge_2map/while/LoopCond*
_output_shapes
: : *
T0*$
_class
loc:@map/while/Merge_2
S
map/while/IdentityIdentitymap/while/Switch:1*
T0*
_output_shapes
: 
W
map/while/Identity_1Identitymap/while/Switch_1:1*
T0*
_output_shapes
: 
W
map/while/Identity_2Identitymap/while/Switch_2:1*
T0*
_output_shapes
: 
f
map/while/add/yConst^map/while/Identity*
dtype0*
_output_shapes
: *
value	B :
Z
map/while/addAddmap/while/Identitymap/while/add/y*
T0*
_output_shapes
: 
?
map/while/TensorArrayReadV3TensorArrayReadV3!map/while/TensorArrayReadV3/Entermap/while/Identity_1#map/while/TensorArrayReadV3/Enter_1*
dtype0*4
_output_shapes"
 :??????????????????
?
!map/while/TensorArrayReadV3/EnterEntermap/TensorArray*
T0*
is_constant(*
parallel_iterations
*
_output_shapes
:*'

frame_namemap/while/while_context
?
#map/while/TensorArrayReadV3/Enter_1Enter>map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3*
T0*
is_constant(*
parallel_iterations
*
_output_shapes
: *'

frame_namemap/while/while_context
v
map/while/resize/ExpandDims/dimConst^map/while/Identity*
value	B : *
dtype0*
_output_shapes
: 
?
map/while/resize/ExpandDims
ExpandDimsmap/while/TensorArrayReadV3map/while/resize/ExpandDims/dim*

Tdim0*
T0*8
_output_shapes&
$:"??????????????????
{
map/while/resize/sizeConst^map/while/Identity*
valueB"?   ?   *
dtype0*
_output_shapes
:
?
map/while/resize/ResizeBilinearResizeBilinearmap/while/resize/ExpandDimsmap/while/resize/size*
align_corners( *
half_pixel_centers( *
T0*(
_output_shapes
:??
?
map/while/resize/SqueezeSqueezemap/while/resize/ResizeBilinear*
T0*$
_output_shapes
:??*
squeeze_dims
 
?
-map/while/TensorArrayWrite/TensorArrayWriteV3TensorArrayWriteV33map/while/TensorArrayWrite/TensorArrayWriteV3/Entermap/while/Identity_1map/while/resize/Squeezemap/while/Identity_2*
T0*+
_class!
loc:@map/while/resize/Squeeze*
_output_shapes
: 
?
3map/while/TensorArrayWrite/TensorArrayWriteV3/EnterEntermap/TensorArray_1*
is_constant(*
_output_shapes
:*'

frame_namemap/while/while_context*
T0*+
_class!
loc:@map/while/resize/Squeeze*
parallel_iterations

h
map/while/add_1/yConst^map/while/Identity*
value	B :*
dtype0*
_output_shapes
: 
`
map/while/add_1Addmap/while/Identity_1map/while/add_1/y*
T0*
_output_shapes
: 
X
map/while/NextIterationNextIterationmap/while/add*
T0*
_output_shapes
: 
\
map/while/NextIteration_1NextIterationmap/while/add_1*
T0*
_output_shapes
: 
z
map/while/NextIteration_2NextIteration-map/while/TensorArrayWrite/TensorArrayWriteV3*
T0*
_output_shapes
: 
I
map/while/ExitExitmap/while/Switch*
_output_shapes
: *
T0
M
map/while/Exit_1Exitmap/while/Switch_1*
T0*
_output_shapes
: 
M
map/while/Exit_2Exitmap/while/Switch_2*
_output_shapes
: *
T0
?
&map/TensorArrayStack/TensorArraySizeV3TensorArraySizeV3map/TensorArray_1map/while/Exit_2*$
_class
loc:@map/TensorArray_1*
_output_shapes
: 
?
 map/TensorArrayStack/range/startConst*
value	B : *$
_class
loc:@map/TensorArray_1*
dtype0*
_output_shapes
: 
?
 map/TensorArrayStack/range/deltaConst*
value	B :*$
_class
loc:@map/TensorArray_1*
dtype0*
_output_shapes
: 
?
map/TensorArrayStack/rangeRange map/TensorArrayStack/range/start&map/TensorArrayStack/TensorArraySizeV3 map/TensorArrayStack/range/delta*$
_class
loc:@map/TensorArray_1*#
_output_shapes
:?????????*

Tidx0
?
(map/TensorArrayStack/TensorArrayGatherV3TensorArrayGatherV3map/TensorArray_1map/TensorArrayStack/rangemap/while/Exit_2*
dtype0*1
_output_shapes
:???????????*!
element_shape:??*$
_class
loc:@map/TensorArray_1
?
5layer1/conv2d/kernel/Initializer/random_uniform/shapeConst*%
valueB"             *'
_class
loc:@layer1/conv2d/kernel*
dtype0*
_output_shapes
:
?
3layer1/conv2d/kernel/Initializer/random_uniform/minConst*
valueB
 *OS?*'
_class
loc:@layer1/conv2d/kernel*
dtype0*
_output_shapes
: 
?
3layer1/conv2d/kernel/Initializer/random_uniform/maxConst*
valueB
 *OS>*'
_class
loc:@layer1/conv2d/kernel*
dtype0*
_output_shapes
: 
?
=layer1/conv2d/kernel/Initializer/random_uniform/RandomUniformRandomUniform5layer1/conv2d/kernel/Initializer/random_uniform/shape*
T0*'
_class
loc:@layer1/conv2d/kernel*
seed2 *
dtype0*&
_output_shapes
: *

seed 
?
3layer1/conv2d/kernel/Initializer/random_uniform/subSub3layer1/conv2d/kernel/Initializer/random_uniform/max3layer1/conv2d/kernel/Initializer/random_uniform/min*
T0*'
_class
loc:@layer1/conv2d/kernel*
_output_shapes
: 
?
3layer1/conv2d/kernel/Initializer/random_uniform/mulMul=layer1/conv2d/kernel/Initializer/random_uniform/RandomUniform3layer1/conv2d/kernel/Initializer/random_uniform/sub*&
_output_shapes
: *
T0*'
_class
loc:@layer1/conv2d/kernel
?
/layer1/conv2d/kernel/Initializer/random_uniformAdd3layer1/conv2d/kernel/Initializer/random_uniform/mul3layer1/conv2d/kernel/Initializer/random_uniform/min*
T0*'
_class
loc:@layer1/conv2d/kernel*&
_output_shapes
: 
?
layer1/conv2d/kernel
VariableV2*
dtype0*&
_output_shapes
: *
shared_name *'
_class
loc:@layer1/conv2d/kernel*
	container *
shape: 
?
layer1/conv2d/kernel/AssignAssignlayer1/conv2d/kernel/layer1/conv2d/kernel/Initializer/random_uniform*
use_locking(*
T0*'
_class
loc:@layer1/conv2d/kernel*
validate_shape(*&
_output_shapes
: 
?
layer1/conv2d/kernel/readIdentitylayer1/conv2d/kernel*
T0*'
_class
loc:@layer1/conv2d/kernel*&
_output_shapes
: 
?
$layer1/conv2d/bias/Initializer/zerosConst*
valueB *    *%
_class
loc:@layer1/conv2d/bias*
dtype0*
_output_shapes
: 
?
layer1/conv2d/bias
VariableV2*
dtype0*
_output_shapes
: *
shared_name *%
_class
loc:@layer1/conv2d/bias*
	container *
shape: 
?
layer1/conv2d/bias/AssignAssignlayer1/conv2d/bias$layer1/conv2d/bias/Initializer/zeros*
T0*%
_class
loc:@layer1/conv2d/bias*
validate_shape(*
_output_shapes
: *
use_locking(
?
layer1/conv2d/bias/readIdentitylayer1/conv2d/bias*
T0*%
_class
loc:@layer1/conv2d/bias*
_output_shapes
: 
l
layer1/conv2d/dilation_rateConst*
valueB"      *
dtype0*
_output_shapes
:
?
layer1/conv2d/Conv2DConv2D(map/TensorArrayStack/TensorArrayGatherV3layer1/conv2d/kernel/read*
	dilations
*
T0*
data_formatNHWC*
strides
*
explicit_paddings
 *
use_cudnn_on_gpu(*
paddingVALID*/
_output_shapes
:?????????~~ 
?
layer1/conv2d/BiasAddBiasAddlayer1/conv2d/Conv2Dlayer1/conv2d/bias/read*
T0*
data_formatNHWC*/
_output_shapes
:?????????~~ 
k
layer1/conv2d/ReluRelulayer1/conv2d/BiasAdd*/
_output_shapes
:?????????~~ *
T0
?
layer1/max_pooling2d/MaxPoolMaxPoollayer1/conv2d/Relu*
ksize
*
paddingVALID*/
_output_shapes
:??????????? *
T0*
strides
*
data_formatNHWC
?
5layer2/conv2d/kernel/Initializer/random_uniform/shapeConst*%
valueB"          @   *'
_class
loc:@layer2/conv2d/kernel*
dtype0*
_output_shapes
:
?
3layer2/conv2d/kernel/Initializer/random_uniform/minConst*
valueB
 *????*'
_class
loc:@layer2/conv2d/kernel*
dtype0*
_output_shapes
: 
?
3layer2/conv2d/kernel/Initializer/random_uniform/maxConst*
valueB
 *???=*'
_class
loc:@layer2/conv2d/kernel*
dtype0*
_output_shapes
: 
?
=layer2/conv2d/kernel/Initializer/random_uniform/RandomUniformRandomUniform5layer2/conv2d/kernel/Initializer/random_uniform/shape*
dtype0*&
_output_shapes
: @*

seed *
T0*'
_class
loc:@layer2/conv2d/kernel*
seed2 
?
3layer2/conv2d/kernel/Initializer/random_uniform/subSub3layer2/conv2d/kernel/Initializer/random_uniform/max3layer2/conv2d/kernel/Initializer/random_uniform/min*
_output_shapes
: *
T0*'
_class
loc:@layer2/conv2d/kernel
?
3layer2/conv2d/kernel/Initializer/random_uniform/mulMul=layer2/conv2d/kernel/Initializer/random_uniform/RandomUniform3layer2/conv2d/kernel/Initializer/random_uniform/sub*
T0*'
_class
loc:@layer2/conv2d/kernel*&
_output_shapes
: @
?
/layer2/conv2d/kernel/Initializer/random_uniformAdd3layer2/conv2d/kernel/Initializer/random_uniform/mul3layer2/conv2d/kernel/Initializer/random_uniform/min*
T0*'
_class
loc:@layer2/conv2d/kernel*&
_output_shapes
: @
?
layer2/conv2d/kernel
VariableV2*
	container *
shape: @*
dtype0*&
_output_shapes
: @*
shared_name *'
_class
loc:@layer2/conv2d/kernel
?
layer2/conv2d/kernel/AssignAssignlayer2/conv2d/kernel/layer2/conv2d/kernel/Initializer/random_uniform*
use_locking(*
T0*'
_class
loc:@layer2/conv2d/kernel*
validate_shape(*&
_output_shapes
: @
?
layer2/conv2d/kernel/readIdentitylayer2/conv2d/kernel*
T0*'
_class
loc:@layer2/conv2d/kernel*&
_output_shapes
: @
?
$layer2/conv2d/bias/Initializer/zerosConst*
dtype0*
_output_shapes
:@*
valueB@*    *%
_class
loc:@layer2/conv2d/bias
?
layer2/conv2d/bias
VariableV2*
shared_name *%
_class
loc:@layer2/conv2d/bias*
	container *
shape:@*
dtype0*
_output_shapes
:@
?
layer2/conv2d/bias/AssignAssignlayer2/conv2d/bias$layer2/conv2d/bias/Initializer/zeros*
T0*%
_class
loc:@layer2/conv2d/bias*
validate_shape(*
_output_shapes
:@*
use_locking(
?
layer2/conv2d/bias/readIdentitylayer2/conv2d/bias*
T0*%
_class
loc:@layer2/conv2d/bias*
_output_shapes
:@
l
layer2/conv2d/dilation_rateConst*
valueB"      *
dtype0*
_output_shapes
:
?
layer2/conv2d/Conv2DConv2Dlayer1/max_pooling2d/MaxPoollayer2/conv2d/kernel/read*
	dilations
*
T0*
data_formatNHWC*
strides
*
use_cudnn_on_gpu(*
explicit_paddings
 *
paddingVALID*/
_output_shapes
:?????????==@
?
layer2/conv2d/BiasAddBiasAddlayer2/conv2d/Conv2Dlayer2/conv2d/bias/read*
T0*
data_formatNHWC*/
_output_shapes
:?????????==@
k
layer2/conv2d/ReluRelulayer2/conv2d/BiasAdd*
T0*/
_output_shapes
:?????????==@
?
7layer2/conv2d_1/kernel/Initializer/random_uniform/shapeConst*%
valueB"      @   @   *)
_class
loc:@layer2/conv2d_1/kernel*
dtype0*
_output_shapes
:
?
5layer2/conv2d_1/kernel/Initializer/random_uniform/minConst*
valueB
 *:͓?*)
_class
loc:@layer2/conv2d_1/kernel*
dtype0*
_output_shapes
: 
?
5layer2/conv2d_1/kernel/Initializer/random_uniform/maxConst*
valueB
 *:͓=*)
_class
loc:@layer2/conv2d_1/kernel*
dtype0*
_output_shapes
: 
?
?layer2/conv2d_1/kernel/Initializer/random_uniform/RandomUniformRandomUniform7layer2/conv2d_1/kernel/Initializer/random_uniform/shape*
dtype0*&
_output_shapes
:@@*

seed *
T0*)
_class
loc:@layer2/conv2d_1/kernel*
seed2 
?
5layer2/conv2d_1/kernel/Initializer/random_uniform/subSub5layer2/conv2d_1/kernel/Initializer/random_uniform/max5layer2/conv2d_1/kernel/Initializer/random_uniform/min*
T0*)
_class
loc:@layer2/conv2d_1/kernel*
_output_shapes
: 
?
5layer2/conv2d_1/kernel/Initializer/random_uniform/mulMul?layer2/conv2d_1/kernel/Initializer/random_uniform/RandomUniform5layer2/conv2d_1/kernel/Initializer/random_uniform/sub*
T0*)
_class
loc:@layer2/conv2d_1/kernel*&
_output_shapes
:@@
?
1layer2/conv2d_1/kernel/Initializer/random_uniformAdd5layer2/conv2d_1/kernel/Initializer/random_uniform/mul5layer2/conv2d_1/kernel/Initializer/random_uniform/min*
T0*)
_class
loc:@layer2/conv2d_1/kernel*&
_output_shapes
:@@
?
layer2/conv2d_1/kernel
VariableV2*
shared_name *)
_class
loc:@layer2/conv2d_1/kernel*
	container *
shape:@@*
dtype0*&
_output_shapes
:@@
?
layer2/conv2d_1/kernel/AssignAssignlayer2/conv2d_1/kernel1layer2/conv2d_1/kernel/Initializer/random_uniform*
T0*)
_class
loc:@layer2/conv2d_1/kernel*
validate_shape(*&
_output_shapes
:@@*
use_locking(
?
layer2/conv2d_1/kernel/readIdentitylayer2/conv2d_1/kernel*
T0*)
_class
loc:@layer2/conv2d_1/kernel*&
_output_shapes
:@@
?
&layer2/conv2d_1/bias/Initializer/zerosConst*
dtype0*
_output_shapes
:@*
valueB@*    *'
_class
loc:@layer2/conv2d_1/bias
?
layer2/conv2d_1/bias
VariableV2*
dtype0*
_output_shapes
:@*
shared_name *'
_class
loc:@layer2/conv2d_1/bias*
	container *
shape:@
?
layer2/conv2d_1/bias/AssignAssignlayer2/conv2d_1/bias&layer2/conv2d_1/bias/Initializer/zeros*
use_locking(*
T0*'
_class
loc:@layer2/conv2d_1/bias*
validate_shape(*
_output_shapes
:@
?
layer2/conv2d_1/bias/readIdentitylayer2/conv2d_1/bias*
T0*'
_class
loc:@layer2/conv2d_1/bias*
_output_shapes
:@
n
layer2/conv2d_1/dilation_rateConst*
dtype0*
_output_shapes
:*
valueB"      
?
layer2/conv2d_1/Conv2DConv2Dlayer2/conv2d/Relulayer2/conv2d_1/kernel/read*
T0*
data_formatNHWC*
strides
*
explicit_paddings
 *
use_cudnn_on_gpu(*
paddingVALID*/
_output_shapes
:?????????;;@*
	dilations

?
layer2/conv2d_1/BiasAddBiasAddlayer2/conv2d_1/Conv2Dlayer2/conv2d_1/bias/read*
T0*
data_formatNHWC*/
_output_shapes
:?????????;;@
o
layer2/conv2d_1/ReluRelulayer2/conv2d_1/BiasAdd*
T0*/
_output_shapes
:?????????;;@
?
layer2/max_pooling2d/MaxPoolMaxPoollayer2/conv2d_1/Relu*
T0*
strides
*
data_formatNHWC*
ksize
*
paddingVALID*/
_output_shapes
:?????????@
?
5layer3/conv2d/kernel/Initializer/random_uniform/shapeConst*%
valueB"      @   @   *'
_class
loc:@layer3/conv2d/kernel*
dtype0*
_output_shapes
:
?
3layer3/conv2d/kernel/Initializer/random_uniform/minConst*
valueB
 *:͓?*'
_class
loc:@layer3/conv2d/kernel*
dtype0*
_output_shapes
: 
?
3layer3/conv2d/kernel/Initializer/random_uniform/maxConst*
valueB
 *:͓=*'
_class
loc:@layer3/conv2d/kernel*
dtype0*
_output_shapes
: 
?
=layer3/conv2d/kernel/Initializer/random_uniform/RandomUniformRandomUniform5layer3/conv2d/kernel/Initializer/random_uniform/shape*

seed *
T0*'
_class
loc:@layer3/conv2d/kernel*
seed2 *
dtype0*&
_output_shapes
:@@
?
3layer3/conv2d/kernel/Initializer/random_uniform/subSub3layer3/conv2d/kernel/Initializer/random_uniform/max3layer3/conv2d/kernel/Initializer/random_uniform/min*
T0*'
_class
loc:@layer3/conv2d/kernel*
_output_shapes
: 
?
3layer3/conv2d/kernel/Initializer/random_uniform/mulMul=layer3/conv2d/kernel/Initializer/random_uniform/RandomUniform3layer3/conv2d/kernel/Initializer/random_uniform/sub*
T0*'
_class
loc:@layer3/conv2d/kernel*&
_output_shapes
:@@
?
/layer3/conv2d/kernel/Initializer/random_uniformAdd3layer3/conv2d/kernel/Initializer/random_uniform/mul3layer3/conv2d/kernel/Initializer/random_uniform/min*
T0*'
_class
loc:@layer3/conv2d/kernel*&
_output_shapes
:@@
?
layer3/conv2d/kernel
VariableV2*
shared_name *'
_class
loc:@layer3/conv2d/kernel*
	container *
shape:@@*
dtype0*&
_output_shapes
:@@
?
layer3/conv2d/kernel/AssignAssignlayer3/conv2d/kernel/layer3/conv2d/kernel/Initializer/random_uniform*
use_locking(*
T0*'
_class
loc:@layer3/conv2d/kernel*
validate_shape(*&
_output_shapes
:@@
?
layer3/conv2d/kernel/readIdentitylayer3/conv2d/kernel*
T0*'
_class
loc:@layer3/conv2d/kernel*&
_output_shapes
:@@
?
$layer3/conv2d/bias/Initializer/zerosConst*
valueB@*    *%
_class
loc:@layer3/conv2d/bias*
dtype0*
_output_shapes
:@
?
layer3/conv2d/bias
VariableV2*
	container *
shape:@*
dtype0*
_output_shapes
:@*
shared_name *%
_class
loc:@layer3/conv2d/bias
?
layer3/conv2d/bias/AssignAssignlayer3/conv2d/bias$layer3/conv2d/bias/Initializer/zeros*
T0*%
_class
loc:@layer3/conv2d/bias*
validate_shape(*
_output_shapes
:@*
use_locking(
?
layer3/conv2d/bias/readIdentitylayer3/conv2d/bias*
T0*%
_class
loc:@layer3/conv2d/bias*
_output_shapes
:@
l
layer3/conv2d/dilation_rateConst*
valueB"      *
dtype0*
_output_shapes
:
?
layer3/conv2d/Conv2DConv2Dlayer2/max_pooling2d/MaxPoollayer3/conv2d/kernel/read*
paddingVALID*/
_output_shapes
:?????????@*
	dilations
*
T0*
data_formatNHWC*
strides
*
use_cudnn_on_gpu(*
explicit_paddings
 
?
layer3/conv2d/BiasAddBiasAddlayer3/conv2d/Conv2Dlayer3/conv2d/bias/read*
T0*
data_formatNHWC*/
_output_shapes
:?????????@
k
layer3/conv2d/ReluRelulayer3/conv2d/BiasAdd*
T0*/
_output_shapes
:?????????@
?
7layer3/conv2d_1/kernel/Initializer/random_uniform/shapeConst*%
valueB"      @   @   *)
_class
loc:@layer3/conv2d_1/kernel*
dtype0*
_output_shapes
:
?
5layer3/conv2d_1/kernel/Initializer/random_uniform/minConst*
valueB
 *:͓?*)
_class
loc:@layer3/conv2d_1/kernel*
dtype0*
_output_shapes
: 
?
5layer3/conv2d_1/kernel/Initializer/random_uniform/maxConst*
dtype0*
_output_shapes
: *
valueB
 *:͓=*)
_class
loc:@layer3/conv2d_1/kernel
?
?layer3/conv2d_1/kernel/Initializer/random_uniform/RandomUniformRandomUniform7layer3/conv2d_1/kernel/Initializer/random_uniform/shape*
dtype0*&
_output_shapes
:@@*

seed *
T0*)
_class
loc:@layer3/conv2d_1/kernel*
seed2 
?
5layer3/conv2d_1/kernel/Initializer/random_uniform/subSub5layer3/conv2d_1/kernel/Initializer/random_uniform/max5layer3/conv2d_1/kernel/Initializer/random_uniform/min*
_output_shapes
: *
T0*)
_class
loc:@layer3/conv2d_1/kernel
?
5layer3/conv2d_1/kernel/Initializer/random_uniform/mulMul?layer3/conv2d_1/kernel/Initializer/random_uniform/RandomUniform5layer3/conv2d_1/kernel/Initializer/random_uniform/sub*&
_output_shapes
:@@*
T0*)
_class
loc:@layer3/conv2d_1/kernel
?
1layer3/conv2d_1/kernel/Initializer/random_uniformAdd5layer3/conv2d_1/kernel/Initializer/random_uniform/mul5layer3/conv2d_1/kernel/Initializer/random_uniform/min*
T0*)
_class
loc:@layer3/conv2d_1/kernel*&
_output_shapes
:@@
?
layer3/conv2d_1/kernel
VariableV2*
dtype0*&
_output_shapes
:@@*
shared_name *)
_class
loc:@layer3/conv2d_1/kernel*
	container *
shape:@@
?
layer3/conv2d_1/kernel/AssignAssignlayer3/conv2d_1/kernel1layer3/conv2d_1/kernel/Initializer/random_uniform*
validate_shape(*&
_output_shapes
:@@*
use_locking(*
T0*)
_class
loc:@layer3/conv2d_1/kernel
?
layer3/conv2d_1/kernel/readIdentitylayer3/conv2d_1/kernel*
T0*)
_class
loc:@layer3/conv2d_1/kernel*&
_output_shapes
:@@
?
&layer3/conv2d_1/bias/Initializer/zerosConst*
valueB@*    *'
_class
loc:@layer3/conv2d_1/bias*
dtype0*
_output_shapes
:@
?
layer3/conv2d_1/bias
VariableV2*
dtype0*
_output_shapes
:@*
shared_name *'
_class
loc:@layer3/conv2d_1/bias*
	container *
shape:@
?
layer3/conv2d_1/bias/AssignAssignlayer3/conv2d_1/bias&layer3/conv2d_1/bias/Initializer/zeros*
use_locking(*
T0*'
_class
loc:@layer3/conv2d_1/bias*
validate_shape(*
_output_shapes
:@
?
layer3/conv2d_1/bias/readIdentitylayer3/conv2d_1/bias*
T0*'
_class
loc:@layer3/conv2d_1/bias*
_output_shapes
:@
n
layer3/conv2d_1/dilation_rateConst*
dtype0*
_output_shapes
:*
valueB"      
?
layer3/conv2d_1/Conv2DConv2Dlayer3/conv2d/Relulayer3/conv2d_1/kernel/read*
paddingVALID*/
_output_shapes
:?????????@*
	dilations
*
T0*
data_formatNHWC*
strides
*
explicit_paddings
 *
use_cudnn_on_gpu(
?
layer3/conv2d_1/BiasAddBiasAddlayer3/conv2d_1/Conv2Dlayer3/conv2d_1/bias/read*
data_formatNHWC*/
_output_shapes
:?????????@*
T0
o
layer3/conv2d_1/ReluRelulayer3/conv2d_1/BiasAdd*
T0*/
_output_shapes
:?????????@
?
layer3/max_pooling2d/MaxPoolMaxPoollayer3/conv2d_1/Relu*
T0*
strides
*
data_formatNHWC*
ksize
*
paddingVALID*/
_output_shapes
:?????????@
?
5layer4/conv2d/kernel/Initializer/random_uniform/shapeConst*%
valueB"      @   ?   *'
_class
loc:@layer4/conv2d/kernel*
dtype0*
_output_shapes
:
?
3layer4/conv2d/kernel/Initializer/random_uniform/minConst*
valueB
 *?[q?*'
_class
loc:@layer4/conv2d/kernel*
dtype0*
_output_shapes
: 
?
3layer4/conv2d/kernel/Initializer/random_uniform/maxConst*
valueB
 *?[q=*'
_class
loc:@layer4/conv2d/kernel*
dtype0*
_output_shapes
: 
?
=layer4/conv2d/kernel/Initializer/random_uniform/RandomUniformRandomUniform5layer4/conv2d/kernel/Initializer/random_uniform/shape*
dtype0*'
_output_shapes
:@?*

seed *
T0*'
_class
loc:@layer4/conv2d/kernel*
seed2 
?
3layer4/conv2d/kernel/Initializer/random_uniform/subSub3layer4/conv2d/kernel/Initializer/random_uniform/max3layer4/conv2d/kernel/Initializer/random_uniform/min*
T0*'
_class
loc:@layer4/conv2d/kernel*
_output_shapes
: 
?
3layer4/conv2d/kernel/Initializer/random_uniform/mulMul=layer4/conv2d/kernel/Initializer/random_uniform/RandomUniform3layer4/conv2d/kernel/Initializer/random_uniform/sub*'
_output_shapes
:@?*
T0*'
_class
loc:@layer4/conv2d/kernel
?
/layer4/conv2d/kernel/Initializer/random_uniformAdd3layer4/conv2d/kernel/Initializer/random_uniform/mul3layer4/conv2d/kernel/Initializer/random_uniform/min*
T0*'
_class
loc:@layer4/conv2d/kernel*'
_output_shapes
:@?
?
layer4/conv2d/kernel
VariableV2*
	container *
shape:@?*
dtype0*'
_output_shapes
:@?*
shared_name *'
_class
loc:@layer4/conv2d/kernel
?
layer4/conv2d/kernel/AssignAssignlayer4/conv2d/kernel/layer4/conv2d/kernel/Initializer/random_uniform*
T0*'
_class
loc:@layer4/conv2d/kernel*
validate_shape(*'
_output_shapes
:@?*
use_locking(
?
layer4/conv2d/kernel/readIdentitylayer4/conv2d/kernel*
T0*'
_class
loc:@layer4/conv2d/kernel*'
_output_shapes
:@?
?
$layer4/conv2d/bias/Initializer/zerosConst*
valueB?*    *%
_class
loc:@layer4/conv2d/bias*
dtype0*
_output_shapes	
:?
?
layer4/conv2d/bias
VariableV2*%
_class
loc:@layer4/conv2d/bias*
	container *
shape:?*
dtype0*
_output_shapes	
:?*
shared_name 
?
layer4/conv2d/bias/AssignAssignlayer4/conv2d/bias$layer4/conv2d/bias/Initializer/zeros*
validate_shape(*
_output_shapes	
:?*
use_locking(*
T0*%
_class
loc:@layer4/conv2d/bias
?
layer4/conv2d/bias/readIdentitylayer4/conv2d/bias*
T0*%
_class
loc:@layer4/conv2d/bias*
_output_shapes	
:?
l
layer4/conv2d/dilation_rateConst*
valueB"      *
dtype0*
_output_shapes
:
?
layer4/conv2d/Conv2DConv2Dlayer3/max_pooling2d/MaxPoollayer4/conv2d/kernel/read*
T0*
data_formatNHWC*
strides
*
use_cudnn_on_gpu(*
explicit_paddings
 *
paddingVALID*0
_output_shapes
:?????????

?*
	dilations

?
layer4/conv2d/BiasAddBiasAddlayer4/conv2d/Conv2Dlayer4/conv2d/bias/read*
data_formatNHWC*0
_output_shapes
:?????????

?*
T0
l
layer4/conv2d/ReluRelulayer4/conv2d/BiasAdd*
T0*0
_output_shapes
:?????????

?
?
7layer4/conv2d_1/kernel/Initializer/random_uniform/shapeConst*%
valueB"      ?   ?   *)
_class
loc:@layer4/conv2d_1/kernel*
dtype0*
_output_shapes
:
?
5layer4/conv2d_1/kernel/Initializer/random_uniform/minConst*
valueB
 *?Q?*)
_class
loc:@layer4/conv2d_1/kernel*
dtype0*
_output_shapes
: 
?
5layer4/conv2d_1/kernel/Initializer/random_uniform/maxConst*
dtype0*
_output_shapes
: *
valueB
 *?Q=*)
_class
loc:@layer4/conv2d_1/kernel
?
?layer4/conv2d_1/kernel/Initializer/random_uniform/RandomUniformRandomUniform7layer4/conv2d_1/kernel/Initializer/random_uniform/shape*

seed *
T0*)
_class
loc:@layer4/conv2d_1/kernel*
seed2 *
dtype0*(
_output_shapes
:??
?
5layer4/conv2d_1/kernel/Initializer/random_uniform/subSub5layer4/conv2d_1/kernel/Initializer/random_uniform/max5layer4/conv2d_1/kernel/Initializer/random_uniform/min*
T0*)
_class
loc:@layer4/conv2d_1/kernel*
_output_shapes
: 
?
5layer4/conv2d_1/kernel/Initializer/random_uniform/mulMul?layer4/conv2d_1/kernel/Initializer/random_uniform/RandomUniform5layer4/conv2d_1/kernel/Initializer/random_uniform/sub*
T0*)
_class
loc:@layer4/conv2d_1/kernel*(
_output_shapes
:??
?
1layer4/conv2d_1/kernel/Initializer/random_uniformAdd5layer4/conv2d_1/kernel/Initializer/random_uniform/mul5layer4/conv2d_1/kernel/Initializer/random_uniform/min*(
_output_shapes
:??*
T0*)
_class
loc:@layer4/conv2d_1/kernel
?
layer4/conv2d_1/kernel
VariableV2*
	container *
shape:??*
dtype0*(
_output_shapes
:??*
shared_name *)
_class
loc:@layer4/conv2d_1/kernel
?
layer4/conv2d_1/kernel/AssignAssignlayer4/conv2d_1/kernel1layer4/conv2d_1/kernel/Initializer/random_uniform*
use_locking(*
T0*)
_class
loc:@layer4/conv2d_1/kernel*
validate_shape(*(
_output_shapes
:??
?
layer4/conv2d_1/kernel/readIdentitylayer4/conv2d_1/kernel*(
_output_shapes
:??*
T0*)
_class
loc:@layer4/conv2d_1/kernel
?
&layer4/conv2d_1/bias/Initializer/zerosConst*
dtype0*
_output_shapes	
:?*
valueB?*    *'
_class
loc:@layer4/conv2d_1/bias
?
layer4/conv2d_1/bias
VariableV2*
	container *
shape:?*
dtype0*
_output_shapes	
:?*
shared_name *'
_class
loc:@layer4/conv2d_1/bias
?
layer4/conv2d_1/bias/AssignAssignlayer4/conv2d_1/bias&layer4/conv2d_1/bias/Initializer/zeros*
use_locking(*
T0*'
_class
loc:@layer4/conv2d_1/bias*
validate_shape(*
_output_shapes	
:?
?
layer4/conv2d_1/bias/readIdentitylayer4/conv2d_1/bias*
_output_shapes	
:?*
T0*'
_class
loc:@layer4/conv2d_1/bias
n
layer4/conv2d_1/dilation_rateConst*
valueB"      *
dtype0*
_output_shapes
:
?
layer4/conv2d_1/Conv2DConv2Dlayer4/conv2d/Relulayer4/conv2d_1/kernel/read*0
_output_shapes
:??????????*
	dilations
*
T0*
data_formatNHWC*
strides
*
explicit_paddings
 *
use_cudnn_on_gpu(*
paddingVALID
?
layer4/conv2d_1/BiasAddBiasAddlayer4/conv2d_1/Conv2Dlayer4/conv2d_1/bias/read*
T0*
data_formatNHWC*0
_output_shapes
:??????????
p
layer4/conv2d_1/ReluRelulayer4/conv2d_1/BiasAdd*
T0*0
_output_shapes
:??????????
?
layer4/max_pooling2d/MaxPoolMaxPoollayer4/conv2d_1/Relu*0
_output_shapes
:??????????*
T0*
strides
*
data_formatNHWC*
ksize
*
paddingVALID
?
5layer5/conv2d/kernel/Initializer/random_uniform/shapeConst*
dtype0*
_output_shapes
:*%
valueB"      ?      *'
_class
loc:@layer5/conv2d/kernel
?
3layer5/conv2d/kernel/Initializer/random_uniform/minConst*
valueB
 *??*?*'
_class
loc:@layer5/conv2d/kernel*
dtype0*
_output_shapes
: 
?
3layer5/conv2d/kernel/Initializer/random_uniform/maxConst*
dtype0*
_output_shapes
: *
valueB
 *??*=*'
_class
loc:@layer5/conv2d/kernel
?
=layer5/conv2d/kernel/Initializer/random_uniform/RandomUniformRandomUniform5layer5/conv2d/kernel/Initializer/random_uniform/shape*
dtype0*(
_output_shapes
:??*

seed *
T0*'
_class
loc:@layer5/conv2d/kernel*
seed2 
?
3layer5/conv2d/kernel/Initializer/random_uniform/subSub3layer5/conv2d/kernel/Initializer/random_uniform/max3layer5/conv2d/kernel/Initializer/random_uniform/min*
_output_shapes
: *
T0*'
_class
loc:@layer5/conv2d/kernel
?
3layer5/conv2d/kernel/Initializer/random_uniform/mulMul=layer5/conv2d/kernel/Initializer/random_uniform/RandomUniform3layer5/conv2d/kernel/Initializer/random_uniform/sub*(
_output_shapes
:??*
T0*'
_class
loc:@layer5/conv2d/kernel
?
/layer5/conv2d/kernel/Initializer/random_uniformAdd3layer5/conv2d/kernel/Initializer/random_uniform/mul3layer5/conv2d/kernel/Initializer/random_uniform/min*(
_output_shapes
:??*
T0*'
_class
loc:@layer5/conv2d/kernel
?
layer5/conv2d/kernel
VariableV2*
shape:??*
dtype0*(
_output_shapes
:??*
shared_name *'
_class
loc:@layer5/conv2d/kernel*
	container 
?
layer5/conv2d/kernel/AssignAssignlayer5/conv2d/kernel/layer5/conv2d/kernel/Initializer/random_uniform*
validate_shape(*(
_output_shapes
:??*
use_locking(*
T0*'
_class
loc:@layer5/conv2d/kernel
?
layer5/conv2d/kernel/readIdentitylayer5/conv2d/kernel*
T0*'
_class
loc:@layer5/conv2d/kernel*(
_output_shapes
:??
?
$layer5/conv2d/bias/Initializer/zerosConst*
valueB?*    *%
_class
loc:@layer5/conv2d/bias*
dtype0*
_output_shapes	
:?
?
layer5/conv2d/bias
VariableV2*
shared_name *%
_class
loc:@layer5/conv2d/bias*
	container *
shape:?*
dtype0*
_output_shapes	
:?
?
layer5/conv2d/bias/AssignAssignlayer5/conv2d/bias$layer5/conv2d/bias/Initializer/zeros*
validate_shape(*
_output_shapes	
:?*
use_locking(*
T0*%
_class
loc:@layer5/conv2d/bias
?
layer5/conv2d/bias/readIdentitylayer5/conv2d/bias*
_output_shapes	
:?*
T0*%
_class
loc:@layer5/conv2d/bias
l
layer5/conv2d/dilation_rateConst*
valueB"      *
dtype0*
_output_shapes
:
?
layer5/conv2d/Conv2DConv2Dlayer4/max_pooling2d/MaxPoollayer5/conv2d/kernel/read*
	dilations
*
T0*
data_formatNHWC*
strides
*
explicit_paddings
 *
use_cudnn_on_gpu(*
paddingVALID*0
_output_shapes
:??????????
?
layer5/conv2d/BiasAddBiasAddlayer5/conv2d/Conv2Dlayer5/conv2d/bias/read*
T0*
data_formatNHWC*0
_output_shapes
:??????????
l
layer5/conv2d/ReluRelulayer5/conv2d/BiasAdd*
T0*0
_output_shapes
:??????????
f
layer6/flatten/ShapeShapelayer5/conv2d/Relu*
_output_shapes
:*
T0*
out_type0
l
"layer6/flatten/strided_slice/stackConst*
valueB: *
dtype0*
_output_shapes
:
n
$layer6/flatten/strided_slice/stack_1Const*
valueB:*
dtype0*
_output_shapes
:
n
$layer6/flatten/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
?
layer6/flatten/strided_sliceStridedSlicelayer6/flatten/Shape"layer6/flatten/strided_slice/stack$layer6/flatten/strided_slice/stack_1$layer6/flatten/strided_slice/stack_2*
end_mask *
_output_shapes
: *
Index0*
T0*
shrink_axis_mask*
ellipsis_mask *

begin_mask *
new_axis_mask 
i
layer6/flatten/Reshape/shape/1Const*
valueB :
?????????*
dtype0*
_output_shapes
: 
?
layer6/flatten/Reshape/shapePacklayer6/flatten/strided_slicelayer6/flatten/Reshape/shape/1*
T0*

axis *
N*
_output_shapes
:
?
layer6/flatten/ReshapeReshapelayer5/conv2d/Relulayer6/flatten/Reshape/shape*
T0*
Tshape0*(
_output_shapes
:??????????2
?
4layer6/dense/kernel/Initializer/random_uniform/shapeConst*
dtype0*
_output_shapes
:*
valueB"      *&
_class
loc:@layer6/dense/kernel
?
2layer6/dense/kernel/Initializer/random_uniform/minConst*
valueB
 *B???*&
_class
loc:@layer6/dense/kernel*
dtype0*
_output_shapes
: 
?
2layer6/dense/kernel/Initializer/random_uniform/maxConst*
valueB
 *B??<*&
_class
loc:@layer6/dense/kernel*
dtype0*
_output_shapes
: 
?
<layer6/dense/kernel/Initializer/random_uniform/RandomUniformRandomUniform4layer6/dense/kernel/Initializer/random_uniform/shape*
dtype0* 
_output_shapes
:
?2?*

seed *
T0*&
_class
loc:@layer6/dense/kernel*
seed2 
?
2layer6/dense/kernel/Initializer/random_uniform/subSub2layer6/dense/kernel/Initializer/random_uniform/max2layer6/dense/kernel/Initializer/random_uniform/min*
T0*&
_class
loc:@layer6/dense/kernel*
_output_shapes
: 
?
2layer6/dense/kernel/Initializer/random_uniform/mulMul<layer6/dense/kernel/Initializer/random_uniform/RandomUniform2layer6/dense/kernel/Initializer/random_uniform/sub* 
_output_shapes
:
?2?*
T0*&
_class
loc:@layer6/dense/kernel
?
.layer6/dense/kernel/Initializer/random_uniformAdd2layer6/dense/kernel/Initializer/random_uniform/mul2layer6/dense/kernel/Initializer/random_uniform/min*
T0*&
_class
loc:@layer6/dense/kernel* 
_output_shapes
:
?2?
?
layer6/dense/kernel
VariableV2*
shape:
?2?*
dtype0* 
_output_shapes
:
?2?*
shared_name *&
_class
loc:@layer6/dense/kernel*
	container 
?
layer6/dense/kernel/AssignAssignlayer6/dense/kernel.layer6/dense/kernel/Initializer/random_uniform*
use_locking(*
T0*&
_class
loc:@layer6/dense/kernel*
validate_shape(* 
_output_shapes
:
?2?
?
layer6/dense/kernel/readIdentitylayer6/dense/kernel*
T0*&
_class
loc:@layer6/dense/kernel* 
_output_shapes
:
?2?
?
3layer6/dense/bias/Initializer/zeros/shape_as_tensorConst*
valueB:?*$
_class
loc:@layer6/dense/bias*
dtype0*
_output_shapes
:
?
)layer6/dense/bias/Initializer/zeros/ConstConst*
valueB
 *    *$
_class
loc:@layer6/dense/bias*
dtype0*
_output_shapes
: 
?
#layer6/dense/bias/Initializer/zerosFill3layer6/dense/bias/Initializer/zeros/shape_as_tensor)layer6/dense/bias/Initializer/zeros/Const*
_output_shapes	
:?*
T0*

index_type0*$
_class
loc:@layer6/dense/bias
?
layer6/dense/bias
VariableV2*
dtype0*
_output_shapes	
:?*
shared_name *$
_class
loc:@layer6/dense/bias*
	container *
shape:?
?
layer6/dense/bias/AssignAssignlayer6/dense/bias#layer6/dense/bias/Initializer/zeros*
use_locking(*
T0*$
_class
loc:@layer6/dense/bias*
validate_shape(*
_output_shapes	
:?
?
layer6/dense/bias/readIdentitylayer6/dense/bias*
T0*$
_class
loc:@layer6/dense/bias*
_output_shapes	
:?
?
layer6/dense/MatMulMatMullayer6/flatten/Reshapelayer6/dense/kernel/read*(
_output_shapes
:??????????*
transpose_a( *
transpose_b( *
T0
?
layer6/dense/BiasAddBiasAddlayer6/dense/MatMullayer6/dense/bias/read*
T0*
data_formatNHWC*(
_output_shapes
:??????????
b
layer6/dense/ReluRelulayer6/dense/BiasAdd*
T0*(
_output_shapes
:??????????
?
5layer6/logits/kernel/Initializer/random_uniform/shapeConst*
valueB"   ?   *'
_class
loc:@layer6/logits/kernel*
dtype0*
_output_shapes
:
?
3layer6/logits/kernel/Initializer/random_uniform/minConst*
valueB
 *?J??*'
_class
loc:@layer6/logits/kernel*
dtype0*
_output_shapes
: 
?
3layer6/logits/kernel/Initializer/random_uniform/maxConst*
dtype0*
_output_shapes
: *
valueB
 *?J?=*'
_class
loc:@layer6/logits/kernel
?
=layer6/logits/kernel/Initializer/random_uniform/RandomUniformRandomUniform5layer6/logits/kernel/Initializer/random_uniform/shape*
seed2 *
dtype0* 
_output_shapes
:
??*

seed *
T0*'
_class
loc:@layer6/logits/kernel
?
3layer6/logits/kernel/Initializer/random_uniform/subSub3layer6/logits/kernel/Initializer/random_uniform/max3layer6/logits/kernel/Initializer/random_uniform/min*
T0*'
_class
loc:@layer6/logits/kernel*
_output_shapes
: 
?
3layer6/logits/kernel/Initializer/random_uniform/mulMul=layer6/logits/kernel/Initializer/random_uniform/RandomUniform3layer6/logits/kernel/Initializer/random_uniform/sub* 
_output_shapes
:
??*
T0*'
_class
loc:@layer6/logits/kernel
?
/layer6/logits/kernel/Initializer/random_uniformAdd3layer6/logits/kernel/Initializer/random_uniform/mul3layer6/logits/kernel/Initializer/random_uniform/min*
T0*'
_class
loc:@layer6/logits/kernel* 
_output_shapes
:
??
?
layer6/logits/kernel
VariableV2*
shape:
??*
dtype0* 
_output_shapes
:
??*
shared_name *'
_class
loc:@layer6/logits/kernel*
	container 
?
layer6/logits/kernel/AssignAssignlayer6/logits/kernel/layer6/logits/kernel/Initializer/random_uniform*
validate_shape(* 
_output_shapes
:
??*
use_locking(*
T0*'
_class
loc:@layer6/logits/kernel
?
layer6/logits/kernel/readIdentitylayer6/logits/kernel*
T0*'
_class
loc:@layer6/logits/kernel* 
_output_shapes
:
??
?
$layer6/logits/bias/Initializer/zerosConst*
dtype0*
_output_shapes	
:?*
valueB?*    *%
_class
loc:@layer6/logits/bias
?
layer6/logits/bias
VariableV2*%
_class
loc:@layer6/logits/bias*
	container *
shape:?*
dtype0*
_output_shapes	
:?*
shared_name 
?
layer6/logits/bias/AssignAssignlayer6/logits/bias$layer6/logits/bias/Initializer/zeros*
use_locking(*
T0*%
_class
loc:@layer6/logits/bias*
validate_shape(*
_output_shapes	
:?
?
layer6/logits/bias/readIdentitylayer6/logits/bias*
T0*%
_class
loc:@layer6/logits/bias*
_output_shapes	
:?
?
layer6/logits/MatMulMatMullayer6/dense/Relulayer6/logits/kernel/read*
T0*(
_output_shapes
:??????????*
transpose_a( *
transpose_b( 
?
layer6/logits/BiasAddBiasAddlayer6/logits/MatMullayer6/logits/bias/read*
T0*
data_formatNHWC*(
_output_shapes
:??????????
h
layer6/final_denseIdentitylayer6/logits/BiasAdd*
T0*(
_output_shapes
:??????????

initNoOp

init_all_tablesNoOp

init_1NoOp
4

group_depsNoOp^init^init_1^init_all_tables
Y
save/filename/inputConst*
valueB Bmodel*
dtype0*
_output_shapes
: 
n
save/filenamePlaceholderWithDefaultsave/filename/input*
dtype0*
_output_shapes
: *
shape: 
e

save/ConstPlaceholderWithDefaultsave/filename*
dtype0*
_output_shapes
: *
shape: 
?
save/StringJoin/inputs_1Const*<
value3B1 B+_temp_a811f0739fd54d8997140aa46ea6f1d2/part*
dtype0*
_output_shapes
: 
u
save/StringJoin
StringJoin
save/Constsave/StringJoin/inputs_1*
N*
_output_shapes
: *
	separator 
Q
save/num_shardsConst*
value	B :*
dtype0*
_output_shapes
: 
k
save/ShardedFilename/shardConst"/device:CPU:0*
value	B : *
dtype0*
_output_shapes
: 
?
save/ShardedFilenameShardedFilenamesave/StringJoinsave/ShardedFilename/shardsave/num_shards"/device:CPU:0*
_output_shapes
: 
?
save/SaveV2/tensor_namesConst"/device:CPU:0*?
value?B?Bglobal_stepBlayer1/conv2d/biasBlayer1/conv2d/kernelBlayer2/conv2d/biasBlayer2/conv2d/kernelBlayer2/conv2d_1/biasBlayer2/conv2d_1/kernelBlayer3/conv2d/biasBlayer3/conv2d/kernelBlayer3/conv2d_1/biasBlayer3/conv2d_1/kernelBlayer4/conv2d/biasBlayer4/conv2d/kernelBlayer4/conv2d_1/biasBlayer4/conv2d_1/kernelBlayer5/conv2d/biasBlayer5/conv2d/kernelBlayer6/dense/biasBlayer6/dense/kernelBlayer6/logits/biasBlayer6/logits/kernel*
dtype0*
_output_shapes
:
?
save/SaveV2/shape_and_slicesConst"/device:CPU:0*=
value4B2B B B B B B B B B B B B B B B B B B B B B *
dtype0*
_output_shapes
:
?
save/SaveV2SaveV2save/ShardedFilenamesave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesglobal_steplayer1/conv2d/biaslayer1/conv2d/kernellayer2/conv2d/biaslayer2/conv2d/kernellayer2/conv2d_1/biaslayer2/conv2d_1/kernellayer3/conv2d/biaslayer3/conv2d/kernellayer3/conv2d_1/biaslayer3/conv2d_1/kernellayer4/conv2d/biaslayer4/conv2d/kernellayer4/conv2d_1/biaslayer4/conv2d_1/kernellayer5/conv2d/biaslayer5/conv2d/kernellayer6/dense/biaslayer6/dense/kernellayer6/logits/biaslayer6/logits/kernel"/device:CPU:0*#
dtypes
2	
?
save/control_dependencyIdentitysave/ShardedFilename^save/SaveV2"/device:CPU:0*
T0*'
_class
loc:@save/ShardedFilename*
_output_shapes
: 
?
+save/MergeV2Checkpoints/checkpoint_prefixesPacksave/ShardedFilename^save/control_dependency"/device:CPU:0*
T0*

axis *
N*
_output_shapes
:
?
save/MergeV2CheckpointsMergeV2Checkpoints+save/MergeV2Checkpoints/checkpoint_prefixes
save/Const"/device:CPU:0*
delete_old_dirs(
?
save/IdentityIdentity
save/Const^save/MergeV2Checkpoints^save/control_dependency"/device:CPU:0*
_output_shapes
: *
T0
?
save/RestoreV2/tensor_namesConst"/device:CPU:0*
dtype0*
_output_shapes
:*?
value?B?Bglobal_stepBlayer1/conv2d/biasBlayer1/conv2d/kernelBlayer2/conv2d/biasBlayer2/conv2d/kernelBlayer2/conv2d_1/biasBlayer2/conv2d_1/kernelBlayer3/conv2d/biasBlayer3/conv2d/kernelBlayer3/conv2d_1/biasBlayer3/conv2d_1/kernelBlayer4/conv2d/biasBlayer4/conv2d/kernelBlayer4/conv2d_1/biasBlayer4/conv2d_1/kernelBlayer5/conv2d/biasBlayer5/conv2d/kernelBlayer6/dense/biasBlayer6/dense/kernelBlayer6/logits/biasBlayer6/logits/kernel
?
save/RestoreV2/shape_and_slicesConst"/device:CPU:0*=
value4B2B B B B B B B B B B B B B B B B B B B B B *
dtype0*
_output_shapes
:
?
save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices"/device:CPU:0*h
_output_shapesV
T:::::::::::::::::::::*#
dtypes
2	
?
save/AssignAssignglobal_stepsave/RestoreV2*
use_locking(*
T0	*
_class
loc:@global_step*
validate_shape(*
_output_shapes
: 
?
save/Assign_1Assignlayer1/conv2d/biassave/RestoreV2:1*
use_locking(*
T0*%
_class
loc:@layer1/conv2d/bias*
validate_shape(*
_output_shapes
: 
?
save/Assign_2Assignlayer1/conv2d/kernelsave/RestoreV2:2*
use_locking(*
T0*'
_class
loc:@layer1/conv2d/kernel*
validate_shape(*&
_output_shapes
: 
?
save/Assign_3Assignlayer2/conv2d/biassave/RestoreV2:3*
T0*%
_class
loc:@layer2/conv2d/bias*
validate_shape(*
_output_shapes
:@*
use_locking(
?
save/Assign_4Assignlayer2/conv2d/kernelsave/RestoreV2:4*
validate_shape(*&
_output_shapes
: @*
use_locking(*
T0*'
_class
loc:@layer2/conv2d/kernel
?
save/Assign_5Assignlayer2/conv2d_1/biassave/RestoreV2:5*
validate_shape(*
_output_shapes
:@*
use_locking(*
T0*'
_class
loc:@layer2/conv2d_1/bias
?
save/Assign_6Assignlayer2/conv2d_1/kernelsave/RestoreV2:6*
T0*)
_class
loc:@layer2/conv2d_1/kernel*
validate_shape(*&
_output_shapes
:@@*
use_locking(
?
save/Assign_7Assignlayer3/conv2d/biassave/RestoreV2:7*
use_locking(*
T0*%
_class
loc:@layer3/conv2d/bias*
validate_shape(*
_output_shapes
:@
?
save/Assign_8Assignlayer3/conv2d/kernelsave/RestoreV2:8*
validate_shape(*&
_output_shapes
:@@*
use_locking(*
T0*'
_class
loc:@layer3/conv2d/kernel
?
save/Assign_9Assignlayer3/conv2d_1/biassave/RestoreV2:9*
validate_shape(*
_output_shapes
:@*
use_locking(*
T0*'
_class
loc:@layer3/conv2d_1/bias
?
save/Assign_10Assignlayer3/conv2d_1/kernelsave/RestoreV2:10*
use_locking(*
T0*)
_class
loc:@layer3/conv2d_1/kernel*
validate_shape(*&
_output_shapes
:@@
?
save/Assign_11Assignlayer4/conv2d/biassave/RestoreV2:11*
use_locking(*
T0*%
_class
loc:@layer4/conv2d/bias*
validate_shape(*
_output_shapes	
:?
?
save/Assign_12Assignlayer4/conv2d/kernelsave/RestoreV2:12*
T0*'
_class
loc:@layer4/conv2d/kernel*
validate_shape(*'
_output_shapes
:@?*
use_locking(
?
save/Assign_13Assignlayer4/conv2d_1/biassave/RestoreV2:13*
use_locking(*
T0*'
_class
loc:@layer4/conv2d_1/bias*
validate_shape(*
_output_shapes	
:?
?
save/Assign_14Assignlayer4/conv2d_1/kernelsave/RestoreV2:14*
validate_shape(*(
_output_shapes
:??*
use_locking(*
T0*)
_class
loc:@layer4/conv2d_1/kernel
?
save/Assign_15Assignlayer5/conv2d/biassave/RestoreV2:15*
use_locking(*
T0*%
_class
loc:@layer5/conv2d/bias*
validate_shape(*
_output_shapes	
:?
?
save/Assign_16Assignlayer5/conv2d/kernelsave/RestoreV2:16*
validate_shape(*(
_output_shapes
:??*
use_locking(*
T0*'
_class
loc:@layer5/conv2d/kernel
?
save/Assign_17Assignlayer6/dense/biassave/RestoreV2:17*
use_locking(*
T0*$
_class
loc:@layer6/dense/bias*
validate_shape(*
_output_shapes	
:?
?
save/Assign_18Assignlayer6/dense/kernelsave/RestoreV2:18*
use_locking(*
T0*&
_class
loc:@layer6/dense/kernel*
validate_shape(* 
_output_shapes
:
?2?
?
save/Assign_19Assignlayer6/logits/biassave/RestoreV2:19*
validate_shape(*
_output_shapes	
:?*
use_locking(*
T0*%
_class
loc:@layer6/logits/bias
?
save/Assign_20Assignlayer6/logits/kernelsave/RestoreV2:20*
validate_shape(* 
_output_shapes
:
??*
use_locking(*
T0*'
_class
loc:@layer6/logits/kernel
?
save/restore_shardNoOp^save/Assign^save/Assign_1^save/Assign_10^save/Assign_11^save/Assign_12^save/Assign_13^save/Assign_14^save/Assign_15^save/Assign_16^save/Assign_17^save/Assign_18^save/Assign_19^save/Assign_2^save/Assign_20^save/Assign_3^save/Assign_4^save/Assign_5^save/Assign_6^save/Assign_7^save/Assign_8^save/Assign_9
-
save/restore_allNoOp^save/restore_shard"&<
save/Const:0save/Identity:0save/restore_all (5 @F8"?
trainable_variables??
?
layer1/conv2d/kernel:0layer1/conv2d/kernel/Assignlayer1/conv2d/kernel/read:021layer1/conv2d/kernel/Initializer/random_uniform:08
v
layer1/conv2d/bias:0layer1/conv2d/bias/Assignlayer1/conv2d/bias/read:02&layer1/conv2d/bias/Initializer/zeros:08
?
layer2/conv2d/kernel:0layer2/conv2d/kernel/Assignlayer2/conv2d/kernel/read:021layer2/conv2d/kernel/Initializer/random_uniform:08
v
layer2/conv2d/bias:0layer2/conv2d/bias/Assignlayer2/conv2d/bias/read:02&layer2/conv2d/bias/Initializer/zeros:08
?
layer2/conv2d_1/kernel:0layer2/conv2d_1/kernel/Assignlayer2/conv2d_1/kernel/read:023layer2/conv2d_1/kernel/Initializer/random_uniform:08
~
layer2/conv2d_1/bias:0layer2/conv2d_1/bias/Assignlayer2/conv2d_1/bias/read:02(layer2/conv2d_1/bias/Initializer/zeros:08
?
layer3/conv2d/kernel:0layer3/conv2d/kernel/Assignlayer3/conv2d/kernel/read:021layer3/conv2d/kernel/Initializer/random_uniform:08
v
layer3/conv2d/bias:0layer3/conv2d/bias/Assignlayer3/conv2d/bias/read:02&layer3/conv2d/bias/Initializer/zeros:08
?
layer3/conv2d_1/kernel:0layer3/conv2d_1/kernel/Assignlayer3/conv2d_1/kernel/read:023layer3/conv2d_1/kernel/Initializer/random_uniform:08
~
layer3/conv2d_1/bias:0layer3/conv2d_1/bias/Assignlayer3/conv2d_1/bias/read:02(layer3/conv2d_1/bias/Initializer/zeros:08
?
layer4/conv2d/kernel:0layer4/conv2d/kernel/Assignlayer4/conv2d/kernel/read:021layer4/conv2d/kernel/Initializer/random_uniform:08
v
layer4/conv2d/bias:0layer4/conv2d/bias/Assignlayer4/conv2d/bias/read:02&layer4/conv2d/bias/Initializer/zeros:08
?
layer4/conv2d_1/kernel:0layer4/conv2d_1/kernel/Assignlayer4/conv2d_1/kernel/read:023layer4/conv2d_1/kernel/Initializer/random_uniform:08
~
layer4/conv2d_1/bias:0layer4/conv2d_1/bias/Assignlayer4/conv2d_1/bias/read:02(layer4/conv2d_1/bias/Initializer/zeros:08
?
layer5/conv2d/kernel:0layer5/conv2d/kernel/Assignlayer5/conv2d/kernel/read:021layer5/conv2d/kernel/Initializer/random_uniform:08
v
layer5/conv2d/bias:0layer5/conv2d/bias/Assignlayer5/conv2d/bias/read:02&layer5/conv2d/bias/Initializer/zeros:08
?
layer6/dense/kernel:0layer6/dense/kernel/Assignlayer6/dense/kernel/read:020layer6/dense/kernel/Initializer/random_uniform:08
r
layer6/dense/bias:0layer6/dense/bias/Assignlayer6/dense/bias/read:02%layer6/dense/bias/Initializer/zeros:08
?
layer6/logits/kernel:0layer6/logits/kernel/Assignlayer6/logits/kernel/read:021layer6/logits/kernel/Initializer/random_uniform:08
v
layer6/logits/bias:0layer6/logits/bias/Assignlayer6/logits/bias/read:02&layer6/logits/bias/Initializer/zeros:08"m
global_step^\
Z
global_step:0global_step/Assignglobal_step/read:02global_step/Initializer/zeros:0H"%
saved_model_main_op


group_deps"?
while_context??
?
map/while/while_context
*map/while/LoopCond:02map/while/Merge:0:map/while/Identity:0Bmap/while/Exit:0Bmap/while/Exit_1:0Bmap/while/Exit_2:0J?
map/TensorArray:0
@map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3:0
map/TensorArray_1:0
map/strided_slice:0
map/while/Enter:0
map/while/Enter_1:0
map/while/Enter_2:0
map/while/Exit:0
map/while/Exit_1:0
map/while/Exit_2:0
map/while/Identity:0
map/while/Identity_1:0
map/while/Identity_2:0
map/while/Less/Enter:0
map/while/Less:0
map/while/Less_1:0
map/while/LogicalAnd:0
map/while/LoopCond:0
map/while/Merge:0
map/while/Merge:1
map/while/Merge_1:0
map/while/Merge_1:1
map/while/Merge_2:0
map/while/Merge_2:1
map/while/NextIteration:0
map/while/NextIteration_1:0
map/while/NextIteration_2:0
map/while/Switch:0
map/while/Switch:1
map/while/Switch_1:0
map/while/Switch_1:1
map/while/Switch_2:0
map/while/Switch_2:1
#map/while/TensorArrayReadV3/Enter:0
%map/while/TensorArrayReadV3/Enter_1:0
map/while/TensorArrayReadV3:0
5map/while/TensorArrayWrite/TensorArrayWriteV3/Enter:0
/map/while/TensorArrayWrite/TensorArrayWriteV3:0
map/while/add/y:0
map/while/add:0
map/while/add_1/y:0
map/while/add_1:0
!map/while/resize/ExpandDims/dim:0
map/while/resize/ExpandDims:0
!map/while/resize/ResizeBilinear:0
map/while/resize/Squeeze:0
map/while/resize/size:0L
map/TensorArray_1:05map/while/TensorArrayWrite/TensorArrayWriteV3/Enter:0i
@map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3:0%map/while/TensorArrayReadV3/Enter_1:0-
map/strided_slice:0map/while/Less/Enter:08
map/TensorArray:0#map/while/TensorArrayReadV3/Enter:0Rmap/while/Enter:0Rmap/while/Enter_1:0Rmap/while/Enter_2:0Zmap/strided_slice:0"?
	variables??
Z
global_step:0global_step/Assignglobal_step/read:02global_step/Initializer/zeros:0H
?
layer1/conv2d/kernel:0layer1/conv2d/kernel/Assignlayer1/conv2d/kernel/read:021layer1/conv2d/kernel/Initializer/random_uniform:08
v
layer1/conv2d/bias:0layer1/conv2d/bias/Assignlayer1/conv2d/bias/read:02&layer1/conv2d/bias/Initializer/zeros:08
?
layer2/conv2d/kernel:0layer2/conv2d/kernel/Assignlayer2/conv2d/kernel/read:021layer2/conv2d/kernel/Initializer/random_uniform:08
v
layer2/conv2d/bias:0layer2/conv2d/bias/Assignlayer2/conv2d/bias/read:02&layer2/conv2d/bias/Initializer/zeros:08
?
layer2/conv2d_1/kernel:0layer2/conv2d_1/kernel/Assignlayer2/conv2d_1/kernel/read:023layer2/conv2d_1/kernel/Initializer/random_uniform:08
~
layer2/conv2d_1/bias:0layer2/conv2d_1/bias/Assignlayer2/conv2d_1/bias/read:02(layer2/conv2d_1/bias/Initializer/zeros:08
?
layer3/conv2d/kernel:0layer3/conv2d/kernel/Assignlayer3/conv2d/kernel/read:021layer3/conv2d/kernel/Initializer/random_uniform:08
v
layer3/conv2d/bias:0layer3/conv2d/bias/Assignlayer3/conv2d/bias/read:02&layer3/conv2d/bias/Initializer/zeros:08
?
layer3/conv2d_1/kernel:0layer3/conv2d_1/kernel/Assignlayer3/conv2d_1/kernel/read:023layer3/conv2d_1/kernel/Initializer/random_uniform:08
~
layer3/conv2d_1/bias:0layer3/conv2d_1/bias/Assignlayer3/conv2d_1/bias/read:02(layer3/conv2d_1/bias/Initializer/zeros:08
?
layer4/conv2d/kernel:0layer4/conv2d/kernel/Assignlayer4/conv2d/kernel/read:021layer4/conv2d/kernel/Initializer/random_uniform:08
v
layer4/conv2d/bias:0layer4/conv2d/bias/Assignlayer4/conv2d/bias/read:02&layer4/conv2d/bias/Initializer/zeros:08
?
layer4/conv2d_1/kernel:0layer4/conv2d_1/kernel/Assignlayer4/conv2d_1/kernel/read:023layer4/conv2d_1/kernel/Initializer/random_uniform:08
~
layer4/conv2d_1/bias:0layer4/conv2d_1/bias/Assignlayer4/conv2d_1/bias/read:02(layer4/conv2d_1/bias/Initializer/zeros:08
?
layer5/conv2d/kernel:0layer5/conv2d/kernel/Assignlayer5/conv2d/kernel/read:021layer5/conv2d/kernel/Initializer/random_uniform:08
v
layer5/conv2d/bias:0layer5/conv2d/bias/Assignlayer5/conv2d/bias/read:02&layer5/conv2d/bias/Initializer/zeros:08
?
layer6/dense/kernel:0layer6/dense/kernel/Assignlayer6/dense/kernel/read:020layer6/dense/kernel/Initializer/random_uniform:08
r
layer6/dense/bias:0layer6/dense/bias/Assignlayer6/dense/bias/read:02%layer6/dense/bias/Initializer/zeros:08
?
layer6/logits/kernel:0layer6/logits/kernel/Assignlayer6/logits/kernel/read:021layer6/logits/kernel/Initializer/random_uniform:08
v
layer6/logits/bias:0layer6/logits/bias/Assignlayer6/logits/bias/read:02&layer6/logits/bias/Initializer/zeros:08*?
serving_default?
H
image?
image_tensor:0+???????????????????????????6
output,
layer6/final_dense:0??????????tensorflow/serving/predict*?
predict?
H
image?
image_tensor:0+???????????????????????????6
output,
layer6/final_dense:0??????????tensorflow/serving/predict