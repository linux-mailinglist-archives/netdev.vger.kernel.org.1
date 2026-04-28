Return-Path: <netdev+bounces-281637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPuOAtFE8Gn2QwEAu9opvQ
	(envelope-from <netdev+bounces-281637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:25:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 543B547D8AA
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B9E4304C945
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039AC3382F0;
	Tue, 28 Apr 2026 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H5Rm7tdf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0697933A014
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353803; cv=none; b=QK2paG2o0xGcfJ3cOEani/SwluwiCsdvQNlolpL6jhZN3dTMoCj7GMympAgnD4TS2y8md7Bmjod2HJOqQHa8uEur5Ep82ATnS4tsaewiqahggpeETAcvqkRBaDUpgk/vK6/qlt5mI3QnPat91djl0+149S9FftD5shq4kC8ORHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353803; c=relaxed/simple;
	bh=u/OiWeUb1xI4knNRa06YhkTxQjXiITwhmCdk3EIs6kM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aoKFx0cgvi5ZOpUDN8uQj30GiV7qXwkCyO9xQirPpPCdAZ4JcLD0boI0eqJBoj00F71l4qI6Lif/Ugecn07fZCj5M44ZlpEhJ3sVKlXN/A+Fje5MpNCDRIfyiWfqKdIU9xgLIvrboQI3BfVg2VEuNcWcQPsnuByDOAFvwvm4bs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H5Rm7tdf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353802; x=1808889802;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=u/OiWeUb1xI4knNRa06YhkTxQjXiITwhmCdk3EIs6kM=;
  b=H5Rm7tdfrXMuN7OXqxu9SCM5JTTvybZqCjzqDnokfSYgoOfJIvow1Dtm
   44ESpLYmEkkTmhefhNExzefr393QHEw5J+nlSQ5u3ZH4KH8o7bjQ9iGjk
   38aaqgnI8fb/IVwGEzyhCH9qlRbN5YuKHumUEKu1E70EkpRmtZgYlqh3i
   f6Q4dsrFb1pwJ21qIL2dc3J8MHtVHrdAkEkUfE53cb3CikH25DL9ZXz0W
   fZ8PwP8VSGL990MJwW79bpRi1LARko3CJxRVTPInxk6N8xkMxWscDn2od
   ypffeIykxq8EmBsuqkJW9CRytrmFLy4rQB9jIsEaC18O1wPcTIMMbTNmc
   w==;
X-CSE-ConnectionGUID: yEwtrIozS5GnS1GF/IHUGQ==
X-CSE-MsgGUID: 3hFe0RDIRJqw4kQKd39e9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="100910554"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="100910554"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:16 -0700
X-CSE-ConnectionGUID: yWdbYKDSST2YyWqQE1herw==
X-CSE-MsgGUID: de0MTZhsT4ecdGhY1SzQMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="237800213"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:16 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 27 Apr 2026 22:22:19 -0700
Subject: [PATCH net 07/11] ice: fix missing SMA pin initialization in DPLL
 subsystem
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-jk-iwl-net-petr-oros-fixes-v1-7-cdcb48303fd8@intel.com>
References: <20260427-jk-iwl-net-petr-oros-fixes-v1-0-cdcb48303fd8@intel.com>
In-Reply-To: <20260427-jk-iwl-net-petr-oros-fixes-v1-0-cdcb48303fd8@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Petr Oros <poros@redhat.com>, Ivan Vecera <ivecera@redhat.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Alexander Nowlin <alexander.nowlin@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3150;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=2334wDsm+QZIYHl9YbbnW/nY/RHkfu4WygIEfr6Ds+s=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswPLk76xTJBHZ1Z5+/vMTDbUWr4jFs+/rVinnLtTSmvp
 tufPMM6SlkYxLgYZMUUWRQcQlZeN54QpvXGWQ5mDisTyBAGLk4BmMirToa/Mqtm8H7hbOt+ln8k
 /Fto3O9Vin8mT9SMEdXY8t7Ox/nNW0aGCeWrFt27mXp3+any/8trLu3senLAwH7xbB7dwOqa57O
 6WQA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 543B547D8AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281637-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Petr Oros <poros@redhat.com>

The DPLL SMA/U.FL pin redesign introduced ice_dpll_sw_pin_frequency_get()
which gates frequency reporting on the pin's active flag. This flag is
determined by ice_dpll_sw_pins_update() from the PCA9575 GPIO expander
state. Before the redesign, SMA pins were exposed as direct HW
input/output pins and ice_dpll_frequency_get() returned the CGU
frequency unconditionally — the PCA9575 state was never consulted.

The PCA9575 powers on with all outputs high, setting ICE_SMA1_DIR_EN,
ICE_SMA1_TX_EN, ICE_SMA2_DIR_EN and ICE_SMA2_TX_EN. Nothing in the
driver writes the register during initialization, so
ice_dpll_sw_pins_update() sees all pins as inactive and
ice_dpll_sw_pin_frequency_get() permanently returns 0 Hz for every
SW pin.

Fix this by writing a default SMA configuration in
ice_dpll_init_info_sw_pins(): clear all SMA bits, then set SMA1 and
SMA2 as active inputs (DIR_EN=0) with U.FL1 output and U.FL2 input
disabled. Each SMA/U.FL pair shares a physical signal path so only
one pin per pair can be active at a time. U.FL pins still report
frequency 0 after this fix: U.FL1 (output-only) is disabled by
ICE_SMA1_TX_EN which keeps the TX output buffer off, and U.FL2
(input-only) is disabled by ICE_SMA2_UFL2_RX_DIS. They can be
activated by changing the corresponding SMA pin direction via dpll
netlink.

Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 62f75701d652..498ec2c045f3 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -4014,6 +4014,7 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 	struct ice_dpll_pin *pin;
 	u32 phase_adj_max, caps;
 	int i, ret;
+	u8 data;
 
 	if (pf->hw.device_id == ICE_DEV_ID_E810C_QSFP)
 		input_idx_offset = ICE_E810_RCLK_PINS_NUM;
@@ -4073,6 +4074,22 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 		}
 		ice_dpll_phase_range_set(&pin->prop.phase_range, phase_adj_max);
 	}
+
+	/* Initialize the SMA control register to a known-good default state.
+	 * Without this write the PCA9575 GPIO expander retains its power-on
+	 * default (all outputs high) which makes all SW pins appear inactive.
+	 * Set SMA1 and SMA2 as active inputs, disable U.FL1 output and
+	 * U.FL2 input.
+	 */
+	ret = ice_read_sma_ctrl(&pf->hw, &data);
+	if (ret)
+		return ret;
+	data &= ~ICE_ALL_SMA_MASK;
+	data |= ICE_SMA1_TX_EN | ICE_SMA2_TX_EN | ICE_SMA2_UFL2_RX_DIS;
+	ret = ice_write_sma_ctrl(&pf->hw, data);
+	if (ret)
+		return ret;
+
 	ret = ice_dpll_pin_state_update(pf, pin, ICE_DPLL_PIN_TYPE_SOFTWARE,
 					NULL);
 	if (ret)

-- 
2.54.0.rc2.531.gaf818d63126a


