<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="course.aspx.cs" Inherits="Lesson9.course" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Course Details</h1>
    <h5>All fields are required</h5>

     <div class="container">
        <h1>Course Details</h1>

        <div class="form-group">
            <label for="txtTitle" class="control-label col-sm-2">Title:</label>
            <asp:TextBox ID="txtTitle" runat="server" required MaxLength="100" />
        </div>
        <div class="form-group">
            <label for="txtCredits" class="control-label col-sm-2">Credits:</label>
            <asp:TextBox ID="txtCredits" runat="server" required TextMode="Number" />
        </div>
        <div class="form-group">
            <label for="ddlDepartment" class="control-label col-sm-2">Department:</label>
            <asp:DropDownList ID="ddlDepartment" runat="server" 
                 DataTextField="Name" DataValueField="DepartmentID"></asp:DropDownList>
        </div>
        <div class="col-sm-2 col-sm-offset-2">
            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="btn btn-primary" />
        </div>
    </div>

    <h2>Students</h2>
    <asp:gridview ID="grdStudents" runat="server" AutoGenerateColumns="false"
         DataKeyNames="EnrollmentID" OnRowDeleting="grdStudents_RowDeleting"
         CssClass="table table-striped table-hover">
        <Columns>

            <asp:BoundField DataField="LastName" HeaderText="Last Name" />
            <asp:BoundField DataField="FirstMidName" HeaderText="First Name" />
            <asp:BoundField DataField="Title" HeaderText="Course" />
            <asp:BoundField DataField="Name" HeaderText="Name" />
            <asp:CommandField ShowDeleteButton="true" DeleteText="Delete" HeaderText="Delete" />
        </Columns>
    </asp:gridview>

</asp:Content>
