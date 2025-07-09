Return-Path: <netdev+bounces-205483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAC9AFEE6E
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 18:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACF51C819C7
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 16:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62402EAB9A;
	Wed,  9 Jul 2025 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fICxVQW2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7073F2EA15D;
	Wed,  9 Jul 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076749; cv=none; b=eXSovX4ZBoVb7nQkd98SH4WVHBBjR+Ex224imE+guLONe1gXZ96aZID2TwWOJLt3451VERTtF2fMSLVXl4i+NYqUZVntL7ei7u2oshpSw6KG82TmbPbRW+0yO4x8MH50OTDoCgCJKboc8n6TNa+4g9i1rARQgTWF/biTCpNqOFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076749; c=relaxed/simple;
	bh=iZvN3Z3Z0rcVoAdWJ24GjnupP01y0n1PoT8Sy6J4zjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+QkIn7rmuwQTSmSJpxOiNqoNUZiUHb9Osp00+j4Jczbyh7JSQxqV1Lp+UF4Y3HfiXFGRP/y5bc7lC1QVWdkUQrHocRqHwxK8D+kLwxz1XEU4aMZwP2jStqGs+NXPGfPPCXF9KdbBuSv1Q+dbJLlzbeEU4fK92hY6AYgtCCDOSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fICxVQW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B15C4CEFC;
	Wed,  9 Jul 2025 15:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752076749;
	bh=iZvN3Z3Z0rcVoAdWJ24GjnupP01y0n1PoT8Sy6J4zjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fICxVQW2Bbs0CHKigrg4aCsDc3ChCcnU1ijSgJlCw32x2Wxu+0lgLLlkdQ5BCtNbQ
	 1DNBx3NqEN7AevRkQCQAsWXn01Ced75lOIRysfopqzZDZP0WUsWaxj8sWS1oAOdR7t
	 CBFDfOoknwjypkPLn2OZLMMIvkmMn/YinulGBsMuN37U04ndp8kZl2vaV4qO3FYxmz
	 bkijiOoj44us4BObcZmw3plYol6RFYSMZyv/IH5aHZMERQPphsKcU7jL7mc4DUkY8f
	 tWFl2Y4W1pis+EzHpXODhvyaizaWy7rx2mfY3IocqbGxGffhVpfzCnlwet+gTrqqzV
	 MHGhSTXl4CIIQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZXCJ-00000000Igy-18KM;
	Wed, 09 Jul 2025 17:59:03 +0200
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
	"Paolo Abeni" <pabeni@redhat.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v9 04/13] tools: ynl_gen_rst.py: cleanup coding style
Date: Wed,  9 Jul 2025 17:58:48 +0200
Message-ID: <3316c4077dbf42a74b9c0f07be2715229f54ff90.1752076293.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752076293.git.mchehab+huawei@kernel.org>
References: <cover.1752076293.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Cleanup some coding style issues pointed by pylint and flake8.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/lib/doc_generator.py | 72 ++++++++----------------
 1 file changed, 25 insertions(+), 47 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/doc_generator.py b/tools/net/ynl/pyynl/lib/doc_generator.py
