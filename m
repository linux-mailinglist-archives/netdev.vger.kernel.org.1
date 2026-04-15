Return-Path: <netdev+bounces-278657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MZBDwAn32nmPQAAu9opvQ
	(envelope-from <netdev+bounces-278657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:49:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D84E9400952
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 334983031BF9
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 05:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8B3372ECD;
	Wed, 15 Apr 2026 05:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBR4NMh3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B67837CD55
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 05:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232170; cv=none; b=tPGJ3nhAkKnNeaHGIyYIKRfMvw8XrSre7u+buxxtC4Cb7OXZrE5e+uFdbyYsaD9di624tB6dzjBp6uqZD7NCccDMS2TcOSs/sMCore26rhmo/WNTL8dXH1siVue4W61p0TH6VOBGd9wziSaFIFg7Ui5Vzh6vZzVTc2lxzWd6UkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232170; c=relaxed/simple;
	bh=dUbHL7XvJHhmT+uyFDR51fhlQVcbSfuTFa89ANhuoXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hiv4dsRF1q6bRt1Y4c4uGsEx+VdlXon1+/06CuqyNPF6D6MTEmTrb8qZiXLi2YR7nztP0YAOzbnf3PD2fCZeGsQ+AhsjreP/yYdtJFkJIBuWvY4OuVT/IDB2JoX66Zf1QV9LiDQr7i+wB79+30Z8xo0Z2DenfX+k1iopLOqyqk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBR4NMh3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776232168; x=1807768168;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=dUbHL7XvJHhmT+uyFDR51fhlQVcbSfuTFa89ANhuoXk=;
  b=gBR4NMh355Vkiy6u8XMuJOX8jkJRgDjm2FwVoy/5yma5Nu100a9R2Hyo
   Bc2wRJVoh+DsF5nFwGIRUOrlnGT2ErKkS8VReF6EZlOOoTnPF6WeZ6407
   9kiD5TpSqMo9LKDTV654MYNj5uoloHLgqRCTdYZgRvEj1udJg4gtn6ZbN
   aRXPhNwvQ5MNyvSgrLT2W4GWR8hCTCeu0c/2nixLa/X9oiGftWqbeZslw
   dx23F6RUSUV0mNwpe3GLHf3aXo9hmgDAkDuvb+HtjwyZhmOk+T41K5iZA
   06R+uYEquI+u8z2LfUF2R51Xf3PYy4pMNpzmJNVwLf0ApXHgnXpuAtIIj
   g==;
X-CSE-ConnectionGUID: ht6iQJz3QeStgJOtUw1+VQ==
X-CSE-MsgGUID: n6JBBwKIT2K/EVY/FQioGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77105939"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77105939"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 22:49:25 -0700
X-CSE-ConnectionGUID: juvtoyvFSnOYJnWe5hjKQQ==
X-CSE-MsgGUID: VLoUDDhzTaChJCf1B7Wtog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="253714804"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 22:49:25 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 14 Apr 2026 22:48:00 -0700
Subject: [PATCH net 05/13] ice: fix PHY config on media change with
 link-down-on-close
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-iwl-net-submission-2026-04-14-v1-5-852f38e7da39@intel.com>
References: <20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com>
In-Reply-To: <20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Paul Greenwalt <paul.greenwalt@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Sunitha Mekala <sunithax.d.mekala@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=7989;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=TnEOG7KnadSEOA3K7hHDI+x3JekY+sVl1EwaEXNI3WM=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsz7ag89s38qXk4vvGQekh9ZnxZwW9fP6UjzZTfFaoa3l
 ydlrdbuKGVhEONikBVTZFFwCFl53XhCmNYbZzmYOaxMIEMYuDgFYCItjxj+2XiVztbKz+nMe6ta
 08P8xOtbnbDe9i/6F58JHmu/kDP3AMP/EP5L2TuVpG4F3173wXHnVUGt/om3ZS8KBx7IdDg466c
 oIwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278657-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: D84E9400952
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paul Greenwalt <paul.greenwalt@intel.com>

Commit 1a3571b5938c ("ice: restore PHY settings on media insertion")
introduced separate flows for setting PHY configuration on media
present: ice_configure_phy() when link-down-on-close is disabled, and
ice_force_phys_link_state() when enabled. The latter incorrectly uses
the previous configuration even after module change, causing link
issues such as wrong speed or no link.

Unify PHY configuration into a single ice_phy_cfg() function with a
link_en parameter, ensuring PHY capabilities are always fetched fresh
from hardware.

Fixes: 1a3571b5938c ("ice: restore PHY settings on media insertion")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 121 +++++++-----------------------
 1 file changed, 27 insertions(+), 94 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3c36e3641b9e..ce3a0afe302d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1922,82 +1922,6 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 	ice_print_vfs_mdd_events(pf);
 }
 
