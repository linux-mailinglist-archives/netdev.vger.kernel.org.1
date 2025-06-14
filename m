Return-Path: <netdev+bounces-197747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B75DAD9B95
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E5A189C8DA
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574BF2C08B8;
	Sat, 14 Jun 2025 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMGNknnJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AC6298CD9;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749891379; cv=none; b=GEXj+ATU12QAHEq60FBTp/MkwFnO4E0zWSisZRzm5qd1uOByoD8DurVtm4Aqn4nUp41H2QiINIB0zuD5bwQJIL77OhsviF+0yGrg57ELFddJttTMSYUssUT9qs3CPHvMz9RBsK7Yy72nRg7qqY3omRpjtqpS2w0HxSPyc8FlUr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749891379; c=relaxed/simple;
	bh=UkQ2QCYIxkOHq/xgNgAQuH6x4IS3MJ30nbw+w5JKF/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnXdVih3mVlYrDNWxVcoFSNcvXA7bDan9yzpqGNXplWP1s9/scHjeBp2PheVoq8CGXBPECmZymam+ntvZCTbNLzUcR+bPVkUcuJDV8uTq+i27hUuVtfQ6EjcC9bPALlIzGmef1P0HAUhrUcPIRcZg4Tavc1jOFNPUBSr+wa45M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMGNknnJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2C6C4CEF9;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749891378;
	bh=UkQ2QCYIxkOHq/xgNgAQuH6x4IS3MJ30nbw+w5JKF/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kMGNknnJNn8kQK832ElSawoVXYKE3mHZ/v1lpBCxbGMTZvYacqL6FJw1Pm1PrOF8a
	 VhgXacirqUeJLLMQzMhRppdRiPlZ2cL2XX41tKP1F/bMcgFWHh8cgbhNop/8UVAO7V
	 2G39xgebJFJGbR/QZNQCPlBh5BFdEQ72aqQCja8kSuCLAZXQopA/7S7u5q0qiJLj3X
	 0T4QI5n1ggPLjIIYRyV+Lyl4F6O4k/eBT2XupsSltFKCS+WKOud6iJinXrTbEJIdzN
	 ikvHNrSRKKSeZ0Vc4J8Fp4OGFBbKdiTezBBWRigpgKjo/n3+eHmlrxy0ess1Q5S5ow
	 /tgFh0FivHsMQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uQMgS-000000064b5-1FVt;
	Sat, 14 Jun 2025 10:56:16 +0200
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
Subject: [PATCH v4 07/14] tools: ynl_gen_rst.py: move index.rst generator to the script
Date: Sat, 14 Jun 2025 10:56:01 +0200
Message-ID: <31466ece9905956c2e1a3d3fc744cfc272df5d88.1749891128.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749891128.git.mchehab+huawei@kernel.org>
References: <cover.1749891128.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The index.rst generator doesn't really belong to the parsing
function. Move it to the command line tool, as it won't be
used elsewhere.

While here, make it more generic, allowing it to handle either
.yaml or .rst as input files.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/lib/netlink_yml_parser.py  | 101 ++++++++---------------------
 tools/net/ynl/pyynl/ynl_gen_rst.py |  28 +++++++-
 2 files changed, 52 insertions(+), 77 deletions(-)

diff --git a/scripts/lib/netlink_yml_parser.py b/scripts/lib/netlink_yml_parser.py
index 839e78b39de3..866551726723 100755
--- a/scripts/lib/netlink_yml_parser.py
+++ b/scripts/lib/netlink_yml_parser.py
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
@@ -380,30 +358,3 @@ class YnlDocGenerator:
             content = self.parse_yaml(yaml_data)
 
         return content
-
-
-    def generate_main_index_rst(self, output: str, index_dir: str) -> None:
-        """Generate the `networking_spec/index` content and write to the file"""
-        lines = []
-
-        lines.append(self.fmt.rst_header())
-        lines.append(self.fmt.rst_label("specs"))
-        lines.append(self.fmt.rst_title("Netlink Family Specifications"))
-        lines.append(self.fmt.rst_toctree(1))
-
-        index_fname = os.path.basename(output)
-        base, ext = os.path.splitext(index_fname)
-
-        if not index_dir:
-            index_dir = os.path.dirname(output)
-
-        logging.debug(f"Looking for {ext} files in %s", index_dir)
-        for filename in sorted(os.listdir(index_dir)):
-            if not filename.endswith(ext) or filename == index_fname:
-                continue
-            base, ext = os.path.splitext(filename)
-            lines.append(f"   {base}\n")
-
-        logging.debug("Writing an index file at %s", output)
-
-        return "".join(lines)
diff --git a/tools/net/ynl/pyynl/ynl_gen_rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
index 624b0960476e..85e9e2520393 100755
--- a/tools/net/ynl/pyynl/ynl_gen_rst.py
+++ b/tools/net/ynl/pyynl/ynl_gen_rst.py
@@ -23,7 +23,7 @@ SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 
 sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
 
-from netlink_yml_parser import YnlDocGenerator
+from netlink_yml_parser import YnlDocGenerator        # pylint: disable=C0413
 
 
 def parse_arguments() -> argparse.Namespace:
@@ -74,7 +74,31 @@ def write_to_rstfile(content: str, filename: str) -> None:
 def write_index_rst(parser: YnlDocGenerator, output: str, index_dir: str) -> None:
     """Generate the `networking_spec/index` content and write to the file"""
 
-    msg = parser.generate_main_index_rst(output, index_dir)
+    lines = []
+
+    lines.append(parser.fmt.rst_header())
+    lines.append(parser.fmt.rst_label("specs"))
+    lines.append(parser.fmt.rst_title("Netlink Family Specifications"))
+    lines.append(parser.fmt.rst_toctree(1))
+
+    index_fname = os.path.basename(output)
+    if not index_dir:
+        index_dir = os.path.dirname(output)
+
+    exts = [ ".yaml", ".rst" ]
+
+    logging.debug(f"Looking for files in %s", index_dir)
+    for filename in sorted(os.listdir(index_dir)):
+        if filename == index_fname:
+            continue
+
+        for ext in exts:
+            if not filename.endswith(ext):
+                continue
+        base, ext = os.path.splitext(filename)
+        lines.append(f"   {base}\n")
+
+    msg = "".join(lines)
 
     logging.debug("Writing an index file at %s", output)
     write_to_rstfile(msg, output)
-- 
2.49.0


