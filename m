Return-Path: <netdev+bounces-304144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 104VIgRQRmotQgsAu9opvQ
	(envelope-from <netdev+bounces-304144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 13:48:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FD86F6FD0
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 13:48:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=cMvyIZQo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304144-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304144-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0D6431E9101
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 11:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197B5449EB6;
	Thu,  2 Jul 2026 11:30:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E91C42A7A3
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 11:30:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991849; cv=none; b=NfucOut+UZHCX1aoo9UhgsZtklCoa5hjrHYoLb0QBuyvfkMU7j1IMYIx1OC0+Ze9danZ98bwjTbDsVkNpYkyE2TUodh/nl02svWjhgLfCgmmBd0LjX0UtDoEZ8GNT/m96R7LH3cF6Zs7NBykFwhc/MPYpgkMGsdx4OEHsEXtKR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991849; c=relaxed/simple;
	bh=232DBDdtJGBW2nEuoIrLOyYdHnfEfjPiz+ZGlJPznw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYZRQzQG9u3mxfcEJpYgkPOMIdzd1LalkOpa7um1RLpJQh7aS0VgJ0N2Eha46Bgn8zCZX8kXalVF3psPlWahQdUXET5Ve2zSVW+gogZFM4d2Xaf0eQLeRVjigHxHC/KYLVC3PU8pcnKSKN59htzhuMCCFmYRHJmRlf1X2Eq0IPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMvyIZQo; arc=none smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782991847; x=1814527847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=232DBDdtJGBW2nEuoIrLOyYdHnfEfjPiz+ZGlJPznw0=;
  b=cMvyIZQocBOcFIMJr+69WEAyC5R0vN2ZcJGS7AH0sQ+jqnHeXATn/C7L
   2c5voaLe1g4r98uBmyJ6JOxOetfjfLCuEm2XH1DvJMaZHRuJQUnbebLgf
   4enYB5knFyUMi3mjB1UZUzTUM+ryeKO6iI08Tus7MzegXNzXlWNrOgNzO
   iar4b+x3aaWBwgE2HUGQRyK1+T8fMuA5l3ceGk3AVTVWq85iIZZplMhQF
   Xn/TDiriK6HIEsb4pvOxjjehA+mQg+JawvHx5XUL0NvKbZMZV2+vKAC37
   9o2dJywFZbmHYRIcG1VoqNf8GgAbQHAHcvMgo2GCvysHuTkezUvkUsL9f
   g==;
X-CSE-ConnectionGUID: xAkzDa2YTtqp0x5CMl+a6g==
X-CSE-MsgGUID: F5nUebglS0CaEQyOKYVw5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83611755"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="83611755"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 04:30:47 -0700
X-CSE-ConnectionGUID: Kjc5JQOUTNuMLgsLMAWb9w==
X-CSE-MsgGUID: 1TPOhj9JTOOETaeuS04A0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="251788435"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa010.jf.intel.com with ESMTP; 02 Jul 2026 04:30:45 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id ECEEC28763;
	Thu,  2 Jul 2026 12:30:43 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v5 12/12] ice: use ACL for ntuple rules that conflict with FDir
Date: Thu,  2 Jul 2026 12:30:06 +0200
Message-ID: <20260702103007.97020-13-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
References: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,linux.intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:sandeep.penigalapati@intel.com,m:ananth.s@intel.com,m:alexander.duyck@gmail.com,m:anthony.l.nguyen@intel.com,m:marcin.szycik@linux.intel.com,m:lukasz.czapnik@intel.com,m:aleksandr.loktionov@intel.com,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304144-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.intel.com:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72FD86F6FD0

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

Flow Director can keep only one input set per flow type. After ACL support
was added for ethtool ntuple rules, the driver still only selected ACL for
rules with partial masks.

That leaves a gap for rules with full masks that still require a different
input set than the one already programmed for Flow Director. Such rules go
through the FDir path, build a different extraction sequence and then fail
because the existing FDir profile cannot be reused.

Detect this case before programming the rule. Build the candidate IP flow
segment, compare it with the active non-tunneled FDir profile and, when the
input sets differ, offload the rule through ACL if ACL is available.

Refactor the IP flow segment setup into a helper so the same logic can be
used both by the extraction-sequence configuration path and by the conflict
check.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
v5:
* ice_fdir_has_input_set_conflict(): add a check if aRFS is using perfect
  filters that may cause a conflict
* ice_add_ntuple_ethtool(): add a guard that rejects flex-byte (user-def)
  filters when they would be routed to ACL (since ACL ignores the flex
  constraint, it would silently offload a broader rule)
* ice_add_ntuple_ethtool(): join subsequent conditions that call
  ice_acl_add_rule_ethtool() for clarity
