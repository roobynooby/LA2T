#web_app.py
#sidenote, base functions are noted by !!!!!!!(function)!!!!
from flask_cors import CORS
import firebase_admin
from firebase_admin import credentials, firestore, db
import smtplib
from email.message import EmailMessage
import random
#new data
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


firebase_service_account ={
  "type": "service_account",
  "project_id": "audit-8e3e1",
  "private_key_id": "b1d6c738e9838f99c928c8bd53fed47d9eeb23ed",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCNAtQpgChCy0aQ\nT9OOwZecNLLpTHUDOvYTfwWnTDMhs5v3qo0LOND75kNV9gUwaOm0DPcULTX7q5j4\nIdfnprO9PVLIq/wGZ4E4PZxz6eSVtRY9qTFqst2bNpxVb0ITq1TPeYAv0IY6YP65\nRzbszIoUjx7OfDi56HsLxJ7A0N/j7Q9SYdzYnphD9cBzhzql78ViNTF6ARlPfMvB\nj8ksSfesG7g9vHp7wY30SCOmNHAP2D5oYd3j0x9/1n8SM3P0imxdTMj1lCtVK2bW\nSFcaYqvpLEvf8MLBRBhhtDaV8vCTrucZeU7CR/ZXvcm/pSjHbPR1xb3ERsIxJ1gG\n3f10LhyXAgMBAAECggEACPCMeHho/68OcVi2OKnaTZYOX6RavhKEsOtlIDGVrkXK\nQLMoekp8U/P0Vzn1I0K2H5WQ1np1SS1xpw184saamjKN5y32w4XYAd5EvG6FcN5I\nTi7F9MCT3w1hGjjRpMNAabTcumtLDzQWAgiwmTubEhREEjglioJhcUy3pHwO2E7C\nNHDfvAKMqtlOtIf/iCO1WOdz9Ob+I8T6CfSIYOlpv5S0uHJJYm0+ZDBLYKiQ9s2X\nPDIQpiHPOCjYA7JlaGCAXF4YhP6W4Egu5DZV3jOGoPsx+qYxhJkfkQ6l/0aiuXgS\nX2+okGdaaIfuFsO3mTlzSSH4ZggROJqpCltGmau4wQKBgQDAMO40dyLBCCQWv9M+\nCgQ99xxHdyRaaVdr7lFZxDDjHy8Mb0kPQnwKcl2dCiQ3+skiTAV3mSNG0UVgVi+x\nXF0rQuYTaSIgQQuValcd/lSRaFPiR0fDIP9DcBlv169/mTINXryidUJXn1wj4gmS\nwY+y6ecsNeIqvaC1fBZL9hpBVwKBgQC70+eLcw6tyyhU0RS1R/7y43Q3Lr7cHoGa\nbNscnruEsKydMb4y9MIPHvYVtpzTwrUMAFlETIcTo5sUqGqWz3i3z/5XINvn4kOL\nR4jNIIdaDGdke0o8Eqs/Dd9kPFxQLr1PPS8smZgMoMMVqhGJK2UjEphoYHNnm2Cp\nMguV3ym2wQKBgHeqf8b/Hw6d6QqZKgiI6BdFE8CTuHjq+lnjq5d/BwmD0yGk8RKl\nTOKcTxmGxQJuDmpid0z+du6TQuU3BL8kSYa0Qtl3Lp5yoanI6rFsOG/JS+GqjE48\n73OoCs6Ot2F1m6qjgESPSl2Qhih5h4hvKPA3n47xhf8izzvxJVjqxXJFAoGAIPnZ\nIwB2SUjrschrbFBRkG8ijjWkyJyKgIQwC9xKa8dg5tA+5k9WarUy2ykOa5c5lfvR\nsE4HQQluRrgyzntqZEseCkn4kcOFvEQ43lqhqMuYs2l55QYaDp3u5Hg8dM9f6TOC\nvr/QlBb9aSZModp+jSPMojaczEnZNJtWsV9WwYECgYAd9xS/mlnRtKe17i6Q4vFz\nENsewFhY7nyG/vp7ryqq5cRrLt4cLUNRVX8C77DTGBLzrgA/H7N3MeWcU3WAcoLH\nMi8IK0n/NdnfA6J92uxcQG/LHKUNlFk+8WAMoYk7lCCOmHVrQTU2ckixwYUNbLr+\n6kFDRaQWWv4UpPerBHLY1Q==\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-2bhky@audit-8e3e1.iam.gserviceaccount.com",
  "client_id": "117470328707379863706",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-2bhky%40audit-8e3e1.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}



