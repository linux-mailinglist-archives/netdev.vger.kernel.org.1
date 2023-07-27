Return-Path: <netdev+bounces-21905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B6976532D
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 14:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F4222280D9C
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 12:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC7E168D1;
	Thu, 27 Jul 2023 12:04:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A134168BC
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 12:04:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE072D54
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 05:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690459445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4cRK8aFosSp0xPRhmivUk0Jy8zSEbEAWDP8gOa7Pj1M=;
	b=ETVfhxnB6TjgTtPRz3RKjYURKyzeu868vvro8HrQhwsA7YMOfycwSKBK21zzdgpMpiVmn0
	yEINhdOAay+sg+LR0wlU9XSBNhRTQq7U3uCQO6XXcQr/S2m6KdlwWnRX2tprS1oYvK4hkz
	uXXU9BfGER7OFKyudLs5uThLQq4GoUI=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-e3s4QARzMWOYaUiTxtyvxw-1; Thu, 27 Jul 2023 08:04:03 -0400
X-MC-Unique: e3s4QARzMWOYaUiTxtyvxw-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6b9cf208fb5so1509634a34.3
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 05:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690459442; x=1691064242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cRK8aFosSp0xPRhmivUk0Jy8zSEbEAWDP8gOa7Pj1M=;
        b=OguUPFzScJWmx2O0mY0Nv3rxp6AMJ8yDR5EXiZpC2Zy2ADmhu+3fONJvvAqC+5VHT9
         CabhVGoAvjf2iLJSlVrNKZ2/rjcRLWVv+2cLqjsOlvcP5PzbTt7sz1+H1F6O0YOKetCB
         oAP6VsyYs6qe3MgGPESopV2AGbRXJ7+LJL4w94xOcA0IuzvoZM3/2lXFInHUy5KGhwo0
         WzXyzS/QXciMoKZMGBCjL70HuQSEMpfArZBjPylguYnKZQwkRKbZZkkQAbMedKYNCPTI
         bw5wmDArzCJbEntzQgSCeI2BmPe849P9y1tG6a1EhfEoCK7plZ7Tcjnp+cuvULc8sPla
         dswA==
X-Gm-Message-State: ABy/qLZ8NPxiCEpsPh5Q/Zkv19mqyQft+mtTqZPf3745BZsmQjZlf6wW
	KjKD5XMPoGU1Oc3HwjuVBGMtW+4uh16pYVx/u50CBFEvxH7i4dfJEqC1ID8c0TWbbwzti/it03R
	PsnKU7K775H4So8gUj1y5oWFoSX0pziWvqsSjYTlxtmojFyJRdjyCcIupoBMIzYpHHcn9pyLqYQ
	mi6Q==
X-Received: by 2002:a9d:7556:0:b0:6b9:c51c:f4d5 with SMTP id b22-20020a9d7556000000b006b9c51cf4d5mr5308668otl.10.1690459442485;
        Thu, 27 Jul 2023 05:04:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlECRLCunbtl3no5N7wifKjiPAYFp/yF2j2yZpTn/OobhnFozPl9/IEnck6syOmL7DnRdM/BpQ==
X-Received: by 2002:a9d:7556:0:b0:6b9:c51c:f4d5 with SMTP id b22-20020a9d7556000000b006b9c51cf4d5mr5308634otl.10.1690459442199;
        Thu, 27 Jul 2023 05:04:02 -0700 (PDT)
