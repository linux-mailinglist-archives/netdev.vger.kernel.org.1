Return-Path: <netdev+bounces-205485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD2FAFEE61
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 18:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C3527ADF03
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88D42EACF8;
	Wed,  9 Jul 2025 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4D6LToG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AF62EA725;
	Wed,  9 Jul 2025 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076750; cv=none; b=qvfyVubRHnK7BxYvxj3gjjyaQYr1R1dexvXxvzMULdWA7D0kNdkxuxuVLlSsA1xJlj78+YcJst6/bObxzyZRAvrIBQuU2WhmzDdgMIAIJW4tH824+0jRCxgqEWoIpNOiK/lXkpNvGkyYmrEpB+JiKEBmIyt0or4G6ortM9556ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076750; c=relaxed/simple;
	bh=deh3Qwq57w+TnIRPLss0GAT2BTvn4TViPnV+RhZDsuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/cFFcEZEKCjNyBfeVkNd6sFOeKHziNlZxGy4wkhGuICpyWodq1lWoT92jp05Ymv+JXWAAM9m4tx3yDdGu5Au8YPUFfou6KIbwVsb2B5oddSnN+Xq4BKkOEF72/R47J1m3v6eG2qkEQfFyxan5SBg7u7pm3T5gCZ9BsVJ66BCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4D6LToG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD034C4CEF7;
	Wed,  9 Jul 2025 15:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752076749;
	bh=deh3Qwq57w+TnIRPLss0GAT2BTvn4TViPnV+RhZDsuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L4D6LToGep7qFuZUBxRxHUl0C0jPpbHtfh7m9cEyPjYcphSOUbacjz9U66Khc4Zu6
	 a6NGHIc4SqIJ8lLaH9HKGHg9M7epnmc3RPk4QA5r9qCYsY3HvwM5phEXtlPugJTK+K
	 MlGzoPzgx2Lw5DrhcDAMsDQ02NrG24dnw+8A9f8pXmoWf2Aw4uNKCrHBK6eZgQ9CNp
	 2M5KhHt7az3oyFE1QfiEDYeiBt5j+m8m51+7eTMQAqMWlLOMWF/9gmqQU0D7cRpHy6
	 gW0ekcErkIyZ3yzxXxl6xIdogZfi1I9rkk7JIMTR3MtX3R6khDDiPTB9DzWbQYG10b
	 v+UIRSnIUoG2Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZXCJ-00000000IhK-1vZX;
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
Subject: [PATCH v9 11/13] tools: netlink_yml_parser.py: add line numbers to parsed data
Date: Wed,  9 Jul 2025 17:58:55 +0200
Message-ID: <dd8100c80209f147a4240e84ff32fb2daaeea4ac.1752076293.git.mchehab+huawei@kernel.org>
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

When something goes wrong, we want Sphinx error to point to the
right line number from the original source, not from the
processed ReST data.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/net/ynl/pyynl/lib/doc_generator.py | 34 ++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/doc_generator.py b/tools/net/ynl/pyynl/lib/doc_generator.py
index 474b2b78c7bc..658759a527a6 100644
--- a/tools/net/ynl/pyynl/lib/doc_generator.py
+++ b/tools/net/ynl/pyynl/lib/doc_generator.py
@@ -20,6 +20,16 @@
 from typing import Any, Dict, List
 import yaml
 
+LINE_STR = '__lineno__'
+
+class NumberedSafeLoader(yaml.SafeLoader):              # pylint: disable=R0901
+    """Override the SafeLoader class to add line number to parsed data"""
+
+    def construct_mapping(self, node, *args, **kwargs):
+        mapping = super().construct_mapping(node, *args, **kwargs)
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


