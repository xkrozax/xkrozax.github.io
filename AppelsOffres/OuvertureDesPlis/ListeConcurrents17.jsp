<%@ page language="java" import="java.util.*" import="metier.Concurrents" contentType="text/html; charset=UTF-8"%>
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
	Concurrents[] tabConcurrents;
	tabConcurrents=(Concurrents[])request.getAttribute("listeConcurrents");
	String   role = "";
	if ((String) session.getAttribute("role") != null){
      role = (String) session.getAttribute("role");  
    } 
	%>
	<% int size = tabConcurrents.length;  
			int sizeParPage = 48;
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
     var size =<%=tabConcurrents.length%>;  
			var sizeParPage = 48;
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
    $('#ajouterConcurrent').click(function ajouterConcurrent() 
    { 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterConcurrent.do", 
            data:$("#formAjouterConcurrent").serialize(),
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
               $("#listeConcurrents").html(html);               
            } 
         }); 
    } 
    );  
    </script>	
	<%for(int i=0;i<tabConcurrents.length;i++) {%>
    <script type="text/javascript">
    $('#modifierConcurrent<%=i%>').click(function modifierConcurrent() 
    { 
        $("tr").removeClass("table tr tr-selectionner");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner");
        $("#idConcurrent3").val("<%= tabConcurrents[i].getIdConcurrent() %>");
        $("#nomConcurrent3").val($('#nomConcurrent2<%=i%>').val());
        $("#ville").val($('#ville2<%=i%>').val()); 
        $("#adresse3").val($('#adresse2<%=i%>').val()); 
        $("#email").val($('#email2<%=i%>').val()); 
        $("#numTel").val($('#numTel2<%=i%>').val()); 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "modifierConcurrent2.do", 
            data:$("#formAjouterConcurrent2").serialize(),
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
   	$('#supprimerConcurrent<%=i%>').click(function supprimerConcurrent() 
    {         
        $("#idConcurrent").val("<%= tabConcurrents[i].getIdConcurrent() %>");
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligneD<%=i%>").addClass("table tr tr-selectionner"); 
        
        $("#dialog8").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialog8").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                               type: "POST", 
                               enctype:"multipart/form-data",
                               url: "supprimerConcurrent.do", 
                               data:$("#formAjouterConcurrent").serialize(),
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
                              $('#ligneD<%=i%>').hide(); 
                              $("#dialog6").dialog({
	                          autoOpen: true, 
                              buttons: {
                              OK: function() {
                              $("#dialog6").dialog("close");                   
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
               $( "#dialog6" ).dialog("open");                                 
            } 
         }); 
               // ---------------------------                                     
                 $("#dialog8").dialog("close"); 
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
               $( "#dialog8" ).dialog("open");          
    } 
    );  
    </script>
    <%} %>   
  </head> 
  <body>  
     <%if(tabConcurrents.length>0){ %>
     <%}
       else
       { %>
     <table  border="2" bgcolor=""  bordercolor="#000000" class="table table-hover " width="" >    
     <tr>    
     <th> N° de Tâche </th>
     <th width=""> Tâche </th>
     <th> Description de la Tâche</th>    
     <th> Responsable </th>
     <th> Date prévue de commencement </th> 
     <%if( ( role.equals("Employé Service Marchés") || role.equals("Représentant Chef Service Marchés") 
     || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") )) { %>  
     <th colspan="2"> <input type="button" class="btn btn-default4" id="ajouterConcurrent"  value=" Ajouter Tâche " size="35"/> </th>         
     <%} %>
     </tr>
     <tr><td colspan="11"> <center>Aucune Tâche</center> </td></tr> 
     </table> 
      <%} %>
     <%if(tabConcurrents.length>0){ %>
     <%for(int j=0;j<nbPage;j++){ %>
     <table id="<%=j%>"  border="2" bgcolor=""  bordercolor="#000000" class="table table-hover " width="" >    
     <tr>        
     <th> N° de Tâche </th>
     <th width=""> Tâche </th>
     <th> Description de la Tâche</th>    
     <th> Responsable </th>
     <th> Date prévue de commencement </th> 
     <%if( ( role.equals("Employé Service Marchés") || role.equals("Représentant Chef Service Marchés") 
     || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") )) { %>  
     <th colspan="2"> <input type="button" class="btn btn-default4" id="ajouterConcurrent"  value=" Ajouter Tâche " size="35"/> </th>         
     <%} %>
     </tr>   
     <% int debut = j*sizeParPage, fin = (j+1)*sizeParPage; %>
     <%for(int i=debut;i<fin && i < size;i++) {%>
     <tr id="ligneD<%=i%>"> 
     <td align="center"> <input type="text" name="ville2<%=i%>" id="ville2<%=i%>"  value="<%=tabConcurrents[i].getVille()%>" size="8"/></td>     
     <td align="center"> <input type="text" name="nomConcurrent2<%=i%>" id="nomConcurrent2<%=i%>"  value="<%=tabConcurrents[i].getNomConcurrent()%>" size="50"/></td>                                 
     <td align="center"> <input type="text" name="adresse2<%=i%>" id="adresse2<%=i%>"  value="<%=tabConcurrents[i].getAdresse()%>" size="80"/></td>                                 
     <td align="center"> <input type="text" name="email2<%=i%>" id="email2<%=i%>"  value="<%=tabConcurrents[i].getEmail()%>" size="20"/></td>                 
     <td align="center"> <input type="date" name="numTel2<%=i%>" id="numTel2<%=i%>" class="number_input3" value="<%=tabConcurrents[i].getNumTel()%>" size="20"/></td>                 
     <%if( ( role.equals("Employé Service Marchés") || role.equals("Représentant Chef Service Marchés") 
     || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") )) { %>  
     <td align="center"><input type="button" class="btn btn-default4" id="modifierConcurrent<%=i%>"  value="Enregistrer" size="35"/> </td>                        
     <td align="center"><input type="button" class="btn btn-default4" id="supprimerConcurrent<%=i%>"  value=" X " size="35"/> </td>                        
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