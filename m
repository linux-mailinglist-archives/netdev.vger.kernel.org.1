Return-Path: <netdev+bounces-111823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B9A933346
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 23:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28045281B7F
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 21:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A382F5C8FC;
	Tue, 16 Jul 2024 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YoF9TpKP"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7846455894
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 21:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721164267; cv=none; b=E7dTqxlyWdyEd9K3Xulc1kRtFKvE2F8nWsi3R02payrpPCn6QxHU7kf+Wm+Mvgmg0YwfboND7DjVSDh4CP4dSyWpDsMt6eStwQOmhyMJaXc0CvaW9rqkq+YGZITWZnthS0D4DbR8+4FWBKf8fXOUnE2U4dC7h1N6K97lr0luNKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721164267; c=relaxed/simple;
	bh=E6lPt+xwX6ONYOUoNbPSpOZyfW8K/y3Nzv2vL+RB4P0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SqDQ+w8yo9pwUMsTftFtxSsKA1jL7lSlfqU/hRHwsPNcfkBjRGt+Gf1zlI1hUjoQKQlqjVg0CQ73FfMDfa64lwPxdrfT/YAiygDiFetDQlI7k/sESQaixV2TzpF7sNgEnLDzbEd2wY0d8SQ1PubVG+c/DgN5CfGMkHsEBPxGiZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YoF9TpKP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=0AIxB2dZ7bGTjLCZ+TnqpUO3NaNcVygHlgKrqu9TYBk=; t=1721164261; x=1722373861; 
	b=YoF9TpKPydYrkIsqUahAtxQ60oBa6x4KRFmWgHAWrv+DCeLpJWlB9y2682vohlA8rlFHS1LS4Kl
	6UFCfE4HxKnnPV20rH1+xru+zAC6neck1JwN7hAFCih9+DXm97vavdlaZFtq7u2mg0lq/DyP9qgL6
	Se/gF2FfyCfstrqhbRQP2UyxvdDi9jhrz36plEa8aqmbo5dK6cjF1/WvQ8xcWNf9kEUt+Ecft2LJD
	VgEY5FhwmtWnPpwKKXqOVMlm/noX1rpmZU0Uog86HsKc+qVSqmD0Or3WjOC8IlnUmDySw1HGBhoSU
	ag0nYSIJyspM+gIfq6lQ8lCro+J5qZeIUU0w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sTp66-0000000FJk1-3G32;
	Tue, 16 Jul 2024 22:48:31 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next] net: drop special comment style
Date: Tue, 16 Jul 2024 13:48:23 -0700
Message-ID: <20240716134822.028c84bbd92f.Ic187fbc5ba452463ef28feebbd5c18668adb0fec@changeid>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

As we just discussed (in the room at netdevconf), drop the
requirement for special comment style for netdev.

For checkpatch, the general check accepts both right now,
so simply drop the special request there as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 Documentation/process/maintainer-netdev.rst | 17 -----------------
 scripts/checkpatch.pl                       | 10 ----------
 2 files changed, 27 deletions(-)

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


