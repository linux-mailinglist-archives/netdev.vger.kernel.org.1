Return-Path: <netdev+bounces-200845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F27AE7157
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65EB317BD9A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1772925A659;
	Tue, 24 Jun 2025 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j81qwTVw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F2025A63D
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799412; cv=none; b=QdAvlUmJ5fmkMRzGsso/swiUFpD34SfwnD91JjOYFPEFWgKoxuDXebyaIa4U8gBxW9BidvfLpuIsA78lXxM9enJBFQibqMC+TUTGRwYPSIujGZ5z/hnTPvx4o7bPcuww0rZal/l8LmuKUgrePeVj5wC5LvLPIPXeKGVPxRC9J1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799412; c=relaxed/simple;
	bh=Gop5oNASOKTIfr7LmXRoKAgoiaG23N7sU2bfYZf+y6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qK4S8p+PFLrbAKl+e84yfh61S4CpLkVGSEV30S2teAqKvdMpKRvPLfNazzmtrkbL6WRhUJut6Xggedat1yAMX7jsepnYdRVOPJx70YNUEhfHm+oDnJhxzpeCYS9nagfcSf+k5EJBT/MnqQ3kfSiZ24uphvbC0D8vRYitEXOU2W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j81qwTVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64391C4CEF6;
	Tue, 24 Jun 2025 21:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750799411;
	bh=Gop5oNASOKTIfr7LmXRoKAgoiaG23N7sU2bfYZf+y6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j81qwTVwGN2mTaeFqw+6wM3IX/Pm4VvmvXatuknyzHsx5xQEAUtKXIsU/sVUZiIcS
	 wdKZCw6NSbnMzpStjhJZkUHQHM6yytUI3Pz1Mu2KbIV6ab79PqFWyU+PY8WgJlVjn3
	 jtnXtM1z63K0Ou3yalkH7gxs6hzLWAfiQQlGEy2Zv90w/jH/7mJOXUrdgw0z+m71QL
	 KXa9O3/wD/UWFpsKlWTA8DqVH5vKrov6TTiHFFo9xJdzD2+zPK1NB2X+7CKuDsjJSP
	 QXojN/rEgaIK/gJpTcgz2q1xYC+GpibUc1FXK3yLeRZ/jfIOL76Z/ymYwS+S/Xaz29
	 56bjDzygDUjcA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	jacob.e.keller@intel.com
Subject: [PATCH net 08/10] netlink: specs: rt-link: replace underscores with dashes in names
Date: Tue, 24 Jun 2025 14:10:00 -0700
Message-ID: <20250624211002.3475021-9-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624211002.3475021-1-kuba@kernel.org>
References: <20250624211002.3475021-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're trying to add a strict regexp for the name format in the spec.
Underscores will not be allowed, dashes should be used instead.
This makes no difference to C (codegen, if used, replaces special
chars in names) but it gives more uniform naming in Python.

Fixes: b2f63d904e72 ("doc/netlink: Add spec for rt link messages")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: jacob.e.keller@intel.com
---
 Documentation/netlink/specs/rt-link.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index b41b31eebcae..28c4cf66517c 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -603,7 +603,7 @@ protonum: 0
         name: optmask
         type: u32
   -
-    name: if_stats_msg
+    name: if-stats-msg
     type: struct
     members:
       -
@@ -2486,7 +2486,7 @@ protonum: 0
       name: getstats
       doc: Get / dump link stats.
       attribute-set: stats-attrs
-      fixed-header: if_stats_msg
+      fixed-header: if-stats-msg
       do:
         request:
           value: 94
-- 
2.49.0


