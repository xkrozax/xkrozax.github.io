<%@ page language="java" import="java.util.*" import="java.text.SimpleDateFormat" import="metier.Appelsoffres"   import="metier.Cautions" import="java.math.BigDecimal" contentType="text/html; charset=UTF-8"%>
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
	%>
    <% 
    Appelsoffres appelsoffres=null;
    appelsoffres=(Appelsoffres)request.getAttribute("Appelsoffres"); 
    Integer idAppelOffre=0; 
    String typeRetenueG = "Retenue de garantie";
    Integer delaiRetenueG = 0;
    if (appelsoffres != null) {
    idAppelOffre=appelsoffres.getIdAppelOffre();
    typeRetenueG=appelsoffres.getTypeRetenueG();
    delaiRetenueG=appelsoffres.getDelaiRetenueG();
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
	$('#enregistrerTypeRg').click(function enregistrerTypeRg() 
    { 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "enregistrerTypeRg.do", 
            data:$("#formRetenueDeGarantie").serialize(),
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
               $("#listeRetenueDeGarantie").html(html);  
               $("#listeRetenueDeGarantie").show(); 
               afficherBienEnregistrer();     
            } 
         }); 
    } 
    );
    $('#ajouterCaution').click(function ajouterCaution() 
    { 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterCautionRg.do", 
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
               $("#listeRetenueDeGarantie").html(html);  
               $("#listeRetenueDeGarantie").show();     
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
    $('#supprimerCaution<%=i%>').click(function supprimerCaution() 
    {         
        $("#idCaution").val("<%= tabCautions[i].getIdCaution() %>");
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligneCaution<%=i%>").addClass("table tr tr-selectionner"); 
        
        $("#dialogCaution3").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialogCaution3").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                               type: "POST", 
                               enctype:"multipart/form-data",
                               url: "supprimerCaution.do", 
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
                              $('#ligneCaution<%=i%>').hide(); 
                              $("#dialogCaution2").dialog({
	                          autoOpen: true, 
                              buttons: {
                              OK: function() {
                              $("#dialogCaution2").dialog("close");                   
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
               $( "#dialogCaution2" ).dialog("open");                                 
            } 
         }); 
               // ---------------------------                                     
                 $("#dialogCaution3").dialog("close"); 
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
               $( "#dialogCaution3" ).dialog("open");          
    } 
    );  
    
    $('#afficherDocuments<%=i%>').click(function afficherDocuments() 
    {         
        $("tr").removeClass("table tr tr-selectionner2");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner2");
        $("#idCourrier1").val("<%= tabCautions[i].getIdCaution() %>");
        $("#idCourrier2").val("<%= tabCautions[i].getIdCaution() %>");
        $("#typeDocument1").val("Caution");
        $("#typeDocument2").val("Caution");
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
     
     <form id="formRetenueDeGarantie" method="post"> 
     <input type="hidden" name="idAppelOffre"    class="newsletter_input"  value="<%=idAppelOffre%>" size="28"/>
     <table  border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="" >      
     <tr> 
     <th width=""> Retenue de garantie</th>
     <% if (! typeRetenueG.equals("Pas de retenue de garantie pour ce marché")) {%>
     <th width=""> Délai de garantie en mois</th>
     <%} else {%>
     <th width=""> </th>
     <%} %>
     <th> <input type="button" class="btn btn-default4" id="ajouterCaution"  value="Ajouter Caution Bancaire" size="35"/> </th>
     </tr>
     <tr>
     <td> <select name="typeRetenueG"   id="typeRetenueG"   >	
                        <option  value="<%=typeRetenueG%>"><%=typeRetenueG%></option> 
                        <option  value="Pas de retenue de garantie pour ce marché">Pas de retenue de garantie pour ce marché</option>                             
	                    <option  value="Retenue de garantie est programmé pour ce marché">Retenue de garantie est programmé pour ce marché</option>                                      
	      </select>
     </td>    
     <% if (! typeRetenueG.equals("Pas de retenue de garantie pour ce marché")) {%>  
     <td align="center"> <input type="number" name="delaiRetenueG" id="delaiRetenueG" class="number_input2" style="text-align:center"   value="<%=delaiRetenueG%>" size="10"/></td> 
     <%} else  {%>
     <td align="center"> <input type="hidden" name="delaiRetenueG" id="delaiRetenueG"   value="<%=delaiRetenueG%>" size="10"/></td> 
     <%} %>
     <td align="center"><input type="button" class="btn btn-default4" id="enregistrerTypeRg"  value="Enregistrer" size="35"/> </td>  
     </tr>    
     </table>
     </form> 
     <%if(tabCautions.length>0){ %>
     <%}
       else
       { %>
         <center>   </center>
      <%} %>
     <%if(tabCautions.length>0){ %>
     <%for(int j=0;j<nbPage;j++){ %>
     <table   border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="" >     <tr>    
     <tr> 
     <th width=""> N° de Caution Bancaire</th>
     <th width=""> Date Etablissement </th>
     <th width="" > Banque / Etablissement </th>
     <th width=""> Montant de la Caution </th>
     <th width=""> Date Dépot </th>
     <th width=""> Etat de Caution </th>
     <th align="left"> Date Main Levée </th>
     <th>   </th>
     <th>   </th>
     </tr>   
     <% int debut = j*sizeParPage, fin = (j+1)*sizeParPage; %>
     <%for(int i=debut;i<fin && i < size;i++) {%>
     <tr id="ligneCaution<%=i%>">  
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
     <td align="center">
     <input type="button" class="btn btn-default4" id="modifierCaution<%=i%>"  value="Enregistrer" size="35"/>
     <input type="button" class="btn btn-default4" id="supprimerCaution<%=i%>"  value="X" size="35"/>
     </td>   
     <td align="center"><input type="button" class="btn btn-default4" id="afficherDocuments<%=i%>"  value="Pièces jointes" size="35"/></td> 
     </tr>
     <%} %>
     </table>
     <%} %>
     <%} %>
    
  </body>
</html>