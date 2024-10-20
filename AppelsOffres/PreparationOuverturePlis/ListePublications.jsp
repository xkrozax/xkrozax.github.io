<%@ page language="java" import="java.util.*" import="metier.Journauxao" import="metier.Journaux"  contentType="text/html; charset=UTF-8"%>
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
	Journauxao [] tabJournauxao;
	tabJournauxao=(Journauxao[])request.getAttribute("listeJournauxao"); 
	Journaux [] tabJournaux;
	tabJournaux=(Journaux[])request.getAttribute("listeJournaux"); 
	String   role = "";
	if ((String) session.getAttribute("role") != null){
      role = (String) session.getAttribute("role");  
    } 
	%>
	<% int size = tabJournauxao.length;  
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
     var size =<%=tabJournauxao.length%>;  
			var sizeParPage = 16;
			var nbPage = <%=nbPage%>;
			var numPage = 0;
    	
	 $(document).ready(function(){   		
	        for(var i=0;i<nbPage;i++){
	        	if(i==numPage){
	        		$("#"+i+"").show();
	        	} else {
	        		$("#"+i+"").hide();
	        	}
	        }
   
	   });
	   
	   function afficher(){
	   			//alert(numP);
	   			//e.preventDefault();

				if(numPage==(nbPage-1)){
				  
					$("#premier").removeAttr("disabled");
		   			$("#precedent").removeAttr("disabled");
		   			$("#next").attr("disabled", "disabled");
		   			$("#dernier").attr("disabled", "disabled");
				}else if(numPage==0){
					$("#premier").attr("disabled", "disabled");
		   			$("#precedent").attr("disabled", "disabled");
		   			$("#next").removeAttr("disabled");
		   			$("#dernier").removeAttr("disabled");
				} else {
					$("#premier").removeAttr("disabled");
		   			$("#precedent").removeAttr("disabled");
		   			$("#next").removeAttr("disabled");
		   			$("#dernier").removeAttr("disabled");
				}

	   			for(var i=0;i<nbPage;i++){
	   			    
	        		if(i==numPage){
		        		$("#"+i+"").show();
		        		$("#page"+i+"").addClass("active btn-info");
		        		$("#page"+i+"").removeClass("btn-default");
		        	} else {
		        		$("#"+i+"").hide();
		        		$("#page"+i+"").addClass("btn-default");
		        		$("#page"+i+"").removeClass("active btn-info");
		        	}
	            }
	   		
	   };
	   		
	   function precedent(){
	   
	   		if(numPage>0){
	   			numPage--;
	   		}
	   		afficher();
	   };
	   function next(){
	   
	   		if(numPage<(nbPage-1)){
	   			numPage++; 
	   		}
	   		afficher();
	   };
	   function afficherPage(numP){
	   		numPage = numP;
	   		afficher();
	   };
	  
	</script>	
	<script type="text/javascript">	
    $('#ajouterPublication').click(function ajouterPublication() 
    { 
        $("#chargement").show();  
        $("#formAjouterPublication").show();
        $("#formAjouterMembresCommission1").hide();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterPublication.do", 
            data:$("#formAjouterPublication").serialize(),
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
               $("#listePublication").html(html); 
               $("#listePublication").show();
               $("#listeMembresCommission1").hide();
               $("#listeMembresCommission2").hide();   
            } 
         }); 
    } 
    ); 
    </script>
	<%for(int i=0;i<tabJournauxao.length;i++) {%>
    <script type="text/javascript">
    $('#exporterPublication<%=i%>').click(function exporterPublication() 
    {         
        $("#chargement").show();
        $("#nomJournal3").val("<%= tabJournauxao[i].getNomJournal() %>");
        $("#typeAvis3").val("<%= tabJournauxao[i].getTypeAvis() %>");
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "exporterPublication.do", 
            data:$("#formExporterPublication").serialize(),
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
               window.location.replace("../../MarchesPublics/Fichiers/DemandePublicationAO.docx");              
            } 
         });            
    } 
    );  
    $('#modifierPublication<%=i%>').click(function modifierPublication() 
    {         
        $("#chargement").show();
        $("#idJournal").val("<%= tabJournauxao[i].getIdJournal() %>");
        $("#typeAvis").val($('#typeAvis2<%=i%>').val());
        $("#typeJournal").val($('#typeJournal2<%=i%>').val());
        $("#nomJournal").val($('#nomJournal2<%=i%>').val());
        $("#numAvis").val($('#numAvis2<%=i%>').val()); 
       
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "modifierPublication.do", 
            data:$("#formAjouterPublication").serialize(),
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
   	$('#supprimerPublication<%=i%>').click(function supprimerPublication() 
    {         
        $("#idJournal").val("<%= tabJournauxao[i].getIdJournal() %>");
        $("tr").removeClass("table tr tr-selectionner");  
        $("#lignePublication<%=i%>").addClass("table tr tr-selectionner"); 
        $("#dialogPublication1").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialogPublication1").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                               type: "POST", 
                               enctype:"multipart/form-data",
                               url: "supprimerJournalAo.do", 
                               data:$("#formAjouterPublication").serialize(),
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
                              $('#lignePublication<%=i%>').hide(); 
                              $("#dialogPublication2").dialog({
	                          autoOpen: true, 
                              buttons: {
                              OK: function() {
                              $("#dialogPublication2").dialog("close");                   
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
               $( "#dialogPublication2" ).dialog("open");                                 
            } 
         }); 
               // ---------------------------                                     
                 $("#dialogPublication1").dialog("close"); 
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
               $( "#dialogPublication1" ).dialog("open");                   
    } 
    ); 
    
    $('#afficherDocumentsPublication<%=i%>').click(function afficherDocumentsPublication() 
    {         
        $("tr").removeClass("table tr tr-selectionner2");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner2");
        $("#idCourrier1").val("<%= tabJournauxao[i].getIdJournal() %>");
        $("#idCourrier2").val("<%= tabJournauxao[i].getIdJournal() %>");
        $("#typeDocument1").val("Journal");
        $("#typeDocument2").val("Journal");
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
   
     <%if(tabJournauxao.length>0){ %>
     <%}
       else
       { %>
     <table   border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="" >    
     <tr>    
     <th width="" align="center"> Nom Sous-Traitant  </th>
     <th width=""> Prestations à sous-traiter </th>
     <th  align="center"> Montant Sous-Traitance    </th>
	 <th  align="center"> Montant Payé </th>
	 <th  align="center"> Reste à Payé </th>		
     <th colspan="4" width=""> <input type="button" class="btn btn-default4" id="ajouterPublication"  value=" Ajouter Sous-Traitant " size="35"/>
     </th>        
     </tr> 
     <tr><td colspan="11"> <center>Aucun Sous-Traitant</center> </td></tr>  
     </table>
      <%} %>
     <%if(tabJournauxao.length>0){ %>
     <%for(int j=0;j<nbPage;j++){ %>
     
     <table id="<%=j%>"  border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="" >    
     <tr>    
     <th width="" align="center"> Nom Sous-Traitant  </th>
     <th width=""> Prestations à sous-traiter </th>
     <th  align="center"> Montant Sous-Traitance    </th>
	 <th  align="center"> Montant Payé </th>
	 <th  align="center"> Reste à Payé </th>		
     <th colspan="5" width=""> <input type="button" class="btn btn-default4" id="ajouterPublication"  value=" Ajouter Sous-Traitant " size="35"/>
     </th>  
     </tr>   
     <% int debut = j*sizeParPage, fin = (j+1)*sizeParPage; %>
     <%for(int i=debut;i<fin && i < size;i++) {%>
     <tr id="lignePublication<%=i%>"> 
     <td align="center"><input type="text" name="nomJournal2<%=i%>" id="nomJournal2<%=i%>" class="number_input"  value="<%=tabJournauxao[i].getNomJournal()%>" size="20"/> </td>
     <td align="center"><input type="text" name="typeJournal2<%=i%>" id="typeJournal2<%=i%>" value="<%=tabJournauxao[i].getTypeJournal()%>" size="40"/> </td>
     <td align="center"><input type="number" name="typeAvis2<%=i%>" id="typeAvis2<%=i%>" class="number_input" value="<%=tabJournauxao[i].getTypeAvis()%>" size="16"/> </td>    
     <td align="center"><input type="number" name="numAvis2<%=i%>" id="numAvis2<%=i%>" class="number_input"  value="<%=tabJournauxao[i].getNumAvis()%>" size="16"/> </td>
     <td align="center"><%=tabJournauxao[i].getDateAvis()%></td>
     <%if(  ( role.equals("Employé Service Marchés") || role.equals("Représentant Chef Service Marchés") 
     || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") )) { %>
     <td align="center">
     <input type="button" id="modifierPublication<%=i%>" class="btn btn-default4" value="Enregistrer"  size="35"/> 
     <input type="button" id="supprimerPublication<%=i%>" class="btn btn-default4" value="X" size="35"/> 
     <td align="center"><input type="button" class="btn btn-default4" id="afficherDocumentsPublication<%=i%>"  value="Pièces jointes" size="35"/></td>
     </td>
     <%} %> 
     </tr>
     <%} %>    
     </table>
     <%} %>
     <%} %>
  
     <div class="col-md-8 center">
        <%if(numPage>1){ %>
        	<button class="btn btn-default" id="premier" onclick="afficherPage(0)"> << </button>
        <%} else {%>
        	<button class="btn btn-default" id="premier" onclick="afficherPage(0)" disabled="disabled" > << </button>
        <%} %>
        <%if(numPage>1){ %>
        	<button class="btn btn-default" id="precedent" onclick="precedent()"> < </button>
        <%} else {%>
        	<button class="btn btn-default" id="precedent" onclick="precedent()" disabled="disabled" > < </button>
        <%} %>
        
        
     	<%for(int i=0;i<nbPage;i++){ %>
     		
     		<%if(i==0){ %>
     			<button class="btn btn-info active" id="page<%=i%>" type="button" onclick="afficherPage(<%=i%>)"> <%=i+1 %> </button>
     		<%} else { %>
     			<button class="btn btn-default" id="page<%=i%>" type="button" onclick="afficherPage(<%=i%>)"> <%=i+1 %> </button>
     		<%} %>
     	<%} %>
     	
     	
     	<%if(numPage<size){ %> 
        	<button class="btn btn-default" id="next" onclick="next()"> > </button>
        <%} else {%>
        	<button class="btn btn-default" id="next" onclick="next()" disabled="disabled"> > </button>
        <%} %>
        <%if(numPage<size){ %> 
        	<button class="btn btn-default" id="dernier" onclick="afficherPage(<%=nbPage-1%>)"> >> </button>
        <%} else {%>
        	<button class="btn btn-default" id="dernier" onclick="afficherPage(<%=nbPage-1%>)" disabled="disabled"> >> </button>
        <%} %>
     </div>
  </body>
</html>