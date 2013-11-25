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

package org.jasig.portlet.newsreader.adapter;

import javax.portlet.PortletRequest;

import org.jasig.portlet.newsreader.NewsConfiguration;
import org.jasig.portlet.newsreader.model.NewsFeed;

/**
 * @author Anthony Colebourne
 */
public interface INewsAdapter {
    
    /**
     * Provides the fully-qualified name of the concrete INewsAdapter class, 
     * which is used in creating a {@link NewsDefinition}.
     */
    String getClassName();
    
    /**
     * Provides the key string for accessing the name of this adapter from the 
     * messageBundle bean.
     */
    String getNameKey();
    
    /**
     * Provides the key string for accessing the description of this adapter 
     * from the messageBundle bean.
     */
    String getDescriptionKey();

    NewsFeed getSyndFeed(NewsConfiguration config, PortletRequest request) throws NewsException;

}
