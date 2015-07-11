<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="course.aspx.cs" Inherits="Lesson9.course" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Course Details</h1>
    <h5>All fields are required</h5>

     <fieldset>
        <label for="txtCourseTitle" class="col-sm-2">Title:</label>
        <asp:TextBox ID="txtCourseTitle" runat="server" required MaxLength="50" />
    </fieldset>
    <fieldset>
        <label for="txtCredits" class="col-sm-2">Credits:</label>
        <asp:TextBox ID="txtCredits" runat="server" required TextMode="Number" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
            ErrorMessage="Number required" ControlToValidate="txtCredits" ></asp:RequiredFieldValidator>
    </fieldset>

    <div class="col-sm-offset-2">
        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary"
             OnClick="btnSave_Click" />
    </div>
    <div></div>

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
