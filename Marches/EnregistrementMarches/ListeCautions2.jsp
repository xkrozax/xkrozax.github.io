<%@ page language="java" import="java.util.*" import="java.text.SimpleDateFormat" import="metier.Cautions" import="java.math.BigDecimal" contentType="text/html; charset=UTF-8"%>
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
	Cautions[] tabCautions;
	tabCautions=(Cautions[])request.getAttribute("listeCautions");
	BigDecimal nombreDecimal=new BigDecimal("00.00").setScale(2, BigDecimal.ROUND_DOWN);
	String   role = "";
	if ((String) session.getAttribute("role") != null){
      role = (String) session.getAttribute("role");  
    }
	 %>
	<% int size = tabCautions.length;  
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
	$('#ajouterCaution').click(function ajouterCaution() 
    { 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterCautionD.do", 
            data:$("#formAjouterCaution").serialize(),
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
               $("#listeCautions").html(html);  
               $("#listeCautions").show();     
            } 
         }); 
    } 
    );
    </script>
	<%for(int i=0;i<tabCautions.length;i++) {%>
    <script type="text/javascript">
   	$('#modifierCaution<%=i%>').click(function modifierCaution() 
    {         
        $("#chargement").show();
        $("#idCaution").val("<%= tabCautions[i].getIdCaution() %>");
        $("#numCaution4").val($('#numCaution2<%=i%>').val());
        $("#dateEtablissement4").val($('#dateEtablissement2<%=i%>').val());
        $("#montantCaution4").val($('#montantCaution2<%=i%>').val());
        $("#etablissement4").val($('#etablissement2<%=i%>').val());
        $("#etatCaution4").val($('#etatCaution2<%=i%>').val());
        $("#dateDepot4").val($('#dateDepot2<%=i%>').val());
        $("#dateRemise4").val($('#dateRemise2<%=i%>').val());
       
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "modifierCaution.do", 
            data:$("#formAjouterCaution").serialize(),
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
    $('#exporterMainLeveeCaution<%=i%>').click(function exporterMainLeveeCaution() 
    {         
        $("#chargement").show();
        $("#idCaution").val("<%= tabCautions[i].getIdCaution() %>");    
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "exporterMainLeveeCaution.do", 
            data:$("#formAjouterCaution").serialize(),
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
               window.location.replace("../../MarchesPublics/Fichiers/MainLeveeCaution.docx");                                        
            } 
         }); 
    } 
    );
    
    $('#afficherDocuments<%=i%>').click(function afficherDocuments() 
    {         
        $("tr").removeClass("table tr tr-selectionner2");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner2");
        $("#idCourrier1").val("<%= tabCautions[i].getIdCaution() %>");
        $("#idCourrier2").val("<%= tabCautions[i].getIdCaution() %>");
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
     <%if(tabCautions.length>0){ %>
     <%}
       else
       { %>
         <center>  Aucun Caution </center>
      <%} %>
     <%if(tabCautions.length>0){ %>
     <%for(int j=0;j<nbPage;j++){ %>
     <table id="<%=j%>"  border="4" bgcolor=""  bordercolor="#000000" class="table table-hover " width="" >     <tr>    
     <tr> 
     <th width=""> N° Caution Définitive</th>
     <th width=""> Date Etablissement </th>
     <th width="" > Banque / Etablissement </th>
     <th width=""> Montant de la Caution </th>
     <th width=""> Date Dépot </th>
     <th width=""> Etat de Caution </th>
     <th align="left"> Date Main Levée </th>
     <% if( (role.equals("Représentant Chef Service Marchés") || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") )) { %>           
     <th>   </th>
     <th>   </th>
     <%} %>
     </tr>   
     <% int debut = j*sizeParPage, fin = (j+1)*sizeParPage; %>
     <%for(int i=debut;i<fin && i < size;i++) {%>
     <tr>  
     <%if (!tabCautions[i].getNumCaution().equals("0")) {	%>
     <td align="center"> <input type="number" name="numCaution2<%=i%>" id="numCaution2<%=i%>" class="number_input"  value="<%=tabCautions[i].getNumCaution()%>" width="120"/> </td> 
     <%}else  {%><td align="center"> <input type="number" name="numCaution2<%=i%>" id="numCaution2<%=i%>" class="number_input"  value="" width="120"/> </td><%} %>
     <td align="center"> <input type="date" name="dateEtablissement2<%=i%>" id="dateEtablissement2<%=i%>" class="newsletter_input"  value="<%=tabCautions[i].getDateEtablissement()%>" size="10"/></td>          
     <td align="center"><input type="text" name="etablissement2<%=i%>" id="etablissement2<%=i%>" class="newsletter_input"  value="<%=tabCautions[i].getEtablissement()%>" size="36"/></td>    
     <%if (tabCautions[i].getMontantCaution() != nombreDecimal) {	%>
     <td align="center"><input type="number" name="montantCaution2<%=i%>" id="montantCaution2<%=i%>" class="number_input2"  value="<%=tabCautions[i].getMontantCaution()%>" size="14"/> </td>   
     <%}else  {%><td align="center"> <input type="number" name="montantCaution2<%=i%>" id="montantCaution2<%=i%>" class="number_input2"  value="" size="14"/></td><%} %>
     <td align="center"><input type="date" name="dateDepot2<%=i%>" id="dateDepot2<%=i%>" class="newsletter_input"  value="<%=tabCautions[i].getDateDepot()%>" size="10"/></td>    
     <td align="center"><select name="etatCaution2<%=i%>"   id="etatCaution2<%=i%>"  class="newsletter_input"  >	
                        <option  value="<%=tabCautions[i].getEtatCaution()%>"><%=tabCautions[i].getEtatCaution()%></option> 
                        <option  value="-------------">-------------</option>                             
	                    <option  value="Déposée">Déposée</option> <option  value="à Remettre">à Remettre</option>	
	                    <option  value="Restituée">Restituée</option> <option  value="Confisquée">Confisquée</option>	                                      
	                    </select>
     </td>      
     <td align="center"><input type="date" name="dateRemise2<%=i%>" id="dateRemise2<%=i%>"   value="<%=tabCautions[i].getDateRemise()%>" size="10"/>
     
     </td>
     <% if( (role.equals("Représentant Chef Service Marchés") || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") )) { %>                
     <td align="center"><input type="button" class="btn btn-default4" id="modifierCaution<%=i%>"  value="Enregistrer" size="35"/> </td> 
     <td align="center"><input type="button" class="btn btn-default4" id="afficherDocuments<%=i%>"  value="Pièces jointes" size="35"/></td>
     <%} %>   
     </tr>
     <%} %>
     </table>
     <%} %>
     <%} %>
    
  </body>
</html>