Return-Path: <netdev+bounces-130393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555C098A58C
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11AAC28137D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D5B1925A4;
	Mon, 30 Sep 2024 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kU0E2zfS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAA519259B;
	Mon, 30 Sep 2024 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703589; cv=none; b=nQ5g2v/ozpT1DmMirYhcBAMse+rsA1MVeNtLohAn9qzdGZneZ0cZo6JzRUwt9o4z0D99ug0aE/Tr8i+6KwjF7xYeO5RUUUiiia8Si41TbSA5KKOTTTuR46A8IVO+M3k3rA1dJanBvuTetF2rPDp0V0sZn2CZpMkjReKLlnG9z8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703589; c=relaxed/simple;
	bh=Bn+ZWwTkouoXDVKET85eSpE0DSK3dWYr18A3xShvEbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ytadj604PKkUr3YkpwfLuDEB+OEz4vjMd7hLivw6dpHmAdu185dl6zVHEli4DPohkZNkg8lzEPCkrnAZKgmimtnSQ3Xne5P8zpaXtRDlRprpqJ85qV67b3Jpn14PC9ii/g3mWfMW3zRf+C9QHVoOgzG9JY8ECWLRJe6l6cquLrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kU0E2zfS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727703588; x=1759239588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bn+ZWwTkouoXDVKET85eSpE0DSK3dWYr18A3xShvEbk=;
  b=kU0E2zfSWeoK26JsSzSBh3Zhdx4/Cj+hTnQnDb9DCkrZgcqAowhjzBz5
   li1uAw8yfo+LVtj/D0Pg88ON0krM5CCONMZNJJfi4vw5CZDGQ4G/WzGDO
   KXS/0BSVwW+EHvMUQUtAL3snMY0OnFfsiajLRfSJul8hG6OCa8SMY5o74
   4qUPSWi4ueAkoBvxAD4FtFE7VKRHkdBLMK2RRZgM4Q/T6tFqvxSofs+e5
   89Ry2OnAcnhPTLqHJ0lckhhjj+rXkuBM92vxxf6CgtxtiM4qFWGyzfrt0
   R2kAmGEeRol1FNUYnOesdkGtlHsybU4FHrzsGYoW5fiCVaCHKohDpsFoS
   Q==;
X-CSE-ConnectionGUID: unrCGML/RuiwqHM3hMEB/w==
X-CSE-MsgGUID: ETBgsu6nRfeZQvJRgMIPBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26601101"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26601101"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:39:47 -0700
X-CSE-ConnectionGUID: zM2hGgn7TmeP7C7wFmumqA==
X-CSE-MsgGUID: XmAbj/nzRHqTI0TQitN/aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="72895452"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa006.fm.intel.com with ESMTP; 30 Sep 2024 06:39:43 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4A5F928195;
	Mon, 30 Sep 2024 14:39:41 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ben Shelton <benjamin.h.shelton@intel.com>,
	Igor Bagnucki <igor.bagnucki@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH 7/7] ice: Add MDD logging via devlink health
Date: Mon, 30 Sep 2024 15:37:25 +0200
Message-Id: <20240930133724.610512-8-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240930133724.610512-1-przemyslaw.kitszel@intel.com>
References: <20240930133724.610512-1-przemyslaw.kitszel@intel.com>
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
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 .../net/ethernet/intel/ice/devlink/health.h   | 11 +++
 .../net/ethernet/intel/ice/devlink/health.c   | 77 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c     |  6 ++
 3 files changed, 94 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/devlink/health.h b/drivers/net/ethernet/intel/ice/devlink/health.h
