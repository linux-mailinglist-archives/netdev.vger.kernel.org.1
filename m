Return-Path: <netdev+bounces-280805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB5ZNdRK6mkhxgIAu9opvQ
	(envelope-from <netdev+bounces-280805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:37:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 96404454FE7
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14796303CC54
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE4E3A5E66;
	Thu, 23 Apr 2026 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="kvdvMCn3"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AD739023F;
	Thu, 23 Apr 2026 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961818; cv=none; b=J7YgNpD8lv9Wa4rwUa6PC1svgtHEo6AvHp62tDFOExPnTAbyksm9aYgWzdE4lIdtAIUDC9jCmEfu1CNrnt+C+14YsF8G+0durONplVsXF6KeXz3NpN0iuQ+cVXOaO4X8CD6UFPtHhJLtcmBKS8jffbIZwOKf7h+HFJdBkciE3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961818; c=relaxed/simple;
	bh=cI7jZFbFLsJBhYo1XIMBZP3pNISto4Ay+0utIALdpiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fX71PtBBQC7sA9uLbJ27ufetjzG7BLu3AyOmX4bsGcAKqNxci8hYGF1fVL9mSaC6jRgYqOdQqC39sJTG5K2usSDkG9gOisjZwEpZ37ZrvgFMAUG7DvJyUHeFJqyCPUhDpy9+beymcWkqCeeKglJcKTgunWIhW/KeItaf1Swnux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=kvdvMCn3; arc=none smtp.client-ip=173.37.142.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=6800; q=dns/txt;
  s=iport01; t=1776961816; x=1778171416;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=52v8GMeIYVgKWnI1pwzIX7iE/NOeEJp5lV/mDLz15dw=;
  b=kvdvMCn39jfEAOQSTvTQOXY0X7ZqFNOJsNFCxkaWYCSWhOE8N7yY7nHF
   DZfW2FCPUAtTwYLfKOvySa2tckk/Wq2ZM3StF9Fe/EFXjmF/zVLYHRDZJ
   H8O5nkkEEGeRYE7QVMfdyov1NwFaZq1d5ARr1Xol/pRxlc7tAcY7Hg+OE
   utCj1qRpr1lO0UyvLONRFFou+QmS4kG5mX8Sz3ZNCZ3tXvTGtDGmHq5aT
   0OEkNtnOL32QXSFGJT+Ir/03YoVO/UVY+H/8TI+KGIAIK+lKL5uMUGU+o
   6NP1qUHsFD87yFRra1GBAQtuNvwVX3h9wtbw6iwX5+GjVkbQFwXuXL28H
   A==;
X-CSE-ConnectionGUID: p2mi/VVCR1qJ23mpS0bm1A==
X-CSE-MsgGUID: ulJt6zBZSFKSzvjiBDwrFw==
X-IPAS-Result: =?us-ascii?q?A0BHAgClR+pp/4//Ja1aglmCV4FPQ0mEV49TgiGeHRSBa?=
 =?us-ascii?q?w8BAQEPUQQBAYUGAo0sAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFA?=
 =?us-ascii?q?QEBAgEHBYEOE4ZchlsCAQMjBFIQJQImAgJGEAYBEoMCgnQDs1V6fzOBAYR92?=
 =?us-ascii?q?UKBZAELFAGBCi6FcoJmAYFwhAY7hD8nG4FJRIEUAYJ5b4QFJYN0gmkEgxwUj?=
 =?us-ascii?q?x4JP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCFBwTDwQWMh1wDCcSLBc0W?=
 =?us-ascii?q?BsHBYFLhAltFDEEIYELgyqBNoEBAwsYDUgRLDcGDhsEPQFuB4o2IA+BOAFxA?=
 =?us-ascii?q?Vk1QjkyDzIlFQgtRZJjg36NXWuBNZ9ZhCaBZKAOATKXZpMFmQYio15ZhGiBa?=
 =?us-ascii?q?DyBWTMaCBsVgyJTGQ+OLRYcyHImMj8HAgcOApFzBIF5AQE?=
IronPort-Data: A9a23:8tYqhaDqxx0IBhVW/+niw5YqxClBgxIJ4kV8jS/XYbTApG8mgTQFz
 zcaXD3Xaf+MajT1f9AgYYjj/R8H65WBnd82OVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZvCCeA+n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jWGthh
 fuo+5eBYAP/gGYvWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TE269rDQYIA6Yio/9VWzpL7
 cdAIjVUR0XW7w626OrTpuhEnM8vKozveYgYoHwllW+fBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGY0BPjDS0Un1lM/E5sinfyohXnXeDxDo1XTrq0yi4TW5FMrgeO8YIuFJrRmQ+1ImmSE+
 HDszV/XISoIKt6e4xaa6Fyz07qncSTTHdh6+KeD3vJjnlCW7mAaFhATUVy1vb+/h1LWc99TN
 kkd6Ccyhac180OvQ5/2WBjQiH2ZtBc0WNdKFeA+rgaXxcL86gCVHGUbDThMdNArqucyWDosk
 FSJ9/vxDDZitry9U3+R9r6I6zi1PEA9KW4EeD9BTgYf5dTniJ88gwiJTdt5FqOxyNrvFlnYx
 T2WoCUgr6scgNRN1Kih+13DxTW2qfD0ohUd/A7bWCehqwh+foPgP9Lu4lnA5vEGJ4GcJrWcg
 EU5dwGlxLhmJfmweOalGo3hwJnBCy65DQDh
IronPort-HdrOrdr: A9a23:0ZQsZqtclVzTl60Iw0ODy+je7skDgNV00zEX/kB9WHVpmwKj5q
 STdZMgtCMc6Qx+ZJhOo7290cW7K080sKQFg7X5Xo3MYOCZgguVxehZhOOI/9SjIVycygc378
 tdmsZFebjNJGk/oMrk7Ay/Cto6hPuK4MmT9J7j5kYoYA10Z6Rn9gtjTjyaHEp/WRVcCfMCZf
 yhD7J81l2dUEVSSNinDX8YWOWGjdjKmJX6JSMiPXccmXGzZffC0s+BL/BetS1uKA9y/Q==
X-Talos-CUID: =?us-ascii?q?9a23=3AJzzgD2sj+pv121OgYQl4HlCC6Is9KHjci0nuCHX?=
 =?us-ascii?q?hEEQzE7iNcgea/fpNxp8=3D?=
X-Talos-MUID: 9a23:7GOKLQQe2JH+LNPTRXTxgBN+atVC0Z+AK3sfj5cHkeWbLwJvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,195,1770595200"; 
   d="scan'208";a="729398984"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Apr 2026 16:29:09 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id A5F5C18000279;
	Thu, 23 Apr 2026 16:29:08 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Thu, 23 Apr 2026 09:28:11 -0700
Subject: [PATCH net-next v5 10/10] enic: add V2 VF probe with admin channel
 and PF registration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-enic-sriov-v2-admin-channel-v2-v5-10-caa9f504a3dc@cisco.com>
References: <20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com>
In-Reply-To: <20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776961741; l=6994;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=cI7jZFbFLsJBhYo1XIMBZP3pNISto4Ay+0utIALdpiw=;
 b=OS0MIvdNZKuYbOdk2Xsb/nIZiCARyosMHgbXqCxsqik0S+ng83d5izA2r3yOb3HQpbBd453mH
 nZLBXnzqJvDCDxmdSagxFusvrIFyM6b2PUIXuWJGLazUZ8o8/sq3jHE
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-06.cisco.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280805-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:dkim,cisco.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96404454FE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a V2 SR-IOV VF probes, open the admin channel, initialize the
MBOX protocol, perform the capability check with the PF, and register
with the PF. This establishes the PF-VF communication path that the PF
uses to send link state notifications.

The admin channel and MBOX registration happen after enic_dev_init()
(which discovers admin channel resources) and before register_netdev()
so the VF is fully initialized before the interface is visible to
userspace.

The admin channel is opened before enic_mbox_init() installs the
receive handler.  This is safe because enic_admin_rq_cq_service()
checks admin_rq_handler before enqueuing received buffers, so any
interrupt that fires between open and mbox_init is harmlessly
discarded.

On remove, the VF unregisters from the PF and closes its admin channel
before tearing down data path resources.

V2 VFs are not provisioned with an RES_TYPE_SRIOV_INTR resource by
firmware, so bypass that check in the admin channel capability
detection for V2 VFs. The PF still requires this resource.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |  1 +
 drivers/net/ethernet/cisco/enic/enic_main.c | 77 ++++++++++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_res.c  |  3 +-
 3 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 70bb8cb9fe42..6f1cd110c670 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -442,6 +442,7 @@ void enic_reset_addr_lists(struct enic *enic);
 int enic_sriov_enabled(struct enic *enic);
 int enic_is_valid_vf(struct enic *enic, int vf);
 int enic_is_dynamic(struct enic *enic);
+int enic_is_sriov_vf_v2(struct enic *enic);
 void enic_set_ethtool_ops(struct net_device *netdev);
 int __enic_set_rsskey(struct enic *enic);
 void enic_ext_cq(struct enic *enic);
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 057716ccc283..eaf7c5640b7e 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -316,6 +316,11 @@ static int enic_is_sriov_vf(struct enic *enic)
 	       enic->pdev->device == PCI_DEVICE_ID_CISCO_VIC_ENET_VF_V2;
 }
 
