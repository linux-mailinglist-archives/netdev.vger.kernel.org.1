Return-Path: <netdev+bounces-201449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBD5AE97CD
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052E81C2149D
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3051E25FA0E;
	Thu, 26 Jun 2025 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1Y9fkv5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0182125C838;
	Thu, 26 Jun 2025 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925616; cv=none; b=Nk+v6y7Yf84xM2Cr33sOhyDZXLX2h5m/E2P28W/PPt/O2B+xV8RaCOvHIAiPaiXR133NVkYw9LWzgIKo/VOyyvDAbacEXNrg1r+Yj9A5uTfr+Jbl1seDIhepfYmTkuB87XiIGQXvs7r30D4IjwWhJRpeOPRtzwyETL2Sxx25rTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925616; c=relaxed/simple;
	bh=ZRwnGGD63dY02hpT4BqTMDO35vMSt+NPRBYC3eA8F/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvdK/nApSYjAU4VbtQmIL1VzvZMs/0E+txOZDLeDjcD+MxSmgfn8ZWE38s1dMb7L0mCu/faszVMPvQJn6gsjNb2+q7x6MpDi85EZqRBPjVirAY4FvdyTBh5tdVFyva5P4R4eNk9gliF1IgMnLKUGH7AiJgyven5jlF6J3rPm1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1Y9fkv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0723C4CEEB;
	Thu, 26 Jun 2025 08:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750925615;
	bh=ZRwnGGD63dY02hpT4BqTMDO35vMSt+NPRBYC3eA8F/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a1Y9fkv50aNfrfpIi2TEbg0UwF6TuACsopFvZ0iJTQEW+yV8P42Tu4vypLmC39xYm
	 yI0DEQTHPRxVNN5gzmxsIiZwRW2uwL61BWwH+WZy250HQtcCWFe8Ao4PxiBA9SW00j
	 9msPP4S6k+laH5kJ3yvAW3xf4EF+NR5NONEOzKUps4pKmCHQEGbL2koUYTYBYvLez6
	 boSIXf/n6DtasEbhQwiwkyjzzsvVO6P7Mdfl4aLUKMOHz3CNqrfo/j/FMvrmxmzESg
	 oR2nuYezQTT8YQ1IFuZyAn6Zw8HHhyqW3ANnOJ6aty2nOAcKvdjSPPbdETWkfuX1cf
	 9p00ovBsBqfkQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uUhjT-00000004sw6-2BYy;
	Thu, 26 Jun 2025 10:13:19 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Donald Hunter" <donald.hunter@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Jan Stancek" <jstancek@redhat.com>,
	"Marco Elver" <elver@google.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Simon Horman <mchehab+huawei@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v8 11/13] tools: netlink_yml_parser.py: add line numbers to parsed data
Date: Thu, 26 Jun 2025 10:13:07 +0200
Message-ID: <549be41405b5ddb6b78ead71f26c33fd6ce8e190.1750925410.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750925410.git.mchehab+huawei@kernel.org>
References: <cover.1750925410.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

When something goes wrong, we want Sphinx error to point to the
right line number from the original source, not from the
processed ReST data.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/net/ynl/pyynl/lib/doc_generator.py | 34 ++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/doc_generator.py b/tools/net/ynl/pyynl/lib/doc_generator.py
index 866551726723..a9d8ab6f2639 100644
--- a/tools/net/ynl/pyynl/lib/doc_generator.py
+++ b/tools/net/ynl/pyynl/lib/doc_generator.py
@@ -20,6 +20,16 @@
 from typing import Any, Dict, List
 import yaml
 
+LINE_STR = '__lineno__'
+
+class NumberedSafeLoader(yaml.SafeLoader):
+    """Override the SafeLoader class to add line number to parsed data"""
+
+    def construct_mapping(self, node):
+        mapping = super().construct_mapping(node)
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


