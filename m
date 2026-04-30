Return-Path: <netdev+bounces-282835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMGBFKxK82ngzAEAu9opvQ
	(envelope-from <netdev+bounces-282835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:27:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1094A2C18
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 571233038B8C
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD2A402BAC;
	Thu, 30 Apr 2026 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJpume7l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A60C3FB073
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777551973; cv=none; b=jZOikWlf+kGIzp43gx9w9A7yZ/60vudFb65tJDKwQOryDBcDD9RWJN0m6J4PJS4RIC+nM3R2p8tTXaL0GOc4frzeUYR95yoJUpiztjUjkv/OLzGZE9KAhnqXDT9+tFfS+V7w5e0sH70Zh8t8Po7ZrIBA1wWmwj7psQgiu45Y810=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777551973; c=relaxed/simple;
	bh=yPN+lmUC+V9SjMLQPhkRnt+TgdSTwYMAW5C7MIsny0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWf6K+hlUvDWePWuW1ZUb2r58LNHbuDi6uaIm8MjAiT2gYQEbOr9vlp0ErQHBrZt2FpIiOXd25ylC4F01LniffLoxwFY7EDN/CF4BdcacTr+j8Z9WHWKghNx5MFT6imE5z/FP29oO4z7+dPtlCdYKWNG63D4eA+s7SIE31ArytY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJpume7l; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777551972; x=1809087972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yPN+lmUC+V9SjMLQPhkRnt+TgdSTwYMAW5C7MIsny0I=;
  b=MJpume7lGMpHRDqaGA+vIeoYA0+ITGcGAlUhCmbv9pnE7qY0ZadmwskH
   tNPaGigR5kkMkzF1xSa4wHdlraOSxT/j509G39OcEhUBGBPJ4eHiHJ6N9
   uREdvrZrsgWn2fN8HzINQZbgQ00stBEXblWN7sjJ9cTpQNG+2EZEt+Rxo
   7BbLsC/uNEBohIk2+3samK6GNW/2hy3nSQqoTlXyzOFVE4VKiCcPtNDPM
   fSu2gf20uQ8GozYMNt8I+UBdk0lrHPF/7uTCWv2AYrHlwVWkZA/I4Zeub
   2BnOqoSLT0j6uPmeRxt/3f5oaKipwDSU5TnTHCfCuU6qJBuvBfzczPriK
   Q==;
X-CSE-ConnectionGUID: SWxqvh4fT46H8gp/6Zkxkw==
X-CSE-MsgGUID: HVh777MDQUyPSkmMb8p8vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78689195"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="78689195"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 05:26:12 -0700
X-CSE-ConnectionGUID: W7cWY3E6TSePxZt18iY4cQ==
X-CSE-MsgGUID: tNm2NjxQQ021EbHCdHcCkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="233538439"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa006.jf.intel.com with ESMTP; 30 Apr 2026 05:26:11 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH 5/5] ice: use element-by-element comparison for DCB config changes
Date: Thu, 30 Apr 2026 14:26:02 +0200
Message-ID: <20260430122602.126722-6-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
References: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DC1094A2C18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282835-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]

Comparing two ice_dcbx_cfg structs with memcmp() is unreliable on
non-packed structs due to uninitialised padding bytes.  The HW DCB
path already has ice_dcb_need_recfg() that compares fields
individually; export it and use it in the SW DCB netlink setters
(setets, setpfc, setapp, cee_set_all) instead of the unsafe memcmp.

Remove the now-redundant memcmp check from ice_pf_dcb_cfg() so that
function always attempts the HW reconfiguration when called.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 13 ++-------
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h |  2 ++
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c  | 30 ++++++++++++++++++--
 3 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index bd77f1c..2e85fae 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -353,15 +353,11 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 	struct ice_dcbx_cfg *old_cfg, *curr_cfg;
 	struct device *dev = ice_pf_to_dev(pf);
 	struct iidc_rdma_event *event;
-	int ret = ICE_DCB_NO_HW_CHG;
 	struct ice_vsi *pf_vsi;
+	int ret;
 
 	curr_cfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
 
-	/* FW does not care if change happened */
-	if (!pf->hw.port_info->qos_cfg.is_sw_lldp)
-		ret = ICE_DCB_HW_CHG_RST;
-
 	/* Enable DCB tagging only when more than one TC */
 	if (ice_dcb_get_num_tc(new_cfg) > 1) {
 		dev_dbg(dev, "DCB tagging enabled (num TC > 1)\n");
@@ -377,11 +373,6 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 		clear_bit(ICE_FLAG_DCB_ENA, pf->flags);
 	}
 
