Return-Path: <netdev+bounces-304642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oogSECz7R2reiQAAu9opvQ
	(envelope-from <netdev+bounces-304642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:10:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCE4704C78
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:10:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=IC3xndXX;
	dmarc=pass (policy=reject) header.from=cisco.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304642-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304642-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22383304CF44
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 18:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C05E314A84;
	Fri,  3 Jul 2026 18:09:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915AC30D41E;
	Fri,  3 Jul 2026 18:09:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102148; cv=none; b=MTVKaLofLWj1qslw68PDASH4qumN+M/qfZ5XMuz6UMx2Slj7NEfmeHwaGiqX0qpTkztTuQyS39orCQDPzGVwvRsIhvYiJhlc63Hx2t2K5zBkPxIlqXweVIkpPjzH2ulfm9FNRXlTgI6NQf4m853KHRN4p0cKSWdFU+GCHf/qqOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102148; c=relaxed/simple;
	bh=B8hX+8NYlp4nvqpweTDRHzDB20zFjnemFDEBdx6UUaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZbSyP/Z84RpaedV4DLAfRWsQExrId1TZHILqb7WSJRtg1IF27Rhav0cTmWF0u+wcnn+bZPvDmlT0/FBA6SKinnQJCXqHmJthWVpGD2ZO7is61ewlDsRSY9p2BGsRiPsRzDJ/Vzo6ukOVLwgpLYhJicTGwy4TOzTKCRfRAAvXViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=IC3xndXX; arc=none smtp.client-ip=173.37.86.77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=8924; q=dns/txt;
  s=iport01; t=1783102146; x=1784311746;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4gwSJKlKJDUOeRYixBT9bOvQy8xbX+FlvXDjIciUTrw=;
  b=IC3xndXXPBOlfJxA2v5qYaaXnu6VEGRtQu9z6geDqNTzKuwqeye0RGlj
   4Q0r6fqBOujmNa9zm2AFpHZBp7FPdXxBOm5Ngsgdt0R2Nu0KROrMjsaNN
   qBY8p4PuvuimB41sg91DlvjpyOUetoM0dUy1Rqu8xSD3YjKFbTaTV0ezp
   bTLq2g6oVoRn/SNLyj9wuujUDoXtTUzy8QpgmCexj3ETmnoISBCmE1JgJ
   HcEEnjVBPWzY/rZZtG/usyg3P4MjZOQT6800QRRjRZUHJo6dQekKRbw6V
   VTyANpndwefiOXoRZtlVtYDDtTX5igxX3nIcTZ1qKyLHBb2MflaDo2p3X
   w==;
X-CSE-ConnectionGUID: owJilaOHQ4Ssy/mbA69qzg==
X-CSE-MsgGUID: qfztOPEiSUKCDJbl++siZg==
X-IPAS-Result: =?us-ascii?q?A0BFAgDU+Udq/5P/Ja1aHgEBCxIMggULgleBUkNJhFePU?=
 =?us-ascii?q?4Ihnh4UgWoPAQEBD1EEAQGFBgKNSwImNAkOAQIEAwIDAQEBAQEBAQEBAQELA?=
 =?us-ascii?q?QEFAQEBAgEHBYEOE4ZchlsCAQMjBFIQJQImAgJGEAYBEoMCgnQDvAV6fzOBA?=
 =?us-ascii?q?YR92UaBZgELFAGBCi6FcYJqAYFwhAY7hEEnG4FJRIEUAYNphAUlg3SCagSCD?=
 =?us-ascii?q?YEPEolVh0oJP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCFBwTDwQWMh1wD?=
 =?us-ascii?q?CcSLBc0WBsHBYEdgRUxBCGBBIR5Ix8DOX+BMHVKeTOBAgESHgqBUoEmAwsYD?=
 =?us-ascii?q?UgRLDcGDhsEPQFuB40AFw+BSwFREAkHAVkhFEI5BC4BAgwyJRUILQk6ApJjg?=
 =?us-ascii?q?36NX2uBNZ9ahCeBZqAPATKXZ5MFmQgjo15ZhGiBaDyBWTMaCBsVgyJTGQ+OL?=
 =?us-ascii?q?RYc0h4nMj8HAgcPApFzBIF5AQE?=
IronPort-Data: A9a23:AofxPKzg+UiIS0ENEaF6t+f3xyrEfRIJ4+MujC+fZmUNrF6WrkUHy
 TcZCzyHM/2KZjH8Kdp1aoSx9E8EsZDczNAyT1BsqFhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCea/VH1buSJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 46aT/H3Ygf/hWYrajlMscpvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJEYpH4wc88FXOD117
 u1fLTokMEGale3jldpXSsE07igiBNPgMIVavjRryivUSK9+B5vCWK7No9Rf2V/chOgXQq2YP
 JVfM2cyKk2cPHWjOX9PYH46tPyhmnjkcz5YgFmUvqEwpWPUyWSd1ZCwaIaIIYLTGpw9ckCwv
 2zU40PBLxAhCf+05RiP9jHvne79knauMG4VPPjinhJwu3Wfz3IeDTUaXEW2pP2+hFL4Xd9DQ
 2QZ9jcrpLo/6GSkSd7yWxD+q3mB1jYfRtBZO+438geAzuzT+QnxLmECQiRMd58gudM6SCIC0
 kKPmZXiBVRHqLSfRHSc3q2ZoTO7JW4eKmpqTSsFSxYVptruuoc+ijrRQdt5Vq24lNv4HXf32
 T/ihC4zm7kek+YV2Kihu1PKmTShot7OVAFd2+nMdniu4gU8YMuuYJalrAGDq/1BN42eCFKGu
 RDohvSj0QzHNrnV/ATlfQnHNOjBCyqtWNEEvWNSIg==
IronPort-HdrOrdr: A9a23:/6Ayfal6vBctG2V0R5jHTsRpfBrpDfLa3DAbv31ZSRFFG/FwWf
 re+MjzsiWUtN9xYh8dcL+7VZVoLUm3yXcx2/hyAV7AZmbbURWTTL2KhLGKq1bd8m/Fh41gPM
 xbH5SWZueAaGRSvILW7Ba1FtA4zMLC0qy57N2utktFfEVGZ75t6gFhBh3eKE15QwFaGYE0fa
 DsgPav3wDQHkg/X4CcGmQPWfTFqpngkZLrZgNDOjscgTP+9Q9BLNXBYmKlNtB0aUI1/Ysf
X-Talos-CUID: =?us-ascii?q?9a23=3ALDl4+2kRC3DZnBc2kr9DnzyKZHHXOXrC7nbUKmi?=
 =?us-ascii?q?YMDpSU6zSTFW5pvJ9gcU7zg=3D=3D?=
X-Talos-MUID: 9a23:8cPiOAno0VBtfYTi/QOSdnp7OtV0xJyDCXswsr4qmcOAdm9rOgWS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,145,1779148800"; 
   d="scan'208";a="504536171"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Jul 2026 18:09:03 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTPS id 08CD4180008AC;
	Fri,  3 Jul 2026 18:09:02 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Fri, 03 Jul 2026 11:09:00 -0700
Subject: [PATCH net-next v11 11/12] enic: add V2 VF probe with admin
 channel and PF registration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-enic-sriov-v2-admin-channel-v2-v11-11-5b739f1fe9e5@cisco.com>
References: <20260703-enic-sriov-v2-admin-channel-v2-v11-0-5b739f1fe9e5@cisco.com>
In-Reply-To: <20260703-enic-sriov-v2-admin-channel-v2-v11-0-5b739f1fe9e5@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783102134; l=9181;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=B8hX+8NYlp4nvqpweTDRHzDB20zFjnemFDEBdx6UUaY=;
 b=zaqew2b5GmCWqAm1wrWViWIhnxjwfc5LCHmIeefiOsbumPSZj6yk4X4I3cbbH0kPuDGHkq2yH
 GPTXJD4PERQAvg9VM1gpZ7nNZ4ioiFFaNXoLH28lR7epqNBvqCMVf3z
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-10.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304642-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sebaddel@cisco.com,m:satishkh@cisco.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cisco.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cisco.com:from_mime,cisco.com:email,cisco.com:mid,cisco.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CCE4704C78

When a V2 SR-IOV VF probes, open the admin channel, initialize the
MBOX protocol, perform the capability check with the PF, and register
with the PF. This establishes the PF-VF communication path that the PF
uses to send link state notifications.

The admin channel and MBOX registration happen after enic_dev_init()
(which discovers admin channel resources) and before register_netdev()
so the VF is fully initialized before the interface is visible to
userspace.

A V2 VF whose firmware did not provision admin WQ/RQ/CQ resources
fails probe with -ENODEV from enic_admin_channel_open(); the admin
channel is a hard requirement for V2 VFs.

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

The admin MSI-X vector reserved by enic_set_intr_mode()
is used for the admin channel interrupt.
enic_adjust_resources() ensures the reserved slot is within
intr_avail bounds even at maximum queue configurations.  The
admin INTR uses a RES_TYPE_INTR_CTRL slot shared with the
data path.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |   1 +
 drivers/net/ethernet/cisco/enic/enic_main.c | 101 +++++++++++++++++++++++++---
 drivers/net/ethernet/cisco/enic/enic_res.c  |   3 +-
 3 files changed, 94 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index b5a43fe04877..62b8941489d7 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -452,6 +452,7 @@ void enic_reset_addr_lists(struct enic *enic);
 int enic_sriov_enabled(struct enic *enic);
 int enic_is_valid_vf(struct enic *enic, int vf);
 int enic_is_dynamic(struct enic *enic);
+int enic_is_sriov_vf_v2(struct enic *enic);
 void enic_set_ethtool_ops(struct net_device *netdev);
 int __enic_set_rsskey(struct enic *enic);
 void enic_ext_cq(struct enic *enic);
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 68a293d60ab8..99c06a049800 100644
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
@@ -2399,15 +2404,19 @@ static int enic_adjust_resources(struct enic *enic)
 		enic->intr_count = enic->intr_avail;
 		break;
 	case VNIC_DEV_INTR_MODE_MSIX: {
-		/* Reserve one MSI-X slot for the admin channel interrupt
-		 * when V2 SR-IOV admin channel resources are present.
-		 */
-		unsigned int admin_reserve =
-			enic->has_admin_channel ? 1 : 0;
-
 		/* Adjust the number of wqs/rqs/cqs/interrupts that will be
-		 * used based on which resource is the most constrained
+		 * used based on which resource is the most constrained.
+		 * Reserve one extra MSI-X slot for the admin channel INTR
+		 * when has_admin_channel is set so that
+		 * enic_admin_setup_intr() can allocate at intr_count
+		 * within the intr_avail bounds even when the data queue
+		 * count is maxed out.  intr_count counts only the data-path
+		 * IRQs (registered by enic_request_intr()); the admin INTR
+		 * lives at msix index intr_count and is set up later by
+		 * enic_admin_setup_intr().
 		 */
+		unsigned int admin_reserve = enic->has_admin_channel ? 1 : 0;
+
 		wq_avail = min(enic->wq_avail, ENIC_WQ_MAX);
 		rq_default = max(netif_get_num_default_rss_queues(),
 				 ENIC_RQ_MIN_DEFAULT);
@@ -3104,6 +3113,44 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_dev_close;
 	}
 
+	/* Initialise link_notify_work before the V2-VF admin-open block below:
+	 * its error path (err_out_admin_close -> enic_admin_channel_close() ->
+	 * cancel_work_sync()) would otherwise act on an uninitialised work.
+	 */
+	INIT_WORK(&enic->link_notify_work, enic_link_notify_work_handler);
+
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
 
@@ -3116,7 +3163,6 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&enic->reset, enic_reset);
 	INIT_WORK(&enic->tx_hang_reset, enic_tx_hang_reset);
 	INIT_WORK(&enic->change_mtu_work, enic_change_mtu_work);
