Return-Path: <netdev+bounces-199018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B19EADEABC
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF2D3A7529
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0730D2DBF48;
	Wed, 18 Jun 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Et/iFfWl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05702BD5A8;
	Wed, 18 Jun 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247211; cv=none; b=q33oCey69G6dzO4IAQF5T3ibp60BaNC+jMF8cgio6NFKNX1gfqSIb0QYDqD+kis2FHhYwXrntClprq61JqeYcJYPDD8reja5A17L/wf5OpPTKtwVUjo7eIlcvVdB4d6eiQqKqE+hJNLDMI3kYwTmcTTrNoK3u+tQTpjBiNp+6X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247211; c=relaxed/simple;
	bh=2WQh1GG+XNK0Cdx26utHd/0dTt1jIj+urA1wFYdPe3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxxBrYmCtAVY0WYJVryNJ+SYznnEFWVDzQu8KD2ZSJiKU1Ju5X+KVkOEMzh6S0bYhG4uKiqUoRNR1wbJ65jm4Cyk11uaBX/yL0TR2dCsO2bykLrNSngpojn8wbkaz3HB7mZrkLcVLg1cMFimxrJ+GrA+JbJRhSJToUrngYcB2y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Et/iFfWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1A2C4CEF1;
	Wed, 18 Jun 2025 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750247211;
	bh=2WQh1GG+XNK0Cdx26utHd/0dTt1jIj+urA1wFYdPe3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Et/iFfWlcEzL1weQEhp1I6Pui5hYu/hp3TJMhAoXcVq8ea80Zxx5TokBskCTwuIPz
	 5uuvGVFIMhSkYgqxVHO1R5m02uUl5/NefK4kVdJSKBMInXC0YXpvBk95DWMArrgaXT
	 7RK8dk6IaTnwaqWuCUCDZ3JU+tnXU95vumeY7ADbVLgRcBY/ZzKarJceOdpztOhvWp
	 GelUU/P0v0AKeFv+IANrrN7Bz6ZR018Vt8kMqS4UwY91qkeBzwnG1X+FP9VlxP0ePN
	 mNyDpZf9WeF6/VLYOPkXGQFRKcPlOJvMl1Nns8z6rUa7DcS4rEn6rUzCLS3KBXGsue
	 b8x0NlWtfP2yg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRrFh-000000036Uh-2Zyf;
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
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v6 07/15] docs: sphinx: add a parser for yaml files for Netlink specs
Date: Wed, 18 Jun 2025 13:46:34 +0200
Message-ID: <79fd88d84e63351d1156a343d697d9bbca8159c5.1750246291.git.mchehab+huawei@kernel.org>
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

Add a simple sphinx.Parser to handle yaml files and add the
the code to handle Netlink specs. All other yaml files are
ignored.

The code was written in a way that parsing yaml for different
subsystems and even for different parts of Netlink are easy.

All it takes to have a different parser is to add an
import line similar to:

	from netlink_yml_parser import YnlDocGenerator

adding the corresponding parser somewhere at the extension:

	netlink_parser = YnlDocGenerator()

And then add a logic inside parse() to handle different
doc outputs, depending on the file location, similar to:

        if "/netlink/specs/" in fname:
            msg = self.netlink_parser.parse_yaml_file(fname)

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/parser_yaml.py | 76 +++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100755 Documentation/sphinx/parser_yaml.py

diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
new file mode 100755
index 000000000000..635945e1c5ba
--- /dev/null
+++ b/Documentation/sphinx/parser_yaml.py
@@ -0,0 +1,76 @@
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
+sys.path.insert(0, os.path.join(srctree, "tools/net/ynl/pyynl"))
+
+from netlink_yml_parser import YnlDocGenerator        # pylint: disable=C0413
+
+logger = logging.getLogger(__name__)
+
+class YamlParser(Parser):
+    """Custom parser for YAML files."""
+
+    # Need at least two elements on this set
+    supported = ('yaml', 'yml')
+
+    netlink_parser = YnlDocGenerator()
+
+    def do_parse(self, inputstring, document, msg):
+        """Parse YAML and generate a document tree."""
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
+            self.do_parse(inputstring, document, msg)
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


