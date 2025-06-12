Return-Path: <netdev+bounces-196913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF83CAD6DDE
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5AC9175E88
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4323624A04D;
	Thu, 12 Jun 2025 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfeWwOIN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE81239E94;
	Thu, 12 Jun 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724344; cv=none; b=DSuu0hiiN/3bmIl9nqzLKCFQ/FOaKR60X0aNSMRhdHe1Z7C2SroCax4Z6BgCNVW9tqxSDfDasxXR/8jcnwrC57XixUQ3Msr+iIhQedDmoCNiRrEqqsgyPqMvtFAFsd+6S/1E2txCc9G4J1AyPfnO0HNavkftRGOaqv1GPn8X/VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724344; c=relaxed/simple;
	bh=BNiT6T73vSHdjoYinnCVLRiSA/MjExWs0t2+7SQv6UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGNRrd8h5+wfsNNxJtN9vgFYwXXvw5kXRhHfkncgO48wCAoXf66r2PEDCrrAsG/5Ww9vllTszUWClOGVFaoXk8CfdHk6W4/FQkKTWQc1OBlk2APcnnmyuhD/7Wor7ytblLi6QbbbZn2oUHHTNn7o0XP1RCUTWXHGqw7sf5ckBq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfeWwOIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A06C4CEF8;
	Thu, 12 Jun 2025 10:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749724344;
	bh=BNiT6T73vSHdjoYinnCVLRiSA/MjExWs0t2+7SQv6UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TfeWwOIN9v3hfc6zrvmifoGhvd9wgTiaJ2z0tOwedEmVKXtqdzlz8dpofIgmWU877
	 2mls+ZMk/NjlMS7b/MxIlD7nda7LSV5cfgvwtAkBmYE1128PT1wkh8772zASH/aR3D
	 Wv7bR/Mr2/SevrmxMr7ayRioyGs8z1A3u6BJnGsjdv17GZapMjTXCG7eW30RoSvhem
	 67kO2hHGINFobwDU/+QeFahKTZPqNnkRlH8DMQapnIanJjlOz079g+39rC3V0nhdm2
	 GKvSYJ6NHd65GyyMPmZwzmbKvCIMSbeqUF7HsZLWOsr0dFX8M2sao4CJYUmSdjcSa9
	 pQrF/uSMZLqUA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uPfEM-00000004yvc-1xhr;
	Thu, 12 Jun 2025 12:32:22 +0200
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
Subject: [PATCH v2 09/12] docs: sphinx: add a parser template for yaml files
Date: Thu, 12 Jun 2025 12:32:01 +0200
Message-ID: <39789f17215178892544ffc408a4d0d9f4017f37.1749723671.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749723671.git.mchehab+huawei@kernel.org>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Add a simple sphinx.Parser class meant to handle yaml files.

For now, it just replaces a yaml file by a simple ReST
code. I opted to do this way, as this patch can be used as
basis for new file format parsers. We may use this as an
example to parse other types of files.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/parser_yaml.py | 63 +++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100755 Documentation/sphinx/parser_yaml.py

diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
new file mode 100755
index 000000000000..b3cde9cf7aac
--- /dev/null
+++ b/Documentation/sphinx/parser_yaml.py
@@ -0,0 +1,63 @@
+"""
+Sphinx extension for processing YAML files
+"""
+
+import os
+
+from docutils.parsers.rst import Parser as RSTParser
+from docutils.statemachine import ViewList
+
+from sphinx.util import logging
+from sphinx.parsers import Parser
+
+from pprint import pformat
+
+logger = logging.getLogger(__name__)
+
+class YamlParser(Parser):
+    """Custom parser for YAML files."""
+
+    supported = ('yaml', 'yml')
+
+    # Overrides docutils.parsers.Parser. See sphinx.parsers.RSTParser
+    def parse(self, inputstring, document):
+        """Parse YAML and generate a document tree."""
+
+        self.setup_parse(inputstring, document)
+
+        result = ViewList()
+
+        try:
+            # FIXME: Test logic to generate some ReST content
+            basename = os.path.basename(document.current_source)
+            title = os.path.splitext(basename)[0].replace('_', ' ').title()
+
+            msg = f"{title}\n"
+            msg += "=" * len(title) + "\n\n"
+            msg += "Something\n"
+
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
+def setup(app):
+    """Setup function for the Sphinx extension."""
+
+    # Add YAML parser
+    app.add_source_parser(YamlParser)
+    app.add_source_suffix('.yaml', 'yaml')
+    app.add_source_suffix('.yml', 'yaml')
+
+    return {
+        'version': '1.0',
+        'parallel_read_safe': True,
+        'parallel_write_safe': True,
+    }
-- 
2.49.0