v3:
* Include flex fields in test_seg to avoid false conflict detection
* Skip conflict check early for ETHER_FLOW
v2:
* Add this patch
---
 .../ethernet/intel/ice/ice_ethtool_ntuple.c   | 189 +++++++++++++-----
 1 file changed, 140 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
index be7bfee9e977..79496ad17781 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
@@ -1459,6 +1459,120 @@ ice_set_fdir_vlan_seg(struct ice_flow_seg_info *seg,
 	return 0;
 }
 
+/**
+ * ice_set_fdir_ip_flow_seg - set IP flow segment based on ethtool flow type
+ * @fsp: pointer to ethtool Rx flow specification
+ * @seg: flow segment for programming
+ * @perfect_fltr: valid on success; returns true if perfect fltr, false if not
+ *
+ * Return: 0 on success and errno in case of error.
+ */
+static int ice_set_fdir_ip_flow_seg(struct ethtool_rx_flow_spec *fsp,
+				    struct ice_flow_seg_info *seg,
+				    bool *perfect_fltr)
+{
+	switch (fsp->flow_type & ~FLOW_EXT) {
+	case TCP_V4_FLOW:
+		return ice_set_fdir_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
+					    ICE_FLOW_SEG_HDR_TCP, perfect_fltr);
+	case UDP_V4_FLOW:
+		return ice_set_fdir_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
+					    ICE_FLOW_SEG_HDR_UDP, perfect_fltr);
+	case SCTP_V4_FLOW:
+		return ice_set_fdir_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
+					    ICE_FLOW_SEG_HDR_SCTP,
+					    perfect_fltr);
+	case IPV4_USER_FLOW:
+		return ice_set_fdir_ip4_usr_seg(seg, &fsp->m_u.usr_ip4_spec,
+						perfect_fltr);
+	case TCP_V6_FLOW:
+		return ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
+					    ICE_FLOW_SEG_HDR_TCP, perfect_fltr);
+	case UDP_V6_FLOW:
+		return ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
+					    ICE_FLOW_SEG_HDR_UDP, perfect_fltr);
+	case SCTP_V6_FLOW:
+		return ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
+					    ICE_FLOW_SEG_HDR_SCTP,
+					    perfect_fltr);
+	case IPV6_USER_FLOW:
+		return ice_set_fdir_ip6_usr_seg(seg, &fsp->m_u.usr_ip6_spec,
+						perfect_fltr);
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * ice_fdir_has_input_set_conflict - Check conflict with existing FD filters
+ * @pf: PF structure
+ * @fsp: pointer to ethtool Rx flow specification
+ * @user: user-defined data parsed from flow specification
+ *
+ * Checks if adding this filter to Flow Director would cause an input set
+ * mismatch with existing filters for the same flow type by building
+ * the segment and comparing with existing profiles.
+ *
+ * Return: true if there's a conflict (use ACL), false otherwise (can use FD)
+ */
+static bool
+ice_fdir_has_input_set_conflict(struct ice_pf *pf,
+				struct ethtool_rx_flow_spec *fsp,
+				const struct ice_rx_flow_userdef *user)
+{
+	struct ice_flow_seg_info *test_seg, *old_seg;
+	bool perfect_fltr = false, conflict = false;
+	struct ice_fd_hw_prof *hw_prof;
+	struct ice_hw *hw = &pf->hw;
+	enum ice_fltr_ptype flow;
+	int err;
+
+	if ((fsp->flow_type & ~FLOW_EXT) == ETHER_FLOW)
+		return false;
+
+	flow = ice_ethtool_flow_to_fltr(fsp->flow_type & ~FLOW_EXT);
+	if (flow >= ICE_FLTR_PTYPE_MAX || !hw->fdir_prof ||
+	    !hw->fdir_prof[flow]) {
+		return false;
+	}
+
+	hw_prof = hw->fdir_prof[flow];
+	old_seg = hw_prof->fdir_seg[ICE_FD_HW_SEG_NON_TUN];
+
+	/* A profile with no ethtool FDir filters (fdir_fltr_cnt == 0) may
+	 * still be locked by aRFS perfect (4-tuple) filters, which keep their
+	 * own active counters separate from fdir_fltr_cnt.
+	 */
+	if (!old_seg || (hw->fdir_fltr_cnt[flow] == 0 &&
+			 !ice_is_arfs_using_perfect_flow(hw, flow)))
+		return false;
+
+	test_seg = kzalloc_obj(*test_seg);
+	if (!test_seg)
+		return false;
+
+	err = ice_set_fdir_ip_flow_seg(fsp, test_seg, &perfect_fltr);
+
+	if (err) {
+		kfree(test_seg);
+		return false;
+	}
+
+	if (user && user->flex_fltr)
+		ice_flow_add_fld_raw(test_seg, user->flex_offset,
+				     ICE_FLTR_PRGM_FLEX_WORD_SIZE,
+				     ICE_FLOW_FLD_OFF_INVAL,
+				     ICE_FLOW_FLD_OFF_INVAL);
+
+	/* Compare the test segment with the existing segment */
+	if (memcmp(old_seg, test_seg, sizeof(*test_seg)) != 0)
+		conflict = true;
+
+	kfree(test_seg);
+
+	return conflict;
+}
+
 /**
  * ice_cfg_fdir_xtrct_seq - Configure extraction sequence for the given filter
  * @pf: PF structure
@@ -1489,57 +1603,16 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
 		return -ENOMEM;
 	}
 
-	switch (fsp->flow_type & ~FLOW_EXT) {
-	case TCP_V4_FLOW:
-		ret = ice_set_fdir_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
-					   ICE_FLOW_SEG_HDR_TCP,
-					   &perfect_filter);
-		break;
-	case UDP_V4_FLOW:
-		ret = ice_set_fdir_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
-					   ICE_FLOW_SEG_HDR_UDP,
-					   &perfect_filter);
-		break;
-	case SCTP_V4_FLOW:
-		ret = ice_set_fdir_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
-					   ICE_FLOW_SEG_HDR_SCTP,
-					   &perfect_filter);
-		break;
-	case IPV4_USER_FLOW:
-		ret = ice_set_fdir_ip4_usr_seg(seg, &fsp->m_u.usr_ip4_spec,
-					       &perfect_filter);
-		break;
-	case TCP_V6_FLOW:
-		ret = ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
-					   ICE_FLOW_SEG_HDR_TCP,
-					   &perfect_filter);
-		break;
-	case UDP_V6_FLOW:
-		ret = ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
-					   ICE_FLOW_SEG_HDR_UDP,
-					   &perfect_filter);
-		break;
-	case SCTP_V6_FLOW:
-		ret = ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
-					   ICE_FLOW_SEG_HDR_SCTP,
-					   &perfect_filter);
-		break;
-	case IPV6_USER_FLOW:
-		ret = ice_set_fdir_ip6_usr_seg(seg, &fsp->m_u.usr_ip6_spec,
-					       &perfect_filter);
-		break;
-	case ETHER_FLOW:
+	if ((fsp->flow_type & ~FLOW_EXT) == ETHER_FLOW) {
 		ret = ice_set_ether_flow_seg(dev, seg, &fsp->m_u.ether_spec);
 		if (!ret && (fsp->m_ext.vlan_etype || fsp->m_ext.vlan_tci)) {
-			if (!ice_fdir_vlan_valid(dev, fsp)) {
+			if (!ice_fdir_vlan_valid(dev, fsp))
 				ret = -EINVAL;
-				break;
-			}
-			ret = ice_set_fdir_vlan_seg(seg, &fsp->m_ext);
+			else
+				ret = ice_set_fdir_vlan_seg(seg, &fsp->m_ext);
 		}
-		break;
-	default:
-		ret = -EINVAL;
+	} else {
+		ret = ice_set_fdir_ip_flow_seg(fsp, seg, &perfect_filter);
 	}
 	if (ret)
 		goto err_exit;
@@ -2343,9 +2416,27 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 		return -ENOSPC;
 	}
 
-	/* ACL filter */
-	if (pf->hw.acl_tbl && ice_is_acl_filter(fsp))
+	/* ACL filter, or this filter would cause an input set conflict with
+	 * existing FD filters
+	 */
+	if (pf->hw.acl_tbl &&
+	    (ice_is_acl_filter(fsp) ||
+	     ice_fdir_has_input_set_conflict(pf, fsp, &userdata))) {
+		/* The ACL programming path does not honor flex byte
+		 * (user-def) constraints. Routing a flex filter to ACL would
+		 * silently drop the flex match and offload a much broader
+		 * rule than requested, so reject it explicitly instead.
+		 */
+		if (userdata.flex_fltr) {
+			dev_info(dev, "Failed to add filter. Flex byte (user-def) filters cannot be offloaded to ACL.\n");
+			return -EOPNOTSUPP;
+		}
+
+		dev_dbg(dev, "ntuple filter at location %d offloaded to ACL instead of Flow Director\n",
+			fsp->location);
+
 		return ice_acl_add_rule_ethtool(vsi, cmd);
+	}
 
 	/* Only fdir filters below */
 	if (!test_bit(ICE_FLAG_FD_ENA, pf->flags))
-- 
2.49.0


