Return-Path: <netdev+bounces-108865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7471F92618E
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F391C22D13
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D6B17C204;
	Wed,  3 Jul 2024 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aKFkT4ID"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261C117B43F;
	Wed,  3 Jul 2024 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012366; cv=none; b=u3tle08b0jErHIC9/dE4dUA2/vzkZ+Xd95RgBDFVMKllaCNyqqyhyMclzOvlXF8DIwuz9sPXS6cf4TL3ssijv1c3n0UEL2xkUQDfnu0den+fIkvxKTxUIYjrre7Uzzh9UmDalCgHr3M/gIY/JdEKRYE+m9IlhtCygY5TKbKDAro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012366; c=relaxed/simple;
	bh=77S0g48ldeSDpH72ehXpHc4TRRYY3yYTmc4CKjzLGmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o/Q3dSz5htSK0gA3IMrZ+gSX7zpNQgnXDtWoE+grcG/OqtS8Uy0wPNqriDB9+KuXUm5vUUTRplrx1u49Kg/t06PZLfs9wD8qoFMQmXlh5g2wh41el60HYoIKsGmoSrrfNGyT8Fmi0R4ggj/D1GiCk7INFx5zqjtJHDm92KRyr68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aKFkT4ID; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720012365; x=1751548365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=77S0g48ldeSDpH72ehXpHc4TRRYY3yYTmc4CKjzLGmU=;
  b=aKFkT4IDmkovGOnIPT0d8L6LLltdGYdTyLo62HY5VpC+X8gJpfQrFHla
   NiGR8TVHiQ12Z5YdnPS2NTY5lTXU7MisUOwlyADutA8JRKJoeK96o+Khe
   lsnji+GC2a8udhfncBb7CNPNkIc5qAAznt0KgIFODnCEQ68F+KRd59omK
   8WaMvZb6TBoSPKuiy1v4l4YOLVnFHjvyREL7dJ1lTkF58wIZL3k7AE8Fm
   nsJCFlo8WcQz5lHp7sRH7kLTQhW9Ql9/b93rQBefDUY4bcia+FLZd3E/I
   f7lfaJJaEV3RFLWcuYOUDrGb6eq5LwhuRbl6dMamJajXNRPA17KzcOJcO
   A==;
X-CSE-ConnectionGUID: tF00cJH+S/WjtSiuHXSJLw==
X-CSE-MsgGUID: +wxgQMIBTE+4jNYVHe6tdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27857155"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="27857155"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 06:12:38 -0700
X-CSE-ConnectionGUID: DrTqlxLwTLmwOVCNYOkuNg==
X-CSE-MsgGUID: Ivv7E3kfSDONtAeCIQtGqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46321600"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa010.fm.intel.com with ESMTP; 03 Jul 2024 06:12:34 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0985328779;
	Wed,  3 Jul 2024 14:12:32 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org,
	willemb@google.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Ben Shelton <benjamin.h.shelton@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Igor Bagnucki <igor.bagnucki@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v1 5/6] ice: Add MDD logging via devlink health
Date: Wed,  3 Jul 2024 08:59:21 -0400
Message-Id: <20240703125922.5625-6-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240703125922.5625-1-mateusz.polchlopek@intel.com>
References: <20240703125922.5625-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Shelton <benjamin.h.shelton@intel.com>

Add a devlink health reporter for MDD events. The 'dump' handler will
return the information captured in each call to ice_handle_mdd_event().
A device reset (CORER/PFR) will put the reporter back in healthy state.

Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 .../intel/ice/devlink/devlink_health.c        | 77 +++++++++++++++++++
 .../intel/ice/devlink/devlink_health.h        | 11 +++
 drivers/net/ethernet/intel/ice/ice_main.c     |  6 ++
 3 files changed, 94 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_health.c b/drivers/net/ethernet/intel/ice/devlink/devlink_health.c
index d6956bba1da2..d19fd3ebe76f 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_health.c
@@ -33,6 +33,79 @@ static void ice_devlink_health_report(struct devlink_health_reporter *reporter,
 	}
 }
 