-/**
- * ice_force_phys_link_state - Force the physical link state
- * @vsi: VSI to force the physical link state to up/down
- * @link_up: true/false indicates to set the physical link to up/down
- *
- * Force the physical link state by getting the current PHY capabilities from
- * hardware and setting the PHY config based on the determined capabilities. If
- * link changes a link event will be triggered because both the Enable Automatic
- * Link Update and LESM Enable bits are set when setting the PHY capabilities.
- *
- * Returns 0 on success, negative on failure
- */
-static int ice_force_phys_link_state(struct ice_vsi *vsi, bool link_up)
-{
-	struct ice_aqc_get_phy_caps_data *pcaps;
-	struct ice_aqc_set_phy_cfg_data *cfg;
-	struct ice_port_info *pi;
-	struct device *dev;
-	int retcode;
-
-	if (!vsi || !vsi->port_info || !vsi->back)
-		return -EINVAL;
-	if (vsi->type != ICE_VSI_PF)
-		return 0;
-
-	dev = ice_pf_to_dev(vsi->back);
-
-	pi = vsi->port_info;
-
-	pcaps = kzalloc_obj(*pcaps);
-	if (!pcaps)
-		return -ENOMEM;
-
-	retcode = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_ACTIVE_CFG, pcaps,
-				      NULL);
-	if (retcode) {
-		dev_err(dev, "Failed to get phy capabilities, VSI %d error %d\n",
-			vsi->vsi_num, retcode);
-		retcode = -EIO;
-		goto out;
-	}
-
-	/* No change in link */
-	if (link_up == !!(pcaps->caps & ICE_AQC_PHY_EN_LINK) &&
-	    link_up == !!(pi->phy.link_info.link_info & ICE_AQ_LINK_UP))
-		goto out;
-
-	/* Use the current user PHY configuration. The current user PHY
-	 * configuration is initialized during probe from PHY capabilities
-	 * software mode, and updated on set PHY configuration.
-	 */
-	cfg = kmemdup(&pi->phy.curr_user_phy_cfg, sizeof(*cfg), GFP_KERNEL);
-	if (!cfg) {
-		retcode = -ENOMEM;
-		goto out;
-	}
-
-	cfg->caps |= ICE_AQ_PHY_ENA_AUTO_LINK_UPDT;
-	if (link_up)
-		cfg->caps |= ICE_AQ_PHY_ENA_LINK;
-	else
-		cfg->caps &= ~ICE_AQ_PHY_ENA_LINK;
-
-	retcode = ice_aq_set_phy_cfg(&vsi->back->hw, pi, cfg, NULL);
-	if (retcode) {
-		dev_err(dev, "Failed to set phy config, VSI %d error %d\n",
-			vsi->vsi_num, retcode);
-		retcode = -EIO;
-	}
-
-	kfree(cfg);
-out:
-	kfree(pcaps);
-	return retcode;
-}
-
 /**
  * ice_init_nvm_phy_type - Initialize the NVM PHY type
  * @pi: port info structure
@@ -2066,7 +1990,7 @@ static void ice_init_link_dflt_override(struct ice_port_info *pi)
  * first time media is available. The ICE_LINK_DEFAULT_OVERRIDE_PENDING state
  * is used to indicate that the user PHY cfg default override is initialized
  * and the PHY has not been configured with the default override settings. The
- * state is set here, and cleared in ice_configure_phy the first time the PHY is
+ * state is set here, and cleared in ice_phy_cfg the first time the PHY is
  * configured.
  *
  * This function should be called only if the FW doesn't support default
@@ -2172,14 +2096,18 @@ static int ice_init_phy_user_cfg(struct ice_port_info *pi)
 }
 
 /**
- * ice_configure_phy - configure PHY
+ * ice_phy_cfg - configure PHY
  * @vsi: VSI of PHY
+ * @link_en: true/false indicates to set link to enable/disable
  *
  * Set the PHY configuration. If the current PHY configuration is the same as
- * the curr_user_phy_cfg, then do nothing to avoid link flap. Otherwise
- * configure the based get PHY capabilities for topology with media.
+ * the curr_user_phy_cfg and link_en hasn't changed, then do nothing to avoid
+ * link flap. Otherwise configure the PHY based get PHY capabilities for
+ * topology with media and link_en.
+ *
+ * Return: 0 on success, negative on failure
  */
