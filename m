Return-Path: <netdev+bounces-197744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ACCAD9B91
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A65417C7D5
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AAE2C08B6;
	Sat, 14 Jun 2025 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqnZtDHr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B942E29826A;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749891378; cv=none; b=fFTf4QpYlzaxnF9Zd2tnlyXm3MTHruliOdhTSkIBnQJUruj8nuIq1BVo3fcCJMrBR+Tf7W0RL5Yz5/jKmFOHl6UqaFMEFVaGQWAqmwHQuR2j6Wft9tmHVEnAhRxyf50nWvGcZLo4PXO3VUbeTptvOrorFNwriKdS5UkHF/RVhx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749891378; c=relaxed/simple;
	bh=cha/mIMe25mR2f/nu4En+YRz7qL3BMOeexKVvY2Yu/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJbcKAOxZxEiHmU4PYgJ5ZO8NvKK9rtrwaVVEvOJzDU0aEynILVD9F5MLDx9/yJ6bRjevwizY0FQs2Fl4SxVKqiq90VetN8gSxDg4/H/AlVT0uLrHOPklrGsacY+VFGgrAkfKA5rtx/RM8aZJkV4VaTTk90sYv9sUXXF/hELerw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqnZtDHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F9FC4CEF5;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749891378;
	bh=cha/mIMe25mR2f/nu4En+YRz7qL3BMOeexKVvY2Yu/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KqnZtDHraGKNNbKbCCAKRMSsQUE0ruP98DMLFAZcNzEAX8sT+t/XibtVUMXGCnntG
	 BZz/Rz66HC6zoE+iT4ciZxuZNYy+xfP7H1WPHGofEte/TQNLXMRlhq9ztUha8a0Mrd
	 LKDcbYhBh9/PHXp2IAlfOb10ZGmV6B50eLueLQYqVxQWQoasVzc8MbKl/8Q49sGEZT
	 rpU+5mL5InGoUnTRJ1s9Eht8EQFTqm5EME3GTgL+mzFcTihOh7dZh4qYvOb7ilRwKn
	 mfhXeea12LG6Hr9CSHDT6w9Qmz/g9lGdW4Vz7coibYC1JzH3fCnUQfhWnqftmwlf+W
	 6z7ZH7+Nap2IQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uQMgS-000000064ax-0iCK;
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
Subject: [PATCH v4 05/14] tools: ynl_gen_rst.py: Split library from command line tool
Date: Sat, 14 Jun 2025 10:55:59 +0200
Message-ID: <440956b08faee14ed22575bea6c7b022666e5402.1749891128.git.mchehab+huawei@kernel.org>
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

As we'll be using the Netlink specs parser inside a Sphinx
extension, move the library part from the command line parser.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/lib/netlink_yml_parser.py  | 391 +++++++++++++++++++++++++++++
 tools/net/ynl/pyynl/ynl_gen_rst.py | 374 +--------------------------
 2 files changed, 401 insertions(+), 364 deletions(-)
 create mode 100755 scripts/lib/netlink_yml_parser.py

