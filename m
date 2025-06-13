Return-Path: <netdev+bounces-197453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA54AD8B11
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D766163BCA
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215CA2EA491;
	Fri, 13 Jun 2025 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmGIdAIs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5339A2E7F11;
	Fri, 13 Jun 2025 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814967; cv=none; b=UoRywwoQleQ2e7slaSIqXhZr7YFSHHktmp8jTQSQLnpJFkjI8VtCGXf/ZM44LDn3bSYhtD0S9Wa/JhgmL2a+hMDsPnxWnfRceUJY0+4LNzaJ01vljqd9J6RRtxF36PTboYhg6x4gXhcbJC1fqUAyd5+S4Rtm2lYcfQ/agzye1jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814967; c=relaxed/simple;
	bh=RRdlkBDEmtJLl36U7brH9gBLYzEATksRx+v4nftXEzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYM1h6YwA+J//k0wi6OlRHSbr1j0FoB3GI+lrG0Rp3qyxO11PrEUCybvWE86nE2ngcDcxLZE7ee4jwJF9ErmMZmWsKPjNFBUdkxatbkl5/QVYOlMvOYDrgJU1Vj4S7wS20b5VI89Syw4/M3pvP5Os8ptltso0Oq1JwmvGA2s7O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmGIdAIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D376FC4CEFB;
	Fri, 13 Jun 2025 11:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749814966;
	bh=RRdlkBDEmtJLl36U7brH9gBLYzEATksRx+v4nftXEzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZmGIdAIsF0j6fvs/aNpGs7XICMloa8BBj4qNnaJyZorcJMurW0D9UgxrAAkTS9/0v
	 8SyEXLnnRagkMuh8G8DicDy8CXClaNLOu73Qyc25xezUaV7RkEh1k6b4t8KImyj7b7
	 rkdIKn7Ko2x6qegq3cgYFn02kZ/2PnQoBzY0JWRnwbmjgprHDWxZF8vSdfnjv77LV9
	 u8z3BPMS1m4YtSMzK5FwscoklNgc+D3VknGw2ud2mNCER6cBdHIjLZTjh2mdMA+4yL
	 oBQedOA7OyLgaUqb0hChwXizST/9aaG/Sa/k0ZNHhzhP3+Ttp2uFd0WYIKLdkW/74p
	 3WvLkzbJztGkw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uQ2o1-00000005dFL-0H9X;
	Fri, 13 Jun 2025 13:42:45 +0200
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
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v3 10/16] docs: sphinx: parser_yaml.py: add Netlink specs parser
Date: Fri, 13 Jun 2025 13:42:31 +0200
Message-ID: <095fba5224a22b86a7604773ddaf9b5193157bc1.1749812870.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749812870.git.mchehab+huawei@kernel.org>
References: <cover.1749812870.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Place the code at parser_yaml.py to handle Netlink specs. All
other yaml files are ignored.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .pylintrc                           |  2 +-
 Documentation/sphinx/parser_yaml.py | 39 +++++++++++++++++++++--------
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/.pylintrc b/.pylintrc
index 30b8ae1659f8..f1d21379254b 100644
--- a/.pylintrc
+++ b/.pylintrc
@@ -1,2 +1,2 @@
 [MASTER]
-init-hook='import sys; sys.path += ["scripts/lib/kdoc", "scripts/lib/abi"]'
+init-hook='import sys; sys.path += ["scripts/lib", "scripts/lib/kdoc", "scripts/lib/abi"]'
diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
index b3cde9cf7aac..eb32e3249274 100755
--- a/Documentation/sphinx/parser_yaml.py
+++ b/Documentation/sphinx/parser_yaml.py
@@ -3,6 +3,10 @@ Sphinx extension for processing YAML files
 """
 
 import os
+import re
+import sys
+
+from pprint import pformat
 
 from docutils.parsers.rst import Parser as RSTParser
 from docutils.statemachine import ViewList
@@ -10,7 +14,10 @@ from docutils.statemachine import ViewList
 from sphinx.util import logging
 from sphinx.parsers import Parser
 
-from pprint import pformat
+srctree = os.path.abspath(os.environ["srctree"])
+sys.path.insert(0, os.path.join(srctree, "scripts/lib"))
+
+from netlink_yml_parser import NetlinkYamlParser      # pylint: disable=C0413
 
 logger = logging.getLogger(__name__)
 
@@ -19,8 +26,9 @@ class YamlParser(Parser):
 
     supported = ('yaml', 'yml')
 
-    # Overrides docutils.parsers.Parser. See sphinx.parsers.RSTParser
-    def parse(self, inputstring, document):
+    netlink_parser = NetlinkYamlParser()
+
+    def do_parse(self, inputstring, document, msg):
         """Parse YAML and generate a document tree."""
 
         self.setup_parse(inputstring, document)
@@ -28,14 +36,6 @@ class YamlParser(Parser):
         result = ViewList()
 
         try:
-            # FIXME: Test logic to generate some ReST content
-            basename = os.path.basename(document.current_source)
-            title = os.path.splitext(basename)[0].replace('_', ' ').title()
-
-            msg = f"{title}\n"
-            msg += "=" * len(title) + "\n\n"
-            msg += "Something\n"
-
             # Parse message with RSTParser
             for i, line in enumerate(msg.split('\n')):
                 result.append(line, document.current_source, i)
@@ -48,6 +48,23 @@ class YamlParser(Parser):
 
         self.finish_parse()
 
+    # Overrides docutils.parsers.Parser. See sphinx.parsers.RSTParser
+    def parse(self, inputstring, document):
+        """Check if a YAML is meant to be parsed."""
+
+        fname = document.current_source
+
+        # Handle netlink yaml specs
+        if re.search("/netlink/specs/", fname):
+            if fname.endswith("index.yaml"):
+                msg = self.netlink_parser.generate_main_index_rst(fname, None)
+            else:
+                msg = self.netlink_parser.parse_yaml_file(fname)
+
+            self.do_parse(inputstring, document, msg)
+
+        # All other yaml files are ignored
+
 def setup(app):
     """Setup function for the Sphinx extension."""
 
-- 
2.49.0


