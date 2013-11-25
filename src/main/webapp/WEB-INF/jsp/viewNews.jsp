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

    <style>
        ul.news-stories li { padding-bottom:0.5em; list-style-image:url('<rs:resourceURL value="/rs/famfamfam/silk/1.3/bullet_feed.png"/>');  }
        .ui-tooltip {
            padding:8px;
            position:absolute;
            z-index:9999;
            -o-box-shadow: 0 0 5px #aaa;
            -moz-box-shadow: 0 0 5px #aaa;
            -webkit-box-shadow: 0 0 5px #aaa;
            box-shadow: 0 0 5px #aaa;
            max-width: 400px;
            background-color: white;
        }
        * html .ui-tooltip { background-image: none; background-color: white; }
        body .ui-tooltip { border-width:2px; }
        body .tooltip {background-color: white;}
        h4{font-size: 15; overflow: auto;}
        .panel-heading{padding-bottom: 25;}
        .ui-state-active {

        }
        .ui-state-over{

        }
    </style>
    <portlet:resourceURL var="feedUrl"/>

    <div class="org-jasig-portlet-newsreader">
        <div id="${n}">
            <div class="news-reader-feed-list portlet ptl-newsreader view-news ">
                <c:choose>
                <c:when test="${ feedView == 'select' }">
                <div class="form-group row" >
                  <div class="col-lg-3">
                      <select class="news-feeds-container form-control list-group"></select> <!-- menu deroulant --> 
                  </div>
              </div>
          </c:when>
          <c:otherwise>
          <div class="navbar navbar-default">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#"><spring:message code="edit.news.portletTitle"/></a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="news-feeds-container nav nav-tabs">
                </ul>
            </div>
        </div>
    </div>
</c:otherwise>
</c:choose>
<div class="story-container" style="display:none">
    <div class="titlebar portlet-titlebar">
        <br/>
        <a class="news-reader-back-link" href="javascript:;" data-role="button" data-icon="back" data-inline="true"><spring:message code="back" /></a>
        <h1 class="title story-title"><spring:message code="story.title" /></h1>
    </div>
    <div data-role="content" class="portlet-content">
        <div class="story-content">
        </div>
    </div>
</div>
</div>
</div>

<br/>
<p>
    <c:if test="${supportsHelp}">
    <a href="<portlet:renderURL portletMode='help'/>"><spring:message code="help" /></a>
</c:if>
<c:if test="${supportsEdit && !isGuest}">
&nbsp;|&nbsp;<a href="<portlet:renderURL portletMode='edit'/>"><spring:message code="edit.news.feed" /></a>
</c:if>
<c:if test="${isAdmin}">
&nbsp;|&nbsp;<a href="<portlet:renderURL portletMode="edit"><portlet:param name="action" value="administration"/></portlet:renderURL>">
<spring:message code="administration" /></a>
</c:if>
</p>
</div>

<!-- creation of selected menu which its sent to the drop down menu -->
<script type="text/template" id="${n}feed-list-template">
    <c:choose>
    <c:when test="${ feedView == 'select' }">
    ${"<%"} _(feeds).each(function(feed) { ${" %>"}
        <option value="${"<%="} feed.id ${"%>"}">
            ${"<%="} feed.name ${"%>"}
        </option>
        ${"<%"} }); ${"%>"}
</c:when>
<c:otherwise>
${"<%"} _(feeds).each(function(feed) { ${" %>"}
    <li ><a href="#${n}feed${"<%="} feed.id ${"%>"}">${"<%="} feed.name ${"%>"}</a></li>
    ${"<%"} }); ${"%>"}
</c:otherwise>
</c:choose>
</script>
<!-- details div
displays the title of the story in a div with titlebar portlet-titlebar css class that contains a h2 tag
-->

<script type="text/javascript" id="${n}feed-detail-template">
    <div class="titlebar portlet-titlebar">
        <div>
            <div>
                <legend class="title">${"<%= title %>"}</legend>
                <c:choose>
                    <c:when test="${ storyView == 'flyout' }">
                        <ul class="news-stories feed"> ${"<%"} _(entries).each(function(story) { ${" %>"}
                            <li>
                                <! -- // each li contains the link, with it's description and title -->
                                <a  href="${"<%="} story.link ${"%>"}"
                                    title="${"<%="} story.description ${"%>"}"
                                    ${ newWindow ? "target=\"_blank\"" : "" }>
                                    ${"<%="} story.title ${"%>"}
                                </a>
                            </li>
                            ${"<%"} }); ${"%>"}
                        </ul>
                    </c:when>
                <c:otherwise>
                    <div class="news-stories feed">
                        <div class="panel-group" >
                            ${"<%"} _(entries).each(function(story) { ${" %>"}
                                <div class="panel panel-default">
                                    <div class="panel-heading">    
                                        <h4 class="panel-title">
                                            <button type="button" style="float:right; margin: auto auto auto .5em;" class="btn btn-default btn-xs collapsed" data-toggle="collapse" data-target="#${"<%="} story.link.replace(/[^a-zA-Z\d\s]/g, "") ${"%>"}"> <spring:message code="edit.feed.read" />
                                            </button>
                                            <a  href="${"<%="} story.link ${"%>"}"
                                                title="${"<%="} story.description ${"%>"}"
                                                ${ newWindow ? "target=\"_blank\"" : "" }>
                                                ${"<%="} story.title ${"%>"}
                                            </a>
                                        </h4>
                                    </div>
                                <div id="${"<%="} story.link.replace(/[^a-zA-Z\d\s]/g, "") ${"%>"}" class="panel-collapse collapse">
                                    <div class="panel-body collapsed">
                                        ${"<%="} story.description ${"%>"}
                                    </div>
                                </div>
                            </div>
                            ${"<%"} }); ${"%>"}
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div> 
</div>
</script>

