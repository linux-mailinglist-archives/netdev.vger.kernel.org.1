Return-Path: <netdev+bounces-196908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CCFAD6DF0
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906CB1BC5CDA
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CEC248F58;
	Thu, 12 Jun 2025 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkoLfvry"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7776A23909C;
	Thu, 12 Jun 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724344; cv=none; b=N+go2CUAKExizw6oA9tgDxvNqJ4NP4roGTFs5Dn0jKy7h+IdSW7tBSLB0y1hSD3moCAPCazzEM4wmEkvSn1lwhuUTWSMWMsqGkXnj2CEG37NJzSJXpg2a2oAEw0Qgmo45jPJjUUsyi9ljDDle22iTsPDOWDQkY1fhaxJZFIXHR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724344; c=relaxed/simple;
	bh=FtB7UQx8Rq2PDYZjw/X+61j5J92UiusLvQz1RbjcG2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLZ8NSlTvJIuoIXSIMjFpiDs7FGvfuebx4fwBxE2a74wuCPncej5cUv1m5dCxkSfDA/WpCJK0s528px+zXL3YQgc1NNPB9qcblOK6cKPBumWHmYMUTY9SaOQtgawxLNwl6LEbI3g4b8sMHxNc+IRsotAeT6om86CiueqTE7rt1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkoLfvry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3826AC4CEF4;
	Thu, 12 Jun 2025 10:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749724344;
	bh=FtB7UQx8Rq2PDYZjw/X+61j5J92UiusLvQz1RbjcG2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BkoLfvrygnc5ptuYiGlC+Zwuzy8lKOdn39aQi+UObLiY48VzPIhKT75tRzHsgnNlz
	 qTaqHe8LOvXeed/++/r4K+wbuzicyeHMysxGEMITll1rKQoCjfNQlPyykMcMzBHR69
	 qsu65cbXL8GiTnH986TH6jjgcYlDlcwl49gWz+/RAfbIj2uj3JO5K7dfVVYrqZmIfH
	 6vueI1fLI9QDlbaTOYYkMDANkV8qJhGa7zEUqTozl1NfOs5NKu9RTam7rUvI951yAE
	 rsblgoarkBScIq9PGrac4pjnunrnQbGikju6/YsZsRgZNp58XRZoo8X2dRgoTbxPbY
	 lqtQS3ZRDWvaQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uPfEM-00000004yvY-1j8a;
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
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v2 08/12] scripts: netlink_yml_parser.py: improve index.rst generation
Date: Thu, 12 Jun 2025 12:32:00 +0200
Message-ID: <ea083e487f1b0fcc95f117d269cba8b70e12c566.1749723671.git.mchehab+huawei@kernel.org>
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

Handle both .yaml and .rst extensions. This way, one can generate
an index file inside the sources with:

	tools/net/ynl/pyynl/ynl_gen_rst.py -x  -v -o Documentation/netlink/specs/index.rst

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/lib/netlink_yml_parser.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/lib/netlink_yml_parser.py b/scripts/lib/netlink_yml_parser.py
index 65981b86875f..3ba28a9a4338 100755
--- a/scripts/lib/netlink_yml_parser.py
+++ b/scripts/lib/netlink_yml_parser.py
@@ -372,15 +372,20 @@ class NetlinkYamlParser:
         lines.append(self.fmt.rst_toctree(1))
 
         index_fname = os.path.basename(output)
-        base, ext = os.path.splitext(index_fname)
 
         if not index_dir:
             index_dir = os.path.dirname(output)
 
-        logging.debug(f"Looking for {ext} files in %s", index_dir)
+        exts = [ ".yaml", ".rst" ]
+
+        logging.debug(f"Looking for files in %s", index_dir)
         for filename in sorted(os.listdir(index_dir)):
-            if not filename.endswith(ext) or filename == index_fname:
+            if filename == index_fname:
                 continue
+
+            for ext in exts:
+                if not filename.endswith(ext):
+                    continue
             base, ext = os.path.splitext(filename)
             lines.append(f"   {base}\n")
 
-- 
2.49.0


