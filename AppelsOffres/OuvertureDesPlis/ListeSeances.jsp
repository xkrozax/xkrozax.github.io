<%@ page language="java" import="java.util.*" import="metier.Seances" contentType="text/html; charset=UTF-8"%>
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
	Seances[] tabSeances;
	tabSeances=(Seances[])request.getAttribute("listeSeances");
	String   role = "";
	if ((String) session.getAttribute("role") != null){
      role = (String) session.getAttribute("role");  
    } 
	 %>
	<% int size = tabSeances.length;  
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
    $('#ajouterSeance').click(function ajouterSeance() 
    { 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterSeanceAO.do", 
            data:$("#formAjouterSeance").serialize(),
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
               $("#listeSeances").html(html);        
            } 
         }); 
    } 
    );
    </script>
    
	<%for(int i=0;i<tabSeances.length;i++) {%>
    <script type="text/javascript">
    $('#afficherCommission<%=i%>').click(function afficherCommission() 
    {         
        $("tr").removeClass("table tr tr-selectionner");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner");
        $("#idSeance2").val("<%= tabSeances[i].getIdSeance() %>");
        $("#typeCommssion").val("CommissionPrincipale");
        $("#chargement").show();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherMembreCommission.do", 
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
               title : "Les membres de l'équipe",        
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
    $('#afficherSousCommission<%=i%>').click(function afficherSousCommission() 
    {         
        $("tr").removeClass("table tr tr-selectionner");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner");
        $("#idSeance2").val("<%= tabSeances[i].getIdSeance() %>");
        $("#typeCommssion").val("SousCommission");
        $("#chargement").show();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherMembreCommission.do", 
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
               title : "Les membres de la sous commission",     
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
    $('#modifierSeance<%=i%>').click(function modifierSeance() 
    {         
        $("tr").removeClass("table tr tr-selectionner");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner");
        $("#idSeance").val("<%= tabSeances[i].getIdSeance() %>");
        $("#numSeance").val($('#numSeance2<%=i%>').val());
        $("#dateSeance").val($('#dateSeance2<%=i%>').val());
        $("#typeSeance").val($('#typeSeance2<%=i%>').val()); 
        $("#heureSeance").val($('#heureSeance2<%=i%>').val()); 
        $("#minuteSeance").val($('#minuteSeance2<%=i%>').val()); 
        if( $('input[name=seanceExamenAt2<%=i%>]').is(':checked') ){ $("#seanceExamenAt").val(28); }
        else { $("#seanceExamenAt").val(0); } 
        if( $('input[name=seanceExamenEchantillons2<%=i%>]').is(':checked') ){ $("#seanceExamenEchantillons").val(28); }
        else { $("#seanceExamenEchantillons").val(0); }
        if( $('input[name=seanceExamenOt2<%=i%>]').is(':checked') ){ $("#seanceExamenOt").val(28); }
        else { $("#seanceExamenOt").val(0); }
        if( $('input[name=seanceExamenOf2<%=i%>]').is(':checked') ){ $("#seanceExamenOf").val(28); }
        else { $("#seanceExamenOf").val(0); }
        if( $('input[name=seanceExamenCd2<%=i%>]').is(':checked') ){ $("#seanceExamenCd").val(28); }
        else { $("#seanceExamenCd").val(0); }
        $("#chargement").show();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "modifierSeance.do", 
            data:$("#formAjouterSeance").serialize(),
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
   	$('#supprimerSeance<%=i%>').click(function supprimerSeance() 
    {         
        $("#idSeance").val("<%= tabSeances[i].getIdSeance() %>");
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
                               url: "supprimerSeance.do", 
                               data:$("#formAjouterSeance").serialize(),
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
        $("#idCourrier1").val("<%= tabSeances[i].getIdSeance() %>");
        $("#idCourrier2").val("<%= tabSeances[i].getIdSeance() %>");
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
     <%if(tabSeances.length>0){ %>
     <%}
       else
       { %>
      
     <table  border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="1142" align="left">    
     <tr>    
     <th> N° de Réunion </th>
     <th width="85"> Date Réunion </th> 
     <th> Heure</th>
     <th> Minute </th>  
     <th width="400"> Objet de Réunion </th> 
     <%if( ( role.equals("Employé Service Marchés") || role.equals("Représentant Chef Service Marchés") 
     || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") )) { %>  
     <th colspan="3"> <input type="button" class="btn btn-default4" id="ajouterSeance"  value=" Ajouter Réunion " size="35"/> </th>    
     <%} %>
     </tr>
     <tr><td colspan="11"> <center>Aucun Réunion </center> </td></tr> 
     </table>
      <%} %>
     <%if(tabSeances.length>0){ %>
     <table  border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="1142" align="center">    
     <tr>    
     <th> N° de Réunion </th>
     <th width="85"> Date Réunion </th> 
     <th> Heure</th>
     <th> Minute </th>  
     <th width="400"> Objet de Réunion </th>   
     <th> </th> 
     <%if( ( role.equals("Employé Service Marchés") || role.equals("Représentant Chef Service Marchés") 
     || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") )) { %>  
     <th colspan="3"> <input type="button" class="btn btn-default4" id="ajouterSeance"  value=" Ajouter Réunion " size="35"/> </th>    
     <%} %>
     </tr>  
   
     <%for(int i=0; i< size;i++) {%>
     <tr id="ligne<%=i%>">      
     <%if (tabSeances[i].getNumSeance() != 0) {	%>
     <td align="center"> <input type="number" name="numSeance2<%=i%>" id="numSeance2<%=i%>" class="newsletter_input"  value="<%=tabSeances[i].getNumSeance()%>" width="120"/> </td> 
     <%}else  {%><td align="center"> <input type="number" name="numSeance2<%=i%>" id="numSeance2<%=i%>" class="newsletter_input"  value="" width="120"/> </td><%} %>         
     <td align="center"> <input type="date" name="dateSeance2<%=i%>" id="dateSeance2<%=i%>" class="newsletter_input"  value="<%=tabSeances[i].getDateSeance()%>" size="10"/></td>                 
     <td align="center"><select name="heureSeance2<%=i%>"   id="heureSeance2<%=i%>"  class="newsletter_input"  >
     <option  value="<%= tabSeances[i].getHeureSeance() %>"><%= tabSeances[i].getHeureSeance() %></option><option  value="0">00</option>
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
     <td align="center"><select name="minuteSeance2<%=i%>"   id="minuteSeance2<%=i%>"  class="newsletter_input"  >
     <option  value="<%= tabSeances[i].getMinuteSeance() %>"><%= tabSeances[i].getMinuteSeance() %></option><option  value="0">00</option>
     <option  value="1">01</option><option  value="2">02</option><option  value="3">03</option>
	 <option  value="4">04</option><option  value="5">05</option><option  value="6">06</option>
	 <option  value="7">07</option><option  value="8">08</option><option  value="9">09</option>
	 <% for(int k=10;k<60;k++){%>
	 <option  value="<%=k%>"><%=k%></option>
	 <%} %>	 
     </select>
     </td>
     <td align="center"> <input type="text" name="typeSeance2<%=i%>"   id="typeSeance2<%=i%>"  value="<%= tabSeances[i].getTypeSeance() %>"  size="120" > </td>
     <td align="center">
     <input type="button" class="btn btn-default" id="afficherCommission<%=i%>"  value=" Membre de la Réunion" size="35"/> 
     </td>   
     <%if( ( role.equals("Employé Service Marchés") || role.equals("Représentant Chef Service Marchés") 
     || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") )) { %>                
     <td align="center"><input type="button" class="btn btn-default4" id="modifierSeance<%=i%>"  value="Enregistrer" size="35"/> </td>                        
     <td align="center"><input type="button" class="btn btn-default4" id="supprimerSeance<%=i%>"  value=" X " size="35"/> </td> 
     <td align="center"><input type="button" class="btn btn-default4" id="afficherDocuments<%=i%>"  value="Pièces jointes" size="35"/></td>            
     <%} %>
     </tr>
     <%} %>
     </table>
     <%} %>
    
  </body>
</html>