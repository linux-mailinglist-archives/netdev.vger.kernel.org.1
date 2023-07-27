Return-Path: <netdev+bounces-21819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2338764E4C
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D8F1C21524
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B828D537;
	Thu, 27 Jul 2023 08:56:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B518F9D6
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 08:56:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B1D5B9C
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 01:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690448165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6N7d7m6eP20y086F5lMH+wTdhRakZLOgBuuEJrsibs=;
	b=DlJ1KLy3hJGWHY9hThW8Yp+V1CLaeHICB33o9zeEzp0ddwOyEUnlYOUzhHbSlg9KZqRFJq
	aJzBSC/mpFopOBq5YqOlaLgW/VaWM3iRAq93J4Z7RrIv+92e8g8Lh70oRU9Wrx9Hcq7xd+
	41g2YwwxjA5Lq4nkBXs7QbIwdUCxak8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-HCneX955NkSKsrdQQH2Kcw-1; Thu, 27 Jul 2023 04:56:04 -0400
X-MC-Unique: HCneX955NkSKsrdQQH2Kcw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62de65b3a5bso9735276d6.2
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 01:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690448163; x=1691052963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6N7d7m6eP20y086F5lMH+wTdhRakZLOgBuuEJrsibs=;
        b=djht4OX6x34f20KOTuhdmEmhQkZ42/wtXcUXMe8uCVj3ldTdJEXj7cxkF8HtzRTqR5
         QaMOhSHh1Y0XzhPyffRDGEiX+3fZhUrWnphE8WkS7CpPzz+0VNYUC/dXezzhb26lYSOI
         DtjUGZcLWjaIy4n1mKLFJ5j88+7dnQaBtEIxlm+EUR7NuSWbRU/MOiJlrVcis5uAg9zc
         R8hFpPFR2ahkhIm6me30cTYOz1yVwOsLgHLnfTUM7Kvccgq3cGcP7PR4Uf8pQP4FnxWK
         k+yj2vdEl2Qe5PjkulDaLApOIGNsXfOsZEwkJEY7rYxkhy0hqh9RtkPrbcUPriJbGMEQ
         73hA==
X-Gm-Message-State: ABy/qLYQwyry4uQST2tCb7hdFWwQmOpBEI7X5GHR2BJVxvO4FgRolGTT
	j47x/aN5Q5CaFbYNbrnIlTlcVfwyB8wDtaYdQIYbmLl93jUs2DMKv5m3NYAQaFzCaEVx7t5Rsv6
	CCbT1CdaUNnirSll9JZOr7x60rg2dFjhyEthEqYepTbAR2lK5n1vielVzYkzVGXyJ851WXr5m4L
	uuAg==
X-Received: by 2002:a0c:f1ca:0:b0:63c:6efe:ffb0 with SMTP id u10-20020a0cf1ca000000b0063c6efeffb0mr860299qvl.65.1690448162996;
        Thu, 27 Jul 2023 01:56:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFCGkroEXOcmxa3jtALE7rlHlyJVxVQUUgxyFSbGOCwON/e1wr02GYADddQlpjgrAyzmD/60w==
X-Received: by 2002:a0c:f1ca:0:b0:63c:6efe:ffb0 with SMTP id u10-20020a0cf1ca000000b0063c6efeffb0mr860284qvl.65.1690448162740;
        Thu, 27 Jul 2023 01:56:02 -0700 (PDT)
