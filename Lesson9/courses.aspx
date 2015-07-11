<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="courses.aspx.cs" Inherits="Lesson9.courses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h1>Courses</h1>
    <a href="course.aspx">Add Course</a>

    <div>
        <label for="ddlPageSize">Records Per Page:</label>
        <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true"
             OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
            <asp:ListItem Value="3" Text="3" />
            <asp:ListItem Value="5" Text="5" />
            <asp:ListItem Value="999999" Text="All" />
        </asp:DropDownList>
    </div>

    <asp:GridView ID="grdCourses" runat="server" AutoGenerateColumns="false" DataKeyNames="CourseID"
         CssClass="table table-striped table-hover" OnRowDeleting="grdCourses_RowDeleting"
         AllowPaging="true" PageSize="3" OnPageIndexChanging="grdCourses_PageIndexChanging"
         AllowSorting="true" OnSorting="grdCourses_Sorting" OnRowDataBound="grdCourses_RowDataBound">
        <Columns>
            <asp:BoundField DataField="CourseID" HeaderText="Course ID" SortExpression="CourseID" />
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
            <asp:BoundField DataField="Credits" HeaderText="Credits" SortExpression="Credits" />
            <asp:BoundField DataField="Name" HeaderText="Department" SortExpression="Name" />
            <asp:HyperLinkField Text="Edit" NavigateUrl="course.aspx" DataNavigateUrlFields="CourseID"
                 DataNavigateUrlFormatString="course.aspx?CourseID={0}" HeaderText="Edit" />
            <asp:CommandField HeaderText="Delete" DeleteText="Delete" ShowDeleteButton="true" />
        </Columns>
    </asp:GridView>

</asp:Content>
