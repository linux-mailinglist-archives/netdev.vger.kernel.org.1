Return-Path: <netdev+bounces-268913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BUTAcNdumnFUgIAu9opvQ
	(envelope-from <netdev+bounces-268913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:09:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D63052B7903
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C61B7302650D
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761D13783C7;
	Wed, 18 Mar 2026 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="asCFNjjn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E18377022
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821263; cv=none; b=WE3GpbVT3Zm81PZT3EsHCyUTTHRcI3H0sL53EN5ARaYVlj/6gSPe09mG7KPx33xtbZ0ren/YBUKUFadA/fqfLvtSI98XRzO3F8b2gUBA+/P41y9bF3unVeIjYXoF5Z4qIAO/bZ2jbNQwJTEKzrlQ7QTy46IalAvSSW+AE+JgLPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821263; c=relaxed/simple;
	bh=eeZWTl75BvHWnhfVyBuJjwwR4iwIkFpT5X5IlIOY/jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F36k6ImD+7jz85lth27FF6v4PRDJsBeq9GXUHA2n17KpMEmqIS7Ar1Rs2MkW44Av/YYxdm0A0dIveYrBpx2oFOgvzIwTxUyvwkxI2oJBRwR2I3Ewwo9UXvK1rIwFziCS8ZgMuy2/+Ecx/b+4OotJjHzYBy+3nWz4hx3XSnBClWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=asCFNjjn; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773821262; x=1805357262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eeZWTl75BvHWnhfVyBuJjwwR4iwIkFpT5X5IlIOY/jM=;
  b=asCFNjjn8LZDdKqKeXIP76SQb+T0fd15zyIwLV+VUrq+fPwKQQ6FBSO+
   cHppQG3p3rfHgCvh29gVmYexzXtwqFQbg2ZREYXQaleQBtj2G7nPzReKY
   Qi9e2MP4Dtr/doPT2Nf9sDMZQ/PuZP2RQRVOedS4GH/zt9E0ijJv2Gy4d
   2cGT7yqtEFY6a4RKXfkNqTklD1jvhal+jsoPnM8pHlQJN/fHbXTcFFYI6
   46YO3pm1dL0UPIz1c8sqQqhxHdoPA9gEBfoIq94m1DZ1A+E2BbJemitAl
   PXt1S4Ro7OVoEyCCGyNRNriy9Ru0aTOUw08YdpBwjtOveRd4BlsCcrq59
   Q==;
X-CSE-ConnectionGUID: rscRRlxTRIOE8MAxx1r8bw==
X-CSE-MsgGUID: 3lHReDKIR3Woxh0FgrAaTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74755246"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74755246"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:07:42 -0700
X-CSE-ConnectionGUID: bUW14SIoRxmGzN/ouR8bHA==
X-CSE-MsgGUID: VfEwE6ANTIO4KeolD91YDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="221628552"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa006.jf.intel.com with ESMTP; 18 Mar 2026 01:07:40 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next v1 2/2] ice: add 0x88E7 handling to SW validation paths
Date: Wed, 18 Mar 2026 09:07:36 +0100
Message-ID: <20260318080737.3012293-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318080737.3012293-1-aleksandr.loktionov@intel.com>
References: <20260318080737.3012293-1-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268913-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: D63052B7903
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The virtchnl v2 VLAN capability handshake now includes the new
VIRTCHNL_VLAN_ETHERTYPE_88E7 flag for IEEE 802.1ah B-TAG support.
Wire up the corresponding software-path handling in ice so the PF
correctly accepts and translates 0x88E7 (ETH_P_8021AH) VLAN filters
requested by VFs.

Three software-only changes, no hardware offload path affected:

 - ice_check_supported_vlan_tpid() (ice_tc_lib.c): accept ETH_P_8021AH
   in the TC VLAN TPID validation switch so 0x88E7-tagged flower filters
   are not rejected early.

 - validate_vlan() (ice_vsi_vlan_lib.c): allow ETH_P_8021AH as a valid
   TPID when adding VLAN filters to a VSI, consistent with the other
   accepted dot1q/dot1ad/QinQ1 TPIDs.

 - ice_vc_validate_vlan_tpid() / ice_vc_get_tpid() (virt/virtchnl.c):
   bidirectional translation between ETH_P_8021AH and
   VIRTCHNL_VLAN_ETHERTYPE_88E7 in the virtchnl VLAN v2 filter path.

This does not add 0x88E7 hardware offload capability, does not change
outer-tag programming, and does not alter any datapath.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c       | 1 +
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c | 3 ++-
 drivers/net/ethernet/intel/ice/virt/virtchnl.c    | 6 ++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index d20357c..4560e55 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -174,6 +174,7 @@ static u16 ice_check_supported_vlan_tpid(u16 vlan_tpid)
 	case ETH_P_8021Q:
 	case ETH_P_8021AD:
 	case ETH_P_QINQ1:
+	case ETH_P_8021AH:
 		return vlan_tpid;
 	default:
 		return 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
index 5498496..b67272e 100644
--- a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
@@ -24,7 +24,8 @@ static void print_invalid_tpid(struct ice_vsi *vsi, u16 tpid)
 static bool validate_vlan(struct ice_vsi *vsi, struct ice_vlan *vlan)
 {
 	if (vlan->tpid != ETH_P_8021Q && vlan->tpid != ETH_P_8021AD &&
-	    vlan->tpid != ETH_P_QINQ1 && (vlan->tpid || vlan->vid)) {
+	    vlan->tpid != ETH_P_QINQ1 && vlan->tpid != ETH_P_8021AH &&
+	    (vlan->tpid || vlan->vid)) {
 		print_invalid_tpid(vsi, vlan->tpid);
 		return false;
 	}
diff --git a/drivers/net/ethernet/intel/ice/virt/virtchnl.c b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
index ca8018e..06d2f9b 100644
--- a/drivers/net/ethernet/intel/ice/virt/virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
@@ -1702,6 +1702,9 @@ static bool ice_vc_validate_vlan_tpid(u16 filtering_caps, u16 tpid)
 	case ETH_P_QINQ1:
 		vlan_ethertype = VIRTCHNL_VLAN_ETHERTYPE_9100;
 		break;
+	case ETH_P_8021AH:
+		vlan_ethertype = VIRTCHNL_VLAN_ETHERTYPE_88E7;
+		break;
 	}
 
 	if (!(filtering_caps & vlan_ethertype))
@@ -2136,6 +2139,9 @@ static int ice_vc_get_tpid(u32 ethertype_setting, u16 *tpid)
 	case VIRTCHNL_VLAN_ETHERTYPE_9100:
 		*tpid = ETH_P_QINQ1;
 		break;
+	case VIRTCHNL_VLAN_ETHERTYPE_88E7:
+		*tpid = ETH_P_8021AH;
+		break;
 	default:
 		*tpid = 0;
 		return -EINVAL;
-- 
2.52.0


