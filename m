Return-Path: <netdev+bounces-199346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E3BADFE1F
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F190A1637CE
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 06:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9AB266595;
	Thu, 19 Jun 2025 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lppJ3Kzs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EC824BBFC;
	Thu, 19 Jun 2025 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750315821; cv=none; b=dffciLOzPK8WYEl6PEl7BBJHo3Gw94xRBfkQIbNWrCBd5/GVK1Jls7JOzmM8ZbPAgKPJQae92roHCUwb6siQGN7FQEIgflIdZZ5WUtDsT3VLjZFKkmp+4OSfb7InMf8lNwB6HdrG1cB03A+7kdiXsP8PR0XzPQcBRhR8qN7LdS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750315821; c=relaxed/simple;
	bh=ZRwnGGD63dY02hpT4BqTMDO35vMSt+NPRBYC3eA8F/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEe4QVw9rzzN38q6g1GsWlEuOROGu0FJmcVcraM9eiy2Cq1+QgBDPFhdBwAG62f9V9UqWxQXeDVlz175E1HF55O6phYOjqsiQxSI1opd6U6FUjBVQXHQhjtrkBapXPbwNRGXcGJw9XSJlf/D0eVZ+ekLY7gfg9o+ilUMacJoMmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lppJ3Kzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1548C4CEFF;
	Thu, 19 Jun 2025 06:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750315821;
	bh=ZRwnGGD63dY02hpT4BqTMDO35vMSt+NPRBYC3eA8F/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lppJ3KzscHSaHWzZ9sjS9vY3r4UEEUqSrZLPTMmyUlixmU7ZFp2yrBq8A/qJSQurG
	 qGCpQf5Oq6NNBh9ft13zG7+CjBQSUtikk5OjmQnAeGAQNqpBMPcjo+wfltFlQU8ECu
	 xjYBzLPSBFJPiDZ1VxGWn2EuXcyYq91GacRqujtuGLM73uvoZswZrf8JabUxnquydZ
	 HGaJRk4CHkyKD1/Axmz6JMVc5ZGGKELWxC5kaWdAkI11mS3aVHplSVAl3amoCNLvgZ
	 FFzwKe0h7iF8XVP6co4BOjtfHm6J9BS/SP92ml1cnGTtValji5f+FW9uhQXMD8WQz4
	 72lX1gSlhQm4w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uS96J-00000003dHM-0ll3;
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
Subject: [PATCH v7 13/17] tools: netlink_yml_parser.py: add line numbers to parsed data
Date: Thu, 19 Jun 2025 08:49:06 +0200
Message-ID: <21722a5346cfc3b8a0ad7427fca157cff032e2f0.1750315578.git.mchehab+huawei@kernel.org>
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


