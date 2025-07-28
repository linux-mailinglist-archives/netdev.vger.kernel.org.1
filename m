Return-Path: <netdev+bounces-210581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C6AB13F76
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37CD189B610
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F1F275B19;
	Mon, 28 Jul 2025 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Es92puf7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F468273D7E;
	Mon, 28 Jul 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718542; cv=none; b=pJ/qLwhdA9To5G8zBvj7ULQrY/9ovJoXJBW7gEf5stidoHNiyb8pfkCQPvDn4vPKmb8KjHb85YfTAJNseaUlwEoUKeNUzG17YeCQJ6VDJkJNropfBRsekzjai8Av2uqxpik4m63/2RDPcNcDD7ift/lsm1xoCu00TPrEV0gkO/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718542; c=relaxed/simple;
	bh=deh3Qwq57w+TnIRPLss0GAT2BTvn4TViPnV+RhZDsuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cm0UZe/qCfPVcGagyk56l2bm0BkE+RqofeeVh97orB64IBYGAsHxwU8XIokWy1pHQXHAn7nMG/P0NVvceqbynnP4/fXX3xCxkPoP4Tjgma081CSy739mjve5rkeqxFoolCa8hYufCn0/b6yM1dBcvvHTlEAuTpT/cLf2TMzAOBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Es92puf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B0DC4CEFB;
	Mon, 28 Jul 2025 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753718542;
	bh=deh3Qwq57w+TnIRPLss0GAT2BTvn4TViPnV+RhZDsuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Es92puf7cu8sxUCISF1zXpjJyy8zn8IR1uC6kiFV1bINXA27e5DZoH5+50aaPZLAn
	 qEvh1zNBpYMMrU7VHETV6szwY07NYE9IwSwzitYnRSy6Xo9J+Qk3MVcH6+/9TfebDC
	 ZqFDmDKhyXE9av0OaxhKSC/RsO1zRVuKD9Uh4IYmPZP1A3fsKbITxdIQT8mq7lyQuw
	 f6jesAC1O7BmItg46rq30sbcf1KKolCoTLajpjSFjoZPw5pvKmY0BTFMfm1QJuKXtT
	 BRcp06d0hS66R4BubPEgg/t41ZoTMPQf3sb2lQAp2WF/pubW3HiVLjzQj1R5rxAcbB
	 AAtIF5Wlh0yBA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1ugQIq-00000000GdB-24S3;
	Mon, 28 Jul 2025 18:02:16 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Message-ID :" <cover.1752076293.git.mchehab+huawei@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Donald Hunter" <donald.hunter@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Jan Stancek" <jstancek@redhat.com>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Marco Elver" <elver@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	"Simon Horman" <horms@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v10 11/14] tools: netlink_yml_parser.py: add line numbers to parsed data
Date: Mon, 28 Jul 2025 18:02:04 +0200
Message-ID: <7b358e8c7684f0ac23b65245205d1d3bd776e47d.1753718185.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1753718185.git.mchehab+huawei@kernel.org>
References: <cover.1753718185.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

When something goes wrong, we want Sphinx error to point to the
right line number from the original source, not from the
processed ReST data.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/net/ynl/pyynl/lib/doc_generator.py | 34 ++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/doc_generator.py b/tools/net/ynl/pyynl/lib/doc_generator.py
index 474b2b78c7bc..658759a527a6 100644
--- a/tools/net/ynl/pyynl/lib/doc_generator.py
+++ b/tools/net/ynl/pyynl/lib/doc_generator.py
@@ -20,6 +20,16 @@
 from typing import Any, Dict, List
 import yaml
 
+LINE_STR = '__lineno__'
+
+class NumberedSafeLoader(yaml.SafeLoader):              # pylint: disable=R0901
+    """Override the SafeLoader class to add line number to parsed data"""
+
+    def construct_mapping(self, node, *args, **kwargs):
+        mapping = super().construct_mapping(node, *args, **kwargs)
+        mapping[LINE_STR] = node.start_mark.line
+
+        return mapping
 
 class RstFormatters:
     """RST Formatters"""
@@ -127,6 +137,11 @@ class RstFormatters:
         """Return a formatted label"""
         return f".. _{title}:\n\n"
 
+    @staticmethod
+    def rst_lineno(lineno: int) -> str:
+        """Return a lineno comment"""
+        return f".. LINENO {lineno}\n"
+
 class YnlDocGenerator:
     """YAML Netlink specs Parser"""
 
@@ -144,6 +159,9 @@ class YnlDocGenerator:
         """Parse 'do' section and return a formatted string"""
         lines = []
         for key in do_dict.keys():
+            if key == LINE_STR:
+                lines.append(self.fmt.rst_lineno(do_dict[key]))
+                continue
             lines.append(self.fmt.rst_paragraph(self.fmt.bold(key), level + 1))
             if key in ['request', 'reply']:
                 lines.append(self.parse_do_attributes(do_dict[key], level + 1) + "\n")
@@ -174,6 +192,10 @@ class YnlDocGenerator:
             lines.append(self.fmt.rst_paragraph(operation["doc"]) + "\n")
 
             for key in operation.keys():
+                if key == LINE_STR:
+                    lines.append(self.fmt.rst_lineno(operation[key]))
+                    continue
+
                 if key in preprocessed:
                     # Skip the special fields
                     continue
@@ -233,6 +255,9 @@ class YnlDocGenerator:
         for definition in defs:
             lines.append(self.fmt.rst_section(namespace, 'definition', definition["name"]))
             for k in definition.keys():
+                if k == LINE_STR:
+                    lines.append(self.fmt.rst_lineno(definition[k]))
+                    continue
                 if k in preprocessed + ignored:
                     continue
                 lines.append(self.fmt.rst_fields(k, self.fmt.sanitize(definition[k]), 0))
@@ -268,6 +293,9 @@ class YnlDocGenerator:
                 lines.append(self.fmt.rst_subsubsection(attr_line))
 
                 for k in attr.keys():
+                    if k == LINE_STR:
+                        lines.append(self.fmt.rst_lineno(attr[k]))
+                        continue
                     if k in preprocessed + ignored:
                         continue
                     if k in linkable:
@@ -306,6 +334,8 @@ class YnlDocGenerator:
         lines = []
 
         # Main header
+        lineno = obj.get('__lineno__', 0)
+        lines.append(self.fmt.rst_lineno(lineno))
 
         family = obj['name']
 
@@ -354,7 +384,7 @@ class YnlDocGenerator:
     def parse_yaml_file(self, filename: str) -> str:
         """Transform the YAML specified by filename into an RST-formatted string"""
         with open(filename, "r", encoding="utf-8") as spec_file:
-            yaml_data = yaml.safe_load(spec_file)
-            content = self.parse_yaml(yaml_data)
+            numbered_yaml = yaml.load(spec_file, Loader=NumberedSafeLoader)
+            content = self.parse_yaml(numbered_yaml)
 
         return content
-- 
2.49.0


