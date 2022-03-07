from crypt import methods
import os
import json
import datetime
import random
import string
from unittest import result
import mysql.connector
from flask import Flask, request

app = Flask(__name__)

config = {
        'user': 'root',
        'password': 'An@ar3m3re',
        'host': 'localhost',
        'port': '8080',
        'database': 'carshop'
    }

# brands
@app.route('/brands', methods=['GET'])
def get_brands():
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    cursor.callproc('select_all_brand')
    response = {}
    brands = []
    result = []
    for row in cursor.stored_results():
        result = row.fetchall()
    for id, den in result:
        brand = {}
        brand['BRAND_CODE'] = str(id)
        brand['BRAND_NAME'] = str(den)
        brands.append(brand)
    response["data"] = brands
    cursor.close()
    connection.close()
    return json.dumps(response)

@app.route('/brand', methods=['POST'])
def add_brand():
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    data = request.json
    b_code = str(data['brand_code'])
    b_name = str(data['brand_name'])
    cursor.callproc('add_brand', [b_code, b_name])
    cursor.close()
    connection.close()
    return ""

@app.route('/brand/<id>', methods=['DELETE'])
def delete_brand(id):
	connection = mysql.connector.connect(**config)
	cursor = connection.cursor()  
	id_brand = str(id)
	cursor.callproc('delete_brand', [id_brand])
	cursor.close()
	connection.close()
	return ""

@app.route('/brand/<id>', methods=['GET'])
def get_brand(id):
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    id_brand = str(id)
    cursor.callproc('select_brand', [id_brand])
    cursor.close()
    connection.close()
    return ""

# colors
@app.route('/color', methods=['POST'])
def add_color():
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    data = request.json
    c_code = int(data['color_code'])
    c_name = str(data['color_name'])
    cursor.callproc('add_color', [c_code, c_name])
    cursor.close()
    connection.close()
    return ""

@app.route('/color/<id>', methods=['DELETE'])
def delete_color(id):
	connection = mysql.connector.connect(**config)
	cursor = connection.cursor()  
	id_color = int(id)
	cursor.callproc('delete_color', [id_color])
	cursor.close()
	connection.close()
	return ""

@app.route('/color/<id>', methods=['GET'])
def get_color(id):
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    id_color = int(id)
    cursor.callproc('select_color', [id_color])
    cursor.close()
    connection.close()
    return ""

@app.route('/colors', methods=['GET'])
def get_colors():
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    cursor.callproc('select_all_color')
    response = {}
    colors = []
    result = []
    for row in cursor.stored_results():
        result = row.fetchall()
    for id, den in result:
        color = {}
        color['COLOR_CODE'] = int(id)
        color['COLOR_NAME'] = str(den)
        colors.append(color)
    response["data"] = colors
    cursor.close()
    connection.close()
    return json.dumps(response)

# gearbox
@app.route('/gearbox', methods=['POST'])
def add_gearbox():
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    data = request.json
    g_code = str(data['gearbox_code'])
    g_name = str(data['gearbox_name'])
    cursor.callproc('add_gearbox', [g_code, g_name])
    cursor.close()
    connection.close()
    return ""

@app.route('/gearbox/<id>', methods=['DELETE'])
def delete_gearbox(id):
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    id_gbx = str(id)
    cursor.callproc('delete_gearbox', [id_gbx])
    cursor.close()
    connection.close()
    return ""

@app.route('/gearbox/<id>', methods=['GET'])
def get_gearbox(id):
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    id_gearbox = str(id)
    cursor.callproc('select_gearbox', [id_gearbox])
    cursor.close()
    connection.close()
    return ""

@app.route('/gearboxes', methods=['GET'])
def get_gearboxes():
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    cursor.callproc('select_all_gearbox')
    response = {}
    gearboxes = []
    result = []
    for row in cursor.stored_results():
        result = row.fetchall()
    for id, den in result:
        gearbox = {}
        gearbox['GEARBOX_CODE'] = str(id)
        gearbox['GEARBOX_TYPE'] = str(den)
        gearboxes.append(gearbox)
    response["data"] = gearboxes
    cursor.close()
    connection.close()
    return json.dumps(response)

# combustibil
@app.route('/combustibil', methods=['POST'])
def add_combustibil():
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    data = request.json
    com_code = int(data['combustibil_id'])
    com_name = str(data['combustibil_type'])
    cursor.callproc('add_combustibil', [com_code, com_name])
    cursor.close()
    connection.close()
    return ""

@app.route('/combustibil/<id>', methods=['DELETE'])
def delete_combustibil(id):
	connection = mysql.connector.connect(**config)
	cursor = connection.cursor()  
	id_com = int(id)
	cursor.callproc('delete_combustibil', [id_com])
	cursor.close()
	connection.close()
	return ""

@app.route('/combustibil/<id>', methods=['GET'])
def get_combustibil(id):
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    id_com = int(id)
    cursor.callproc('select_combustibil', [id_com])
    cursor.close()
    connection.close()
    return ""

