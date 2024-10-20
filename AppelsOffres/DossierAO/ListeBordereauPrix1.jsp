<%@ page language="java" import="java.util.*" import="java.text.DecimalFormat" import="java.math.BigDecimal" import="java.math.RoundingMode"  import="java.math.RoundingMode" import="metier.Appelsoffres" import="metier.Bordereauprix" import="metier.Seances" contentType="text/html; charset=UTF-8"%>
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
	Bordereauprix[] tabBordereauprix;
	tabBordereauprix=(Bordereauprix[])request.getAttribute("listeBordereauprix");
    BigDecimal[] tabMontant;
	tabMontant =(BigDecimal[]) request.getAttribute("listeMontant");
	String typeBordereau = "";
	typeBordereau = (String) request.getAttribute("typeBordereau");
	DecimalFormat f = new DecimalFormat();
	f.setMinimumFractionDigits(2);
	f.setMaximumFractionDigits(2);	
	%>
	
	<% int size = tabBordereauprix.length;  
			int sizeParPage = 200;
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
     var size =<%=tabBordereauprix.length%>;  
			var sizeParPage = 200;
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
	<%for(int i=0;i<tabBordereauprix.length;i++) {%>
    <script type="text/javascript">
   	
    $('#modifierPrix<%=i%>').click(function modifierPrix() 
    {         
        $("#chargement").show();
        $("tr").removeClass("table tr tr-selectionner");  
        $('#ligne<%=i%>').addClass("table tr tr-selectionner"); 
        $("#idBordereau2").val("<%= tabBordereauprix[i].getIdBordereau() %>");
        $("#numPrix2").val("<%= tabBordereauprix[i].getNumPrix() %>");
        $("#designation2").val("<%= tabBordereauprix[i].getDesignation() %>");
        $("#tauxTva2").val("<%= tabBordereauprix[i].getTauxTva() %>");
        $("#unite2").val("<%= tabBordereauprix[i].getUnite() %>");
        $("#quantite2").val("<%= tabBordereauprix[i].getQuantite() %>");
        $("#prixUnitaire2").val("<%= tabBordereauprix[i].getPrixUnitaire() %>");
          
               $("#chargement").hide();
               $("#dialog").dialog({
	           autoOpen: true, 
               buttons: {
               Annuler: function() {                    
               $( this ).dialog("close"); 
               $('#ligne<%=i%>').removeClass("table tr tr-selectionner");                     
               },
               Enregistrer: function() {
                     $.ajax( 
                           {    
                            type: "POST", 
                            enctype:"multipart/form-data",
                            url: "modifierPrixBordereau.do", 
                            data:$("#formModifierPrixBordereau").serialize(),
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
                            $("#listeBordereauPrix").html(html); 
                            $("#BordereauPrix1").show(); 
                            $("tr").removeClass("table tr tr-selectionner");  
                            $("#ligne<%=i%>").addClass("table tr tr-selectionner");                                                         
                            $("#dialog").dialog("close");
                            // -----------------------
                            $("#dialog2").dialog({
	                           autoOpen: true, 
                               buttons: {
                               Ok: function() {  
                               $('#ligne<%=i%>').removeClass("table tr tr-selectionner");                   
                               $( this ).dialog("close");                     
                               },
                            },
                            width: 452,
                            height: 165,         
                            position: {
			                my: "center", at: "center", of: window, collision: "fit",			      
			                using: function( pos ) {
			     	           var topOffset = $( this ).css( pos ).offset().top;
				               if ( topOffset < 0 ) {
					           $( this ).css( "top", pos.top - topOffset );
				               }
			                }
		                    }              
                            });
                           // -----------------------
                           }
                      }); 
                  },
               },
               width: 752,
               height: 395,         
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
               $( "#dialog" ).dialog( "open" );                                    
    } 
    ); 
    $('#supprimerPrix<%=i%>').click(function supprimerPrix() 
    {         
        $("#idBordereau").val("<%= tabBordereauprix[i].getIdBordereau() %>");
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=i%>").addClass("table tr tr-selectionner"); 
        
        $("#dialog4").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialog4").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                               type: "POST", 
                               enctype:"multipart/form-data",
                               url: "supprimerPrixBordereau.do", 
                               data:$("#formAjouterBordereauPrix").serialize(),
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
               // ---------------------------                                     
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
    );  
    </script>
    <%} %>   
  </head> 
  <body>  
   
     <%if(tabBordereauprix.length>0){ %>
     <%}
       else
       { %>
         <center>  Aucun Prix </center>
      <%} %>
     <%if(tabBordereauprix.length>0){ %>
     <table   border="3" bgcolor=""  bordercolor="#000000" class="table table-hover " width="1102" >    
     <tr>    
     <th width=""> N° de Prix </th>
     <th width="520" class="" align="center"> Désignation  </th>
     <th width="76" align="center"> Taux TVA </th>
     <th class="" align="center"> Unité   </th>
     <%if(typeBordereau.equals("Bordereau du prix global")){ %> 
	 <th class="" align="center"> Prix Forfaitaire </th>	
	 <%}else { %>
	 <th width="" align="center"> Quantité </th>
	 <th class="" align="center"> Prix Unitaire </th>
	 <th class="" align="center"> Prix Total </th>
	 <%} %>
     <th colspan="2">  </th>
     </tr>   
     <%for(int i=0;i<tabBordereauprix.length;i++) {%>
     <tr id="ligne<%=i%>"> 
     <td align="center"><%= tabBordereauprix[i].getNumPrix() %> </td>
     <td align="left"><%= tabBordereauprix[i].getDesignation() %> </td>
     <%if( (tabBordereauprix[i].getTauxTva().doubleValue()) == (tabBordereauprix[i].getTauxTva().intValue()) ){ %> 
     <td align="right"><%= tabBordereauprix[i].getTauxTva().intValue() %> %</td>  
     <%}else { %> <td align="right"><%= tabBordereauprix[i].getTauxTva() %> %</td><%} %>
     <td align="center"><%= tabBordereauprix[i].getUnite() %> </td>
     <%if(typeBordereau.equals("Bordereau du prix global")){ %>         
     <td align="right"><%= (f.format(tabBordereauprix[i].getPrixUnitaire())).replace(",", ".") %> </td>
     <%}else { %>
     <td align="right"><%= (f.format(tabBordereauprix[i].getQuantite())).replace(",", ".") %> </td>
     <td align="right"><%= (f.format(tabBordereauprix[i].getPrixUnitaire())).replace(",", ".") %> </td>
     <td align="right"><%= (f.format(tabBordereauprix[i].getPrixTotal())).replace(",", ".") %> </td>
     <%} %>
     <td align="center"><input type="button" id="modifierPrix<%=i%>" class="btn btn-default4" value="Modifier" size="35"/> </td>    
     <td align="center"><input type="button" id="supprimerPrix<%=i%>" class="btn btn-default4" value="X" size="35"/> </td>
     </tr>
     <%} %>
     <%if(typeBordereau.equals("Bordereau du prix global")){ %>
     <tr> 
     <td align="right" colspan="4"> Prix  Total  HT </td>   
     <td align="right"> <%=(f.format(tabMontant[0])).replace(",", ".") %> </td>
     <td align="center" colspan="2"> </td>
     </tr>
     <tr> 
     <td align="right" colspan="4"> TOTAL de TVA % </td>   
     <td align="right"> <%=(f.format(tabMontant[1])).replace(",", ".") %> </td>   
     <td align="center" colspan="2"> </td>
     </tr>
     <tr>
     <td align="right" colspan="4"> Prix Total TTC </td>   
     <td align="right"> <%=(f.format(tabMontant[2])).replace(",", ".") %> </td>
     <td align="center" colspan="2"> </td>
     </tr>
     <%}else { %>
     <tr> 
     <td align="right" colspan="6"> Prix  Total  HT </td>   
     <td align="right"> <%=(f.format(tabMontant[0])).replace(",", ".") %> </td>
     <td align="center" colspan="2"> </td>
     </tr>
     <tr> 
     <td align="right" colspan="6"> TOTAL de TVA % </td>   
     <td align="right"> <%=(f.format(tabMontant[1])).replace(",", ".") %> </td>
     <td align="center" colspan="2"> </td>
     </tr>
     <tr>
     <td align="right" colspan="6"> Prix Total TTC </td>   
     <td align="right"> <%=(f.format(tabMontant[2])).replace(",", ".") %> </td>
     <td align="center" colspan="2"> </td>
     </tr>
     <%} %>
     </table>
     <%} %>

  </body>
</html>