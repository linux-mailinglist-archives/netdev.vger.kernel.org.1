Return-Path: <netdev+bounces-199347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E486ADFE20
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD363AA740
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 06:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F5C266B40;
	Thu, 19 Jun 2025 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD6qezGc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75E32586E0;
	Thu, 19 Jun 2025 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750315821; cv=none; b=qZn3mNEsfNfWHiPVUIPVSKB2pjOay5ADV74GNwbprFeFNyrZKpYtLEjOHwJxToLC7P1zcDKoLPl/YIzOfIc8e2fVeQFvV4o1UdAlVEesKT0iwXnRUVjW8iiEPOVnPMPhkA1/dZrm0Qh4ryJtFjhWpYEAPwI6sSLs2MQxRg7/U6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750315821; c=relaxed/simple;
	bh=sLGX0eyqIoRSaJCtRaOhRqFB+mw5FlWjFBG7e4HNq2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFkqSysymwHwzpEvs/PzdGFuCXGn224/mY5BO8Y3CYlkxBHSw6dJF+7S38fH4/l8uqSTYSFVjDPIWUgexNAhmGR57/2og9MDlb4JgSlxz8PICkg7tMK41W/wTW0fu6dFv0gSPYYBgkJekHC0BEwV7IMJpkLdjH62OdrUBLgY2E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD6qezGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C87C116C6;
	Thu, 19 Jun 2025 06:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750315821;
	bh=sLGX0eyqIoRSaJCtRaOhRqFB+mw5FlWjFBG7e4HNq2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YD6qezGcHVKgPQ7iY2lD7cpkxIaV5PL3Fxe5U1FafOwI8jTwRPpRQ/FXrwR6haiUu
	 tUqs4Xs+UJ1H+SfVGjlDWOHJRjo0E0DHLy9ShUlEQdWMQZXRI7LYIT5aPZho/6fa5C
	 nM01fd9UnTqcOM2wUB9R7dp5IUa2m8ViJS7k6vwanzEexFgUJRvuj7zjg3aPGV0CM/
	 1a5je6uD0RzxHKHod/rFGwc7lXt9Yjnp58nEqRJiaDGSDCI1NTRw7MIXjkrHE4KDrC
	 xBdr7yvuJkgJrzuW7+4pLjj7ZSAtkJ3RPRoloP0NMQc6jYrUkFEWMUw534K8IkZ1hg
	 ak7ljWm0E7vhQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uS96J-00000003dHR-0tQY;
	Thu, 19 Jun 2025 08:50:19 +0200
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
Subject: [PATCH v7 14/17] docs: parser_yaml.py: add support for line numbers from the parser
Date: Thu, 19 Jun 2025 08:49:07 +0200
Message-ID: <33fc2894166805b93d4cf652cff9927a54b4f242.1750315578.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750315578.git.mchehab+huawei@kernel.org>
References: <cover.1750315578.git.mchehab+huawei@kernel.org>
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