-	INIT_WORK(&enic->link_notify_work, enic_link_notify_work_handler);
 
 	for (i = 0; i < enic->wq_count; i++)
 		spin_lock_init(&enic->wq[i].lock);
@@ -3129,7 +3175,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = enic_set_mac_addr(netdev, enic->mac_addr);
 	if (err) {
 		dev_err(dev, "Invalid MAC address, aborting\n");
-		goto err_out_dev_deinit;
+		goto err_out_admin_close;
 	}
 
 	enic->tx_coalesce_usecs = enic->config.intr_timer_usec;
@@ -3227,11 +3273,23 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -3269,7 +3327,30 @@ static void enic_remove(struct pci_dev *pdev)
 		cancel_work_sync(&enic->reset);
 		cancel_work_sync(&enic->tx_hang_reset);
 		cancel_work_sync(&enic->change_mtu_work);
+
+		/* Close the admin channel and unregister from the PF before
+		 * unregister_netdev() to prevent a late PF notification from
+		 * touching a netdev that is being torn down.
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
+		/* unregister_netdev() -> enic_stop() stops the notify timer, so
+		 * no new link_notify_work can be queued past this point.  Cancel
+		 * unconditionally to cover the narrow window where
+		 * enic_link_check() scheduled it just as SR-IOV was disabled.
+		 */
+		cancel_work_sync(&enic->link_notify_work);
 #ifdef CONFIG_PCI_IOV
 		if (enic_sriov_enabled(enic)) {
 			if (enic->vf_type == ENIC_VF_TYPE_V2)
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


