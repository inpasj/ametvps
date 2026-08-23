<%@ Page Title="Afiliados" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Afiliados.aspx.cs" Inherits="A.Afiliados" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
<style type="text/css">
    table.dataTable td {
        font-size: 0.9em;
    }
</style>
<script type="text/javascript">
    
    $(document).ready(function () {
        var table = $('#MainContent_gview').DataTable({
            buttons: ['excel', 'pdf', 'print', 'colvis'],
            language: {
                "sProcessing": "Procesando...",
                "sLengthMenu": "Mostrar _MENU_ registros",
                "sZeroRecords": "No se encontraron resultados",
                "sEmptyTable": "Ningún dato disponible en esta tabla",
                "sInfo": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                "sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
                "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
                "sInfoPostFix": "",
                "sSearch": "Buscar:",
                "sUrl": "",
                "sInfoThousands": ",",
                "sLoadingRecords": "Cargando...",
                "oPaginate": {
                    "sFirst": "Primero",
                    "sLast": "Último",
                    "sNext": "Siguiente",
                    "sPrevious": "Anterior"
                },
                "oAria": {
                    "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
                    "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                },
                "buttons": {
                    "copy": "Copiar",
                    "colvis": "Visibilidad",
                    "collection": "Colección",
                    "colvisRestore": "Restaurar visibilidad",
                    "copyKeys": "Presione ctrl o u2318 + C para copiar los datos de la tabla al portapapeles del sistema. <br \/> <br \/> Para cancelar, haga clic en este mensaje o presione escape.",
                    "copySuccess": {
                        "1": "Copiada 1 fila al portapapeles",
                        "_": "Copiadas %ds fila al portapapeles"
                    },
                    "copyTitle": "Copiar al portapapeles",
                    "csv": "CSV",
                    "excel": "Excel",
                    "pageLength": {
                        "-1": "Mostrar todas las filas",
                        "_": "Mostrar %d filas"
                    },
                    "pdf": "PDF",
                    "print": "Imprimir",
                    "renameState": "Cambiar nombre",
                    "updateState": "Actualizar",
                    "createState": "Crear Estado",
                    "removeAllStates": "Remover Estados",
                    "removeState": "Remover",
                    "savedStates": "Estados Guardados",
                    "stateRestore": "Estado %d"
                },
            }
        });
        table.buttons().container()
            .appendTo('#MainContent_gview_wrapper .col-sm-6:eq(0)');
    });

    document.onkeyup = KeyCheck;
    function KeyCheck(e) {
        var KeyID = (window.event) ? event.keyCode : e.keyCode;
        if (KeyID == 113) {
            document.getElementById('MainContent_Button3').click();
        }
    }
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
                wire('<%= FechaIngresoB.ClientID %>', '<%= imgPopup2.ClientID %>');
            }
            if (window.Sys && Sys.Application) { Sys.Application.add_load(init); }
            if (document.readyState === 'loading') { document.addEventListener('DOMContentLoaded', init); } else { init(); }
        })();
    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2><span class="glyphicon glyphicon-share-alt" style="font-size: 27px; color:darkseagreen"></span> <span class="glyphicon glyphicon-user" style="font-size: 27px; color:darkgreen"></span>&nbsp;&nbsp;<asp:Label ID="Titulo" runat="server"></asp:Label></h2>
    <hr style="border-color:#CCC;"/>
    <asp:Label ID="mensaje" runat="server" ForeColor="#0000ff"></asp:Label>

    <table id="t_form" align="left" runat="server" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr style=" background-color: #DBDBDB"><td colspan="6">&nbsp;&nbsp;&nbsp; <strong> Datos Personales</strong></td></tr>
        <tr style="height: 10px;"><td>&nbsp;</td><td></td><td></td></tr>
    </table>
    <table id="t_form1" align="left" runat="server" border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr style="height: 30px;">
            <td align="right">Tipo Documento.:</td><td></td>
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
            <td align="right">Sexo:</td><td></td>
            <td align="left">
                <asp:DropDownList ID="Sexo" runat="server">
                    <asp:ListItem></asp:ListItem>
                    <asp:ListItem Value="F">Femenino</asp:ListItem>
                    <asp:ListItem Value="M">Masculino</asp:ListItem>
                    <asp:ListItem Value="I">Indeterminado</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="Sexo" ErrorMessage="* Obligatorio" runat="server" />
                <asp:Button ID="BuscarPersona" runat="server" Text="Buscar Persona" CausesValidation="false" OnClick="BuscarPersona_Click" />
            </td>
        </tr>
        <tr ><td colspan="10"><hr /></td></tr>
    </table>
    <table id="t_form2" visible="false" align="left" runat="server" border="0" cellpadding="0" cellspacing="0" width="100%" >
        <tr style="height: 30px;">
            <td align="right">Nombre:</td><td></td><td>
                <asp:TextBox ID="Nombre" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="Nombre" ErrorMessage="* Obligatorio" runat="server" />
            </td>
            <td align="right">Apellido:</td><td></td>
            <td>
                <asp:TextBox ID="Apellido" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="Apellido" ErrorMessage="* Obligatorio" runat="server" />
            </td>
        </tr>
       
        <tr style="height: 30px;">
            <td align="right">Nacionalidad: </td><td></td><td align="left"><asp:DropDownList ID="DDNacionalidad" runat="server"></asp:DropDownList></td>
            <td align="right">Estado Civil: </td><td></td><td align="left"><asp:DropDownList ID="DDEstadoCivil" runat="server"></asp:DropDownList></td>
        </tr>
        <tr style="height: 30px;">
            <td align="right">Domicilio: </td><td></td><td><asp:TextBox ID="Domicilio" runat="server" Columns="45"></asp:TextBox></td>
            <td align="right">Fecha de Nacimiento:</td><td></td>
            <td>
                
                <asp:TextBox ID="FechNac" runat="server"></asp:TextBox><asp:ImageButton ID="imgPopup" ImageUrl="~/img/calendar.png" ImageAlign="Bottom" runat="server" />
            </td>
        </tr>
        <tr style="height: 30px;"><td align="right">Departamento: </td><td></td><td><asp:DropDownList ID="DDDepartamento" runat="server"></asp:DropDownList></td>
            <td align="right">Localidad: </td><td></td><td align="left"><asp:DropDownList ID="DDLocalidad" runat="server"></asp:DropDownList></td>
        </tr>
        <tr style="height: 30px;">
            <td align="right">Código Postal: </td><td></td><td><asp:TextBox ID="CodPostal" runat="server"></asp:TextBox></td>
            <td align="right">CUIL: </td><td></td><td align="left"><asp:TextBox ID="CUIL" runat="server"></asp:TextBox></td>
        </tr>
        <tr style="height: 30px;">
            <td align="right">Teléfono: </td><td></td><td><asp:TextBox ID="Telefono" runat="server"></asp:TextBox></td>
            <td align="right">Correo: </td><td></td><td align="left"><asp:TextBox ID="Correo" runat="server"></asp:TextBox></td>
        </tr>
        <tr style="height: 10px;"><td>&nbsp;</td><td></td><td></td><td></td><td></td><td></td></tr>
        <tr style=" background-color: #DBDBDB"><td colspan="6">&nbsp;&nbsp;&nbsp; <strong> Datos Afiliado</strong></td></tr>
        <tr style="height: 10px;"><td>&nbsp;</td><td></td><td></td><td></td><td></td><td></td></tr>
         <tr style="height: 30px;">
            <td align="right">Fecha de Ingreso:</td><td></td><td>
                <asp:TextBox ID="FechaIngresoB" runat="server"></asp:TextBox>
                <asp:ImageButton ID="imgPopup2" ImageUrl="~/img/calendar.png" ImageAlign="Bottom" runat="server" />
            </td>
            <td align="right">Estado: </td><td></td><td align="left">
                    <asp:DropDownList ID="DDEstadoB" runat="server">
                        <asp:ListItem Value="Activo">Activo</asp:ListItem>
                        <asp:ListItem Value="Inactivo">Inactivo</asp:ListItem>
                        <asp:ListItem Value="Bloqueado">Bloqueado</asp:ListItem>
                        <asp:ListItem Value="DeBaja">De Baja(NO Liq.)</asp:ListItem>
                        <asp:ListItem Value="Jubilado">Jubilado(NO Liq.)</asp:ListItem>
                     </asp:DropDownList>
            </td>
        </tr>
        <tr style="height: 30px;">
            <td align="right">Padrón: </td><td></td><td><asp:TextBox ID="PadronB" runat="server" MaxLength="9"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="PadronB" ErrorMessage="* Obligatorio" runat="server" /></td>
            <td align="right">Centro: </td><td></td><td align="left"><asp:DropDownList ID="DDCentro" runat="server"></asp:DropDownList></td>
        </tr>
        <tr style="height: 30px;">
            <td align="right">Sector: </td><td></td><td><asp:DropDownList ID="DDSector" runat="server"></asp:DropDownList></td>
            <td align="right">Clase: </td><td></td><td align="left"><asp:DropDownList ID="DDClase" runat="server"></asp:DropDownList></td>
        </tr>
        <tr style="height: 30px;">
            <td align="right">Categoría: </td><td></td><td><asp:TextBox ID="CategoriaB" runat="server"></asp:TextBox></td>
            <td align="right">Antigüedad al Ingresar: </td><td></td><td align="left"><asp:TextBox ID="AntiguedadB" runat="server" MaxLength="2" Width="40px"></asp:TextBox>  <asp:Label ID="AntiguedadEstimada" runat="server" ></asp:Label></asp:TextBox></td>
        </tr>
        <tr style="height: 30px;">
            <td align="right">Obra Social: </td><td></td><td><asp:DropDownList ID="DDObraSocial" runat="server"></asp:DropDownList></td>
            <td align="right"></td>
        </tr>
        <tr style=" background-color: #DBDBDB"><td colspan="6">&nbsp;&nbsp;&nbsp; <strong> Coseguro </strong></td></tr>
        <tr style="height: 30px;">
            <td align="right">¿Coseguro?:</td><td></td><td>
                <asp:DropDownList ID="DDCoseguro" runat="server"  AutoPostBack="true"  onselectedindexchanged="DDCoseguro_SelectedIndexChanged"></asp:DropDownList>
                <asp:Label ID="CoseguroActual" runat="server" Visible="false"></asp:Label>
                <asp:Label ID="MsjCoseguro" runat="server" Visible="true"></asp:Label>
            </td>
            <td align="right"></td><td></td><td></td>
        </tr>
        <tr style="height: 10px;"><td>&nbsp;</td><td></td><td></td><td></td><td></td><td></td></tr>
        <tr style="height: 30px; background-color: #DBDBDB">
            <td></td>
            <td></td>
            <td></td>
            <td align="center"></td>
            <td> </td>
            <td>
            <asp:Button ID="btn_Cancelar" runat="server" Text="« Volver" CausesValidation="false" OnClick="Cancelar_Click"  class="btn btn-info" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btn_Guardar" runat="server" Text="> Guardar <" OnClick="Guardar_click" class="btn btn-success"/>
                <asp:Label ID="Lab_buscar" ForeColor="Red" runat="server" Text="* Debe buscar una persona"></asp:Label>
            </td>
        </tr>
        <tr style="height: 10px;"><td>&nbsp;</td><td></td><td></td><td></td><td></td><td></td></tr>
        <tr style="height: 10px;"><td></td><td></td><td></td><td></td><td></td><td></td></tr>
    </table>
    <asp:Label ID="IdPersonaT" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="IdAfiliadoT" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="accion" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="accioncoseguro" runat="server" Visible="false"></asp:Label>
     <asp:Label ID="CoseguroInicial" runat="server" Visible="false"></asp:Label>
     <asp:Label ID="EstadoInicial" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="parametro" runat="server" Visible="false"></asp:Label>
    <table id="t_grilla" runat="server" width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr>
            <td>
               <table id="Table1" runat="server" width="100%" bgcolor="#EBEBEB" border="0">
                    <tr>
                        <td colspan="2" align="left"><strong>Buscar por:</strong></td> 
                        <td height="30" colspan="3" align="right" bgcolor="#FFFFFF">
                        <asp:Button ID="Button3" runat="server"  Text=">> Nuevo Afiliado" OnClick="AgregarNuevo" class="btn btn-success" /></td>
                    </tr>
                    <tr> <td height="8" colspan="5" align="left"></td></tr>
                    <tr> 
                          <td>Padrón:</td>
                          <td><asp:TextBox ID="Padron" runat="server" CssClass="form-control"></asp:TextBox></td>
                          <td>Estado:</td>
                          <td>
                          <asp:DropDownList ID="DDEstado" runat="server" CssClass="form-control">
                            <asp:ListItem Value="Activo">Activo</asp:ListItem>
                            <asp:ListItem Value="Todos">Todos</asp:ListItem>
                            <asp:ListItem Value="Inactivo">Inactivo</asp:ListItem>
                            <asp:ListItem Value="Bloqueado">Bloqueado</asp:ListItem>
                            <asp:ListItem Value="DeBaja">De Baja(NO Liq.)</asp:ListItem>
                            <asp:ListItem Value="Jubilado">Jubilado(NO Liq.)</asp:ListItem>
                         </asp:DropDownList>
                         </td>
                         <td></td>
                    </tr> 
                   <tr> <td height="8" colspan="5" align="left"></td></tr>
                    <tr> 
                     <td>Nombre:</td>
                     <td><asp:TextBox ID="NombreB" runat="server" CssClass="form-control"></asp:TextBox></td>
                     <td>Apellido:</td>
                     <td><asp:TextBox ID="ApellidoB" runat="server" CssClass="form-control"></asp:TextBox></td>
                     <td></td>
                    </tr> 
                   <tr> <td height="8" colspan="5" align="left"></td></tr>
                    <tr>
                        <td>DNI:</td>
                        <td><asp:TextBox ID="DocumentoB" runat="server" CssClass="form-control"></asp:TextBox></td>
                        <td colspan="2"><asp:Button ID="Button1" runat="server" OnClick="Buscar_Click" Text="Buscar Afiliado" class="btn btn-primary" />
                         <asp:Button  ID="Button5" runat="server" OnClick="Cancelar_Click" Text="Limpiar" class="btn btn-default" /></td>
                    </tr> 
                   <tr> <td height="8" colspan="5" align="left"></td></tr>
                </table>
                <hr style="border-color:#CCC;"/>
            </td>
        </tr>
        <tr><td></td></tr>
        <tr>
            <td>
                <asp:GridView ID="gview" runat="server" OnRowDataBound="gview_RowDatabound" 
                  OnRowDeleting="gview_RowDeleting" OnRowCommand="gview_RowCommand" OnRowUpdating="gview_RowUpdating" AutoGenerateColumns="False" class="table table-striped table-bordered"
                    EmptyDataText="No hay resultados.">
                    <AlternatingRowStyle BackColor="White" />
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
                        <asp:TemplateField HeaderText="IdAfiliado" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="IdAfiliado" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "IdAfiliado")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Padrón">
                            <ItemTemplate>
                                <asp:Label ID="Padron" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Padron")%>'></asp:Label>
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
                        <asp:TemplateField HeaderText="Centro">
                            <ItemTemplate>
                                <asp:Label ID="Centro" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Centro")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Sector">
                            <ItemTemplate>
                                <asp:Label ID="Sector" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Sector")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Clase">
                            <ItemTemplate>
                                <asp:Label ID="Clase" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Clase")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Coseguro">
                            <ItemTemplate>
                                <asp:Label ID="Coseguro" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Coseguro")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Estado">
                            <ItemTemplate>
                                <asp:Label ID="Estado" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Estado")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ingreso">
                        <ItemTemplate>
                        <asp:Label id="Ingreso" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FechaIngreso")%>'></asp:Label>	
                        </ItemTemplate>  
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Departamento">
                        <ItemTemplate>
                        <asp:Label id="Departamento" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Departamento")%>'></asp:Label>	
                        </ItemTemplate>  
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tipo">
                        <ItemTemplate>
                        <asp:Label id="Tipo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Tipo")%>'></asp:Label>	
                        </ItemTemplate>  
                        </asp:TemplateField>
                         <asp:TemplateField >
                            <ItemTemplate>
                                <asp:LinkButton ID="Mostrar" runat="server" CommandName="Mostrar" CommandArgument = '<%# DataBinder.Eval(Container.DataItem, "IdAfiliado")%>' 
                                 ToolTip="Consultar"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                            </ItemTemplate> 
                        </asp:TemplateField>
                        <asp:TemplateField  >
                            <ItemTemplate>
                                <asp:LinkButton ID="Editar" Visible="<%# AMET.PermisoOperador()%>"  runat="server" CommandName="Update" CommandArgument = '<%# DataBinder.Eval(Container.DataItem, "IdAfiliado")%>' 
                                 ToolTip="Modificar"><span class="glyphicon glyphicon-edit" style="color:green"></span></asp:LinkButton>
                            </ItemTemplate> 
                        </asp:TemplateField>
                       
                        <asp:TemplateField  >
                            <ItemTemplate>
                                <asp:LinkButton Visible="<%# AMET.PermisoOperador()%>" ID="lnkRemove" runat="server" CommandName="Delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "IdAfiliado")%>'
                                    OnClientClick="return confirm('¿Esta seguro que desea DAR DE BAJA a este Afiliado?')" ToolTip="Eliminar">
                                    <span class="glyphicon glyphicon-remove" style="color:red"></span></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField  ItemStyle-BackColor="#DBDBDB">
                            <ItemTemplate>
                                <div class="btn-group">                         
                                  <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                                     Seleccione una opción
                                    <span class="caret"></span>
                                  </button>
                                  <ul class="dropdown-menu" role="menu" >
                                      <li><asp:LinkButton Visible="<%# AMET.PermisoOperador()%>" ID="Autorizados" runat="server" CommandName="Autorizados" CommandArgument = '<%# DataBinder.Eval(Container.DataItem, "IdAfiliado")%>' 
                                 ToolTip="Autorizados"><span class="glyphicon glyphicon-user"></span> Autorizados</asp:LinkButton></li>
                                      <li><asp:LinkButton Visible="<%# AMET.PermisoOperador()%>" ID="Ordenes" runat="server" CommandName="Ordenes" CommandArgument = '<%# DataBinder.Eval(Container.DataItem, "IdAfiliado")%>' 
                                 ToolTip="Ordenes"><span class="glyphicon glyphicon-list-alt"></span> Ordenes</asp:LinkButton></li>
                                      <li><asp:LinkButton Visible="<%# AMET.PermisoOperador()%>" ID="SolicitudIngreso" runat="server" CommandName="SolicitudIngreso" CommandArgument = '<%# DataBinder.Eval(Container.DataItem, "IdAfiliado")%>' 
                                 ToolTip="Solicitud De Ingreso"><span class="glyphicon glyphicon-th-list"></span> Solicitud de Ingreso</asp:LinkButton></li>
                                      <li><asp:LinkButton ID="Proyeccion" runat="server" CommandName="Proyeccion" CommandArgument = '<%# DataBinder.Eval(Container.DataItem, "IdAfiliado")%>' 
                                 ToolTip="Consultar Proyección"><span class="glyphicon glyphicon-stats"></span> Proyección</asp:LinkButton></li>
                                      <li><asp:LinkButton Visible="<%# AMET.PermisoOperador()%>" ID="Sabana" runat="server" CommandName="Sabana" CommandArgument = '<%# DataBinder.Eval(Container.DataItem, "IdAfiliado")%>' 
                                 ToolTip="ver Sábana del Afiliado"><span class="glyphicon glyphicon-print"></span> Sábana</asp:LinkButton></li>
                                 </ul>
                              </div>
                            </ItemTemplate> 
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <br />
                <br />
            </td>
        </tr>
    </table>
</asp:Content>
