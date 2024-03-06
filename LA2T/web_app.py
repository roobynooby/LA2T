#web_app.py
#sidenote, base functions are noted by !!!!!!!(function)!!!!
import platform
from flask import Flask, render_template, request, redirect, url_for, send_file, jsonify
from flask_mail import Mail, Message
import csv
import os
import glob
from itertools import combinations
from tempfile import NamedTemporaryFile
import shutil
import subprocess
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
import paramiko
import csv_diff
import datetime
from datetime import datetime
import schedule
import time
from threading import Thread
import os.path
import urllib.parse
import re

app = Flask(__name__)

UPLOAD_FOLDER = 'uploads'
ALLOWED_EXTENSIONS = {'csv'}
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

scheduled_jobs = {}

# Perform scheduled audit function
def perform_scheduled_audit(selected_script, custom_csv_name):
    # Execute your bash script for scheduled audit
    csv_filename = f"{custom_csv_name}.csv" if custom_csv_name else f"{datetime.now().strftime('%Y-%m-%d_%H-%M-%S')}.csv"
    script_output_path = os.path.join(app.config['UPLOAD_FOLDER'], csv_filename)

    subprocess.run(['bash', selected_script, csv_filename])

    current_csv = glob.glob('*.csv')[0]
    new_csv_path = os.path.join(app.config['UPLOAD_FOLDER'], current_csv)
    shutil.move(current_csv, new_csv_path)


def schedule_audit(selected_script, custom_csv_name, scheduled_datetime, frequency):
    # Generate a unique ID for the job
    job_id = f"{selected_script}-{custom_csv_name}-{scheduled_datetime.timestamp()}"

    # Schedule the audit based on the selected frequency
    if frequency == 'daily':
        job = schedule.every().day.at(scheduled_datetime.strftime("%H:%M")).do(
            perform_scheduled_audit, selected_script, custom_csv_name
        )
    elif frequency == 'weekly':
        job = schedule.every().week.do(
            perform_scheduled_audit, selected_script, custom_csv_name
        )
    elif frequency == 'monthly':
        # Assuming the day of the month is 1, adjust this based on your requirements
        job = schedule.every().day.at(scheduled_datetime.strftime("%H:%M")).do(
            perform_scheduled_audit, selected_script, custom_csv_name
        )
    else:
        # Handle other cases or provide a default frequency
        job = schedule.every().day.at(scheduled_datetime.strftime("%H:%M")).do(
            perform_scheduled_audit, selected_script, custom_csv_name
        )

    # Replace problematic characters in job_id
    encoded_job_id = re.sub(r'[^a-zA-Z0-9_-]', '_', job_id)

    # Store the job and relevant information in the dictionary with the unique ID as the key
    scheduled_jobs[encoded_job_id] = {'job': job, 'selected_script': selected_script, 'custom_csv_name': custom_csv_name, 'frequency': frequency}

    print(f"Audit scheduled for script: {selected_script}, custom CSV name: {custom_csv_name}, scheduled time: {scheduled_datetime}, frequency: {frequency}")
    print(schedule.get_jobs())

    return encoded_job_id





def run_scheduled_jobs():
    while True:
        schedule.run_pending()
        time.sleep(1)

script_files = glob.glob('static/scripts/*.sh')  # Define script_files outside the route

@app.route('/schedule_audit_route', methods=['GET', 'POST'])
def schedule_audit_route():
    scheduled_date_default = datetime.now().strftime("%Y-%m-%d")

    if request.method == 'POST':
        selected_script = request.form.get('scriptDropdown', '')
        custom_csv_name = request.form.get('customCsvName', '')
        scheduled_date = request.form.get('scheduled_date')
        scheduled_time = request.form.get('scheduled_time')

        print(f"Received form values - Script: {selected_script}, CSV Name: {custom_csv_name}, Date: {scheduled_date}, Time: {scheduled_time}")

        if selected_script and scheduled_date and scheduled_time:
            # Combine date and time to create a datetime object
            scheduled_datetime_str = f"{scheduled_date} {scheduled_time}"

            try:
                scheduled_datetime = datetime.strptime(scheduled_datetime_str, "%Y-%m-%d %H:%M")
            except ValueError:
                error_message = 'Invalid date format or value.'
                return render_template('error_message.html', error_message=error_message)

            print(f"Scheduled DateTime: {scheduled_datetime}")

            # Check if the scheduled_datetime is in the past
            if scheduled_datetime <= datetime.now():
                error_message = 'Scheduled time is in the past. Please choose a future time.'
                return render_template('error_message.html', error_message=error_message)

            # Get the selected frequency from the form data
            frequency = request.form.get('frequency', '')

            # Perform scheduled audit and get the scheduled job
            job = schedule_audit(selected_script, custom_csv_name, scheduled_datetime, frequency)

            # Display scheduled audit information
            return render_template('scheduled_audit_confirmation.html', scheduled_datetime=scheduled_datetime, job=job)

    return render_template('schedule_audit.html', script_files=script_files, scheduled_jobs=scheduled_jobs, scheduled_date_default=scheduled_date_default)





