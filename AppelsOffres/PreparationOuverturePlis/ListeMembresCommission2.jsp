<%@ page language="java" import="java.util.*" import="metier.Membreconvocation" import="metier.Fonctionnaire" contentType="text/html; charset=UTF-8"%>
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
	Membreconvocation[] tabMembrecommssion;
	tabMembrecommssion=(Membreconvocation[])request.getAttribute("listeMembresCommssion");
	 %>
	<%
	Fonctionnaire [] tabFonctionnaire;
	tabFonctionnaire=(Fonctionnaire[])request.getAttribute("listeFonctionnaire"); 
	String   role = "";
	if ((String) session.getAttribute("role") != null){
      role = (String) session.getAttribute("role");  
    }
	%>
	<% int size = tabMembrecommssion.length;  
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
     var size =<%=tabMembrecommssion.length%>;  
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
    $('#ajouterMembreCommission').click(function ajouterMembreCommission() 
    { 
        $("#chargement").show(); 
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterMembresCommission2.do", 
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
               $("#listeMembresCommission").html(html);  
               $("#listePublication").hide();
               $("#listeMembresCommission").show();      
            } 
         }); 
    } 
    );
    $('#afficherFormFonctionnaire').click(function afficherFormFonctionnaire() 
    {         
         $("#dialogAjouterFonctionnaire").dialog({
	     autoOpen: true, 
         buttons: {
         Annuler: function() {                    
         $( this ).dialog("close");              
         },
         Enregistrer: function() {
                     $("#chargement").show(); 
                     $.ajax( 
                           {    
                            type: "POST", 
                            enctype:"multipart/form-data",
                            url: "ajouterFonctionnaire.do", 
                            data:$("#formAjouterFonctionnaire").serialize(),
                            dataType: "html", 
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
                               $("#dialogAjouterFonctionnaire").dialog("close");
                               BtnConvocations2();
                               $("#chargement").hide(); 
                               afficherBienEnregistrer(); 
                            }
                      }); 
                  },
               },
               width: 614,
               height: 220,         
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
               $( "#dialogAjouterFonctionnaire" ).dialog( "open" );                                    
    } 
    );
    </script>
    
	<%for(int i=0;i<tabMembrecommssion.length;i++) {%>
    <script type="text/javascript">
    $('#exporterConvocationMC<%=i%>').click(function exporterConvocationMC() 
    { 
        $("#chargement").show();
        $("#idMembreCommission").val("<%= tabMembrecommssion[i].getIdMembre() %>");      
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "exporterConvocationMC.do", 
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
               window.location.replace("../../MarchesPublics/Fichiers/ConvocationMembreCommission.docx");           
            } 
         }); 
    } 
    );
    $('#modifierMembreCommission<%=i%>').click(function modifierMembreCommission() 
    { 
        $("#chargement").show();
        $("#idMembreCommission").val("<%= tabMembrecommssion[i].getIdMembre() %>");
        $("#idFonctionnaire").val($('#idFonctionnaire2<%=i%>').val());
        $("#role").val($('#role2<%=i%>').val()); 
       
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "modifierMembreCommission2.do", 
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
               afficherBienEnregistrer();               
            } 
         }); 
    } 
    );
   	$('#supprimerMembreCommssion<%=i%>').click(function supprimerMembreCommssion() 
    {           
        $("#idMembreCommission").val("<%= tabMembrecommssion[i].getIdMembre() %>");
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligneC<%=i%>").addClass("table tr tr-selectionner"); 
        
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
                               url: "supprimerMembreCommission2.do", 
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
                              $('#ligneC<%=i%>').hide(); 
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
    } 
    );  
    </script>
    <%} %>   
  </head> 
  <body>  
     <%if(tabMembrecommssion.length>0){ %>
     <%}
       else
       { %>
     <table   border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="" >    
     <tr>    
     <th> Nom du Membre </th>
     <th> Role </th>   
      <%if( ( role.equals("Employé Service Marchés") || role.equals("Représentant Chef Service Marchés") 
     || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") )) { %>  
     <th colspan="3"> <input type="button" class="btn btn-default4" id="ajouterMembreCommission"  value=" Ajouter membre de commssion " size="35"/> </th>        
     <%} %>
     </tr> 
     <tr><td colspan="11"> <center>Aucun Membre de commssion</center> </td></tr>  
     </table>
      <%} %>
     <%if(tabMembrecommssion.length>0){ %>
     <%for(int j=0;j<nbPage;j++){ %>
     <table id="<%=j%>"  border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="" >    
     <tr>    
     <th> Nom du Membre <input align="right" type="button" id="afficherFormFonctionnaire" value="+" /></th>
     <th> Role </th>  
     <%if( ( role.equals("Employé Service Marchés") || role.equals("Représentant Chef Service Marchés") 
     || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") )) { %>   
     <th colspan="3"> <input type="button" class="btn btn-default4" id="ajouterMembreCommission"  value=" Ajouter membre de commssion " size="35"/> </th>        
     <%} %>
     </tr>   
     <% int debut = j*sizeParPage, fin = (j+1)*sizeParPage; %>
     <%for(int i=debut;i<fin && i < size;i++) {%>
     <tr id="ligneC<%=i%>"> 
     <td align="center"><select name="idFonctionnaire2<%=i%>"   id="idFonctionnaire2<%=i%>"  class="newsletter_input"  >
     <%if(tabMembrecommssion[i].getIdFonctionnaire() == 0){ %>
     <option  value="0">----------------------- : -----------------------------------------------</option>
     <%}else { %> 
     <option  value="<%= tabMembrecommssion[i].getIdFonctionnaire() %>"><%= tabMembrecommssion[i].getNom() %> : <%= tabMembrecommssion[i].getFonction() %></option>
     <%} %>          
                <%if(tabFonctionnaire.length>0){ %>
                <%for(int k=0;k<tabFonctionnaire.length;k++) {%>
		        <option value="<%=tabFonctionnaire[k].getIdFonctionnaire()%>">
		        <%=tabFonctionnaire[k].getNom()%> : <%=tabFonctionnaire[k].getFonction()%> 
		        </option>	
		        <%} %>
                <%} %>
     </select>
     </td>
     
     <td align="center"><select name="role2<%=i%>"   id="role2<%=i%>"   >
     <option  value="<%= tabMembrecommssion[i].getRole() %>"><%= tabMembrecommssion[i].getRole() %></option>
     <option  value="Membre de la commission">Membre de la commission</option>
     <option  value="Président de la commssion">Président de la commssion</option>
     </select>
     </td> 
     <%if( ( role.equals("Employé Service Marchés") || role.equals("Représentant Chef Service Marchés") 
     || role.equals("Chef Service Marchés") || role.equals("Chef Division Equipement") )) { %>   
     <td align="center"><input type="button" id="modifierMembreCommission<%=i%>" class="btn btn-default4" value="Enregistrer" size="35"/> </td>
     <td align="center"><input type="button" id="supprimerMembreCommssion<%=i%>" class="btn btn-default4" value="X" size="35"/> </td>         
     <td align="center"><input type="button" id="exporterConvocationMC<%=i%>" class="btn btn-default2"   value="Convocation" size="35"/> </td>             
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