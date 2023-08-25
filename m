Return-Path: <netdev+bounces-30660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E84788776
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 14:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542FA1C2102F
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 12:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930D2FBEE;
	Fri, 25 Aug 2023 12:29:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEFDFBEC
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 12:29:11 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6B42717;
	Fri, 25 Aug 2023 05:28:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40057e09bbaso7427095e9.3;
        Fri, 25 Aug 2023 05:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692966499; x=1693571299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGAqxktDTDiKNjzNkKdCTzIyXjBELWOqS8ELULbMYUM=;
        b=jeu6P7pIC5QIVYQAH7hsD5CwiMGgwH2NP7mcrCPMg7IB+nyTdHtXgphEvCBmEdAAcF
         PDwpIgqPavyNaWg0bcZjMAQtdCJt8aPrqkLfUwO0NX+ZPRlOf9521YQ633wIZNksjTy8
         Kp87VJyg0eabYNboaTfHvEXXfVn5rKR3Z+9sUJeB+AP8DQb9X1gMiklsLCxlju26llZX
         fbFNJYwNLFWe5QftrId/FJz753z2YF3JZ+pSetY/k48aXeRa8BjeWWuodLJhqo40N3TO
         3ZuZSVUFiW9L4E5bhNqiXL8CVVEEhHZ5mOxbWxRzMhkDc5+Ya/QRnKxu2ssVa2pODhRV
         kWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692966499; x=1693571299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGAqxktDTDiKNjzNkKdCTzIyXjBELWOqS8ELULbMYUM=;
        b=bkM7Jk9cdmw8wZpq8Ji45paIT8/qhXcFwu2hWUPoA1UHCeur2zZAEUqbPu3jKdVCXu
         +JDZnSU4/1PodeRR6PZuMqomRPMW01u40Vd7ErnFjXC/ueXJtcFKmJUGGT7kmpGzJ45B
         Ex6lb2bwWUfUpslNvdbq5HoySFlevS6+lYafYtXsmgy95X/UMRVnZaEq8UhYSCQr0VKV
         Kkr6zdGCon0rHxomzQ/oPL3GuEBSbQFLFesA6seKnBX4TVvdkDwdns4pJvI0+3j5ZAWf
         GkDF7vT4D1SmbsImLT7d8LQwhfqCvy80Q6UKWkX71LOnUxvQAhwRx3RcEigeCyE7KDk8
         orAQ==
X-Gm-Message-State: AOJu0YzrTQiZjRqfHKjT5oVTF/HtQbMTZs9IRuC/ZF+SoXINgNiKwwtl
	kEH9BU4zbbYR6p5AccGDOksI7S7HvpqYaA==
X-Google-Smtp-Source: AGHT+IGmaRDPd6ZbZX5pTsY4hFBs2mhYu+fVeS5AEJ0wUUTQ1ngPo9Dm+nf2rUSxyOEAqabTIWBidQ==
X-Received: by 2002:a7b:c414:0:b0:3fb:dff2:9f17 with SMTP id k20-20020a7bc414000000b003fbdff29f17mr14599063wmi.15.1692966498720;
        Fri, 25 Aug 2023 05:28:18 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:88fe:5215:b5d:bbee])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c229000b003fff96bb62csm2089561wmf.16.2023.08.25.05.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 05:28:18 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Stanislav Fomichev <sdf@google.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v6 09/12] tools/net/ynl: Add support for create flags
Date: Fri, 25 Aug 2023 13:27:52 +0100
Message-ID: <20230825122756.7603-10-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825122756.7603-1-donald.hunter@gmail.com>
References: <20230825122756.7603-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for using NLM_F_REPLACE, _EXCL, _CREATE and _APPEND flags
in requests.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 tools/net/ynl/cli.py          | 12 ++++++++++--
 tools/net/ynl/lib/__init__.py |  4 ++--
 tools/net/ynl/lib/ynl.py      | 14 ++++++++++----
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index ffaa8038aa8c..564ecf07cd2c 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -6,7 +6,7 @@ import json
 import pprint
 import time
 
-from lib import YnlFamily
+from lib import YnlFamily, Netlink
 
 
 def main():
@@ -19,6 +19,14 @@ def main():
     parser.add_argument('--dump', dest='dump', type=str)
     parser.add_argument('--sleep', dest='sleep', type=int)
     parser.add_argument('--subscribe', dest='ntf', type=str)
+    parser.add_argument('--replace', dest='flags', action='append_const',
+                        const=Netlink.NLM_F_REPLACE)
+    parser.add_argument('--excl', dest='flags', action='append_const',
+                        const=Netlink.NLM_F_EXCL)
+    parser.add_argument('--create', dest='flags', action='append_const',
+                        const=Netlink.NLM_F_CREATE)
+    parser.add_argument('--append', dest='flags', action='append_const',
+                        const=Netlink.NLM_F_APPEND)
     args = parser.parse_args()
 
     if args.no_schema:
@@ -37,7 +45,7 @@ def main():
         time.sleep(args.sleep)
 
     if args.do:
-        reply = ynl.do(args.do, attrs)
+        reply = ynl.do(args.do, attrs, args.flags)
         pprint.PrettyPrinter().pprint(reply)
     if args.dump:
         reply = ynl.dump(args.dump, attrs)
diff --git a/tools/net/ynl/lib/__init__.py b/tools/net/ynl/lib/__init__.py
index 4b3797fe784b..f7eaa07783e7 100644
--- a/tools/net/ynl/lib/__init__.py
+++ b/tools/net/ynl/lib/__init__.py
@@ -2,7 +2,7 @@
 
 from .nlspec import SpecAttr, SpecAttrSet, SpecEnumEntry, SpecEnumSet, \
     SpecFamily, SpecOperation
-from .ynl import YnlFamily
+from .ynl import YnlFamily, Netlink
 
 __all__ = ["SpecAttr", "SpecAttrSet", "SpecEnumEntry", "SpecEnumSet",
-           "SpecFamily", "SpecOperation", "YnlFamily"]
+           "SpecFamily", "SpecOperation", "YnlFamily", "Netlink"]
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 5d04a2b5fc78..484b42354ae7 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -35,6 +35,10 @@ class Netlink:
     NLM_F_ACK = 4
     NLM_F_ROOT = 0x100
     NLM_F_MATCH = 0x200
+
+    NLM_F_REPLACE = 0x100
+    NLM_F_EXCL = 0x200
+    NLM_F_CREATE = 0x400
     NLM_F_APPEND = 0x800
 
     NLM_F_CAPPED = 0x100
@@ -649,10 +653,12 @@ class YnlFamily(SpecFamily):
 
       return op['do']['request']['attributes'].copy()
 
-    def _op(self, method, vals, dump=False):
+    def _op(self, method, vals, flags, dump=False):
         op = self.ops[method]
 
         nl_flags = Netlink.NLM_F_REQUEST | Netlink.NLM_F_ACK
+        for flag in flags or []:
+            nl_flags |= flag
         if dump:
             nl_flags |= Netlink.NLM_F_DUMP
 
@@ -711,8 +717,8 @@ class YnlFamily(SpecFamily):
             return rsp[0]
         return rsp
 
-    def do(self, method, vals):
-        return self._op(method, vals)
+    def do(self, method, vals, flags):
+        return self._op(method, vals, flags)
 
     def dump(self, method, vals):
-        return self._op(method, vals, dump=True)
+        return self._op(method, vals, [], dump=True)
-- 
2.41.0