<jsp:directive.include file="/WEB-INF/jsp/scripts.jsp"/>
<script type="text/javascript">
    <rs:compressJs>
    ${n}.jQuery(function(){
        var $, _, Backbone, newsView, upnews;

        $ = ${n}.jQuery;
        _ = ${n}._;
        Backbone = ${n}.Backbone;
        upnews = ${n}.upnews;

        var adjustToolTipBasedOnSize = function () {
            <c:if test="${ storyView == 'flyout' }">
            var tooltipPosition = { offset: "15 15" , collision: "fit" }
                // If there is not enough width in the window to display as a flyout, switch to display the
                // tooltip under the news item.  Set collision to none instead of 'fit' because fit has a flickering
                // display when the tip can't cleanly display under the news item (at least with jQuery 1.8.13).
                // This is still not perfect; at least with jQuery 1.8.13 if the width of the window is small and the
                // tip flows to a smaller width, the tip can overlap the top of the news item and cause flicker if the
                // cursor is underneath the tip.
                if (window.innerWidth < 400 * 2) {
                    tooltipPosition = { my: "left bottom", at: "left top", collision: "none", offset: "0 -20"}
                }
                $(".news-stories li a").tooltip({
                    showURL: false,
                    position: tooltipPosition
                });
            </c:if>
        };
        // creation of flow list
        var DesktopNewsFeedDetailView = upnews.NewsFeedDetailView.extend({
            template: _.template($("#${n}feed-detail-template").html()),
            postRender: adjustToolTipBasedOnSize
        });

        <c:if test="${ storyView == 'flyout' }">
        $(window).resize(function() {
            $(".news-stories li a").tooltip("destroy");
            adjustToolTipBasedOnSize();
        });
    </c:if>

    var DesktopNewsFeedListView = upnews.NewsFeedListView.extend({
        el: "#${n} .news-feeds-container",
        template: _.template($("#${n}feed-list-template").html())
    });

        // modify the selected flow
        newsView = new upnews.NewsView();
        newsView.onSuccessfulSetup = function () {
            if (${ feedView  == 'select' }) {
                // set the current news feed to selected in the select menu
                $("#${n} option").removeAttr("selected");
                $("#${n} option[value=" + newsView.feedDetails.get("id") + "]").attr("selected", "selected");

                // event handler for select menu
                $("#${n} select").change(function () {
                    var id = $(this).val();
                    newsView.feedListView.trigger("feedSelected", id);
                    $("#${n} .news-stories-container").hide();
                    $("#${n}feed" + id).show();
                });
            } else {
                // compute the index of the currently selected feed
                var index = $("#${n} .news-stories-container").index($("#${n}feed" + newsView.feedDetails.get("id")));

                // initialize the jQueryUI tabs widget and set the initially
                // selected tab
                $("#${n} .view-news").tabs({
                    select: function (event, ui) {
                        var id = ui.panel.id.split("feed")[1];
                        newsView.feedListView.trigger("feedSelected", id);
                        // $("li.ui-state-default.ui-corner-top").removeClass("active");// tous les onglets sont actifs
                        // $("ui-state-default.ui-corner-top.ui-tabs-selected.ui-state-active").addClass("active");

                         // $("#${n} .news-stories-container").removeClass("active");
                         $("#${n} .news-stories-container").hide();
                         $("#${n}feed" + id).show();
                         $("#${n}feed" + id).addClass("active");
                     },
                     selected: index
                 });
            }

        };
        newsView.url = "${feedUrl}";
        newsView.feedDetailViewFn = DesktopNewsFeedDetailView;
        newsView.feedListView = new DesktopNewsFeedListView();
        newsView.namespace = "${n}";

        $(document).ready(function () {

            newsView.feedListView.bind("feedSelected", function (id) {
                if (!newsView.feedDetails || newsView.feedDetails.get("id") !== id) {
                    newsView.getFeed(id);
                }
            });

            newsView.setup();

        });

    });

</rs:compressJs></script>


<jsp:directive.include file="/WEB-INF/jsp/footer.jsp"/>
