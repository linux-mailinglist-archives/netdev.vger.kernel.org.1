Return-Path: <netdev+bounces-201455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5230EAE97D8
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A134A1F78
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BB5277C8B;
	Thu, 26 Jun 2025 08:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S24s9KWN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A542749F4;
	Thu, 26 Jun 2025 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925626; cv=none; b=LsulW9nXWmvTtyTUko3yNgi5L5O9Xv+FiMIIf2Hi1O4xEvywNKrVoDthF8r9G0ow3zN5W653gGipxk7nQ+sxHVVmNsUTM3c7Yh6wLhgi59YkhrKmKpITNgT0tWcLYpITPyO3GMhaWkUww8WikfJShfBI6HHwOOf1pZBjnrNVcYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925626; c=relaxed/simple;
	bh=D248y9zPyJEISZ9QQ1s+72K+/VLmYnY7s/slvWoph7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8TiTT5IJM37j6/fHvIASjIWDMpzi0WiEgHmqtVWUtZBQemk+1DwwNKX8imJh7DoorDvrfwtAWJKOBW+RT4VpaKHHEYrtSQslTImWQDB5Rc1UtdhUizk0LZYxGDmO60gk91Ft31ZaZf6p8ag6PQDMJiWQywjlPwCeFbJGRYBadU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S24s9KWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492B8C4CEEB;
	Thu, 26 Jun 2025 08:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750925625;
	bh=D248y9zPyJEISZ9QQ1s+72K+/VLmYnY7s/slvWoph7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S24s9KWNMQI4U0UZCiuLhBDDCe/Eu4vBLfheqJ0OAI+Cota7eUSHqrHtk10sHcuC3
	 hvbisAB00DUR8aTQxbf0Qn5I8h6RRH0f2Fm8h3Mat67d9+vfc1wtVOqTN9+om3XPDl
	 sZ6J776N6hHHkyz4TeemJE5QTJg3yTVjMnTc/IZxMVdueXFCte/hqOI/dOxFUpznL5
	 jg7Hs3cU1ibwmXY3tpdiwBl/aQB+WhChY5gMRaQ75eiz4pqwTBubA8XXWU4ShHW3nW
	 9mYpIayoVlgGjNbFJIIcMid/EZ75ZjQ59K2DNxBVCrbMtI/1LqytNi8xEMBVthlquH
	 KS1re4JseB+QQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uUhjT-00000004sve-1JJ1;
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
Subject: [PATCH v8 04/13] tools: ynl_gen_rst.py: cleanup coding style
Date: Thu, 26 Jun 2025 10:13:00 +0200
Message-ID: <398c4d179f07bc0558c8f6ce196e3620bf2efdaf.1750925410.git.mchehab+huawei@kernel.org>
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

Cleanup some coding style issues pointed by pylint and flake8.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/lib/doc_generator.py | 74 +++++++++---------------
 1 file changed, 26 insertions(+), 48 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/doc_generator.py b/tools/net/ynl/pyynl/lib/doc_generator.py
index 80e468086693..866551726723 100644
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
@@ -119,10 +100,9 @@ class RstFormatters:
                     'nested-attributes': 'attribute-set',
                     'struct': 'definition'}
         if prefix in mappings:
-            prefix = mappings[prefix]
+            prefix = mappings.get(prefix, "")
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