+int enic_is_sriov_vf_v2(struct enic *enic)
+{
+	return enic->pdev->device == PCI_DEVICE_ID_CISCO_VIC_ENET_VF_V2;
+}
+
 int enic_is_valid_vf(struct enic *enic, int vf)
 {
 #ifdef CONFIG_PCI_IOV
@@ -2157,6 +2162,13 @@ static void enic_reset(struct work_struct *work)
 	enic_set_api_busy(enic, true);
 
 	enic_stop(enic->netdev);
+	/* CMD_SOFT_RESET disables all hardware queues including the
+	 * admin channel queues (admin_wq, admin_rq, admin_cq).  The
+	 * recovery path below only reinitializes the data path queues.
+	 * If the admin channel was active (V2 SR-IOV), it will be left
+	 * in a disabled state after soft reset.  Full admin channel
+	 * recovery is planned as a future enhancement.
+	 */
 	enic_dev_soft_reset(enic);
 	enic_reset_addr_lists(enic);
 	enic_init_vnic_resources(enic);
@@ -2992,6 +3004,38 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_dev_close;
 	}
 
+	/* V2 VF: open admin channel and register with PF.
+	 * Must happen before register_netdev so the VF is fully
+	 * initialized before the interface is visible to userspace.
+	 *
+	 * admin_channel_open() runs before enic_mbox_init() installs
+	 * the receive handler.  This is safe because
+	 * enic_admin_rq_cq_service() checks admin_rq_handler before
+	 * enqueuing any received buffer, so interrupts that fire
+	 * between open and mbox_init are harmlessly discarded.
+	 */
+	if (enic_is_sriov_vf_v2(enic)) {
+		err = enic_admin_channel_open(enic);
+		if (err) {
+			dev_err(dev,
+				"Failed to open admin channel: %d\n", err);
+			goto err_out_dev_deinit;
+		}
+		enic_mbox_init(enic);
+		err = enic_mbox_vf_capability_check(enic);
+		if (err) {
+			dev_err(dev,
+				"MBOX capability check failed: %d\n", err);
+			goto err_out_admin_close;
+		}
+		err = enic_mbox_vf_register(enic);
+		if (err) {
+			dev_err(dev,
+				"MBOX VF registration failed: %d\n", err);
+			goto err_out_admin_close;
+		}
+	}
+
 	netif_set_real_num_tx_queues(netdev, enic->wq_count);
 	netif_set_real_num_rx_queues(netdev, enic->rq_count);
 
