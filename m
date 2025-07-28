Return-Path: <netdev+bounces-210582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE07B13F77
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3202A189B575
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093C6275B1A;
	Mon, 28 Jul 2025 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Drmb86SH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ADC273D7F;
	Mon, 28 Jul 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718542; cv=none; b=nbAXp9MqVZ+pd5Cd3QuFu/FP5flgiO/BmUHEBfgko77DtJYKccEclFoUMr8/j57hGb1pA0WVsLe7b2nszHX5CKz4sDNdv0nSsVP4qMXonad3p3P+bgeoPRGTnRztnsrP46DTJHW2pQXNKeO5VsK79hdW7Iv8wlC4UcIyALX3fSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718542; c=relaxed/simple;
	bh=XSw4mQEDkXYg1/MgVR7Ux51WqbxkUyoFtZ5Xkxz6xTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOzy9RdYSV1GXIwE1E6R8s+fqregYOaGOhKmpkR7W8/qm4BDkTnozFbINab6b6cyRs//UZjtYVcPrzPikJYhS9QhWg29vqevcYqGU0oT76BofkHT61V6XMtZ1I2MJlJ0REX3CYMhZVVxxgfb0Sivf2NApseWq3ZmPu2/CskTyq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Drmb86SH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA0EC116B1;
	Mon, 28 Jul 2025 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753718542;
	bh=XSw4mQEDkXYg1/MgVR7Ux51WqbxkUyoFtZ5Xkxz6xTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Drmb86SHisLz6/XaBYSkRUMw4q+Y4sagL2pNyxT88nO4h4j7+QgzO6S98YhmK9loE
	 Cufy8D077P0hrukVf9IVmcaZN9HSt4yYCEjCLfOOGAmWUzYZ+6h6/g3gZycHmeF4wN
	 jBltRkOU57pCbwecqTklQt/7Kp+zU83iwsr8n1Q7mWF65J1ejMqEfGZLw7CmDz8H0M
	 5b65tqSaqgW97oEfyFcyq79VO1Wg3+w1pKJcZ/CNwmze79IdOjeCQ7GR+7RwOfRXc+
	 Fbqo2xg+hLyeRAjVlfTFhN3DBUwDPSr9N4hlfrFOc0L9Sm1mrR4QbvzEd28RQumLr+
	 NYuvLEmGzCr3Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1ugQIq-00000000Gct-1QFd;
	Mon, 28 Jul 2025 18:02:16 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Message-ID :" <cover.1752076293.git.mchehab+huawei@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Donald Hunter" <donald.hunter@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Jan Stancek" <jstancek@redhat.com>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Marco Elver" <elver@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	"Simon Horman" <horms@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v10 05/14] docs: sphinx: add a parser for yaml files for Netlink specs
Date: Mon, 28 Jul 2025 18:01:58 +0200
Message-ID: <bec1bf1f340ad01694d9eede70b214c1b0f42b5f.1753718185.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1753718185.git.mchehab+huawei@kernel.org>
References: <cover.1753718185.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Add a simple sphinx.Parser to handle yaml files and add the
the code to handle Netlink specs. All other yaml files are
ignored.

The code was written in a way that parsing yaml for different
subsystems and even for different parts of Netlink are easy.

All it takes to have a different parser is to add an
import line similar to:

	from doc_generator import YnlDocGenerator

adding the corresponding parser somewhere at the extension:

	netlink_parser = YnlDocGenerator()

And then add a logic inside parse() to handle different
doc outputs, depending on the file location, similar to:

        if "/netlink/specs/" in fname:
            msg = self.netlink_parser.parse_yaml_file(fname)

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/sphinx/parser_yaml.py | 104 ++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100755 Documentation/sphinx/parser_yaml.py

diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
new file mode 100755
index 000000000000..fa2e6da17617
--- /dev/null
+++ b/Documentation/sphinx/parser_yaml.py
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2025 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
+"""
+Sphinx extension for processing YAML files
+"""
+
+import os
+import re
+import sys
+
+from pprint import pformat
+
+from docutils.parsers.rst import Parser as RSTParser
+from docutils.statemachine import ViewList
+
+from sphinx.util import logging
+from sphinx.parsers import Parser
+
+srctree = os.path.abspath(os.environ["srctree"])
+sys.path.insert(0, os.path.join(srctree, "tools/net/ynl/pyynl/lib"))
+
+from doc_generator import YnlDocGenerator        # pylint: disable=C0413
+
+logger = logging.getLogger(__name__)
+
+class YamlParser(Parser):
+    """
+    Kernel parser for YAML files.
+
+    This is a simple sphinx.Parser to handle yaml files inside the
+    Kernel tree that will be part of the built documentation.
+
+    The actual parser function is not contained here: the code was
+    written in a way that parsing yaml for different subsystems
+    can be done from a single dispatcher.
+
+    All it takes to have parse YAML patches is to have an import line:
+
+            from some_parser_code import NewYamlGenerator
+
+    To this module. Then add an instance of the parser with:
+
+            new_parser = NewYamlGenerator()
+
+    and add a logic inside parse() to handle it based on the path,
+    like this:
+
+            if "/foo" in fname:
+                msg = self.new_parser.parse_yaml_file(fname)
+    """
+
+    supported = ('yaml', )
+
+    netlink_parser = YnlDocGenerator()
+
+    def rst_parse(self, inputstring, document, msg):
+        """
+        Receives a ReST content that was previously converted by the
+        YAML parser, adding it to the document tree.
+        """
+
+        self.setup_parse(inputstring, document)
+
+        result = ViewList()
+
+        try:
+            # Parse message with RSTParser
+            for i, line in enumerate(msg.split('\n')):
+                result.append(line, document.current_source, i)
+
+            rst_parser = RSTParser()
+            rst_parser.parse('\n'.join(result), document)
+
+        except Exception as e:
+            document.reporter.error("YAML parsing error: %s" % pformat(e))
+
+        self.finish_parse()
+
+    # Overrides docutils.parsers.Parser. See sphinx.parsers.RSTParser
+    def parse(self, inputstring, document):
+        """Check if a YAML is meant to be parsed."""
+
+        fname = document.current_source
+
+        # Handle netlink yaml specs
+        if "/netlink/specs/" in fname:
+            msg = self.netlink_parser.parse_yaml_file(fname)
+            self.rst_parse(inputstring, document, msg)
+
+        # All other yaml files are ignored
+
+def setup(app):
+    """Setup function for the Sphinx extension."""
+
+    # Add YAML parser
+    app.add_source_parser(YamlParser)
+    app.add_source_suffix('.yaml', 'yaml')
+
+    return {
+        'version': '1.0',
+        'parallel_read_safe': True,
+        'parallel_write_safe': True,
+    }
-- 
2.49.0