-static int ice_configure_phy(struct ice_vsi *vsi)
+static int ice_phy_cfg(struct ice_vsi *vsi, bool link_en)
 {
 	struct device *dev = ice_pf_to_dev(vsi->back);
 	struct ice_port_info *pi = vsi->port_info;
@@ -2199,9 +2127,6 @@ static int ice_configure_phy(struct ice_vsi *vsi)
 	    phy->link_info.topo_media_conflict == ICE_AQ_LINK_TOPO_UNSUPP_MEDIA)
 		return -EPERM;
 
-	if (test_bit(ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA, pf->flags))
-		return ice_force_phys_link_state(vsi, true);
-
 	pcaps = kzalloc_obj(*pcaps);
 	if (!pcaps)
 		return -ENOMEM;
@@ -2215,10 +2140,8 @@ static int ice_configure_phy(struct ice_vsi *vsi)
 		goto done;
 	}
 
-	/* If PHY enable link is configured and configuration has not changed,
-	 * there's nothing to do
-	 */
-	if (pcaps->caps & ICE_AQC_PHY_EN_LINK &&
+	/* Configuration has not changed. There's nothing to do. */
+	if (link_en == !!(pcaps->caps & ICE_AQC_PHY_EN_LINK) &&
 	    ice_phy_caps_equals_cfg(pcaps, &phy->curr_user_phy_cfg))
 		goto done;
 
@@ -2282,8 +2205,12 @@ static int ice_configure_phy(struct ice_vsi *vsi)
 	 */
 	ice_cfg_phy_fc(pi, cfg, phy->curr_user_fc_req);
 
-	/* Enable link and link update */
-	cfg->caps |= ICE_AQ_PHY_ENA_AUTO_LINK_UPDT | ICE_AQ_PHY_ENA_LINK;
+	/* Enable/Disable link and link update */
+	cfg->caps |= ICE_AQ_PHY_ENA_AUTO_LINK_UPDT;
+	if (link_en)
+		cfg->caps |= ICE_AQ_PHY_ENA_LINK;
+	else
+		cfg->caps &= ~ICE_AQ_PHY_ENA_LINK;
 
 	err = ice_aq_set_phy_cfg(&pf->hw, pi, cfg, NULL);
 	if (err)
@@ -2336,7 +2263,7 @@ static void ice_check_media_subtask(struct ice_pf *pf)
 		    test_bit(ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA, vsi->back->flags))
 			return;
 
-		err = ice_configure_phy(vsi);
+		err = ice_phy_cfg(vsi, true);
 		if (!err)
 			clear_bit(ICE_FLAG_NO_MEDIA, pf->flags);
 
@@ -4892,9 +4819,15 @@ static int ice_init_link(struct ice_pf *pf)
 
 		if (!test_bit(ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA, pf->flags)) {
 			struct ice_vsi *vsi = ice_get_main_vsi(pf);
+			struct ice_link_default_override_tlv *ldo;
+			bool link_en;
+
+			ldo = &pf->link_dflt_override;
+			link_en = !(ldo->options &
+				    ICE_LINK_OVERRIDE_AUTO_LINK_DIS);
 
 			if (vsi)
-				ice_configure_phy(vsi);
+				ice_phy_cfg(vsi, link_en);
 		}
 	} else {
 		set_bit(ICE_FLAG_NO_MEDIA, pf->flags);
@@ -9707,7 +9640,7 @@ int ice_open_internal(struct net_device *netdev)
 			}
 		}
 
-		err = ice_configure_phy(vsi);
+		err = ice_phy_cfg(vsi, true);
 		if (err) {
 			netdev_err(netdev, "Failed to set physical link up, error %d\n",
 				   err);
@@ -9748,7 +9681,7 @@ int ice_stop(struct net_device *netdev)
 	}
 
 	if (test_bit(ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA, vsi->back->flags)) {
-		int link_err = ice_force_phys_link_state(vsi, false);
+		int link_err = ice_phy_cfg(vsi, false);
 
 		if (link_err) {
 			if (link_err == -ENOMEDIUM)

-- 
2.53.0.1066.g1eceb487f285


