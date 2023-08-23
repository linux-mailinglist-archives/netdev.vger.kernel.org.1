Return-Path: <netdev+bounces-29995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891817856F5
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 13:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FBA281065
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01160C120;
	Wed, 23 Aug 2023 11:42:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CD6C2CA
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:42:27 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFB8E61;
	Wed, 23 Aug 2023 04:42:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so51400965e9.2;
        Wed, 23 Aug 2023 04:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692790944; x=1693395744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpxozlulOHy7e2NcGQ2N1A8WX8wlrZhzOJhaC8DQaBU=;
        b=O+biuidF6ljTTgJjvFLL8V1/KewlqF7/3jCi2s+XYEJdu2wDMyPVq+/bL0ICrbI1iE
         emWZhQZ3bYWztIJJ/7T8ZHQtMlo+RdSCblasU3Q994U0VL+ieJO0r/+TNleeaeyo67wX
         DQJPaWAv+zkdNQ2KnY9SiLsJP2++nlQu+jQid8gcaJyO/SIF43NPv/NqbwqoFu2iBp6h
         b3ic0JFjBzHo4LT/PxStyFTT+YDLI2rxrcXDHhmcGdZ1sVQK9kawIdB7LS2ohcKyW+ld
         S67g5sShIPOUN/02rJm166FGoxC14rFfOx0J7Q2wpE2Wte8mJOKXDiCaCrxARtPoj/o9
         vLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692790944; x=1693395744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpxozlulOHy7e2NcGQ2N1A8WX8wlrZhzOJhaC8DQaBU=;
        b=bGyVzPVGYib34MIIZgwsekM3n95wwLs7AmXuv59P3xyg0rhGG6gx7zt25FsQ2g2wxF
         E1zWhsEQKnlfrBCh2Gq3WAulymnJ23FhqoeAelxg2VCkp4k8WdtHyK+pZv8A6A84GhYf
         gFKDmjbqmFBcCrIElpL+dUaf+QMk5v7Ip6uTq4bF60nkOX9NeqdBhEBgeZ0LHn3KT4gE
         uW3JxQFlNRy3UH4laOLoPRGUWpGE9WUYuJZwGd6FFX53B88vTIJ1BS15eIvEY+CSA+3p
         AND3F9CHrDH4qLcuMXuEHBEfO/37Vqfyr5ZUWqFCildJ2I1AHRsveiRse2UXoimd9ua4
         o3ow==
X-Gm-Message-State: AOJu0YwU7dlptCtA/T66w1x2PM2Tm3b0CKdnHTenCD2dfAn+KuVq3Qs8
	QBdsuXgyzD5DdlnuvZV0rugJ/GPG1v03qA==
X-Google-Smtp-Source: AGHT+IE+3XmyoSdRt7aPMz05YNbjeRaqibRit8p4+LkaOZxH5Naq6tO3g5U3P0m6VQaldbzrQRKDNQ==
X-Received: by 2002:a7b:cbc8:0:b0:3fb:e254:b81e with SMTP id n8-20020a7bcbc8000000b003fbe254b81emr9608435wmi.12.1692790944485;
        Wed, 23 Aug 2023 04:42:24 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:e4cf:1132:7b40:4262])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003fed9b1a1f4sm559508wms.1.2023.08.23.04.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 04:42:24 -0700 (PDT)
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
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v4 09/12] tools/net/ynl: Add support for create flags
Date: Wed, 23 Aug 2023 12:41:58 +0100
Message-ID: <20230823114202.5862-10-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823114202.5862-1-donald.hunter@gmail.com>
References: <20230823114202.5862-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for using NLM_F_REPLACE, _EXCL, _CREATE and _APPEND flags
in requests.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
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
index b44174f1fa33..14a45e71963b 100644
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
@@ -647,10 +651,12 @@ class YnlFamily(SpecFamily):
 
       return op['do']['request']['attributes'].copy()
 
-    def _op(self, method, vals, dump=False):
+    def _op(self, method, vals, flags, dump=False):
         op = self.ops[method]
 
         nl_flags = Netlink.NLM_F_REQUEST | Netlink.NLM_F_ACK
+        for flag in flags or []:
+            nl_flags |= flag
         if dump:
             nl_flags |= Netlink.NLM_F_DUMP
 
@@ -709,8 +715,8 @@ class YnlFamily(SpecFamily):
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


