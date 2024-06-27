import csv

#id, h, w, l, x_start, x_end, y_start, y_end, heading, model_reference
cars = [[0, 0, 0, 0, -2856, 1935, 13703, 13745, 0, 'vehicle.tesla.model3'], #by carla model name
[1, 0, 0, 0, -14, -2851, 13021, 13003, 180, 'vehicle.audi.etron'], #by carla model name
[2, 1.7, 2, 6, 1936, -2853, 13396, 13353, 180, ''], #by measurements
[3, 1.6, 1.9, 4.9, -21, 1933, 14070, 14095, 0, '']] #by measurements

seconds = 5
hz = 100
timesteps = seconds * hz
data = []

for n in range(timesteps + 1):
    for car in cars:
        timestamp_milliseconds = n * 10
        x = (float(car[4]) + float(car[5] - car[4]) * n / timesteps) * 0.01
        y = -(float(car[6]) + float(car[7] - car[6]) * n / timesteps) * 0.01
        data.append([timestamp_milliseconds * 1000, car[0], car[1], car[2], car[3], '', x, y , 0, 0, 0, 0, 0, 0, 0, car[8], car[9]])

with open('town10hd-replay.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)

    header = ['ts','id','h','w','l','class','x','y','z','vx','vy','vel','ax','ay','acc','heading','model_reference']
    writer.writerow(header)
    for entry in data:
        writer.writerow(entry)
