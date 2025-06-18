Return-Path: <netdev+bounces-199020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2226ADEAA7
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61722160DEE
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A63A2DE1F1;
	Wed, 18 Jun 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNpAhvIS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35EA2BE7DA;
	Wed, 18 Jun 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247211; cv=none; b=ANPQEgDZjWpCQ3I+/Jv0W/Xa5dl7Xn3+xqDN9t7w4Bh33xJ4sukboaP7CdU3DnOud4341yB0fpnVI8V+oauMcFFwIYAjRPNT4nBPei5/a1CkWOrQPpTDNYcDxUkYiRMoYH651VWzAyNZBEcm7NMbqcn0WbIyzsM2VzjVpza7QBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247211; c=relaxed/simple;
	bh=JvTI+DF/1Dszyn4T0n7ZKhi6vNtj6FoC1Ae/TMd5FHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjGsOZBabQXPpFJ9K8gH2xwf7lKjXlQTtlGnxhrtI2dJ3FZ7/W3Q0cku0XByICN0Z9XySlbo81B0bHG072mFEQEZ4Gslrs64lgNA255SlW0r/nexbEi1uXmT3Cv4YQa8BaYEhfds3DTmeMMgE06niWjUUE9orVWx2ebN7efQu2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNpAhvIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E02C4AF09;
	Wed, 18 Jun 2025 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750247211;
	bh=JvTI+DF/1Dszyn4T0n7ZKhi6vNtj6FoC1Ae/TMd5FHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNpAhvIS8B9g/yY9cvaF5cSmS+QQVnN2qc8L9H7B8QbLCp0GCOynIFLNtIr8YkZkz
	 mMMokwZpCg/5aa+JZcjZ4BcV1DmDMBHnodbIpEhnAYRKTUyDWjOyrw9Tq9FSVrR+va
	 DtfpHGfhtruIEWDQvgPbUhsHYkS727pTZaLChdXMitYQML+M8T28pB0NFFo+7Im80I
	 H8Rcs0D026838D5+6cIfG//c7jGhKj8893sYrj6PSZ+C+4EeBJN5+MqBLNjL3HlvKu
	 mHPEy0bRBfAFb4hVZtWGrcLk/o/sliwm6p5a2TnKSpZdXFJBfWYCyMl/HRd7VWfFdv
	 NpNIUbXMx5rsQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRrFh-000000036UJ-1rob;
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
Subject: [PATCH v6 01/15] docs: conf.py: properly handle include and exclude patterns
Date: Wed, 18 Jun 2025 13:46:28 +0200
Message-ID: <737b08e891765dc10bd944d4d42f8b1e37b80275.1750246291.git.mchehab+huawei@kernel.org>
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

When one does:
	make SPHINXDIRS="foo" htmldocs

All patterns would be relative to Documentation/foo, which
causes the include/exclude patterns like:

	include_patterns = [
		...
		f'foo/*.{ext}',
	]

to break. This is not what it is expected. Address it by
adding a logic to dynamically adjust the pattern when
SPHINXDIRS is used.

That allows adding parsers for other file types.

It should be noticed that include_patterns was added on
Sphinx 5.1:
	https://www.sphinx-doc.org/en/master/usage/configuration.html#confval-include_patterns

So, a backward-compatible code is needed when we start
using it for real.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/conf.py | 67 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 12de52a2b17e..4ba4ee45e599 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -17,6 +17,66 @@ import os
 import sphinx
 import shutil
 
+# Get Sphinx version
+major, minor, patch = sphinx.version_info[:3]
+
+# Include_patterns were added on Sphinx 5.1
+if (major < 5) or (major == 5 and minor < 1):
+    has_include_patterns = False
+else:
+    has_include_patterns = True
+    # Include patterns that don't contain directory names, in glob format
+    include_patterns = ['**.rst']
+
+# Location of Documentation/ directory
+doctree = os.path.abspath('.')
+
+# Exclude of patterns that don't contain directory names, in glob format.
+exclude_patterns = []
+
+# List of patterns that contain directory names in glob format.
+dyn_include_patterns = []
+dyn_exclude_patterns = ['output']
+
+# Properly handle include/exclude patterns
+# ----------------------------------------
+
+def update_patterns(app):
+
+    """
+    On Sphinx, all directories are relative to what it is passed as
+    SOURCEDIR parameter for sphinx-build. Due to that, all patterns
+    that have directory names on it need to be dynamically set, after
+    converting them to a relative patch.
+
+    As Sphinx doesn't include any patterns outside SOURCEDIR, we should
+    exclude relative patterns that start with "../".
+    """
+
+    sourcedir = app.srcdir  # full path to the source directory
+    builddir = os.environ.get("BUILDDIR")
+
+    # setup include_patterns dynamically
+    if has_include_patterns:
+        for p in dyn_include_patterns:
+            full = os.path.join(doctree, p)
+
+            rel_path = os.path.relpath(full, start = app.srcdir)
+            if rel_path.startswith("../"):
+                continue
+
+            app.config.include_patterns.append(rel_path)
+
+    # setup exclude_patterns dynamically
+    for p in dyn_exclude_patterns:
+        full = os.path.join(doctree, p)
+
+        rel_path = os.path.relpath(full, start = app.srcdir)
+        if rel_path.startswith("../"):
+            continue
+
+        app.config.exclude_patterns.append(rel_path)
+
 # helper
 # ------
 
@@ -219,10 +279,6 @@ language = 'en'
 # Else, today_fmt is used as the format for a strftime call.
 #today_fmt = '%B %d, %Y'
 
-# List of patterns, relative to source directory, that match files and
-# directories to ignore when looking for source files.
-exclude_patterns = ['output']
-
 # The reST default role (used for this markup: `text`) to use for all
 # documents.
 #default_role = None
@@ -516,3 +572,6 @@ kerneldoc_srctree = '..'
 # the last statement in the conf.py file
 # ------------------------------------------------------------------------------
 loadConfig(globals())
+
+def setup(app):
+	app.connect('builder-inited', update_patterns)
-- 
2.49.0


