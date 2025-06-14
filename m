Return-Path: <netdev+bounces-197740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E7CAD9B8F
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9224F17CA58
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400772C08A3;
	Sat, 14 Jun 2025 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTG7J6SH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0C12980B4;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749891378; cv=none; b=sSpQmN3NuCwM77BCtx+yvAYpF4f4WtlMduJ8g9YHfCFX7xZTJH8ZTYaPD+cBCEoAagHZDx0WGU2iQUDa5X7iPkxg2hxlg9aGRRlZFt0Ba62Em2Fh7IohGgLejtIZfYPyZeNA85TSn3mawIiBoYOwDviXVg2QJBaw0IgRBwKktw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749891378; c=relaxed/simple;
	bh=I8pUy88zBF77rSu49ytMSdMuCNGwN6+WLgN5avfuYxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyZWS6jnK2SLG3wJY4hmEj1U92padwxlBSMukh7llcJxiQYv6V3jb/dPm11s5KtNN8K5yKHcrg49qa2nc/n2qs/rQtXS5A8Evyn5oomHDmTnbeHu35gFAwHyJ4jUavO1XR7Vsu7Mt/wZbkgQi3SRiMQm6giS3RAtnHyusBVXOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTG7J6SH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223EAC4CEFA;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749891378;
	bh=I8pUy88zBF77rSu49ytMSdMuCNGwN6+WLgN5avfuYxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HTG7J6SH/h1/npYSqD2MKXtZuTixOUkwIZQ6lmqLSQ3J5aNz5L1gABzF7h0vUpW8n
	 UMVtH3jE02TZm3H7Erbf2UjLQYDF2JtJmBNQ8qUdJNXOiYCdpVD5KJ1LUiRth78MWB
	 gK5LBkeYIvapyhdht6NO7NWwDtTHV9EHthMTa74+VDlr/bL7RYxkHRXYGg3zimEgBQ
	 Ih5k0Kkkl2CnHMj1EXLH1sRRSHzFwZzmzXA638Y9M+ECQMXBaA4ZiizxlMyRdHSjVT
	 LiaKHPFfKCQPSppHB7EdBy7D2VCTz5mUwbdQew5RS6Uwmm174j649+cCbCt0WPDaLF
	 HECI2U1/M9KFw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uQMgS-000000064b9-1UUZ;
	Sat, 14 Jun 2025 10:56:16 +0200
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
Subject: [PATCH v4 08/14] docs: sphinx: add a parser for yaml files for Netlink specs
Date: Sat, 14 Jun 2025 10:56:02 +0200
Message-ID: <4eb1691d75bedaf1317e5293bb09f4148288904a.1749891128.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749891128.git.mchehab+huawei@kernel.org>
References: <cover.1749891128.git.mchehab+huawei@kernel.org>
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
 .pylintrc                           |  2 +-
 Documentation/sphinx/parser_yaml.py | 76 +++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100755 Documentation/sphinx/parser_yaml.py

diff --git a/.pylintrc b/.pylintrc
index 30b8ae1659f8..f1d21379254b 100644
--- a/.pylintrc
+++ b/.pylintrc
@@ -1,2 +1,2 @@
 [MASTER]
-init-hook='import sys; sys.path += ["scripts/lib/kdoc", "scripts/lib/abi"]'
+init-hook='import sys; sys.path += ["scripts/lib", "scripts/lib/kdoc", "scripts/lib/abi"]'
diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
new file mode 100755
index 000000000000..9083e102c9f3
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
+sys.path.insert(0, os.path.join(srctree, "scripts/lib"))
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