# Delete scheduled audit function
@app.route('/delete_scheduled_audit/<job_id>', methods=['GET'])
def delete_scheduled_audit(job_id):
    try:
        # Decode the encoded job ID
        decoded_job_id = urllib.parse.unquote(job_id)

        # Unscheduled the job using unschedule_job function
        schedule.cancel_job(scheduled_jobs[decoded_job_id]['job'])
        del scheduled_jobs[decoded_job_id]
        print(f"Scheduled audit with job_id {decoded_job_id} has been deleted.")
    except Exception as e:
        print(f"Error deleting scheduled audit with job_id {decoded_job_id}: {str(e)}")

    return redirect(url_for('schedule_audit_route'))


#!!!!!perform audit function!!!!!
def perform_audit(selected_script, chapter_descriptions):

    chapter_descriptions = {
        1: "Initial Setup",
        2: "Services",
        3: "Network",
        4: "Access, Authentication, and Authorization",
        5: "Logging and Auditing",
        6: "System Maintenance",
    }    	
    # Execute your bash script
    custom_csv_name = request.form.get('customCsvName', '')
    
    if custom_csv_name:
        csv_filename = f"{custom_csv_name}.csv"
    else:
        # Use the timestamp without spaces for filename
        timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
        print("timestamp:", timestamp)
        csv_filename = f"{timestamp}.csv"

    # Remove the additional .csv if it was added by mistake
    if csv_filename.endswith('.csv.csv'):
        csv_filename = csv_filename[:-4]

    # Adjust the script to use the custom CSV name
    script_output_path = os.path.join(app.config['UPLOAD_FOLDER'], csv_filename)

    subprocess.run(['bash', selected_script, csv_filename])

    # Modify this line to look for CSV files in the 'uploads' folder
    current_csv = glob.glob('*.csv')[0]

    new_csv_path = os.path.join(app.config['UPLOAD_FOLDER'], os.path.basename(current_csv))
    shutil.move(current_csv, new_csv_path)

    

   

        

#!!!!!reading the csv function!!!!	
def read_csv():
    # Get a list of all CSV files in the uploads folder
    csv_files = glob.glob(os.path.join(app.config['UPLOAD_FOLDER'], '*.csv'))

    # Sort the files based on their creation time
    csv_files.sort(key=os.path.getctime, reverse=True)

    # Get the latest CSV file
    latest_csv = csv_files[0]

    # Read the contents of the latest CSV file
    with open(latest_csv, 'r') as file:
        csv_reader = csv.reader(file)
        # next(csv_reader)  # Skip the header
        results = [{'title': row[0] if len(row) > 0 else '', 'additional_output': row[1] if len(row) > 1 else '', 'result': row[2] if len(row) > 2 else ''} for row in csv_reader]


    return results



def get_chapter_descriptions():
    return {
        1: "Initial Setup",
        2: "Services",
        3: "Network",
        4: "Access, Authentication, and Authorization",
        5: "Logging and Auditing",
        6: "System Maintenance",
    }



@app.route('/')
def index():
    script_files_default = glob.glob('static/scripts/*.sh')
    script_files_custom = glob.glob('static/custom/*.sh')
    script_files = script_files_default + script_files_custom
    print("List of Script Files:", script_files)
    return render_template('index.html', script_files=script_files)


