<%@ page language="java" import="java.util.*" import="java.text.SimpleDateFormat" import="metier.Attachement" contentType="text/html; charset=UTF-8"%>
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
	Attachement[] tabAttachements;
	tabAttachements=(Attachement[])request.getAttribute("listeAttachements");
	String   role = "";
	if ((String) session.getAttribute("role") != null){
      role = (String) session.getAttribute("role");  
    }
	SimpleDateFormat inSDF = new SimpleDateFormat("yyyy-mm-dd");
	SimpleDateFormat outSDF = new SimpleDateFormat("dd-mm-yyyy");
	String DateAttachement1 ="";
	String DateAttachement2 ="";
	 %>
	<% int size = tabAttachements.length;  
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
	
	<%for(int i=0;i<tabAttachements.length;i++) {%>
    <script type="text/javascript">
   	$('#afficherAttachement<%=i%>').click(function afficherAttachement() 
    {         
        $("#chargement").show();
        $("#listeBordereauPrix").show();
        $("#idAttachement").val("<%= tabAttachements[i].getIdAttachement() %>");
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligneA<%=i%>").addClass("table tr tr-selectionner");
        $("input[type='button']").removeClass("active btn-info");
        $('#btnAttachements').addClass("active btn-info");
        $('#afficherAttachement<%=i%>').addClass("active btn-info");
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "rechercherLignesAttachement.do", 
            data:$("#formAjouterAttachement").serialize(),
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
               $("#listeBordereauPrix2").html(html);               
               $("#BordereauAttachements").show(); 
               $("#listeBordereauPrix2").show();                   
            } 
         });            
    } 
    );
    $('#supprimerAttachement<%=i%>').click(function supprimerAttachement() 
    {         
        $("#idAttachement").val("<%= tabAttachements[i].getIdAttachement() %>");
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligneA<%=i%>").addClass("table tr tr-selectionner"); 
        $("tr").removeClass("table tr tr-selectionner");  
        $("#ligneA<%=i%>").addClass("table tr tr-selectionner");
        $("input[type='button']").removeClass("active btn-info");
        $('#btnAttachements').addClass("active btn-info");
        $('#afficherAttachement<%=i%>').addClass("active btn-info");
        $('#supprimerAttachement<%=i%>').addClass("active btn-info");
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
                               url: "supprimerAttachement.do", 
                               data:$("#formAjouterAttachement").serialize(),
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
                              $('#ligneA<%=i%>').hide(); 
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
    $('#modifierAttachement<%=i%>').click(function modifierAttachement() 
    {         
        $("#chargement").show();
        $("#idAttachementModifier").val("<%= tabAttachements[i].getIdAttachement() %>");
        $("#numAttachementModifier").val($('#numAttachement2<%=i%>').val());
        $("#typeAttachementModifier").val($('#typeAttachement2<%=i%>').val());
        $("#dateAttachementModifier").val($('#dateAttachement2<%=i%>').val());
        $("#dateDepotAttachement").val($('#dateDepotAttachement2<%=i%>').val());
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "modifierAttachement.do", 
            data:$("#formModifierAttachement").serialize(),
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
    $('#validerParChefProjet<%=i%>').click(function validerParChefProjet() 
    {         
        $("#chargement").show();
        $("#idAttachementModifier").val("<%= tabAttachements[i].getIdAttachement() %>");
        $("#validerParChefProjet").val($('#validerParChefProjet2<%=i%>').val());
        $("#dateValidationChefProjet").val($('#dateValidationChefProjet2<%=i%>').val());
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "validerAttachementParChefProjet.do", 
            data:$("#formModifierAttachement").serialize(),
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
    $('#validerParService<%=i%>').click(function validerParService() 
    {         
        $("#chargement").show();
        $("#idAttachementModifier").val("<%= tabAttachements[i].getIdAttachement() %>");
        $("#validerParService").val($('#validerParService2<%=i%>').val());
        $("#dateValidationService").val($('#dateValidationService2<%=i%>').val());
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "validerAttachementParService.do", 
            data:$("#formModifierAttachement").serialize(),
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
    $('#validerParDivision<%=i%>').click(function validerParDivision() 
    {         
        $("#chargement").show();
        $("#idAttachementModifier").val("<%= tabAttachements[i].getIdAttachement() %>");
        $("#validerParDivision").val($('#validerParDivision2<%=i%>').val());
        $("#dateValidationDivision").val($('#dateValidationDivision2<%=i%>').val());
        $.ajax( 
        {    
            type: "POST", 
            enctype:"multipart/form-data",
            url: "validerAttachementParDivision.do", 
            data:$("#formModifierAttachement").serialize(),
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
    $('#ajouterCopieAttachement<%=i%>').click(function ajouterCopieAttachement() 
    { 
        $("#idAttachementAjouterCopie").val("<%= tabAttachements[i].getIdAttachement() %>");
            
        $("#interfaceAjouterCopieAttachement").dialog({
	           autoOpen: true, 
               width: 520,
               height: 140,        
               position: {
			       my: "center",
			       at: "center",
			       of: window,
			       collision: "fit",
			       using: function( pos ) {
			     	   var topOffset = $( this ).css( pos ).offset().top;
				       if ( topOffset < 0 ) {
					   $( this ).css( "top", pos.top - topOffset );
				       }
			      }
		       }             
               });
               $("#interfaceAjouterCopieAttachement").dialog("open");
    } 
    );
    $('#exporterAttachement<%=i%>').click(function exporterAttachement() 
       {       
        $("#chargement").show();   
        window.location.replace("../../MarchesPublics/DossierDesAttachements/"+"<%=tabAttachements[i].getCopieAttachement()%>");      
        $("#chargement").hide();     
     }); 
    </script>
    <%} %>   
  </head> 
  <body> 
  
     <%if(tabAttachements.length>0){ %>
     <%}
       else
       { %>
         <center>  Aucun Attachement </center>
      <%} %>
     <%if(tabAttachements.length>0){ %>
     <%for(int j=0;j<nbPage;j++){ %>
     
     <% int debut = j*sizeParPage, fin = (j+1)*sizeParPage; %>
     <%for(int i=debut;i<fin && i < size;i++) {%> 
     <%if(tabAttachements[i].getCategorieAttachement().equals("Livraison")){ %> 
     <table   border="1" bgcolor=""  bordercolor="#000000" class="table table-hover " width="2052" > 
     <tr> 
     <th> N° de la facture </th>
     <th> Type de la facture </th>
     <th> Date dépôt de de la facture </th>
     <th> Date de service fait </th>
     <th>  </th>
     <th > Copie de la facture </th> 
     <th>  </th>
     <th> Validation par Chef de projet </th>
     <th> Validation par Chef de service </th>
     <th> Validation par Chef de division </th>
     </tr>   
     <tr id="ligneA<%=i%>"> 
     <%if (tabAttachements[i].getNumAttachement() != 0) {	%>
     <td align="center"> <input type="number" name="numAttachement2<%=i%>" id="numAttachement2<%=i%>" class="number_input"  value="<%=tabAttachements[i].getNumAttachement()%>" width="120"/> </td> 
     <%}else  {%><td align="center"> <input type="number" name="numAttachement2<%=i%>" id="numAttachement2<%=i%>" class="number_input"  value="" width="120"/> </td><%} %>
     <td align="center"><select name="typeAttachement2<%=i%>"   id="typeAttachement2<%=i%>" >	
                        <option  value="<%=tabAttachements[i].getTypeAttachement()%>"><%=tabAttachements[i].getTypeAttachement()%></option>  
                        <option  value="">---------------------------</option>
	                    <option  value="Provisoire"> Provisoire </option>
		                <option  value="Provisoire et dérnier"> Provisoire et dérnier </option>                       
		                <option  value="Définitif"> Définitif </option>
		                <option  value="Partiel provisoire">Partiel provisoire</option>
		                <option  value="Géneral provisoire">Géneral provisoire</option>		                
		                <option  value="Partiel définitif">Partiel définitif</option>
		                <option  value="Géneral définitif">Géneral définitif</option>                                   
	                    </select>
     </td> 
     <td align="center"> <input type="date" name="dateDepotAttachement2<%=i%>" id="dateDepotAttachement2<%=i%>"   value="<%=tabAttachements[i].getDateDepotAttachement() %>" size="10"/></td>               
     <td align="center"> <input type="date" name="dateAttachement2<%=i%>" id="dateAttachement2<%=i%>"   value="<%=tabAttachements[i].getDateAttachement() %>" size="10"/></td>                           
     <td align="center"><input type="button" id="modifierAttachement<%=i%>"  value=" + "  class="btn btn-default4" size="35"/> </td>
     <%if(!tabAttachements[i].getCopieAttachement().equals("")){  %>
     <td align="center"> <input type="button" id="exporterAttachement<%=i%>" value= " Copie de la facture " />  <input type="button" class="btn btn-default4" id="ajouterCopieAttachement<%=i%>"  value="+" size="35"/>   </td>          
     <%}else{ %> <td align="center">  <input type="button" class="btn btn-default4" id="ajouterCopieAttachement<%=i%>"  value="Ajouter Copie Facture" size="35"/>  </td><%} %>       
     <td align="center">    
     <input type="button" id="afficherAttachement<%=i%>"  value="Saisir Facture"  class="btn btn-default4" size="35"/> 
     <input type="button" id="supprimerAttachement<%=i%>" class="btn btn-default4" value="X" size="35"/>
     </td>    
     <td align="center"><select name="validerParChefProjet2<%=i%>"   id="validerParChefProjet2<%=i%>"   >	
                        <option  value="<%=tabAttachements[i].getValiderParChefProjet()%>"><%=tabAttachements[i].getValiderParChefProjet()%></option>                        
	                    <% if( role.equals("Chef De Projet") ) { %> 
	                    <option  value="">------------</option>
	                    <option  value="Non validé">Non validé</option>
	                    <option  value="Validé">Validé</option>	 
	                    <%} %>                                   
	                    </select>
	 <input type="date" name="dateValidationChefProjet2<%=i%>" id="dateValidationChefProjet2<%=i%>"   value="<%=tabAttachements[i].getDateValidationChefProjet() %>" size="10"/>                             
     <% if( role.equals("Chef De Projet") ) { %>                   
     <input type="button" class="btn btn-default4" id="validerParChefProjet<%=i%>"  value="+" size="35"/>     
     <%} %>
     </td>
     <td align="center"><select name="validerParService2<%=i%>"   id="validerParService2<%=i%>"   >	
                        <option  value="<%=tabAttachements[i].getValiderParService()%>"><%=tabAttachements[i].getValiderParService()%></option>                        
	                    <% if( role.equals("Chef Service Travaux") ) { %> 
	                    <option  value="">------------</option>
	                    <option  value="Non validé">Non validé</option>
	                    <option  value="Validé">Validé</option>	 
	                    <%} %>                                   
	                    </select>
	 <input type="date" name="dateValidationService2<%=i%>" id="dateValidationService2<%=i%>"   value="<%=tabAttachements[i].getDateValidationService() %>" size="10"/>                             
     <% if( role.equals("Chef Service Travaux") ) { %>                   
     <input type="button" class="btn btn-default4" id="validerParService<%=i%>"  value="+" size="35"/>     
     <%} %>
     </td>
     <td align="center"><select name="validerParDivision2<%=i%>"   id="validerParDivision2<%=i%>"   >	
                        <option  value="<%=tabAttachements[i].getValiderParDivision()%>"><%=tabAttachements[i].getValiderParDivision()%></option>                        
	                    <% if( role.equals("Chef Division Equipement") ) { %> 
	                    <option  value="">------------</option>
	                    <option  value="Non validé">Non validé</option>
	                    <option  value="Validé">Validé</option>	 
	                    <%} %>                                   
	                    </select>
	 <input type="date" name="dateValidationDivision2<%=i%>" id="dateValidationDivision2<%=i%>"   value="<%=tabAttachements[i].getDateValidationDivision() %>" size="10"/>                             
     <% if( role.equals("Chef Division Equipement") ) { %>                   
     <input type="button" class="btn btn-default4" id="validerParDivision<%=i%>"  value="+" size="35"/>     
     <%} %>
     </td>
     </tr>
     </table>
     <%}else{ %>
     <table   border="1" bgcolor=""  bordercolor="#000000" class="table table-hover " width="2052" > 
     <tr> 
     <th> N° d'attachement </th>
     <th> Type d'attachement </th>
     <th> Date dépôt de l'attachement </th>
     <th> Date de service fait </th>
     <th>  </th>
     <th> Copie de l'attachement </th>  
     <th>  </th>
     <th > Validation par Chef de projet </th>
     <th> Validation par Chef de service </th>
     <th> Validation par Chef de division </th>
     </tr>   
     <tr id="ligneA<%=i%>"> 
     <%if (tabAttachements[i].getNumAttachement() != 0) {	%>
     <td align="center"> <input type="number" name="numAttachement2<%=i%>" id="numAttachement2<%=i%>" class="number_input"  value="<%=tabAttachements[i].getNumAttachement()%>" width="120"/> </td> 
     <%}else  {%><td align="center"> <input type="number" name="numAttachement2<%=i%>" id="numAttachement2<%=i%>" class="number_input"  value="" width="120"/> </td><%} %>
     <td align="center"><select name="typeAttachement2<%=i%>"   id="typeAttachement2<%=i%>" >	
                        <option  value="<%=tabAttachements[i].getTypeAttachement()%>"><%=tabAttachements[i].getTypeAttachement()%></option>  
                        <option  value="">---------------------------</option>
	                    <option  value="Provisoire"> Provisoire </option>
		                <option  value="Provisoire et dérnier"> Provisoire et dérnier </option>                       
		                <option  value="Définitif"> Définitif </option>
		                <option  value="Partiel provisoire">Partiel provisoire</option>
		                <option  value="Géneral provisoire">Géneral provisoire</option>		                
		                <option  value="Partiel définitif">Partiel définitif</option>
		                <option  value="Géneral définitif">Géneral définitif</option>                                   
	                    </select>
     </td> 
     <td align="center"> <input type="date" name="dateDepotAttachement2<%=i%>" id="dateDepotAttachement2<%=i%>"   value="<%=tabAttachements[i].getDateDepotAttachement() %>" size="10"/></td>               
     <td align="center"> <input type="date" name="dateAttachement2<%=i%>" id="dateAttachement2<%=i%>"   value="<%=tabAttachements[i].getDateAttachement()%>" size="10"/></td>                            
     <td align="center"> <input type="button" id="modifierAttachement<%=i%>"  value=" + "  class="btn btn-default4" size="35"/> </td>
     <%if(!tabAttachements[i].getCopieAttachement().equals("")){  %>
     <td align="center"> <input type="button" id="exporterAttachement<%=i%>" value= " Copie de l'attachement " /> <input type="button" class="btn btn-default4" id="ajouterCopieAttachement<%=i%>"  value="+" size="35"/>   </td>          
     <%}else{ %> <td align="center">  <input type="button" class="btn btn-default4" id="ajouterCopieAttachement<%=i%>"  value="Ajouter Copie Attachement" size="35"/>  </td> <%} %>        
     <td align="center">      
     <input type="button" id="afficherAttachement<%=i%>"  value="Saisir attachement"  class="btn btn-default4" size="35"/>  
     <input type="button" id="supprimerAttachement<%=i%>" class="btn btn-default4" value="X" size="35"/> 
     </td>
     
     <td align="center"><select name="validerParChefProjet2<%=i%>"   id="validerParChefProjet2<%=i%>"   >	
                        <option  value="<%=tabAttachements[i].getValiderParChefProjet()%>"><%=tabAttachements[i].getValiderParChefProjet()%></option>                        
	                    <% if( role.equals("Chef De Projet") ) { %> 
	                    <option  value="">------------</option>
	                    <option  value="Non validé">Non validé</option>
	                    <option  value="Validé">Validé</option>	 
	                    <%} %>                                   
	                    </select>
	 <input type="date" name="dateValidationChefProjet2<%=i%>" id="dateValidationChefProjet2<%=i%>"   value="<%=tabAttachements[i].getDateValidationChefProjet() %>" size="10"/>                             
     <% if( role.equals("Chef De Projet") ) { %>                   
     <input type="button" class="btn btn-default4" id="validerParChefProjet<%=i%>"  value="+" size="35"/>     
     <%} %>
     </td>
     <td align="center"><select name="validerParService2<%=i%>"   id="validerParService2<%=i%>"   >	
                        <option  value="<%=tabAttachements[i].getValiderParService()%>"><%=tabAttachements[i].getValiderParService()%></option>                        
	                    <% if( role.equals("Chef Service Travaux") ) { %> 
	                    <option  value="">------------</option>
	                    <option  value="Non validé">Non validé</option>
	                    <option  value="Validé">Validé</option>	 
	                    <%} %>                                   
	                    </select>
	 <input type="date" name="dateValidationService2<%=i%>" id="dateValidationService2<%=i%>"   value="<%=tabAttachements[i].getDateValidationService() %>" size="10"/>                             
     <% if( role.equals("Chef Service Travaux") ) { %>                   
     <input type="button" class="btn btn-default4" id="validerParService<%=i%>"  value="+" size="35"/>     
     <%} %>
     </td>
     <td align="center"><select name="validerParDivision2<%=i%>"   id="validerParDivision2<%=i%>"   >	
                        <option  value="<%=tabAttachements[i].getValiderParDivision()%>"><%=tabAttachements[i].getValiderParDivision()%></option>                        
	                    <% if( role.equals("Chef Division Equipement") ) { %> 
	                    <option  value="">------------</option>
	                    <option  value="Non validé">Non validé</option>
	                    <option  value="Validé">Validé</option>	 
	                    <%} %>                                   
	                    </select>
	 <input type="date" name="dateValidationDivision2<%=i%>" id="dateValidationDivision2<%=i%>"   value="<%=tabAttachements[i].getDateValidationDivision() %>" size="10"/>                             
     <% if( role.equals("Chef Division Equipement") ) { %>                   
     <input type="button" class="btn btn-default4" id="validerParDivision<%=i%>"  value="+" size="35"/>     
     <%} %>
     </td>       
     </tr>
     </table>
     <%} %>
     <%} %>
         
     <%} %>
     <%} %>
  </body>
</html>