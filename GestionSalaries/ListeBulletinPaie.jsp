<%@ page language="java" import="java.util.*" import="metier.Bulletinpaie" import="java.math.BigDecimal"  import="trierObjet.TrierFormatDate"   contentType="text/html; charset=UTF-8"%>
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
	Bulletinpaie[] tabBulletinPaie =(Bulletinpaie[])request.getAttribute("listeBulletinPaie");
	int ligne = (Integer)request.getAttribute("ligne");
	BigDecimal nombreDecimal=new BigDecimal("00.00").setScale(2, BigDecimal.ROUND_DOWN);
	BigDecimal montantPayer = nombreDecimal;
	BigDecimal montantApayer = nombreDecimal;
	BigDecimal ResteApayer = nombreDecimal;
	String   role = "";
	if ((String) session.getAttribute("role") != null){
      role = (String) session.getAttribute("role");  
    }
    
		int size = tabBulletinPaie.length;  
			int sizeParPage = 300;
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
     var size =<%=tabBulletinPaie.length%>;  
			var sizeParPage = 300;
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
	   
	    $("tr").removeClass("table tr tr-selectionner"); 
	    if(<%=ligne%> > 0){ 
        $("#ligne<%=ligne%>").addClass("table tr tr-selectionner");   
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
	
	$('#modifierDateReglementListeBulletin').click(function modifierDateReglementListeBulletin()
    {     
        $("#dateReglementListeBulletin").val($('#dateReglementListeBulletin2').val());    
        $("#chargement").show();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "modifierDateReglementListeBulletin.do", 
            data:$("#formRechercherBulletinPaie").serialize(),
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
               $("#resultatRecherche").html(html);
               $("#resultatRecherche").show();                          
            } 
         }); 
    } 
    );    
	</script>	
	<%for(int i=0;i<tabBulletinPaie.length;i++) {%>
    <script type="text/javascript"> 	
    $('#supprimerBulletinPaie<%=i%>').click(function supprimerBulletinPaie() 
    {         
        $("#idBulletinPaie").val("<%= tabBulletinPaie[i].getIdBulletinPaie() %>");
        $("#idPersonnel").val("<%= tabBulletinPaie[i].getIdPersonnel() %>");
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=tabBulletinPaie[i].getIdBulletinPaie()%>").addClass("table tr tr-selectionner"); 
        
        $("#dialog5").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialog5").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#ligne<%=tabBulletinPaie[i].getIdBulletinPaie()%>").hide(); 
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                               type: "POST", 
                               enctype:"multipart/form-data",
                               url: "supprimerBulletinPaie.do", 
                               data:$("#formRechercherBulletinPaie").serialize(),
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
    $('#modifierBulletinPaie<%=i%>').click(function modifierBulletinPaie() 
    {         
        $("#idBulletinPaie").val("<%= tabBulletinPaie[i].getIdBulletinPaie() %>");
        $("#idPersonnel").val("<%= tabBulletinPaie[i].getIdPersonnel() %>");      
        $("#montantPayer").val($('#montantPayer2<%=i%>').val());
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=tabBulletinPaie[i].getIdBulletinPaie()%>").addClass("table tr tr-selectionner"); 
        
        
        
        $("#dialogModifier").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialogModifier").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                               type: "POST", 
                               enctype:"multipart/form-data",
                               url: "modifierBulletinPaie.do", 
                               data:$("#formRechercherBulletinPaie").serialize(),
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
                              $("#resultatRecherche").html(html);                           
                                                         
            } 
         }); 
               // ---------------------------                                     
                 $("#dialogModifier").dialog("close"); 
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
               $( "#dialogModifier" ).dialog("open");          
    } 
    );  
    $('#validerBulletinPaie<%=i%>').click(function validerBulletinPaie() 
    {         
        $("#idBulletinPaie").val("<%= tabBulletinPaie[i].getIdBulletinPaie() %>");
        $("#idPersonnel").val("<%= tabBulletinPaie[i].getIdPersonnel() %>");      
        $("#joursTravail").val($('#joursTravail2<%=i%>').val());
        $("#nbJoursConge").val($('#nbJoursConge2<%=i%>').val());
        $("#primeNonImposable").val($('#primeNonImposable2<%=i%>').val());
        $("#retenuePrets").val($('#retenuePrets2<%=i%>').val());
        $("#modeReglement").val($('#modeReglement2<%=i%>').val());
        $("#dateReglement").val($('#dateReglement2<%=i%>').val());
        $("#heuresSupp").val("00.00");
        $("#primeImposable").val("00.00");
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=tabBulletinPaie[i].getIdBulletinPaie()%>").addClass("table tr tr-selectionner"); 
        
        $("#dialogValider").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialogValider").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                               type: "POST", 
                               enctype:"multipart/form-data",
                               url: "validerBulletinPaie.do", 
                               data:$("#formRechercherBulletinPaie").serialize(),
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
                              $('#etatReglement<%=i%>').html('Validé');
                              $('#modifierBulletinPaie<%=i%>').hide();
                              $('#validerBulletinPaie<%=i%>').hide();
                              $("#resultatRecherche").html(html);
                              
                                             
            } 
         }); 
               // ---------------------------                                     
                 $("#dialogValider").dialog("close"); 
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
               $( "#dialogValider" ).dialog("open");          
    } 
    );
     
         
     $('#montantPayer2<%=i%>').keydown(function()  {  
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=tabBulletinPaie[i].getIdBulletinPaie()%>").addClass("table tr tr-selectionner"); 
     });
     $('#avance2<%=i%>').keydown(function()  {  
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=tabBulletinPaie[i].getIdBulletinPaie()%>").addClass("table tr tr-selectionner"); 
     });
     $('#dateReglement2<%=i%>').keydown(function()  {  
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=tabBulletinPaie[i].getIdBulletinPaie()%>").addClass("table tr tr-selectionner"); 
     }); 
    </script>    
    <%} %>   
  </head> 
  <body>  
     <%if(tabBulletinPaie.length>0){ %>
     <%}
       else
       { %>
         <center>  Aucun Résultat </center>
      <%} %>
     <%if(tabBulletinPaie.length>0){ %>
     <%for(int j=0;j<nbPage;j++){ %>
     <table id="<%=j%>"  border="4" bgcolor=""  bordercolor="#000000"  class="table table-hover " width="" >     
	     <tr>
	         <th> Mat  </th> 
		     <th> Nom Personnel  </th>
		     <th> Fonction </th>
		     <th> Mode Paiement  </th> 	 	     	     
		     <th> Salaire à payer </th>
		     <th> Montant Payé </th>
		     <th> Reste à payer </th> 
		      <th width="130">   </th>     		     
		     		      
	     </tr>   
	     <% int debut = j*sizeParPage, fin = (j+1)*sizeParPage; %>
	     <%for(int i=debut;i<fin && i < size;i++) {%>
	     <%
	     montantPayer = montantPayer.add(tabBulletinPaie[i].getMontantPayer());
	     montantApayer = montantApayer.add(tabBulletinPaie[i].getSalaireParMois());
	     ResteApayer = ResteApayer.add(tabBulletinPaie[i].getResteApayer());
	     %>
	     <tr id="ligne<%=tabBulletinPaie[i].getIdBulletinPaie()%>" > 
		     <td align="center"><%= tabBulletinPaie[i].getPersonnel().getMatricule() %> </td>
		     <td><%= tabBulletinPaie[i].getPersonnel().getNom() %> </td>
		     <td><%= tabBulletinPaie[i].getPersonnel().getFonction() %> </td>
		     <td> Paiement <%= tabBulletinPaie[i].getPersonnel().getContratAnapec() %> </td>		     
	     		         
		     <td align="right"><%= tabBulletinPaie[i].getSalaireParMois() %> </td>
		     <td> <input type="number" name="montantPayer2<%=i%>" id="montantPayer2<%=i%>" value="<%=tabBulletinPaie[i].getMontantPayer()%>" class="number_input7" /> </td>      		     
		     <td align="right"><%= tabBulletinPaie[i].getResteApayer() %> </td>  
		     <td>		      
		      <input type="button" class="btn btn-default4" id="modifierBulletinPaie<%=i%>"  value="Valider" size="35"/>		    
		      <input type="button" class="btn btn-default4" id="supprimerBulletinPaie<%=i%>"  value="X" size="35"/>	       
		     </td>	         
	              
	     </tr>
	     <%} %>
	     <tr>          
             <td align="center">  </td>
             <td align="center">  </td>
             <td align="center"> </td>  
             <td align="center"> </td>  
             <td align="right">  <%= montantApayer.setScale(2, BigDecimal.ROUND_DOWN)%> </td>
             <td align="right">  <%= montantPayer.setScale(2, BigDecimal.ROUND_DOWN)%> </td> 
             <td align="right">  <%= ResteApayer.setScale(2, BigDecimal.ROUND_DOWN)%> </td>  
             
              
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