@app.route('/combustibili', methods=['GET'])
def get_combustibili():
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    cursor.callproc('select_all_combustibil')
    response = {}
    combustibili = []
    result = []
    for row in cursor.stored_results():
        result = row.fetchall()
    for id, den in result:
        comb = {}
        comb['COMBUSTIBIL_ID'] = int(id)
        comb['COMBUSTIBIL_TYPE'] = str(den)
        combustibili.append(comb)
    response["data"] = combustibili
    cursor.close()
    connection.close()
    return json.dumps(response)

# car_type
@app.route('/car_type', methods=['POST'])
def add_car_type():
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    data = request.json
    cart_code = int(data['car_type_id'])
    cart_name = str(data['car_type_name'])
    cursor.callproc('add_car_type', [cart_code, cart_name])
    cursor.close()
    connection.close()
    return ""

@app.route('/car_type/<id>', methods=['DELETE'])
def delete_car_type(id):
	connection = mysql.connector.connect(**config)
	cursor = connection.cursor()  
	id_cart = int(id)
	cursor.callproc('delete_car_type', [id_cart])
	cursor.close()
	connection.close()
	return ""

@app.route('/car_type/<id>', methods=['GET'])
def get_car_type(id):
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    id_cart = int(id)
    cursor.callproc('select_car_type', [id_cart])
    cursor.close()
    connection.close()
    return ""

@app.route('/cars_type', methods=['GET'])
def get_cars_type():
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    cursor.callproc('select_all_car_type')
    response = {}
    cars_type = []
    result = []
    for row in cursor.stored_results():
        result = row.fetchall()
    for id, name in result:
        car_t = {}
        car_t['CAR_TYPE_ID'] = int(id)
        car_t['CAR_TYPE_NAME'] = str(name)
        cars_type.append(car_t)
    response["data"] = cars_type
    cursor.close()
    connection.close()
    return json.dumps(response)

# cars
@app.route('/car', methods=['POST'])
def add_car():
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    data = request.json
    car_id = int(data['ID_CAR'])
    car_name = str(data['MODEL_NAME'])
    car_brand = str(data['BRAND_CODE'])
    car_year = int(data['CAR_YEAR'])
    car_comb = int(data['COMBUSTIBIL_ID'])
    car_type = int(data['CAR_TYPE_ID'])
    car_price = int(data['PRICE'])
    car_gbx_code = str(data['GEARBOX_CODE'])
    car_no_km = int(data['NO_KM'])
    car_pow = int(data['ENGINE_POWER'])
    car_color = int(data['COLOR_CODE'])
    cursor.callproc('add_car', [car_id, car_name, car_brand, car_year, car_comb, car_type, car_price, car_gbx_code, car_no_km, car_pow, car_color])
    cursor.close()
    connection.close()
    return ""

@app.route('/car/<id>', methods=['DELETE'])
def delete_car(id):
	connection = mysql.connector.connect(**config)
	cursor = connection.cursor()  
	id_car = int(id)
	cursor.callproc('delete_car', [id_car])
	cursor.close()
	connection.close()
	return ""

@app.route('/car/<id>', methods=['GET'])
def get_car_by_id(id):
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    id_car = int(id)
    cursor.callproc('select_all_by_id', [id_car])
    response = {}
    cars = []
    result = []
    for row in cursor.stored_results():
        result = row.fetchall()
    for c_id, c_den, c_year, c_price in result:
        car = {}
        car['ID_CAR'] = int(c_id)
        car['MODEL_NAME'] = str(c_den)
        car['CAR_YEAR'] = int(c_year)
        car['PRICE'] = int(c_price)
        cars.append(car)
    response["data"] = cars
    cursor.close()
    connection.close()
    return json.dumps(response)

@app.route('/car/car_combust/<id>', methods=['GET'])
def get_car_by_comb_id(id):
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    id_comb = int(id)
    cursor.callproc('select_all_by_comb_id', [id_comb])
    response = {}
    cars = []
    result = []
    for row in cursor.stored_results():
        result = row.fetchall()
    for c_id, c_den, c_year, c_price in result:
        car = {}
        car['ID_CAR'] = int(c_id)
        car['MODEL_NAME'] = str(c_den)
        car['CAR_YEAR'] = int(c_year)
        car['PRICE'] = int(c_price)
        cars.append(car)
    response["data"] = cars
    cursor.close()
    connection.close()
    return json.dumps(response)

@app.route('/car/car_type/<car_type_id>', methods=['GET'])
def get_car_by_car_type(car_type_id):
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    id_car = int(car_type_id)
    cursor.callproc('select_all_by_car_type_id', [id_car])
    response = {}
    cars = []
    result = []
    for row in cursor.stored_results():
        result = row.fetchall()
    for c_id, c_den, c_year, ct_id in result:
        car = {}
        car['ID_CAR'] = int(c_id)
        car['MODEL_NAME'] = str(c_den)
        car['CAR_YEAR'] = int(c_year)
        car['CAR_TYPE_ID'] = int(ct_id)
        cars.append(car)
    response["data"] = cars
    cursor.close()
    connection.close()
    return json.dumps(response)

