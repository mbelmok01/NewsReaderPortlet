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
<style type="text/css">
.input-medium { border-radius: 5; background-color:#DFEFFF; width: 55%}
input {margin: auto; display: inline;}
.form-control {width: 55%}
label{text-align: left;width: auto}


</style>
<jsp:directive.include file="/WEB-INF/jsp/include.jsp"/>

<portlet:actionURL var="postUrl"><portlet:param name="action" value="editUrl"/></portlet:actionURL>

<legend><spring:message code="edit.news.feed.edit"/></legend>

<form:form name="news" commandName="newsListingCommand" class="form-horizontal"  action="${postUrl}">
    <fieldset>
        <form:hidden path="id" />

            <div class="control-group">
                <label class="control-label" /*style="padding-top:0px;"*/ for="textinput">
                    <spring:message code="edit.news.feed.name"/>
                </label>
                <div class="controls">
                    <form:input path="name" placeholder="Le monde" class="form-control" style="width:55%" size="50"/>
                    <form:errors path="name" cssClass="portlet-msg-error"/>
                </div>
            </div>
            <br/>

            <div class="control-group">
                <label class="control-label" /*style="padding-top:0px;"*/ for="textinput">
                    <spring:message code="edit.news.feed.url"/>
                </label>
                <div class="controls">
                    <form:input path="url" placeholder="http://www.lemonde.fr/rss/une.xml" class="form-control" style="width:55%" size="50" />
                    <form:errors path="url" cssClass="portlet-msg-error"/>
                </div>
            </div>
            
            <br/>

            <div>
                <spring:message code="edit.news.feed.note"/>
            </div>

            <br/>
            
            <div class="control-group">
                <label class="control-label" ></label>
                <div class="controls">
                    <button type="submit" class="btn btn-primary" style="border-radius=5;">
                        <spring:message code="edit.news.feed.sav"/>
                    </button>
                </div>
            </div>
    </fieldset>
</form:form>

<p>
        <a href="<portlet:renderURL><portlet:param name="action" value="editPrefences"/></portlet:renderURL>"><img src="<c:url value="/images/arrow_left.png"/>" style="vertical-align: middle"><spring:message code="edit.news.feed.back"/></a>
</p>

<jsp:directive.include file="/WEB-INF/jsp/footer.jsp"/>