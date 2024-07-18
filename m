Return-Path: <netdev+bounces-112111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 768B593517F
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 20:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1245C1F216BD
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 18:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF94145B32;
	Thu, 18 Jul 2024 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vjglLNvn"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C4C145B2B
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721326083; cv=none; b=Ehy/tcpp9OaEFlr3zrmdiS7I/nwJolJJUIenMKXDyTCS2pL6hYhad+0bEPAIKqGlNon8T/VaRrLpmd7XRE83YAzECm4RvFyDP1V4uMOAceMzDuCXHPD/RDf8/qkfQ/acpoJo8k1l751paUJP2GEXoCG/iejsQguK3a7kY2gUoTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721326083; c=relaxed/simple;
	bh=GnUynizeBhXw55M4hn7PQrMF3cZN7aM/Ov3YoNmI2Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mmYf/Sxe1UDXfrbufpb4HGsH1KWMcac+FzQtTFsCHiP0lmw0Chcm6OXNQZotVkozA16nnXBLVgm6SZI4pMYd3wEeCTMshEbxSxcdAdI2zVImzIJsvECypda/zVxhzZdDaDNk5dD1kQOztOZJhoox8DiBYuOsKtsmtMsl54zotGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vjglLNvn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=lExCO7+q+7xxtW/56Na+tLHiIolTQVgJN7CjTgDuWas=; t=1721326079; x=1722535679; 
	b=vjglLNvnVBCxFePCZPbsLEdAuMuiX6f1TISj/DznoVVGyIqDw3ckPS3Vm6jimxh7imzkabWEcV3
	Vj0hDQEwAXZToD0F+RMIqZT4zKz7OK0qql7R+YHUGaAysI4Wo32YdC2CRGV+3Gg7d6rlGSXOOvwli
	wj6l5D3iOE7qdWKtwOtQ4EBYhFOfyqG5j/s4zsTBuXDK/C4t95EwCrvLCrHWWuz9OIcOkKbKDhp+p
	XpsBkl1uDp1R2LS0mc0gXyebF4NyjOIxkHByQmfoHkCF/YE8zNwPmcwrOrdzsDvl+bkc7iQhi37os
	M4mIaO7ZOxA5Knvfe5dBTz6Yj+bPbiF8y/Yg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sUVXh-00000001t0J-40G4;
	Thu, 18 Jul 2024 20:07:50 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: Alexandra Winter <wintera@linux.ibm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net-next] net: drop special comment style
Date: Thu, 18 Jul 2024 11:07:40 -0700
Message-ID: <20240718110739.503e986bf647.Ic187fbc5ba452463ef28feebbd5c18668adb0fec@changeid>
X-Mailer: git-send-email 2.45.2
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
index 7e768c65aa92..3ccda9f42cfa 100644
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
index 5e1fcfad1c4c..5a411c52b466 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -356,23 +356,6 @@ just do it. As a result, a sequence of smaller series gets merged quicker and
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
index 2b812210b412..9a953b9169d6 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3997,16 +3997,6 @@ sub process {
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
2.45.2