index 92e40d790e72..a08c7bd174cf 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.h
+++ b/drivers/net/ethernet/intel/ice/devlink/health.h
@@ -16,17 +16,26 @@
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
  * @tx_hang_buf: pre-allocated place to put info for Tx hang reporter from
  *               non-sleeping context
  * @tx_ring: ring that the hang occured on
  * @head: descriptior head
  * @intr: interrupt register value
  * @vsi_num: VSI owning the queue that the hang occured on
  */
 struct ice_health {
+	struct devlink_health_reporter *mdd;
 	struct devlink_health_reporter *tx_hang;
 	struct_group_tagged(ice_health_tx_hang_buf, tx_hang_buf,
 		struct ice_tx_ring *tx_ring;
@@ -43,6 +52,8 @@ void ice_health_clear(struct ice_pf *pf);
 
 void ice_prep_tx_hang_report(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
 			     u16 vsi_num, u32 head, u32 intr);
+void ice_report_mdd_event(struct ice_pf *pf, enum ice_mdd_src src, u8 pf_num,
+			  u16 vf_num, u8 event, u16 queue);
 void ice_report_tx_hang(struct ice_pf *pf);
 
 #endif /* _HEALTH_H_ */
diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
index 1626c5171152..c7a8b8c9e1ca 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
@@ -27,6 +27,79 @@ static void ice_devlink_health_report(struct devlink_health_reporter *reporter,
 	devlink_health_report(reporter, msg, priv_ctx);
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
+ * ice_report_mdd_event - Report an MDD event through devlink health
+ * @pf: the PF device structure
+ * @src: the HW block that was the source of this MDD event
+ * @pf_num: the pf_num on which the MDD event occurred
+ * @vf_num: the vf_num on which the MDD event occurred
+ * @event: the event type of the MDD event
+ * @queue: the queue on which the MDD event occurred
+ *
+ * Report an MDD event that has occurred on this PF.
+ */
+void ice_report_mdd_event(struct ice_pf *pf, enum ice_mdd_src src, u8 pf_num,
+			  u16 vf_num, u8 event, u16 queue)
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
@@ -169,6 +242,7 @@ ice_init_devlink_rep(struct ice_pf *pf,
 	.dump = ice_ ## _name ## _reporter_dump, \
 }
 
+ICE_DEFINE_HEALTH_REPORTER_OPS(mdd);
 ICE_DEFINE_HEALTH_REPORTER_OPS(tx_hang);
 
 /**
@@ -181,6 +255,7 @@ void ice_health_init(struct ice_pf *pf)
 {
 	struct ice_health *reps = &pf->health_reporters;
 
+	reps->mdd = ice_init_devlink_rep(pf, &ice_mdd_reporter_ops);
 	reps->tx_hang = ice_init_devlink_rep(pf, &ice_tx_hang_reporter_ops);
 }
 
@@ -202,6 +277,7 @@ static void ice_deinit_devl_reporter(struct devlink_health_reporter *reporter)
  */
 void ice_health_deinit(struct ice_pf *pf)
 {
+	ice_deinit_devl_reporter(pf->health_reporters.mdd);
 	ice_deinit_devl_reporter(pf->health_reporters.tx_hang);
 }
 
@@ -221,5 +297,6 @@ void ice_health_assign_healthy_state(struct devlink_health_reporter *reporter)
  */
 void ice_health_clear(struct ice_pf *pf)
 {
+	ice_health_assign_healthy_state(pf->health_reporters.mdd);
 	ice_health_assign_healthy_state(pf->health_reporters.tx_hang);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 899bd7f8abec..5a63f0ccc27a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1816,6 +1816,8 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 		if (netif_msg_tx_err(pf))
 			dev_info(dev, "Malicious Driver Detection event %d on TX queue %d PF# %d VF# %d\n",
 				 event, queue, pf_num, vf_num);
+		ice_report_mdd_event(pf, ICE_MDD_SRC_TX_PQM, pf_num, vf_num,
+				     event, queue);
 		wr32(hw, GL_MDET_TX_PQM, 0xffffffff);
 	}
 
@@ -1829,6 +1831,8 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 		if (netif_msg_tx_err(pf))
 			dev_info(dev, "Malicious Driver Detection event %d on TX queue %d PF# %d VF# %d\n",
 				 event, queue, pf_num, vf_num);
+		ice_report_mdd_event(pf, ICE_MDD_SRC_TX_TCLAN, pf_num, vf_num,
+				     event, queue);
 		wr32(hw, GL_MDET_TX_TCLAN_BY_MAC(hw), U32_MAX);
 	}
 
@@ -1842,6 +1846,8 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 		if (netif_msg_rx_err(pf))
 			dev_info(dev, "Malicious Driver Detection event %d on RX queue %d PF# %d VF# %d\n",
 				 event, queue, pf_num, vf_num);
+		ice_report_mdd_event(pf, ICE_MDD_SRC_RX, pf_num, vf_num, event,
+				     queue);
 		wr32(hw, GL_MDET_RX, 0xffffffff);
 	}
 
-- 
2.39.3


