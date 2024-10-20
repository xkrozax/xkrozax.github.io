<%@ page language="java" import="java.util.*" import="metier.Concurrents" contentType="text/html; charset=UTF-8"%>
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
        $("#idConcurrent").val("<%= tabConcurrents[i].getIdConcurrent() %>");
        $("#nomConcurrent").val($('#nomConcurrent2<%=i%>').val());
        $("#typeDepotPlis").val($('#typeDepotPlis2<%=i%>').val());
        $("#numDepotPlis").val($('#numDepotPlis2<%=i%>').val()); 
        $("#dateDepotPlis").val($('#dateDepotPlis2<%=i%>').val()); 
        $("#numDepotEchantillons").val($('#numDepotEchantillons2<%=i%>').val()); 
        $("#dateDepotEchantillons").val($('#dateDepotEchantillons2<%=i%>').val()); 
        if( $('input[name=plisAcompleter2<%=i%>]').is(':checked') ){ $("#plisAcompleter").val(20); }
        else { $("#plisAcompleter").val(0); } 
        if( $('input[name=depotEchantillons2<%=i%>]').is(':checked') ){ $("#depotEchantillons").val(20); }
        else { $("#depotEchantillons").val(0); } 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "modifierConcurrent.do", 
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
     <th width=""> Tâche </th>
     <th> Statut </th>
     <th> Réalisation en % </th>    
     <th> Date Début Tâche</th>
     <th> Date Fin Tâche </th>
     <th> Nombre du Jour </th> 
     <th width="95"> Non Términer </th> 
     <th width="95"> Términer </th> 
     <%if( ( role.equals("Employé Service Marchés") || role.equals("Représentant Chef Service Marchés") 
     || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") )) { %>
     <th colspan="2">  </th>  
     <%} %>       
     </tr>
     <tr><td colspan="11"> <center>Aucune Tâche</center> </td></tr> 
     </table> 
      <%} %>
     <%if(tabConcurrents.length>0){ %>
     <%for(int j=0;j<nbPage;j++){ %>
     <table id="<%=j%>"  border="2" bgcolor=""  bordercolor="#000000" class="table table-hover " width="" >    
     <tr>    
     <th width=""> Tâche </th>
     <th> Statut </th>
     <th> Réalisation en % </th>    
     <th> Date Début Tâche</th>
     <th> Date Fin Tâche </th>
     <th> Nombre du Jour </th> 
     <th width="95"> Non Términer </th> 
     <th width="95"> Términer </th>    
     <%if( ( role.equals("Employé Service Marchés") || role.equals("Représentant Chef Service Marchés") 
     || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") )) { %>
     <th colspan="2">  </th> 
     <%} %>        
     </tr>   
     <% int debut = j*sizeParPage, fin = (j+1)*sizeParPage; %>
     <%for(int i=debut;i<fin && i < size;i++) {%>
     <tr id="ligneD<%=i%>">   
     <td align="center"> <input type="text" name="nomConcurrent2<%=i%>" id="nomConcurrent2<%=i%>" class="newsletter_input"  value="<%=tabConcurrents[i].getNomConcurrent()%>" size="55"/></td>                 
     <td align="center"><select name="typeDepotPlis2<%=i%>"   id="typeDepotPlis2<%=i%>"  class="newsletter_input"  >
     <option  value="<%= tabConcurrents[i].getTypeDepotPlis() %>"><%= tabConcurrents[i].getTypeDepotPlis() %></option>
     <option  value="Non Commencé"> Non Commencé </option>
	 <option  value="En cours d'exécution"> En cours d'exécution </option>
     <option  value="Terminé"> Terminé </option>
     </select>
     </td>
     <%if (tabConcurrents[i].getNumDepotPlis() != 0) {%> 
     <td align="center"> <input type="number" name="numDepotPlis2<%=i%>" id="numDepotPlis2<%=i%>" class="number_input4"  value="<%=tabConcurrents[i].getNumDepotPlis()%>" size="6"/></td>                 
     <%} else {%> <td align="center"> <input type="number" name="numDepotPlis2<%=i%>" id="numDepotPlis2<%=i%>" class="number_input4"  value="" size="6"/></td> <%} %>                          
     <td align="center"> <input type="date" name="dateDepotPlis2<%=i%>" id="dateDepotPlis2<%=i%>" class="newsletter_input"  value="<%=tabConcurrents[i].getDateDepotPlis()%>" size="10"/></td>                 
     <td align="center"> <input type="date" name="dateDepotEchantillons2<%=i%>" id="dateDepotEchantillons2<%=i%>" class="newsletter_input"  value="<%=tabConcurrents[i].getDateDepotEchantillons()%>" size="10"/></td>                     
     <%if (tabConcurrents[i].getNumDepotEchantillons() != 0) {%> 
     <td align="center"> <input type="number" name="numDepotEchantillons2<%=i%>" id="numDepotEchantillons2<%=i%>" class="number_input4"  value="<%=tabConcurrents[i].getNumDepotEchantillons()%>" size="6"/></td>                 
     <%} else {%> <td align="center"> <input type="number" name="numDepotEchantillons2<%=i%>" id="numDepotEchantillons2<%=i%>" class="number_input4"  value="" size="6"/></td>  <%} %>                    
     <%if (tabConcurrents[i].getPlisAcompleter() == 20) {%>
     <td align="center" > <div class="checkbox checkbox-danger"><input type="checkbox" name="plisAcompleter2<%=i%>" id="plisAcompleter2<%=i%>" value="" checked="checked" /> <label for="plisAcompleter2<%=i%>"></label></div></td>
     <%} else {%> <td align="center"> <div class="checkbox checkbox-danger"> <input type="checkbox" name="plisAcompleter2<%=i%>" id="plisAcompleter2<%=i%>" value="" /> <label for="plisAcompleter2<%=i%>"></label></div></td> <%} %>         
     <%if (tabConcurrents[i].getDepotEchantillons() == 20) {%>
     <td align="center" > <div class="checkbox checkbox-success"><input type="checkbox" name="depotEchantillons2<%=i%>" id="depotEchantillons2<%=i%>" value="" checked="checked" /> <label for="depotEchantillons2<%=i%>"></label></div></td>
     <%} else {%> <td align="center"> <div class="checkbox checkbox-success"> <input type="checkbox" name="depotEchantillons2<%=i%>" id="depotEchantillons2<%=i%>" value="" /> <label for="depotEchantillons2<%=i%>"></label></div></td> <%} %>          
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