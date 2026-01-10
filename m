Return-Path: <netdev+bounces-248768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFF8D0DF40
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 00:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CF83304F11C
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 23:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C432C3254;
	Sat, 10 Jan 2026 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyM5g4j+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CDA28B407
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768087913; cv=none; b=bvX6QuLnH2cNYVNYEs6ph2SuVtITEl5tLD4mUZkb8DEw81qzxeF86aD/wNLACsOr+eBBEDfDf0LKeTCNaU6XyQgzAmur1VBoI70UHwasO1UNixSvIWHUwm/rjip31ljZR1z6NGPrXaKcCrHi/7W0dyfH3Yq+AcicTE+4bGVHhc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768087913; c=relaxed/simple;
	bh=lALnecFLouPlXiO36PamBTc0+LB+wjTzJFBSsIbG5nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7cC9WRhVMsYw7HAwC/IJ5LyDc7LKZNiabLQLwFGKjgezIOmWxUqJ60hs4jA+aE2kufAA4N9ggrqkg02m1yPmUfuWkpxmsAoYdeBolfsKie7bN8qmBahPWAJ8OxQX3KNS+gGbeRM1qsy4OguCp3cVqGcH5FyZtOBlpU08nQV0wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyM5g4j+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3472C19425;
	Sat, 10 Jan 2026 23:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768087913;
	bh=lALnecFLouPlXiO36PamBTc0+LB+wjTzJFBSsIbG5nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyM5g4j++bs6nHszKUPTnAgZACwLRIWlaUerChw/Yp4PiUwlTavVuPlfjJE9oFsGe
	 2eiTLeM0uvU8/Anjiq2qEogVNQDdgmPc6TuAyEvi+Qs8KGfgUyPZQ+M1hyhC9U79Im
	 LdtRwBZBpsqDtwttkaA6hPNOUjZNGNguhlaAA/OA9JTgWTgYgzOps6CYAhSMhHTbZs
	 wU7oSFOL8bl50YrjpD03iLOdONyGlZEvfyOlH5SBaIdUFv2HgL71tfANh3IYHNJ+bJ
	 qJWTIklQWS9dBcK7FnzGBlnNYY2/tdze2vgI/bWiWIg8FyX9loyuoyjaNlAK6qM7Tf
	 7qc8pgNrJJWYw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	donald.hunter@gmail.com,
	gal@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 4/7] tools: ynl: cli: add --doc as alias to --list-attrs
Date: Sat, 10 Jan 2026 15:31:39 -0800
Message-ID: <20260110233142.3921386-5-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110233142.3921386-1-kuba@kernel.org>
References: <20260110233142.3921386-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

--list-attrs also provides information about the operation itself.
So --doc seems more appropriate. Add an alias.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/cli.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 3aa1f1e816bf..4147c498b479 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -179,7 +179,7 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
                      help="List available --do and --dump operations")
     ops.add_argument('--list-msgs', action='store_true',
                      help="List all messages of the family (incl. notifications)")
-    ops.add_argument('--list-attrs', dest='list_attrs', metavar='MSG',
+    ops.add_argument('--list-attrs', '--doc', dest='list_attrs', metavar='MSG',
                      type=str, help='List attributes for a message / operation')
     ops.add_argument('--validate', action='store_true',
                      help="Validate the spec against schema and exit")
-- 
2.52.0


