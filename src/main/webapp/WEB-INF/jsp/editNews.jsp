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

    <style type="text/css">
        table.edit-news { width: 100%; }
        table.edit-news td { font-size: 1.1em; }
        table.edit-news td.instruction { color: #666; font-size: 1em; text-align: center; vertical-align: bottom; }
        label{text-align: left; width: auto; padding-top: 7;}
    </style>

    <jsp:directive.include file="/WEB-INF/jsp/scripts.jsp"/>
    <script type="text/javascript">

//alert($("div.portlet").innerWidth());

<rs:compressJs>
${n}.jQuery(function(){

    var $ = ${n}.jQuery;
    
    var savePrefUrl = '<portlet:resourceURL/>';
    
    $('#${n}maxStories').change(function(){
        $.post(savePrefUrl, { prefName: 'maxStories', prefValue: $('#${n}maxStories').val() }, null, 'json');
    });
    $('#${n}feedView').change(function(){
        $.post(savePrefUrl, { prefName: 'feedView', prefValue: $('#${n}feedView').val() }, null, 'json');
    });
    $('#${n}storyView').change(function(){
        $.post(savePrefUrl, { prefName: 'summaryView', prefValue: $('#${n}storyView').val() }, null, 'json');
    });
    $("#${n}newWindow").change(function(e){
        $.post(savePrefUrl, { prefName: 'newWindow', prefValue: ($(e.target).attr("checked") == 'checked') }, null, 'json');
    });

});
</rs:compressJs></script>


<portlet:actionURL var="postUrl"></portlet:actionURL>


<h3><spring:message code="edit.title"/></h3>
<div class="table-responsive">
<table class="table">
    <thead>
        <tr>
            <th><spring:message code="edit.news.name"/></th>
            <th><spring:message code="edit.news.edit"/></th>
            <th><spring:message code="edit.news.delete"/></th>
            <th><spring:message code="edit.news.displayed"/></th>
        </tr>
    </thead>
    <tbody>
         <c:forEach items="${ model.myNewsConfigurations }" var="feed">
            <tr>
                <td> 
                    ${ feed.newsDefinition.name }
                </td>
                <td class="instruction">
                    <a href="<portlet:renderURL><portlet:param name="action" value="editUrl"/>
                        <portlet:param name="id" value="${ feed.id }"/></portlet:renderURL>"
                        title="<spring:message code="edit.feed.edit"/>">
                        <img alt="edit" src="<c:url value="/images/pencil.png"/>"/>
                    </a>
                </td>
                <td class="instruction">
                    <a href="<portlet:actionURL><portlet:param name="actionCode" value="delete"/>
                        <portlet:param name="id" value="${ feed.id }"/></portlet:actionURL>"
                        title="<spring:message code="edit.feed.delete"/>">
                        <img alt="delete" src="<c:url value="/images/rss_delete.png"/>"/>
                    </a>
                </td>
                <td class="instruction">
                    <c:choose>
                        <c:when test="${ feed.displayed }">
                            <portlet:actionURL var="displayURL"><portlet:param name="actionCode" value="hide"/>
                            <portlet:param name="id" value="${ feed.id }"/></portlet:actionURL>
                    
                            <a href="${ displayURL }" title="<spring:message code="edit.feed.hide"/>">
                                <img alt="show" src="<c:url value="/images/select-active.gif"/>"/>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <portlet:actionURL var="displayURL"><portlet:param name="actionCode" value="show"/><portlet:param name="id" value="${ feed.id }"/></portlet:actionURL>
                            <a href="${ displayURL }" title="<spring:message code="edit.feed.show"/>">
                                <img alt="show" src="<c:url value="/images/select-inactive.gif"/>"/>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
</div>
<p>
    <a href="<portlet:renderURL><portlet:param name="action" value="editUrl"/></portlet:renderURL>">
        <img src="<c:url value="/images/rss_add.png"/>" style="vertical-align: middle"/>
        <spring:message code="edit.news.add"/>
    </a>
</p>


<h3><spring:message code="edit.news.exist"/></h3>

<div class="table-responsive">
    <table class="table">
        <thead>
            <tr>
                <th><spring:message code="edit.news.name"/></th>
                <th><spring:message code="edit.news.displayed"/></th>
                <th colspan=""></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${ model.predefinedNewsConfigurations }" var="feed">
                <tr>
                    <td>
                        ${ feed.newsDefinition.name }
                    </td>

                    <td class="instruction">
                        <c:choose>
                            <c:when test="${ feed.displayed }">
                                <portlet:actionURL var="displayURL"><portlet:param name="actionCode" value="hide"/>
                                <portlet:param name="id" value="${ feed.id }"/></portlet:actionURL>
                                <a href="${ displayURL }" title="Hide feed">
                                    <img alt="show" src="<c:url value="/images/select-active.gif"/>"/>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <portlet:actionURL var="displayURL"><portlet:param name="actionCode" value="show"/>
                                <portlet:param name="id" value="${ feed.id }"/></portlet:actionURL>
                                <a href="${ displayURL }" title="Show feed">
                                    <img alt="show" src="<c:url value="/images/select-inactive.gif"/>"/>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>

            <c:forEach items="${ model.hiddenFeeds }" var="feed">
                <tr>
                    <td>
                        ${ feed.name }
                    </td>
                    <td class="instruction">
                        <portlet:actionURL var="displayURL">
                            <portlet:param name="actionCode" value="showNew"/><portlet:param name="id" value="${ feed.id }"/></portlet:actionURL>
                        <a href="${ displayURL }" title="Show feed">
                            <img alt="show" src="<c:url value="/images/select-inactive.gif"/>"/>
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<p>
    <a href="<portlet:renderURL><portlet:param name="action" value="editNewsDefinition"/></portlet:renderURL>">
        <img src="<c:url value="/images/rss_add.png"/>" style="vertical-align: middle"/>
        <spring:message code="edit.news.add"/>
    </a>
</p>


<h3><spring:message code="edit.news.pref"/></h3>
<div>
    <div>
        <label for="${n}maxStories"><spring:message code="edit.news.maxstories"/></label>

        <c:set var="maxStories" value="${renderRequest.preferences.map['maxStories'][0]}"/>
        <div class="form-group row" >
            <div class="col-lg-2 col-md-2 col-sm-4 col-xs-12">
                <select class="form-control" id="${n}maxStories">
                    <option ${ maxStories == 5 ? 'selected="selected"' : '' }>${5}</option>
                    <option ${ maxStories == 10 ? 'selected="selected"' : '' }>${10}</option>
                    <option ${ maxStories == 15 ? 'selected="selected"' : '' }>${15}</option>
                    <option ${ maxStories == 20 ? 'selected="selected"' : '' }>${20}</option>
                </select>
            </div>
        </div>
    </div>

    <div>
        <label for="${n}feedView"><spring:message code="edit.news.feedView"/></label>
        <c:set var="feedView" value="${renderRequest.preferences.map['feedView'][0]}"/>
        <div class="form-group row">
            <div class="col-lg-2 col-md-2 col-sm-4 col-xs-12">
                <select class="form-control"  id="${n}feedView">
                    <option value="tabs" ${ feedView == 'tabs' ? 'selected="selected"' : '' }><spring:message code="edit.news.feedView.tab"/></option>
                    <option value="select" ${ feedView == 'select' ? 'selected="selected"' : '' }><spring:message code="edit.news.feedView.menu"/></option>
                </select>
            </div>
        </div>
    </div>
    

    <div>
        <label for="${n}storyView"><spring:message code="edit.news.storyview"/></label>
        <c:set var="storyView" value="${renderRequest.preferences.map['summaryView'][0]}"/>
        <div class="form-group row" >
            <div class="col-lg-2 col-md-2 col-sm-4 col-xs-12">
                <select class="form-control" id="${n}storyView">
                    <option value="flyout" ${ storyView == 'flyout' ? 'selected="selected"' : '' }><spring:message code="edit.news.storyview.flyout"/>
                    </option>
                    <option value="summaries" ${ storyView == 'summaries' ? 'selected="selected"' : '' }><spring:message code="edit.news.storyview.scrolldiv"/>
                    </option>
                </select>
            </div>
        </div>
    </div>

    <p>
        <label for="${n}newWindow" style="padding-top:0"><spring:message code="edit.news.newwindows"/></label>
        <c:set var="newWindow" value="${renderRequest.preferences.map['newWindow'][0]}"/>
        <div class="form-group row">
            <div class="col-lg-1 col-md-1 col-sm-1 col-xs-2">
                <input type="checkbox" id="${n}newWindow" ${ newWindow == "true" ? "checked='checked'" : ""} />
            </div>
        </div>
    </p>
</div>

<p>
    <a href="<portlet:renderURL portletMode="help"/>">
        <spring:message code="help.need"/>
    </a>
</p>

<br />
<hr />
<p>
    <a href="<portlet:renderURL portletMode="view"/>"><img src="<c:url value="/images/arrow_left.png"/>" style="vertical-align: middle"><spring:message code="back.list"/></a>
</p>

<jsp:directive.include file="/WEB-INF/jsp/footer.jsp"/>