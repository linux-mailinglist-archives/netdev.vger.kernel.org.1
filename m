Return-Path: <netdev+bounces-238165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE77C54EA3
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 01:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6ACC04E17C3
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 00:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5391946C8;
	Thu, 13 Nov 2025 00:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N87cPYaJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EA9156678
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 00:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762993864; cv=none; b=KJNZM72Yp37lPTF94BN6S1mplHdB0Jid4U4a2Km2Sfh+08D0vHIoNodwT5jZdl4sQWFh2Ly+M4m3f564BBYsXWdMFMEHbDZIQcoKA2NedztCXQfKKm1qG1DjrSPB6tgVYrYbnqt1FD3NYNh5GCbhekJ1724zZGbW+fCoeyARkwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762993864; c=relaxed/simple;
	bh=Kbcd1olDLTbNyz5MlvSyuJZcGM4GuRep8YUj1HKvnd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V9bpdL/xK19lFRV2DGjICrZ3uJ0sLk2yIj4A5gNZZgS5WdAcW62gWFM44ULHGy9w5T2Q8AaVJWDnolnr6SNPVLZiOPu1zaB1EF8s3pEDzEEp3u01Uo6gUBfRMMmDg0/ooE2wY3YRmWzAizA3UGa9s8Quf/jWud2Z6m5FEFpX2r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N87cPYaJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762993862; x=1794529862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kbcd1olDLTbNyz5MlvSyuJZcGM4GuRep8YUj1HKvnd8=;
  b=N87cPYaJcqpYhXWSofGhmuBf4zaOC/1lv4vJ+nUmZeTJ5bmjQQQMQXcR
   YERDklO1QuUoa5oIuYiGYGAVc3r4pl4s/a+gC6ScSmekvzvXgvtcuDecm
   MzsuGqDGW2y1JQ3n0KT8aE8KPzCmPcyCRagwvUTA6H26yo9gJa1h67dmd
   vI7W8Q+m/nsKsRYj00+BeC/xnX9mrZ6rYQcoVcFRA0MGXwRap59r/9k41
   yYN+VVjKwYH7l3qatGYTQ5r2xsGkhbvN3583kSIbbFLFvrs1Yw076Pd49
   soQQDMNKqgS04Ve3G5hiZ5tu5SDswrPuPR996CdUk2a4Nv2ZveLdubZo/
   w==;
X-CSE-ConnectionGUID: EyFlPHAbSTWGB9PN+4uJ4Q==
X-CSE-MsgGUID: oIlvh8kORC+kCgVvODSJbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82465659"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="82465659"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 16:30:57 -0800
X-CSE-ConnectionGUID: 4oJNCHVZQhKR3SgQl1CWLw==
X-CSE-MsgGUID: iwNM2FCrROOYD7jVMS8gUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="190099556"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
  by fmviesa010.fm.intel.com with ESMTP; 12 Nov 2025 16:30:57 -0800
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [Intel-wired-lan][PATCH iwl-next v10 05/10] idpf: reshuffle idpf_vport struct members to avoid holes
Date: Wed, 12 Nov 2025 16:41:38 -0800
Message-Id: <20251113004143.2924761-6-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251113004143.2924761-1-joshua.a.hay@intel.com>
References: <20251113004143.2924761-1-joshua.a.hay@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

The previous refactor of moving queue and vector resources out of the
idpf_vport structure, created few holes. Reshuffle the existing members
to avoid holes as much as possible.

Reviewed-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
v8: rebase on AF_XDP series
---
 drivers/net/ethernet/intel/idpf/idpf.h | 32 ++++++++++++--------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 781e0c8dbc2f..4e6ab58b70e7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -347,29 +347,29 @@ struct idpf_q_vec_rsrc {
 /**
  * struct idpf_vport - Handle for netdevices and queue resources
  * @dflt_qv_rsrc: contains default queue and vector resources
- * @num_txq: Number of allocated TX queues
- * @compln_clean_budget: Work budget for completion clean
  * @txqs: Used only in hotpath to get to the right queue very fast
- * @crc_enable: Enable CRC insertion offload
- * @xdpsq_share: whether XDPSQ sharing is enabled
+ * @num_txq: Number of allocated TX queues
  * @num_xdp_txq: number of XDPSQs
  * @xdp_txq_offset: index of the first XDPSQ (== number of regular SQs)
+ * @xdpsq_share: whether XDPSQ sharing is enabled
  * @xdp_prog: installed XDP program
- * @rx_ptype_lkup: Lookup table for ptypes on RX
  * @vdev_info: IDC vport device info pointer
  * @adapter: back pointer to associated adapter
  * @netdev: Associated net_device. Each vport should have one and only one
  *	    associated netdev.
  * @flags: See enum idpf_vport_flags
- * @vport_type: Default SRIOV, SIOV, etc.
+ * @compln_clean_budget: Work budget for completion clean
  * @vport_id: Device given vport identifier
+ * @vport_type: Default SRIOV, SIOV, etc.
  * @idx: Software index in adapter vports struct
- * @default_vport: Use this vport if one isn't specified
  * @max_mtu: device given max possible MTU
  * @default_mac_addr: device will give a default MAC to use
  * @rx_itr_profile: RX profiles for Dynamic Interrupt Moderation
  * @tx_itr_profile: TX profiles for Dynamic Interrupt Moderation
+ * @rx_ptype_lkup: Lookup table for ptypes on RX
  * @port_stats: per port csum, header split, and other offload stats
+ * @default_vport: Use this vport if one isn't specified
+ * @crc_enable: Enable CRC insertion offload
  * @link_up: True if link is up
  * @tx_tstamp_caps: Capabilities negotiated for Tx timestamping
  * @tstamp_config: The Tx tstamp config
@@ -378,34 +378,32 @@ struct idpf_q_vec_rsrc {
  */
 struct idpf_vport {
 	struct idpf_q_vec_rsrc dflt_qv_rsrc;
-	u16 num_txq;
-	u32 compln_clean_budget;
 	struct idpf_tx_queue **txqs;
-	bool crc_enable;
-
-	bool xdpsq_share;
+	u16 num_txq;
 	u16 num_xdp_txq;
 	u16 xdp_txq_offset;
+	bool xdpsq_share;
 	struct bpf_prog *xdp_prog;
 
-	struct libeth_rx_pt *rx_ptype_lkup;
-
 	struct iidc_rdma_vport_dev_info *vdev_info;
 
 	struct idpf_adapter *adapter;
 	struct net_device *netdev;
 	DECLARE_BITMAP(flags, IDPF_VPORT_FLAGS_NBITS);
-	u16 vport_type;
+	u32 compln_clean_budget;
 	u32 vport_id;
+	u16 vport_type;
 	u16 idx;
-	bool default_vport;
 
 	u16 max_mtu;
 	u8 default_mac_addr[ETH_ALEN];
 	u16 rx_itr_profile[IDPF_DIM_PROFILE_SLOTS];
 	u16 tx_itr_profile[IDPF_DIM_PROFILE_SLOTS];
-	struct idpf_port_stats port_stats;
 
+	struct libeth_rx_pt *rx_ptype_lkup;
+	struct idpf_port_stats port_stats;
+	bool default_vport;
+	bool crc_enable;
 	bool link_up;
 
 	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
-- 
2.39.2


