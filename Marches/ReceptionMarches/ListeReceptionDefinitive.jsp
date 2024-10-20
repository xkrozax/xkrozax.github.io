<%@ page language="java" import="java.util.*" import="metier.Reception" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ListeDossierPermisConstruire2.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%
	Reception[] tabReceptions;
	tabReceptions=(Reception[])request.getAttribute("listeReceptions");
	 %>
	<% int size = tabReceptions.length;  
			int sizeParPage = 16;
			int nbPage = 0;
			int marge = size%sizeParPage;
			if ( size <= sizeParPage ){
			nbPage = 1;
			}
			else 
			 {
			   if (marge==0){
			   nbPage = size/sizeParPage;
			   }
			   else{
			   nbPage = size/sizeParPage+1;
			   }
			 } 		 
			int numPage = 0;		
	%>		
		
	<script type="text/javascript">
    $('#ajouterReceptionD').click(function ajouterReceptionD() 
    { 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterReception.do", 
            data:$("#formReceptionDefinitive").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
               $("#chargement").hide();                  
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
               $("#chargement").hide();              
               $("#listeReceptions").html(html);        
            } 
         }); 
    } 
    );
    </script>
    
	<%for(int i=0;i<tabReceptions.length;i++) {%>
    <script type="text/javascript">
    $('#exporterPvReception<%=i%>').click(function exporterPvReception() 
    {                         
        $("#chargement").show();  
        $("#idReception").val("<%= tabReceptions[i].getIdReception() %>");  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "exporterPvReception.do", 
            data:$("#formAjouterReception").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
               $("#chargement").hide();                  
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
               $("#chargement").hide();
               window.location.replace("../../MarchesPublics/Fichiers/PvReception.docx");                            
            } 
         });      
    });
    $('#afficherCommission<%=i%>').click(function afficherCommission() 
    {         
        $("tr").removeClass("table tr tr-selectionner");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner");
        $("#idReception2").val("<%= tabReceptions[i].getIdReception() %>");
        $("#typeCommssion").val("CommissionPrincipale");
        $("#chargement").show();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherMembreCommission3.do", 
            data:$("#formAjouterCommission").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
               $("#chargement").hide();                  
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
               $("#chargement").hide();
               $("#membresCommission").show();
               $("#listeMembresCommission").html(html);  
               $("#listeMembresCommission").show(); 
               $("#dialog1").dialog({
	           autoOpen: true, 
               buttons: {
               OK: function() {
                  $("#dialog1").dialog("close");                   
                  },
               },
               width: 1102,
               height: 453,
               title : "Les membres de la commission",        
               position: {
			       my: "center",
			       at: "center",
			       of: window,
			       collision: "fit",
			       // Ensure the titlebar is always visible
			       using: function( pos ) {
			     	   var topOffset = $( this ).css( pos ).offset().top;
				       if ( topOffset < 0 ) {
					   $( this ).css( "top", pos.top - topOffset );
				       }
			      }
		       }             
               });
               $( "#dialog1" ).dialog("open");                                  
            } 
         }); 
    } 
    ); 
     
    $('#modifierReception<%=i%>').click(function modifierReception() 
    {         
        $("tr").removeClass("table tr tr-selectionner");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner");
        $("#idReception").val("<%= tabReceptions[i].getIdReception() %>");
        $("#typeReception").val($('#typeReception2<%=i%>').val());
        $("#dateReception").val($('#dateReception2<%=i%>').val());
        $("#heureReception").val($('#heureReception2<%=i%>').val()); 
        $("#minuteReception").val($('#minuteReception2<%=i%>').val()); 
        $("#chargement").show();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "modifierReception.do", 
            data:$("#formAjouterReception").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
               $("#chargement").hide();                  
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
               $("#chargement").hide();
               afficherBienEnregistrer();                                      
            } 
         });
    
    } 
    ); 
   	$('#supprimerReception<%=i%>').click(function supprimerReception() 
    {         
        $("#idReception").val("<%= tabReceptions[i].getIdReception() %>");
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=i%>").addClass("table tr tr-selectionner"); 
        
        $("#dialog3").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialog3").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                               type: "POST", 
                               enctype:"multipart/form-data",
                               url: "supprimerReception.do", 
                               data:$("#formAjouterReception").serialize(),
                               dataType: "html", 
                              //timeout : 4000, 
                              error: function()
                              { 
                              alert("invalid"); 
                              $("#chargement").hide();                  
                              }, 
                              beforeSend : function() 
                              { 
                              }, 
                              success: function(html) 
                              { 
                              $("#chargement").hide();
                              $('#ligne<%=i%>').hide(); 
                              $("#dialog2").dialog({
	                          autoOpen: true, 
                              buttons: {
                              OK: function() {
                              $("#dialog2").dialog("close");                   
                              },
                              },
               width: 422,
               height: 192,          
               position: {
			       my: "center",
			       at: "center",
			       of: window,
			       collision: "fit",
			       // Ensure the titlebar is always visible
			       using: function( pos ) {
			     	   var topOffset = $( this ).css( pos ).offset().top;
				       if ( topOffset < 0 ) {
					   $( this ).css( "top", pos.top - topOffset );
				       }
			      }
		       }             
               });
               $( "#dialog2" ).dialog("open");                                 
            } 
         }); 
               // ---------------------------                                     
                 $("#dialog3").dialog("close"); 
                  },
               },
               width: 422,
               height: 192,          
               position: {
			       my: "center",
			       at: "center",
			       of: window,
			       collision: "fit",
			       // Ensure the titlebar is always visible
			       using: function( pos ) {
			     	   var topOffset = $( this ).css( pos ).offset().top;
				       if ( topOffset < 0 ) {
					   $( this ).css( "top", pos.top - topOffset );
				       }
			      }
		       }             
               });
               $( "#dialog3" ).dialog("open");          
    } 
    );  
    
    $('#afficherDocuments<%=i%>').click(function afficherDocuments() 
    {         
        $("tr").removeClass("table tr tr-selectionner2");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner2");
        $("#idCourrier1").val("<%= tabReceptions[i].getIdReception() %>");
        $("#idCourrier2").val("<%= tabReceptions[i].getIdReception() %>");
        $("#chargement").show();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherDocumentPieceJointe.do", 
            data:$("#formDocumentsCourrier").serialize(),
            dataType: "html", 
            //timeout : 4000, 
            error: function()
            { 
               alert("invalid"); 
               $("#chargement").hide();                  
            }, 
            beforeSend : function() 
            { 
            }, 
             success: function(html) 
            { 
               $("#chargement").hide();
               $("#listeDocumentsCourrier").html(html);  
               $("#listeDocumentsCourrier").show(); 
               $("#dialogDocumentsCourrier").dialog({
	           autoOpen: true, 
               buttons: {
               OK: function() {
                  $("#dialogDocumentsCourrier").dialog("close");                   
                  },
               },
               width: 560,
               height: 320,
               title : "Pièces Jointes",        
               position: {
			       my: "center",
			       at: "center",
			       of: window,
			       collision: "fit",
			       // Ensure the titlebar is always visible
			       using: function( pos ) {
			     	   var topOffset = $( this ).css( pos ).offset().top;
				       if ( topOffset < 0 ) {
					   $( this ).css( "top", pos.top - topOffset );
				       }
			      }
		       }             
               });
               $( "#dialogDocumentsCourrier" ).dialog("open");                                  
            } 
         }); 
    } 
    );   
    </script>
    <%} %>   
  </head> 
  <body>  
     <%if(tabReceptions.length>0){ %>
     <%}
       else
       { %>
     <center> 
     <table  border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="1042" align="left">    
     <tr>    
     <th width=""> Type de Réception </th>    
     <th width=""> Date Réception</th> 
     <th> Heure</th>
     <th> Minute </th>  
     <th colspan="3"> <input type="button" class="btn btn-default4" id="ajouterReceptionD"  value=" Ajouter Réception Définitive" size="35"/> </th>    
     </tr>
     <tr><td colspan="8"> <center>Aucune Réception définitive</center> </td></tr> 
     </table>
     </center> 
      <%} %>
     <%if(tabReceptions.length>0){ %>
     <center> 
     <table  border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="1042" align="center">    
     <tr>   
     <th width=""> Type de Réception </th>    
     <th width=""> Date Réception</th> 
     <th> Heure</th>
     <th> Minute </th>  
     <th> </th> 
     <th colspan="3"> <input type="button" class="btn btn-default4" id="ajouterReceptionD"  value=" Ajouter Réception Définitive" size="35"/> </th>    
     </tr>  
   
     <%for(int i=0; i< size;i++) {%>
     <tr id="ligne<%=i%>">
     <td align="center"><select name="typeReception2<%=i%>"   id="typeReception2<%=i%>"  class="newsletter_input"  >
     <option  value="<%= tabReceptions[i].getTypeReception() %>"><%= tabReceptions[i].getTypeReception() %></option>
     <option  value="Réception définitive">Réception définitive</option>
     <option  value="Réception définitive partielle">Réception définitive partielle</option>
     <option  value="Réception définitive générale">Réception définitive générale</option>
     </select>
     </td>      
     <td align="center"> <input type="date" name="dateReception2<%=i%>" id="dateReception2<%=i%>" class="newsletter_input"  value="<%=tabReceptions[i].getDateReception()%>" size="10"/></td>                 
     <td align="center"><select name="heureReception2<%=i%>"   id="heureReception2<%=i%>"  class="newsletter_input"  >
     <option  value="<%= tabReceptions[i].getHeureReception() %>"><%= tabReceptions[i].getHeureReception() %></option><option  value="0">00</option>
     <option  value="1">01</option><option  value="2">02</option><option  value="3">03</option>
	 <option  value="4">04</option><option  value="5">05</option><option  value="6">06</option>
	 <option  value="7">07</option><option  value="8">08</option><option  value="9">09</option>
	 <option  value="10">10</option><option  value="11">11</option><option  value="12">12</option>	            
	 <option  value="13">13</option><option  value="14">14</option><option  value="15">15</option>
	 <option  value="16">16</option><option  value="17">17</option><option  value="18">18</option>
	 <option  value="19">19</option><option  value="20">20</option><option  value="21">21</option>
	 <option  value="22">22</option><option  value="23">23</option>
     </select>
     </td>
     <td align="center"><select name="minuteReception2<%=i%>"   id="minuteReception2<%=i%>"  class="newsletter_input"  >
     <option  value="<%= tabReceptions[i].getMinuteReception() %>"><%= tabReceptions[i].getMinuteReception() %></option><option  value="0">00</option>
     <option  value="1">01</option><option  value="2">02</option><option  value="3">03</option>
	 <option  value="4">04</option><option  value="5">05</option><option  value="6">06</option>
	 <option  value="7">07</option><option  value="8">08</option><option  value="9">09</option>
	 <% for(int k=10;k<60;k++){%>
	 <option  value="<%=k%>"><%=k%></option>
	 <%} %>	 
     </select>
     </td>
     <td align="center"><input type="button" class="btn btn-default" id="afficherCommission<%=i%>"  value=" Commission de la réception" size="35"/>      
     </td>                 
     <td align="center"><input type="button" class="btn btn-default4" id="modifierReception<%=i%>"  value="Enregistrer" size="35"/> </td>                        
     <td align="center"><input type="button" class="btn btn-default4" id="supprimerReception<%=i%>"  value=" X " size="35"/> </td>  
     <td align="center"><input type="button" class="btn btn-default4" id="afficherDocuments<%=i%>"  value="Pièces jointes" size="35"/></td>
     </tr>
     <%} %>
     </table>
     </center> 
     <%} %>
    
  </body>
</html>