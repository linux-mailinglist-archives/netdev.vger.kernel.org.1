Return-Path: <netdev+bounces-276541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD4iMrlV1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:18:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 275383BCBAA
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1E0230D9A7D
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A3F3CD8BB;
	Wed,  8 Apr 2026 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NiK70kGW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543043CCFB7
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653927; cv=none; b=WDrbB8oJ2WWmxX3ZcN+ykwXjKw0MMt/siTQWT2qzQGfOaEV3iL/wooEwE2/+/S4qFlC05Ukf0ko4cfJPJ/0dy6hhlzz9ZnXpMALF+OmvmPRHv7RppuxUbNup528NF2bVDjxXaEaCTE/Ndj5a2Zj+7gC4KIHo8qs7kEcYzSrRWOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653927; c=relaxed/simple;
	bh=LU06K51Gotx2bmJxCVz4VDn41OARIsR6jwdtt19pDGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKdO3Qv2KWuO8lN9meVrJG7FCl7KP0PIulutsYTh+okZQGQQV6c6Bhb7/a6BcvDBIpfRaVgExU+ODYPaVm2iFm6MhY15cObU5Wg3DN8wl8D7h+Kf4EHpZvyLgQdxemmjRZvlPy3Rh+R/awONmWk/V64aJFb12iRuRRoyCrWXhCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NiK70kGW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775653926; x=1807189926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LU06K51Gotx2bmJxCVz4VDn41OARIsR6jwdtt19pDGM=;
  b=NiK70kGWmOI8RFJImbFKvRsbV+BNGhzxMGF9td/k/2ZxokXh5KhYszom
   u4YnGjFoVgrhtPIz9Mf97DnKWeWfXEwvKP1gLeUOdFwgi3eq4EZhphfXO
   EVYbNFX1bbramneOiE9kDAcXF3Av6jykxuw2IkcV7yrcCCg5/BEKiPjwL
   FSYDJRVAEtwOKDzhjUucY9DgyLRj3BTCfA8/YzxHe45dGcbG30Kg+hnTQ
   iag9xiCHUv5aCz+Ap/BfNwXOzKASUpG/GEIh8od+2iweb61OzQnmzbfxN
   pRBmSUv54Readd7iv4SmCE3C2nnLrxbcWPmIxxz8yB+hKoSK96QHQSD8S
   A==;
X-CSE-ConnectionGUID: O21oDTRJQf2ZSVEfa5O4gg==
X-CSE-MsgGUID: gzH3unY1SAm4c0f47vciZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="102087240"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="102087240"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 06:12:06 -0700
X-CSE-ConnectionGUID: UoruqNZeSIK/gIMoqZhRJw==
X-CSE-MsgGUID: Ajq+f5wrTI+FO0oDjwlMYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="228714985"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa007.jf.intel.com with ESMTP; 08 Apr 2026 06:12:04 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v2 6/6] ixgbe: fix integer overflow and wrong bit position in ixgbe_validate_rtr()
Date: Wed,  8 Apr 2026 15:11:54 +0200
Message-ID: <20260408131154.2661818-7-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408131154.2661818-1-aleksandr.loktionov@intel.com>
References: <20260408131154.2661818-1-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276541-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 275383BCBAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two bugs in the same loop in ixgbe_validate_rtr():

1. The 3-bit traffic-class field was extracted by shifting a u32 and
   assigning the result directly to a u8.  For user priority 0 this is
   harmless; for UP[5..7] the shift leaves bits [15..21] in the u32
   which are then silently truncated when stored in u8.  Mask with
   IXGBE_RTRUP2TC_UP_MASK before the assignment so only the intended
   3 bits are kept.

2. When clearing an out-of-bounds entry the mask was always shifted by
   the fixed constant IXGBE_RTRUP2TC_UP_SHIFT (== 3), regardless of
   which loop iteration was being processed.  This means only UP1 (bit
   position 3) was ever cleared; UP0,2..7 (positions 0, 6, 9, ..., 21)
   were left unreset, so invalid TC mappings persisted in hardware and
   could mis-steer received packets to the wrong traffic class.
   Use i * IXGBE_RTRUP2TC_UP_SHIFT to target the correct 3-bit field
   for each iteration.

Swap the operand order in the mask expression to place the constant
on the right per kernel coding style (noted by David Laight).

Fixes: e7589eab9291 ("ixgbe: consolidate, setup for multiple traffic classes")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1 -> v2:
 - Add Fixes: tag; reroute to iwl-net (wrong bit positions cause packet
   mis-steering); swap to (reg >> ...) & MASK operand order per David
   Laight.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 210c7b9..c9e4f12 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9772,11 +9772,12 @@ static void ixgbe_validate_rtr(struct ixgbe_adapter *adapter, u8 tc)
 	rsave = reg;
 
 	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
-		u8 up2tc = reg >> (i * IXGBE_RTRUP2TC_UP_SHIFT);
+		u8 up2tc = (reg >> (i * IXGBE_RTRUP2TC_UP_SHIFT)) &
+			   IXGBE_RTRUP2TC_UP_MASK;
 
 		/* If up2tc is out of bounds default to zero */
 		if (up2tc > tc)
-			reg &= ~(0x7 << IXGBE_RTRUP2TC_UP_SHIFT);
+			reg &= ~(IXGBE_RTRUP2TC_UP_MASK << (i * IXGBE_RTRUP2TC_UP_SHIFT));
 	}
 
 	if (reg != rsave)
-- 
2.52.0