cred = credentials.Certificate(firebase_service_account )
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://audit-8e3e1-default-rtdb.firebaseio.com/'
})



app = Flask(__name__)
CORS(app)
UPLOAD_FOLDER = 'uploads'
ALLOWED_EXTENSIONS = {'csv'}
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

scheduled_jobs = {}



# Flask-Mail configuration
app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USE_SSL'] = False
app.config['MAIL_USERNAME'] = 'rubynewby0908@gmail.com'
app.config['MAIL_PASSWORD'] = 'vybf jgym rheu akhk'
app.config['MAIL_DEFAULT_SENDER'] = 'rubynewby0908@gmail.com'

mail = Mail(app)



#all functions for scedule audit 
def get_uploaded_files():
    return [{'filename': file, 'path': os.path.join(app.config['UPLOAD_FOLDER'], file)} for file in os.listdir(app.config['UPLOAD_FOLDER'])]
@app.route('/schedule_final')
def latest_audit_files():
    files = get_uploaded_files()
    return render_template('last_audit_files.html', files=files)
@app.route('/get_audits')
def get_audits():
    ref = db.reference('/audit')
    audits = ref.get()
    if audits is None:
        audits = {}
    return jsonify(audits)
@app.route('/second_page')
def second_page():
    ref = db.reference('/audit')
    audits = ref.get()
    print("Audits fetched from Firebase:", audits)  # Debug print
    if audits is None:
        audits = {}
    return render_template('last_audit_files.html', audits=audits)

@app.route('/schedule_audit', methods=['POST'])
def schedule_audit():
    try:
        data = request.get_json()
        print("Received data:", data)  # Debug print
        
        # Further processing and Firebase posting logic here
        ref = db.reference('/audit')  # Replace with your desired reference
        ref.push(data)

        return jsonify({"success": True, "message": "Audit scheduled successfully"})
 

    except Exception as e:
        print("Error:", e)  # Debug print
        return jsonify({"success": False, "error": str(e)})
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
    

@app.route('/audit_time_reached', methods=['POST'])
def audit_time_reached():
    print("Time has reached")
    data = request.json

    email = data.get('email')
    username=data.get('auditusername')
    password=data.get('auditpassword')
    app_dir = os.path.abspath(os.path.dirname(__file__))
    script_path = os.path.join(app_dir, 'AUDITSCRIPT.sh')
    trimmed_username = data.get('auditusername').strip()
    trimmed_password = data.get('auditpassword').strip()
    trimmed_ip = data.get('ip').strip()
    status = data.get('status')
    key=data.get('key')

    success=perform_ssh_audit(script_path,trimmed_ip ,trimmed_username , trimmed_password,email)

    if success:
        status = "Successfull"
    else:
        status = "Failed"
    try:
        ref = db.reference('/audit')
    
        ref.child(key).update({
            "status": status
        })
        print(f"Updated status in Firebase for key {key} to {status}")
        return jsonify({"success": success, "message": "Audit time has been reached."})
    except Exception as e:
        print(f"Error updating status in Firebase: {e}")
        return jsonify({"success": success, "message": "Audit time has been reached."})




















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










@app.route('/delete_audit/<audit_key>', methods=['DELETE'])
def delete_audit(audit_key):
    try:
        ref = db.reference('/audit')
        ref.child(audit_key).delete()
        return jsonify({"success": True, "message": "Audit deleted successfully"})
    except Exception as e:
        return jsonify({"success": False, "message": str(e)})





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