@app.route('/car/car_gbx/<car_gbx_id>', methods=['GET'])
def get_car_by_gbx_id(car_gbx_id):
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    id_car = str(car_gbx_id)
    cursor.callproc('select_all_by_gearbox_code', [id_car])
    response = {}
    cars = []
    result = []
    for row in cursor.stored_results():
        result = row.fetchall()
    for c_id, c_den, c_year, c_price in result:
        car = {}
        car['ID_CAR'] = int(c_id)
        car['MODEL_NAME'] = str(c_den)
        car['CAR_YEAR'] = int(c_year)
        car['PRICE'] = int(c_price)
        cars.append(car)
    response["data"] = cars
    cursor.close()
    connection.close()
    return json.dumps(response)

@app.route('/car/car_color/<car_color_id>', methods=['GET'])
def get_car_by_color_id(car_color_id):
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    id_car = int(car_color_id)
    cursor.callproc('select_all_by_color', [id_car])
    response = {}
    cars = []
    result = []
    for row in cursor.stored_results():
        result = row.fetchall()
    for c_id, c_den, c_year, c_price in result:
        car = {}
        car['ID_CAR'] = int(c_id)
        car['MODEL_NAME'] = str(c_den)
        car['CAR_YEAR'] = int(c_year)
        car['PRICE'] = int(c_price)
        cars.append(car)
    response["data"] = cars
    cursor.close()
    connection.close()
    return json.dumps(response)

@app.route('/cars', methods=['GET'])
def get_cars():
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    # id_car = int(id)
    cursor.callproc('select_all_cars')
    response = {}
    cars = []
    result = []
    for row in cursor.stored_results():
        result = row.fetchall()
    for c_id, c_den, c_brand, c_year, c_comb, c_type, c_price, c_gbx, c_km, c_pow, c_color in result:
        car = {}
        car['ID_CAR'] = int(c_id)
        car['MODEL_NAME'] = str(c_den)
        car['BRAND_CODE'] = str(c_brand)
        car['CAR_YEAR'] = int(c_year)
        car['COMBUSTIBIL_ID'] = int(c_comb)
        car['CAR_TYPE_ID'] = int(c_type)
        car['PRICE'] = int(c_price)
        car['GEARBOX_CODE'] = str(c_gbx)
        car['NO_KM'] = int(c_km)
        car['ENGINE_POWER'] = int(c_pow)
        car['COLOR_CODE'] = int(c_color)
        cars.append(car)
    response["data"] = cars
    cursor.close()
    connection.close()
    return json.dumps(response)

# functii
@app.route('/what_gbx_i_have/<id>', methods=['GET'])
def car_gbx(id):
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    car_id = int(id)
    f = "SELECT get_car_gearbox(%s)"
    cursor.execute(f, (car_id,))
    result = cursor.fetchone()
    response = {}
    cars = []
    print(result)
    for c_gbx in result:
        car = {}
        car['GEARBOX_CODE'] = str(c_gbx)
        cars.append(car)
    response["data"] = cars
    cursor.close()
    connection.close()
    return json.dumps(response)

@app.route('/power_class/<power>', methods=['GET'])
def power_class(power):
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    pow = int(power)
    f = "SELECT clasify_by_power(%s)"
    cursor.execute(f, (pow,))
    result = cursor.fetchone()
    response = {}
    cars = []
    for c_status in result:
        c = {}
        c["STATUS CAR"] = str(c_status)
        cars.append(c)
    response["data"] = cars
    cursor.close()
    connection.close()
    return json.dumps(response)
    
@app.route('/power_class/car/<name>', methods=['GET'])
def get_car_by_pow(name):
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    cursor.callproc('select_all_cars')
    n = str(name)
    response = {}
    cars = []
    result = []
    for row in cursor.stored_results():
        result = row.fetchall()
    for c_id, c_den, c_brand, c_year, c_comb, c_type, c_price, c_gbx, c_km, c_pow, c_color in result:
        car = {}
        car['ID_CAR'] = int(c_id)
        car['MODEL_NAME'] = str(c_den)
        car['BRAND_CODE'] = str(c_brand)
        car['CAR_YEAR'] = int(c_year)
        car['COMBUSTIBIL_ID'] = int(c_comb)
        car['CAR_TYPE_ID'] = int(c_type)
        car['PRICE'] = int(c_price)
        car['GEARBOX_CODE'] = str(c_gbx)
        car['NO_KM'] = int(c_km)
        car['ENGINE_POWER'] = int(c_pow)
        car['COLOR_CODE'] = int(c_color)
        car['STATUS'] = str(json.loads(power_class(c_pow)))
        list_status = car['STATUS'].split("'")
        if list_status[len(list_status)-2] == n:
            cars.append(car)
    response["data"] = cars
    cursor.close()
    connection.close()
    return json.dumps(response)
if __name__ == '__main__':
    app.run(host='0.0.0.0')