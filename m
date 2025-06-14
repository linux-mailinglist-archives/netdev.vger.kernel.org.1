Return-Path: <netdev+bounces-197743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAF1AD9B92
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD47189CBA7
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3342C08AC;
	Sat, 14 Jun 2025 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jnxo2kga"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18AC298CD1;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749891378; cv=none; b=OV9fKLXoU7xnTiyvxBhvVlm8yvDD6p49h0zfuGdsqTzMhLFVLn1W+U9oDtOVeJzikL7Zb95u2JlZwqamv2cRKcE6jtT3YaS++86K83fuMCghvlbqlnHNWgpW6Oo5y+bhkYJ4GBT/iRvjI+JRQrr5aRsvEnFGrmwaWtXt5D514k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749891378; c=relaxed/simple;
	bh=JDTK8ds5rMEZTW9f7Wpcip/tbHM6fMKUON4aC7f9ZTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNgSSJ2D4Pa1wATKOEFlGZzGQMfaZ8bgvgiOClGSe5AsuB7aFlY2Q12vPMAqlG2nF1B+vSwgA4GEHlG9rvl1WobIJfJaVPEbjMv5xLNepdmtm14oMXZUP0bDRmQ8VsyOYQspj5buLrEI0jD3eSmdgKsmazL/0BV+5AjiD5ltGyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jnxo2kga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793A4C116C6;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749891378;
	bh=JDTK8ds5rMEZTW9f7Wpcip/tbHM6fMKUON4aC7f9ZTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jnxo2kgabhDXzSpfzf0kdqlxjfXWeYV1fURoZiC0VQCicHOQ5U2te0gdTHk3o9Ghd
	 +iaOdCab93EbQ3V3PMSsF26JYOTOuz0XqNDIWWCtBY/TUNc5jKw6qpZuOGOQYIMRXu
	 WgVIcuqRmhvWPCYM7YxMpZ/vQGEUeFVuNz9fYIqCVfzUtzgn+DJ1rYFxGyX2v/NXcH
	 hMZuoVBRB3SLs58H7PaZN3m1jNV+1FngQcfVKuR2stYZEzncKvEi6ViR6GDKApdm82
	 SjIMRWmXG5X7WRKZ+siT8E0DKGhWRiEcIvOzISR/vmarQaL7wzPOWiQKap07Ns03hx
	 S3TvudT1JdLpg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uQMgS-000000064bX-2vAc;
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
Subject: [PATCH v4 14/14] docs: conf.py: properly handle include and exclude patterns
Date: Sat, 14 Jun 2025 10:56:08 +0200
Message-ID: <2238d93ac08f9e6d3e88e0edfc6f58d13f5f9b68.1749891128.git.mchehab+huawei@kernel.org>
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

When one does:
	make SPHINXDIRS="netlink/specs" htmldocs

the build would break because a statically-defined pattern
like:

	include_patterns = [
		...
		'netlink/specs/*.yaml',
	]

would be pointing to Documentation/netlink/specs/netlink/specs,
as the path there is relative. Also, when SPHINXDIRS is used,
the exclude_pattern = [ "output" ] is also wrong.

Fix conf.py to generate relative include/exclude patterns,
relative to the SOURCEDIR sphinx-dir parameter.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 58 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 12 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 62a51ac64b95..be678bdf95d4 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -17,6 +17,52 @@ import os
 import sphinx
 import shutil
 
+# Location of Documentation/ directory
+doctree = os.path.abspath('.')
+
+# List of patterns that don't contain directory names, in glob format.
+include_patterns = ['**.rst']
+exclude_patterns = []
+
+# List of patterns that contain directory names in glob format.
+dyn_include_patterns = ['netlink/specs/**.yaml']
+dyn_exclude_patterns = ['output']
+
+def setup(app):
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
+    for p in dyn_include_patterns:
+        full = os.path.join(doctree, p)
+
+        rel_path = os.path.relpath(full, start = app.srcdir)
+        if rel_path.startswith("../"):
+            continue
+
+        app.config.include_patterns.append(rel_path)
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
+
 # helper
 # ------
 
@@ -220,18 +266,6 @@ language = 'en'
 # Else, today_fmt is used as the format for a strftime call.
 #today_fmt = '%B %d, %Y'
 
-# List of patterns, relative to source directory, that match files and
-# directories.
-include_patterns = [
-	'**.rst',
-	'netlink/specs/*.yaml',
-]
-
-# patterns to ignore when looking for source files.
-exclude_patterns = [
-	'output',
-]
-
 # The reST default role (used for this markup: `text`) to use for all
 # documents.
 #default_role = None
-- 
2.49.0


