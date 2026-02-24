*** Settings ***
Library    endpoints.py
Library    Collections
Library    OperatingSystem
Library    String
Library    DateTime
Resource   secrets.robot
Resource   keywords.resource
    
*** Test Cases ***
Check connection with CTW
    [Tags]    connectivity
    # Check if CTW is online
    Test connection with CTW-in
    Test connection with CTW-out

Send 015C declarations to CTW-in
    [Tags]    acceptance
    Send one normal CC015C message and receive one CC928C message
    Send one invalid CC015C message and receive one CC056C message
    Send one simplified CC015C message and receive simultaneously one CC928C message and one CC028C message
