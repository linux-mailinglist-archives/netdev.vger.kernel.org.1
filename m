Return-Path: <netdev+bounces-272421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNLDDN8zxmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:38:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C81340855
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9147E30A3D69
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89593CBE9F;
	Fri, 27 Mar 2026 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ee/wyvWz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AF63CAE80
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596686; cv=none; b=Dfm+A68IxbXxYapv47v6h5u0jHdeW7+maVT0IvMtBLBkyvp0hH2CjFtc12uqQ7Q5OjT5diiNj2LpuaD/S8iUiNDUe4OpTb3O9u06vdsQ79n/EvCFQKXTUKv/DJC8Ffc7BCUStzR/SRc4q6RrJuByQ+w/xCZf1WYNOAlTXPi3TR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596686; c=relaxed/simple;
	bh=yOMRZi0/3SiDel76zDrsB6VaNT3oaM/8FJKDjA+kZU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtVmW8GCm1qYQFnoJZI8QzKtcqOWqvjEjPJJvax4BI2tEjeNpOZa+ZPycb3fzZ3l/PQK6HAusI2m/BbEsbT3XMzckvGngL5fxK5Gi05qCLHYalRZxN73UWVOeBlj1O30EnyGHaaxc1Sx8155O+Q1JzcPIJBC3++AphLjOQ50xn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ee/wyvWz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596675; x=1806132675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yOMRZi0/3SiDel76zDrsB6VaNT3oaM/8FJKDjA+kZU0=;
  b=ee/wyvWzSYdeqocxXe1v9y3BU1ljBdWP9EO+umtAf39SD4ud3q7G0WR7
   o13ANlDGQeCzBVNmsRMRJrpOgQwDmJHrY9TWQ28Tay2CMeF5QNhwIvzRX
   3DLzhsF9rIrtZmkMQKMgA0O3dijM5LD2ENpY35zO7kAOu6ry6PATKRk2W
   uMP6c4sLYsLonmTYyp7mtV0ag0eTfwVUn88eCtPS9MynrYX8VRceBH9BU
   ++fKdOpYR5IVi2lrJhUr+TZTjIQvr5fmqYWneEqdSUh4vUjO2g6mIm91h
   y8OKC1rXZekHZsLshRy0shlR/h5HWS+axqyAZW2zaer0tE2puxcirZRR2
   A==;
X-CSE-ConnectionGUID: yPHLbxCfSUWPWxI3d73N9g==
X-CSE-MsgGUID: XRQVla9HR0ivCUHz+nAR5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75734332"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75734332"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:31:03 -0700
X-CSE-ConnectionGUID: iwt7FBKaQt+b0OKEi/VAiA==
X-CSE-MsgGUID: 7qbuhTliSaiKAsw4i5HMWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255740432"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:31:02 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next] ixgbe: fix ITR value overflow in adaptive interrupt throttling
Date: Fri, 27 Mar 2026 08:30:45 +0100
Message-ID: <20260327073046.134085-11-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272421-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0C81340855
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ixgbe_update_itr() packs a mode flag (IXGBE_ITR_ADAPTIVE_LATENCY, bit 7)
and a usecs delay (bits [6:0]) into an unsigned int, then stores it in
ring_container->itr which is u8.  Values above 0xFF wrap, corrupting both
the delay and the mode-flag on the next readback.

Separate the mode bits from the usecs sub-field; clamp only the latter to
[0, IXGBE_ITR_ADAPTIVE_LATENCY - 1] via min_t(unsigned int, ...) so
overflow cannot bleed into bit 7.  Add a WARN_ONCE() when the raw usecs
value exceeds U8_MAX so out-of-range ITR computations are visible in
dmesg during development and testing.

Fixes: b4ded8327fea ("ixgbe: Update adaptive ITR algorithm")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 1885fe8..4d53bd63 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2901,8 +2901,12 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 	if ((itr & IXGBE_ITR_ADAPTIVE_LATENCY) && itr < ring_container->itr)
 		itr = ring_container->itr - IXGBE_ITR_ADAPTIVE_MIN_INC;
 clear_counts:
-	/* write back value */
-	ring_container->itr = itr;
+	WARN_ONCE((itr & ~IXGBE_ITR_ADAPTIVE_LATENCY) > U8_MAX,
+		  "ITR value %u exceeds U8_MAX, clamping\n", itr);
+
+	ring_container->itr = (itr & IXGBE_ITR_ADAPTIVE_LATENCY) |
+		min_t(unsigned int, itr & ~IXGBE_ITR_ADAPTIVE_LATENCY,
+		      IXGBE_ITR_ADAPTIVE_LATENCY - 1);
 
 	/* next update should occur within next jiffy */
 	ring_container->next_update = next_update + 1;
-- 
2.52.0


