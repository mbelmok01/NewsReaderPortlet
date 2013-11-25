<%--

    Licensed to Jasig under one or more contributor license
    agreements. See the NOTICE file distributed with this work
    for additional information regarding copyright ownership.
    Jasig licenses this file to you under the Apache License,
    Version 2.0 (the "License"); you may not use this file
    except in compliance with the License. You may obtain a
    copy of the License at:

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on
    an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied. See the License for the
    specific language governing permissions and limitations
    under the License.

--%>

<jsp:directive.include file="/WEB-INF/jsp/include.jsp"/>
<c:set var="n"><portlet:namespace/></c:set>

<jsp:directive.include file="/WEB-INF/jsp/scripts.jsp"/>
<script type="text/javascript"> 
	 var ${n} = ${n} || {};
    ${n}.jQuery = jQuery.noConflict(true);

    ${n}.jQuery(function() {
    
        var $ = ${n}.jQuery;

        var savePrefUrl = '<portlet:resourceURL/>';

    	var $p = $("#news-single-preference");	//find the root element of the protlet to scope dom seraches
		
		$p.find("#name").change(function(e){
    		$.post(savePrefUrl, {prefName: 'name', prefValue: $(e.target).val()});
    	});	
    	$p.find("#url").change(function(e){
    		$.post(savePrefUrl, {prefName: 'url', prefValue: $(e.target).val()});
    	});	
    	$p.find("#className").change(function(e){
    		$.post(savePrefUrl, {prefName: 'className', prefValue: $(e.target).val()});
    	});	
		
    	$p.find("#max").change(function(e){
    		$.post(savePrefUrl, {prefName: 'maxStories', prefValue: $(e.target).val()});
    	});	
    	$p.find("#view").change(function(e){
    		$.post(savePrefUrl, {prefName: 'summaryView', prefValue: $(e.target).val()});
    	});	
    	$p.find("#new-window").change(function(e){
    		prefValue = ($(e.target).attr("checked") == "checked") ? 'true' : 'false';
    		$.post(savePrefUrl, {prefName: 'newWindow', prefValue: prefValue});
    	});

    });
	 
	
 </script>

<style type="text/css" media="screen">
	.preference{
		margin:0 0 13px 13px;
	}
</style>
<div id="news-single-preference">
	<h3>Preferences</h3>
	

	<div class="preference">
		<label class="portlet-form-field-label">News feed name:</label>
		<input type="text" name="name" value="${name.value}" id="name" size="50" ${ name.readOnly ? "disabled='disabled'" : '' }>
	</div>
		
	<div class="preference">
		<label class="portlet-form-field-label">News feed URL:</label>
		<input type="text" name="url" value="${url.value}" id="url" size="50" ${ url.readOnly ? "disabled='disabled'" : '' }>
	</div>
	
	<div class="preference">
		<label class="portlet-form-field-label">News feed class:</label>		
		<input size="50" type="text" name="className" value="${className.value}" id="className"    
		       ${ className.readOnly ? "disabled='disabled'" : '' }>
	</div>
	
	<div class="preference">
		<label>Maximum number of stories to display</label>
		<select id="max" ${ max.readOnly ? "disabled='disabled'" : ''}>
			<c:forEach items="${max.options}" var="item">
				<option value="${item}" ${ item == max.value ? "selected='selected'" : '' }>
					${item}
				</option>
			</c:forEach>
		</select>
	</div>
	
	<div class="preference">
		<label>Display stories as</label>
		<select id="view" ${ view.readOnly ? "disabled='disabled'" : ''}>
			<c:forEach items="${view.options}" var="entry" >
				<option value="${entry.key}" ${entry.key == view.value ? "selected='selected'" : '' }>
					${entry.value}
				</option>
			</c:forEach>
		</select>
	</div>
	
	<div class="preference">
		<label>Open stories in new window</label>
		<input type="checkbox" name="new-window" value="" id="new-window" 
			${ newWindow.value == "true" ?  "checked='checked'" : '' } 
			${ newWindow.readOnly ? "disabled='disabled'" : '' }>
	</div>
	
	<a href="<portlet:renderURL portletMode="view"/>"><img src="<c:url value="/images/arrow_left.png"/>"> Return to feed</a>
</div>
<jsp:directive.include file="/WEB-INF/jsp/footer.jsp"/>