Received: from nfvsdn-06.redhat.com (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id f30-20020a0caa9e000000b0063612e03433sm273260qvb.101.2023.07.27.01.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:56:02 -0700 (PDT)
From: mtahhan@redhat.com
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: Maryam Tahhan <mtahhan@redhat.com>
Subject: [net-next,v1 1/2] tools/net/ynl: configuration through json
Date: Thu, 27 Jul 2023 04:55:56 -0400
Message-Id: <5fe9a6d2a6bf97f470281162ccb73558416ac7c9.1690447762.git.mtahhan@redhat.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Maryam Tahhan <mtahhan@redhat.com>

Enable YNL configuration through a json file alongside the
current commandline arguments. This will allow one to cycle
through multiple specs and commands at once.

Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
---
 tools/net/ynl/cli.py | 108 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 87 insertions(+), 21 deletions(-)

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index ffaa8038aa8c..1749851f8460 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -5,13 +5,54 @@ import argparse
 import json
 import pprint
 import time
+import os
 
 from lib import YnlFamily
 
+class ynlConfig():
+    def __init__(self):
+        self.no_schema = True
+        self.schema = None
+        self.spec = None
+        self.json_text = None
+        self.ntf = None
+        self.sleep = None
+        self.do = None
+        self.dump = None
+    def run(self):
+        ynl_cfg(self.no_schema, self.spec, self.schema, self.json_text, self.ntf, self.sleep, self.do, self.dump)
+
+def ynl_cfg(no_schema, spec, schema, json_text, ntf, sleep, do, dump):
+
+        if no_schema:
+            schema = ''
+
+        attrs = {}
+        if json_text:
+            attrs = json.loads(json_text)
+
+        ynl = YnlFamily(spec, schema)
+
+        if ntf:
+            ynl.ntf_subscribe(ntf)
+
+        if sleep:
+            time.sleep(sleep)
+
+        if do:
+            reply = ynl.do(do, attrs)
+            pprint.PrettyPrinter().pprint(reply)
+        if dump:
+            reply = ynl.dump(dump, attrs)
+            pprint.PrettyPrinter().pprint(reply)
+
+        if ntf:
+            ynl.check_ntf()
+            pprint.PrettyPrinter().pprint(ynl.async_msg_queue)
 
 def main():
     parser = argparse.ArgumentParser(description='YNL CLI sample')
-    parser.add_argument('--spec', dest='spec', type=str, required=True)
+    parser.add_argument('--spec', dest='spec', type=str)
     parser.add_argument('--schema', dest='schema', type=str)
     parser.add_argument('--no-schema', action='store_true')
     parser.add_argument('--json', dest='json_text', type=str)
@@ -19,34 +60,59 @@ def main():
     parser.add_argument('--dump', dest='dump', type=str)
     parser.add_argument('--sleep', dest='sleep', type=int)
     parser.add_argument('--subscribe', dest='ntf', type=str)
+    parser.add_argument('--config', dest='config', type=str)
     args = parser.parse_args()
 
-    if args.no_schema:
-        args.schema = ''
-
-    attrs = {}
-    if args.json_text:
-        attrs = json.loads(args.json_text)
+    if args.config:
+        directory = ""
+        yamls = {}
 
-    ynl = YnlFamily(args.spec, args.schema)
+        if not os.path.exists(args.config):
+             print("Error: ", args.config, " doesn't exist")
+             exit(-1)
 
-    if args.ntf:
-        ynl.ntf_subscribe(args.ntf)
+        f = open(args.config)
+        data = json.load(f)
 
-    if args.sleep:
-        time.sleep(args.sleep)
+        for k in data:
+            if k == 'yaml-specs-path':
+                directory = data[k]
 
-    if args.do:
-        reply = ynl.do(args.do, attrs)
-        pprint.PrettyPrinter().pprint(reply)
-    if args.dump:
-        reply = ynl.dump(args.dump, attrs)
-        pprint.PrettyPrinter().pprint(reply)
+                # Scan the dir and get all the yaml files.
+                for filename in os.scandir(directory):
+                    if filename.is_file():
+                        if filename.name.endswith('.yaml'):
+                            yamls[filename.name] = filename.path
 
-    if args.ntf:
-        ynl.check_ntf()
-        pprint.PrettyPrinter().pprint(ynl.async_msg_queue)
+            elif k == 'spec-args':
+               for v in data[k]:
+                    print("############### ",v," ###############\n")
+                    cfg = ynlConfig()
+                    # Check for yaml from the specs we found earlier
+                    if v in yamls:
+                        # FOUND
+                        cfg.spec = yamls[v]
+                        if 'no-schema' in data[k][v]:
+                            cfg.no_schema = data[k][v]['no-schema']
+                        if 'schema' in data[k][v]:
+                            cfg.schema = data[k][v]['schema']
+                            cfg.no_schema = False
+                        if 'do' in data[k][v]:
+                            cfg.do = data[k][v]['do']
+                        if 'dump' in data[k][v]:
+                            cfg.dump = data[k][v]['dump']
+                        if 'subscribe' in data[k][v]:
+                            cfg.ntf = data[k][v]['subscribe']
+                        if 'sleep' in data[k][v]:
+                            cfg.sleep = data[k][v]['sleep']
+                        if 'json-params' in data[k][v]:
+                            cfg.json_text = json.dumps(data[k][v]['json-params'])
 
+                        cfg.run()
+                    else:
+                        print("Error: ", v, " doesn't have a valid yaml file in ", directory, "\n")
+    else:
+        ynl_cfg(args.no_schema, args.spec, args.schema, args.json_text, args.ntf, args.sleep, args.do, args.dump)
 
 if __name__ == "__main__":
     main()
-- 
2.39.2


