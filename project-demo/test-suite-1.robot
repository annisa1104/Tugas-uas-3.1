*** Settings ***
Library           SeleniumLibrary

*** variables ***
${BROWSER}     chrome
${HOST}    http://localhost/web-1/login.php

${USER}    ICHA
${PASS-1}    123456    # correct password
${PASS-2}    xxs12s2    # wrong password

${COMPANY}    global.inc
${TITLE}    [TEST] Senior Engineering manager
${LOCATION}     Singapore
${TAGS}    engineering manager software
${JOBEMAIL}    jobs@global.co
${WEBSITE}    https://global.co
${DESCRIPTION}     Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

*** Test Cases ***

  

# Positive Test - Login
testcase-1 Login
    Open Browser    ${HOST}    ${BROWSER}
    Page Should Contain    Login
    Page Should Contain Element   xpath://input[@name='username']
    input text        name:username       ${USER}
    input text        name:password    ${PASS-1}
    Click Element     xpath://button[@type='submit']
    Page Should Contain    Daftar Produk
    Sleep    2s 

# logout
testcase-2
    Login Success
    Click Element     xpath://a[@id='logout']
    Sleep    5s
    Close Browser 

#register
testcase-3
    Open Browser    ${HOST}    ${BROWSER}
    Page Should Contain    Login
    Click Element     xpath://a[@type='register']
    Input Text    name:username    userbaru
    Input Text    name:password    1234
    Click Element     xpath://button[@type='daftar']
    Click Element     xpath://a[@type='login']
    Page Should Contain Element   xpath://input[@name='username']
    input text        name:username    userbaru
    input text        name:password    1234
    Click Element     xpath://button[@type='submit']
    Page Should Contain    Daftar Produk
    Sleep    2s 

#post job
testcase-4
    Login Success
    Click Element     xpath://a[@type='tambah']
    Input Text    name:nama_produk    JORAN SIMANO
    Input Text    name:harga    500000
    Input Text    name:stok    50
    Click Element     xpath://button[@type='submit']
    Page Should Contain    Daftar Produk
    Sleep    2s 

#edit
testcase-5
    Login Success
    Click Element     xpath://a[@href='edit.php?id=2']
    Input Text    name:nama_produk    KAIL NO 12
    Input Text    name:harga    150000
    Input Text    name:stok    100
    Click Button    xpath://button[@type='submit']
    Page Should Contain    Daftar Produk
    Sleep    2s
    
testcase-6
    Login Success
    Click Element     xpath://a[@href='/listings/create']
    Page Should Contain Element   xpath://input[@name='company']
    sleep     5s
    Scroll Down Until End

*** Keywords ***

Scroll Down Until End
    ${previous_height}=    Execute Javascript    return document.body.scrollHeight;
    FOR  ${i}    IN RANGE    10
        Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
        Sleep    1s
        ${current_height}=    Execute Javascript    return document.body.scrollHeight;
        Exit For Loop If    '${current_height}' == '${previous_height}'
        ${previous_height}=    Set Variable    ${current_height}
        Sleep    2s
    END

Login Success
   Open Browser    ${HOST}    ${BROWSER}
    Page Should Contain    Login
    Page Should Contain Element   xpath://input[@name='username']
    input text        name:username       ${USER}
    input text        name:password    ${PASS-1}
    Click Element     xpath://button[@type='submit']
    Page Should Contain    Daftar Produk