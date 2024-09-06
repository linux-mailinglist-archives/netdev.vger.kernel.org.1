Return-Path: <netdev+bounces-125932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A6196F4D7
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9998AB20BA1
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218C31C9EBB;
	Fri,  6 Sep 2024 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HiqQyfzA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606521552FA
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627432; cv=none; b=JxLg23dp7OYrUHDVlksOI97P+nJ31q5D8ZVKbLBhbWpPhxhMEB9xgoX07pFGvA95hiTCouSodMDOpFnHmJBRSUNN4anrDAZcog4s0P+gMhLwMn52E4QpXdZmRTN20CvCE7TDcUJizuPzPeb3k5Dmkv7o0gUEB72iyDLEAiK68IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627432; c=relaxed/simple;
	bh=PgpUqTDJtGZIRloqGiVVcn/EalmCmqNfTkJNG23ep/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DE/ygGXKSiLaFgvzgOp3SNOGYsns83XNh0T7myxLB1KvKS8sO+6uqZYnUtwRwMp1uLoGlCHNRwius40er8QEViTTR4jL4OqSQ3J/BIgvWT2cmirXZnDwTKPzWLh5k6VeaYO0dZ3GtpTXJ2QiHUWBoYjfG24frYnEX7XtLstXk1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HiqQyfzA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725627431; x=1757163431;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PgpUqTDJtGZIRloqGiVVcn/EalmCmqNfTkJNG23ep/w=;
  b=HiqQyfzAZmMhMLabNoVukyQjuz7WrUgr1Hbsk42FtBIigtQqeRNRHTPp
   T2RC1w8enTRp8Xrt+jg+vUjCjfci6R9p8vGumuKTAEU8tklbEd/Z0AZAz
   Ur6Xwt8O3Dq85Rwd9NwmNGKjHPJ/H3EPLNfgxzdi3hSv3mMTHfIfcp0Gu
   sZTMNZlO1Tex7pHIY1d48KRlbtk8P2tJ5D35YwOOHmNrwvNFK1jf/jxLE
   WZMSpavvTH4F3DlXBMeq2RVLUsfZVhxc4CHE3YjCqCO3VXGnfZ1qPGbn7
   ZYjIEtskXWLSx7pj8NFPKFqUquj7DQPIUEGTcx+TmVGlJll4lLANVxWjx
   A==;
X-CSE-ConnectionGUID: bpeMT2TuQd295T6FHkIEGQ==
X-CSE-MsgGUID: tiz6CaZpTru9limqauq5Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="24546123"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="24546123"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 05:57:09 -0700
X-CSE-ConnectionGUID: ZlYcbZKVTvCmau3AgYWjmA==
X-CSE-MsgGUID: +dX9tKI4SjyxpMYZzzYqDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="96731526"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa001.fm.intel.com with ESMTP; 06 Sep 2024 05:57:07 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	wojciech.drewek@intel.com,
	mschmidt@redhat.com
Subject: [iwl-net v1] ice: clear port vlan config during reset
Date: Fri,  6 Sep 2024 14:57:06 +0200
Message-ID: <20240906125706.46965-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with
ice_vf_reconfig_vsi()") VF VSI is only reconfigured instead of
recreated. The context configuration from previous setting is still the
same. If any of the config needs to be cleared it needs to be cleared
explicitly.

Previously there was assumption that port vlan will be cleared
automatically. Now, when VSI is only reconfigured we have to do it in the
code.

Not clearing port vlan configuration leads to situation when the driver
VSI config is different than the VSI config in HW. Traffic can't be
passed after setting and clearing port vlan, because of invalid VSI
config in HW.

Example reproduction:
> ip a a dev $(VF) $(VF_IP_ADDRESS)
> ip l s dev $(VF) up
> ping $(VF_IP_ADDRESS)
ping is working fine here
> ip link set eth5 vf 0 vlan 100
> ip link set eth5 vf 0 vlan 0
> ping $(VF_IP_ADDRESS)
ping isn't working

