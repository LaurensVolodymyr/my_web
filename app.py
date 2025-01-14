from flask import Flask, request, redirect, url_for, render_template
import redis

app = Flask(__name__)
r = redis.Redis(host='redis', port=6379, db=0, decode_responses=True)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        message = request.form['message']
        r.rpush('messages', message)
        return redirect(url_for('index'))

    messages = r.lrange('messages', 0, -1)
    return render_template('index.html', messages=messages)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
