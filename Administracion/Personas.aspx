<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Personas.aspx.cs" Inherits="A.Personas" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#MainContent_gview').DataTable({
                "columnDefs": [{
                    "targets": 0
                }],
                language: {
                    "sProcessing": "Procesando...",
                    "sLengthMenu": "Mostrar _MENU_ resultados",
                    "sZeroRecords": "No se encontraron resultados",
                    "sEmptyTable": "Ningún dato disponible en esta tabla",
                    "sInfo": "Mostrando resultados _START_-_END_ de  _TOTAL_",
                    "sInfoEmpty": "Mostrando resultados del 0 al 0 de un total de 0 registros",
                    "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
                    "sSearch": "Buscar:",
                    "sLoadingRecords": "Cargando...",
                    "oPaginate": {
                        "sFirst": "Primero",
                        "sLast": "Último",
                        "sNext": "Siguiente",
                        "sPrevious": "Anterior"
                    },
                }
            });
        });
    </script>
    <script type="text/javascript">
        (function () {
            function wire(textId, buttonId) {
                var text = document.getElementById(textId), button = document.getElementById(buttonId), picker;
                function iso(value) { value = /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/.exec((value || '').replace(/^\s+|\s+$/g, '')); return value ? value[3] + '-' + ('0' + value[2]).slice(-2) + '-' + ('0' + value[1]).slice(-2) : ''; }
                function display(value) { value = /^(\d{4})-(\d{2})-(\d{2})$/.exec(value || ''); return value ? value[3] + '/' + value[2] + '/' + value[1] : ''; }
                function unlock() { text.readOnly = false; text.removeAttribute('readonly'); }
                function sync() { unlock(); picker.value = iso(text.value); }
                if (!text || !button || text.getAttribute('data-native-calendar-bound') === '1') return;
                text.setAttribute('data-native-calendar-bound', '1');
                picker = document.createElement('input');
                picker.type = 'date'; picker.id = textId + '_NativePicker'; picker.tabIndex = -1;
                picker.setAttribute('aria-hidden', 'true');
                picker.style.cssText = 'position:absolute;width:1px;height:1px;opacity:0;pointer-events:none;';
                document.body.appendChild(picker);
                unlock(); sync();
                ['focus', 'click', 'keydown'].forEach(function (name) { text.addEventListener(name, unlock); });
                ['input', 'change', 'blur'].forEach(function (name) { text.addEventListener(name, sync); });
                ['input', 'change'].forEach(function (name) { picker.addEventListener(name, function () { if (picker.value) { unlock(); text.value = display(picker.value); } }); });
                button.addEventListener('click', function (event) { event.preventDefault(); sync(); try { if (picker.showPicker) { picker.showPicker(); return; } } catch (error) {} picker.focus(); picker.click(); });
            }
            function init() {
                wire('<%= FechNac.ClientID %>', '<%= imgPopup.ClientID %>');
            }
            if (window.Sys && Sys.Application) { Sys.Application.add_load(init); }
            if (document.readyState === 'loading') { document.addEventListener('DOMContentLoaded', init); } else { init(); }
        })();
    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2><span class="glyphicon glyphicon-share-alt" style="font-size: 27px; color:cornflowerblue"></span> <span class="glyphicon glyphicon-user" style="font-size: 27px; color:cornflowerblue"></span>&nbsp;&nbsp;<asp:Label ID="Titulo" runat="server"></asp:Label></h2>
    <hr style="border-color:#CCC;"/>
    <asp:Label ID="mensaje" runat="server" ForeColor="#0000ff"></asp:Label>
    <table id="t_form" align="center" runat="server" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr style="height: 30px;">
            <td align="right">Nombre:</td>
            <td></td>
            <td>
                <asp:TextBox ID="Nombre" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="Nombre"
                    ErrorMessage="* Obligatorio" runat="server" />
            </td>
            <td align="right">Apellido:</td>
            <td></td>
            <td>
                <asp:TextBox ID="Apellido" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="Apellido"
                    ErrorMessage="* Obligatorio" runat="server" />
            </td>
        </tr>
        <tr style="height: 30px;">
            <td align="right">Tipo Documento:</td>
            <td></td>
            <td align="left">
                <asp:DropDownList ID="TipoDoc" runat="server">
                    <asp:ListItem>DU</asp:ListItem>
                    <asp:ListItem>CI</asp:ListItem>
                    <asp:ListItem>LC</asp:ListItem>
                    <asp:ListItem>LE</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="right">Documento:</td>
            <td></td>
            <td>
                <asp:TextBox ID="Documento" runat="server" MaxLength="8"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="Documento" ErrorMessage="* Obligatorio" runat="server" />
            </td>
        </tr>
        <tr style="height: 30px;">
            <td align="right">Sexo:</td>
            <td></td>
            <td align="left">
                <asp:DropDownList ID="Sexo" runat="server">
                    <asp:ListItem></asp:ListItem>
                    <asp:ListItem Value="F">Femenino</asp:ListItem>
                    <asp:ListItem Value="M">Masculino</asp:ListItem>
                    <asp:ListItem Value="I">Indeterminado</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="Sexo" ErrorMessage="* Obligatorio" runat="server" />
            </td>
            <td align="right">Fecha de Nacimiento:</td>
            <td></td>
            <td>
                
                <asp:TextBox ID="FechNac" runat="server"></asp:TextBox>
                <asp:ImageButton ID="imgPopup" ImageUrl="~/img/calendar.png" ImageAlign="Bottom" runat="server" />
            </td>
        </tr>
        <tr style="height: 30px;">
            <td align="right">Nacionalidad:</td>
            <td></td>
            <td align="left">
                <asp:DropDownList ID="DDNacionalidad" runat="server">
                </asp:DropDownList>
            </td>
            <td align="right">Estado Civil:</td>
            <td></td>
            <td align="left">
                <asp:DropDownList ID="DDEstadoCivil" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr style="height: 30px;">
            <td align="right">Domicilio:</td>
            <td></td>
            <td colspan="4">
                <asp:TextBox ID="Domicilio" runat="server" Columns="75"></asp:TextBox>
            </td>
        </tr>
        <tr style="height: 30px;">
            <td align="right">Departamento:</td>
            <td></td>
            <td>
                <asp:DropDownList ID="DDDepartamento" runat="server">
                </asp:DropDownList>
            </td>
            <td align="right">Localidad:</td>
            <td></td>
            <td align="left">
                <asp:DropDownList ID="DDLocalidad" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr style="height: 30px;">
            <td align="right">Código Postal:</td>
            <td></td>
            <td>
                <asp:TextBox ID="CodPostal" runat="server"></asp:TextBox>
            </td>
            <td align="right">CUIL:</td>
            <td></td>
            <td align="left">
                <asp:TextBox ID="CUIL" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr style="height: 30px;">
            <td align="right">Teléfono:</td>
            <td></td>
            <td>
                <asp:TextBox ID="Telefono" runat="server"></asp:TextBox>
            </td>
            <td align="right">Correo:</td>
            <td></td>
            <td align="left">
                <asp:TextBox ID="Correo" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr style="height: 32px;"><td colspan="5"></td>
        </tr>
        <tr style="height: 50px; background-color: #DBDBDB">
            <td align="right">&nbsp;</td>
            <td></td>
            <td align="center">
                <asp:Button ID="btn_Guardar" runat="server" Text="Guardar" OnClick="Guardar_click" class="btn btn-success"/>
            </td>
            <td></td>
            <td></td>
            <td>
                <asp:Button ID="btn_Cancelar" runat="server" Text="Cancelar" CausesValidation="false" OnClick="Cancelar_Click" class="btn btn-info"/>
            </td>
        </tr>
    </table>
    <asp:Label ID="IdPersonaT" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="accion" runat="server" Visible="false"></asp:Label>
    <table id="t_grilla" runat="server" width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr>
            <td>
                <table id="Table2" runat="server" width="100%" border="0" align="center" >
                    <tr> 
                        <td colspan="4" align="left"><strong>Buscar por:</strong></td>
                        <td align="right" style="text-align:right" colspan="4">
                        <asp:Button Enabled="<%# AMET.PermisoOperador()%>" ID="Button2" runat="server" Text=">> Nueva Persona" OnClick="agregarnuevo" class="btn btn-success"/></td>
                    </tr>
                    <tr> <td height="8" colspan="4" align="left"></td></tr>
                    <tr> <td></td> 
                        <td>Nombre: </td>
                        <td><asp:TextBox ID="NombreB" runat="server" CssClass="form-control"></asp:TextBox></td>
                        <td>Apellido:</td>
                        <td><asp:TextBox ID="ApellidoB" runat="server" CssClass="form-control"></asp:TextBox>
                        </td>
                    </tr>
                    <tr> <td height="8" colspan="4" align="left"></td></tr>
                    <tr><td></td>
                        <td>DNI:</td>
                        <td><asp:TextBox ID="DocumentoB" runat="server" CssClass="form-control"></asp:TextBox></td>
                        <td></td>
                        <td><asp:Button ID="Button1" runat="server" OnClick="Buscar_Click" Text="Buscar Persona" class="btn btn-primary" /></td>
                    </tr>    
                </table>
                <hr style="border-color:#CCC;"/>
            </td>
        </tr>
        <tr> <td></td></tr>
        <tr>
            <td align="center"><br />
                <asp:GridView ID="gview" runat="server"  Width="100%" 
                OnRowDataBound="gview_RowDatabound" AutoGenerateColumns="False" OnRowUpdating="gview_RowUpdating" 
                OnRowDeleting="gview_RowDeleting" OnRowCommand="gview_RowCommand" class="table table-striped table-bordered">
                    <Columns>
                        <asp:TemplateField HeaderText="#">
                            <ItemTemplate>
                                <asp:Label ID="Num" runat="server" Text='<%#Container.DataItemIndex+1%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ID" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="ID" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ID")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Nombre">
                            <ItemTemplate>
                                <asp:Label ID="Nombre" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Nombre")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Documento">
                            <ItemTemplate>
                                <asp:Label ID="Documento" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Documento")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Fecha Nac.">
                            <ItemTemplate>
                                <asp:Label ID="FechaNac" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FechaNac")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Género">
                            <ItemTemplate>
                                <asp:Label ID="Sexo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Sexo")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Domicilio">
                            <ItemTemplate>
                                <asp:Label ID="Domicilio" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Domicilio")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="Mostrar" runat="server" CommandName="Mostrar" CommandArgument = '<%# DataBinder.Eval(Container.DataItem, "ID")%>' 
                                 ToolTip="Consultar"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                            </ItemTemplate> 
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton Visible="<%# AMET.PermisoOperador()%>" ID="Editar" runat="server" CommandName="Update" CommandArgument = '<%# DataBinder.Eval(Container.DataItem, "ID")%>' 
                                 ToolTip="Modificar"><span class="glyphicon glyphicon-edit" style="color:green"></span></asp:LinkButton>
                            </ItemTemplate> 
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton Visible="<%# AMET.PermisoOperador()%>" ID="lnkRemove" runat="server" CommandName="Delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID")%>'
                                    OnClientClick="return confirm('¿Esta seguro que quiere eliminar?')" ToolTip="Eliminar">
                                    <span class="glyphicon glyphicon-remove" style="color:red"></span></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>
    <br /><br />
</asp:Content>