+struct ice_mdd_event {
+	enum ice_mdd_src src;
+	u16 vf_num;
+	u16 queue;
+	u8 pf_num;
+	u8 event;
+};
+
+static const char *ice_mdd_src_to_str(enum ice_mdd_src src)
+{
+	switch (src) {
+	case ICE_MDD_SRC_TX_PQM:
+		return "tx_pqm";
+	case ICE_MDD_SRC_TX_TCLAN:
+		return "tx_tclan";
+	case ICE_MDD_SRC_TX_TDPU:
+		return "tx_tdpu";
+	case ICE_MDD_SRC_RX:
+		return "rx";
+	default:
+		return "invalid";
+	}
+}
+
+static int
+ice_mdd_reporter_dump(struct devlink_health_reporter *reporter,
+		      struct devlink_fmsg *fmsg, void *priv_ctx,
+		      struct netlink_ext_ack *extack)
+{
+	struct ice_mdd_event *mdd_event = priv_ctx;
+	const char *src;
+
+	if (!mdd_event)
+		return 0;
+
+	src = ice_mdd_src_to_str(mdd_event->src);
+
+	devlink_fmsg_obj_nest_start(fmsg);
+	devlink_fmsg_put(fmsg, "src", src);
+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, mdd_event, pf_num);
+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, mdd_event, vf_num);
+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, mdd_event, event);
+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, mdd_event, queue);
+	devlink_fmsg_obj_nest_end(fmsg);
+
+	return 0;
+}
+
+/**
+ * ice_devlink_report_mdd_event - Report an MDD event through devlink health
+ * @pf: the PF device structure
+ * @src: the HW block that was the source of this MDD event
+ * @pf_num: the pf_num on which the MDD event occurred
+ * @vf_num: the vf_num on which the MDD event occurred
+ * @event: the event type of the MDD event
+ * @queue: the queue on which the MDD event occurred
+ *
+ * Report an MDD event that has occurred on this PF.
+ */
+void ice_devlink_report_mdd_event(struct ice_pf *pf, enum ice_mdd_src src,
+				  u8 pf_num, u16 vf_num, u8 event, u16 queue)
+{
+	struct ice_mdd_event ev = {
+		.src = src,
+		.pf_num = pf_num,
+		.vf_num = vf_num,
+		.event = event,
+		.queue = queue,
+	};
+
+	ice_devlink_health_report(pf->health_reporters.mdd, "MDD event", &ev);
+}
+
 static void ice_dump_ethtool_stats_to_fmsg(struct devlink_fmsg *fmsg,
 					   struct net_device *netdev)
 {
@@ -155,6 +228,7 @@ ice_init_devlink_rep(struct ice_pf *pf,
 	.dump = ice_ ## _name ## _reporter_dump, \
 }
 
+ICE_DEFINE_HEALTH_REPORTER_OPS(mdd);
 ICE_DEFINE_HEALTH_REPORTER_OPS(tx_hang);
 
 /**
@@ -167,6 +241,7 @@ void ice_health_init(struct ice_pf *pf)
 {
 	struct ice_health *reps = &pf->health_reporters;
 
+	reps->mdd = ice_init_devlink_rep(pf, &ice_mdd_reporter_ops);
 	reps->tx_hang = ice_init_devlink_rep(pf, &ice_tx_hang_reporter_ops);
 }
 
@@ -188,6 +263,7 @@ static void ice_deinit_devl_reporter(struct devlink_health_reporter *reporter)
  */
 void ice_health_deinit(struct ice_pf *pf)
 {
+	ice_deinit_devl_reporter(pf->health_reporters.mdd);
 	ice_deinit_devl_reporter(pf->health_reporters.tx_hang);
 }
 
@@ -207,5 +283,6 @@ void ice_health_assign_healthy_state(struct devlink_health_reporter *reporter)
  */
 void ice_health_clear(struct ice_pf *pf)
 {
+	ice_health_assign_healthy_state(pf->health_reporters.mdd);
 	ice_health_assign_healthy_state(pf->health_reporters.tx_hang);
 }
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_health.h b/drivers/net/ethernet/intel/ice/devlink/devlink_health.h
index 984b8f9f56d4..01abd3d8f31e 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_health.h
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_health.h
@@ -16,18 +16,29 @@
 struct ice_pf;
 struct ice_tx_ring;
 
+enum ice_mdd_src {
+	ICE_MDD_SRC_TX_PQM,
+	ICE_MDD_SRC_TX_TCLAN,
+	ICE_MDD_SRC_TX_TDPU,
+	ICE_MDD_SRC_RX,
+};
+
 /**
  * struct ice_health - stores ice devlink health reporters and accompanied data
  * @tx_hang: devlink health reporter for tx_hang event
+ * @mdd: devlink health reporter for MDD detection event
  */
 struct ice_health {
 	struct devlink_health_reporter *tx_hang;
+	struct devlink_health_reporter *mdd;
 };
 
 void ice_health_init(struct ice_pf *pf);
 void ice_health_deinit(struct ice_pf *pf);
 void ice_health_clear(struct ice_pf *pf);
 
+void ice_devlink_report_mdd_event(struct ice_pf *pf, enum ice_mdd_src src,
+				  u8 pf_num, u16 vf_num, u8 event, u16 queue);
 void ice_report_tx_hang(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
 			u16 vsi_num, u32 head, u32 intr);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 246dcfe54397..904a4d2f9a59 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1820,6 +1820,8 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 		if (netif_msg_tx_err(pf))
 			dev_info(dev, "Malicious Driver Detection event %d on TX queue %d PF# %d VF# %d\n",
 				 event, queue, pf_num, vf_num);
+		ice_devlink_report_mdd_event(pf, ICE_MDD_SRC_TX_PQM, pf_num,
+					     vf_num, event, queue);
 		wr32(hw, GL_MDET_TX_PQM, 0xffffffff);
 	}
 
@@ -1833,6 +1835,8 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 		if (netif_msg_tx_err(pf))
 			dev_info(dev, "Malicious Driver Detection event %d on TX queue %d PF# %d VF# %d\n",
 				 event, queue, pf_num, vf_num);
+		ice_devlink_report_mdd_event(pf, ICE_MDD_SRC_TX_TCLAN, pf_num,
+					     vf_num, event, queue);
 		wr32(hw, GL_MDET_TX_TCLAN_BY_MAC(hw), U32_MAX);
 	}
 
@@ -1846,6 +1850,8 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 		if (netif_msg_rx_err(pf))
 			dev_info(dev, "Malicious Driver Detection event %d on RX queue %d PF# %d VF# %d\n",
 				 event, queue, pf_num, vf_num);
+		ice_devlink_report_mdd_event(pf, ICE_MDD_SRC_RX, pf_num,
+					     vf_num, event, queue);
 		wr32(hw, GL_MDET_RX, 0xffffffff);
 	}
 
-- 
2.38.1


