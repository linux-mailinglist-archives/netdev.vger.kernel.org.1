Return-Path: <netdev+bounces-199031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1DDADEAD2
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E83540295D
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864412E889D;
	Wed, 18 Jun 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQ7blse+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B72DE214;
	Wed, 18 Jun 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247212; cv=none; b=dLnfrb2Jr9odlgM2+ffPCY/7MWVuFUFhlL1+dH/h3XuFZOk/AZ3fUizVhop/ffppVKTdPZY1/WNG4HQOB087nfAFx4FhMVhFwh+ZB0GO9w2SX7xm0PT82wHyrTCWcnNh7wCKJlnvPW1ejkF6IfnucFSoIJQo4CD6UbR6qPk7swg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247212; c=relaxed/simple;
	bh=ILMkIMZRBVquHVA7G08AHG7My5iKhrMAj1qGVO2Pimg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coVEZXz9JspznbW67CnHr7jqfRJ6mvFaojpEJAtx0cHf+aa8EnnrVQwwVpI8PIZoJi9fQzKGV4ezi7Cd7fY6RlqsA35u20OsDY1SDK30TW6wCVZluvPyZSumak6emLsMQFJlxqOVWOI/djIisY/+aXs8XFp1VLov9VBWL1JOY9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQ7blse+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643EFC4CEF2;
	Wed, 18 Jun 2025 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750247211;
	bh=ILMkIMZRBVquHVA7G08AHG7My5iKhrMAj1qGVO2Pimg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sQ7blse+yZjDClmiXQlLiQIQDfEVRDh5w2t6ILU0woHepKIhtI4GHlj8fYAL+UALQ
	 AV9IZEHnxWFfi7XMYqzDLKhRUQvUJN+VGKcq8JttfzDEETmtl4avNMderF7txSY6sR
	 p1ir4BhJMYXrB0ncmSAsnFLP5wF4w4QPyuMw5qJtB5iemZCRRSaj84Tp5E5aqzqT3w
	 m8IrgHlB0qGMTOZI2o/oavdSL4A0HlqhNJxuWRke/IpDbTHBAa7dl7NH/ZVWp3lVG2
	 oeTRiv0q2bBWuuOMoQp07/PNIo2qkMgf+7oN/Tacq0Lz+m89dM4MQw5c0wXO1Q+0FK
	 wwXPLu/aHCZuw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRrFh-000000036UW-2EYe;
	Wed, 18 Jun 2025 13:46:49 +0200
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
Subject: [PATCH v6 04/15] tools: ynl_gen_rst.py: Split library from command line tool
Date: Wed, 18 Jun 2025 13:46:31 +0200
Message-ID: <4e26583ad1d8a05ba40cada4213c95120bd45efc.1750246291.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750246291.git.mchehab+huawei@kernel.org>
References: <cover.1750246291.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As we'll be using the Netlink specs parser inside a Sphinx
extension, move the library part from the command line parser.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/net/ynl/pyynl/lib/__init__.py      |   2 +
 tools/net/ynl/pyynl/lib/doc_generator.py | 409 +++++++++++++++++++++++
 tools/net/ynl/pyynl/ynl_gen_rst.py       | 361 +-------------------
 3 files changed, 419 insertions(+), 353 deletions(-)
 create mode 100644 tools/net/ynl/pyynl/lib/doc_generator.py

diff --git a/tools/net/ynl/pyynl/lib/__init__.py b/tools/net/ynl/pyynl/lib/__init__.py
index 71518b9842ee..5f266ebe4526 100644
--- a/tools/net/ynl/pyynl/lib/__init__.py
+++ b/tools/net/ynl/pyynl/lib/__init__.py
@@ -4,6 +4,8 @@ from .nlspec import SpecAttr, SpecAttrSet, SpecEnumEntry, SpecEnumSet, \
     SpecFamily, SpecOperation, SpecSubMessage, SpecSubMessageFormat
 from .ynl import YnlFamily, Netlink, NlError
 
+from .doc_generator import YnlDocGenerator
+
 __all__ = ["SpecAttr", "SpecAttrSet", "SpecEnumEntry", "SpecEnumSet",
            "SpecFamily", "SpecOperation", "SpecSubMessage", "SpecSubMessageFormat",
            "YnlFamily", "Netlink", "NlError"]
