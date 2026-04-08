Return-Path: <netdev+bounces-276685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cArmHB6j1mlqGwgAu9opvQ
	(envelope-from <netdev+bounces-276685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:49:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B0D3C1A1F
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 214D93046FF5
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 18:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A0A3D904F;
	Wed,  8 Apr 2026 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CA57XmDS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517DB3624B9
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674053; cv=none; b=scZcDflL6MQGSalmtw6IIDrz8sDDzlJUclaDM1yOtTP5+dySStv21qdbqdHhp6IsW2k9jOxnrhamaBK6BNsxXNt4GzPgGoQzos5j8HbRfh+1JzPR+5nrUfLMRjmJljjtNg/91x4FRHm5XIOjsmg96Y3qdC8S/ARxvhCrOgWF6bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674053; c=relaxed/simple;
	bh=K3UN4pf9JPW3ZpduY02DTj0XVgO7vI4d+ii+qU3c24E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VSxFWiQbj0oHyyQXwVxg5xevGkMasGwRcBAWlGLfobIiCtY6FM4+EKU02Lt+vXBiOFSL8P0PsUP5ihLM4OIItmdJ9Uo0sgzo1Sy/BVzKj4wi4X2JrcWO/J24bluhpGlLkcMuM39iUurrjvktAj4gKTiProCwxt9ehSl2SqWpZBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CA57XmDS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775674052; x=1807210052;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=K3UN4pf9JPW3ZpduY02DTj0XVgO7vI4d+ii+qU3c24E=;
  b=CA57XmDSozTQxwJMZ6VzY7oXgBZr9OqXfR2V2ldtPhgbG68KY06h5gKq
   vr9mrrBsJnl0HvTrscPjeDOvgt9BPb6C7OI3DuhZLPIgRDIMhyYQKbO+e
   /3Nwp37KGhR5hVOwfRPPprNXuHHaiULRz/e5H3Hbzudf+0j4AP90cnNXY
   ZHg+a9Iw7YamAsaHKnat3WRnhFNqzjPxbF4nbqtuw/pkMxUk+ljTDq3MK
   NrlueFFIRc3iYxMCjqM6rIMXIZjnHjM0XI4yjQH5T5ZPsFrrp0jqCiDfh
   k/wZf58ktQBypRodXk4rmx27lnbYYI5VhVXKWfl9u1Iqcm3UOIAFUz4bb
   A==;
X-CSE-ConnectionGUID: qBb65mKqT2m471BOHlbjnA==
X-CSE-MsgGUID: uaypXznuQ2mUbO/jQTD/pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75841385"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="75841385"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 11:47:28 -0700
X-CSE-ConnectionGUID: QBP765/BQXmy6Y3irzVc5w==
X-CSE-MsgGUID: 8BBOg8TlRqK92yagsDYzpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="230217560"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 11:47:26 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 08 Apr 2026 11:46:31 -0700
Subject: [PATCH iwl-net 1/4] ice: fix timestamp interrupt configuration for
 E825C
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-jk-even-more-e825c-fixes-v1-1-b959da91a81f@intel.com>
References: <20260408-jk-even-more-e825c-fixes-v1-0-b959da91a81f@intel.com>
In-Reply-To: <20260408-jk-even-more-e825c-fixes-v1-0-b959da91a81f@intel.com>
To: Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Timothy Miskell <timothy.miskell@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.16-dev-306a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=5492;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=RfOBce6ZBKcXPiiqDoqjeTQe/2/0bz7nXMgcDDG6AGY=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsxri/bwJU5UC2bVt2Y99Vgl1PBVnsPk86mCnybF/k6c2
 +ZQJHa7o5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgImw/Gb4p1/9vEdJ8wrDvR2m
 28OvxCo6bzr5aY/De+eHoveNp2msvsjwVzRWRuuFz9tFe/mK9N1ef1r0um0PZz9rzesC14RvB3Z
 E8QIA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276685-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54B0D3C1A1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

The E825C ice_phy_cfg_intr_eth56g() function is responsible for programming
the PHY interrupt for a given port. This function writes to the
PHY_REG_TS_INT_CONFIG register of the port. The register is responsible for
configuring whether the port interrupt logic is enabled, as well as
programming the threshold of waiting timestamps that will trigger an
interrupt from this port.

This threshold value must not be programmed to zero while the interrupt is
enabled. Doing so puts the port in a misconfigured state where the PHY
timestamp interrupt for the quad of connected ports will become stuck.

This occurs, because a threshold of zero results in the timestamp interrupt
status for the port becoming stuck high. The four ports in the connected
quad have their timestamp status indicators muxed together. A new interrupt
cannot be generated until the timestamp status indicators return low for
all four ports.

Normally, the timestamp status for a port will clear once there are fewer
timestamps in that ports timestamp memory bank than the threshold. A
threshold of zero makes this impossible, so the timestamp status for the
port does not clear.

The ice driver never intentionally programs the threshold to zero, indeed
the driver always programs it to a value of 1, intending to get an
interrupt immediately as soon as even a single packet is waiting for a
timestamp.

However, there is a subtle flaw in the programming logic in the
ice_phy_cfg_intr_eth56g() function. Due to the way that the hardware
handles enabling the PHY interrupt. If the threshold value is modified at
the same time as the interrupt is enabled, the HW PHY state machine might
enable the interrupt before the new threshold value is actually updated.
This leaves a potential race condition caused by the hardware logic where
a PHY timestamp interrupt might be triggered before the non-zero threshold
is written, resulting in the PHY timestamp logic becoming stuck.

Once the PHY timestamp status is stuck high, it will remain stuck even
after attempting to reprogram the PHY block by changing its threshold or
disabling the interrupt. Even a typical PF or CORE reset will not reset the
particular block of the PHY that becomes stuck. Even a warm power cycle is
not guaranteed to cause the PHY block to reset, and a cold power cycle is
required.

Prevent this by always writing the PHY_REG_TS_INT_CONFIG in two stages.
First write the threshold value with the interrupt disabled, and only write
the enable bit after the threshold has been programmed. When disabling the
interrupt, leave the threshold unchanged. Additionally, re-read the
register after writing it to guarantee that the write to the PHY has been
flushed upon exit of the function.

While we're modifying this function implementation, explicitly reject
programming a threshold of 0 when enabling the interrupt. No caller does
this today, but the consequences of doing so are significant. An explicit
rejection in the code makes this clear.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 36 +++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index e3db252c3918..67775beb9449 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -1847,6 +1847,8 @@ static int ice_phy_cfg_mac_eth56g(struct ice_hw *hw, u8 port)
  * @ena: enable or disable interrupt
  * @threshold: interrupt threshold
  *
+ * The threshold cannot be 0 while the interrupt is enabled.
+ *
  * Configure TX timestamp interrupt for the specified port
  *
  * Return:
@@ -1858,19 +1860,45 @@ int ice_phy_cfg_intr_eth56g(struct ice_hw *hw, u8 port, bool ena, u8 threshold)
 	int err;
 	u32 val;
 
+	if (ena && !threshold)
+		return -EINVAL;
+
 	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_TS_INT_CONFIG, &val);
 	if (err)
 		return err;
 