Received: from nfvsdn-06.redhat.com (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id t1-20020a0ca681000000b006262e5c96d0sm369295qva.129.2023.07.27.05.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 05:04:01 -0700 (PDT)
From: Maryam Tahhan <mtahhan@redhat.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	Maryam Tahhan <mtahhan@redhat.com>,
	Keith Wiles <keith.wiles@intel.com>
Subject: [PATCH net-next v2 2/2] tools/net/ynl: validate config against schema
Date: Thu, 27 Jul 2023 08:03:31 -0400
Message-ID: <20230727120353.3020678-3-mtahhan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727120353.3020678-1-mtahhan@redhat.com>
References: <20230727120353.3020678-1-mtahhan@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Validate the provided configuration file against
the ynl-config.schema.

Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
Signed-off-by: Keith Wiles <keith.wiles@intel.com>
Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
---
 tools/net/ynl/cli.py            | 43 ++++++++++++++++----
 tools/net/ynl/ynl-config.schema | 72 +++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 7 deletions(-)
 create mode 100644 tools/net/ynl/ynl-config.schema

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index 1749851f8460..3071ef9e3117 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -9,6 +9,12 @@ import os
 
 from lib import YnlFamily
 
+try:
+    import jsonschema
+except ModuleNotFoundError as e:
+    print('Error: {}. Try `pip install jsonschema`'.format(e))
+    raise SystemExit(1)
+
 class ynlConfig():
     def __init__(self):
         self.no_schema = True
@@ -66,13 +72,36 @@ def main():
     if args.config:
         directory = ""
         yamls = {}
-
-        if not os.path.exists(args.config):
-             print("Error: ", args.config, " doesn't exist")
-             exit(-1)
-
-        f = open(args.config)
-        data = json.load(f)
+        configSchema = os.path.dirname(__file__) + "/ynl-config.schema"
+
+        # Load ynl-config json schema
+        try:
+            with open(configSchema, 'r') as f:
+                s = json.load(f)
+        except FileNotFoundError as e:
+            print('Error:', e)
+            raise SystemExit(1)
+        except json.decoder.JSONDecodeError as e:
+            print('Error: {}:'.format(args.schema), e)
+            raise SystemExit(1)
+
+        # Load config file
+        try:
+            with open(args.config, 'r') as f:
+                data = json.load(f)
+        except FileNotFoundError as e:
+            print('Error:', e)
+            raise SystemExit(1)
+        except json.decoder.JSONDecodeError as e:
+            print('Error: {}:'.format(args.schema), e)
+            raise SystemExit(1)
+
+        # Validate json config against the ynl-config schema
+        try:
+            jsonschema.validate(instance=data, schema=s)
+        except jsonschema.exceptions.ValidationError as e:
+            print('Error:', e)
+            raise SystemExit(1)
 
         for k in data:
             if k == 'yaml-specs-path':
diff --git a/tools/net/ynl/ynl-config.schema b/tools/net/ynl/ynl-config.schema
new file mode 100644
index 000000000000..c127e2acbabb
--- /dev/null
+++ b/tools/net/ynl/ynl-config.schema
@@ -0,0 +1,72 @@
+{
+    "$schema": "https://json-schema.org/draft-07/schema",
+    "description": "YNL specs configuration file",
+    "type": "object",
+
+    "properties": {
+        "yaml-specs-path": {
+            "description": "Path to Yaml specs",
+            "type": "string"
+        },
+        "spec-args": {
+            "description": "Individual spec args",
+            "type": "object",
+            "patternProperties": {
+                "^.*(\\.yaml)$": {
+                    "description": "Specific yaml spec arguments",
+                    "type": "object",
+                    "properties": {
+                        "schema": {
+                            "description": "The schema to use",
+                            "type": "string"
+                        },
+                        "no-schema": {
+                            "description": "No schema",
+                            "type": "boolean",
+                            "default": true
+                        },
+                        "do": {
+                            "description": "The do function to use",
+                            "type": "string"
+                        },
+                        "dump": {
+                            "description": "The dump function to use",
+                            "type": "string"
+                        },
+                        "subscribe": {
+                            "description": "The multicast group to subscribe to",
+                            "type": "string"
+                        },
+                        "sleep": {
+                            "description": "The number to seconds to sleep",
+                            "type": "number",
+                            "default": 0
+                        },
+                        "json-params": {
+                            "description": "The json params to use for different functions",
+                            "type": "object",
+                            "patternProperties": {
+                                "^.*$": {
+                                  "type": ["string", "number", "object"],
+                                  "patternProperties": {
+                                        "^.*$": {
+                                        "type": ["string", "number"]
+                                        }
+                                    },
+                                    "additionalProperties": false
+                                }
+                            }
+                        },
+                        "additionalProperties": false
+                    },
+                    "additionalProperties": false
+                }
+            },
+            "additionalProperties": false
+        }
+    },
+    "additionalProperties": false,
+    "required": [
+        "yaml-specs-path"
+    ]
+}
-- 
2.41.0


