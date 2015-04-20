from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def hello_world():
	return 'Hello shaun!'

if __name__ == '__main__':
	print os.environ['RESIN_DEVICE_UUID']
	app.run(host='0.0.0.0',port=80)





