Return-Path: <netdev+bounces-119633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30172956661
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB2B1F238CD
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3A6158845;
	Mon, 19 Aug 2024 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sueNo7e8"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F0A148FE0
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058602; cv=none; b=W6fgeB2dV2Scjm9VaFTd/gFEPx839+idn3uovGgkmcLyFmAClOv0YVRE553lHBsaUQM+17kPAzKjjOcU6rZFDdW5OsYNaTmvPTFtgMYvdxiIQBlMkAeI3PmsgpkSb03R7c25EzryCh472+29MrOMK2QDr52Zvoi8L2wrpWlhUiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058602; c=relaxed/simple;
	bh=H4qwsIP7lSkUiFnZ2TwGN7NkBRU7qfQXzAJlke5nVMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pY+JY0XSMrUFDWCIXvELsVRaovmMIrRw+TLCKKD6bAoa3lG7YalSVleDSrqGAAA9HmN+OqT5tjKR/xYXLmFbNDk15Y3F5pOJGD4NIThg9vp0liCUFUFPEawP35rtK3iUlZ5CydDEIJTa45NbUmvWf65aAASda0ZhEsF7HxYEp0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sueNo7e8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=MtMcJFNwJiyCOLkUOkk1+PNy8WkGXe15FL+rE7N/ctE=; t=1724058599; x=1725268199; 
	b=sueNo7e8Zvo+P4ai8JQFg1IRsz0VwLKY9IxIkr3UjtglGekYMvQW0VKVUem1a+7QQd4RIdcQ8VX
	+LB6+5Iue7eLHpNTx0C/e3sMydvpC6Lf4fJjr0e1SRAFCZZeK4+YNkHRyDyPwj861TmC1oP2ETI5v
	Q5E57GokAspAO7WaX6p+jVoYqbbk5VL0BazRBAVEKcEt/7Z2rw3VifINRnmBE5D42ic2zY+rOGDS3
	DhZvzud0wcexNwgUUgAmethQutI2n91VY1vd92GLigowvI/ylA2AhciMtaZrp7WB/5vBpJ02TFNx9
	ZDuJ+UYid08WhI1GjA4hB22iJj9cOw8hZEGg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sfyOh-00000007KfD-277m;
	Mon, 19 Aug 2024 11:09:55 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2] net: drop special comment style
Date: Mon, 19 Aug 2024 11:09:43 +0200
Message-ID: <20240819110950.9602c7ae8daa.Ic187fbc5ba452463ef28feebbd5c18668adb0fec@changeid>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

As we discussed in the room at netdevconf earlier this week,
drop the requirement for special comment style for netdev.

For checkpatch, the general check accepts both right now, so
simply drop the special request there as well.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2:
 - drop paragraph from Documentation/process/coding-style.rst
   (Alexandra Winter)
 - collect Stephen's acked-by
---
 Documentation/process/coding-style.rst      | 12 ------------
 Documentation/process/maintainer-netdev.rst | 17 -----------------
 scripts/checkpatch.pl                       | 10 ----------
 3 files changed, 39 deletions(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 04f6aa377a5d..8e30c8f7697d 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -629,18 +629,6 @@ The preferred style for long (multi-line) comments is:
 	 * with beginning and ending almost-blank lines.
 	 */
 
-For files in net/ and drivers/net/ the preferred style for long (multi-line)
-comments is a little different.
-
-.. code-block:: c
-
-	/* The preferred comment style for files in net/ and drivers/net
-	 * looks like this.
-	 *
-	 * It is nearly the same as the generally preferred comment style,
-	 * but there is no initial almost-blank line.
-	 */
-
 It's also important to comment data, whether they are basic types or derived
 types.  To this end, use just one data declaration per line (no commas for
 multiple data declarations).  This leaves you room for a small comment on each
diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index fe8616397d63..30d24eecdaaa 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -355,23 +355,6 @@ just do it. As a result, a sequence of smaller series gets merged quicker and
 with better review coverage. Re-posting large series also increases the mailing
 list traffic.
 
-Multi-line comments
-~~~~~~~~~~~~~~~~~~~
-
-Comment style convention is slightly different for networking and most of
-the tree.  Instead of this::
-
-  /*
-   * foobar blah blah blah
-   * another line of text
-   */
-
-it is requested that you make it look like this::
-
-  /* foobar blah blah blah
-   * another line of text
-   */
-
 Local variable ordering ("reverse xmas tree", "RCS")
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 39032224d504..4427572b2477 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4015,16 +4015,6 @@ sub process {
 			}
 		}
 
-# Block comment styles
-# Networking with an initial /*
-		if ($realfile =~ m@^(drivers/net/|net/)@ &&
-		    $prevrawline =~ /^\+[ \t]*\/\*[ \t]*$/ &&
-		    $rawline =~ /^\+[ \t]*\*/ &&
-		    $realline > 3) { # Do not warn about the initial copyright comment block after SPDX-License-Identifier
-			WARN("NETWORKING_BLOCK_COMMENT_STYLE",
-			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
-		}
-
 # Block comments use * on subsequent lines
 		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
 		    $prevrawline =~ /^\+.*?\/\*/ &&		#starting /*
-- 
2.46.0


