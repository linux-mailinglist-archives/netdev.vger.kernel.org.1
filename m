Return-Path: <netdev+bounces-21904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2257276532A
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 14:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD1A282331
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 12:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150431642E;
	Thu, 27 Jul 2023 12:04:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08019168BC
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 12:04:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81FD30C6
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 05:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690459442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ho1c8RI5UuIQlZedLaovGkzM0J+O3ylPf3x16FMPob4=;
	b=QOIRx1tNaCrqmYIrkQjTQ/5mFKP4m/DH0YG3Gi+qjYF+sFdYC+WoHT6DzhAqRQFzVE29I+
	g69E8mgLcXq+d9CJt/AQw+Zc7KVJ4B+qQvHwzH46C31Mo5Maa1JiG3nsCNojuW+xl90DBu
	88HtCRJKc4CutFV5Fzyo8Dt31b2MLJ8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-oFuuYE3NNwy7qBcXXaBvzg-1; Thu, 27 Jul 2023 08:04:01 -0400
X-MC-Unique: oFuuYE3NNwy7qBcXXaBvzg-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a5aca1f256so1854101b6e.2
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 05:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690459440; x=1691064240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ho1c8RI5UuIQlZedLaovGkzM0J+O3ylPf3x16FMPob4=;
        b=XEtz3yEjXgZS+9FQNySGN+vQ3WO4qe+lmT8gzZKkUUkjrP+yUWsTQN6WEuP7wOOj0Y
         IUeo00qhalW0MaI4nCWZIz8DtGYd6vOWSJg3R6pNzBshbV6R/opicnLVuAPYzFnJ7psl
         LrajAYin6CMyM2eeiM92+iQjyFS4Im3BIrBUsnKdyXquApQBXiCS+yARoSZBkK5UyrTm
         ne4ncbN06ap6dvunUhihJwEYRXQA9Z3GMlrSv5yGqNWvXxvCiTEHdPhWgq8HIii4u493
         1yzGEEtaIGyw/zFvHKWQoeEGAXaeS5G6Zz89hoJaDi8PjDv9JIcUwmteQd7vTTzv8rk0
         htVQ==
X-Gm-Message-State: ABy/qLbUAL4+v5cIzqiwsfXt8eEITGq2p0IKn8uyeJH03vVuF4yNxTNH
	ghQ8KYFzqhwGkAtcrdZxziQ1+0BBr3ODmO6zM0P50Jr2BH1ANKty8Pjlv0/ZHLbt8TxGvlS0kJ/
	Qd7JY9fHAuh1DTzw7FtyHavpr1K3wQWVCqZoSEODxz9rYHan2AzI0qf8NKnDSkqFF2EfmSye4Ll
	a0Sg==
X-Received: by 2002:a05:6808:bc5:b0:3a3:660c:bdb0 with SMTP id o5-20020a0568080bc500b003a3660cbdb0mr3397926oik.54.1690459440533;
        Thu, 27 Jul 2023 05:04:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEwrdVkJNYerh7G7o6gYUAjAW8dig3M1yCNQ7ilVDSwat6g2+6o4Jo9W35qxtBQp4OEjhXtKA==
X-Received: by 2002:a05:6808:bc5:b0:3a3:660c:bdb0 with SMTP id o5-20020a0568080bc500b003a3660cbdb0mr3397894oik.54.1690459440149;
        Thu, 27 Jul 2023 05:04:00 -0700 (PDT)
Received: from nfvsdn-06.redhat.com (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id t1-20020a0ca681000000b006262e5c96d0sm369295qva.129.2023.07.27.05.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 05:03:59 -0700 (PDT)
From: Maryam Tahhan <mtahhan@redhat.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH net-next v2 1/2] tools/net/ynl: configuration through json
Date: Thu, 27 Jul 2023 08:03:30 -0400
Message-ID: <20230727120353.3020678-2-mtahhan@redhat.com>
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
2.41.0