#audit over ssh stuff
@app.route('/perform_audit', methods=['POST'])
def perform_audit_route():
    selected_script = request.form['scriptDropdown']
    custom_csv_name = request.form.get('customCsvName', '')

    if custom_csv_name:
        csv_filename = f"{custom_csv_name}.csv"
    else:
        # Use the timestamp without spaces for filename
        timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
        print("timestamp:", timestamp)
        csv_filename = f"{timestamp}.csv"

    # Adjust the script to use the custom CSV name
    script_output_path = os.path.join(app.config['UPLOAD_FOLDER'], csv_filename)

    if 'ssh_checkbox' in request.form:
        ssh_host = request.form['ssh_host']
        ssh_user = request.form['ssh_user']
        ssh_password = request.form['ssh_password']
        perform_ssh_audit(selected_script, ssh_host, ssh_user, ssh_password)
        results = read_csv()
        return render_template('audit_results.html', results=results, chapter_descriptions=get_chapter_descriptions())
    else:
        # Fetch chapter descriptions (added this line)
        chapter_descriptions = get_chapter_descriptions()
        perform_audit(selected_script, chapter_descriptions)  # Pass chapter_descriptions to perform_audit
        results = read_csv()
        return render_template('audit_results.html', results=results, chapter_descriptions=get_chapter_descriptions())



def perform_ssh_audit(selected_script, ssh_host, ssh_user, ssh_password):
    # Establish an SSH connection
    with paramiko.SSHClient() as ssh_client:
        ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        try:
            # Connect to the remote machine
            ssh_client.connect(ssh_host, username=ssh_user, password=ssh_password)

            # Transfer the script to the remote machine
            local_script_path = selected_script
            remote_script_path = f'/tmp/{os.path.basename(selected_script)}'

            with ssh_client.open_sftp() as sftp:
                # Ensure the remote script is executable
                sftp.put(local_script_path, remote_script_path)
                sftp.chmod(remote_script_path, 0o755)

            # Execute the script remotely
            command = f'bash {remote_script_path}'
            stdin, stdout, stderr = ssh_client.exec_command(command)
            exit_status = stdout.channel.recv_exit_status()

            # Print the result
            print(f"Script execution command: {command}")
            print(f"Script execution result: {exit_status}")

            # Check for errors in stderr
            if exit_status != 0:
                print("Error output:")
                print(stderr.read().decode())

            # Fetch the resulting CSV file (adjust this based on your script logic)
            remote_csv_files = ssh_client.open_sftp().listdir('.')
            if not remote_csv_files:
                print("No CSV file generated on the remote machine.")
                return

            remote_csv = remote_csv_files[0]
            remote_csv_filename = f"{remote_csv}.csv"
            remote_csv_path = os.path.join(app.config['UPLOAD_FOLDER'], remote_csv_filename)

            # Fetch the CSV file from the remote machine
            with ssh_client.open_sftp() as sftp:
                sftp.get(remote_csv, remote_csv_path)

            # Remove the temporary script from the remote machine
            with ssh_client.open_sftp() as sftp:
                sftp.remove(remote_script_path)

        except Exception as e:
            print(f"Error during SSH audit: {str(e)}")

        finally:
            # Close the SSH connection
            ssh_client.close()










def read_history_csv(file_path):
    # Read the contents of the latest CSV file
    with open(file_path, 'r') as file:
        csv_reader = csv.reader(file)
        # next(csv_reader)  # Skip the header
        results = [{'title': row[0] if len(row) > 0 else '', 'additional_output': row[1] if len(row) > 1 else '', 'result': row[2] if len(row) > 2 else ''} for row in csv_reader]


    return results

@app.route('/audit_results/<filename>')
def audit_results(filename):
    file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
    results = read_history_csv(file_path)

    # Extract unique title numbers
    title_numbers = set(result['title'].split('.')[0] for result in results)

    chapter_descriptions = {
        1: "Initial Setup",
        2: "Services",
        3: "Network",
        4: "Access, Authentication, and Authorization",
        5: "Logging and Auditing",
        6: "System Maintenance",
    }

    return render_template('audit_results.html', results=results, filename=filename, titleNumbers=title_numbers, chapter_descriptions=chapter_descriptions)

    

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def read_uploaded_csv(file_path):
    # Read the contents of the latest CSV file
    with open(file_path, 'r') as file:
        csv_reader = csv.reader(file)
        # next(csv_reader)  # Skip the header
        results = [{'title': row[0] if len(row) > 0 else '', 'additional_output': row[1] if len(row) > 1 else '', 'result': row[2] if len(row) > 2 else ''} for row in csv_reader]

    return results


def compare_csv(file1_path, file2_path):
    results1 = read_uploaded_csv(file1_path)
    results2 = read_uploaded_csv(file2_path)
    return results1, results2

