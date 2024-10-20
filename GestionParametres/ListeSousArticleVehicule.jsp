<%@ page language="java" import="java.util.*" import="metier.Sousarticle"   contentType="text/html; charset=UTF-8"%>
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
	Sousarticle[] tabSousArticle;
	tabSousArticle=(Sousarticle[])request.getAttribute("listeSousArticle");
	
	String role="Chef Service Assiette";
	String refRedevable="";	
	%>
	<% int size = tabSousArticle.length;  
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
     var size =<%=tabSousArticle.length%>;  
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
   
	<%for(int i=0;i<tabSousArticle.length;i++) {%>
    <script type="text/javascript">
    
      
    $('#modifierArticle<%=i%>').click(function modifierArticle() 
    { 
        $("tr").removeClass("table tr tr-selectionner");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner");
        $("#idSousArticle").val("<%=tabSousArticle[i].getIdSousArticle()%>");
        $("#sousArticle").val($('#sousArticle2<%=i%>').val());
        $("#reference").val($('#reference2<%=i%>').val());
        $("#prixAchat").val($('#prixAchat2<%=i%>').val());
        $("#nomArticle").val($('#nomArticle2<%=i%>').val());
        $("#matricule").val($('#matricule2<%=i%>').val());
        $("#marque").val($('#marque2<%=i%>').val());
        $("#dateAchat").val($('#dateAchat2<%=i%>').val());
        $("#statut").val($('#statut2<%=i%>').val());
        $("#remarque").val($('#remarque2<%=i%>').val());
        $("#responsable").val($('#responsable2<%=i%>').val());
                        
        $("#dialogModifierRedevable").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialogModifierRedevable").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                                  type: "POST", 
                                  enctype:"multipart/form-data",
                                  url: "modifierSousArticle.do", 
                                  data:$("#formModifierArticle").serialize(),
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
                                $("#dialogModifierRedevable").dialog("close"); 
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
               $( "#dialogModifierRedevable" ).dialog("open");          
    } 
    );       
    
    $('#modifierStockInitial<%=i%>').click(function modifierStockInitial() 
    { 
        $("tr").removeClass("table tr tr-selectionner");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner");
        $("#idSousArticle").val("<%=tabSousArticle[i].getIdSousArticle()%>");
        $("#stockInitial").val($('#stockInitial2<%=i%>').val());        
                        
        $("#dialogModifierRedevable").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialogModifierRedevable").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                                  type: "POST", 
                                  enctype:"multipart/form-data",
                                  url: "modifierStockInitial.do", 
                                  data:$("#formModifierArticle").serialize(),
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
                                  var m1=($('#ID_stockActuelA<%=i%>').html())+"+"+($('#stockInitial2<%=i%>').val());
                                  var m2=($('#ID_stockActuelB<%=i%>').html())+"+"+($('#stockInitial2<%=i%>').val());
                                  var m3=($('#ID_stockActuelC<%=i%>').html())+"+"+($('#stockInitial2<%=i%>').val());
                                  var m4=($('#ID_stockActuelD<%=i%>').html())+"+"+($('#stockInitial2<%=i%>').val());
                                  $("#ID_stockActuelA<%=i%>").html(m1); 
                                  $("#ID_stockActuelB<%=i%>").html(m2); 
                                  $("#ID_stockActuelC<%=i%>").html(m3); 
                                  $("#ID_stockActuelD<%=i%>").html(m4); 
                                  afficherBienEnregistrer();                                                            
                                  } 
                                });                                           
                                $("#dialogModifierRedevable").dialog("close"); 
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
               $( "#dialogModifierRedevable" ).dialog("open");          
    } 
    );                   
                        
   
   	$('#supprimerArticle<%=i%>').click(function supprimerArticle() 
    {         
        $("#idSousArticle").val("<%= tabSousArticle[i].getIdSousArticle() %>");
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=i%>").addClass("table tr tr-selectionner"); 
        
        $("#dialogSupprimerRedevable1").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialogSupprimerRedevable1").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                               type: "POST", 
                               enctype:"multipart/form-data",
                               url: "supprimerSousArticle.do", 
                               data:$("#formModifierArticle").serialize(),
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
                              $("#dialogSupprimerRedevable2").dialog({
	                          autoOpen: true, 
                              buttons: {
                              OK: function() {
                              $("#dialogSupprimerRedevable2").dialog("close");                   
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
               $( "#dialogSupprimerRedevable2" ).dialog("open");                                 
            } 
         }); 
               // ---------------------------                                     
                 $("#dialogSupprimerRedevable1").dialog("close"); 
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
               $( "#dialogSupprimerRedevable1" ).dialog("open");          
    } 
    );  
    
    </script>
    <%} %>   
  </head> 
  <body>  
     <%if(tabSousArticle.length>0){ %>
     <%}
       else
       { %>
     <table  border="2" bgcolor=""  bordercolor="#000000" class="table table-hover " width="1350" >    
     <tr> 
     <th> <font color="#000000"> <h3>Type Engins/Véhicule </h3> </font></th>
     <th> <font color="#000000"> <h3>Marque </h3> </font></th>
     <th> <font color="#000000"> <h3>Réference </h3> </font></th>
     <th> <font color="#000000"> <h3>Marticule </h3> </font></th>
     <th> <font color="#000000"> <h3>Prix Acquisition </h3> </font></th>
     <th> <font color="#000000"> <h3>Date Acquisition </h3> </font></th>
     <th> <font color="#000000"> <h3>Statut </h3> </font></th> 
     <th> <font color="#000000"> <h3>Responsable </h3> </font></th>  
     <th> <font color="#000000"> <h3>Remarque </h3> </font></th>  
     <th>  </th>     
     <th> <font color="#000000"> <h3>Quantité Entrée </h3> </font></th> 
     <th> <font color="#000000"> <h3>Quantité Sortie </h3> </font></th> 
     <th> <font color="#000000"> <h3>Quantité Actuel </h3> </font></th>   
     <th> <font color="#000000"> <h3> </h3> </font></th> 
     <th>  </th>   
     </tr>
     <tr><td colspan="11"> <center>Aucun Produit</center> </td></tr> 
     </table> 
     <%} %>
     <%if(tabSousArticle.length>0){ %>
     <%for(int j=0;j<nbPage;j++){ %>
     <table id="<%=j%>"  border="2" bgcolor=""  bordercolor="#000000" class="table table-hover " width="" >    
     <tr> 
     <th> <font color="#000000"> <h3>Type Engins/Véhicule </h3> </font></th>
     <th> <font color="#000000"> <h3>Marque </h3> </font></th>
     <th> <font color="#000000"> <h3>Réference </h3> </font></th>
     <th> <font color="#000000"> <h3>Marticule </h3> </font></th>
     <th> <font color="#000000"> <h3>Prix Acquisition </h3> </font></th>
     <th> <font color="#000000"> <h3>Date Acquisition </h3> </font></th>
     <th> <font color="#000000"> <h3>Statut </h3> </font></th> 
     <th> <font color="#000000"> <h3>Responsable </h3> </font></th>  
     <th> <font color="#000000"> <h3>Remarque </h3> </font></th>  
     <th>  </th>     
     <th> <font color="#000000"> <h3>Quantité Entrée </h3> </font></th> 
     <th> <font color="#000000"> <h3>Quantité Sortie </h3> </font></th> 
     <th> <font color="#000000"> <h3>Quantité Stock </h3> </font></th>   
     <th > </th>         
     </tr>   
     <% int debut = j*sizeParPage, fin = (j+1)*sizeParPage; %>
     <%for(int i=debut;i<fin && i < size;i++) {%>
     <tr id="ligne<%=i%>">   
	 <td><input type="text" name="sousArticle2<%=i%>"  id="sousArticle2<%=i%>" value="<%=tabSousArticle[i].getSousArticle()%>"  size="15"/>  </td>
	 <td><input type="text" name="nomArticle2<%=i%>"  id="nomArticle2<%=i%>" value="<%=tabSousArticle[i].getNomArticle()%>"  size="15"/>  </td>										 			     
     <td><input type="text" name="reference2<%=i%>"  id="reference2<%=i%>" value="<%=tabSousArticle[i].getReference()%>"  size="12"/>  </td>
     <td><input type="text" name="matricule2<%=i%>"  id="matricule2<%=i%>" value="<%=tabSousArticle[i].getMatricule()%>"  size="12"/>  </td>  
     <td><input type="number" name="prixAchat2<%=i%>"  id="prixAchat2<%=i%>" value="<%=tabSousArticle[i].getPrixAchat()%>"  class="number_input"/>  </td>
     <td><input type="date" name="dateAchat2<%=i%>"  id="dateAchat2<%=i%>" value="<%=tabSousArticle[i].getDateAchat()%>"  size="10"/>  </td>
     <td><input type="text" name="statut2<%=i%>"  id="statut2<%=i%>" value="<%=tabSousArticle[i].getStatut()%>"  size="15"/>  </td>
     <td><input type="text" name="responsable2<%=i%>"  id="responsable2<%=i%>" value="<%=tabSousArticle[i].getResponsable()%>"  size="10"/>  </td>
     <td><input type="text" name="remarque2<%=i%>"  id="remarque2<%=i%>" value="<%=tabSousArticle[i].getRemarque()%>"  size="22"/>  </td>
     <td> <input type="button" class="btn btn-default4" id="modifierArticle<%=i%>"  value="Enregistrer" size="35"/> 
          <input type="button" class="btn btn-default4" id="supprimerArticle<%=i%>"  value=" X " size="35"/>
     </td>
       
     <%if(tabSousArticle[i].getQuantiteEntree().intValue() == tabSousArticle[i].getQuantiteEntree() ){ %>
     <td align="center" id="ID_stockActuelC<%=i%>"> <%=tabSousArticle[i].getQuantiteEntree().intValue()%> </td> 
     <%} else {%>  <td align="center"  id="ID_stockActuelD<%=i%>"> <%=tabSousArticle[i].getQuantiteEntree()%> </td> <%} %> 
     
     <%if (tabSousArticle[i].getQuantiteSortie().intValue() == tabSousArticle[i].getQuantiteSortie() ){ %>
     <td align="center"> <%=tabSousArticle[i].getQuantiteSortie().intValue()%> </td> 
     <%} else {%>  <td align="center"> <%=tabSousArticle[i].getQuantiteSortie()%> </td> <%} %> 
     
     <%if(tabSousArticle[i].getStockActuel().intValue() == tabSousArticle[i].getStockActuel() ){ %>
     <td align="center"  id="ID_stockActuelA<%=i%>"> <%=tabSousArticle[i].getStockActuel().intValue()%> </td> 
     <%} else {%>  <td align="center" id="ID_stockActuelB<%=i%>"> <%=tabSousArticle[i].getStockActuel()%> </td> <%} %> 
     
     <td><input type="number" name="stockInitial2<%=i%>"  id="stockInitial2<%=i%>" value="" /> <input type="button" class="btn btn-default4" id="modifierStockInitial<%=i%>"  value="Ajouter Quantité Entrée" size="35"/>  </td>	
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