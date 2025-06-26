Return-Path: <netdev+bounces-201458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E685AE97E3
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3079F4A4966
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA7D25E46A;
	Thu, 26 Jun 2025 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4Zh87Pa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEB628727A;
	Thu, 26 Jun 2025 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925630; cv=none; b=Fpg6p4c43eWw8KejmcxP8XIiTSwbwPpFiHaIQdncYyHoAnol/Hoa414gsjr5ZUJZfwk/zwvaL5hr/hp08/ZW+ZnGBkVT8foJxPYIqUtmPoswl5pRC0ghd8yUxsdaW7wmwRmgysethyCuy9RmO7R4fogzD4Gw+KCSNHahdObjev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925630; c=relaxed/simple;
	bh=h3lg/MPxA2UEDbTu8Auv0CyvDYYqbxBicz9ilF8rLOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnSPlDRHF+FOhvMp844G3KQiHRKIb5y2oWzgL6qd7qcXd0mvlFDfvFleattdw++nWtMDGFX9ssEdrGQWJl+uiiyJglz+Fes/7UarjD/rxIK0SrNiezoJ3IATGUvbomUsF9fJ2Qf15E0KZaA4n9mQasuEDLdSD/FfiUj1qMeI2Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4Zh87Pa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91B5C4CEF2;
	Thu, 26 Jun 2025 08:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750925630;
	bh=h3lg/MPxA2UEDbTu8Auv0CyvDYYqbxBicz9ilF8rLOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j4Zh87PaKi/PobZcLvLK/DRW3EAZI2UBddYl0dSNgFrf1wvFgjKFLs3SyKfepffAV
	 +W7wHUvem3wOd85zAA0VY5s+qNlTcA8Rnn1RKknR7ts0zFIvAXoDdoNK4c3yT7i9Np
	 GkgH7U+Q8w5X36+sS+OMu1SpGM7htKYqbSXjPQVGeaIb/9NKNlcRrrC/j6CxOjY43T
	 fKwCVA9scYV1A9RpnAe5z8dJFyNKjLZfWYedADVnqeaxyGPx18BnXz37vzkZFIxXZn
	 0Jayt1iYbMQKbitKkqS3b2JaCqxIzRb6cp9WBEOmfnTYv1jIWrj6KepBcQS7mDkzRf
	 4VxLZG2oVzyYw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uUhjT-00000004swA-2JQL;
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
Subject: [PATCH v8 12/13] docs: parser_yaml.py: add support for line numbers from the parser
Date: Thu, 26 Jun 2025 10:13:08 +0200
Message-ID: <46f50d33765aaf9755a788be4aa61ff8d956da8e.1750925410.git.mchehab+huawei@kernel.org>
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