@app.route('/compare_csv', methods=['GET', 'POST'])
def compare_csv_route():
    selected_files = request.form.getlist('selected_files')
    
    if len(selected_files) == 2:
        file1_path = os.path.join(app.config['UPLOAD_FOLDER'], selected_files[0])
        file2_path = os.path.join(app.config['UPLOAD_FOLDER'], selected_files[1])
        
        # Perform CSV comparison
        results1, results2 = compare_csv(file1_path, file2_path)

        return render_template('compare_results.html', results1=results1, results2=results2,
                               file1_name=selected_files[0], file2_name=selected_files[1])

    files = get_uploaded_files()
    return render_template('compare_results.html', files=files)



def get_uploaded_files():
    directory = app.config['UPLOAD_FOLDER']
    files = []
    for filename in os.listdir(directory):
        if filename.endswith('.csv'):
            file_path = os.path.join(directory, filename)
            file_info = {
                'filename': filename,
                'path': file_path,
                'creation_time': datetime.fromtimestamp(os.path.getctime(file_path)).strftime('%Y-%m-%d %H:%M:%S')
            }
            files.append(file_info)
    return files

@app.route('/audit_files')
def audit_files():
    files = get_uploaded_files()
    return render_template('audit_files.html', files=files)



@app.route('/download/<filename>')
def download_file(filename):
    file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
    return send_file(file_path, as_attachment=True)

@app.route('/about_us')
def about_us():
    return render_template('about_us.html')

# Flask-Mail configuration
app.config['MAIL_SERVER'] = 'smtp.gmail.com'  # set to whichever email type you wish to use
app.config['MAIL_PORT'] = 587
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USE_SSL'] = False
app.config['MAIL_USERNAME'] = 'youremail@email.com'
app.config['MAIL_PASSWORD'] = 'yourmailapppassword'
app.config['MAIL_DEFAULT_SENDER'] = 'youremail@email.com'

mail = Mail(app)

@app.route('/email_form/<filename>')
def email_form(filename):
    return render_template('email_form.html', selected_files=[filename])


@app.route('/send_email', methods=['POST'])
def send_email():
    user_email = request.form['user_email']
    selected_files = request.form.getlist('selected_files')

    try:
        # Create the message
        msg = Message('CSV File from Your Application', sender='youremail@email.com', recipients=[user_email])
        msg.body = "Please find the attached CSV file."

        # Attach the CSV file(s)
        for file in selected_files:
            file_path = os.path.join(app.config['UPLOAD_FOLDER'], file)

            if os.path.exists(file_path):
                with open(file_path, 'rb') as attachment:
                    msg.attach(file, 'text/csv', attachment.read())
            else:
                print(f"File not found: {file_path}")   

        # Send the email
        mail.send(msg)

        # Return a JSON response indicating success
        return jsonify(success=True)

    except Exception as e:
        # Log the error for debugging
        print(f"Error sending email: {str(e)}")

        # Return a JSON response indicating failure
        return jsonify(success=False, error=str(e))

#!!!!!!!!!!!!!!!!!!!!!deleting files function!!!!!!!!!
@app.route('/delete_file/<filename>')
def delete_file(filename):
    try:
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        
        # Check if the file exists before attempting to delete
        if os.path.exists(file_path):
            os.remove(file_path)
            return redirect(url_for('audit_files'))
        else:
            # Handle the case where the file doesn't exist
            return render_template('error.html', error_message='File not found for deletion')

    except Exception as e:
        # Log the error for debugging
        print(f"Error deleting file: {str(e)}")

        # Handle the error gracefully
        return render_template('error.html', error_message='Error deleting file')


#start of finding differences part
def find_differences(results1, results2):
    differences = []

    for result1, result2 in zip(results1, results2):
        title = result1['title']

        if result1['result'].strip() != result2['result'].strip():
            differences.append({
                'title': title,
                'result1': result1['result'],
                'result2': result2['result']
            })

    return differences




@app.route('/compare_differences', methods=['POST'])
def compare_differences_route():
    selected_files = request.form.getlist('selected_files')

    if len(selected_files) == 2:
        # Perform CSV comparison
        file1_path = os.path.join(app.config['UPLOAD_FOLDER'], selected_files[0])
        file2_path = os.path.join(app.config['UPLOAD_FOLDER'], selected_files[1])

        with open(file1_path) as f1, open(file2_path) as f2:
            csv1 = list(csv.DictReader(f1))
            csv2 = list(csv.DictReader(f2))

        # Specify the key based on which you want to compare the CSVs
        key_field = ''  # Change this to the actual key field in your CSV

        # Use csv_diff to find differences
        diff = csv_diff.diff(csv1, csv2, key=key_field, delimiter=',', quotechar='"')

        # The csv_diff function returns a list of differences
        if diff:
            differences = [
                {'title': d['key'], 'result1': d['old'], 'result2': d['new']} for d in diff
            ]
        else:
            differences = []

        print("Differences:", differences)

        return render_template('compare_results.html', differences=differences, file1_name=selected_files[0], file2_name=selected_files[1])

    files = get_uploaded_files()
    return render_template('audit_files.html', files=files)


