<%@ Page Title="" Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="TimeSheet.aspx.cs" Inherits="TimeSheet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <%--  <link href="Style/bootstrap.min.css" rel="stylesheet" />
    <link href="Style/bootstrap-theme.min.css" rel="stylesheet" />--%>
    <link href="Style/jquery-ui.min.css" rel="stylesheet" />
    <%--    <script src="Scripts/jquery.js"></script>
    <script src="Scripts/jquery-ui.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>--%>
    <script src="Scripts/jquery-ui.min.js"></script>
    <style>
        .modal-backdrop {
            z-index: -1;
        }
        /*#ProcedureDetailModal, #SignModal {
            background-color: black;
            opacity: 5.5;
        }*/
    </style>
    <style>
        #ddDate {
        }

        #ddLocation {
            width: 300px;
        }

        .title {
            padding: 5px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        #tblProcedures tr td {
            width: 100px;
            margin: 5px;
        }



        .border {
            border-width: 1px;
            border-style: solid;
            border-color: gray;
        }

        .bottomborder {
            border-width: 0 0 1px 0;
            border-style: solid;
        }

        .med-button {
            width: 80px;
            margin: 4px;
        }

        .align {
            margin: 20px;
        }

        legend {
            font-size: small;
        }

        .sign {
            min-height: 125px;
            margin-top: 5px;
        }

        .topalign {
            margin: 20px 0 0 0;
        }

        .signbtns {
            padding-top: 15px;
        }

        .noborder {
            border: none;
        }

        .caption-align Caption {
            padding-left: 40px;
        }

        .large-button {
            width: 300px;
            margin: 30px;
            vertical-align: bottom;
        }


        .patientDetails {
            border-style: solid;
            min-height: 600px;
            border-width: 0 0 0 1px;
        }

        .sbtncontainer {
            vertical-align: bottom;
        }

        .boldertext {
            font-weight: bold;
        }



        .table {
            width: auto;
        }

        /*.model-header {
            padding: 0px !important;
        }*/

        .listBox {
            min-height: 136px;
            min-width: 200px;
        }

        .provider-ma {
            text-align: center;
        }

            .provider-ma input {
                width: 50px;
            }

        /*.modal {
            left: 50%;
            bottom: auto !important;
        }

        .modal-dialog {
            margin: 0 auto !important;
        }

        #ProcedureDetailModal, #SignModal {
            background-color: black;
            opacity: 5.5;
        }*/

        #content {
            padding: 0;
        }

        .leafNode {
            border-width: 0 0 0 1px;
            border-style: dotted;
            width: 150px;
            overflow: hidden;
        }

            .leafNode img {
                display: none;
            }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpTitle" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cpMain" runat="Server">



    <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>
    <asp:Panel ID="pnlSearch" runat="server">
        <div class="row bottomborder">
            <!--TopBar-->
            <div class="col-lg-5" style="display: none">
                <asp:Label ID="lblDate" runat="server" Text="Date" CssClass="align boldertext"></asp:Label>
                <asp:DropDownList ID="ddDate" runat="server" CssClass="align" DataTextFormatString="{0:d}" Width="180px"></asp:DropDownList>
            </div>
            <div class="col-lg-6">
                <label class="align boldertext">From</label>
                <asp:TextBox ID="txt_From" CssClass="align dateonly" placeholder="From Date" runat="server"></asp:TextBox>
                <label class="align boldertext">&nbsp;To&nbsp;</label>
                <asp:TextBox ID="txtTo" CssClass="align dateonly" placeholder="To Date" runat="server"></asp:TextBox>



            </div>
            <div class="col-lg-6">
                <asp:Label ID="lblLocation" runat="server" Text="Location" CssClass="boldertext"></asp:Label>
                <asp:DropDownList ID="ddLocation" runat="server" CssClass="align">
                    <asp:ListItem>All</asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="btnFind" runat="server" Text="Find" CssClass=" btn btn-default" OnClick="btnFind_Click" />
                <button type="button" class="btn btn-default top-right" data-toggle="modal" disabled data-target="#SignModal">Signature</button>
                <%--  <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass=" btn btn-default right" OnClick="btnLogout_Click" />--%>
                <%--<asp:HyperLink ID="hlPatientIE" runat="server" Text="Patient Details" CssClass=" btn btn-default right" NavigateUrl="~/PatientIntakeList.aspx"></asp:HyperLink>--%>
                <%--<asp:Button ID="btnHidden" runat="server" Text="GetHiddenValues" OnClick="btnHidden_Click" />--%>
                &nbsp;
                 <asp:Button ID="btnDownloadSI" runat="server" Text="Download SI" CssClass=" btn btn-default" OnClick="btnDownloadSI_Click" />
            </div>
        </div>
        <!--End TopBar-->

    </asp:Panel>
    <!--Start Top Quick links. -->
    <%-- <asp:LinkButton ID="lbtnPatientDetails" Style="margin-right:1%" CssClass="procDetail" runat="server" OnClick="lbtnPatientDetails_Click" >Patient Details</asp:LinkButton>--%>
    <!--End Top Quick links. -->
    <div class="row">
        <!--Content-->

        <div class="col-lg-2 col-md-2 text-center patients">
            <!--Patients Container-->

            <asp:TreeView ID="tvPatients" runat="server" OnSelectedNodeChanged="tvPatients_SelectedNodeChanged" ShowLines="True" Width="150px">
                <LeafNodeStyle CssClass="leafNode" />
            </asp:TreeView>
        </div>
        <!--End Patients Container-->

        <div class="col-lg-9 topalign patientDetails">
            <!--Patient Details Container-->
            <div class="row">
                <div class="col-lg-4">
                    <asp:Label ID="lblName" runat="server" Text="Name : " CssClass="boldertext"></asp:Label>
                    <asp:Label ID="lblDName" runat="server" Text=""></asp:Label>
                </div>
                <div class="col-lg-2">
                    <asp:Label ID="lblDOA" runat="server" Text="DOA : " CssClass="boldertext"></asp:Label>
                    <asp:Label ID="lblDDOA" runat="server" Text="" CssClass=""></asp:Label>
                </div>
                <div class="col-lg-4">
                    <asp:Label ID="lblPLocation" runat="server" Text="Location : " CssClass="boldertext"></asp:Label>
                    <asp:Label ID="lblPDLocation" runat="server" Text="" CssClass=""></asp:Label>
                </div>
                <div class="col-lg-2">
                    <asp:Label ID="lblCaseType" runat="server" Text="Case Type : " CssClass="boldertext"></asp:Label>
                    <asp:Label ID="lblDCaseType" runat="server" Text="" CssClass=""></asp:Label>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-lg-4">
                    <asp:Label ID="lblNeck" runat="server" Text="Name : " CssClass="boldertext">Neck:</asp:Label><br />
                    MRI&nbsp;&nbsp; :&nbsp;
                        <asp:Label ID="lblNeckMRI" runat="server" Text=""></asp:Label><br />
                    UE&nbsp;&nbsp;&nbsp;&nbsp; :&nbsp; 
                        <asp:Label ID="lblNeckUE" runat="server" Text=""></asp:Label>
                </div>
                <div class="col-lg-4">
                    <asp:Label ID="lblLowBack" runat="server" Text="DOA : " CssClass="boldertext">LowBack:</asp:Label><br />
                    MRI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :
                    <asp:Label ID="lblLowBackMRI" runat="server" Text="" CssClass=""></asp:Label><br />
                    LE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :
                    <asp:Label ID="lblLowBackLE" runat="server" Text="" CssClass=""></asp:Label>
                </div>
                <div class="col-lg-4">
                    <asp:Label ID="lblMidBack" runat="server" Text="Location : " CssClass="boldertext">MidBack:</asp:Label><br />
                    MRI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :
                    <asp:Label ID="lblMidBackMRI" runat="server" Text="" CssClass=""></asp:Label><br />
                    <%-- LE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : --%><asp:Label ID="lblMidBackLE" runat="server" Visible="false" Text="" CssClass=""></asp:Label>
                </div>
            </div>
            <br />
            <strong>MA and Providers : </strong>
            <asp:Label ID="lblMAandProviders" runat="server" Text=""></asp:Label>
            <br />
            <%--                <br />
                <div class="row">
                    <div class="col-lg-8">
                        <strong>MA and Providers:</strong>
                        <table class="provider-ma">
                            <tr><td style="vertical-align:top;" rowspan="6"><asp:ListBox ID="lbMAandProviders" CssClass="listBox" runat="server"></asp:ListBox></td><td></td><td style="vertical-align:top;  min-height:136px" rowspan="6"><asp:ListBox CssClass="listBox" ID="lbSelectedMAandProviders" runat="server"></asp:ListBox></td></tr>
                            <tr><td width="80px">
                                <asp:Button ID="moveAllLeft" CssClass="btn btn-default" runat="server" Text="<<" OnClick="moveAllLeft_Click" /></td></tr>
                             <tr><td>
                                 <asp:Button ID="moveLeft" CssClass="btn btn-default" runat="server" Text="<" OnClick="moveLeft_Click" /></td></tr>
                             <tr><td>
                                 <asp:Button ID="moveRight" CssClass="btn btn-default" runat="server" Text=">" OnClick="moveRight_Click" /></td></tr>
                             <tr><td>
                                 <asp:Button ID="moveAllRight" CssClass="btn btn-default" runat="server" Text=">>" OnClick="moveAllRight_Click" /></td></tr>                            
                        </table>

                    </div>
                </div>
                <br />--%>
            <div class="row" style="overflow-x: scroll; min-width: 400px;">
                <!--Grid Container-->
                <div class="col-lg-12">
                    <b>Procedures :</b>
                    <asp:Literal ID="ltNew" runat="server"></asp:Literal>
                    <br />
                    <br />
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:Panel ID="pnlProcedures" runat="server"></asp:Panel>
                        </ContentTemplate>

                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnReload" EventName="Click" />
                        </Triggers>

                    </asp:UpdatePanel>

                </div>
            </div>
            <!--Grid Container-->
        </div>
        <!--End Patient Details Container-->

    </div>
    <!-- Signature Modal -->
    <div class="modal fade" id="SignModal" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <b>Signature</b>
                    <div class="row">
                        <div class="col-lg-9">
                            <div class="center-block border sign"></div>
                        </div>
                        <div class="col-lg-3">
                            <button type="button" class="btn btn-default med-button">Clear</button><br />
                            <button type="button" class="btn btn-default med-button">Sign</button><br />
                            <button type="button" data-dismiss="modal" class="btn btn-default med-button">Done!!!</button>
                        </div>
                    </div>
                </div>
            </div>
            <!--End Content-->
        </div>
    </div>
    <asp:HiddenField runat="server" ID="DOEhdn" />
    <!-- New Proceduredetail Modal -->

    <!-- Modal content-->

    <asp:HiddenField ID="hfPatientIE_ID" runat="server" />
    <asp:HiddenField ID="hfPatientFU_ID" runat="server" />
    <asp:HiddenField ID="hfUserID" runat="server" />


    <script type="text/javascript">
        function save() {
            var datacol = $('#HDN_Attribute').val().split('_');
            var pdesc = 'test';
            var ajaxdata = "{  procedureId:'" + datacol[2] +
                "',patientIEId:'" + $("#<%=hfPatientIE_ID.ClientID%>").val() +
                "',patientFUId:'" + datacol[4] +
                "',createdBy:'" + $("#<%=hfUserID.ClientID%>").val() +
                "',mcode:'" + datacol[5] + $('#Pos_val').val() + '_' + datacol[6] + '_' + datacol[7] +
                "',bodypart:'" + datacol[8] +
                "',date:'" + $('#HDN_Selecteddate').val() +
                "',pDesc:'" + pdesc +
                "',ProcedureDetail_ID:'" + datacol[9] +
                "'}";

            $.ajax({
                type: "POST",
                url: "SaveProcedure.aspx/Save",
                data: ajaxdata,
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function () {
                    $('.reload').click();
                    $('#LocSelectPopup').modal('hide');
                    //console.log('reached');
                },
                failure: function (response) {
                    alert("Invalid Details...")
                }
            });


        }
        $(document).ready(function () {

            setdatepicker();
            loadPanel();
            if ($('#lblName').val() != "") {
                $('#New').css("visiblity", "visible");
            }
            else {
                $('#New').css("visiblity", "hidden");
            }

            $('#txtDate').text($('#DOEhdn').val());
        });
        function saveClick() {
            // $.blockUI({ message: "<h1>Remote call in progress...</h1>" }); 


            // unblock when remote call returns 



        }
        function setdatepicker() {
            $('.dateonly').datepicker({
                dateFormat: "mm/dd/yy"
            });

            $('#').datepicker({
                dateFormat: "mm/dd/yy"
            });



            $('.date').datepicker({
                dateFormat: "mm/dd/yy",
                onSelect: function () {
                    if (confirm('Do you want to continue to save?')) {
                        //debugger;
                        var datacol = $(this).attr('id').split('_');
                        $('#HDN_Attribute').val($(this).attr('id'));
                        var pdesc = 'test';
                        $('#HDN_Selecteddate').val('');
                        // alert(datacol[5]);
                        switch (datacol[5]) {
                            case 'CTPI':
                                $('#HDN_Selecteddate').val($(this).val());
                                $('#LocSelectPopup').modal('show');
                                break;
                            case 'LTPI':
                                $('#HDN_Selecteddate').val($(this).val());
                                $('#LocSelectPopup').modal('show');
                                break;
                            case 'TTPI':
                                $('#HDN_Selecteddate').val($(this).val());
                                $('#LocSelectPopup').modal('show');
                                break;
                            default:
                                var ajaxdata = "{  procedureId:'" + datacol[2] +
                                    "',patientIEId:'" + $("#<%=hfPatientIE_ID.ClientID%>").val() +
                                    "',patientFUId:'" + datacol[4] +
                                    "',createdBy:'" + $("#<%=hfUserID.ClientID%>").val() +
                                    "',mcode:'" + datacol[5] + '_' + datacol[6] + '_' + datacol[7] +
                                    "',bodypart:'" + datacol[8] +
                                    "',date:'" + $(this).val() +
                                    "',pDesc:'" + pdesc +
                                    "',ProcedureDetail_ID:'" + datacol[9] +
                                    "'}";

                                $.ajax({
                                    type: "POST",
                                    url: "SaveProcedure.aspx/Save",
                                    data: ajaxdata,
                                    contentType: "application/json;charset=utf-8",
                                    dataType: "json",
                                    success: function () {
                                        $('.reload').click();
                                        //console.log('reached');
                                    },
                                    failure: function (response) {
                                        alert("Invalid Details...")
                                    }
                                });

                                break;
                        }
                    }
                    else {
                        $(this).val('');
                    }

                }
            });

            $('.date').keyup(function () {

                if (!this.value) {
                    $('.date').blur();
                    $('.date').datepicker("hide")
                    if (confirm('Do u want to delete?')) {
                        var datacol = $(this).attr('id').split('_');
                        var pdesc = 'test';
                        //debugger;
                        // alert(datacol[5])
                        var ajaxdata = "{  procedureId:'" + datacol[2] +
                            "',patientIEId:'" + $("#<%=hfPatientIE_ID.ClientID%>").val() +
                            "',patientFUId:'" + datacol[4] +
                                        <%--"',createdBy:'" + $("#<%=hfUserID.ClientID%>").val() +--%>
                            "',mcode:'" + datacol[5] + '_' + datacol[6] + '_' + datacol[7] +
                            "',bodypart:'" + datacol[8] +
                            "',ProcedureDetail_ID:'" + datacol[9] +
                            "'}";
                        $.ajax({
                            type: "POST",
                            url: "SaveProcedure.aspx/Delete",
                            data: ajaxdata,
                            contentType: "application/json;charset=utf-8",
                            dataType: "json",
                            success: function () {
                                $('.reload').click();
                                //console.log('reached');
                            },
                            failure: function (response) {
                                alert("Invalid Details...")
                            }
                        });
                    }
                }

            });
        }
        function loadPanel() {
            $("#<%=btnReload.ClientID%>").click(function () {
                $('#<%=lblAlert.ClientID%>').html('');
                $('#modalclose').click();

            });
        }
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        if (prm != null) {
            prm.add_endRequest(function (sender, e) {
                if (sender._postBackSettings.panelsToUpdate != null) {
                    setdatepicker();
                    loadPanel();
                }
            });
        }


    </script>



    <div class="modal fade" id="ProcedureDetailModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <asp:Label ID="lblAlert" runat="server"></asp:Label>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-sm-10">
                                    <div class="row">
                                        <div class="col-sm-5">
                                            <label class="control-label">BodyPart :</label>
                                        </div>
                                        <div class="col-sm-5">
                                            <asp:DropDownList ID="ddBodyPart" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddBodyPart_SelectedIndexChanged"></asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="space"></div>
                                    <div class="row">
                                        <div class="col-sm-5">Type :</div>
                                        <div class="col-sm-5">
                                            <asp:RadioButtonList ID="rblDateType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblDateType_SelectedIndexChanged">
                                                <asp:ListItem Value="R">Requested</asp:ListItem>
                                                <asp:ListItem Value="S">Scheduled</asp:ListItem>
                                                <asp:ListItem Value="E">Executed</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                    <div class="space"></div>
                                    <div class="row">
                                        <div class="col-sm-5">Procedure :</div>
                                        <div class="col-sm-5">
                                            <asp:DropDownList ID="ddProcedure" CssClass="form-control" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddProcedure_SelectedIndexChanged"></asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="space"></div>
                                    <div class="row">
                                        <div class="col-sm-5">Sub Procedure :</div>
                                        <div class="col-sm-5">
                                            <asp:DropDownList ID="ddSubProcedure" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddSubProcedure_SelectedIndexChanged"></asp:DropDownList>
                                            <asp:TextBox ID="txtNumber" Width="30px" Height="19px" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="space"></div>
                                    <div class="row">
                                        <div class="col-sm-5">Date</div>
                                        <div class="col-sm-5">
                                            <asp:TextBox ID="txtDate" CssClass="dateonly" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="space"></div>
                                    <div class="row">
                                        <div class="col-sm-5"></div>
                                        <div class="col-sm-5">
                                            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Save" OnClientClick="saveClick()" OnClick="btnSave_Click" />
                                            <%--  <button id="closeandload">Close</button>  --%>
                                            <button type="button" id="modalclose" class="btn btn-primary" data-dismiss="modal" style="display: none" aria-hidden="true">&times;</button>
                                            <asp:Button ID="btnReload" runat="server" Text="Close" CssClass="reload btn btn-primary" OnClick="btnReload_Click" />


                                        </div>
                                    </div>
                                </div>

                            </div>
                        </ContentTemplate>

                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>



    <!--End Content-->

    <div class="modal fade" id="LocSelectPopup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <%--<h4 class="modal-title" id="myModalLabel">Modal title</h4>--%>
                </div>
                <div class="modal-body">
                    <div class="col-lg-3">
                        <label class="align boldertext">Position</label>
                        <select id="Pos_val">
                            <option value="">--Select--</option>
                            <option value="L">Left</option>
                            <option value="R">Right</option>
                            <option value="B">Bilateral</option>
                            <option value="B12B">B12B</option>
                            <option value="B12L">B12L</option>
                            <option value="B12R">B12R</option>
                        </select>
                        <input type="hidden" id="HDN_Selecteddate" />
                        <input type="hidden" id="HDN_Attribute" />
                    </div>
                </div>
                <div class="modal-footer" style="margin-right: 18px">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" onclick="save()" class="btn btn-primary">Save</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