def perform_ssh_audit(selected_script, ssh_host, ssh_user, ssh_password, recipient_email):
    """
    Function to perform SSH audit.

    Arguments:
    selected_script : str : Path to the selected audit script
    ssh_host : str : IP address or hostname of the SSH server
    ssh_user : str : Username for SSH login
    ssh_password : str : Password for SSH login
    recipient_email : str : Email address for notification

    Returns:
    bool : True if audit is successful, False otherwise
    """
    try:
        # Check if the selected script exists locally
        if not os.path.exists(selected_script):
            print("Selected script not found.")
            return False
        
        print("Selected script found. Ready to transfer.")

        # Establish an SSH connection
        with paramiko.SSHClient() as ssh_client:
            ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            try:
                ssh_client.connect(ssh_host, username=ssh_user, password=ssh_password)

                # Transfer the script to the remote machine
                local_script_path = selected_script
                remote_script_path = f'/tmp/{os.path.basename(selected_script)}'

                with ssh_client.open_sftp() as sftp:
                    sftp.put(local_script_path, remote_script_path)

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
                    return False  # Return False if execution fails

                # Fetch the resulting CSV file
                with ssh_client.open_sftp() as sftp:
                    remote_files = sftp.listdir('.')
                    remote_csv_files = [file for file in remote_files if file.endswith('.csv')]

                    if not remote_csv_files:
                        print("No CSV file generated on the remote machine.")
                        return False

                    remote_csv = remote_csv_files[0]  # Taking the first CSV file found

                    # Ensure the 'uploads' directory exists
                    uploads_dir = app.config['UPLOAD_FOLDER']
                    if not os.path.exists(uploads_dir):
                        os.makedirs(uploads_dir)

                    # Sanitize the file name to remove invalid characters
                    safe_filename = remote_csv.replace(':', '_')

                    # Use os.path.join to construct the file path
                    remote_csv_path = os.path.join(uploads_dir, safe_filename)

                    # Fetch the CSV file from the remote machine
                    try:
                        sftp.get(remote_csv, remote_csv_path)
                        print(f"CSV file downloaded successfully: {safe_filename}")

                        # Now that the CSV is downloaded, send it via email
                        send_email_with_specific_or_random_csv(recipient_email, remote_csv_path)
                    except Exception as e:
                        print(f"Error downloading CSV file: {str(e)}")
                        return False  # Return False if download fails

                    # Remove the temporary script from the remote machine
                    try:
                        sftp.remove(remote_script_path)
                    except Exception as e:
                        print(f"Error removing remote script: {str(e)}")
                        return False  # Return False if script removal fails

            except Exception as e:
                print(f"Error connecting to the remote machine: {str(e)}")
                return False  # Return False if connection fails

            finally:
                # Close the SSH connection
                ssh_client.close()

        # Return True if all steps executed successfully
        return True
    except Exception as e:
        print(f"Error performing SSH audit: {e}")
        return False  # Return False for any other unexpected errors
def send_email_with_specific_or_random_csv(recipient_email, specific_filepath, fallback_filename="random_data.csv"):
    """Sends an email with a specific CSV file if it exists, or a randomly generated one otherwise."""
    # Determine if specific file exists, else use fallback
    filename_to_send = specific_filepath if os.path.exists(specific_filepath) else generate_random_csv(fallback_filename)
    
    with app.app_context():
        msg = Message("SSH Connection Successful",
                      recipients=[recipient_email])
        msg.body = "Please find the attached CSV file."
        
        # Attach the CSV file
        with open(filename_to_send, 'rb') as fp:  # Use built-in open for filesystem paths
            msg.attach(filename_to_send, "text/csv", fp.read())
        
        mail.send(msg)
# These functions are for some purpose(email sending)
def generate_random_csv(filename="random_data.csv"):
    """Generates a CSV file with random data."""
    headers = ["ID", "Name", "Value"]
    data = [[i, f"Name_{i}", random.randint(1, 100)] for i in range(1, 11)]
    
    with open(filename, mode='w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(headers)
        writer.writerows(data)

    return filename








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
app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USE_SSL'] = False
app.config['MAIL_USERNAME'] = 'rubynewby0908@gmail.com'
app.config['MAIL_PASSWORD'] = 'vybf jgym rheu akhk'
app.config['MAIL_DEFAULT_SENDER'] = 'rubynewby0908@gmail.com'

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
        msg = Message('CSV File from Your Application', sender='rubynewby0908@gmail.com', recipients=[user_email])
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

#!!!!!!!!!!!!!!!!!!!!deleting files function!!!!!!!!!
# @app.route('/delete_file/<filename>')
# def delete_file(filename):
#     try:
#         file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        
#         # Check if the file exists before attempting to delete
#         if os.path.exists(file_path):
#             os.remove(file_path)
#             return redirect(url_for('audit_files'))
#         else:
#             # Handle the case where the file doesn't exist
#             return render_template('error.html', error_message='File not found for deletion')

#     except Exception as e:
#         # Log the error for debugging
#         print(f"Error deleting file: {str(e)}")

#         # Handle the error gracefully
#         return render_template('error.html', error_message='Error deleting file')


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








