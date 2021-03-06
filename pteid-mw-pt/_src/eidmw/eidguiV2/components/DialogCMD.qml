/*-****************************************************************************

 * Copyright (C) 2018-2019 Miguel Figueira - <miguel.figueira@caixamagica.pt>
 * Copyright (C) 2018-2019 Adriano Campos - <adrianoribeirocampos@gmail.com>
 * Copyright (C) 2019 José Pinto - <jose.pinto@caixamagica.pt>
 *
 * Licensed under the EUPL V.1.1

****************************************************************************-*/

import QtQuick 2.6
import QtQuick.Controls 2.1

/* Constants imports */
import "../scripts/Constants.js" as Constants
import "../scripts/Functions.js" as Functions

//Import C++ defined enums
import eidguiV2 1.0

Item {
    // Center dialog in the main view
    x: - mainMenuView.width - subMenuView.width
        + mainView.width * 0.5 - dialogCMDProgress.width * 0.5
    y: parent.height * 0.5 - dialogSignCMD.height * 0.5

    Connections {
        target: gapi
        onSignalOpenCMDSucess: {
            console.log("Signal Open CMD Sucess")
            progressBarIndeterminate.visible = false
            rectReturnCode.visible = true
            buttonCMDProgressConfirm.visible = true
            textFieldReturnCode.forceActiveFocus()
        }
        onSignalCloseCMDSucess: {
            console.log("Signal Close CMD Sucess")
            progressBarIndeterminate.visible = false
            rectReturnCode.visible = false
            rectLabelCMDText.visible = true
            buttonCMDProgressConfirm.visible = true
            buttonCMDProgressConfirm.text = qsTranslate("Popup File","STR_POPUP_FILE_OPEN")
            buttonCMDProgressConfirm.forceActiveFocus()
        }
        onSignalUpdateProgressBar: {
            console.log("CMD sign change --> update progress bar with value = " + value)
            rectReturnCode.visible = false
            progressBar.value = value
            if(value === 100) {
                progressBarIndeterminate.visible = false
            }
        }
        onSignalUpdateProgressStatus: {
            console.log("CMD sign change --> update progress status with text = " + statusMessage)
            rectReturnCode.visible = false
            textMessageTop.propertyText.text = statusMessage
            textMessageTop.propertyAccessibleText = statusMessage
            textMessageTop.forceActiveFocus()
        }
        onSignalShowLoadAttrButton:{
            buttonSCAPLoadAttributes.visible = true
            rectLabelCMDText.visible = true
            labelCMDText.text = qsTranslate("Popup File","STR_POPUP_LOAD_SCAP_ATTR")
        }
    }

    Dialog {
        id: dialogSignCMD
        width: 600
        height: 300
        font.family: lato.name
        modal: true

        header: Label {
            id: labelTextTitle
            text: qsTranslate("PageServicesSign","STR_SIGN_CMD")
            visible: true
            elide: Label.ElideRight
            padding: 24
            bottomPadding: 0
            font.bold: rectPopUp.activeFocus
            font.pixelSize: Constants.SIZE_TEXT_MAIN_MENU
            color: Constants.COLOR_MAIN_BLUE
        }

        Item {
            id: rectPopUp
            width: parent.width
            height: rectMessageTopLogin.height + rectMobilNumber.height + rectPin.height

            Keys.enabled: true
            Keys.onPressed: {
                if(event.key===Qt.Key_Enter || event.key===Qt.Key_Return
                        && textFieldMobileNumber.length !== 0 && textFieldPin.length !== 0)
                {
                    signCMD()
                }
            }
            Accessible.role: Accessible.AlertMessage
            Accessible.name: qsTranslate("Popup Card","STR_SHOW_WINDOWS")
                             + labelTextTitle.text
            KeyNavigation.tab: textLinkCMD.propertyText
            KeyNavigation.down: textLinkCMD.propertyText
            KeyNavigation.right: textLinkCMD.propertyText
            KeyNavigation.backtab: okButton
            KeyNavigation.up: okButton

            Item {
                id: rectMessage
                width: parent.width
                height: 25
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rectPopUp.top
                Link {
                    id: textLinkCMD
                    width: parent.width
                    propertyText.text: "<a href='https://www.autenticacao.gov.pt/cmd-pedido-chave'>"
                            + qsTranslate("PageServicesSign","STR_SIGN_CMD_URL")
                    propertyText.font.italic: true
                    propertyText.verticalAlignment: Text.AlignVCenter
                    anchors.verticalCenter: parent.verticalCenter
                    propertyText.font.pixelSize: Constants.SIZE_TEXT_LABEL
                    propertyAccessibleText: qsTranslate("PageServicesSign","STR_SIGN_CMD_URL")
                    propertyLinkUrl: 'https://www.autenticacao.gov.pt/cmd-pedido-chave'
                    KeyNavigation.tab: textMessageTopLogin
                    KeyNavigation.down: textMessageTopLogin
                    KeyNavigation.right: textMessageTopLogin
                    KeyNavigation.backtab: rectPopUp
                    KeyNavigation.up: rectPopUp
                }
            }
            Item {
                id: rectMessageTopLogin
                width: parent.width
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rectMessage.bottom
                Text {
                    id: textMessageTopLogin
                    text: qsTranslate("PageServicesSign","STR_SIGN_INSERT_LOGIN")
                    verticalAlignment: Text.AlignVCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: Constants.SIZE_TEXT_LABEL
                    font.family: lato.name
                    font.bold: activeFocus
                    color: Constants.COLOR_TEXT_LABEL
                    height: parent.height
                    width: parent.width
                    anchors.bottom: parent.bottom
                    wrapMode: Text.WordWrap
                    Accessible.role: Accessible.StaticText
                    Accessible.name: text + textMobileNumber.text + textPin.text
                    KeyNavigation.tab: comboBoxIndicative
                    KeyNavigation.down: comboBoxIndicative
                    KeyNavigation.right: comboBoxIndicative
                    KeyNavigation.backtab: textLinkCMD.propertyText
                    KeyNavigation.up: textLinkCMD.propertyText
                }
            }
            Item {
                id: rectMobilNumber
                width: parent.width
                height: 50
                anchors.top: rectMessageTopLogin.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    id: textMobileNumber
                    text: qsTranslate("PageServicesSign","STR_SIGN_CMD_MOVEL_NUM")
                    verticalAlignment: Text.AlignVCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: Constants.SIZE_TEXT_LABEL
                    font.family: lato.name
                    font.bold: activeFocus
                    color: Constants.COLOR_TEXT_BODY
                    height: parent.height
                    width: parent.width * 0.3
                    anchors.bottom: parent.bottom
                }
                ComboBox {
                    id: comboBoxIndicative
                    width: parent.width * 0.4
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    model: PhoneCountriesCodeListModel{}
                    font.family: lato.name
                    font.pixelSize: Constants.SIZE_TEXT_FIELD
                    font.capitalization: Font.MixedCase
                    font.bold: activeFocus
                    visible: true
                    anchors.left: textMobileNumber.right
                    anchors.bottom: parent.bottom
                    onCurrentIndexChanged: {
                        if(comboBoxIndicative.currentIndex >= 0){
                            propertyPageLoader.propertyBackupMobileIndicatorIndex = comboBoxIndicative.currentIndex
                        }else{
                            comboBoxIndicative.currentIndex = propertyPageLoader.propertyBackupMobileIndicatorIndex
                        }
                    }
                    Accessible.role: Accessible.ComboBox
                    Accessible.name: currentText
                    KeyNavigation.tab: textFieldMobileNumber
                    KeyNavigation.down: textFieldMobileNumber
                    KeyNavigation.right: textFieldMobileNumber
                    KeyNavigation.backtab: textLinkCMD.propertyText
                    KeyNavigation.up: textLinkCMD.propertyText
                }
                TextField {
                    id: textFieldMobileNumber
                    width: parent.width * 0.25
                    anchors.verticalCenter: parent.verticalCenter
                    font.italic: textFieldMobileNumber.text === "" ? true: false
                    placeholderText: qsTranslate("PageServicesSign","STR_SIGN_CMD_MOVEL_NUM_OP") + "?"
                    validator: RegExpValidator { regExp: /[0-9]+/ }
                    maximumLength: 15
                    font.family: lato.name
                    font.pixelSize: Constants.SIZE_TEXT_FIELD
                    font.bold: activeFocus
                    clip: false
                    anchors.left: comboBoxIndicative.right
                    anchors.leftMargin:  parent.width * 0.05
                    anchors.bottom: parent.bottom
                    onEditingFinished: {
                        // CMD load backup mobile data
                        propertyPageLoader.propertyBackupMobileNumber = textFieldMobileNumber.text
                    }
                    Accessible.role: Accessible.EditableText
                    Accessible.name: textMobileNumber.text
                    KeyNavigation.tab: textFieldPin
                    KeyNavigation.down: textFieldPin
                    KeyNavigation.right: textFieldPin
                    KeyNavigation.backtab: comboBoxIndicative
                    KeyNavigation.up: comboBoxIndicative
                }
            }
            Item {
                id: rectPin
                width: parent.width
                height: 50
                anchors.top: rectMobilNumber.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    id: textPin
                    text: qsTranslate("PageServicesSign","STR_SIGN_CMD_PIN")
                    verticalAlignment: Text.AlignVCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: Constants.SIZE_TEXT_LABEL
                    font.family: lato.name
                    font.bold: activeFocus
                    color: Constants.COLOR_TEXT_BODY
                    height: parent.height
                    width: parent.width * 0.3
                    anchors.bottom: parent.bottom
                }
                TextField {
                    id: textFieldPin
                    width: parent.width * 0.7
                    anchors.verticalCenter: parent.verticalCenter
                    font.italic: textFieldPin.text === "" ? true: false
                    placeholderText: qsTranslate("PageServicesSign","STR_SIGN_CMD_PIN_OP") + "?"
                    validator: RegExpValidator { regExp: /[0-9]{4,8}/ }
                    echoMode : TextInput.Password
                    font.family: lato.name
                    font.pixelSize: Constants.SIZE_TEXT_FIELD
                    font.bold: activeFocus
                    clip: false
                    anchors.left: textPin.right
                    anchors.bottom: parent.bottom
                    Accessible.role: Accessible.EditableText
                    Accessible.name: textPin.text
                    KeyNavigation.tab: cancelButton
                    KeyNavigation.down: cancelButton
                    KeyNavigation.right: cancelButton
                    KeyNavigation.backtab: textFieldMobileNumber
                    KeyNavigation.up: textFieldMobileNumber

                    Keys.onEnterPressed: {
                        if(okButton.enabled) signCMD()
                    }
                    Keys.onReturnPressed: {
                        if(okButton.enabled) signCMD()
                    }
                }
            }
            Item {
                width: dialogSignCMD.availableWidth
                height: Constants.HEIGHT_BOTTOM_COMPONENT
                anchors.horizontalCenter: parent.horizontalCenter
                y: 190
                Button {
                    id: cancelButton
                    width: Constants.WIDTH_BUTTON
                    height: Constants.HEIGHT_BOTTOM_COMPONENT
                    text: qsTranslate("PageServicesSign","STR_CMD_POPUP_CANCEL")
                    anchors.left: parent.left
                    font.pixelSize: Constants.SIZE_TEXT_FIELD
                    font.family: lato.name
                    font.capitalization: Font.MixedCase
                    highlighted: activeFocus ? true : false
                    onClicked: {
                        gapi.cancelCMDSign();
                        dialogSignCMD.close()
                        textFieldPin.text = ""
                        mainFormID.opacity = Constants.OPACITY_MAIN_FOCUS
                        mainFormID.propertyPageLoader.forceActiveFocus()
                    }
                    Keys.onEnterPressed: {
                        gapi.cancelCMDSign();
                        dialogSignCMD.close()
                        textFieldPin.text = ""
                        mainFormID.opacity = Constants.OPACITY_MAIN_FOCUS
                        mainFormID.propertyPageLoader.forceActiveFocus()
                    }
                    Keys.onReturnPressed: {
                        gapi.cancelCMDSign();
                        dialogSignCMD.close()
                        textFieldPin.text = ""
                        mainFormID.opacity = Constants.OPACITY_MAIN_FOCUS
                        mainFormID.propertyPageLoader.forceActiveFocus()
                    }
                    Accessible.role: Accessible.Button
                    Accessible.name: text
                    KeyNavigation.tab: okButton
                    KeyNavigation.down: okButton
                    KeyNavigation.right: okButton
                    KeyNavigation.backtab: textFieldPin
                    KeyNavigation.up: textFieldPin
                }
                Button {
                    id: okButton
                    width: Constants.WIDTH_BUTTON
                    height: Constants.HEIGHT_BOTTOM_COMPONENT
                    text: qsTranslate("PageServicesSign","STR_CMD_POPUP_CONFIRM")
                    anchors.right: parent.right
                    font.pixelSize: Constants.SIZE_TEXT_FIELD
                    font.family: lato.name
                    font.capitalization: Font.MixedCase
                    enabled: textFieldMobileNumber.acceptableInput && textFieldPin.acceptableInput
                    highlighted: activeFocus ? true : false
                    onClicked: {
                        signCMD()
                    }
                    Keys.onEnterPressed: {
                        signCMD()
                    }
                    Keys.onReturnPressed: {
                        signCMD()
                    }
                    Accessible.role: Accessible.Button
                    Accessible.name: text
                    KeyNavigation.tab: rectPopUp
                    KeyNavigation.down: rectPopUp
                    KeyNavigation.right: rectPopUp
                    KeyNavigation.backtab: cancelButton
                    KeyNavigation.up: cancelButton
                }
            }
        }
        onRejected:{
            // Reject CMD Popup's only with ESC key
            dialogSignCMD.open()
        }
        onOpened: {
            textFieldMobileNumber.forceActiveFocus()
        }
        onClosed: {
            mainFormID.opacity = Constants.OPACITY_MAIN_FOCUS
            mainFormID.propertyPageLoader.forceActiveFocus()
        }
    }
    Dialog {
        id: dialogCMDProgress
        width: 600
        height: 300
        font.family: lato.name
        modal: true

        header: Label {
            id: labelTextTitleProgress
            text: qsTranslate("PageServicesSign","STR_SIGN_CMD")
            visible: true
            elide: Label.ElideRight
            padding: 24
            bottomPadding: 0
            font.bold: rectPopUpProgress.activeFocus
            font.pixelSize: Constants.SIZE_TEXT_MAIN_MENU
            color: Constants.COLOR_MAIN_BLUE
        }
        ProgressBar {
            id: progressBar
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            height: 20
            to: 100
            value: 0
            visible: true
            indeterminate: false
            z:1
        }

        Item {
            id: rectPopUpProgress
            width: parent.width
            height: rectMessageTop.height + rectReturnCode.height + progressBarIndeterminate.height
            anchors.top: progressBar.bottom

            Keys.enabled: true
            Keys.onPressed: {
                if(event.key===Qt.Key_Enter || event.key===Qt.Key_Return && buttonCMDProgressConfirm.visible == true)
                {
                    signCMDConfirm()
                }
            }
            Accessible.role: Accessible.AlertMessage
            Accessible.name: qsTranslate("Popup Card","STR_SHOW_WINDOWS")
                             + labelTextTitleProgress.text
            KeyNavigation.tab: textMessageTop
            KeyNavigation.down: textMessageTop
            KeyNavigation.right: textMessageTop
            KeyNavigation.backtab: buttonCMDProgressConfirm
            KeyNavigation.up: buttonCMDProgressConfirm

            Item {
                id: rectMessageTop
                width: parent.width
                height: 75
                anchors.horizontalCenter: parent.horizontalCenter
                Link {
                    id: textMessageTop
                    width: parent.width
                    height: parent.height
                    propertyText.text: ""
                    propertyText.font.pixelSize: Constants.SIZE_TEXT_LABEL
                    propertyText.color: Constants.COLOR_TEXT_LABEL
                    propertyText.wrapMode: Text.WordWrap
                    propertyText.height: parent.height
                    propertyText.width: parent.width
                    propertyText.font.bold: activeFocus? true : false
                    KeyNavigation.tab: rectLabelCMDText.visible ? labelCMDText : (rectReturnCode.visible ? textFieldReturnCode:closeButton)
                    KeyNavigation.down: rectLabelCMDText.visible ? labelCMDText : (rectReturnCode.visible ? textFieldReturnCode:closeButton)
                    KeyNavigation.right: rectLabelCMDText.visible ? labelCMDText : (rectReturnCode.visible ? textFieldReturnCode:closeButton)
                    KeyNavigation.backtab: rectPopUpProgress
                    KeyNavigation.up: rectPopUpProgress
                }
            }
            Item {
                id: rectLabelCMDText
                width: parent.width
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rectMessageTop.bottom
                anchors.topMargin: -15
                visible: false
                Text {
                    id: labelCMDText
                    text: (filesModel.count == 1 ? qsTranslate("PageServicesSign","STR_SIGN_OPEN") :
                                                   qsTranslate("PageServicesSign","STR_SIGN_OPEN_MULTI"))
                    font.pixelSize: Constants.SIZE_TEXT_LABEL
                    font.family: lato.name
                    font.bold: activeFocus
                    color: Constants.COLOR_TEXT_LABEL
                    height: parent.height
                    width: parent.width
                    wrapMode: Text.Wrap
                    Accessible.role: Accessible.StaticText
                    Accessible.name: text
                    KeyNavigation.tab: closeButton
                    KeyNavigation.down: closeButton
                    KeyNavigation.right: closeButton
                    KeyNavigation.backtab: textMessageTop
                    KeyNavigation.up: textMessageTop
                }
            }
            Item {
                id: rectReturnCode
                width: parent.width
                height: 50
                anchors.top: rectMessageTop.bottom
                anchors.topMargin: -15
                anchors.horizontalCenter: parent.horizontalCenter
                visible: false
                Text {
                    id: textReturnCode
                    text: qsTranslate("PageServicesSign","STR_SIGN_CMD_CODE") + ":"
                    verticalAlignment: Text.AlignVCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: Constants.SIZE_TEXT_LABEL
                    font.family: lato.name
                    font.bold: activeFocus
                    color: Constants.COLOR_TEXT_BODY
                    height: parent.height
                    width: parent.width * 0.5
                    anchors.bottom: parent.bottom
                }
                TextField {
                    id: textFieldReturnCode
                    width: parent.width * 0.5
                    anchors.verticalCenter: parent.verticalCenter
                    font.italic: textFieldReturnCode.text === "" ? true: false
                    placeholderText: qsTranslate("PageServicesSign","STR_SIGN_CMD_CODE_OP") + "?"
                    validator: RegExpValidator { regExp: /^[0-9]{6}$/ }
                    font.family: lato.name
                    font.pixelSize: Constants.SIZE_TEXT_FIELD
                    font.bold: activeFocus
                    clip: false
                    anchors.left: textReturnCode.right
                    anchors.bottom: parent.bottom
                    Accessible.role: Accessible.EditableText
                    Accessible.name: textReturnCode.text
                    KeyNavigation.tab: closeButton
                    KeyNavigation.down: closeButton
                    KeyNavigation.right: closeButton
                    KeyNavigation.backtab: labelCMDText
                    KeyNavigation.up: labelCMDText

                    Keys.onEnterPressed: {
                        if(buttonCMDProgressConfirm.enabled) signCMDConfirm()
                    }
                    Keys.onReturnPressed: {
                        if(buttonCMDProgressConfirm.enabled) signCMDConfirm()
                    }
                }
            }

            ProgressBar {
                id: progressBarIndeterminate
                width: parent.width
                anchors.top: rectReturnCode.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                height: 20
                to: 100
                value: 0
                visible: true
                indeterminate: true
                z:1
            }
        }

        Item {
            width: dialogCMDProgress.availableWidth
            height: Constants.HEIGHT_BOTTOM_COMPONENT
            anchors.horizontalCenter: parent.horizontalCenter
            y: 190
            Button {
                id: closeButton
                width: Constants.WIDTH_BUTTON
                height: Constants.HEIGHT_BOTTOM_COMPONENT
                text: qsTranslate("PageServicesSign","STR_CMD_POPUP_CANCEL")
                anchors.left: parent.left
                font.pixelSize: Constants.SIZE_TEXT_FIELD
                font.family: lato.name
                font.capitalization: Font.MixedCase
                highlighted: activeFocus ? true : false
                onClicked: {
                    gapi.cancelCMDSign();
                    dialogCMDProgress.close()
                    rectReturnCode.visible = false
                }
                Keys.onEnterPressed: {
                    gapi.cancelCMDSign();
                    dialogCMDProgress.close()
                    rectReturnCode.visible = false
                }
                Keys.onReturnPressed: {
                    gapi.cancelCMDSign();
                    dialogCMDProgress.close()
                    rectReturnCode.visible = false
                }
                Accessible.role: Accessible.Button
                Accessible.name: text
                KeyNavigation.tab: buttonCMDProgressConfirm.visible ? buttonCMDProgressConfirm : buttonSCAPLoadAttributes
                KeyNavigation.down: buttonCMDProgressConfirm.visible ? buttonCMDProgressConfirm : buttonSCAPLoadAttributes
                KeyNavigation.right: buttonCMDProgressConfirm.visible ? buttonCMDProgressConfirm : buttonSCAPLoadAttributes
                KeyNavigation.backtab: textFieldReturnCode
                KeyNavigation.up: textFieldReturnCode
            }
            Button {
                property var isOpenFile: false

                id: buttonCMDProgressConfirm
                width: Constants.WIDTH_BUTTON
                height: Constants.HEIGHT_BOTTOM_COMPONENT
                text: qsTranslate("PageServicesSign","STR_CMD_POPUP_CONFIRM")
                anchors.right: parent.right
                font.pixelSize: Constants.SIZE_TEXT_FIELD
                font.family: lato.name
                font.capitalization: Font.MixedCase
                enabled: textFieldReturnCode.acceptableInput || isOpenFile
                visible: false
                highlighted: activeFocus ? true : false
                onClicked: {
                    signCMDConfirm()
                }
                Keys.onEnterPressed: {
                    signCMDConfirm()
                }
                Keys.onReturnPressed: {
                    signCMDConfirm()
                }
                Accessible.role: Accessible.Button
                Accessible.name: text
                KeyNavigation.tab: rectPopUpProgress
                KeyNavigation.down: rectPopUpProgress
                KeyNavigation.right: rectPopUpProgress
                KeyNavigation.backtab: closeButton
                KeyNavigation.up: closeButton
            }
            Button {
                id: buttonSCAPLoadAttributes
                width: Constants.WIDTH_BUTTON
                height: Constants.HEIGHT_BOTTOM_COMPONENT
                text: qsTranslate("PageServicesSign","STR_LOAD_SCAP_ATTRIBUTES")
                anchors.right: parent.right
                font.pixelSize: Constants.SIZE_TEXT_FIELD
                font.family: lato.name
                font.capitalization: Font.MixedCase
                enabled: textFieldReturnCode.acceptableInput || isOpenFile
                visible: false
                highlighted: activeFocus ? true : false
                onClicked: {
                    loadSCAPAttributes()
                }
                Keys.onEnterPressed: {
                    loadSCAPAttributes()
                }
                Keys.onReturnPressed: {
                    loadSCAPAttributes()
                }
                Accessible.role: Accessible.Button
                Accessible.name: text
                KeyNavigation.tab: rectPopUpProgress
                KeyNavigation.down: rectPopUpProgress
                KeyNavigation.right: rectPopUpProgress
                KeyNavigation.backtab: closeButton
                KeyNavigation.up: closeButton
            }
        }
        onOpened: {
            rectPopUpProgress.forceActiveFocus()
        }
        onRejected:{
            // Reject CMD Popup's only with ESC key
            dialogCMDProgress.open()
        }
        onClosed: {
            mainFormID.opacity = Constants.OPACITY_MAIN_FOCUS
            mainFormID.propertyPageLoader.forceActiveFocus()
        }
    }

    Component.onCompleted: {
        textFieldMobileNumber.text = propertyPageLoader.propertyBackupMobileNumber
    }

    function open() {
        buttonCMDProgressConfirm.isOpenFile = false
        dialogSignCMD.open()
        mainFormID.opacity = Constants.OPACITY_POPUP_FOCUS
    }
    function close() {
        dialogSignCMD.close()
        dialogCMDProgress.close()
        mainFormID.opacity = Constants.OPACITY_MAIN_FOCUS
    }
    function signCMD(){
        var loadedFilePaths = []
        for (var fileIndex = 0; fileIndex < filesModel.count; fileIndex++) {
            loadedFilePaths.push(filesModel.get(fileIndex).fileUrl)
        }
        
        var outputFile = ""
        if (filesModel.count == 1) {
            outputFile = propertyFileDialogCMDOutput.fileUrl.toString()
        }
        else {
            outputFile = propertyFileDialogBatchCMDOutput.fileUrl.toString()
        }
        outputFile = decodeURIComponent(Functions.stripFilePrefix(outputFile))

        var page = 1
        if(propertyCheckLastPage.checked) {
            page = 0 // Sign last page in all documents
        }else{
            page = propertySpinBoxControl.value
        }
        
        var isTimestamp = false
        if (typeof propertySwitchSignTemp !== "undefined")
            isTimestamp = propertySwitchSignTemp.checked

        var reason = ""
        if (typeof propertyTextFieldReason !== "undefined")
            reason = propertyTextFieldReason.text

        var location = ""
        if (typeof propertyTextFieldLocal !== "undefined")
            location = propertyTextFieldLocal.text

        var isSmallSignature = false
        if (typeof propertyCheckSignReduced !== "undefined")
            isSmallSignature = propertyCheckSignReduced.checked

        propertyPDFPreview.updateSignPreview()
        var coord_x = -1
        var coord_y = -1
        if(typeof propertyCheckSignShow !== "undefined"){
            if(propertyCheckSignShow.checked){
                coord_x = propertyPDFPreview.propertyCoordX
                //coord_y must be the lower left corner of the signature rectangle
                coord_y = propertyPDFPreview.propertyCoordY
            }
        } else {
            coord_x = propertyPDFPreview.propertyCoordX
            //coord_y must be the lower left corner of the signature rectangle
            coord_y = propertyPDFPreview.propertyCoordY
        }

        /*console.log("Output filename: " + outputFile)*/
        console.log("Signing in position coord_x: " + coord_x
                    + " and coord_y: "+coord_y)

        var countryCode = comboBoxIndicative.currentText.substring(0, comboBoxIndicative.currentText.indexOf(' '));
        var mobileNumber = countryCode + " " + textFieldMobileNumber.text

        propertyOutputSignedFile = outputFile
        rectLabelCMDText.visible = false

        if (typeof propertySwitchSignAdd !== "undefined" && propertySwitchSignAdd.checked) {
            gapi.signOpenScapWithCMD(mobileNumber,textFieldPin.text,
                                     loadedFilePaths,outputFile,page,
                                     coord_x, coord_y,
                                     reason,location)
        } else {
            gapi.signOpenCMD(mobileNumber,textFieldPin.text,
                             loadedFilePaths,outputFile,page,
                             coord_x,coord_y,
                             reason,location,
                             isTimestamp, isSmallSignature)
        }

        progressBarIndeterminate.visible = true
        progressBar.visible = true
        textFieldPin.text = ""
        textFieldReturnCode.text = ""
        dialogSignCMD.close()
        buttonCMDProgressConfirm.visible = false
        buttonCMDProgressConfirm.text = qsTranslate("PageServicesSign","STR_CMD_POPUP_CONFIRM")
        buttonSCAPLoadAttributes.visible = false
        dialogCMDProgress.open()
    }
    function signCMDConfirm(){
        /*console.log("Send sms_token : " + textFieldReturnCode.text)*/
        buttonCMDProgressConfirm.isOpenFile = true
        if( progressBar.value < 100) {
            var attributeList = []
            //CMD with SCAP attributes
            if (typeof propertySwitchSignAdd !== "undefined" && propertySwitchSignAdd.checked) {
                var count = 0
                for (var i = 0; i < entityAttributesModel.count; i++){
                    if(entityAttributesModel.get(i).checkBoxAttr == true) {
                        attributeList[count] = i
                        count++
                    }
                }
            }
            gapi.signCloseCMD(textFieldReturnCode.text, attributeList)
            progressBarIndeterminate.visible = true
            rectReturnCode.visible = false
            buttonCMDProgressConfirm.visible = false
            textFieldReturnCode.text = ""
            dialogCMDProgress.open()
        }
        else
        {
            dialogCMDProgress.close()
            if (Qt.platform.os === "windows") {
                if (propertyOutputSignedFile.substring(0, 2) == "//" ){
                    propertyOutputSignedFile = "file:" + propertyOutputSignedFile
                }else{
                    propertyOutputSignedFile = "file:///" + propertyOutputSignedFile
                }
            }else{
                propertyOutputSignedFile = "file://" + propertyOutputSignedFile
            }
            /*console.log("Open Url Externally: " + propertyOutputSignedFile)*/
            Qt.openUrlExternally(propertyOutputSignedFile)
            mainFormID.opacity = Constants.OPACITY_MAIN_FOCUS
            mainFormID.propertyPageLoader.forceActiveFocus()
        }
    }
    function loadSCAPAttributes(){
        mainFormID.opacity = Constants.OPACITY_MAIN_FOCUS
        dialogCMDProgress.close()
        gapi.startRemovingAttributesFromCache(GAPI.ScapAttrAll)
        jumpToDefinitionsSCAP()
    }
}
