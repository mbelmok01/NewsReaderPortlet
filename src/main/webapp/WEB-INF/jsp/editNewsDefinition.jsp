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

<script type="text/javascript"><rs:compressJs>
	function addRole(id) {
		var div = document.getElementById(id);
		var container = document.createElement('div');
		container.style.padding = "5px";
		var input = document.createElement('input');
		input.name = 'role';
		input.type = 'text';
		input.size = '20';
		input.style.marginLeft= '35px';
		input.style.backgroundColor= '#ffffff';
		input.style.backgroundImage='none';
		input.style.border='1px solid #cccccc';
		input.style.borderRightColor ='rgb(204, 204, 204)'; 
		input.style.borderRadius='4px';
		container.appendChild(input);
		var remove = document.createElement('a');
		remove.href = 'javascript:;';
		remove.onclick = function(){removeRole(this)};
		remove.appendChild(document.createTextNode(' '));
		var img = document.createElement('img');
		img.src = '<c:url value="/images/delete.png"/>';
		img.style.verticalAlign = 'middle';
		remove.appendChild(img);
		container.appendChild(remove);
		div.appendChild(container);
	}
	
	function removeRole(link) {
		var div = link.parentNode;
		div.parentNode.removeChild(div);
	}

	function addParameter(id) {
		var div = document.getElementById(id);
		var container = document.createElement('div');
		container.style.padding = "5px";
		var input = document.createElement('input');
		input.name = 'parameterName';
		input.type = 'text';
		input.size = '20';
		input.style.marginLeft= '35px';
		input.style.backgroundColor= '#ffffff';
		input.style.backgroundImage='none';
		input.style.border='1px solid #cccccc';
		input.style.borderRightColor ='rgb(204, 204, 204)'; 
		input.style.borderRadius='4px';
		container.appendChild(input);
		input = document.createElement('input');
		input.name = 'parameterValue';
		input.type = 'text';
		input.size = '20';
		input.style.marginLeft= '35px';
		input.style.backgroundColor= '#ffffff';
		input.style.backgroundImage='none';
		input.style.border='1px solid #cccccc';
		input.style.borderRightColor ='rgb(204, 204, 204)'; 
		input.style.borderRadius='4px';

		container.appendChild(input);
		var remove = document.createElement('a');
		remove.href = 'javascript:;';
		remove.onclick = function(){removeRole(this)};
		remove.appendChild(document.createTextNode(' '));
		var img = document.createElement('img');
		img.src = '<c:url value="/images/delete.png"/>';
		img.style.verticalAlign = 'middle';
		remove.appendChild(img);
		container.appendChild(remove);
		div.appendChild(container);
	}

	function removeParameter(link) {
		var div = link.parentNode;
		div.parentNode.removeChild(div);
	}
</rs:compressJs></script>
<style type="text/css">
	label {
		width: auto
	}
</style>

<portlet:actionURL var="postUrl"><portlet:param name="action" value="editNewsDefinition"/></portlet:actionURL>

<h3>
	<spring:message code="edit.news.feed.edit"/>
</h3>

<form:form name="news" commandName="newsDefinitionForm" action="${postUrl}">
	<form:hidden path="id"/>
		
		<div class="row">
			<div class="col-lg-2">
				<label>
					<spring:message code="edit.news.feed.name"/>
				</label>
			</div>
			<div class="col-lg-8 col-md-8 col-sm-6 col-xs-12">
				<form:input path="name" class="form-control" size="50"/>
				<form:errors path="name" cssClass="portlet-msg-error has-error"/>
			</div>
		</div>
		<br/>
   		<div class="row">
        	<div class="col-lg-2">
    	    	<label class="portlet-form-field-label">
        			<spring:message code="edit.news.feed.url"/>
        		</label>
        	</div>
        	<div class="col-lg-8 col-md-8 col-sm-6 col-xs-12">
        		<form:select path="className" class="form-control">
            		<c:forEach items="${availableAdapters}" var="adapter">
                		<c:set var="adapterName"><spring:message code="${adapter.nameKey}"/></c:set>
                		<c:set var="adapterDescription"><spring:message code="${adapter.descriptionKey}"/></c:set>
                		<form:option value="${adapter.className}" label="${adapterName}" title="${adapterDescription}" />
            		</c:forEach>
        		</form:select>
        		<form:errors path="className" cssClass="portlet-msg-error"/>
        	</div>
        	<br/>

        	<div id="role-list" class="row">
				<div class="col-lg-12" style="margin-left:15px;">
				<label class="portlet-form-field-label">
					<spring:message code="edit.news.feed.roles"/>
				</label>
				<br/>
				<c:forEach items="${ newsDefinitionForm.role }" var="role">
					<div style="padding-left: 5px;">
						<a href="javascript:;" onclick="removeRole(this)">
							<img style="vertical-align: middle;" src="<c:url value="/images/delete.png"/>"/>
						</a>
						<input name="role" type="text" class="control-form" value="${ role }" size="20"/>
					</div>
				</c:forEach>
				<div style="padding: 5px;">
					<a href="javascript:;" onclick="addRole('role-list')">
						<img style="vertical-align: middle;" src="<c:url value="/images/add.png"/>"/>
						<spring:message code="edit.news.feed.roles.add"/>
					</a>
				</div>
				</div>
			</div>


			<div id="parameter-list" class="row">
				<div class="col-lg-12" style="margin-left:15px;">
				<label class="portlet-form-field-label">
					<spring:message code="edit.news.feed.param"/>
				</label>
				<br />
				<c:forEach items="${ newsDefinitionForm.parameterName }" var="paramName" varStatus="status">
					<div style="padding-left: 5px">
						<form class="form-inline" role="form">
							<div class="form-group">
								<input name="parameterName" id="id1" type="text" value="${ paramName }" size="20"/>
									<input name="parameterValue"  type="text" value="${ newsDefinitionForm.parameterValue[status.index] }" size="20"/>
								<a href="javascript:;" onclick="removeParameter(this)">
									<img style="vertical-align: middle;" src="<c:url value="/images/delete.png"/>"/>
								</a>
							</div>
						</form>
					</div>
				</c:forEach>
				<div style="padding: 5px;">
					<a href="javascript:;" onclick="addParameter('parameter-list')">
						<img style="vertical-align: middle;" src="<c:url value="/images/add.png"/>"/>
						<spring:message code="edit.news.feed.param.add"/>
					</a>
				</div>
				</div>
			</div>

			<div>
        		<button type="submit" class="btn btn-primary" style="margin-left: 15;">
        			<spring:message code="edit.news.feed.sav"/>
        		</button>
        	</div>
        </form:form>
        <br />
       <hr />

       <div class="row">
       	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
       	<p style="margin-left:15px">
       		<a href="<portlet:renderURL><portlet:param name="action" value="administration"/></portlet:renderURL>"><img src="<c:url value="/images/arrow_left.png"/>" style="vertical-align: middle"> <spring:message code="administration.feed.back"/>
       	</a>
       	</p>
       	</div>

       </div>
<jsp:directive.include file="/WEB-INF/jsp/footer.jsp"/>