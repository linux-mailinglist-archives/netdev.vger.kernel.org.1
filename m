Return-Path: <netdev+bounces-205477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F7BAFEE4F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787D7645EBD
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F312E9EC0;
	Wed,  9 Jul 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJUIIuDP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC70B1DDE9;
	Wed,  9 Jul 2025 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076749; cv=none; b=slKZZbRtOwbCMdt2CInlfy3kJCdR3CuW0PsvX9jqfLi7S3swrDc6OXz1Aj8xOQqYxx1P+bp12mg3aYcYWykVo3dtkXNpmCdIeIA/PCQWp5GA4BLhs3nliFniVLYh/pFPqKZp9PjhiyAHS2crMlyyz5Hc6wRmwMbZ6L+4G+qHGYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076749; c=relaxed/simple;
	bh=4WCVDXg5rtVzGD/fr8GpQ8WQ2UpN2w9kZ40jE7x0wMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYM5Gl/G068ya7BSO7DBCns5sDBvXGemH+rZGpvgFa6dfQU+2UGtYrF+aRFKErQn6OEZa/ipdpJZuN6Ndy32w0KLPELZGv11rAXnHviBA4YFhzNDt3W9aLgmYBjoBnmv+H+bWHYydKrWXJrHxQtoqr8Jae58nrPApaRCgVFSsM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJUIIuDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8E4C4CEFA;
	Wed,  9 Jul 2025 15:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752076748;
	bh=4WCVDXg5rtVzGD/fr8GpQ8WQ2UpN2w9kZ40jE7x0wMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vJUIIuDPcAqAvK9KhYXrShAlwPP35WT4sMg5gv8uZ74V190/DkwDyKf1RCEzpTEei
	 EpjpgDPh6VzikIpn3Ck1lzXImExSyCtMYGE9kkwXWCAcg0JW0GJkcrwtatjflQzV4d
	 jgNCUxtz/Wv/7QjJToUaW7mqN04zjxDHXNoEfbKyN2ANY4R5X9XLc/AS4zbefgsOl0
	 mLiIuDIZqQHqSYm5ZSL2R/YyatZflTA6Yc1unsVqlJueXTDbmxfmzkR9piMZfslhkD
	 YH02dEOjFcaeCFTW0d+kK0grpdS0G3qlTYcfsqkXO3sNXnOISEFfaE4dVXYUIQrBHu
	 y56Vg+9tBAitg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZXCJ-00000000Ih2-1Fma;
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
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v9 05/13] docs: sphinx: add a parser for yaml files for Netlink specs
Date: Wed,  9 Jul 2025 17:58:49 +0200
Message-ID: <eab7fb6b3ab7a29a71c35452478619745e66b621.1752076293.git.mchehab+huawei@kernel.org>
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