+	val &= ~PHY_TS_INT_CONFIG_ENA_M;
 	if (ena) {
-		val |= PHY_TS_INT_CONFIG_ENA_M;
 		val &= ~PHY_TS_INT_CONFIG_THRESHOLD_M;
 		val |= FIELD_PREP(PHY_TS_INT_CONFIG_THRESHOLD_M, threshold);
-	} else {
-		val &= ~PHY_TS_INT_CONFIG_ENA_M;
+		err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TS_INT_CONFIG,
+					       val);
+		if (err) {
+			ice_debug(hw, ICE_DBG_PTP,
+				  "Failed to update 'threshold' PHY_REG_TS_INT_CONFIG port=%u ena=%u threshold=%u\n",
+				  port, !!ena, threshold);
+			return err;
+		}
+		val |= PHY_TS_INT_CONFIG_ENA_M;
 	}
 
-	return ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TS_INT_CONFIG, val);
+	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TS_INT_CONFIG, val);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP,
+			  "Failed to update 'ena' PHY_REG_TS_INT_CONFIG port=%u ena=%u threshold=%u\n",
+			  port, !!ena, threshold);
+		return err;
+	}
+
+	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_TS_INT_CONFIG, &val);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP,
+			  "Failed to read PHY_REG_TS_INT_CONFIG port=%u ena=%u threshold=%u\n",
+			  port, !!ena, threshold);
+		return err;
+	}
+
+	return 0;
 }
 
 /**

-- 
2.53.0.1066.g1eceb487f285


