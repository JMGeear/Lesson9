<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="student.aspx.cs" Inherits="Lesson9.student" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Student Details</h1>
    <h5>All fields are required</h5>

    <fieldset>
        <label for="txtLastName" class="col-sm-2">Last Name:</label>
        <asp:TextBox ID="txtLastName" runat="server" required MaxLength="50" />
    </fieldset>
    <fieldset>
        <label for="txtFirstMidName" class="col-sm-2">First Name:</label>
        <asp:TextBox ID="txtFirstMidName" runat="server" required MaxLength="50" />
    </fieldset>
    <fieldset>
        <label for="txtEnrollmentDate" class="col-sm-2">Enrollment Date:</label>
        <asp:TextBox ID="txtEnrollmentDate" runat="server" required TextMode="Date" />
        <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Must be a Date"
            ControlToValidate="txtEnrollmentDate" CssClass="alert alert-danger"
            Type="Date" MinimumValue="2000-01-01" MaximumValue="12/31/2999"></asp:RangeValidator>
    </fieldset>

    <div class="col-sm-offset-2">
        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary"
             OnClick="btnSave_Click" />
    </div>

    <h2>Courses</h2>
    <asp:gridview ID="grdCourses" runat="server" AutoGenerateColumns="false"
         DataKeyNames="EnrollmentID" OnRowDeleting="grdCourses_RowDeleting"
         CssClass="table table-striped table-hover">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Department" />
            <asp:BoundField DataField="Title" HeaderText="Course" />
            <asp:BoundField DataField="Grade" HeaderText="Grade" />
            <asp:CommandField ShowDeleteButton="true" DeleteText="Delete" HeaderText="Delete" />
        </Columns>
    </asp:gridview>

</asp:Content>
