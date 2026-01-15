Return-Path: <netdev+bounces-250350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FA9D2955E
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 00:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89C3830B3A71
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 23:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ABF3314DC;
	Thu, 15 Jan 2026 23:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hraHy68S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CD03203B6
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 23:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768520888; cv=none; b=J2WobRxGo9bxSX/IeEGGqD/cXvT6N6DnOLBjYSSRKljrLwK0kdG9GTXq7ZU+rc09/1721/iaraHazux9oPPAVdjy4J9qs9qG+rgX55KNVV8eEXRvBW4qBJQWOq8JPdUR6VD3xqdZChBfDOz+QshQcdnC/tAbAJTSCuipI05As7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768520888; c=relaxed/simple;
	bh=hZ7toU5UQ0WL2456kWSJjW7MC1We8zhrckb8pdYAFdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEu3M9ymV8EYanj77A0vJenbg7VygUHnvKoGM/zKDk8uhjnRCgTviy6pXYdAD9Jl8idqsbPOLTVrojVF8E4n5uceB4GCNTnVzvVwcldhTeNtQsMvIuV9YN0ODHI0ZevxJ7c4nUw6i3eRk8aNB65Mfu00p9oLhPVyxenMqxRA+Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hraHy68S; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768520885; x=1800056885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hZ7toU5UQ0WL2456kWSJjW7MC1We8zhrckb8pdYAFdI=;
  b=hraHy68STh9qu9aJRo4W2VbFia0vkvJshna1zvxSoDeTbUN3MMtaHbIm
   XksdtDB4/PKJmvAw4GEa42ygKJBqJz4bf7724vMdtCA3UI5vl2qIvwQVX
   DieBGm5FWyRRHrjbllAE/oKM528dr2zNGmMvVwByNjd5i66q7dCrMxPyY
   2dkRlPrUh2LOkTTEP6Vyy5d5Rkj4MtUNoEIVENcjcE7yX4MtbkltdNVH8
   esm0fIBtWQ/mCuaTvQIyhPv7hIyvTS8Mrba/JlR0pcyWD8tFcyJgr+kGL
   u0mR0Xb9AgqvOTRaF8AaU+E+Hv4tDbTnFP1Abtj1lpJolHtBRbJlpl+QX
   w==;
X-CSE-ConnectionGUID: sAwtTidqRqGdcEtbqgYtWA==
X-CSE-MsgGUID: mC/QudCbTYyrhP0xrC8B1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69892357"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69892357"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 15:48:01 -0800
X-CSE-ConnectionGUID: IitHjR+bQlOPZro8wK3WzQ==
X-CSE-MsgGUID: soDelby2TMSQdyIE3uPqEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="205502013"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 15 Jan 2026 15:48:00 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Madhu Chittim <madhu.chittim@intel.com>,
	anthony.l.nguyen@intel.com,
	joshua.a.hay@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next 05/10] idpf: reshuffle idpf_vport struct members to avoid holes
Date: Thu, 15 Jan 2026 15:47:42 -0800
Message-ID: <20260115234749.2365504-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260115234749.2365504-1-anthony.l.nguyen@intel.com>
References: <20260115234749.2365504-1-anthony.l.nguyen@intel.com>
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
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h | 32 ++++++++++++--------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index d7519cfc365e..a196c4debc3f 100644
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
2.47.1


