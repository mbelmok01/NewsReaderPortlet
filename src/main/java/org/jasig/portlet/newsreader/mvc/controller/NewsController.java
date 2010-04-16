/**
 * Licensed to Jasig under one or more contributor license
 * agreements. See the NOTICE file distributed with this work
 * for additional information regarding copyright ownership.
 * Jasig licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a
 * copy of the License at:
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on
 * an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package org.jasig.portlet.newsreader.mvc.controller;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.portlet.PortletPreferences;
import javax.portlet.PortletSession;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jasig.portlet.newsreader.dao.NewsStore;
import org.jasig.portlet.newsreader.service.IInitializationService;
import org.springframework.web.portlet.ModelAndView;
import org.springframework.web.portlet.mvc.ParameterizableViewController;

/*
 * @author Anthony Colebourne
 */
public class NewsController extends ParameterizableViewController {

    private static Log log = LogFactory.getLog(NewsController.class);

    public ModelAndView handleRenderRequestInternal(RenderRequest request,
                                                    RenderResponse response) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();
        PortletSession session = request.getPortletSession(true);

        /**
         * If this is a new session, perform any necessary
         * portlet initialization.
         */
        if (session.getAttribute("initialized") == null) {

            // get a set of all role names currently configured for
            // default newss
            List<String> allRoles = newsStore.getUserRoles();
            log.debug("all roles: " + allRoles);

            // determine which of the above roles the user belongs to
            // and store the resulting list in the session
            Set<String> userRoles = new HashSet<String>();
            for (String role : allRoles) {
                if (request.isUserInRole(role))
                    userRoles.add(role);
            }
            session.setAttribute("userRoles", userRoles, PortletSession.PORTLET_SCOPE);

            // determine if this user belongs to the defined news
            // administration group and store the result in the session
            session.setAttribute("isAdmin",
                    request.isUserInRole("newsAdmin"),
                    PortletSession.PORTLET_SCOPE);

            // set the default number of days to display
            session.setAttribute("items", defaultItems);

            // perform any other configured initialization tasks
            for (IInitializationService service : initializationServices) {
                service.initialize(request);
            }

            // mark this session as initialized
            session.setAttribute("initialized", "true");
            session.setMaxInactiveInterval(60 * 60 * 2);

        } 

        model.put("isAdmin", (Boolean) session.getAttribute("isAdmin", PortletSession.PORTLET_SCOPE));
        
        log.debug("forwarding to " + getViewName());
        return new ModelAndView(getViewName(), "model", model);
    }

    private NewsStore newsStore;
    public void setNewsStore(NewsStore newsStore) {
        this.newsStore = newsStore;
    }
    
    private int defaultItems = 2;
    public void setDefaultItems(int defaultItems) {
        this.defaultItems = defaultItems;
    }

    private List<IInitializationService> initializationServices;
    public void setInitializationServices(List<IInitializationService> services) {
        this.initializationServices = services;
    }
}

/*
* NewsController.java
*
* Copyright (c) April 17, 2008 The University of Manchester. All rights reserved.
*
* THIS SOFTWARE IS PROVIDED "AS IS," AND ANY EXPRESS OR IMPLIED WARRANTIES,
* INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
* FITNESS FOR A PARTICULAR PURPOSE, ARE EXPRESSLY DISCLAIMED. IN NO EVENT SHALL
* MANCHESER UNIVERSITY OR ITS EMPLOYEES BE LIABLE FOR ANY DIRECT, INDIRECT,
* INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
* LIMITED, THE COSTS OF PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
* USE, DATA OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
* THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED IN ADVANCE OF THE POSSIBILITY OF SUCH DAMAGE.
*
* Redistribution and use of this software in source or binary forms, with or
* without modification, are permitted, provided that the following conditions
* are met.
*
* 1. Any redistribution must include the above copyright notice and disclaimer
* and this list of conditions in any related documentation and, if feasible, in
* the redistributed software.
*
* 2. Any redistribution must include the acknowledgment, "This product includes
* software developed by The University of Manchester," in any related documentation and, if
* feasible, in the redistributed software.
*
* 3. The names "Manchester University" and "The University of Manchester" must not be used to endorse or
* promote products derived from this software.
*/