import logging
from flask import Flask, request, jsonify
from sqlalchemy import create_engine, Table, Column, Integer, String, Numeric, TIMESTAMP, MetaData, select
from sqlalchemy.exc import SQLAlchemyError
from datetime import datetime
import os

app = Flask(__name__)

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Database configuration
DB_USER = os.getenv('POSTGRES_USER', 'postgres')
DB_PASSWORD = os.getenv('POSTGRES_PASSWORD', 'S3cr37')
DB_HOST = os.getenv('POSTGRES_HOST', 'localhost')
DB_PORT = os.getenv('POSTGRES_PORT', '5432')
DB_NAME = os.getenv('POSTGRES_DB', 'sela_db')

DATABASE_URI = f'postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}'
engine = create_engine(DATABASE_URI)
metadata = MetaData()

# Define the table structure
data_table = Table(
    'data', metadata,
    Column('name', String(255), nullable=False),
    Column('value', Numeric, nullable=False),
    Column('time', TIMESTAMP, nullable=False)
)

# Ensure table exists
metadata.create_all(engine)

@app.route('/data', methods=['POST'])
def add_data():
    
    try:
        # Parse JSON request
        data = request.get_json()
        name = data.get('name')
        value = data.get('value')
        time = data.get('time')
        logger.info(f"Add data {name}, {value}, {time}")
        # Validate input
        if not all([name, value, time]):
            logger.warning('Invalid input received')
            return jsonify({'error': 'Invalid input, all fields are required'}), 400

        # Convert time to datetime object
        try:
            time = datetime.fromisoformat(time)
        except ValueError:
            logger.warning('Invalid time format')
            return jsonify({'error': 'Invalid time format. Use ISO format, e.g., "2023-10-10T10:00:00"'}), 400

        # Insert data into the table
        with engine.connect() as conn:
            conn.execute(data_table.insert().values(name=name, value=value, time=time))
            conn.commit()

        return jsonify({'message': 'Data added successfully'}), 201

    except SQLAlchemyError as e:
        print(e)
        return jsonify({'error': 'Database error occurred'}), 500

@app.route('/data/<string:name>', methods=['GET'])
def get_data(name):
    logger.info('Get data ' + name)
    try:
        # Query the table for the specified name
        with engine.connect() as conn:
            query = select(data_table).where(data_table.c.name == name)
            result = conn.execute(query).mappings().fetchone()
            # Check if the record exists
            if result:
                data = {
                    'name': result['name'],
                    'value': float(result['value']),
                    'time': result['time'].isoformat()
                }
                return jsonify(data), 200
            else:
                return jsonify({'error': 'Record not found'}), 404

    except SQLAlchemyError as e:
        logger.error(f"Database error: {e}")
        return jsonify({'error': 'Database error occurred'}), 500

@app.route('/', methods=['GET'])
def hello():
    return "Hello", 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
    logger.info('App is running')