diff --git a/scripts/lib/netlink_yml_parser.py b/scripts/lib/netlink_yml_parser.py
new file mode 100755
index 000000000000..3c15b578f947
--- /dev/null
+++ b/scripts/lib/netlink_yml_parser.py
@@ -0,0 +1,391 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# -*- coding: utf-8; mode: python -*-
+
+"""
+    Script to auto generate the documentation for Netlink specifications.
+
+    :copyright:  Copyright (C) 2023  Breno Leitao <leitao@debian.org>
+    :license:    GPL Version 2, June 1991 see linux/COPYING for details.
+
+    This script performs extensive parsing to the Linux kernel's netlink YAML
+    spec files, in an effort to avoid needing to heavily mark up the original
+    YAML file.
+
+    This code is split in three big parts:
+        1) RST formatters: Use to convert a string to a RST output
+        2) Parser helpers: Functions to parse the YAML data structure
+        3) Main function and small helpers
+"""
+
+from typing import Any, Dict, List
+import os.path
+import logging
+import yaml
+
+
+SPACE_PER_LEVEL = 4
+
+
+# RST Formatters
+# ==============
+def headroom(level: int) -> str:
+    """Return space to format"""
+    return " " * (level * SPACE_PER_LEVEL)
+
+
+def bold(text: str) -> str:
+    """Format bold text"""
+    return f"**{text}**"
+
+
+def inline(text: str) -> str:
+    """Format inline text"""
+    return f"``{text}``"
+
+
+def sanitize(text: str) -> str:
+    """Remove newlines and multiple spaces"""
+    # This is useful for some fields that are spread across multiple lines
+    return str(text).replace("\n", " ").strip()
+
+
+def rst_fields(key: str, value: str, level: int = 0) -> str:
+    """Return a RST formatted field"""
+    return headroom(level) + f":{key}: {value}"
+
+
+def rst_definition(key: str, value: Any, level: int = 0) -> str:
+    """Format a single rst definition"""
+    return headroom(level) + key + "\n" + headroom(level + 1) + str(value)
+
+
+def rst_paragraph(paragraph: str, level: int = 0) -> str:
+    """Return a formatted paragraph"""
+    return headroom(level) + paragraph
+
+
+def rst_bullet(item: str, level: int = 0) -> str:
+    """Return a formatted a bullet"""
+    return headroom(level) + f"- {item}"
+
+
+def rst_subsection(title: str) -> str:
+    """Add a sub-section to the document"""
+    return f"{title}\n" + "-" * len(title)
+
+
+def rst_subsubsection(title: str) -> str:
+    """Add a sub-sub-section to the document"""
+    return f"{title}\n" + "~" * len(title)
+
+
+def rst_section(namespace: str, prefix: str, title: str) -> str:
+    """Add a section to the document"""
+    return f".. _{namespace}-{prefix}-{title}:\n\n{title}\n" + "=" * len(title)
+
+
+def rst_subtitle(title: str) -> str:
+    """Add a subtitle to the document"""
+    return "\n" + "-" * len(title) + f"\n{title}\n" + "-" * len(title) + "\n\n"
+
+
+def rst_title(title: str) -> str:
+    """Add a title to the document"""
+    return "=" * len(title) + f"\n{title}\n" + "=" * len(title) + "\n\n"
+
+
+def rst_list_inline(list_: List[str], level: int = 0) -> str:
+    """Format a list using inlines"""
+    return headroom(level) + "[" + ", ".join(inline(i) for i in list_) + "]"
+
+
+def rst_ref(namespace: str, prefix: str, name: str) -> str:
+    """Add a hyperlink to the document"""
+    mappings = {'enum': 'definition',
+                'fixed-header': 'definition',
+                'nested-attributes': 'attribute-set',
+                'struct': 'definition'}
+    if prefix in mappings:
+        prefix = mappings[prefix]
+    return f":ref:`{namespace}-{prefix}-{name}`"
+
+
+def rst_header() -> str:
+    """The headers for all the auto generated RST files"""
+    lines = []
+
+    lines.append(rst_paragraph(".. SPDX-License-Identifier: GPL-2.0"))
+    lines.append(rst_paragraph(".. NOTE: This document was auto-generated.\n\n"))
+
+    return "\n".join(lines)
+
+
+def rst_toctree(maxdepth: int = 2) -> str:
+    """Generate a toctree RST primitive"""
+    lines = []
+
+    lines.append(".. toctree::")
+    lines.append(f"   :maxdepth: {maxdepth}\n\n")
+
+    return "\n".join(lines)
+
+
+def rst_label(title: str) -> str:
+    """Return a formatted label"""
+    return f".. _{title}:\n\n"
+
+
+# Parsers
+# =======
+
+
+def parse_mcast_group(mcast_group: List[Dict[str, Any]]) -> str:
+    """Parse 'multicast' group list and return a formatted string"""
+    lines = []
+    for group in mcast_group:
+        lines.append(rst_bullet(group["name"]))
+
+    return "\n".join(lines)
+
+
+def parse_do(do_dict: Dict[str, Any], level: int = 0) -> str:
+    """Parse 'do' section and return a formatted string"""
+    lines = []
+    for key in do_dict.keys():
+        lines.append(rst_paragraph(bold(key), level + 1))
+        if key in ['request', 'reply']:
+            lines.append(parse_do_attributes(do_dict[key], level + 1) + "\n")
+        else:
+            lines.append(headroom(level + 2) + do_dict[key] + "\n")
+
+    return "\n".join(lines)
+
+
+def parse_do_attributes(attrs: Dict[str, Any], level: int = 0) -> str:
+    """Parse 'attributes' section"""
+    if "attributes" not in attrs:
+        return ""
+    lines = [rst_fields("attributes", rst_list_inline(attrs["attributes"]), level + 1)]
+
+    return "\n".join(lines)
+
+
+def parse_operations(operations: List[Dict[str, Any]], namespace: str) -> str:
+    """Parse operations block"""
+    preprocessed = ["name", "doc", "title", "do", "dump", "flags"]
+    linkable = ["fixed-header", "attribute-set"]
+    lines = []
+
+    for operation in operations:
+        lines.append(rst_section(namespace, 'operation', operation["name"]))
+        lines.append(rst_paragraph(operation["doc"]) + "\n")
+
+        for key in operation.keys():
+            if key in preprocessed:
+                # Skip the special fields
+                continue
+            value = operation[key]
+            if key in linkable:
+                value = rst_ref(namespace, key, value)
+            lines.append(rst_fields(key, value, 0))
+        if 'flags' in operation:
+            lines.append(rst_fields('flags', rst_list_inline(operation['flags'])))
+
+        if "do" in operation:
+            lines.append(rst_paragraph(":do:", 0))
+            lines.append(parse_do(operation["do"], 0))
+        if "dump" in operation:
+            lines.append(rst_paragraph(":dump:", 0))
+            lines.append(parse_do(operation["dump"], 0))
+
+        # New line after fields
+        lines.append("\n")
+
+    return "\n".join(lines)
+
+
+def parse_entries(entries: List[Dict[str, Any]], level: int) -> str:
+    """Parse a list of entries"""
+    ignored = ["pad"]
+    lines = []
+    for entry in entries:
+        if isinstance(entry, dict):
+            # entries could be a list or a dictionary
+            field_name = entry.get("name", "")
+            if field_name in ignored:
+                continue
+            type_ = entry.get("type")
+            if type_:
+                field_name += f" ({inline(type_)})"
+            lines.append(
+                rst_fields(field_name, sanitize(entry.get("doc", "")), level)
+            )
+        elif isinstance(entry, list):
+            lines.append(rst_list_inline(entry, level))
+        else:
+            lines.append(rst_bullet(inline(sanitize(entry)), level))
+
+    lines.append("\n")
+    return "\n".join(lines)
+
+
+def parse_definitions(defs: Dict[str, Any], namespace: str) -> str:
+    """Parse definitions section"""
+    preprocessed = ["name", "entries", "members"]
+    ignored = ["render-max"]  # This is not printed
+    lines = []
+
+    for definition in defs:
+        lines.append(rst_section(namespace, 'definition', definition["name"]))
+        for k in definition.keys():
+            if k in preprocessed + ignored:
+                continue
+            lines.append(rst_fields(k, sanitize(definition[k]), 0))
+
+        # Field list needs to finish with a new line
+        lines.append("\n")
+        if "entries" in definition:
+            lines.append(rst_paragraph(":entries:", 0))
+            lines.append(parse_entries(definition["entries"], 1))
+        if "members" in definition:
+            lines.append(rst_paragraph(":members:", 0))
+            lines.append(parse_entries(definition["members"], 1))
+
+    return "\n".join(lines)
+
+
+def parse_attr_sets(entries: List[Dict[str, Any]], namespace: str) -> str:
+    """Parse attribute from attribute-set"""
+    preprocessed = ["name", "type"]
+    linkable = ["enum", "nested-attributes", "struct", "sub-message"]
+    ignored = ["checks"]
+    lines = []
+
+    for entry in entries:
+        lines.append(rst_section(namespace, 'attribute-set', entry["name"]))
+        for attr in entry["attributes"]:
+            type_ = attr.get("type")
+            attr_line = attr["name"]
+            if type_:
+                # Add the attribute type in the same line
+                attr_line += f" ({inline(type_)})"
+
+            lines.append(rst_subsubsection(attr_line))
+
+            for k in attr.keys():
+                if k in preprocessed + ignored:
+                    continue
+                if k in linkable:
+                    value = rst_ref(namespace, k, attr[k])
+                else:
+                    value = sanitize(attr[k])
+                lines.append(rst_fields(k, value, 0))
+            lines.append("\n")
+
+    return "\n".join(lines)
+
+
+def parse_sub_messages(entries: List[Dict[str, Any]], namespace: str) -> str:
+    """Parse sub-message definitions"""
+    lines = []
+
+    for entry in entries:
+        lines.append(rst_section(namespace, 'sub-message', entry["name"]))
+        for fmt in entry["formats"]:
+            value = fmt["value"]
+
+            lines.append(rst_bullet(bold(value)))
+            for attr in ['fixed-header', 'attribute-set']:
+                if attr in fmt:
+                    lines.append(rst_fields(attr,
+                                            rst_ref(namespace, attr, fmt[attr]),
+                                            1))
+            lines.append("\n")
+
+    return "\n".join(lines)
+
+
+def parse_yaml(obj: Dict[str, Any]) -> str:
+    """Format the whole YAML into a RST string"""
+    lines = []
+
+    # Main header
+
+    family = obj['name']
+
+    lines.append(rst_header())
+    lines.append(rst_label("netlink-" + family))
+
+    title = f"Family ``{family}`` netlink specification"
+    lines.append(rst_title(title))
+    lines.append(rst_paragraph(".. contents:: :depth: 3\n"))
+
+    if "doc" in obj:
+        lines.append(rst_subtitle("Summary"))
+        lines.append(rst_paragraph(obj["doc"], 0))
+
+    # Operations
+    if "operations" in obj:
+        lines.append(rst_subtitle("Operations"))
+        lines.append(parse_operations(obj["operations"]["list"], family))
+
+    # Multicast groups
+    if "mcast-groups" in obj:
+        lines.append(rst_subtitle("Multicast groups"))
+        lines.append(parse_mcast_group(obj["mcast-groups"]["list"]))
+
+    # Definitions
+    if "definitions" in obj:
+        lines.append(rst_subtitle("Definitions"))
+        lines.append(parse_definitions(obj["definitions"], family))
+
+    # Attributes set
+    if "attribute-sets" in obj:
+        lines.append(rst_subtitle("Attribute sets"))
+        lines.append(parse_attr_sets(obj["attribute-sets"], family))
+
+    # Sub-messages
+    if "sub-messages" in obj:
+        lines.append(rst_subtitle("Sub-messages"))
+        lines.append(parse_sub_messages(obj["sub-messages"], family))
+
+    return "\n".join(lines)
+
+
+# Main functions
+# ==============
+
+
+def parse_yaml_file(filename: str) -> str:
+    """Transform the YAML specified by filename into an RST-formatted string"""
+    with open(filename, "r", encoding="utf-8") as spec_file:
+        yaml_data = yaml.safe_load(spec_file)
+        content = parse_yaml(yaml_data)
+
+    return content
+
+
+def generate_main_index_rst(output: str, index_dir: str) -> str:
+    """Generate the `networking_spec/index` content and write to the file"""
+    lines = []
+
+    lines.append(rst_header())
+    lines.append(rst_label("specs"))
+    lines.append(rst_title("Netlink Family Specifications"))
+    lines.append(rst_toctree(1))
+
+    index_fname = os.path.basename(output)
+    base, ext = os.path.splitext(index_fname)
+
+    if not index_dir:
+        index_dir = os.path.dirname(output)
+
+    logging.debug(f"Looking for {ext} files in %s", index_dir)
+    for filename in sorted(os.listdir(index_dir)):
+        if not filename.endswith(ext) or filename == index_fname:
+            continue
+        base, ext = os.path.splitext(filename)
+        lines.append(f"   {base}\n")
+
+    return "".join(lines), output
diff --git a/tools/net/ynl/pyynl/ynl_gen_rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
index b1e5acafb998..38dafe3d9179 100755
--- a/tools/net/ynl/pyynl/ynl_gen_rst.py
+++ b/tools/net/ynl/pyynl/ynl_gen_rst.py
@@ -18,345 +18,17 @@
         3) Main function and small helpers
 """
 
-from typing import Any, Dict, List
 import os.path
 import sys
 import argparse
 import logging
-import yaml
 
+LIB_DIR = "../../../../scripts/lib"
+SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 
-SPACE_PER_LEVEL = 4
+sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
 
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
+from netlink_yml_parser import parse_yaml_file, generate_main_index_rst
 
 
 def parse_arguments() -> argparse.Namespace:
@@ -393,50 +65,24 @@ def parse_arguments() -> argparse.Namespace:
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
 
-    dir = os.path.dirname(filename)
-    os.makedirs(dir, exist_ok=True)
+    directory = os.path.dirname(filename)
+    os.makedirs(directory, exist_ok=True)
 
     with open(filename, "w", encoding="utf-8") as rst_file:
         rst_file.write(content)
 
 
-def generate_main_index_rst(output: str, index_dir: str) -> None:
+def write_index_rst(output: str, index_dir: str) -> None:
     """Generate the `networking_spec/index` content and write to the file"""
-    lines = []
 
-    lines.append(rst_header())
-    lines.append(rst_label("specs"))
-    lines.append(rst_title("Netlink Family Specifications"))
-    lines.append(rst_toctree(1))
-
-    index_fname = os.path.basename(output)
-    base, ext = os.path.splitext(index_fname)
-
-    if not index_dir:
-        index_dir = os.path.dirname(output)
-
-    logging.debug(f"Looking for {ext} files in %s", index_dir)
-    for filename in sorted(os.listdir(index_dir)):
-        if not filename.endswith(ext) or filename == index_fname:
-            continue
-        base, ext = os.path.splitext(filename)
-        lines.append(f"   {base}\n")
+    msg = generate_main_index_rst(output, index_dir)
 
     logging.debug("Writing an index file at %s", output)
-    write_to_rstfile("".join(lines), output)
+    write_to_rstfile(msg, output)
 
 
 def main() -> None:
@@ -457,7 +103,7 @@ def main() -> None:
 
     if args.index:
         # Generate the index RST file
-        generate_main_index_rst(args.output, args.input_dir)
+        write_index_rst(args.output, args.input_dir)
 
 
 if __name__ == "__main__":
-- 
2.49.0


