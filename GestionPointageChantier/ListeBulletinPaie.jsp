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
         $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=tabBulletinPaie[i].getIdBulletinPaie()%>").addClass("table tr tr-selectionner");     
        $("#idBulletinPaie").val("<%= tabBulletinPaie[i].getIdBulletinPaie() %>");
        $("#idPersonnel").val("<%= tabBulletinPaie[i].getIdPersonnel() %>"); 
        $("#salaireParJour").val($('#salaireParJour2<%=i%>').val());
        $("#salaireParHeure").val($('#salaireParHeure2<%=i%>').val());     
        $("#montantPayer").val($('#montantPayer2<%=i%>').val());      
  
        $("#jour1").val($('#1jourTravail1<%=i%>').val());
        $("#jour2").val($('#2jourTravail2<%=i%>').val());
        $("#jour3").val($('#3jourTravail3<%=i%>').val());
        $("#jour4").val($('#4jourTravail4<%=i%>').val());
        $("#jour5").val($('#5jourTravail5<%=i%>').val());
        $("#jour6").val($('#6jourTravail6<%=i%>').val());
        $("#jour7").val($('#7jourTravail7<%=i%>').val());
        $("#jour8").val($('#8jourTravail8<%=i%>').val());
        $("#jour9").val($('#9jourTravail9<%=i%>').val());
        $("#jour10").val($('#10jourTravail10<%=i%>').val());
        $("#jour11").val($('#11jourTravail11<%=i%>').val());
        $("#jour12").val($('#12jourTravail12<%=i%>').val());
        $("#jour13").val($('#13jourTravail13<%=i%>').val());
        $("#jour14").val($('#14jourTravail14<%=i%>').val());
        $("#jour15").val($('#15jourTravail15<%=i%>').val());
        $("#jour16").val($('#16jourTravail16<%=i%>').val());
        $("#jour17").val($('#17jourTravail17<%=i%>').val());
        $("#jour18").val($('#18jourTravail18<%=i%>').val());
        $("#jour19").val($('#19jourTravail19<%=i%>').val());
        $("#jour20").val($('#20jourTravail20<%=i%>').val());
        $("#jour21").val($('#21jourTravail21<%=i%>').val());
        $("#jour22").val($('#22jourTravail22<%=i%>').val());
        $("#jour23").val($('#23jourTravail23<%=i%>').val());
        $("#jour24").val($('#24jourTravail24<%=i%>').val());
        $("#jour25").val($('#25jourTravail25<%=i%>').val());
        $("#jour26").val($('#26jourTravail26<%=i%>').val());
        $("#jour27").val($('#27jourTravail27<%=i%>').val());
        $("#jour28").val($('#28jourTravail28<%=i%>').val());
        $("#jour29").val($('#29jourTravail29<%=i%>').val());
        $("#jour30").val($('#30jourTravail30<%=i%>').val());
        $("#jour31").val($('#31jourTravail31<%=i%>').val());
        
        $("#heurejour1").val($('#1heureTravail1<%=i%>').val());
        $("#heurejour2").val($('#2heureTravail2<%=i%>').val());
        $("#heurejour3").val($('#3heureTravail3<%=i%>').val());
        $("#heurejour4").val($('#4heureTravail4<%=i%>').val());
        $("#heurejour5").val($('#5heureTravail5<%=i%>').val());
        $("#heurejour6").val($('#6heureTravail6<%=i%>').val());
        $("#heurejour7").val($('#7heureTravail7<%=i%>').val());
        $("#heurejour8").val($('#8heureTravail8<%=i%>').val());
        $("#heurejour9").val($('#9heureTravail9<%=i%>').val());
        $("#heurejour10").val($('#10heureTravail10<%=i%>').val());
        $("#heurejour11").val($('#11heureTravail11<%=i%>').val());
        $("#heurejour12").val($('#12heureTravail12<%=i%>').val());
        $("#heurejour13").val($('#13heureTravail13<%=i%>').val());
        $("#heurejour14").val($('#14heureTravail14<%=i%>').val());
        $("#heurejour15").val($('#15heureTravail15<%=i%>').val());
        $("#heurejour16").val($('#16heureTravail16<%=i%>').val());
        $("#heurejour17").val($('#17heureTravail17<%=i%>').val());
        $("#heurejour18").val($('#18heureTravail18<%=i%>').val());
        $("#heurejour19").val($('#19heureTravail19<%=i%>').val());
        $("#heurejour20").val($('#20heureTravail20<%=i%>').val());
        $("#heurejour21").val($('#21heureTravail21<%=i%>').val());
        $("#heurejour22").val($('#22heureTravail22<%=i%>').val());
        $("#heurejour23").val($('#23heureTravail23<%=i%>').val());
        $("#heurejour24").val($('#24heureTravail24<%=i%>').val());
        $("#heurejour25").val($('#25heureTravail25<%=i%>').val());
        $("#heurejour26").val($('#26heureTravail26<%=i%>').val());
        $("#heurejour27").val($('#27heureTravail27<%=i%>').val());
        $("#heurejour28").val($('#28heureTravail28<%=i%>').val());
        $("#heurejour29").val($('#29heureTravail29<%=i%>').val());
        $("#heurejour30").val($('#30heureTravail30<%=i%>').val());
        $("#heurejour31").val($('#31heureTravail31<%=i%>').val());
        
        
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
    
    
         
     $("#ligne<%=tabBulletinPaie[i].getIdBulletinPaie()%>  input").mousedown(function()  {  
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
		     <th> Fonction  </th>	      
		     <th> 01 Jour/Heure </th><th> 02 Jour/Heure</th><th> 03 Jour/Heure</th><th> 04 Jour/Heure</th><th> 05 Jour/Heure</th><th> 06 Jour/Heure</th> <th> 07 Jour/Heure</th><th> 08 Jour/Heure</th><th> 09 Jour/Heure</th>  <th> 10 Jour/Heure</th>  
		     <th> 11 Jour/Heure</th><th> 12 Jour/Heure</th><th> 13 Jour/Heure</th><th> 14 Jour/Heure</th><th> 15 Jour/Heure</th>
		     <th> 16 Jour/Heure</th> <th> 17 Jour/Heure</th><th> 18 Jour/Heure</th><th> 19 Jour/Heure</th>  <th> 20 Jour/Heure</th>  
		     <th> 21 Jour/Heure</th><th> 22 Jour/Heure</th><th> 23 Jour/Heure</th><th> 24 Jour/Heure</th><th> 25 Jour/Heure</th><th> 26 Jour/Heure</th> <th> 27 Jour/Heure</th><th> 28 Jour/Heure</th><th> 29 Jour/Heure</th>  <th> 30 Jour/Heure</th> <th> 31 Jour/Hs</th>   		     
		     <th> Tarif/Jour </th>
		     <th> Tarif/Heure </th>
		     <th> Montant Payé </th>   
		     <th width="180">   </th>
		     <th> Nom Personnel  </th> 
		     <th> Jours Travail </th> 
		     <th> Heures Travail </th> 
		     <th> Salaire à payer </th>
		     <th> Reste à payer </th> 
		     <th>  </th>     		     
		     		      
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
		     	     
		    <td> <input type="number" name="jourTravailA1<%=i%>" id="1jourTravail1<%=i%>" value="<%=tabBulletinPaie[i].getJour1()%>"  /> 
		    </br> <input type="number" name="heureTravaiBl1<%=i%>" id="1heureTravail1<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour1()%>" /></td>
		    <td> <input type="number" name="jourTravail2<%=i%>" id="2jourTravail2<%=i%>" value="<%=tabBulletinPaie[i].getJour2()%>"  /> 
		    </br> <input type="number" name="heureTravail2<%=i%>" id="2heureTravail2<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour2()%>" /></td>
		    <td> <input type="number" name="jourTravail3<%=i%>" id="3jourTravail3<%=i%>" value="<%=tabBulletinPaie[i].getJour3()%>"  /> 
		    </br> <input type="number" name="heureTravail3<%=i%>" id="3heureTravail3<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour3()%>" /></td>
		    <td> <input type="number" name="jourTravail4<%=i%>" id="4jourTravail4<%=i%>" value="<%=tabBulletinPaie[i].getJour4()%>"  /> 
		    </br> <input type="number" name="heureTravail4<%=i%>" id="4heureTravail4<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour4()%>" /></td>
		    <td> <input type="number" name="jourTravail5<%=i%>" id="5jourTravail5<%=i%>" value="<%=tabBulletinPaie[i].getJour5()%>"  /> 
		    </br> <input type="number" name="heureTravail5<%=i%>" id="5heureTravail5<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour5()%>" /></td>
		    <td> <input type="number" name="jourTravail6<%=i%>" id="6jourTravail6<%=i%>" value="<%=tabBulletinPaie[i].getJour6()%>"  /> 
		    </br> <input type="number" name="heureTravail6<%=i%>" id="6heureTravail6<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour6()%>" /></td>
		    <td> <input type="number" name="jourTravail7<%=i%>" id="7jourTravail7<%=i%>" value="<%=tabBulletinPaie[i].getJour7()%>"  /> 
		    </br> <input type="number" name="heureTravail7<%=i%>" id="7heureTravail7<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour7()%>" /></td>
		    <td> <input type="number" name="jourTravail8<%=i%>" id="8jourTravail8<%=i%>" value="<%=tabBulletinPaie[i].getJour8()%>"  /> 
		    </br> <input type="number" name="heureTravail8<%=i%>" id="8heureTravail8<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour8()%>" /></td>
		    <td> <input type="number" name="jourTravail9<%=i%>" id="9jourTravail9<%=i%>" value="<%=tabBulletinPaie[i].getJour9()%>"  /> 
		    </br> <input type="number" name="heureTravail9<%=i%>" id="9heureTravail9<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour9()%>" /></td>	    
		    <td> <input type="number" name="jourTravail10<%=i%>" id="10jourTravail10<%=i%>" value="<%=tabBulletinPaie[i].getJour10()%>"  /> 
		    </br> <input type="number" name="heureTravail10<%=i%>" id="10heureTravail10<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour10()%>" /></td>
		    
		    <td> <input type="number" name="jourTravail11<%=i%>" id="11jourTravail11<%=i%>" value="<%=tabBulletinPaie[i].getJour11()%>"  /> 
		    </br> <input type="number" name="heureTravail11<%=i%>" id="11heureTravail11<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour11()%>" /></td>	    
		    <td> <input type="number" name="jourTravail12<%=i%>" id="12jourTravail12<%=i%>" value="<%=tabBulletinPaie[i].getJour12()%>"  /> 
		    </br> <input type="number" name="heureTravail12<%=i%>" id="12heureTravail12<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour12()%>" /></td>
		    <td> <input type="number" name="jourTravail13<%=i%>" id="13jourTravail13<%=i%>" value="<%=tabBulletinPaie[i].getJour13()%>"  /> 
		    </br> <input type="number" name="heureTravail13<%=i%>" id="13heureTravail13<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour13()%>" /></td>
		    <td> <input type="number" name="jourTravail14<%=i%>" id="14jourTravail14<%=i%>" value="<%=tabBulletinPaie[i].getJour14()%>"  /> 
		    </br> <input type="number" name="heureTravail14<%=i%>" id="14heureTravail14<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour14()%>" /></td>
		    <td> <input type="number" name="jourTravail15<%=i%>" id="15jourTravail15<%=i%>" value="<%=tabBulletinPaie[i].getJour15()%>"  /> 
		    </br> <input type="number" name="heureTravail15<%=i%>" id="15heureTravail15<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour15()%>" /></td>
		    <td> <input type="number" name="jourTravail16<%=i%>" id="16jourTravail16<%=i%>" value="<%=tabBulletinPaie[i].getJour16()%>"  /> 
		    </br> <input type="number" name="heureTravail16<%=i%>" id="16heureTravail16<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour16()%>" /></td>
		    <td> <input type="number" name="jourTravail17<%=i%>" id="17jourTravail17<%=i%>" value="<%=tabBulletinPaie[i].getJour17()%>"  /> 
		    </br> <input type="number" name="heureTravail17<%=i%>" id="17heureTravail17<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour17()%>" /></td>
		    <td> <input type="number" name="jourTravail18<%=i%>" id="18jourTravail18<%=i%>" value="<%=tabBulletinPaie[i].getJour18()%>"  /> 
		    </br> <input type="number" name="heureTravail18<%=i%>" id="18heureTravail18<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour18()%>" /></td>
		    <td> <input type="number" name="jourTravail19<%=i%>" id="19jourTravail19<%=i%>" value="<%=tabBulletinPaie[i].getJour19()%>"  /> 
		    </br> <input type="number" name="heureTravail19<%=i%>" id="19heureTravail19<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour19()%>" /></td>
		    <td> <input type="number" name="jourTravail20<%=i%>" id="20jourTravail20<%=i%>" value="<%=tabBulletinPaie[i].getJour20()%>"  /> 
		    </br> <input type="number" name="heureTravail20<%=i%>" id="20heureTravail20<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour20()%>" /></td>
		    
		    
		    <td> <input type="number" name="jourTravail21<%=i%>" id="21jourTravail21<%=i%>" value="<%=tabBulletinPaie[i].getJour21()%>"  /> 
		    </br> <input type="number" name="heureTravail21<%=i%>" id="21heureTravail21<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour21()%>" /></td>	    
		    <td> <input type="number" name="jourTravail22<%=i%>" id="22jourTravail22<%=i%>" value="<%=tabBulletinPaie[i].getJour22()%>"  /> 
		    </br> <input type="number" name="heureTravail22<%=i%>" id="22heureTravail22<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour22()%>" /></td>
		    <td> <input type="number" name="jourTravail23<%=i%>" id="23jourTravail23<%=i%>" value="<%=tabBulletinPaie[i].getJour23()%>"  /> 
		    </br> <input type="number" name="heureTravail23<%=i%>" id="23heureTravail23<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour23()%>" /></td>
		    <td> <input type="number" name="jourTravail24<%=i%>" id="24jourTravail24<%=i%>" value="<%=tabBulletinPaie[i].getJour24()%>"  /> 
		    </br> <input type="number" name="heureTravail24<%=i%>" id="24heureTravail24<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour24()%>" /></td>
		    <td> <input type="number" name="jourTravail25<%=i%>" id="25jourTravail25<%=i%>" value="<%=tabBulletinPaie[i].getJour25()%>"  /> 
		    </br> <input type="number" name="heureTravail25<%=i%>" id="25heureTravail25<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour25()%>" /></td>
		    <td> <input type="number" name="jourTravail26<%=i%>" id="26jourTravail26<%=i%>" value="<%=tabBulletinPaie[i].getJour26()%>"  /> 
		    </br> <input type="number" name="heureTravail26<%=i%>" id="26heureTravail26<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour26()%>" /></td>
		    <td> <input type="number" name="jourTravail27<%=i%>" id="27jourTravail27<%=i%>" value="<%=tabBulletinPaie[i].getJour27()%>"  /> 
		    </br> <input type="number" name="heureTravail27<%=i%>" id="27heureTravail27<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour27()%>" /></td>
		    <td> <input type="number" name="jourTravail28<%=i%>" id="28jourTravail28<%=i%>" value="<%=tabBulletinPaie[i].getJour28()%>"  /> 
		    </br> <input type="number" name="heureTravail28<%=i%>" id="28heureTravail28<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour28()%>" /></td>
		    <td> <input type="number" name="jourTravail29<%=i%>" id="29jourTravail29<%=i%>" value="<%=tabBulletinPaie[i].getJour29()%>"  /> 
		    </br> <input type="number" name="heureTravail29<%=i%>" id="29heureTravail29<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour29()%>" /></td>
		    <td> <input type="number" name="jourTravail30<%=i%>" id="30jourTravail30<%=i%>" value="<%=tabBulletinPaie[i].getJour30()%>"  /> 
		    </br> <input type="number" name="heureTravail30<%=i%>" id="30heureTravail30<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour30()%>" /></td>
		    <td> <input type="number" name="jourTravail31<%=i%>" id="31jourTravail31<%=i%>" value="<%=tabBulletinPaie[i].getJour31()%>"  /> 
		    </br> <input type="number" name="heureTravail31<%=i%>" id="31heureTravail31<%=i%>" value="<%=tabBulletinPaie[i].getHeurejour31()%>" /></td>
		    
		    <td> <input type="number" name="salaireParJour2<%=i%>" id="salaireParJour2<%=i%>" value="<%=tabBulletinPaie[i].getSalaireParJour()%>" class="number_input7" /> </td>      		     		    		    
		    <td> <input type="number" name="salaireParHeure2<%=i%>" id="salaireParHeure2<%=i%>" value="<%=tabBulletinPaie[i].getSalaireParHeure()%>" class="number_input7" /> </td>      		     		    
		    <td> <input type="number" name="montantPayer2<%=i%>" id="montantPayer2<%=i%>" value="<%=tabBulletinPaie[i].getMontantPayer()%>" class="number_input7" /> </td>      		     
		    <td> <input type="button" class="btn btn-default4" id="modifierBulletinPaie<%=i%>"  value="Valider" size="35"/>	</td> 	    		           
		     
		     <td><%= tabBulletinPaie[i].getPersonnel().getNom() %> </td>
		     <td align="right"><%= tabBulletinPaie[i].getJoursTravail() %> </td>
		     <td align="right"><%= tabBulletinPaie[i].getHeuresTravail() %> </td>     
		     <td align="right"><%= tabBulletinPaie[i].getSalaireParMois() %> </td>
		     <td align="right"><%= tabBulletinPaie[i].getResteApayer() %> </td> 
		     <td> <input type="button" class="btn btn-default4" id="supprimerBulletinPaie<%=i%>"  value="X" size="35"/>	</td>        
		   
	     </tr>
	     <%} %>
	     <tr>
             <td colspan="35" >  </td>  
             <td align="center"> Total  </td>  
             <td align="right">  <%= montantPayer.setScale(2, BigDecimal.ROUND_DOWN)%> </td>
             <td align="center">  </td>
             <td align="center">  </td>
             <td align="center">  </td>
             <td align="center">  </td>
             <td align="right">  <%= montantApayer.setScale(2, BigDecimal.ROUND_DOWN)%> </td>
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