diff --git a/tools/net/ynl/pyynl/lib/doc_generator.py b/tools/net/ynl/pyynl/lib/doc_generator.py
new file mode 100644
index 000000000000..839e78b39de3
--- /dev/null
+++ b/tools/net/ynl/pyynl/lib/doc_generator.py
@@ -0,0 +1,409 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# -*- coding: utf-8; mode: python -*-
+
+"""
+    Class to auto generate the documentation for Netlink specifications.
+
+    :copyright:  Copyright (C) 2023  Breno Leitao <leitao@debian.org>
+    :license:    GPL Version 2, June 1991 see linux/COPYING for details.
+
+    This class performs extensive parsing to the Linux kernel's netlink YAML
+    spec files, in an effort to avoid needing to heavily mark up the original
+    YAML file.
+
+    This code is split in two classes:
+        1) RST formatters: Use to convert a string to a RST output
+        2) YAML Netlink (YNL) doc generator: Generate docs from YAML data
+"""
+
+from typing import Any, Dict, List
+import os.path
+import sys
+import argparse
+import logging
+import yaml
+
+
+# ==============
+# RST Formatters
+# ==============
+class RstFormatters:
+    SPACE_PER_LEVEL = 4
+
+    @staticmethod
+    def headroom(level: int) -> str:
+        """Return space to format"""
+        return " " * (level * RstFormatters.SPACE_PER_LEVEL)
+
+
+    @staticmethod
+    def bold(text: str) -> str:
+        """Format bold text"""
+        return f"**{text}**"
+
+
+    @staticmethod
+    def inline(text: str) -> str:
+        """Format inline text"""
+        return f"``{text}``"
+
+
+    @staticmethod
+    def sanitize(text: str) -> str:
+        """Remove newlines and multiple spaces"""
+        # This is useful for some fields that are spread across multiple lines
+        return str(text).replace("\n", " ").strip()
+
+
+    def rst_fields(self, key: str, value: str, level: int = 0) -> str:
+        """Return a RST formatted field"""
+        return self.headroom(level) + f":{key}: {value}"
+
+
+    def rst_definition(self, key: str, value: Any, level: int = 0) -> str:
+        """Format a single rst definition"""
+        return self.headroom(level) + key + "\n" + self.headroom(level + 1) + str(value)
+
+
+    def rst_paragraph(self, paragraph: str, level: int = 0) -> str:
+        """Return a formatted paragraph"""
+        return self.headroom(level) + paragraph
+
+
+    def rst_bullet(self, item: str, level: int = 0) -> str:
+        """Return a formatted a bullet"""
+        return self.headroom(level) + f"- {item}"
+
+
+    @staticmethod
+    def rst_subsection(title: str) -> str:
+        """Add a sub-section to the document"""
+        return f"{title}\n" + "-" * len(title)
+
+
+    @staticmethod
+    def rst_subsubsection(title: str) -> str:
+        """Add a sub-sub-section to the document"""
+        return f"{title}\n" + "~" * len(title)
+
+
+    @staticmethod
+    def rst_section(namespace: str, prefix: str, title: str) -> str:
+        """Add a section to the document"""
+        return f".. _{namespace}-{prefix}-{title}:\n\n{title}\n" + "=" * len(title)
+
+
+    @staticmethod
+    def rst_subtitle(title: str) -> str:
+        """Add a subtitle to the document"""
+        return "\n" + "-" * len(title) + f"\n{title}\n" + "-" * len(title) + "\n\n"
+
+
+    @staticmethod
+    def rst_title(title: str) -> str:
+        """Add a title to the document"""
+        return "=" * len(title) + f"\n{title}\n" + "=" * len(title) + "\n\n"
+
+
+    def rst_list_inline(self, list_: List[str], level: int = 0) -> str:
+        """Format a list using inlines"""
+        return self.headroom(level) + "[" + ", ".join(self.inline(i) for i in list_) + "]"
+
+
+    @staticmethod
+    def rst_ref(namespace: str, prefix: str, name: str) -> str:
+        """Add a hyperlink to the document"""
+        mappings = {'enum': 'definition',
+                    'fixed-header': 'definition',
+                    'nested-attributes': 'attribute-set',
+                    'struct': 'definition'}
+        if prefix in mappings:
+            prefix = mappings[prefix]
+        return f":ref:`{namespace}-{prefix}-{name}`"
+
+
+    def rst_header(self) -> str:
+        """The headers for all the auto generated RST files"""
+        lines = []
+
+        lines.append(self.rst_paragraph(".. SPDX-License-Identifier: GPL-2.0"))
+        lines.append(self.rst_paragraph(".. NOTE: This document was auto-generated.\n\n"))
+
+        return "\n".join(lines)
+
+
+    @staticmethod
+    def rst_toctree(maxdepth: int = 2) -> str:
+        """Generate a toctree RST primitive"""
+        lines = []
+
+        lines.append(".. toctree::")
+        lines.append(f"   :maxdepth: {maxdepth}\n\n")
+
+        return "\n".join(lines)
+
+
+    @staticmethod
+    def rst_label(title: str) -> str:
+        """Return a formatted label"""
+        return f".. _{title}:\n\n"
+
+# =======
+# Parsers
+# =======
+class YnlDocGenerator:
+
+    fmt = RstFormatters()
+
+    def parse_mcast_group(self, mcast_group: List[Dict[str, Any]]) -> str:
+        """Parse 'multicast' group list and return a formatted string"""
+        lines = []
+        for group in mcast_group:
+            lines.append(self.fmt.rst_bullet(group["name"]))
+
+        return "\n".join(lines)
+
+
+    def parse_do(self, do_dict: Dict[str, Any], level: int = 0) -> str:
+        """Parse 'do' section and return a formatted string"""
+        lines = []
+        for key in do_dict.keys():
+            lines.append(self.fmt.rst_paragraph(self.fmt.bold(key), level + 1))
+            if key in ['request', 'reply']:
+                lines.append(self.parse_do_attributes(do_dict[key], level + 1) + "\n")
+            else:
+                lines.append(self.fmt.headroom(level + 2) + do_dict[key] + "\n")
+
+        return "\n".join(lines)
+
+
+    def parse_do_attributes(self, attrs: Dict[str, Any], level: int = 0) -> str:
+        """Parse 'attributes' section"""
+        if "attributes" not in attrs:
+            return ""
+        lines = [self.fmt.rst_fields("attributes", self.fmt.rst_list_inline(attrs["attributes"]), level + 1)]
+
+        return "\n".join(lines)
+
+
+    def parse_operations(self, operations: List[Dict[str, Any]], namespace: str) -> str:
+        """Parse operations block"""
+        preprocessed = ["name", "doc", "title", "do", "dump", "flags"]
+        linkable = ["fixed-header", "attribute-set"]
+        lines = []
+
+        for operation in operations:
+            lines.append(self.fmt.rst_section(namespace, 'operation', operation["name"]))
+            lines.append(self.fmt.rst_paragraph(operation["doc"]) + "\n")
+
+            for key in operation.keys():
+                if key in preprocessed:
+                    # Skip the special fields
+                    continue
+                value = operation[key]
+                if key in linkable:
+                    value = self.fmt.rst_ref(namespace, key, value)
+                lines.append(self.fmt.rst_fields(key, value, 0))
+            if 'flags' in operation:
+                lines.append(self.fmt.rst_fields('flags', self.fmt.rst_list_inline(operation['flags'])))
+
+            if "do" in operation:
+                lines.append(self.fmt.rst_paragraph(":do:", 0))
+                lines.append(self.parse_do(operation["do"], 0))
+            if "dump" in operation:
+                lines.append(self.fmt.rst_paragraph(":dump:", 0))
+                lines.append(self.parse_do(operation["dump"], 0))
+
+            # New line after fields
+            lines.append("\n")
+
+        return "\n".join(lines)
+
+
+    def parse_entries(self, entries: List[Dict[str, Any]], level: int) -> str:
+        """Parse a list of entries"""
+        ignored = ["pad"]
+        lines = []
+        for entry in entries:
+            if isinstance(entry, dict):
+                # entries could be a list or a dictionary
+                field_name = entry.get("name", "")
+                if field_name in ignored:
+                    continue
+                type_ = entry.get("type")
+                if type_:
+                    field_name += f" ({self.fmt.inline(type_)})"
+                lines.append(
+                    self.fmt.rst_fields(field_name, self.fmt.sanitize(entry.get("doc", "")), level)
+                )
+            elif isinstance(entry, list):
+                lines.append(self.fmt.rst_list_inline(entry, level))
+            else:
+                lines.append(self.fmt.rst_bullet(self.fmt.inline(self.fmt.sanitize(entry)), level))
+
+        lines.append("\n")
+        return "\n".join(lines)
+
+
+    def parse_definitions(self, defs: Dict[str, Any], namespace: str) -> str:
+        """Parse definitions section"""
+        preprocessed = ["name", "entries", "members"]
+        ignored = ["render-max"]  # This is not printed
+        lines = []
+
+        for definition in defs:
+            lines.append(self.fmt.rst_section(namespace, 'definition', definition["name"]))
+            for k in definition.keys():
+                if k in preprocessed + ignored:
+                    continue
+                lines.append(self.fmt.rst_fields(k, self.fmt.sanitize(definition[k]), 0))
+
+            # Field list needs to finish with a new line
+            lines.append("\n")
+            if "entries" in definition:
+                lines.append(self.fmt.rst_paragraph(":entries:", 0))
+                lines.append(self.parse_entries(definition["entries"], 1))
+            if "members" in definition:
+                lines.append(self.fmt.rst_paragraph(":members:", 0))
+                lines.append(self.parse_entries(definition["members"], 1))
+
+        return "\n".join(lines)
+
+
+    def parse_attr_sets(self, entries: List[Dict[str, Any]], namespace: str) -> str:
+        """Parse attribute from attribute-set"""
+        preprocessed = ["name", "type"]
+        linkable = ["enum", "nested-attributes", "struct", "sub-message"]
+        ignored = ["checks"]
+        lines = []
+
+        for entry in entries:
+            lines.append(self.fmt.rst_section(namespace, 'attribute-set', entry["name"]))
+            for attr in entry["attributes"]:
+                type_ = attr.get("type")
+                attr_line = attr["name"]
+                if type_:
+                    # Add the attribute type in the same line
+                    attr_line += f" ({self.fmt.inline(type_)})"
+
+                lines.append(self.fmt.rst_subsubsection(attr_line))
+
+                for k in attr.keys():
+                    if k in preprocessed + ignored:
+                        continue
+                    if k in linkable:
+                        value = self.fmt.rst_ref(namespace, k, attr[k])
+                    else:
+                        value = self.fmt.sanitize(attr[k])
+                    lines.append(self.fmt.rst_fields(k, value, 0))
+                lines.append("\n")
+
+        return "\n".join(lines)
+
+
+    def parse_sub_messages(self, entries: List[Dict[str, Any]], namespace: str) -> str:
+        """Parse sub-message definitions"""
+        lines = []
+
+        for entry in entries:
+            lines.append(self.fmt.rst_section(namespace, 'sub-message', entry["name"]))
+            for fmt in entry["formats"]:
+                value = fmt["value"]
+
+                lines.append(self.fmt.rst_bullet(self.fmt.bold(value)))
+                for attr in ['fixed-header', 'attribute-set']:
+                    if attr in fmt:
+                        lines.append(self.fmt.rst_fields(attr,
+                                                self.fmt.rst_ref(namespace, attr, fmt[attr]),
+                                                1))
+                lines.append("\n")
+
+        return "\n".join(lines)
+
+
+    def parse_yaml(self, obj: Dict[str, Any]) -> str:
+        """Format the whole YAML into a RST string"""
+        lines = []
+
+        # Main header
+
+        family = obj['name']
+
+        lines.append(self.fmt.rst_header())
+        lines.append(self.fmt.rst_label("netlink-" + family))
+
+        title = f"Family ``{family}`` netlink specification"
+        lines.append(self.fmt.rst_title(title))
+        lines.append(self.fmt.rst_paragraph(".. contents:: :depth: 3\n"))
+
+        if "doc" in obj:
+            lines.append(self.fmt.rst_subtitle("Summary"))
+            lines.append(self.fmt.rst_paragraph(obj["doc"], 0))
+
+        # Operations
+        if "operations" in obj:
+            lines.append(self.fmt.rst_subtitle("Operations"))
+            lines.append(self.parse_operations(obj["operations"]["list"], family))
+
+        # Multicast groups
+        if "mcast-groups" in obj:
+            lines.append(self.fmt.rst_subtitle("Multicast groups"))
+            lines.append(self.parse_mcast_group(obj["mcast-groups"]["list"]))
+
+        # Definitions
+        if "definitions" in obj:
+            lines.append(self.fmt.rst_subtitle("Definitions"))
+            lines.append(self.parse_definitions(obj["definitions"], family))
+
+        # Attributes set
+        if "attribute-sets" in obj:
+            lines.append(self.fmt.rst_subtitle("Attribute sets"))
+            lines.append(self.parse_attr_sets(obj["attribute-sets"], family))
+
+        # Sub-messages
+        if "sub-messages" in obj:
+            lines.append(self.fmt.rst_subtitle("Sub-messages"))
+            lines.append(self.parse_sub_messages(obj["sub-messages"], family))
+
+        return "\n".join(lines)
+
+
+    # Main functions
+    # ==============
+
+
+    def parse_yaml_file(self, filename: str) -> str:
+        """Transform the YAML specified by filename into an RST-formatted string"""
+        with open(filename, "r", encoding="utf-8") as spec_file:
+            yaml_data = yaml.safe_load(spec_file)
+            content = self.parse_yaml(yaml_data)
+
+        return content
+
+
+    def generate_main_index_rst(self, output: str, index_dir: str) -> None:
+        """Generate the `networking_spec/index` content and write to the file"""
+        lines = []
+
+        lines.append(self.fmt.rst_header())
+        lines.append(self.fmt.rst_label("specs"))
+        lines.append(self.fmt.rst_title("Netlink Family Specifications"))
+        lines.append(self.fmt.rst_toctree(1))
+
+        index_fname = os.path.basename(output)
+        base, ext = os.path.splitext(index_fname)
+
+        if not index_dir:
+            index_dir = os.path.dirname(output)
+
+        logging.debug(f"Looking for {ext} files in %s", index_dir)
+        for filename in sorted(os.listdir(index_dir)):
+            if not filename.endswith(ext) or filename == index_fname:
+                continue
+            base, ext = os.path.splitext(filename)
+            lines.append(f"   {base}\n")
+
+        logging.debug("Writing an index file at %s", output)
+
+        return "".join(lines)
diff --git a/tools/net/ynl/pyynl/ynl_gen_rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
index 7bfb8ceeeefc..b5a665eeaa5a 100755
--- a/tools/net/ynl/pyynl/ynl_gen_rst.py
+++ b/tools/net/ynl/pyynl/ynl_gen_rst.py
@@ -10,354 +10,17 @@
 
     This script performs extensive parsing to the Linux kernel's netlink YAML
     spec files, in an effort to avoid needing to heavily mark up the original
