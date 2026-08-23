<%@ Page Title="Autorizados" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Autorizados.aspx.cs" Inherits="A.Autorizados" %>

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
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="Server">
    <h2><span class="glyphicon glyphicon-user" style="font-size: 27px; color:brown"></span> <span class="glyphicon glyphicon-thumbs-up" style="font-size: 23px; color:brown"></span>&nbsp;&nbsp;<asp:Label ID="Titulo" runat="server"></asp:Label></h2>
    <hr style="border-color:#CCC;"/>
 
    <table id="t_grilla" runat="server" width="100%" border="0" cellpadding="0" cellspacing="0" align="center" >
        <tr>
            <td style="text-align: center" colspan="3">
                <asp:Label ID="mensaje" runat="server" Text="Label" Style="font-weight: 700; color: #0066FF"></asp:Label>
                <br />
                <br />
            </td>
        </tr>
        <tr>
            <td></td>
            <td >&nbsp;</td>
            <td  align="right">
              <asp:Button ID="btnAddAuto" runat="server" onclick="btnAddAuto_Click" Text=">> Nuevo Autorizado" Width="154px" class="btn btn-success" />
            </td>
        </tr>
        <tr>
            <td style="text-align: center" >
                <asp:Label ID="idAfiliado" runat="server" Visible="false"></asp:Label>
            </td>
            <td style="text-align: center">
                &nbsp;</td>
            <td style="text-align: center">
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:GridView ID="gview" runat="server" AutoGenerateColumns="False" 
                   OnRowDeleting="gview_RowDeleting" OnRowCommand="gview_RowCommand" OnRowUpdating="gview_RowUpdating" 
                    class="table table-striped table-bordered">
                    <Columns>
                        <asp:TemplateField HeaderText="#">
                            <ItemTemplate>
                                <asp:Label ID="Num" runat="server" Text='<%#Container.DataItemIndex+1%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="IdAutorizado" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="IdAutorizado" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "IdAutorizado")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Apellido">
                            <ItemTemplate>
                                <asp:Label ID="Apellido" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Apellido")%>'></asp:Label>
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
                        <asp:TemplateField HeaderText="Sexo">
                            <ItemTemplate>
                                <asp:Label ID="Sexo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Sexo")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Telefono">
                            <ItemTemplate>
                                <asp:Label ID="Telefono" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Telefono")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Correo">
                            <ItemTemplate>
                                <asp:Label ID="Correo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Correo")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-BackColor="#DBDBDB">
                            <ItemTemplate>
                                <asp:LinkButton ID="Mostrar" runat="server" CommandName="Mostrar" CommandArgument = '<%# DataBinder.Eval(Container.DataItem, "IdAutorizado")%>' 
                                 ToolTip="Consultar"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                            </ItemTemplate> 
                        </asp:TemplateField>
                        <asp:TemplateField  ItemStyle-BackColor="#DBDBDB">
                            <ItemTemplate>
                                <asp:LinkButton Visible="<%# AMET.PermisoOperador()%>" ID="Editar" runat="server" CommandName="Update" CommandArgument = '<%# DataBinder.Eval(Container.DataItem, "IdAutorizado")%>' 
                                 ToolTip="Modificar"><span class="glyphicon glyphicon-edit" style="color:green"></span></asp:LinkButton>
                            </ItemTemplate> 
                        </asp:TemplateField>
                        <asp:TemplateField  ItemStyle-BackColor="#DBDBDB">
                            <ItemTemplate>
                                <asp:LinkButton Visible="<%# AMET.PermisoOperador()%>" ID="lnkRemove" runat="server" CommandName="Delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "IdAutorizado")%>'
                                    OnClientClick="return confirm('¿Esta seguro que desea ELIMINAR esta Persona Autorizada?')"
                                    ToolTip="Eliminar"><span class="glyphicon glyphicon-remove" style="color:red"></span></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr style="height: 50px;">
            <td align="center" class="style9" colspan="3">
                &nbsp;</td>
        </tr>
    </table>
    <table id="t_form" runat="server" border="0" cellpadding="0" cellspacing="0" width="90%" align="center">
        <tr style=" background-color: #DBDBDB"><td colspan="6">&nbsp;&nbsp;&nbsp; <strong> Datos Personales</strong></td></tr>
        <tr style="height: 10px;"><td>&nbsp;</td><td>
            <asp:Label ID="IdPersonaT" runat="server" Visible="False"></asp:Label>
            <asp:Label ID="parametro" runat="server" Visible="False"></asp:Label>
            </td><td></td></tr>
    </table>
    <table id="t_form1" runat="server" border="0" cellpadding="0" cellspacing="0" width="90%" align="center">
    <tr style="height: 30px;">
            <td align="right">Tipo Documento:</td><td></td>
            <td align="left" style="width:150px;">
                <asp:DropDownList ID="TipoDoc" runat="server">
                    <asp:ListItem>DU</asp:ListItem>
                    <asp:ListItem>CI</asp:ListItem>
                    <asp:ListItem>LC</asp:ListItem>
                    <asp:ListItem>LE</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="right">Documento:</td><td></td>
            <td><asp:TextBox ID="Documento" runat="server" MaxLength="8"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="Documento" ErrorMessage="* Obligatorio" runat="server" /></td>
            <td align="right">Género:</td><td></td>
            <td align="left">
                <asp:DropDownList ID="Sexo" runat="server">
                    <asp:ListItem></asp:ListItem>
                    <asp:ListItem Value="F">Femenino</asp:ListItem>
                    <asp:ListItem Value="M">Masculino</asp:ListItem>
                    <asp:ListItem Value="I">Indeterminado</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="Sexo" ErrorMessage="* Obligatorio" runat="server" />
                &nbsp;&nbsp;&nbsp;<asp:Button ID="BuscarPersona" runat="server" Text="Buscar Persona" CausesValidation="false" OnClick="BuscarPersona_Click" class="btn btn-info"/>
            </td>
        </tr>
        <tr ><td colspan="9"><hr /></td></tr>
    </table>

    <table id="muestra" runat="server" border="0" cellpadding="0" cellspacing="0" width="90%" align="center">
        <tr style="height: 30px;">
            <td align="right">
                Nombre:
            </td>
            <td>
            </td>
            <td>
                <asp:TextBox ID="Nombre" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="Nombre" ErrorMessage="* Obligatorio" runat="server" />
            </td>
            <td align="right">
                Apellido:
            </td>
            <td>
            </td>
            <td>
                <asp:TextBox ID="Apellido" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="Apellido" ErrorMessage="* Obligatorio" runat="server" />
            </td>
        </tr>
        <tr style="height: 30px;">
            <td align="right">Nacionalidad:</td>
            <td></td>
            <td align="left">
                <asp:DropDownList ID="DDNacionalidad" runat="server"></asp:DropDownList>
            </td>
            <td align="right">Estado Civil:</td>
            <td></td>
            <td align="left">
                <asp:DropDownList ID="DDEstadoCivil" runat="server"></asp:DropDownList>
            </td>
        </tr>
        <tr style="height: 30px;">
            <td align="right">Domicilio:</td>
            <td></td>
            <td>
                <asp:TextBox ID="Domicilio" runat="server" Columns="45"></asp:TextBox>
            </td>
            <td align="right">Fecha de Nac.:</td>
            <td></td>
            <td>
                
                <asp:TextBox ID="FechNac" runat="server"></asp:TextBox><asp:ImageButton ID="imgPopup"
                    ImageUrl="~/img/calendar.png" ImageAlign="Bottom" runat="server" />
            </td>
        </tr>
        <tr style="height: 30px;">
            <td align="right">Departamento:</td>
            <td></td>
            <td>
                <asp:DropDownList ID="DDDepartamento" runat="server" Height="23px" Width="169px"></asp:DropDownList>
            </td>
            <td align="right">Localidad:</td>
            <td></td>
            <td align="left">
                <asp:DropDownList ID="DDLocalidad" runat="server" Height="17px" Width="175px"></asp:DropDownList>
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
        <tr style="height: 30px;">
            <td align="right">Relación:</td>
            <td></td>
            <td>
                <asp:DropDownList ID="DDIdRelacion" runat="server" Height="21px" Width="175px"></asp:DropDownList>
            </td>
            <td align="right">Observaciones:</td>
            <td></td>
            <td align="left">
                <asp:TextBox ID="txtObservaciones" runat="server" Height="94px" Width="254px"></asp:TextBox>
            </td>
        </tr>
        <tr style="height: 10px;">
            <td colspan="6"></td>
        </tr>
        <tr style="height: 30px; background-color: #DBDBDB">
            <td align="center" colspan="6">
                <asp:Button ID="btnVolver" runat="server" onclick="btnVolver_Click" Text="Cancelar" class="btn btn-info" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btn_Actualizar" runat="server" Text="> Actualizar <" class="btn btn-success" />
                <asp:Button ID="btn_Guardar" runat="server" Text="> Guardar <" OnClick="Guardar_click" class="btn btn-success"/>
            </td>
        </tr>
    </table>
    <div>
        <hr style="border-color:#CCC;"/>
        <asp:Button ID="Volver" runat="server" Text="<< Volver" CausesValidation="false" onclick="f_volver" CssClass="btn btn-info" style="margin-left: 0"/>
    </div>
</asp:Content>