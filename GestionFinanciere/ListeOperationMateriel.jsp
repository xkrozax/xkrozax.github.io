<%@ page language="java" import="java.util.*" import="metier.Operation"  import="java.math.BigDecimal" import="trierObjet.TrierFormatDate" contentType="text/html; charset=UTF-8"%>
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
	Operation[] tabOperation;
	tabOperation=(Operation[])request.getAttribute("listeOperation");
	BigDecimal montantTotal = (BigDecimal)request.getAttribute("montantTotal");
	BigDecimal montantTotalBenifice = (BigDecimal)request.getAttribute("montantTotalBenifice");
	String   role = "";
	if ((String) session.getAttribute("role") != null){
      role = (String) session.getAttribute("role");  
    }  
	 %>
	<% int size = tabOperation.length;  
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
     var size =<%=tabOperation.length%>;  
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
	<%for(int i=0;i<tabOperation.length;i++) {%>
    <script type="text/javascript"> 	
    $('#supprimerOperation<%=i%>').click(function supprimerOperation() 
    {         
        $("#idOperation2").val("<%= tabOperation[i].getIdOperation() %>");
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=i%>").addClass("table tr tr-selectionner"); 
        
        $("#dialog2").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialog2").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                               type: "POST", 
                               enctype:"multipart/form-data",
                               url: "supprimerOperationFinanciere.do", 
                               data:$("#formSupprimerOperationFinanciere").serialize(),
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
                              $("#dialog1").dialog({
	                          autoOpen: true, 
                              buttons: {
                              OK: function() {
                              $("#dialog1").dialog("close");                   
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
               $( "#dialog1" ).dialog("open");
               location.reload(true);                                 
            } 
         }); 
               // ---------------------------                                     
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
    ); 
    $('#modifierOperation<%=i%>').click(function modifierOperation() 
    {         
        $("#idOperation").val("<%= tabOperation[i].getIdOperation() %>");
        $("#typeModification").val($('#modePaiement2<%=i%>').val());
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=i%>").addClass("table tr tr-selectionner"); 
        
        $("#dialog6").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialog6").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                               type: "POST", 
                               enctype:"multipart/form-data",
                               url: "modifierOperationFinanciere.do", 
                               data:$("#formModifierOperationFinanciere").serialize(),
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
                              $("#dialog5").dialog({
	                          autoOpen: true, 
                              buttons: {
                              OK: function() {
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
         }); 
               // ---------------------------                                     
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
    ); 
    
    $('#statut2<%=i%>').change(function() {
        $("#statut").val($(this).is(':checked'));
        $("#idOperation").val("<%= tabOperation[i].getIdOperation() %>"); 
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=i%>").addClass("table tr tr-selectionner"); 
        
                       $("#chargement").show();        
                         $.ajax( 
                               {    
                               type: "POST", 
                               enctype:"multipart/form-data",
                               url: "modifierStatutMateriel.do", 
                               data:$("#formModifierOperationFinanciere").serialize(),
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
                              }                                                 
                       }); 
      });           
    
    $('#afficherDocuments<%=i%>').click(function afficherDocuments() 
    {         
        $("tr").removeClass("table tr tr-selectionner2");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner2");
        $("#idCourrier1").val("<%= tabOperation[i].getIdOperation() %>");
        $("#idCourrier2").val("<%= tabOperation[i].getIdOperation() %>");
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
     <%if(tabOperation.length>0){ %>
     <%}
       else
       { %>
     <table   border="1" bgcolor=""  bordercolor="#000000" class="table table-hover " width="" > 
     <tr>
       <th> <font color="#000000"> Article </font> </th> 
     <th> <font color="#000000"> Engins-Véhicule / Sous Article </font> </th>
     <th width="96"> <font color="#000000">  Date Entrée au chantier</font> </th>   
     <th width="60"> <font color="#000000"> Quantité </font> </th>      
     <th> <font color="#000000"> Responsable </font> </th>
     <th> <font color="#000000"> Remarque </font> </th>
     <th width="200"> <font color="#000000"> Date Sortie du chantier </font> </th>
     <th> </th>  
     <th> </th>
     </tr>
     </table>
     <%} %>
     <%if(tabOperation.length>0){ %>
       
     <%for(int j=0;j<nbPage;j++){ %>
     <table id="<%=j%>"  border="4" bgcolor=""  bordercolor="#000000"  class="table table-hover " width="990" >     
     <tr> 
        
     <th> <font color="#000000"> Article </font> </th> 
     <th> <font color="#000000"> Engins-Véhicule / Matériels </font> </th>
     <th width="96"> <font color="#000000">  Date Entrée au chantier</font> </th>   
     <th width="60"> <font color="#000000"> Quantité </font> </th>      
     <th> <font color="#000000"> Responsable </font> </th>
     <th> <font color="#000000"> Remarque </font> </th>
     <th> <font color="#000000"> Sortie du chantier </font> </th> 
     <th width="200"> <font color="#000000"> Date Sortie du chantier </font> </th>
     <th> </th>  
     <th> </th>   
     </tr>   
     <% int debut = j*sizeParPage, fin = (j+1)*sizeParPage; %>
     <%for(int i=debut;i<fin && i < size;i++) {%>   
     <tr id="ligne<%=i%>">     
     <td align="center"> <%=tabOperation[i].getArticle()%> </td> 
     <td align="center"> <%=tabOperation[i].getSousArticle()%> </td> 
     <td align="center"> <%=TrierFormatDate.dateToLeft (tabOperation[i].getDate()).replace("-", "/")%> </td> 
     <%if(tabOperation[i].getQuantite().intValue() == tabOperation[i].getQuantite() ){ %>
     <td align="center"> <%=tabOperation[i].getQuantite().intValue()%> </td> 
     <%} else {%>    
     <td align="center"> <%=tabOperation[i].getQuantite()%> </td> 
     <%} %>                        
     <td align="center"> <%=tabOperation[i].getPersonne()%> </td> 
     <td align="center"> <%=tabOperation[i].getRemarque()%> </td> 
     <td align="center"> 
         <%if ( tabOperation[i].getStatut().equals("Sortie")) {%>
         <div class="checkbox checkbox-warning"><input type="checkbox" name="statut2<%=i%>" id="statut2<%=i%>" value="" checked="checked" /> <label for="statut2<%=i%>"></label></div> 
         <%} else {%> <div class="checkbox checkbox-warning"><input type="checkbox" name="statut2<%=i%>" id="statut2<%=i%>"  value=""  /> <label for="statut2<%=i%>"></label></div> <%} %>                     
     </td>           
     <td><input type="date" name="modePaiement2<%=i%>"  id="modePaiement2<%=i%>" value="<%=tabOperation[i].getModePaiement()%>"  />
         <input type="button" class="btn btn-default4" id="modifierOperation<%=i%>"  value="+" /> 
     </td>
     <td align="center" >  <input type="button" id="supprimerOperation<%=i%>" class="btn btn-default4" value="X" />
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