def get_linux_distribution():
    try:
        with open('/etc/os-release', 'r') as file:
            for line in file:
                if line.startswith('ID='):
                    return line.split('=')[1].strip().strip('"')
    except FileNotFoundError:
        return 'Unknown'



@app.route('/get_os_details')
def get_os_details():
    try:        
        os_details = {
            'system': platform.system(),
            'release': platform.release(),
            'version': platform.version(),
            'architecture': platform.architecture(),
            'distribution': get_linux_distribution(),    
        }        
        return jsonify({'success': True, 'data': os_details})                
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)})
    
    



@app.route('/detect_audit_route', methods=['POST'])
def detect_audit_route():
    selected_script = '/static/scripts/Ubuntu-20.04.4.sh'
    print(selected_script)

    # Use the timestamp without spaces for filename
    timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    print("timestamp:", timestamp)
    csv_filename = f"{timestamp}.csv"

    # Adjust the script to use the custom CSV name
    script_output_path = os.path.join(app.config['UPLOAD_FOLDER'], csv_filename)

    # Run the audit script
    script_path = os.path.join('static', 'scripts', 'Ubuntu-20.04.4.sh')    
    subprocess.run(['bash', script_path, csv_filename])

    # Check if any CSV files were generated
    current_csv = glob.glob('*.csv')[0]
    
    if not current_csv:
        print("No CSV files generated.")
        return render_template('error.html', error_message="No CSV files generated.")

    # Move the latest CSV file to the 'uploads' folder
    new_csv_path = os.path.join(app.config['UPLOAD_FOLDER'], os.path.basename(current_csv))
    shutil.move(current_csv, new_csv_path)

    results = read_history_csv(new_csv_path)
    return render_template('audit_results.html', results=results, chapter_descriptions=get_chapter_descriptions())




@app.route('/feedback')
def feedback():
    return render_template('feedback.html')





@app.route('/create_custom_script', methods=['GET', 'POST'])
def create_custom_script():
    if request.method == 'POST':
        custom_script_name = request.form['custom_script_name']
        selected_chapters = request.form.getlist('selected_chapters')

        # Process selected chapters and create the custom script
        custom_script_content = generate_custom_script(selected_chapters)

        # Save the script to a file (modify the path as needed)
        script_filename = f"{custom_script_name}.sh"
        script_path = f'static/custom/{script_filename}'
        with open(script_path, 'w') as file:
            file.write(custom_script_content)

        os.chmod(script_path, 0o755)

        return render_template('custom_script_created.html', script_filename=script_filename)
    custom_script_files = glob.glob('static/custom/*.sh')



    chapter_descriptions = {
        1: "Initial Setup",
        2: "Services",
        3: "Network",
        4: "Access, Authentication, and Authorization",
        5: "Logging and Auditing",
        6: "System Maintenance",
    }

    return render_template('create_custom_script.html', chapters=range(1, 7), chapter_descriptions=chapter_descriptions, custom_script_files=custom_script_files)


def generate_custom_script(selected_chapters):
    # Load the content of each chapter script (replace these paths with your actual paths)
    chapter_scripts = []
    for chapter in selected_chapters:
        with open(f'static/indiv/chapter{chapter}.sh', 'r') as file:
            chapter_scripts.append(file.read())

    # Combine the selected chapter scripts
    custom_script_content = '\n'.join(chapter_scripts)
    return custom_script_content


@app.route('/delete_script/<filename>', methods=['POST'])
def delete_script(filename):
    file_name = filename.split('/')[-1]
    file_path = f'static/custom/{file_name}'  # Adjust the path accordingly
    if os.path.exists(file_path):
        os.remove(file_path)
    return redirect(url_for('create_custom_script'))



if __name__ == '__main__':
    if not os.path.exists(app.config['UPLOAD_FOLDER']):
        os.makedirs(app.config['UPLOAD_FOLDER'])
    
    scheduled_jobs = {}

    # Start a separate thread for running scheduled jobs
    Thread(target=run_scheduled_jobs, daemon=True).start()

    app.run(debug=True)








