Return-Path: <netdev+bounces-198456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0C9ADC3F2
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E90B7A6339
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 08:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FFE28DB57;
	Tue, 17 Jun 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5vr77Nm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D033BE65;
	Tue, 17 Jun 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147352; cv=none; b=K0P76FyplsKOQNZGO+7MeNuYgwqATt1KAiHGlbWnBU8hr70WLdKtSY6GMGKJZQr2lqmuuk4bKJW32oPRrKgj1gbUOuY95ckEY5VlGiDxXsdmEbgaEdQtGvI7jVS38ZxR+H3QYHO+t3b3CXCQtrCvN+q4SFFZ16jiHFsrSx3ArPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147352; c=relaxed/simple;
	bh=TQlUV26hUMBvQLESC8JIjjk9jVydpjRjIcMxZ7u1zZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuCkY209uh0QGfONN5tg2+023STnHU32wriIwPYRRIRXoOILyYs4AHZg/lYFtpdeBVE0y+VY2yho+6fZkgvwCaDPBedgpMXRuBURDKSFPc1keZRcQtiYG1kzdwdhAe5sZF/CQyI8X3vCkYPcsV8FWovsc9lTt9ehQuUUBZ+Hyxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5vr77Nm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6D0C4CEEE;
	Tue, 17 Jun 2025 08:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750147351;
	bh=TQlUV26hUMBvQLESC8JIjjk9jVydpjRjIcMxZ7u1zZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t5vr77Nm3T85lDkDCkTWO06PqpqrIayAe2sYq08oix+8bAeLj3xlY80wifnqiSFU9
	 qQwrTt4hZWLAnCrcX7JpUMQ+hADJOyEO9/fvErp2iinJaE4bO0HqbcHO5GzB7urHkE
	 SyrleLbLpOXNxo+d23Y+d1RQMG42HS5kKA44I6G3agFivmQCEJ8dXjNFezStacqseK
	 aSxd6wwDm1cXVtJ54cYElwpsc1YPwwjZO3lsWdsF3pLiJICbegvlV4gDFjg+KPf8F1
	 PQUFVD95zqZ4HCupLUP7IuWGq3QkY4vOlNw01toHzQ9YSUQ6p/r1EUQFJb86aYqbCf
	 Omkib/K37qkHg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRRH3-00000001vcq-3jNb;
	Tue, 17 Jun 2025 10:02:29 +0200
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
Subject: [PATCH v5 01/15] docs: conf.py: properly handle include and exclude patterns
Date: Tue, 17 Jun 2025 10:01:58 +0200
Message-ID: <cca10f879998c8f0ea78658bf9eabf94beb0af2b.1750146719.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750146719.git.mchehab+huawei@kernel.org>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
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

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 52 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 12de52a2b17e..e887c1b786a4 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -17,6 +17,54 @@ import os
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
+dyn_include_patterns = []
+dyn_exclude_patterns = ['output']
+
+# Properly handle include/exclude patterns
+# ----------------------------------------
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
 # helper
 # ------
 
@@ -219,10 +267,6 @@ language = 'en'
 # Else, today_fmt is used as the format for a strftime call.
 #today_fmt = '%B %d, %Y'
 
-# List of patterns, relative to source directory, that match files and
-# directories to ignore when looking for source files.
-exclude_patterns = ['output']
-
 # The reST default role (used for this markup: `text`) to use for all
 # documents.
 #default_role = None
-- 
2.49.0


