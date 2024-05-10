import numpy as np

with open("output.txt", "r") as file:
    
    pixel_data = file.read()

pixel_list = list(map(int, pixel_data.split()))

a = np.array(pixel_list).reshape((512, 512))

k1 = np.array([
    [232, 271,  171,  -46,  -25],
    [279, 420,  407,  216,  -37],
    [184, 411,  512,  411,  184],
    [-37, 216,  407,  420,  279],
    [254, -46,  171,  271,  232]] )

k2 = np.array([
     [-7 , -5,  0,  5,  7],
     [23, 317,  353, 323, 242],
     [34 ,464, 512, 464, 345],
     [24, 323, 353, 317, 234],
     [7,5, 0 ,-5, -7]])

k3 = np.array([
    [ -25 , -33, 188, 282, 232],
    [ -49 ,217, 412,  420,  268],
    [ 167 ,406, 512,  406,  167],
    [ 268 ,420, 412,  217,  -49],
    [ 232 ,282, 188,  -33,  -254]
])


k4 = np.array([
    [0, 5, 22, 238, 0],
    [0, 320, 29, 320, 0],
    [0, 353, 512, 353, 0],
    [0, 320, 29, 320, 0],
    [0, 238, 22, 238, 0]
])

final_k1 = np.zeros((512, 512), dtype=np.int32)
final_k2 = np.zeros((512, 512), dtype=np.int32)
final_k3 = np.zeros((512, 512), dtype=np.int32)
final_k4 = np.zeros((512, 512), dtype=np.int32)

repeated_k1 = np.tile(k1, (102,102))
repeated_k2 = np.tile(k2, (102,102))
repeated_k3 = np.tile(k3, (102,102))
repeated_k4 = np.tile(k4, (102,102))


start_row = (512 - repeated_k1.shape[0]) // 2
start_col = (512 - repeated_k1.shape[1]) // 2


final_k1[start_row:start_row + repeated_k1.shape[0], start_col:start_col + repeated_k1.shape[1]] = repeated_k1
final_k2[start_row:start_row + repeated_k2.shape[0], start_col:start_col + repeated_k2.shape[1]] = repeated_k2
final_k3[start_row:start_row + repeated_k3.shape[0], start_col:start_col + repeated_k3.shape[1]] = repeated_k3
final_k4[start_row:start_row + repeated_k4.shape[0], start_col:start_col + repeated_k4.shape[1]] = repeated_k4


result_k1 = (a * final_k1)/512
result_k2 = (a * final_k2)/512
result_k3 = (a * final_k3)/512
result_k4 = (a * final_k4)/512

np.savetxt('res_k1.txt', result_k1, fmt='%d')
np.savetxt('res_k2.txt', result_k2, fmt='%d')
np.savetxt('res_k3.txt', result_k3, fmt='%d')
np.savetxt('res_k4.txt', result_k4, fmt='%d')




print(result_k1)
print(result_k2)
print(result_k3)
print(result_k4)

