*** Settings ***
Library    endpoints.py
Library    Collections
Library    OperatingSystem
Library    String
Library    DateTime
Resource   keywords.resource 

*** Test Cases ***
Prepare test environment
    [Tags]    setup
    Get credentials    ${USERNAME}    ${PASSWORD}

Check connection with CTW
    [Tags]    connectivity
    Test connection with CTW-in
    Test connection with CTW-out

Send 015C declarations to CTW-in
    [Tags]    acceptance
    Send one normal CC015C message and receive one CC928C message
    Send one invalid CC015C message and receive one CC056C message
    Send one simplified CC015C message and receive simultaneously one CC928C message and one CC028C message
