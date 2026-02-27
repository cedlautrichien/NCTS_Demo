*** Settings ***
Library    endpoints.py
Library    Collections
Library    OperatingSystem
Library    String
Library    DateTime

*** Variables ***
${LRNPREFIX}    CM

*** Keywords ***
Get credentials
    [Arguments]    ${username}    ${password}
    Should Not Be Empty    ${username}
    Should Not Be Empty    ${password}

Test connection with CTW-in
    ${xml_template}     Get File    ${CURDIR}/Templates/testCTW.xml
    ${soap_body}=   Replace String    ${xml_template}    USERNAME    ${USERNAME}
    ${soap_body}=   Replace String    ${soap_body}    PASSWORD    ${PASSWORD}
    ${response}    ctw_in    body=${soap_body}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    ${response.content}
    Should Contain    ${response.content}    <result>Hallo user! Erfolgreich bei CTW InServices angekommen.</result>

Test connection with CTW-out
    ${xml_template}     Get File    ${CURDIR}/Templates/testCTW.xml
    ${soap_body}   Replace String    ${xml_template}    USERNAME    ${USERNAME}
    ${soap_body}   Replace String    ${soap_body}    PASSWORD    ${PASSWORD}
    ${response}    ctw_out    body=${soap_body}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    ${response.content}
    Should Contain    ${response.content}    <result>Hallo user! Erfolgreich bei CTW OutServices angekommen.</result>

Send one ${015C_type} message and receive one ${msg_type} message
    
    ${xml_template}     Get File    ${CURDIR}/Templates/${015C_type}.xml
    ${icref}    Generate Random String    12    [NUMBERS]
    ${lrnlower}    Generate Random String    12    [LETTERS]
    ${lrnsuffix}    Convert To Uppercase    ${lrnlower}
    ${date1}    Get Current Date    result_format=%Y-%m-%dT%H:%M:%S
    ${date2}    Get Current Date    result_format=%Y-%m-%d
    ${date3}    Get Current Date    result_format=%Y%m%d%H%M%S    
    ${soap_body}   Replace String    ${xml_template}    USERNAME    ${USERNAME}
    ${soap_body}   Replace String    ${soap_body}    PASSWORD    ${PASSWORD}
    ${soap_body}   Replace String    ${soap_body}    ICREF    ${icref}
    ${soap_body}   Replace String    ${soap_body}    LRNPREFIX    ${LRNPREFIX}
    ${soap_body}   Replace String    ${soap_body}        LRNSUFFIX     ${lrnsuffix}
    ${soap_body}   Replace String     ${soap_body}        DATE1     ${date1}
    ${soap_body}   Replace String     ${soap_body}        DATE2     ${date2}
    ${soap_body}   Replace String     ${soap_body}        DATE3     ${date3}
    ${response}    ctw_in   body=${soap_body}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    ${response.content}   
    Sleep    30s
    ${xml_template}     Get File    ${CURDIR}/Templates/ctwOut.xml
    ${soap_body}   Replace String    ${xml_template}    USERNAME    ${USERNAME}
    ${soap_body}   Replace String    ${soap_body}    PASSWORD    ${PASSWORD}
    ${response}    ctw_out   body=${soap_body}
    Should Be Equal As Strings    ${response.status_code}    200
    Should Contain    ${response.content}    ns2:MsgTyp>${msg_type}
    Should Contain    ${response.content}    ns2:OICRef>${icref}
    Should Contain    ${response.content}    LRN>${LRNPREFIX}_${lrnsuffix}
    Log    ${response.content}

Send one ${015C_type} message and receive simultaneously one ${msg_type1} message and one ${msg_type2} message
    
    ${xml_template}     Get File    ${CURDIR}/Templates/${015C_type}.xml
    ${icref}    Generate Random String    12    [NUMBERS]
    ${lrnlower}    Generate Random String    12    [LETTERS]
    ${lrnsuffix}    Convert To Uppercase    ${lrnlower}
    ${date1}    Get Current Date    result_format=%Y-%m-%dT%H:%M:%S
    ${date2}    Get Current Date    result_format=%Y-%m-%d
    ${date3}    Get Current Date    result_format=%Y%m%d%H%M%S    
    ${soap_body}   Replace String    ${xml_template}    USERNAME    ${USERNAME}
    ${soap_body}   Replace String    ${soap_body}    PASSWORD    ${PASSWORD}
    ${soap_body}   Replace String    ${soap_body}    ICREF    ${icref}
    ${soap_body}   Replace String    ${soap_body}    LRNPREFIX    ${LRNPREFIX}
    ${soap_body}   Replace String    ${soap_body}        LRNSUFFIX     ${lrnsuffix}
    ${soap_body}   Replace String     ${soap_body}        DATE1     ${date1}
    ${soap_body}   Replace String     ${soap_body}        DATE2     ${date2}
    ${soap_body}   Replace String     ${soap_body}        DATE3     ${date3}
    ${response}    ctw_in   body=${soap_body}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    ${response.content}
    Sleep    10s
    ${xml_template}     Get File    ${CURDIR}/Templates/ctwOut.xml
    ${soap_body}   Replace String    ${xml_template}    USERNAME    ${USERNAME}
    ${soap_body}   Replace String    ${soap_body}    PASSWORD    ${PASSWORD}
    ${response}    ctw_out   body=${soap_body}
    Should Be Equal As Strings    ${response.status_code}    200
    Should Contain    ${response.content}    ns2:MsgTyp>${msg_type1}
    Should Contain    ${response.content}    ns2:MsgTyp>${msg_type2}
    Should Contain    ${response.content}    ns2:OICRef>${icref}
    Should Contain    ${response.content}    LRN>${LRNPREFIX}_${lrnsuffix}
    Log    ${response.content}
