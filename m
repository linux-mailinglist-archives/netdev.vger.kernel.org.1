Return-Path: <netdev+bounces-201452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D51AE97D9
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7909D1C22DDC
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C3D23B613;
	Thu, 26 Jun 2025 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwjtBGRd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58932266B67;
	Thu, 26 Jun 2025 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925619; cv=none; b=UrCbnivepm+gJlfe6j7pcl3qrkC4R2zCYKea75P7+BXnE3cQHfo90CfmzkFIu6zNhqBOs0s5w1l3KpHYuohG37KV9qTT2TaLvIGR1mIbrqYNnA8EJ6I2FWOole3AQXljY1yGTQgW97E/XIJJHa/yIgJg7Gu/zIPno8aTtLUet+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925619; c=relaxed/simple;
	bh=gS8amLkS0GVZ6ebOGGSXJ433whLwzCqtgP9rfi48TA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbPSNc5CK7C1uPR83pYRXmB2r2AZclPMsUesttlr23JLH8C6Bvq51xGOcAADaYk7Rs6rqnkLdfhrf27p/P3G3giyODt8eqYZcPcWagrxw2Txswfk9fZIwNZGyRBHMniC+J3BnFIhUQnDl9O9/RcqWosyn+EsDCHHykeOW7zMjJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwjtBGRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD32FC4CEEE;
	Thu, 26 Jun 2025 08:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750925618;
	bh=gS8amLkS0GVZ6ebOGGSXJ433whLwzCqtgP9rfi48TA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hwjtBGRdgHlM0A4sF0HG8Dcx5lDZUyUuo3m92YX8gukHeGon6qKNeTNiamt6605xy
	 TbJeUSTuY6ovHL3VDZu0mj/Cr12f9/X+ymLm95IH/cLT2RXktyXHtiXX3UOojpc6I6
	 ELh9KQ9pZ0iMehweecJdt9Gut8J2MufFbyXB0ZfAc6R2SbdWqpFw8eoWc1e2kQE6Ma
	 RKdSlXRbv5AgbzGgalL7hqdRV1HPheFvJZqYm19TpacQCRmsyXlK9w5cu02HDNByNV
	 hTw4x8bwuFVWs1BSZACNqAo+6CaT1ZuS70v0n2HCRqVOHM686ItEyN1UlcHY6p5DvI
	 +j2d+1hmtnRbA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uUhjT-00000004svi-1Qzx;
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
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v8 05/13] docs: sphinx: add a parser for yaml files for Netlink specs
Date: Thu, 26 Jun 2025 10:13:01 +0200
Message-ID: <8373667e90bf5b184dfd28393fe6a955cdb4bbb7.1750925410.git.mchehab+huawei@kernel.org>
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
 Documentation/sphinx/parser_yaml.py | 104 ++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100755 Documentation/sphinx/parser_yaml.py

diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
new file mode 100755
index 000000000000..585a7ec81ba0
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
+sys.path.insert(0, os.path.join(srctree, "tools/net/ynl/pyynl"))
+
+from netlink_yml_parser import YnlDocGenerator        # pylint: disable=C0413
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


