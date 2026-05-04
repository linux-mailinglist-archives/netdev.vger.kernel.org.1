Return-Path: <netdev+bounces-283879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK9KLMau+Gn2xgIAu9opvQ
	(envelope-from <netdev+bounces-283879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:35:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 559214BFBC5
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEB553031A22
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F983E4C9A;
	Mon,  4 May 2026 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJK/m7Nv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005003E51C1
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904698; cv=none; b=W33xnrOqzU15rf+yMaEtwYkVy/pTwzs+Z3NQ56wyOCiBx+Ur8aAVILvn4n/al0g159LM0DVl/AsWC1sm0Oec78nPx0WPF6yjPb8e30ZqFRy6p49E4S0W0esxXxohalFz8Tkb9qIX/8bpv3+7pdHVv5PHDZ9QCRFtiP2rsm83Tpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904698; c=relaxed/simple;
	bh=WmUk/hzZFJcKObTRWjUXnGHFK9+dUHG3QByEE5jydN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zhdp5XJ4KcWi28455FHvMCoiiQSRePJIWhUkv2kaJHBtIDA4FoS6WTS5m2+4P29FN/E7mg9biMbhNiIOPnzfb014Drc0WFqiSvV1Cjwnpk4HXJaLZeG5/2lsVcz+1RXFVJoA9Hsbvjnj27nZ/BBkmogHT5BVtJnFcLN8LZPiZ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJK/m7Nv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777904697; x=1809440697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WmUk/hzZFJcKObTRWjUXnGHFK9+dUHG3QByEE5jydN8=;
  b=fJK/m7Nvx/Dhy7IVcwcUfN/cyxfPR8csd8Eluanb5rURd7uAMeGt+j4X
   XJNEqtr3V/l3j1vZv7jRp6MSJwePCxgc2lQKfbcei9im7IomfRB/L1tYS
   mtHfmvQ0ZmNHGVLNWuPfYF+iV1oUNAn52/GjqRYM6BTFdokTLzjEIPiVm
   aNrKGpaoukP+tHOGEWC5o3JRz4wSehW/ePPPa5q+RrC8KvuZvXTAszUQX
   s4L8p2A/k7s5gQe0oOfGaaJbGgFc2KdalN9coN1/w3Imgz71hbv0K5J1W
   eSgpzMEqd46CeIq2fi2+xSJQ1jJDv79pIqTRc2GXx+BeN0CLhPESAVmOh
   A==;
X-CSE-ConnectionGUID: gYmsVw0YSsWVFhF/nXk3fQ==
X-CSE-MsgGUID: aDmp6OHsSguAc5rH532Ogw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78691609"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78691609"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:24:57 -0700
X-CSE-ConnectionGUID: VBk4SrbnTsaPlsmSDBRsKQ==
X-CSE-MsgGUID: +SxbCFl4SLurZhG/Bu45iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="230935401"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa006.fm.intel.com with ESMTP; 04 May 2026 07:24:55 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v2 2/5] ice: remove unnecessary PF_SB_REM_DEV_CTL write for E82X
Date: Mon,  4 May 2026 16:24:48 +0200
Message-ID: <20260504142451.4161845-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260504142451.4161845-1-aleksandr.loktionov@intel.com>
References: <20260504142451.4161845-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 559214BFBC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283879-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]

From: Karol Kolacinski <karol.kolacinski@intel.com>

Remove the PF_SB_REM_DEV_CTL register write from ice_ptp_init_phc_e82x().
PHY access is enabled by default on E82X devices and the driver does not
need to configure switch device access. The register write was a
remnant of an earlier SWITCH_MODE workaround for a FIFO issue and is
no longer needed.

Also update the kernel-doc comment to refer to the E82X family rather than
E822.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 61c0a0d..7b1b402 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2767,22 +2767,13 @@ static int ice_ptp_set_vernier_wl(struct ice_hw *hw)
 }
 
 /**
- * ice_ptp_init_phc_e82x - Perform E822 specific PHC initialization
+ * ice_ptp_init_phc_e82x - Perform E82X specific PHC initialization
  * @hw: pointer to HW struct
  *
- * Perform PHC initialization steps specific to E822 devices.
+ * Perform PHC initialization steps specific to E82X devices.
  */
 static int ice_ptp_init_phc_e82x(struct ice_hw *hw)
 {
-	u32 val;
-
-	/* Enable reading switch and PHY registers over the sideband queue */
-#define PF_SB_REM_DEV_CTL_SWITCH_READ BIT(1)
-#define PF_SB_REM_DEV_CTL_PHY0 BIT(2)
-	val = rd32(hw, PF_SB_REM_DEV_CTL);
-	val |= (PF_SB_REM_DEV_CTL_SWITCH_READ | PF_SB_REM_DEV_CTL_PHY0);
-	wr32(hw, PF_SB_REM_DEV_CTL, val);
-
 	/* Set window length for all the ports */
 	return ice_ptp_set_vernier_wl(hw);
 }
-- 
2.52.0


