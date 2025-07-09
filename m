Return-Path: <netdev+bounces-205487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D96AFEE73
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 18:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317CE7609CF
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 16:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D3B2EACFB;
	Wed,  9 Jul 2025 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+601J0p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F8D2EA726;
	Wed,  9 Jul 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076750; cv=none; b=POB3he+ffWINYNdUkn5MokZ38AvQcTM1hwWp320QgJty3yHDA2aFu/VA6hpZZbj5ew6ul6uUbSkDMbTe1j6E9zL1GmK6KpnXY/HOvZvc1bZayXMYRukSOr8AmeyX0OY4yK0Wv+fhdzvehIsQIoenouvnQOkfscexO0+vIaGyNcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076750; c=relaxed/simple;
	bh=otVjsBKFUHYlcqJjnUpXdq/CVdL2g8H+2Ln8zBoihTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGiZ87Iqd61RddGrW4zNedkwoV0XfZD7SUbql0+fSljt9Qka2qlBgpeTyT7MSpGSZnz/pT1Bz/yZv2/6RYsdwIhveQdk0OONf6qehs2hglXDjJRaMxWetlQIDpFjQJxPHlnuH35GBSXtbLO9MLonQdcyr2xf4vBbaeKgG2ZOFUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+601J0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF46CC4CEF1;
	Wed,  9 Jul 2025 15:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752076749;
	bh=otVjsBKFUHYlcqJjnUpXdq/CVdL2g8H+2Ln8zBoihTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b+601J0p0iRyivZ6yAx7xrhjVd+dWUdu0glKR1yPcAp5JvDNCr5lp4DSCCK3ODBW1
	 kxZCWmlli2aigSoqfuu3L9Xdf4bP8DN6gjKmwYktMpwpMsTVG6/7+gGG84aY8aPNml
	 an1KpUZHHEOXWobftkWEyHz66qJwihP7L5iPGJ1h6CrRUm2vMcaIs1hy5f2IzElOS2
	 Ovq1tQHYh8Dyfuh5UBQtzV/3buuLMRwEZyw6dgwf6zniKQncWveo4T85WD4acNpnFO
	 TrYme7dd/hcryDmdFB2a+DhasF4u8PnPFtsaInYUCdDOf7uy467A08FOVrH82g8EUk
	 hDia6RrP+UpEA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZXCJ-00000000IhN-22TJ;
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
Subject: [PATCH v9 12/13] docs: parser_yaml.py: add support for line numbers from the parser
Date: Wed,  9 Jul 2025 17:58:56 +0200
Message-ID: <3b18b30b1b50b01a014fd4b5a38423e529cde2fb.1752076293.git.mchehab+huawei@kernel.org>
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

Instead of printing line numbers from the temp converted ReST
file, get them from the original source.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/parser_yaml.py      | 12 ++++++++++--
 tools/net/ynl/pyynl/lib/doc_generator.py | 16 ++++++++++++----
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
index fa2e6da17617..8288e2ff7c7c 100755
--- a/Documentation/sphinx/parser_yaml.py
+++ b/Documentation/sphinx/parser_yaml.py
@@ -54,6 +54,8 @@ class YamlParser(Parser):
 
     netlink_parser = YnlDocGenerator()
 
+    re_lineno = re.compile(r"\.\. LINENO ([0-9]+)$")
+
     def rst_parse(self, inputstring, document, msg):
         """
         Receives a ReST content that was previously converted by the
@@ -66,8 +68,14 @@ class YamlParser(Parser):
 
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
index 658759a527a6..403abf1a2eda 100644
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