Fixes: 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()")
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  7 +++
 .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c | 57 +++++++++++++++++++
 .../net/ethernet/intel/ice/ice_vsi_vlan_lib.h |  1 +
 3 files changed, 65 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 5635e9da2212..9fe2a309c5ff 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -335,6 +335,13 @@ static int ice_vf_rebuild_host_vlan_cfg(struct ice_vf *vf, struct ice_vsi *vsi)
 
 		err = vlan_ops->add_vlan(vsi, &vf->port_vlan_info);
 	} else {
+		/* clear possible previous port vlan config */
+		err = ice_vsi_clear_port_vlan(vsi);
+		if (err) {
+			dev_err(dev, "failed to clear port VLAN via VSI parameters for VF %u, error %d\n",
+				vf->vf_id, err);
+			return err;
+		}
 		err = ice_vsi_add_vlan_zero(vsi);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
index 6e8f2aab6080..5291f2888ef8 100644
--- a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
@@ -787,3 +787,60 @@ int ice_vsi_clear_outer_port_vlan(struct ice_vsi *vsi)
 	kfree(ctxt);
 	return err;
 }
+
+int ice_vsi_clear_port_vlan(struct ice_vsi *vsi)
+{
+	struct ice_hw *hw = &vsi->back->hw;
+	struct ice_vsi_ctx *ctxt;
+	int err;
+
+	ctxt = kzalloc(sizeof(*ctxt), GFP_KERNEL);
+	if (!ctxt)
+		return -ENOMEM;
+
+	ctxt->info = vsi->info;
+
+	ctxt->info.port_based_outer_vlan = 0;
+	ctxt->info.port_based_inner_vlan = 0;
+
+	ctxt->info.inner_vlan_flags =
+		FIELD_PREP(ICE_AQ_VSI_INNER_VLAN_TX_MODE_M,
+			   ICE_AQ_VSI_INNER_VLAN_TX_MODE_ALL);
+	if (ice_is_dvm_ena(hw)) {
+		ctxt->info.inner_vlan_flags |=
+			FIELD_PREP(ICE_AQ_VSI_INNER_VLAN_EMODE_M,
+				   ICE_AQ_VSI_INNER_VLAN_EMODE_NOTHING);
+		ctxt->info.outer_vlan_flags =
+			FIELD_PREP(ICE_AQ_VSI_OUTER_VLAN_TX_MODE_M,
+				   ICE_AQ_VSI_OUTER_VLAN_TX_MODE_ALL);
+		ctxt->info.outer_vlan_flags |=
+			FIELD_PREP(ICE_AQ_VSI_OUTER_TAG_TYPE_M,
+				   ICE_AQ_VSI_OUTER_TAG_VLAN_8100);
+		ctxt->info.outer_vlan_flags |=
+			ICE_AQ_VSI_OUTER_VLAN_EMODE_NOTHING <<
+			ICE_AQ_VSI_OUTER_VLAN_EMODE_S;
+	}
+
+	ctxt->info.sw_flags2 &= ~ICE_AQ_VSI_SW_FLAG_RX_VLAN_PRUNE_ENA;
+	ctxt->info.valid_sections =
+		cpu_to_le16(ICE_AQ_VSI_PROP_OUTER_TAG_VALID |
+			    ICE_AQ_VSI_PROP_VLAN_VALID |
+			    ICE_AQ_VSI_PROP_SW_VALID);
+
+	err = ice_update_vsi(hw, vsi->idx, ctxt, NULL);
+	if (err) {
+		dev_err(ice_pf_to_dev(vsi->back), "update VSI for clearing port based VLAN failed, err %d aq_err %s\n",
+			err, ice_aq_str(hw->adminq.sq_last_status));
+	} else {
+		vsi->info.port_based_outer_vlan =
+			ctxt->info.port_based_outer_vlan;
+		vsi->info.port_based_inner_vlan =
+			ctxt->info.port_based_inner_vlan;
+		vsi->info.outer_vlan_flags = ctxt->info.outer_vlan_flags;
+		vsi->info.inner_vlan_flags = ctxt->info.inner_vlan_flags;
+		vsi->info.sw_flags2 = ctxt->info.sw_flags2;
+	}
+
+	kfree(ctxt);
+	return err;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.h b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.h
index f0d84d11bd5b..12b227621a7d 100644
--- a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.h
@@ -36,5 +36,6 @@ int ice_vsi_ena_outer_insertion(struct ice_vsi *vsi, u16 tpid);
 int ice_vsi_dis_outer_insertion(struct ice_vsi *vsi);
 int ice_vsi_set_outer_port_vlan(struct ice_vsi *vsi, struct ice_vlan *vlan);
 int ice_vsi_clear_outer_port_vlan(struct ice_vsi *vsi);
+int ice_vsi_clear_port_vlan(struct ice_vsi *vsi);
 
 #endif /* _ICE_VSI_VLAN_LIB_H_ */
-- 
2.42.0


