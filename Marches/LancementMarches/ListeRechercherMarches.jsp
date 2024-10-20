<%@ page language="java" import="java.util.*" import="org.joda.time.Days" import="org.joda.time.LocalDate" import="java.math.BigDecimal"  import="metier.Appelsoffres" import="java.text.DecimalFormat" import="trierObjet.TrierFormatDate"  contentType="text/html; charset=UTF-8"%>
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
	Appelsoffres[] tabAppelsoffres;
	tabAppelsoffres=(Appelsoffres[])request.getAttribute("listeAppelsoffres");
	BigDecimal montantPayeTTC;
	montantPayeTTC=(BigDecimal)request.getAttribute("montantPayeTTC");
	BigDecimal montantDepensesDivers;
	montantDepensesDivers=(BigDecimal)request.getAttribute("montantDepensesDivers");
	BigDecimal montantChargesSalaire;
	montantChargesSalaire=(BigDecimal)request.getAttribute("montantChargesSalaire");
	BigDecimal montantBenefice;
	montantBenefice=(BigDecimal)request.getAttribute("montantBenefice");
	DecimalFormat f = new DecimalFormat();
	f.setMinimumFractionDigits(2);
	f.setMaximumFractionDigits(2);
	LocalDate date1 = new LocalDate(); 
	LocalDate date2 = new LocalDate();
	int nombreJours =0;
	 %>
	<% int size = tabAppelsoffres.length;  
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
     var size =<%=tabAppelsoffres.length%>;  
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
	
	<%for(int i=0;i<tabAppelsoffres.length;i++) {%>
    <script type="text/javascript">
   	$('#ouvrirAO<%=i%>').click(function ouvrirAO() 
    {          
        $("#chargement").show();
        $("#idAppelOffre").val("<%= tabAppelsoffres[i].getIdAppelOffre() %>");
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ouvrirAppelOffre.do", 
            data:$("#formOuvrirAppelOffre").serialize(),
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
               $("#dialog").dialog({
	           autoOpen: false, 
               buttons: {
                  OK: function() {
                     $( this ).dialog( "close" );
                  }
               },
               width: 314
               });
               $( "#dialog" ).dialog( "open" );                    
            } 
         }); 
    } 
    ); 
    $('#exporterRapportAppelOffre<%=i%>').click(function exporterRapportAppelOffre() 
    { 
        $("#chargement").show();  
        $("#idAppelOffre").val("<%= tabAppelsoffres[i].getIdAppelOffre() %>");
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "exporterRapportAppelOffre.do", 
            data:$("#formOuvrirAppelOffre").serialize(),
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
               window.location.replace("../../GestionEntrepriseBTP/Fichiers/RapportMarchés.pdf"); 
               
            } 
         }); 
    } 
    ); 
    
    $('#suprrimerAO<%=i%>').click(function supprimerAO() 
    {        
        $("#idAppelOffre").val("<%= tabAppelsoffres[i].getIdAppelOffre() %>");
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
                               url: "supprimerAppelOffre.do", 
                               data:$("#formOuvrirAppelOffre").serialize(),
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
    } 
    );  
    $('#afficherDocuments<%=i%>').click(function afficherDocuments() 
    {         
        $("tr").removeClass("table tr tr-selectionner2");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner2");
        $("#idCourrier1").val("<%= tabAppelsoffres[i].getIdAppelOffre() %>");
        $("#idCourrier2").val("<%= tabAppelsoffres[i].getIdAppelOffre() %>");
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
           
     <%if(tabAppelsoffres.length>0){ %>
     <%}
       else
       { %>
         <center>  Aucun Résultat </center>
      <%} %>
     <%if(tabAppelsoffres.length>0){ %>
     <%for(int j=0;j<nbPage;j++){ %>
         
     <table id="<%=j%>"  border="5" bgcolor=""  bordercolor="#000000" class="table table-hover " width="1590" >     <tr>    
     <tr> 
     <th> N° du Marché</th>
     <th> Année </th> 
     <th width="400"> Objet </th>
     <th> Client </th>
     <th width="90"> Date de Commencement des travaux </th>
     <th width="90"> Date Prévue Fin des travaux </th>
     <th> Délai Restant </th>
     <th> Montant du Marché TTC </th>
     <th width="250"> Montant Payé TTC</th>
     <th width="250"> Dépenses Divers du Marché </th>
     <th width="250"> Charges Salaire Personnels du Marché </th>
     <th width="150"> Bénéfice du Marché </th>
     <th> Statut </th>
     <th>  </th>
     <th>  </th>
     <th>  </th>
     <th>  </th>
     </tr>   
     <% int debut = j*sizeParPage, fin = (j+1)*sizeParPage; %>
     <%for(int i=debut;i<fin && i < size;i++) {%>
     <%nombreJours = 0;%>
     <tr  id="ligne<%=i%>">  
     <td align="center"><%= tabAppelsoffres[i].getNumMarches() %> </td>
     <td align="center"><%= tabAppelsoffres[i].getAnneeMarches() %> </td>    
     <td ><%= tabAppelsoffres[i].getObjetAppelOffre() %> </td>  
     <td ><%= tabAppelsoffres[i].getObjetAppelOffre2() %> </td>   
     <td align="center"><%= TrierFormatDate.dateToLeft(tabAppelsoffres[i].getDateVisiteDesLieux()).replace("-", "/") %> </td>
     <td align="center"><%= TrierFormatDate.dateToLeft(tabAppelsoffres[i].getDateDepotEchantillons()).replace("-", "/") %> </td>
     <%if (tabAppelsoffres[i].getDateDepotEchantillons()!= null && !tabAppelsoffres[i].getDateDepotEchantillons().equals("")) {
					 date1 = new LocalDate(); date2 = new LocalDate(tabAppelsoffres[i].getDateDepotEchantillons());
				     nombreJours = Days.daysBetween(date1, date2).getDays();
				     if (nombreJours <0) {
				     nombreJours = 0;
				     }
				     }%>
	 <td align="right"><%= nombreJours %> </td>
     <td align="right"><%= (f.format(tabAppelsoffres[i].getEstimation())).replace(",", ".") %> </td>
     <td align="right"><%= (f.format(tabAppelsoffres[i].getMontantIndhEmis())).replace(",", ".") %> </td>
     <td align="right"><%= (f.format(tabAppelsoffres[i].getPartCengagee())).replace(",", ".") %> </td>
     <td align="right"><%= (f.format(tabAppelsoffres[i].getPartIndhEngagee())).replace(",", ".") %> </td>
     <td align="right"><%= (f.format( ((tabAppelsoffres[i].getMontantIndhEmis().subtract(tabAppelsoffres[i].getPartCengagee())).subtract(tabAppelsoffres[i].getPartIndhEngagee())) )).replace(",", ".") %> </td>
     <td align="center"><%= tabAppelsoffres[i].getStatutActuel() %> </td>
     <td align="center"><input type="button" class="btn btn-default" id="ouvrirAO<%=i%>"  value="Ouvrir" size="35"/> </td>
     <td align="center"><input type="button" class="btn btn-default2" id="exporterRapportAppelOffre<%=i%>"  value="Rapport du marché" size="35"/> </td>
     <td align="center"><input type="button" class="btn btn-default" id="suprrimerAO<%=i%>"  value="X" size="35"/> </td>
     <td align="center"><input type="button" class="btn btn-default4" id="afficherDocuments<%=i%>"  value="Pièces jointes" size="35"/></td>
     </tr>
     <%} %>
     <tr>
     <td colspan="8" >  </td>   
     <td align="right"> <%=montantPayeTTC %>  </td> 
     <td align="right"> <%=montantDepensesDivers %>  </td> 
     <td align="right"> <%=montantChargesSalaire %>  </td> 
     <td align="right"> <%=montantBenefice %>  </td>
     <td colspan="5" >  </td>   
     </tr>
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