index 80e468086693..474b2b78c7bc 100644
--- a/tools/net/ynl/pyynl/lib/doc_generator.py
+++ b/tools/net/ynl/pyynl/lib/doc_generator.py
@@ -18,17 +18,12 @@
 """
 
 from typing import Any, Dict, List
-import os.path
-import sys
-import argparse
-import logging
 import yaml
 
 
-# ==============
-# RST Formatters
-# ==============
 class RstFormatters:
+    """RST Formatters"""
+
     SPACE_PER_LEVEL = 4
 
     @staticmethod
@@ -36,81 +31,67 @@ class RstFormatters:
         """Return space to format"""
         return " " * (level * RstFormatters.SPACE_PER_LEVEL)
 
-
     @staticmethod
     def bold(text: str) -> str:
         """Format bold text"""
         return f"**{text}**"
 
-
     @staticmethod
     def inline(text: str) -> str:
         """Format inline text"""
         return f"``{text}``"
 
-
     @staticmethod
     def sanitize(text: str) -> str:
         """Remove newlines and multiple spaces"""
         # This is useful for some fields that are spread across multiple lines
         return str(text).replace("\n", " ").strip()
 
-
     def rst_fields(self, key: str, value: str, level: int = 0) -> str:
         """Return a RST formatted field"""
         return self.headroom(level) + f":{key}: {value}"
 
-
     def rst_definition(self, key: str, value: Any, level: int = 0) -> str:
         """Format a single rst definition"""
         return self.headroom(level) + key + "\n" + self.headroom(level + 1) + str(value)
 
-
     def rst_paragraph(self, paragraph: str, level: int = 0) -> str:
         """Return a formatted paragraph"""
         return self.headroom(level) + paragraph
 
-
     def rst_bullet(self, item: str, level: int = 0) -> str:
         """Return a formatted a bullet"""
         return self.headroom(level) + f"- {item}"
 
-
     @staticmethod
     def rst_subsection(title: str) -> str:
         """Add a sub-section to the document"""
         return f"{title}\n" + "-" * len(title)
 
-
     @staticmethod
     def rst_subsubsection(title: str) -> str:
         """Add a sub-sub-section to the document"""
         return f"{title}\n" + "~" * len(title)
 
-
     @staticmethod
     def rst_section(namespace: str, prefix: str, title: str) -> str:
         """Add a section to the document"""
         return f".. _{namespace}-{prefix}-{title}:\n\n{title}\n" + "=" * len(title)
 
-
     @staticmethod
     def rst_subtitle(title: str) -> str:
         """Add a subtitle to the document"""
         return "\n" + "-" * len(title) + f"\n{title}\n" + "-" * len(title) + "\n\n"
 
-
     @staticmethod
     def rst_title(title: str) -> str:
         """Add a title to the document"""
         return "=" * len(title) + f"\n{title}\n" + "=" * len(title) + "\n\n"
 
-
     def rst_list_inline(self, list_: List[str], level: int = 0) -> str:
         """Format a list using inlines"""
         return self.headroom(level) + "[" + ", ".join(self.inline(i) for i in list_) + "]"
 
-
     @staticmethod
     def rst_ref(namespace: str, prefix: str, name: str) -> str:
         """Add a hyperlink to the document"""
@@ -122,7 +103,6 @@ class RstFormatters:
             prefix = mappings[prefix]
         return f":ref:`{namespace}-{prefix}-{name}`"
 
-
     def rst_header(self) -> str:
         """The headers for all the auto generated RST files"""
         lines = []
@@ -132,7 +112,6 @@ class RstFormatters:
 
         return "\n".join(lines)
 
-
     @staticmethod
     def rst_toctree(maxdepth: int = 2) -> str:
         """Generate a toctree RST primitive"""
@@ -143,16 +122,13 @@ class RstFormatters:
 
         return "\n".join(lines)
 
-
     @staticmethod
     def rst_label(title: str) -> str:
         """Return a formatted label"""
         return f".. _{title}:\n\n"
 
-# =======
-# Parsers
-# =======
 class YnlDocGenerator:
+    """YAML Netlink specs Parser"""
 
     fmt = RstFormatters()
 
@@ -164,7 +140,6 @@ class YnlDocGenerator:
 
         return "\n".join(lines)
 
-
     def parse_do(self, do_dict: Dict[str, Any], level: int = 0) -> str:
         """Parse 'do' section and return a formatted string"""
         lines = []
@@ -177,16 +152,16 @@ class YnlDocGenerator:
 
         return "\n".join(lines)
 
-
     def parse_do_attributes(self, attrs: Dict[str, Any], level: int = 0) -> str:
         """Parse 'attributes' section"""
         if "attributes" not in attrs:
             return ""
-        lines = [self.fmt.rst_fields("attributes", self.fmt.rst_list_inline(attrs["attributes"]), level + 1)]
+        lines = [self.fmt.rst_fields("attributes",
+                                     self.fmt.rst_list_inline(attrs["attributes"]),
+                                     level + 1)]
 
         return "\n".join(lines)
 
-
     def parse_operations(self, operations: List[Dict[str, Any]], namespace: str) -> str:
         """Parse operations block"""
         preprocessed = ["name", "doc", "title", "do", "dump", "flags"]
@@ -194,7 +169,8 @@ class YnlDocGenerator:
         lines = []
 
         for operation in operations:
-            lines.append(self.fmt.rst_section(namespace, 'operation', operation["name"]))
+            lines.append(self.fmt.rst_section(namespace, 'operation',
+                                              operation["name"]))
             lines.append(self.fmt.rst_paragraph(operation["doc"]) + "\n")
 
             for key in operation.keys():
@@ -206,7 +182,8 @@ class YnlDocGenerator:
                     value = self.fmt.rst_ref(namespace, key, value)
                 lines.append(self.fmt.rst_fields(key, value, 0))
             if 'flags' in operation:
-                lines.append(self.fmt.rst_fields('flags', self.fmt.rst_list_inline(operation['flags'])))
+                lines.append(self.fmt.rst_fields('flags',
+                                                 self.fmt.rst_list_inline(operation['flags'])))
 
             if "do" in operation:
                 lines.append(self.fmt.rst_paragraph(":do:", 0))
@@ -220,7 +197,6 @@ class YnlDocGenerator:
 
         return "\n".join(lines)
 
-
     def parse_entries(self, entries: List[Dict[str, Any]], level: int) -> str:
         """Parse a list of entries"""
         ignored = ["pad"]
@@ -235,17 +211,19 @@ class YnlDocGenerator:
                 if type_:
                     field_name += f" ({self.fmt.inline(type_)})"
                 lines.append(
-                    self.fmt.rst_fields(field_name, self.fmt.sanitize(entry.get("doc", "")), level)
+                    self.fmt.rst_fields(field_name,
+                                        self.fmt.sanitize(entry.get("doc", "")),
+                                        level)
                 )
             elif isinstance(entry, list):
                 lines.append(self.fmt.rst_list_inline(entry, level))
             else:
-                lines.append(self.fmt.rst_bullet(self.fmt.inline(self.fmt.sanitize(entry)), level))
+                lines.append(self.fmt.rst_bullet(self.fmt.inline(self.fmt.sanitize(entry)),
+                                                 level))
 
         lines.append("\n")
         return "\n".join(lines)
 
-
     def parse_definitions(self, defs: Dict[str, Any], namespace: str) -> str:
         """Parse definitions section"""
         preprocessed = ["name", "entries", "members"]
@@ -270,7 +248,6 @@ class YnlDocGenerator:
 
         return "\n".join(lines)
 
-
     def parse_attr_sets(self, entries: List[Dict[str, Any]], namespace: str) -> str:
         """Parse attribute from attribute-set"""
         preprocessed = ["name", "type"]
@@ -279,7 +256,8 @@ class YnlDocGenerator:
         lines = []
 
         for entry in entries:
-            lines.append(self.fmt.rst_section(namespace, 'attribute-set', entry["name"]))
+            lines.append(self.fmt.rst_section(namespace, 'attribute-set',
+                                              entry["name"]))
             for attr in entry["attributes"]:
                 type_ = attr.get("type")
                 attr_line = attr["name"]
@@ -301,13 +279,13 @@ class YnlDocGenerator:
 
         return "\n".join(lines)
 
-
     def parse_sub_messages(self, entries: List[Dict[str, Any]], namespace: str) -> str:
         """Parse sub-message definitions"""
         lines = []
 
         for entry in entries:
-            lines.append(self.fmt.rst_section(namespace, 'sub-message', entry["name"]))
+            lines.append(self.fmt.rst_section(namespace, 'sub-message',
+                                              entry["name"]))
             for fmt in entry["formats"]:
                 value = fmt["value"]
 
@@ -315,13 +293,14 @@ class YnlDocGenerator:
                 for attr in ['fixed-header', 'attribute-set']:
                     if attr in fmt:
                         lines.append(self.fmt.rst_fields(attr,
-                                                self.fmt.rst_ref(namespace, attr, fmt[attr]),
-                                                1))
+                                                         self.fmt.rst_ref(namespace,
+                                                                          attr,
+                                                                          fmt[attr]),
+                                                         1))
                 lines.append("\n")
 
         return "\n".join(lines)
 
-
     def parse_yaml(self, obj: Dict[str, Any]) -> str:
         """Format the whole YAML into a RST string"""
         lines = []
@@ -344,7 +323,8 @@ class YnlDocGenerator:
         # Operations
         if "operations" in obj:
             lines.append(self.fmt.rst_subtitle("Operations"))
-            lines.append(self.parse_operations(obj["operations"]["list"], family))
+            lines.append(self.parse_operations(obj["operations"]["list"],
+                                               family))
 
         # Multicast groups
         if "mcast-groups" in obj:
@@ -368,11 +348,9 @@ class YnlDocGenerator:
 
         return "\n".join(lines)
 
-
     # Main functions
     # ==============
 
-
     def parse_yaml_file(self, filename: str) -> str:
         """Transform the YAML specified by filename into an RST-formatted string"""
         with open(filename, "r", encoding="utf-8") as spec_file:
-- 
2.49.0


