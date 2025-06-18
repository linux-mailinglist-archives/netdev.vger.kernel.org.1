Return-Path: <netdev+bounces-199023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28616ADEAC0
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BD317E637
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670E12E7639;
	Wed, 18 Jun 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skrqAHXT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295162DBF5B;
	Wed, 18 Jun 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247212; cv=none; b=ODVty495NJMsJet221E4FlF81hCGDjfH8cYGDXzFicAheuYQ1jbaSr+nuUsoo+4NK+k6+X1J2PJszAe7+lsN/DKAkK8xQvlYlHECOYroFTNgaJUVONWX1LIR1zjtQ0JacBQC8jgEcnFHYrCtgnlAXvaBSWN31uDQeEm31gFgYx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247212; c=relaxed/simple;
	bh=sLGX0eyqIoRSaJCtRaOhRqFB+mw5FlWjFBG7e4HNq2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/4UxkMLsTpQ81U0VLlnAXWdQ1ukA52uA5T8OLt//wQ/GSFDn7mHcJahGVaLoFfUGE8QWbVGztCTJq/3fcHm0wz8yvENJhVYrPHzp8DR8rWC8d7ZnbC65BAh/POa/P0gtTtFYLyHpn0oB55708KR/Y+HOqYTEkB9qPqrHEAdmbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skrqAHXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEB2C113CF;
	Wed, 18 Jun 2025 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750247211;
	bh=sLGX0eyqIoRSaJCtRaOhRqFB+mw5FlWjFBG7e4HNq2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=skrqAHXTbHNgSUzyZwiGm2Fupr9l61UiluGGSBvxmKD6r+ld9HPm3T/9gtlevsEN6
	 XYEIMvCdpCYWMAWMOv/sjIRwyu9+XIVe9F2260gT/2mGyR/T0esmbK6J4BcMZ5l0l9
	 nZ8L2eoAnaFoL60aFn+A2mj6Rbvj/yYuyxbr3Jp1XTH8PO93Mn8+ghO4bV2Z/gRanl
	 +0LXBRO3gvGxUgV2ZieuJg4JKdANstYjf0aKHJaKQLucOsPDKvOfj09pk7JZQIkrUw
	 Tf9PXDfi1cuumo4aRVBB1PWSa++psvYvq1kEOiJfK8v5YDRCHYbO4UguU2/eZNSjTq
	 WmJIGEttZ5UxA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRrFh-000000036VA-3PEz;
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
Subject: [PATCH v6 14/15] docs: parser_yaml.py: add support for line numbers from the parser
Date: Wed, 18 Jun 2025 13:46:41 +0200
Message-ID: <33fc2894166805b93d4cf652cff9927a54b4f242.1750246291.git.mchehab+huawei@kernel.org>
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

Instead of printing line numbers from the temp converted ReST
file, get them from the original source.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/parser_yaml.py      | 12 ++++++++++--
 tools/net/ynl/pyynl/lib/doc_generator.py | 16 ++++++++++++----
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
index 2b2af239a1c2..5360fcfd4fde 100755
--- a/Documentation/sphinx/parser_yaml.py
+++ b/Documentation/sphinx/parser_yaml.py
@@ -29,6 +29,8 @@ class YamlParser(Parser):
 
     netlink_parser = YnlDocGenerator()
 
+    re_lineno = re.compile(r"\.\. LINENO ([0-9]+)$")
+
     def do_parse(self, inputstring, document, msg):
         """Parse YAML and generate a document tree."""
 
@@ -38,8 +40,14 @@ class YamlParser(Parser):
 
         try:
             # Parse message with RSTParser
-            for i, line in enumerate(msg.split('\n')):
-                result.append(line, document.current_source, i)
+            lineoffset = 0;
+            for line in msg.split('\n'):
+                match = self.re_lineno.match(line)
+                if match:
+                    lineoffset = int(match.group(1))
+                    continue
+
+                result.append(line, document.current_source, lineoffset)
 
             rst_parser = RSTParser()
             rst_parser.parse('\n'.join(result), document)
diff --git a/tools/net/ynl/pyynl/lib/doc_generator.py b/tools/net/ynl/pyynl/lib/doc_generator.py
index a9d8ab6f2639..7f4f98983cdf 100644
--- a/tools/net/ynl/pyynl/lib/doc_generator.py
+++ b/tools/net/ynl/pyynl/lib/doc_generator.py
@@ -158,9 +158,11 @@ class YnlDocGenerator:
     def parse_do(self, do_dict: Dict[str, Any], level: int = 0) -> str:
         """Parse 'do' section and return a formatted string"""
         lines = []
+        if LINE_STR in do_dict:
+            lines.append(self.fmt.rst_lineno(do_dict[LINE_STR]))
+
         for key in do_dict.keys():
             if key == LINE_STR:
-                lines.append(self.fmt.rst_lineno(do_dict[key]))
                 continue
             lines.append(self.fmt.rst_paragraph(self.fmt.bold(key), level + 1))
             if key in ['request', 'reply']:
@@ -187,13 +189,15 @@ class YnlDocGenerator:
         lines = []
 
         for operation in operations:
+            if LINE_STR in operation:
+                lines.append(self.fmt.rst_lineno(operation[LINE_STR]))
+
             lines.append(self.fmt.rst_section(namespace, 'operation',
                                               operation["name"]))
             lines.append(self.fmt.rst_paragraph(operation["doc"]) + "\n")
 
             for key in operation.keys():
                 if key == LINE_STR:
-                    lines.append(self.fmt.rst_lineno(operation[key]))
                     continue
 
                 if key in preprocessed:
@@ -253,10 +257,12 @@ class YnlDocGenerator:
         lines = []
 
         for definition in defs:
+            if LINE_STR in definition:
+                lines.append(self.fmt.rst_lineno(definition[LINE_STR]))
+
             lines.append(self.fmt.rst_section(namespace, 'definition', definition["name"]))
             for k in definition.keys():
                 if k == LINE_STR:
-                    lines.append(self.fmt.rst_lineno(definition[k]))
                     continue
                 if k in preprocessed + ignored:
                     continue
@@ -284,6 +290,9 @@ class YnlDocGenerator:
             lines.append(self.fmt.rst_section(namespace, 'attribute-set',
                                               entry["name"]))
             for attr in entry["attributes"]:
+                if LINE_STR in attr:
+                    lines.append(self.fmt.rst_lineno(attr[LINE_STR]))
+
                 type_ = attr.get("type")
                 attr_line = attr["name"]
                 if type_:
@@ -294,7 +303,6 @@ class YnlDocGenerator:
 
                 for k in attr.keys():
                     if k == LINE_STR:
-                        lines.append(self.fmt.rst_lineno(attr[k]))
                         continue
                     if k in preprocessed + ignored:
                         continue
-- 
2.49.0