-    YAML file.
-
-    This code is split in three big parts:
-        1) RST formatters: Use to convert a string to a RST output
-        2) Parser helpers: Functions to parse the YAML data structure
-        3) Main function and small helpers
+    YAML file. It uses the library code from scripts/lib.
 """
 
-from typing import Any, Dict, List
 import os.path
+import pathlib
 import sys
 import argparse
 import logging
-import yaml
-
-
-SPACE_PER_LEVEL = 4
-
-
-# RST Formatters
-# ==============
-def headroom(level: int) -> str:
-    """Return space to format"""
-    return " " * (level * SPACE_PER_LEVEL)
-
-
-def bold(text: str) -> str:
-    """Format bold text"""
-    return f"**{text}**"
-
-
-def inline(text: str) -> str:
-    """Format inline text"""
-    return f"``{text}``"
-
-
-def sanitize(text: str) -> str:
-    """Remove newlines and multiple spaces"""
-    # This is useful for some fields that are spread across multiple lines
-    return str(text).replace("\n", " ").strip()
-
-
-def rst_fields(key: str, value: str, level: int = 0) -> str:
-    """Return a RST formatted field"""
-    return headroom(level) + f":{key}: {value}"
-
-
-def rst_definition(key: str, value: Any, level: int = 0) -> str:
-    """Format a single rst definition"""
-    return headroom(level) + key + "\n" + headroom(level + 1) + str(value)
-
-
-def rst_paragraph(paragraph: str, level: int = 0) -> str:
-    """Return a formatted paragraph"""
-    return headroom(level) + paragraph
-
-
-def rst_bullet(item: str, level: int = 0) -> str:
-    """Return a formatted a bullet"""
-    return headroom(level) + f"- {item}"
-
-
-def rst_subsection(title: str) -> str:
-    """Add a sub-section to the document"""
-    return f"{title}\n" + "-" * len(title)
-
-
-def rst_subsubsection(title: str) -> str:
-    """Add a sub-sub-section to the document"""
-    return f"{title}\n" + "~" * len(title)
-
-
-def rst_section(namespace: str, prefix: str, title: str) -> str:
-    """Add a section to the document"""
-    return f".. _{namespace}-{prefix}-{title}:\n\n{title}\n" + "=" * len(title)
-
-
-def rst_subtitle(title: str) -> str:
-    """Add a subtitle to the document"""
-    return "\n" + "-" * len(title) + f"\n{title}\n" + "-" * len(title) + "\n\n"
-
-
-def rst_title(title: str) -> str:
-    """Add a title to the document"""
-    return "=" * len(title) + f"\n{title}\n" + "=" * len(title) + "\n\n"
-
-
-def rst_list_inline(list_: List[str], level: int = 0) -> str:
-    """Format a list using inlines"""
-    return headroom(level) + "[" + ", ".join(inline(i) for i in list_) + "]"
-
-
-def rst_ref(namespace: str, prefix: str, name: str) -> str:
-    """Add a hyperlink to the document"""
-    mappings = {'enum': 'definition',
-                'fixed-header': 'definition',
-                'nested-attributes': 'attribute-set',
-                'struct': 'definition'}
-    if prefix in mappings:
-        prefix = mappings[prefix]
-    return f":ref:`{namespace}-{prefix}-{name}`"
-
-
-def rst_header() -> str:
-    """The headers for all the auto generated RST files"""
-    lines = []
-
-    lines.append(rst_paragraph(".. SPDX-License-Identifier: GPL-2.0"))
-    lines.append(rst_paragraph(".. NOTE: This document was auto-generated.\n\n"))
-
-    return "\n".join(lines)
-
-
-def rst_toctree(maxdepth: int = 2) -> str:
-    """Generate a toctree RST primitive"""
-    lines = []
-
-    lines.append(".. toctree::")
-    lines.append(f"   :maxdepth: {maxdepth}\n\n")
-
-    return "\n".join(lines)
-
-
-def rst_label(title: str) -> str:
-    """Return a formatted label"""
-    return f".. _{title}:\n\n"
-
-
-# Parsers
-# =======
-
-
-def parse_mcast_group(mcast_group: List[Dict[str, Any]]) -> str:
-    """Parse 'multicast' group list and return a formatted string"""
-    lines = []
-    for group in mcast_group:
-        lines.append(rst_bullet(group["name"]))
-
-    return "\n".join(lines)
-
-
-def parse_do(do_dict: Dict[str, Any], level: int = 0) -> str:
-    """Parse 'do' section and return a formatted string"""
-    lines = []
-    for key in do_dict.keys():
-        lines.append(rst_paragraph(bold(key), level + 1))
-        if key in ['request', 'reply']:
-            lines.append(parse_do_attributes(do_dict[key], level + 1) + "\n")
-        else:
-            lines.append(headroom(level + 2) + do_dict[key] + "\n")
-
-    return "\n".join(lines)
-
-
-def parse_do_attributes(attrs: Dict[str, Any], level: int = 0) -> str:
-    """Parse 'attributes' section"""
-    if "attributes" not in attrs:
-        return ""
-    lines = [rst_fields("attributes", rst_list_inline(attrs["attributes"]), level + 1)]
-
-    return "\n".join(lines)
-
-
-def parse_operations(operations: List[Dict[str, Any]], namespace: str) -> str:
-    """Parse operations block"""
-    preprocessed = ["name", "doc", "title", "do", "dump", "flags"]
-    linkable = ["fixed-header", "attribute-set"]
-    lines = []
-
-    for operation in operations:
-        lines.append(rst_section(namespace, 'operation', operation["name"]))
-        lines.append(rst_paragraph(operation["doc"]) + "\n")
-
-        for key in operation.keys():
-            if key in preprocessed:
-                # Skip the special fields
-                continue
-            value = operation[key]
-            if key in linkable:
-                value = rst_ref(namespace, key, value)
-            lines.append(rst_fields(key, value, 0))
-        if 'flags' in operation:
-            lines.append(rst_fields('flags', rst_list_inline(operation['flags'])))
-
-        if "do" in operation:
-            lines.append(rst_paragraph(":do:", 0))
-            lines.append(parse_do(operation["do"], 0))
-        if "dump" in operation:
-            lines.append(rst_paragraph(":dump:", 0))
-            lines.append(parse_do(operation["dump"], 0))
-
-        # New line after fields
-        lines.append("\n")
-
-    return "\n".join(lines)
-
-
-def parse_entries(entries: List[Dict[str, Any]], level: int) -> str:
-    """Parse a list of entries"""
-    ignored = ["pad"]
-    lines = []
-    for entry in entries:
-        if isinstance(entry, dict):
-            # entries could be a list or a dictionary
-            field_name = entry.get("name", "")
-            if field_name in ignored:
-                continue
-            type_ = entry.get("type")
-            if type_:
-                field_name += f" ({inline(type_)})"
-            lines.append(
-                rst_fields(field_name, sanitize(entry.get("doc", "")), level)
-            )
-        elif isinstance(entry, list):
-            lines.append(rst_list_inline(entry, level))
-        else:
-            lines.append(rst_bullet(inline(sanitize(entry)), level))
-
-    lines.append("\n")
-    return "\n".join(lines)
-
-
-def parse_definitions(defs: Dict[str, Any], namespace: str) -> str:
-    """Parse definitions section"""
-    preprocessed = ["name", "entries", "members"]
-    ignored = ["render-max"]  # This is not printed
-    lines = []
-
-    for definition in defs:
-        lines.append(rst_section(namespace, 'definition', definition["name"]))
-        for k in definition.keys():
-            if k in preprocessed + ignored:
-                continue
-            lines.append(rst_fields(k, sanitize(definition[k]), 0))
-
-        # Field list needs to finish with a new line
-        lines.append("\n")
-        if "entries" in definition:
-            lines.append(rst_paragraph(":entries:", 0))
-            lines.append(parse_entries(definition["entries"], 1))
-        if "members" in definition:
-            lines.append(rst_paragraph(":members:", 0))
-            lines.append(parse_entries(definition["members"], 1))
-
-    return "\n".join(lines)
-
-
-def parse_attr_sets(entries: List[Dict[str, Any]], namespace: str) -> str:
-    """Parse attribute from attribute-set"""
-    preprocessed = ["name", "type"]
-    linkable = ["enum", "nested-attributes", "struct", "sub-message"]
-    ignored = ["checks"]
-    lines = []
-
-    for entry in entries:
-        lines.append(rst_section(namespace, 'attribute-set', entry["name"]))
-        for attr in entry["attributes"]:
-            type_ = attr.get("type")
-            attr_line = attr["name"]
-            if type_:
-                # Add the attribute type in the same line
-                attr_line += f" ({inline(type_)})"
-
-            lines.append(rst_subsubsection(attr_line))
-
-            for k in attr.keys():
-                if k in preprocessed + ignored:
-                    continue
-                if k in linkable:
-                    value = rst_ref(namespace, k, attr[k])
-                else:
-                    value = sanitize(attr[k])
-                lines.append(rst_fields(k, value, 0))
-            lines.append("\n")
-
-    return "\n".join(lines)
-
-
-def parse_sub_messages(entries: List[Dict[str, Any]], namespace: str) -> str:
-    """Parse sub-message definitions"""
-    lines = []
-
-    for entry in entries:
-        lines.append(rst_section(namespace, 'sub-message', entry["name"]))
-        for fmt in entry["formats"]:
-            value = fmt["value"]
-
-            lines.append(rst_bullet(bold(value)))
-            for attr in ['fixed-header', 'attribute-set']:
-                if attr in fmt:
-                    lines.append(rst_fields(attr,
-                                            rst_ref(namespace, attr, fmt[attr]),
-                                            1))
-            lines.append("\n")
-
-    return "\n".join(lines)
-
-
-def parse_yaml(obj: Dict[str, Any]) -> str:
-    """Format the whole YAML into a RST string"""
-    lines = []
-
-    # Main header
-
-    family = obj['name']
-
-    lines.append(rst_header())
-    lines.append(rst_label("netlink-" + family))
-
-    title = f"Family ``{family}`` netlink specification"
-    lines.append(rst_title(title))
-    lines.append(rst_paragraph(".. contents:: :depth: 3\n"))
-
-    if "doc" in obj:
-        lines.append(rst_subtitle("Summary"))
-        lines.append(rst_paragraph(obj["doc"], 0))
-
-    # Operations
-    if "operations" in obj:
-        lines.append(rst_subtitle("Operations"))
-        lines.append(parse_operations(obj["operations"]["list"], family))
-
-    # Multicast groups
-    if "mcast-groups" in obj:
-        lines.append(rst_subtitle("Multicast groups"))
-        lines.append(parse_mcast_group(obj["mcast-groups"]["list"]))
-
-    # Definitions
-    if "definitions" in obj:
-        lines.append(rst_subtitle("Definitions"))
-        lines.append(parse_definitions(obj["definitions"], family))
-
-    # Attributes set
-    if "attribute-sets" in obj:
-        lines.append(rst_subtitle("Attribute sets"))
-        lines.append(parse_attr_sets(obj["attribute-sets"], family))
-
-    # Sub-messages
-    if "sub-messages" in obj:
-        lines.append(rst_subtitle("Sub-messages"))
-        lines.append(parse_sub_messages(obj["sub-messages"], family))
-
-    return "\n".join(lines)
-
-
-# Main functions
-# ==============
 
+sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
+from lib import YnlDocGenerator    # pylint: disable=C0413
 
 def parse_arguments() -> argparse.Namespace:
     """Parse arguments from user"""
@@ -392,15 +55,6 @@ def parse_arguments() -> argparse.Namespace:
     return args
 
 
-def parse_yaml_file(filename: str) -> str:
-    """Transform the YAML specified by filename into an RST-formatted string"""
-    with open(filename, "r", encoding="utf-8") as spec_file:
-        yaml_data = yaml.safe_load(spec_file)
-        content = parse_yaml(yaml_data)
-
-    return content
-
-
 def write_to_rstfile(content: str, filename: str) -> None:
     """Write the generated content into an RST file"""
     logging.debug("Saving RST file to %s", filename)
@@ -411,7 +65,6 @@ def write_to_rstfile(content: str, filename: str) -> None:
 
 def generate_main_index_rst(output: str) -> None:
     """Generate the `networking_spec/index` content and write to the file"""
-    lines = []
 
     lines.append(rst_header())
     lines.append(rst_label("specs"))
@@ -426,7 +79,7 @@ def generate_main_index_rst(output: str) -> None:
         lines.append(f"   {filename.replace('.rst', '')}\n")
 
     logging.debug("Writing an index file at %s", output)
-    write_to_rstfile("".join(lines), output)
+    write_to_rstfile(msg, output)
 
 
 def main() -> None:
@@ -434,10 +87,12 @@ def main() -> None:
 
     args = parse_arguments()
 
+    parser = YnlDocGenerator()
+
     if args.input:
         logging.debug("Parsing %s", args.input)
         try:
-            content = parse_yaml_file(os.path.join(args.input))
+            content = parser.parse_yaml_file(os.path.join(args.input))
         except Exception as exception:
             logging.warning("Failed to parse %s.", args.input)
             logging.warning(exception)
-- 
2.49.0


