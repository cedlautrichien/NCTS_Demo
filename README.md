This project is a demo project demonstrating how to send (transit) customs declarations to the test environment of Austrian customs, using the Robot Framework, Python, a few standard Python libraries and template messages.
It is designed to be usable by non-technical users, as the Robot Framework keywords are written in BDD (Behaviour-Driven Development) form. In order to get credentials, you need to be an Austrian company and apply on the portal https://usp.gv.at.
The corresponding documentation is publicly available on the website of the Austrian Finance Ministry : https://www.bmf.gv.at

If you are interested in this project and/or would like to get assistance, feel free to contact me on my LinkedIn page.

Steps :
1/ Install the latest version of Python on your machine
2/ In the NCTS_DEMO folder, create a Python virtual environment 
3/ Activate the newly created virtual environment
4/ Install the Robot Framework using PyPI. Command : pip install robotframework
5/ Install the Python library 'Requests'. Command : pip install requests
6/ In the file secrets.robot, add your TXM credentials provided through the USP website
7/ Run the test suite. Command : robot 01__BDD.robot 
