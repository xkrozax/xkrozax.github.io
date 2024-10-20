<%@ page language="java" import="java.util.*" import="metier.Programmeprevisionnel" contentType="text/html; charset=UTF-8"%>
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
	Programmeprevisionnel[] tabProgramme;
	tabProgramme=(Programmeprevisionnel[])request.getAttribute("listeProgramme");
	 %>
	<% int size = tabProgramme.length;  
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
    $('#ajouterProgramme').click(function ajouterProgramme() 
    { 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "ajouterProgramme.do", 
            data:$("#formRechercherProgramme").serialize(),
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
               $("#listeProgramme").html(html);               
            } 
         }); 
    } 
    );  
    $('#BtnExporterProgramme').click(function BtnExporterProgramme() 
    {                   
        $("#categorieProgramme").val("Fr"); 
        $("#chargement").show();
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "exporterProgramme.do", 
            data:$("#formRechercherProgramme").serialize(),
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
               window.location.replace("../../MarchesPublics/Fichiers/ProgrammePrevisionnel.pdf");                   
            } 
         });     
    });   
    </script>	
	<%for(int i=0;i<tabProgramme.length;i++) {%>
    <script type="text/javascript">
    $('#modifierProgramme<%=i%>').click(function modifierProgramme() 
    { 
        $("tr").removeClass("table tr tr-selectionner");
        $("#ligne<%=i%>").addClass("table tr tr-selectionner");
        $("#idProgramme").val("<%= tabProgramme[i].getIdProgramme() %>");
        $("#typeProgramme").val($('#typeProgramme2<%=i%>').val());
        $("#objetProgramme").val($('#objetProgramme2<%=i%>').val());
        $("#lieuExecution").val($('#lieuExecution2<%=i%>').val()); 
        $("#modePassation").val($('#modePassation2<%=i%>').val()); 
        $("#periodeLancement").val($('#periodeLancement2<%=i%>').val()); 
        $("#service").val($('#service2<%=i%>').val()); 
        $("#reserverPme").val($('#reserverPme2<%=i%>').val()); 
        $("#chargement").show();  
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "modifierProgramme.do", 
            data:$("#formModifierProgramme").serialize(),
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
               $("#ligne<%=i%>").removeClass("table tr tr-selectionner");                          
            } 
         }); 
    } 
    );  
   	$('#supprimerProgramme<%=i%>').click(function supprimerProgramme() 
    {         
        $("#idProgramme").val("<%= tabProgramme[i].getIdProgramme() %>");
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligne<%=i%>").addClass("table tr tr-selectionner"); 
        
        $("#dialog1").dialog({
	           autoOpen: true, 
               buttons: {
               Non: function() {
                  $("#dialog1").dialog("close");  
                  $("tr").removeClass("table tr tr-selectionner");                   
                  },
               Oui: function() {
                               $("#chargement").show();        
                               $.ajax( 
                               {    
                               type: "POST", 
                               enctype:"multipart/form-data",
                               url: "supprimerProgramme.do", 
                               data:$("#formModifierProgramme").serialize(),
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
                              $("#dialog2").dialog({
	                          autoOpen: true, 
                              buttons: {
                              OK: function() {
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
         }); 
               // ---------------------------                                     
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
               $( "#dialog2" ).dialog("open");          
    } 
    );  
    </script>
    <%} %>   
  </head> 
  <body>  
     <%if(tabProgramme.length>0){ %>
     <%}
       else
       { %>
     <table  border="2" bgcolor=""  bordercolor="#000000" class="table table-hover " width="1542" >    
     <tr>    
     <th width="320"> Type </th>
     <th> Objet </th>
     <th> Lieu d'exécution</th>    
     <th> Mode de passation</th>
     <th> Période de lancement </th> 
     <th> Service concerné </th>    
     <th> Réservés à PME </th>
     <th colspan="2"> <input type="button" class="btn btn-default4" id="ajouterProgramme"  value="Ajouter" size="35"/>
     </th>        
     </tr>
     <tr><td colspan="11"> <center> Néant </center> </td></tr> 
     </table> 
      <%} %>
     <%if(tabProgramme.length>0){ %>
     <input type="button" id="BtnExporterProgramme"  class="btn btn-default2"   value= " Imprimer " size="28"/>
    
     <table id=""  border="2" bgcolor=""  bordercolor="#000000" class="table table-hover " width="1642" >    
     <tr>    
     <th width="320"> Type </th>
     <th> Objet </th>
     <th> Lieu d'exécution</th>    
     <th> Mode de passation</th>
     <th> Période de lancement </th> 
     <th> Service concerné </th>    
     <th> Réservés à PME </th>
     <th colspan="2"> <input type="button" class="btn btn-default4" id="ajouterProgramme"  value="Ajouter" size="35"/> 
     </th>         
     </tr>   
     <%for(int i=0;i<tabProgramme.length;i++) {%>
     <tr id="ligne<%=i%>">   
     <td align="left"> <input type="text" name="typeProgramme2<%=i%>" id="typeProgramme2<%=i%>"  value="<%=tabProgramme[i].getTypeProgramme()%>" size="23"/></td>                 
     <td align="left"> <input type="text" name="objetProgramme2<%=i%>" id="objetProgramme2<%=i%>"  value="<%=tabProgramme[i].getObjetProgramme()%>" size="57"/></td>                 
     <td align="left"> <input type="text" name="lieuExecution2<%=i%>" id="lieuExecution2<%=i%>"  value="<%=tabProgramme[i].getLieuExecution()%>" size="22"/></td>                         
     <td align="center"><select name="modePassation2<%=i%>"   id="modePassation2<%=i%>" >
                <option  value="<%= tabProgramme[i].getModePassation() %>"><%= tabProgramme[i].getModePassation() %></option>
                <option  value="---------------------"> ------------------------------------- </option>
                <option  value="Appel d'offres">Appel d'offres</option>
                <option  value="Bon de commande">Bon de commande</option>
                <option  value="Contrat de droit commun">Contrat de droit commun</option>
                <option  value="Convention">Convention</option>
		        <option  value="Consultation architecturale">Consultation architecturale</option>
		        <option  value="Concours architecturale">Concours architecturale</option>
		        <option  value="Concours">Concours</option>	
		        <option  value="Marché négocié">Marché négocié</option>	   
     </select>
     </td>
     <td align="left"> <input type="text" name="periodeLancement2<%=i%>" id="periodeLancement2<%=i%>"  value="<%=tabProgramme[i].getPeriodeLancement()%>" size="13"/></td>                 
     <td align="center"><select name="service2<%=i%>"   id="service2<%=i%>"  >
                <option  value="<%= tabProgramme[i].getService() %>"><%= tabProgramme[i].getService() %></option>
                <option  value="---------------------"> ------------------------------------- </option>
                <option  value="Service marchés"> Service marchés </option>
	            <option  value="Service des travaux"> Service des travaux </option>
	            <option  value="Service environnement-eau et espaces verts"> Service environnement-eau et espaces verts</option>
	            <option  value="Service d'inventaire et approvisionnement"> Service d'inventaire et approvisionnement </option>              
                <option  value="Service d'éclirage public"> Service d'éclirage public </option>
                <option  value="Service d'urbanisme"> Service d'urbanisme </option>
                <option  value="Service de domaine public communal"> Service de domaine public communal </option>
                <option  value="Service de patrimoine communal"> Service de patrimoine communal </option>
                <option  value="Service de comptabilité"> Service de comptabilité </option>
                <option  value="Service de Recouvrement"> Service de Recouvrement </option>
                <option  value="Service de gestion parc Auto"> Service de gestion parc Auto </option>
                <option  value="Secrétariat du Président"> Secrétariat du Président </option>
                <option  value="Service Ressources Humaines"> Service Ressources Humaines </option>
                <option  value="Service ILDH"> Service ILDH </option>
                <option  value="Bureau communal d’hygiène"> Bureau communal d’hygiène </option>
                <option  value="Service magasin"> Service magasin </option>
                <option  value="Service recette"> Service recette </option>
                <option  value="service Mécanique"> service Mécanique </option>
                <option  value="Division d’Equipement"> Division d’Equipement </option>
                <option  value="Division Administratif et Juridique"> Division Administratif et Juridique </option>
                <option  value="Division des affaires économiques sociales Culturelles et sportives"> division des affaires économiques sociales Culturelles et sportives </option>       
                <option  value="Division budget et affaires financières"> Division budget et affaires financières </option>      

     </select>
     </td>
     <td align="center"><select name="reserverPme2<%=i%>"   id="reserverPme2<%=i%>"  >
     <option  value="<%= tabProgramme[i].getReserverPme() %>"><%= tabProgramme[i].getReserverPme() %></option>
     <option  value="----"> ---- </option>
     <option  value="Oui"> Oui </option>
	 <option  value="Non"> Non </option>
     </select>
     </td>
     <td align="center"><input type="button" class="btn btn-default4" id="modifierProgramme<%=i%>"  value=" + " size="35"/> </td>                        
     <td align="center"><input type="button" class="btn btn-default4" id="supprimerProgramme<%=i%>"  value=" X " size="35"/> </td>                        
     </tr>
     <%} %>
     </table>
     <%} %>
     
  </body>
</html>