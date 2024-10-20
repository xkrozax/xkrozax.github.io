<%@ page language="java" import="java.util.*" import="metier.Personnel" import="java.math.BigDecimal"  import="trierObjet.TrierFormatDate"   contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title> </title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%
	Personnel[] tabPersonnel;
	tabPersonnel=(Personnel[])request.getAttribute("listePersonnel");
	 %>
	<% int size = tabPersonnel.length;  
			int sizeParPage = 120;
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
     var size =<%=tabPersonnel.length%>;  
			var sizeParPage = 120;
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
	<%for(int i=0;i<tabPersonnel.length;i++) {%>
    <script type="text/javascript"> 	
    $('#supprimerPersonnel<%=i%>').click(function supprimerPersonnel() 
    {         
        $("#idPersonnel").val("<%= tabPersonnel[i].getIdPersonnel() %>");
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=i%>").addClass("table tr tr-selectionner"); 
        
        $("#dialog5").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialog5").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                               type: "POST", 
                               enctype:"multipart/form-data",
                               url: "supprimerPersonnel.do", 
                               data:$("#formOuvrirPersonnel").serialize(),
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
                              $("#dialog4").dialog({
	                          autoOpen: true, 
                              buttons: {
                              OK: function() {
                              $("#dialog4").dialog("close");                   
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
               $( "#dialog4" ).dialog("open");                                 
            } 
         }); 
               // ---------------------------                                     
                 $("#dialog5").dialog("close"); 
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
               $( "#dialog5" ).dialog("open");          
    });
      
    $('#selectionnerPersonnel<%=i%>').click(function ouvrirDossier() {         
        $("#chargement").show();
        $("#idPersonnel").val("<%= tabPersonnel[i].getIdPersonnel() %>");
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ouvrirSessionPersonnel.do", 
            data:$("#formOuvrirPersonnel").serialize(),
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
               $("#templatemo_menu").show();
               $("#dialog3").dialog({
	           autoOpen: true, 
               buttons: {
               OK: function() {
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
         }); 
    });
    
    $('#selectionnerPersonnel<%=i%>').click(function ajouterPersonnel(){
    
    	$("#id").val("<%= tabPersonnel[i].getIdPersonnel() %>");
    	<% request.setAttribute("selectedPersonnel", tabPersonnel[i]);%>
    	
    });
    $('#modifierPersonnel<%=i%>').click(function ajouterPersonnel(){ 
        	
        	$("#id").val("<%= tabPersonnel[i].getIdPersonnel() %>");
            $("#matricule").val("<%= tabPersonnel[i].getMatricule() %>");
        	$("#nom").val("<%= tabPersonnel[i].getNom() %>");
        	$("#cin").val("<%= tabPersonnel[i].getCin() %>");
        	$("#numCnss").val("<%= tabPersonnel[i].getNumCnss() %>");
        	$("#situationFamiliale").val("<%= tabPersonnel[i].getSituationFamiliale() %>");
        	$("#nbEnfants").val("<%= tabPersonnel[i].getNbEnfants() %>");
        	$("#dateEmbauche").val("<%= tabPersonnel[i].getDateEmbauche() %>");
        	$("#fonction").val("<%= tabPersonnel[i].getFonction() %>");
        	$("#salaireBase").val("<%= tabPersonnel[i].getSalaireBaseParJour() %>");
        	$("#salaireNetApayer").val("<%= tabPersonnel[i].getSalaireNetApayer() %>");
        	$("#adresse").val("<%= tabPersonnel[i].getAdresse() %>");      	
        	$("#prets").val("<%= tabPersonnel[i].getPrets() %>");
        	$("#compteBancaire").val("<%= tabPersonnel[i].getCompteBancaire() %>");
        	$("#banque").val("<%= tabPersonnel[i].getBanque() %>");
        	$("#agenceBancaire").val("<%= tabPersonnel[i].getAgenceBancaire() %>");
        	$("#villeBanque").val("<%= tabPersonnel[i].getVilleBanque() %>");
        	$('#contratAnapec option[value="<%= tabPersonnel[i].getContratAnapec() %>"]').prop('selected',true);
        	$("#dateArretTravail").val("<%= tabPersonnel[i].getDateArretTravail() %>");
        	       	        
        	$("tr").removeClass("table tr tr-selectionner");  
            $("#ligne<%=i%>").addClass("table tr tr-selectionner"); 
            $("#dialogAjouterPersonnel").dialog({
	           autoOpen: true, 
               buttons: {
               Enregistrer: function() {
                     $.ajax({    
                            type: "POST", 
                            enctype:"multipart/form-data",
                            url: "modifierPersonnel.do", 
                            data:$("#formAjouterPersonnel").serialize(),
                            dataType: "html", 
                            error: function(){ 
                             	alert("invalid"); 
                             	$("#chargement").hide();                  
                            }, 
                            beforeSend : function(){ 
                            }, 
                            success: function(html){                                                       
                            	$("#dialogAjouterPersonnel").dialog("close");
                            	afficherBienEnregistrer();
                            	
                            	$('#matricule<%=i%>').html($('#matricule').val());
                            	$('#nom<%=i%>').html($('#nom').val());
                            	$('#cin<%=i%>').html($('#cin').val());
        	                    $('#numCnss<%=i%>').html($('#numCnss').val());
        	                    $('#situationFamiliale<%=i%>').html($('#situationFamiliale').val());
        	                    $('#nbEnfants<%=i%>').html($('#nbEnfants').val());
        	                    $('#dateEmbauche<%=i%>').html($('#dateEmbauche').val());
        	                    $('#fonction<%=i%>').html($('#fonction').val());
        	                    $('#salaireBase<%=i%>').html($('#salaireBase').val());
        	                    $('#salaireNetApayer<%=i%>').html($('#salaireNetApayer').val());
        	                    $('#adresse<%=i%>').html($('#adresse').val());       	
        	                    $('#prets<%=i%>').html($('#prets').val());
        	                    $('#compteBancaire<%=i%>').html($('#compteBancaire').val());
        	                    $('#banque<%=i%>').html($('#banque').val());
        	                    $('#agenceBancaire<%=i%>').html($('#agenceBancaire').val());
        	                    $('#villeBanque<%=i%>').html($('#villeBanque').val());
        	                    $('#dateArretTravail<%=i%>').html($('#dateArretTravail').val());
                           }
                      }); 
                  },
               },
               width: 900,
               height: 540,        
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
               $( "#dialogAjouterPersonnel" ).dialog( "open" );                                    
      }); 
    
    $('#rechercherAvancePersonnel<%=i%>').click(function rechercherAvancePersonnel() 
    {         
        $("tr").removeClass("table tr tr-selectionner");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner");
        $("#idPersonnelAvance").val("<%= tabPersonnel[i].getIdPersonnel() %>");
        $("#chargement").show();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherAvancePersonnel.do", 
            data:$("#formAjouterAvance").serialize(),
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
               $("#listeAvance").html(html);  
               $("#listeAvance").show(); 
               $("#dialog1").dialog({
	           autoOpen: true, 
               buttons: {
               OK: function() {
                  $("#dialog1").dialog("close");                   
                  },
               },
               width: 930,
               height: 453,
               title : "Liste des avances",        
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
    
    $('#afficherDocuments<%=i%>').click(function afficherDocuments() 
    {         
        $("tr").removeClass("table tr tr-selectionner2");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner2");
        $("#idCourrier1").val("<%= tabPersonnel[i].getIdPersonnel() %>");
        $("#idCourrier2").val("<%= tabPersonnel[i].getIdPersonnel() %>");
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
     <%if(tabPersonnel.length>0){ %>
     <%}
       else
       { %>
         <center>  Aucun Résultat </center>
      <%} %>
     <%if(tabPersonnel.length>0){ %>
     <%for(int j=0;j<nbPage;j++){ %>
     <table id="<%=j%>"  border="4" bgcolor=""  bordercolor="#000000"  class="table table-hover " width="" >     
	     <tr>
	         <th> Matricule </th> 
		     <th> Nom Salarié  </th> 
		     <th> Fonction </th> 
		     <th> CIN  </th>  
		     <th> Date Embauche </th> 
		     <th> Date Fin de Travail </th>
		     <th> Adresse </th>	           
		     <th> Salaire</th>       
		     <th width="170">  </th>
		     <th>   </th>
	     </tr>   
	     <% int debut = j*sizeParPage, fin = (j+1)*sizeParPage; %>
	     <%for(int i=debut;i<fin && i < size;i++) {%>
	     <tr id="ligne<%=i%>" > 
	         <td id="matricule<%=i%>" align="center"><%= tabPersonnel[i].getMatricule() %> </td> 
		     <td id="nom<%=i%>"><%= tabPersonnel[i].getNom() %> </td>
		     <td id="fonction<%=i%>"><%= tabPersonnel[i].getFonction() %> </td> 
		     <td id="cin<%=i%>"><%= tabPersonnel[i].getCin() %> </td>
		     <td id="dateEmbauche<%=i%>"><%= TrierFormatDate.dateToLeft(tabPersonnel[i].getDateEmbauche().toString()).replace("-", "/") %> </td> 		     
		     <td id="dateFinTravail<%=i%>"><%= TrierFormatDate.dateToLeft(tabPersonnel[i].getDateArretTravail().toString()).replace("-", "/") %> </td> 		     	     
		     <td id="adresse<%=i%>"><%= tabPersonnel[i].getAdresse() %> </td>         		     
		     <td id="retenue<%=i%>"><%= tabPersonnel[i].getSalaireBaseParJour() %> <%= tabPersonnel[i].getContratAnapec() %> </td> 			     
		     <td>
		     	<input type="button"  id="modifierPersonnel<%=i%>"  value="Dossier Salarié" size="35"/>     	
		     	<input type="button"  id="supprimerPersonnel<%=i%>"  value="X" size="35"/> 
		     </td>   
		     <td align="center"><input type="button" class="btn btn-default4" id="afficherDocuments<%=i%>"  value="Pièces jointes" size="35"/></td>    
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