-	if (!memcmp(new_cfg, curr_cfg, sizeof(*new_cfg))) {
-		dev_dbg(dev, "No change in DCB config required\n");
-		return ret;
-	}
-
 	if (ice_dcb_bwchk(pf, new_cfg))
 		return -EINVAL;
 
@@ -481,7 +472,7 @@ static void ice_cfg_etsrec_defaults(struct ice_port_info *pi)
  * @old_cfg: current DCB config
  * @new_cfg: new DCB config
  */
-static bool
+bool
 ice_dcb_need_recfg(struct ice_pf *pf, struct ice_dcbx_cfg *old_cfg,
 		   struct ice_dcbx_cfg *new_cfg)
 {
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
index da9ba81..a7eaa2f9 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
@@ -20,6 +20,8 @@ u8 ice_dcb_get_num_tc(struct ice_dcbx_cfg *dcbcfg);
 void ice_vsi_set_dcb_tc_cfg(struct ice_vsi *vsi);
 bool ice_is_pfc_causing_hung_q(struct ice_pf *pf, unsigned int txqueue);
 u8 ice_dcb_get_tc(struct ice_vsi *vsi, int queue_index);
+bool ice_dcb_need_recfg(struct ice_pf *pf, struct ice_dcbx_cfg *old_cfg,
+			struct ice_dcbx_cfg *new_cfg);
 int
 ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked);
 int ice_dcb_bwchk(struct ice_pf *pf, struct ice_dcbx_cfg *dcbcfg);
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
index a10c1c8d..13a52c1 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
@@ -108,11 +108,17 @@ static int ice_dcbnl_setets(struct net_device *netdev, struct ieee_ets *ets)
 	if (!bwrec)
 		new_cfg->etsrec.tcbwtable[0] = 100;
 
+	if (!ice_dcb_need_recfg(pf, &pf->hw.port_info->qos_cfg.local_dcbx_cfg,
+				new_cfg)) {
+		err = ICE_DCB_NO_HW_CHG;
+		goto ets_out;
+	}
+
 	err = ice_pf_dcb_cfg(pf, new_cfg, true);
 	/* return of zero indicates new cfg applied */
-	if (err == ICE_DCB_HW_CHG_RST)
+	if (!err)
 		ice_dcbnl_devreset(netdev);
-	if (err == ICE_DCB_NO_HW_CHG)
+	else if (err == ICE_DCB_NO_HW_CHG)
 		err = ICE_DCB_HW_CHG_RST;
 
 ets_out:
@@ -287,11 +293,18 @@ static int ice_dcbnl_setpfc(struct net_device *netdev, struct ieee_pfc *pfc)
 
 	new_cfg->pfc.pfcena = pfc->pfc_en;
 
+	if (!ice_dcb_need_recfg(pf, &pf->hw.port_info->qos_cfg.local_dcbx_cfg,
+				new_cfg)) {
+		err = ICE_DCB_NO_HW_CHG;
+		goto pfc_out;
+	}
+
 	err = ice_pf_dcb_cfg(pf, new_cfg, true);
 	if (err == ICE_DCB_HW_CHG_RST)
 		ice_dcbnl_devreset(netdev);
 	if (err == ICE_DCB_NO_HW_CHG)
 		err = ICE_DCB_HW_CHG_RST;
+pfc_out:
 	mutex_unlock(&pf->tc_mutex);
 	return err;
 }
@@ -845,6 +858,12 @@ static int ice_dcbnl_setapp(struct net_device *netdev, struct dcb_app *app)
 	new_cfg->dscp_map[app->protocol] = app->priority;
 	new_cfg->app[new_cfg->numapps++] = new_app;
 
+	if (!ice_dcb_need_recfg(pf, &pf->hw.port_info->qos_cfg.local_dcbx_cfg,
+				new_cfg)) {
+		ret = ICE_DCB_NO_HW_CHG;
+		goto setapp_out;
+	}
+
 	ret = ice_pf_dcb_cfg(pf, new_cfg, true);
 	/* return of zero indicates new cfg applied */
 	if (ret == ICE_DCB_HW_CHG_RST)
@@ -991,8 +1010,15 @@ static u8 ice_dcbnl_cee_set_all(struct net_device *netdev)
 
 	mutex_lock(&pf->tc_mutex);
 
+	if (!ice_dcb_need_recfg(pf, &pf->hw.port_info->qos_cfg.local_dcbx_cfg,
+				new_cfg)) {
+		err = ICE_DCB_NO_HW_CHG;
+		goto out;
+	}
+
 	err = ice_pf_dcb_cfg(pf, new_cfg, true);
 
+out:
 	mutex_unlock(&pf->tc_mutex);
 	return (err != ICE_DCB_HW_CHG_RST) ? ICE_DCB_NO_HW_CHG : err;
 }
-- 
2.52.0


