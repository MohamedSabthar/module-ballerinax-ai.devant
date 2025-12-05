// Copyright (c) 2025 WSO2 LLC (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/ai;

# Represents chunker configuration of default devant chunker
public type DefaultChunkerConfig record {|
    # The base URL of the Devant AI service endpoint
    string serviceUrl;
    # The access token used to authenticate API requests
    string accessToken;
    # The maximum number of characters allowed per chunk
    int maxChunkSize = 500;
    # The maximum number of characters to reuse from the end of the previous
    # chunk when creating the next one
    int maxOverlapSize = 50;
    # The strategy to use for chunking the document
    ChunkStrategy strategy = RECURSIVE;
    # Additional HTTP connection configurations
    ai:ConnectionConfig connectionConfig;
|};

configurable DefaultChunkerConfig? defaultChunkerConfig = ();

isolated function init() returns error? {
    DefaultChunkerConfig? config = defaultChunkerConfig;
    if config is () {
        defaultChunker = ();
    } else {
        defaultChunker = check new (config.serviceUrl, config.accessToken,
            config.maxChunkSize, config.maxOverlapSize,
            connectionConfig = config.connectionConfig
        );
    }
}
