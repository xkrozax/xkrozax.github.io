<%@ page language="java" import="java.util.*" import="metier.Appelsoffres" import="java.text.SimpleDateFormat" import="metier.Ordredeservice" contentType="text/html; charset=UTF-8"%>
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
	Ordredeservice[] tabOrdreDeService;
	tabOrdreDeService=(Ordredeservice[])request.getAttribute("listeOrdreDeService");
	 %>
	<% 
    Appelsoffres appelsoffres=null;
    appelsoffres=(Appelsoffres)session.getAttribute("Appelsoffres"); 
    Integer modeOrdreDeService=0; 
    modeOrdreDeService = appelsoffres.getNumOrdreService(); 
    %>
	<% int size = tabOrdreDeService.length;  
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
	$(function(){
	<%if (modeOrdreDeService != 0) {%>
	$("#ajouterModeOrdreDeService").hide();
    $("#ajouterModeOrdreDeService2").show(); 
    <%}else { %>  
    $("#ajouterModeOrdreDeService2").hide();
    $("#ajouterModeOrdreDeService").show();
    <%} %>    	
	});
	
	$('#ajouterModeOrdreDeService').click(function ajouterModeOrdreDeService() 
    { 
      $("#chargement").show();
      $("#modeOrdreDeService").val(20); 
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterModeOrdreDeServiceAR.do", 
            data:$("#formRechercherMarches").serialize(),
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
               $("#listeOrdreDeService").html(html);  
               $("#listeOrdreDeService").show(); 
               $("#ajouterModeOrdreDeService").hide();
               $("#ajouterModeOrdreDeService2").show();     
            } 
         });
    } 
    );
    $('#ajouterModeOrdreDeService2').click(function ajouterModeOrdreDeService2() 
    { 
      $("#chargement").show();
      $("#modeOrdreDeService").val(0);  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterModeOrdreDeServiceAR.do", 
            data:$("#formRechercherMarches").serialize(),
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
               $("#listeOrdreDeService").html(html);  
               $("#listeOrdreDeService").show();  
               $("#ajouterModeOrdreDeService2").hide();
               $("#ajouterModeOrdreDeService").show();    
            } 
         });
    } 
    ); 
	$('#ajouterOrdreDeService').click(function ajouterOrdreDeService() 
    {       
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterOrdreDeServiceAR.do", 
            data:$("#formRechercherMarches").serialize(),
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
               $("#listeOrdreDeService").html(html);  
               $("#listeOrdreDeService").show();     
            } 
         }); 
    } 
    );
    </script>
	<%for(int i=0;i<tabOrdreDeService.length;i++) {%>
    <script type="text/javascript">
    $('#exporterOrdreDeService<%=i%>').click(function exporterOrdreDeService() 
    {                         
        $("#chargement").show();  
        $("#idOrdreDeService").val("<%= tabOrdreDeService[i].getIdOrdreDeService() %>");
        $("#numOrdreService").val($('#numOrdreService2<%=i%>').val());
        $("#dateOrdreService").val($('#dateOrdreService2<%=i%>').val());
        $("#dateSignatureMo").val($('#dateSignatureMo2<%=i%>').val());
        $("#dateRecuEntreprise").val($('#dateRecuEntreprise2<%=i%>').val());
        $("#typeOrdreService").val($('#typeOrdreService2<%=i%>').val()); 
        $("#motifsOrdreService").val($('#motifsOrdreService2<%=i%>').val());  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "exporterOrdreDeService.do", 
            data:$("#formAjouterOrdreDeService").serialize(),
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
               window.location.replace("../../MarchesPublics/Fichiers/OrdreDeService.docx");            
               
            } 
         });      
    });
    
   	$('#modifierOrdreDeService<%=i%>').click(function modifierOrdreDeService() 
    {         
        $("#chargement").show();
        $("#idOrdreDeService").val("<%= tabOrdreDeService[i].getIdOrdreDeService() %>");
        $("#numOrdreService").val($('#numOrdreService2<%=i%>').val());
        $("#dateOrdreService").val($('#dateOrdreService2<%=i%>').val());
        $("#dateSignatureMo").val($('#dateSignatureMo2<%=i%>').val());
        $("#dateRecuEntreprise").val($('#dateRecuEntreprise2<%=i%>').val());
        $("#typeOrdreService").val($('#typeOrdreService2<%=i%>').val());
        $("#motifsOrdreService").val($('#motifsOrdreService2<%=i%>').val());       
        $("#delaiArretPrestation").val($('#delaiArretPrestation2<%=i%>').val());
        $("#numPhase").val($('#numPhase2<%=i%>').val());
       
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "modifierOrdreDeService.do", 
            data:$("#formAjouterOrdreDeService").serialize(),
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
    
    $('#supprimerOrdreDeService<%=i%>').click(function supprimerOrdreDeService() 
    {         
        $("#idOrdreDeService").val("<%= tabOrdreDeService[i].getIdOrdreDeService() %>");
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligneOrdreDeServiceR<%=i%>").addClass("table tr tr-selectionner"); 
        
        $("#dialogOrdreService3").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialogOrdreService3").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                               type: "POST", 
                               enctype:"multipart/form-data",
                               url: "supprimerOrdreDeService.do", 
                               data:$("#formAjouterOrdreDeService").serialize(),
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
                              $('#ligneOrdreDeServiceR<%=i%>').hide(); 
                              $("#dialogOrdreService2").dialog({
	                          autoOpen: true, 
                              buttons: {
                              OK: function() {
                              $("#dialogOrdreService2").dialog("close");                   
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
               $( "#dialogOrdreService2" ).dialog("open");                                 
            } 
         }); 
               // ---------------------------                                     
                 $("#dialogOrdreService3").dialog("close"); 
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
               $( "#dialogOrdreService3" ).dialog("open");          
    } 
    ); 
    
    $('#afficherDocuments<%=i%>').click(function afficherDocuments() 
    {         
        $("tr").removeClass("table tr tr-selectionner2");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner2");
        $("#idCourrier1").val("<%= tabOrdreDeService[i].getIdOrdreDeService() %>");
        $("#idCourrier2").val("<%= tabOrdreDeService[i].getIdOrdreDeService() %>");
        $("#typeDocument1").val("OrdreDeService");
        $("#typeDocument2").val("OrdreDeService");
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
     <%if(tabOrdreDeService.length>0){ %>
     <%}
       else
       { %>
         <center>  Aucun Ordre De Service 
         <input type="button"  id="ajouterOrdreDeService" class="btn btn-default4"  value=" Ajouter ordre de service " size="35"/>
         </center>
      <%} %>
     <%if(tabOrdreDeService.length>0){ %>
     <%for(int j=0;j<nbPage;j++){ %>
     <table id="<%=j%>"  border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="" >     <tr>    
     <tr> 
     <th width="" > Type Ordre Service </th>
     <%if (modeOrdreDeService != 0) {	%>
     <th width="" > Phase </th>
     <th width=""> N° Ordre Service</th>
     <th width=""> Date d'Arrêt / Reprise </th>
     <th width=""> Délai d'Arrêt en jour </th>
     <th width=""> Motifs d'Arrêt </th>
     <th width=""> Date Notification Ordre Service </th>
     <th width=""> Date Reçue par Entrepreneur </th>
     <%}else { %>  
     <th width=""> N° Ordre Service</th>
     <th width=""> Date d'Arrêt / Reprise </th>
     <th width=""> Délai d'Arrêt en jour </th>
     <th width=""> Motifs d'Arrêt </th>
     <th width=""> Date Notification Ordre Service </th>
     <th width=""> Date Reçue par Entrepreneur </th>
     <%} %>
     <th width="952"> <input type="button"  id="ajouterOrdreDeService" class="btn btn-default4"  value=" + Ordre de service " size="35"/> <input type="button" id="ajouterModeOrdreDeService" class="btn btn-default4" value=" + phase" size="35"/>
     <input type="button"  id="ajouterModeOrdreDeService2" class="btn btn-default4"  value=" - Phase" size="35"/>
     </th>
     <th>   </th>
     </tr>   
     <% int debut = j*sizeParPage, fin = (j+1)*sizeParPage; %>
     <%for(int i=debut;i<fin && i < size;i++) {%>
     <tr id="ligneOrdreDeServiceR<%=i%>">  
     <td align="center"><select name="typeOrdreService2<%=i%>"   id="typeOrdreService2<%=i%>"  class="newsletter_input"  >	
     <%if (  (!(tabOrdreDeService[i].getTypeOrdreService().equals("Ordre de service de commencement"))) && ( !(tabOrdreDeService[i].getTypeOrdreService().equals("Ordre de service de commencement partiel"))) ) {	%>
                        <option  value="<%=tabOrdreDeService[i].getTypeOrdreService()%>"><%=tabOrdreDeService[i].getTypeOrdreService()%></option> 
      <%} %>                             
	                    <option  value="Ordre de service d'arrêt">Ordre de service d'arrêt </option><option  value="Ordre de service de reprise">Ordre de service de reprise</option>
	                    <option  value="Ordre de service d'arrêt partiel">Ordre de service d'arrêt partiel</option><option  value="Ordre de service de reprise partiel">Ordre de service de reprise partiel</option>
	                    </select>
     </td>
     <%if (modeOrdreDeService != 0) {	%>
     <td align="center" id="idPhase2" ><select name="numPhase2<%=i%>"   id="numPhase2<%=i%>"  class="newsletter_input"  >	
                        <option  value="<%=tabOrdreDeService[i].getNumPhase()%>"> Phase <%=tabOrdreDeService[i].getNumPhase()%></option>                              
	                    <option  value="1">Phase 1 </option><option  value="2">Phase 2</option><option  value="3">Phase 3</option>	
	                    <option  value="4">Phase 4</option> <option  value="5">Phase 5</option><option  value="6">Phase 6</option>                                    
	                    <option  value="7">Phase 7</option> <option  value="8">Phase 8</option><option  value="9">Phase 9</option>                                    
	                    <option  value="10">Phase 10</option> <option  value="11">Phase 11</option><option  value="12">Phase 12</option>                                    
	                    <option  value="13">Phase 13</option> <option  value="14">Phase 14</option><option  value="15">Phase 15</option>                                    
	                    <option  value="16">Phase 16</option> <option  value="17">Phase 17</option><option  value="18">Phase 18</option>                                    	                    
	                    <option  value="19">Phase 19</option> <option  value="20">Phase 20</option>                        	                    	                    
	                    </select>
     </td>
     <td align="center"> <input type="text" name="numOrdreService2<%=i%>" id="numOrdreService2<%=i%>" class="number_input"  value="<%=tabOrdreDeService[i].getNumOrdreService() %>" size="14"/> </td> 
     <td align="center"> <input type="date" name="dateOrdreService2<%=i%>" id="dateOrdreService2<%=i%>" class="newsletter_input"  value="<%=tabOrdreDeService[i].getDateOrdreService()%>" size="10"/></td>               
     <%if (tabOrdreDeService[i].getDelaiArretPrestation() != 0) {	%>
     <td align="center"> <input type="number" name="delaiArretPrestation2<%=i%>" id="delaiArretPrestation2<%=i%>" class="number_input"  value="<%=tabOrdreDeService[i].getDelaiArretPrestation() %>" width="120"/> </td> 
     <%}else  {%><td align="center"> <input type="number" name="delaiArretPrestation2<%=i%>" id="delaiArretPrestation2<%=i%>" class="number_input"  value="" width="120"/> </td><%} %>
     <td align="center"><input type="text" name="motifsOrdreService2<%=i%>" id="motifsOrdreService2<%=i%>" class="newsletter_input"  value="<%=tabOrdreDeService[i].getMotifsOrdreService()%>" size="40"/></td>     
     <td align="center"> <input type="date" name="dateSignatureMo2<%=i%>" id="dateSignatureMo2<%=i%>"  value="<%=tabOrdreDeService[i].getDateSignatureMo()%>" size="10"/></td>               
     <td align="center"> <input type="date" name="dateRecuEntreprise2<%=i%>" id="dateRecuEntreprise2<%=i%>"   value="<%=tabOrdreDeService[i].getDateRecuEntreprise()%>" size="10"/></td>                  
     <td align="center">
     <input type="button" class="btn btn-default4" id="modifierOrdreDeService<%=i%>"  value="Enregistrer" size="35"/> 
     <input type="button" class="btn btn-default4" id="supprimerOrdreDeService<%=i%>"  value=" X " size="35"/>
     <input type="button" class="btn btn-default2" id="exporterOrdreDeService<%=i%>"  value="Imprimer" size="35"/> 
     </td> 
     <%}else { %>
     <td align="center"> <input type="text" name="numOrdreService2<%=i%>" id="numOrdreService2<%=i%>" class="number_input"  value="<%=tabOrdreDeService[i].getNumOrdreService() %>" size="14"/> </td> 
     <td align="center"> <input type="date" name="dateOrdreService2<%=i%>" id="dateOrdreService2<%=i%>" class="newsletter_input"  value="<%=tabOrdreDeService[i].getDateOrdreService()%>" size="10"/></td>               
     <%if (tabOrdreDeService[i].getDelaiArretPrestation() != 0) {	%>
     <td align="center"> <input type="number" name="delaiArretPrestation2<%=i%>" id="delaiArretPrestation2<%=i%>" class="number_input"  value="<%=tabOrdreDeService[i].getDelaiArretPrestation() %>" width="120"/> </td> 
     <%}else  {%><td align="center"> <input type="number" name="delaiArretPrestation2<%=i%>" id="delaiArretPrestation2<%=i%>" class="number_input"  value="" width="120"/> </td><%} %>
     <td align="center"><input type="text" name="motifsOrdreService2<%=i%>" id="motifsOrdreService2<%=i%>" class="newsletter_input"  value="<%=tabOrdreDeService[i].getMotifsOrdreService()%>" size="40"/></td>     
     <td align="center"> <input type="date" name="dateSignatureMo2<%=i%>" id="dateSignatureMo2<%=i%>"  value="<%=tabOrdreDeService[i].getDateSignatureMo()%>" size="10"/></td>               
     <td align="center"> <input type="date" name="dateRecuEntreprise2<%=i%>" id="dateRecuEntreprise2<%=i%>"   value="<%=tabOrdreDeService[i].getDateRecuEntreprise()%>" size="10"/></td>                   
     <td align="center">
     <input type="button" class="btn btn-default4" id="modifierOrdreDeService<%=i%>"  value="Enregistrer" size="35"/> 
     <input type="button" class="btn btn-default4" id="supprimerOrdreDeService<%=i%>"  value=" X " size="35"/>
     </td>
     <td align="center"><input type="button" class="btn btn-default4" id="afficherDocuments<%=i%>"  value="Pièces jointes" size="35"/></td>        
     <%} %>
     </tr>
     <%} %>
     </table>
     <%} %>
     <%} %>
    
  </body>
</html>