Return-Path: <netdev+bounces-300295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MZWgMRtRM2rC/QUAu9opvQ
	(envelope-from <netdev+bounces-300295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 03:59:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADAB69D17A
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 03:59:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=Hf2VPLbO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300295-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300295-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C35130E8129
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 01:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172872EACF9;
	Thu, 18 Jun 2026 01:54:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DCE2E7396;
	Thu, 18 Jun 2026 01:54:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781747648; cv=none; b=pyPwPRO6yrAKF5PtgIU6UJ/eDud+HvvQK6Q3taY8zCFjzXookoordd38jJ/kcKYTqRJeAtNgesucCYo5aUproVG4Pd0uY/J0Os2rl+zFu6gP6sYLUD+dzxfSaQtYbvFnDtWUrWP/fBUmOEce1/t6seoJkfUSXzBYMMqwW4W76wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781747648; c=relaxed/simple;
	bh=QR9MY7oGRZM7XHfTsx2Vxui40CTLYeJlgG71/YLLHpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D4YBrUrlIDIJw88xDLp81PjgSpFYNheiHC7IvwKktFbiZQZ+pBSYGKuA0njQlkEiLWS6cMNDKmx3+PhjIJJSt19e1kpdbEg5ycUgFJvwEpRKLCUvMJg4oMCYlK6s9GSHjtaPeRwAkWqWCqxRTkqNIEdgUvgdcLxC+3wr07cofD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=Hf2VPLbO; arc=none smtp.client-ip=173.37.86.72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=7654; q=dns/txt;
  s=iport01; t=1781747641; x=1782957241;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=urMlnb1RDV4qC1rWkHCpmKadIU7/GxR2Yy9++X3HMsM=;
  b=Hf2VPLbO5BhoNPCmjn+eoolU31Oe6UxhKcjPMyN5LcGzWJwdckgQEu/T
   ae5o9QB/MpdRwIXCajHji4C80eVr3SbTDEI42Ecb2SRQVqAbBF8C3/xCw
   b61yDTc5M3uk2dCygvqfMJefe5kc1yMaJgcBBEx9C96GcHdWhaHj9Pnm4
   Yb8QYeISAWPP+MiylXSOduYPhaUVQk/fyT1lsMoMbo787LN0rW6ch4R8Z
   gBGWdiZtI8AHKC5xOWlJkOgHOCOzy+h7Rv1HbkmnrEQV7oyy/urgsQ2g8
   qJi7wBhdYf5ieDbPxQDdvgEHx8I/mzLXGQRnhXt9pus4Wf8cxs7qTxu4u
   Q==;
X-CSE-ConnectionGUID: 5z11YJKoSMCDc9FD+1dp9A==
X-CSE-MsgGUID: RBEPs452T3eB3h4ihxfzFA==
X-IPAS-Result: =?us-ascii?q?A0BFAgBwTjNq/4r/Ja1aHgEBCxIMggULgleBUkNJhFePU?=
 =?us-ascii?q?4Ihnh4UgWoPAQEBD1EEAQGFBgKNRAImNAkOAQIEAwIDAQEBAQEBAQEBAQELA?=
 =?us-ascii?q?QEFAQEBAgEHBYEOE4ZchlsCAQMjBFIQJQImAgJGEAYBEoMCgnQDsml6fzOBA?=
 =?us-ascii?q?YR92UaBZgELFAGBCi6FcYJqAYFwhAY7hEEnG4FJRIEUAYJ6b4QFJYN0gmoEg?=
 =?us-ascii?q?g2BDxKKT4ZYCT+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSEhgVAhQcEw8EFjIdc?=
 =?us-ascii?q?AwnEiwXNFgbBwWBHoEnLwQhgQOFAyMfAzl/gW2BJWdmFTA1gQEBER8KgRsDC?=
 =?us-ascii?q?xgNSBEsNwYOGwQ9AW4HjHkXD4FLAWoHAYEOQjkyAwwyJRUILQmTH4N+jV9rg?=
 =?us-ascii?q?TWfWoQngWagDwEyl2eTBZkII6NeWYRogWg8gVkzGggbFYMiUxkPji0WHMlFJ?=
 =?us-ascii?q?zI/BwIHDwKRcwSBeQEB?=
IronPort-Data: A9a23:2uOh0ahuZRxbvDE6XDPioRK8X161oBEKZh0ujC45NGQN5FlHY01je
 htvUW3TbPaPZ2enLtgjaou1/BwA7Z/VytVgTgZp/Hs9FnhjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOOn9SUgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZeDULOZ82QsaDxMtfvc8E8HUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqVF6L8uMENt8
 sc9AxwGPz6vxLu62OOSH7wEasQLdKEHPasFsX1miDWcBvE8TNWbGuPB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWYQd/5JEWxI9EglHkeiFZs1KWpYI84nPYy0p6172F3N/9Jo3XGpoEwx/Hz
 o7A117TLykBaIHF9WGI2Cms2u7PjS3pdqtHQdVU8dYv2jV/3Fc7BBQIWF6TrfCnh0u6XNxDb
 UoZ5kIGoKQv8UW5Q8XVUBq/r3qJ+BUbXrJ4EPAw4SmOx7DS7gLfAXILJhZIbtA8udB1QzE22
 lKXt9f0Azopu739YWqU/LqSrBuoNCQVJHNEbigBJSMB4t/+sMQwgwjJQ9JLDqG4lJv2FCv2z
 jTMqzIx750VgNIH2ruT41/KmXSvq4LPQwpz4R/YNl9J9Stjb4KjIojt4l/B4LMYdcCST0KKu
 z4PnM32AP0yMKxhXRelGI0ldIxFLd7cWNEAqTaDx6Ucygk=
IronPort-HdrOrdr: A9a23:zaVUHq/f4gDVf0Ghd3huk+AuI+orL9Y04lQ7vn2ZhyYlFvBw8P
 rOoB1773HJYVkqNU3I9errBEDEewK/yXcX2+Ys1MmZPDUO0VHAROpfBMnZsl7d8kbFmtK1u5
 0QFpRWOZncAUd3iMDi7BL9MdoxqeP3iZyAtKPyw2hgSAdyZ7ol1Qd2DQ6HDlZ7LTM2Y6bRbK
 DsgfZvln6HZWkdaNi9Cz0uWujOoMCOqbfdCCR2fyLOLGK1/EmVAHmQKWni4isj
X-Talos-CUID: 9a23:MpS2cmC5iwct9of6E3R1rRclOOMiSVj24HyBDWP7UGpxGZTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AWnrEpw9Ngrn3GdjjFHtEfzWQf/1Czpy1VB1Xrc4?=
 =?us-ascii?q?LkZKEaS1wKzmPoh3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,210,1774310400"; 
   d="scan'208";a="495779517"
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Jun 2026 01:53:56 +0000
Received: from [127.0.0.1] (unknown [10.25.128.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id ED0C2180001C2;
	Thu, 18 Jun 2026 01:53:55 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Wed, 17 Jun 2026 18:53:33 -0700
Subject: [PATCH net-next v9 10/10] enic: add V2 VF probe with admin channel
 and PF registration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-enic-sriov-v2-admin-channel-v2-v9-10-37f5f5af4c93@cisco.com>
References: <20260617-enic-sriov-v2-admin-channel-v2-v9-0-37f5f5af4c93@cisco.com>
In-Reply-To: <20260617-enic-sriov-v2-admin-channel-v2-v9-0-37f5f5af4c93@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781747628; l=7884;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=QR9MY7oGRZM7XHfTsx2Vxui40CTLYeJlgG71/YLLHpg=;
 b=HXZaQbfbjfrGwZoHTmSkXlEXTroeHFDIrZ0+USFBUFQ8im3G4rTQB8JzUOnYKi+HbIAfv2W0z
 y9Ab07gvVRCAG/6s0N0okYD9XfCBzkOfCo8Td4GeZz+pXQ4xrwWq/Ba
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.189];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.189, [10.25.128.189]
X-Outbound-Node: rcdn-l-core-01.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300295-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2ADAB69D17A

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

The admin MSI-X vector reserved by enic_set_intr_mode()
is used for the admin channel interrupt.
enic_adjust_resources() ensures the reserved slot is within
intr_avail bounds even at maximum queue configurations.  The
admin INTR uses a RES_TYPE_INTR_CTRL slot shared with the
data path.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |  1 +
 drivers/net/ethernet/cisco/enic/enic_main.c | 88 ++++++++++++++++++++++++++---
 drivers/net/ethernet/cisco/enic/enic_res.c  |  3 +-
 3 files changed, 82 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index a6abd6fd04dc..1999403bd969 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -446,6 +446,7 @@ void enic_reset_addr_lists(struct enic *enic);
 int enic_sriov_enabled(struct enic *enic);
 int enic_is_valid_vf(struct enic *enic, int vf);
 int enic_is_dynamic(struct enic *enic);
+int enic_is_sriov_vf_v2(struct enic *enic);
 void enic_set_ethtool_ops(struct net_device *netdev);
 int __enic_set_rsskey(struct enic *enic);
 void enic_ext_cq(struct enic *enic);
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 04b9ae4be29b..6bc7ead860a9 100644
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
@@ -3096,6 +3105,38 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
 
@@ -3121,7 +3162,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = enic_set_mac_addr(netdev, enic->mac_addr);
 	if (err) {
 		dev_err(dev, "Invalid MAC address, aborting\n");
-		goto err_out_dev_deinit;
+		goto err_out_admin_close;
 	}
 
 	enic->tx_coalesce_usecs = enic->config.intr_timer_usec;
@@ -3219,11 +3260,23 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -3260,6 +3313,23 @@ static void enic_remove(struct pci_dev *pdev)
 
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


