Return-Path: <netdev+bounces-21820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A87A764E51
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0661C21568
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD44D53A;
	Thu, 27 Jul 2023 08:56:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D75CFBEB
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 08:56:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0C16190
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 01:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690448167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dT8KiqSdAKXm3PcPyTMPmAVUroHS4OgGgPagioa9rwc=;
	b=h8a0j19KhLO6uu76BNQGKgX5ETKILMMoEO2DBQJMbFi9OrQz/6cyI89bRWcRz2N+ISsOMu
	YXkpbymfSav9vvlOkG8QqYvBGc3GpCQWjwNs92Shd0xjXjBGO7Lv1Gg7u0cvfQUjpXYq53
	JLQSbbFGi4WRCpCiGtRRHcO1HnY8UlI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-hNElFY8PPLSbGB_kdTaU9g-1; Thu, 27 Jul 2023 04:56:06 -0400
X-MC-Unique: hNElFY8PPLSbGB_kdTaU9g-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-403ab5a9a83so9095151cf.1
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 01:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690448165; x=1691052965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dT8KiqSdAKXm3PcPyTMPmAVUroHS4OgGgPagioa9rwc=;
        b=XCNBuf032rcFmq1k8FQCtcM0Vd9OGoyyPVTQdzm+M9YDR1cPVP4lZxE2PxfOq/f/Cr
         cj6qkwA2GxP/bM4myb48El467L5pKF8xNl7fAOhJSPOce0V9H7VR8j4BJt8sO4Wom3hi
         TnyIYFfspoakt5QwdWBb7tlgK/daNfNDSs5j63a66Bu8CVezqUrzme0S2UdVOlcsONmz
         8Jw22u7V5eL0XbNBDNlMx74NfxXDfpdtHAmaf523LO/MNzCF+Jm2TXJawcYLWFULBmZb
         ht2iMgwK4rZMQI7vWQx0T0J7S5DvrG/TrkYld8Zfi3TRvXyELc3AAt1oFFxB6o0gtxDD
         ZkZw==
X-Gm-Message-State: ABy/qLbgEGQjPHvX8aIas6suplEahqGvxgEaGdrJlv+90CXQNT08e/hW
	s8Q8Gc3WwTuy/fW5lnkMCvKdz/2kukAuTBAHTNurVbsmCNwIhc22P2f7oPoomNXyz//uStQYcgJ
	ypURM/i75AUTRT7flfAwRC6H0UIcb75yEO2aHZF/MKazMVIsTjB/kwwuICW9HKyIhCD2mVqkCqN
	du0g==
X-Received: by 2002:a05:622a:11cd:b0:3f6:c253:a738 with SMTP id n13-20020a05622a11cd00b003f6c253a738mr5410022qtk.41.1690448165052;
        Thu, 27 Jul 2023 01:56:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHacmbuek6+dje4vNU5ZeQyKfCpzl7drOLdYDJ5dSqlBr5w8sEEr4zwdluPgP1MEmFe4FpvzA==
X-Received: by 2002:a05:622a:11cd:b0:3f6:c253:a738 with SMTP id n13-20020a05622a11cd00b003f6c253a738mr5410000qtk.41.1690448164774;
        Thu, 27 Jul 2023 01:56:04 -0700 (PDT)
Received: from nfvsdn-06.redhat.com (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id f30-20020a0caa9e000000b0063612e03433sm273260qvb.101.2023.07.27.01.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:56:04 -0700 (PDT)
From: mtahhan@redhat.com
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: Maryam Tahhan <mtahhan@redhat.com>,
	Keith Wiles <keith.wiles@intel.com>
Subject: [net-next,v1 2/2] tools/net/ynl: validate config against schema
Date: Thu, 27 Jul 2023 04:55:57 -0400
Message-Id: <44bc5160d743c53d22aacf9347545b782d27bfd8.1690447762.git.mtahhan@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690447762.git.mtahhan@redhat.com>
References: <cover.1690447762.git.mtahhan@redhat.com>
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

From: Maryam Tahhan <mtahhan@redhat.com>

Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
Signed-off-by: Keith Wiles <keith.wiles@intel.com>
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
2.39.2


