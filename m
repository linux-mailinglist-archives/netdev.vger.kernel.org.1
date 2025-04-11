Return-Path: <netdev+bounces-181691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AB7A862C9
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47C437BC1FD
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 16:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0C73FB31;
	Fri, 11 Apr 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RwXGj7v1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018EE1E8335
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387254; cv=none; b=gJEdppZ8R8Mqy4EUZCGl/+8l7mxt9WFAfQA7vQdcAvolCdr5V14DylbxpoWiyt9xeGW97iqoRgyrT9EwwTLuW/PXQLTAQeyuSY7snAGtWCL3i2j1i+sJooABvu37FG1QjtA2HbUxxqxImy9zggwjrfcJYNdc4RVV4TmyxFk+Gcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387254; c=relaxed/simple;
	bh=xHYLkNlHzOqq5UAUq/s/3DQyt8oyTH2qJbIOoZ1A7Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=regvXQopsmho/amRFpEueALxaNz26fjEP8RfqrwjaNeZhWxFjThLtcbE85MyVF9vvLE68pwkWpH5ZaTJcmj2UQLgdB1Rmlrc3LWlvG1O0V4SKyuC/UXUaSLvIvr+1nDZLd3qYupZLQzoNgcYNgT1UBUef/NKNHZ7GjifiVZBeu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RwXGj7v1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744387253; x=1775923253;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xHYLkNlHzOqq5UAUq/s/3DQyt8oyTH2qJbIOoZ1A7Y0=;
  b=RwXGj7v1mTBepgYkiAYQUvWNt7wHrfu6xuxph+m5eruDMOro28cWmDX0
   km+9Pv2R/ezeIf4SRdr+JJ+PJNIzAjgPXMuN9nYq5jJ5YyiVKGYMaUCSS
   8lUgNNToVx/clFZ5svlyVjDFJKMvXb1EInYggjs62CjuuhX4P6Nl9MBjf
   6mKjmzw4WDDbjOVFblhtgBAY+F2m2CyqdnO5lprkCh9c5CdB+bmQ4+6ta
   XLUmk1ImuBcYfvAni3otNqTIELTMhcOcEwXkAxm6z+nqbYvONTXEXtYS5
   WBSDOqujZ57BbOLFrmXUhqquqFvBvzNtCs475N/eF/5PVSnSJQdPbBXwS
   w==;
X-CSE-ConnectionGUID: KYiJ7AOOTUyptRmURgaLTg==
X-CSE-MsgGUID: h99ve1ocQCeS2g7paTNqrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="68433889"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="68433889"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 09:00:52 -0700
X-CSE-ConnectionGUID: RbxF6juvRCeoQIe9XmKSvw==
X-CSE-MsgGUID: SSFDzFIdTiy2Z5Kk0j7Lvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="133985238"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.55])
  by fmviesa005.fm.intel.com with ESMTP; 11 Apr 2025 09:00:51 -0700
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Madhu Chititm <madhu.chittim@intel.com>
Subject: [PATCH iwl-net] idpf: fix null-ptr-deref in idpf_features_check
Date: Fri, 11 Apr 2025 09:00:35 -0700
Message-ID: <20250411160035.9155-1-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

idpf_features_check is used to validate the TX packet. skb header
length is compared with the hardware supported value received from
the device control plane. The value is stored in the adapter structure
and to access it, vport pointer is used. During reset all the vports
are released and the vport pointer that the netdev private structure
points to is NULL.

To avoid null-ptr-deref, store the max header length value in netdev
private structure. This also helps to cache the value and avoid
accessing adapter pointer in hot path.

BUG: kernel NULL pointer dereference, address: 0000000000000068
...
RIP: 0010:idpf_features_check+0x6d/0xe0 [idpf]
Call Trace:
 <TASK>
 ? __die+0x23/0x70
 ? page_fault_oops+0x154/0x520
 ? exc_page_fault+0x76/0x190
 ? asm_exc_page_fault+0x26/0x30
 ? idpf_features_check+0x6d/0xe0 [idpf]
 netif_skb_features+0x88/0x310
 validate_xmit_skb+0x2a/0x2b0
 validate_xmit_skb_list+0x4c/0x70
 sch_direct_xmit+0x19d/0x3a0
 __dev_queue_xmit+0xb74/0xe70
 ...

Fixes: a251eee62133 ("idpf: add SRIOV support and other ndo_ops")
Reviewed-by: Madhu Chititm <madhu.chittim@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h     |  2 ++
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 10 ++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 66544faab710..dc37ac0accd5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -143,6 +143,7 @@ enum idpf_vport_state {
  * @vport_id: Vport identifier
  * @link_speed_mbps: Link speed in mbps
  * @vport_idx: Relative vport index
+ * @max_tx_hdr_size: Max header length hardware can support
  * @state: See enum idpf_vport_state
  * @netstats: Packet and byte stats
  * @stats_lock: Lock to protect stats update
@@ -153,6 +154,7 @@ struct idpf_netdev_priv {
 	u32 vport_id;
 	u32 link_speed_mbps;
 	u16 vport_idx;
+	u16 max_tx_hdr_size;
 	enum idpf_vport_state state;
 	struct rtnl_link_stats64 netstats;
 	spinlock_t stats_lock;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index f3aea7bcdaa3..b926305562ab 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -721,6 +721,7 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 		np->vport = vport;
 		np->vport_idx = vport->idx;
 		np->vport_id = vport->vport_id;
+		np->max_tx_hdr_size = idpf_get_max_tx_hdr_size(adapter);
 		vport->netdev = netdev;
 
 		return idpf_init_mac_addr(vport, netdev);
@@ -738,6 +739,7 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	np->adapter = adapter;
 	np->vport_idx = vport->idx;
 	np->vport_id = vport->vport_id;
+	np->max_tx_hdr_size = idpf_get_max_tx_hdr_size(adapter);
 
 	spin_lock_init(&np->stats_lock);
 
@@ -2206,8 +2208,8 @@ static netdev_features_t idpf_features_check(struct sk_buff *skb,
 					     struct net_device *netdev,
 					     netdev_features_t features)
 {
-	struct idpf_vport *vport = idpf_netdev_to_vport(netdev);
-	struct idpf_adapter *adapter = vport->adapter;
+	struct idpf_netdev_priv *np = netdev_priv(netdev);
+	u16 max_tx_hdr_size = np->max_tx_hdr_size;
 	size_t len;
 
 	/* No point in doing any of this if neither checksum nor GSO are
@@ -2230,7 +2232,7 @@ static netdev_features_t idpf_features_check(struct sk_buff *skb,
 		goto unsupported;
 
 	len = skb_network_header_len(skb);
-	if (unlikely(len > idpf_get_max_tx_hdr_size(adapter)))
+	if (unlikely(len > max_tx_hdr_size))
 		goto unsupported;
 
 	if (!skb->encapsulation)
@@ -2243,7 +2245,7 @@ static netdev_features_t idpf_features_check(struct sk_buff *skb,
 
 	/* IPLEN can support at most 127 dwords */
 	len = skb_inner_network_header_len(skb);
-	if (unlikely(len > idpf_get_max_tx_hdr_size(adapter)))
+	if (unlikely(len > max_tx_hdr_size))
 		goto unsupported;
 
 	/* No need to validate L4LEN as TCP is the only protocol with a
-- 
2.43.0