@@ -3016,7 +3060,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = enic_set_mac_addr(netdev, enic->mac_addr);
 	if (err) {
 		dev_err(dev, "Invalid MAC address, aborting\n");
-		goto err_out_dev_deinit;
+		goto err_out_admin_close;
 	}
 
 	enic->tx_coalesce_usecs = enic->config.intr_timer_usec;
@@ -3114,11 +3158,23 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(dev, "Cannot register net device, aborting\n");
-		goto err_out_dev_deinit;
+		goto err_out_admin_close;
 	}
 
 	return 0;
 
+err_out_admin_close:
+	if (enic_is_sriov_vf_v2(enic)) {
+		if (enic->vf_registered) {
+			int unreg_err = enic_mbox_vf_unregister(enic);
+
+			if (unreg_err)
+				netdev_warn(netdev,
+					    "Failed to unregister from PF: %d\n",
+					    unreg_err);
+		}
+		enic_admin_channel_close(enic);
+	}
 err_out_dev_deinit:
 	enic_dev_deinit(enic);
 err_out_dev_close:
@@ -3155,6 +3211,23 @@ static void enic_remove(struct pci_dev *pdev)
 
 		cancel_work_sync(&enic->reset);
 		cancel_work_sync(&enic->change_mtu_work);
+
+		/* Close the admin channel and unregister from the PF before
+		 * unregister_netdev() to prevent a late PF notification from
+		 * touching a netdev that has been freed.
+		 */
+		if (enic_is_sriov_vf_v2(enic)) {
+			if (enic->vf_registered) {
+				int unreg_err = enic_mbox_vf_unregister(enic);
+
+				if (unreg_err)
+					netdev_warn(netdev,
+						    "Failed to unregister from PF: %d\n",
+						    unreg_err);
+			}
+			enic_admin_channel_close(enic);
+		}
+
 		unregister_netdev(netdev);
 #ifdef CONFIG_PCI_IOV
 		if (enic_sriov_enabled(enic)) {
diff --git a/drivers/net/ethernet/cisco/enic/enic_res.c b/drivers/net/ethernet/cisco/enic/enic_res.c
index 436326ace049..74cd2ee3af5c 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.c
+++ b/drivers/net/ethernet/cisco/enic/enic_res.c
@@ -211,7 +211,8 @@ void enic_get_res_counts(struct enic *enic)
 		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_RQ) >= 1 &&
 		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_CQ) >=
 			ARRAY_SIZE(enic->admin_cq) &&
-		vnic_dev_get_res_count(enic->vdev, RES_TYPE_SRIOV_INTR) >= 1;
+		(enic_is_sriov_vf_v2(enic) ||
+		 vnic_dev_get_res_count(enic->vdev, RES_TYPE_SRIOV_INTR) >= 1);
 
 	dev_info(enic_get_dev(enic),
 		"vNIC resources avail: wq %d rq %d cq %d intr %d admin %s\n",

-- 
2.43.0


