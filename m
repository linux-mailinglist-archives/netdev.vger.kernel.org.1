Return-Path: <netdev+bounces-302744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RYSOO++sQmpA/gkAu9opvQ
	(envelope-from <netdev+bounces-302744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:35:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A326DDC7D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:35:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=byM4n7eV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302744-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302744-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A07C3047DB9
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA84477E21;
	Mon, 29 Jun 2026 17:26:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E1C472796;
	Mon, 29 Jun 2026 17:26:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753970; cv=none; b=ZVTEE2d2BHFQzeP7OJEVsA+gQoZ95xNODDJkmkWUvPSFS2/EWIpLUWd2yEvdD6cqS2S7Kl1c+PpNohmucJ8BcQOAEm62Ass6FU1oRyqn+MfPclb150y6mOpkNP0el3P/1ojWHMijm2KV/HmIf44CW1h4bsIE62kAvUhZBmeSqZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753970; c=relaxed/simple;
	bh=3gL3NIFaVF+0H+Ofn5EKlW0eoZSHlup+Ozy7hX6+HN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/3VeTdHZFoYqTuBdcr6XdLf7p65A6ZqEf/AtF2/L2XEM8/HG4+CSYz4sYE3lVOyHfTPPVt1rXty1TP4n7yOpzSJz35fyUpUQ5VsJvKbUPcX3P9giv6eSu9w7eyP7P/W94LlUZF4XzbXoKoTyom4MWmeQYIWt6oeRTBobrHJxhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=byM4n7eV; arc=none smtp.client-ip=173.37.86.72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3920; q=dns/txt;
  s=iport01; t=1782753968; x=1783963568;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=PgJZJHti/xto1BSearAPGsr9py1TUyVl/DNcgdMawyo=;
  b=byM4n7eVTUPt4cY5yBAPh5Z2NxsZOVm0yG3v1rilurKUN/kS/pnzHfcR
   ypayzwoWOPrI1rXLYf4Rs8JFZ+S4Eohn2kjjGOGRveN2W/6oa4+XEDyNZ
   vopOvHnhMnZ5kAn5EpkpJwEmlYExgTnSMHnUmmLuB5et6u8UblIw8xnJf
   Hmn4b0Ke8fqT1VfD3uvN9eRITLT1pqDuvo3aeoljlfUuo5ntKSbbRv9RV
   lHjreuCn1+dNHQc/jeZsOy0CL70wQAnTa7h3WHsNnZBEDXkKw40QkKz4X
   5kBQM12QhXk5QO2BC5KzlSe0dQjsMvi2jHm2jOHWr0ha1OcnH/VBUT6d8
   g==;
X-CSE-ConnectionGUID: d4hj2apzQsmcKf2KNPsAag==
X-CSE-MsgGUID: iqd5A1EXTHKFlllY2pXtzw==
X-Ironport-Invalid-End-Of-Message: True
X-IPAS-Result: =?us-ascii?q?A0BFAgBUqkJq/5D/Ja1aHgEBCxIMggULgleBUkNJhFePU?=
 =?us-ascii?q?4Ihnh6Bfg8BAQEPUQQBAYUGAo1LAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQsBA?=
 =?us-ascii?q?QUBAQECAQcFgQ4ThlyGWwIBAyMEUhAlAiYCAkYQBgESgwKCdAO4c3p/M4EBh?=
 =?us-ascii?q?H3ZRoFmAQsUAYEKLoVxgmoBgXCEBjuEQScbgUlEgRWDaYEZgwaDf4JqBIMcE?=
 =?us-ascii?q?pEGCT+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSEhgVAhQvDwQWMh1wDCcSLBc0W?=
 =?us-ascii?q?BsHBYEdgRUvBCGBBIR9Ix8DOX+BMHVYZhUwNYERHgqBUicDCxgNSBEsNwYOG?=
 =?us-ascii?q?wQ9AW4HjF0XD4FMXxI9HDUUgSkPFBkbgQ+SYwgVg2GNX2uBNZ9ahCeBZqAPA?=
 =?us-ascii?q?TKXZ5MFmQgjpDeEaIFoPIFZMxoIGxWDIlMZD44qAxbMWycyPwcCBw8CkgSBb?=
 =?us-ascii?q?AEB?=
IronPort-Data: A9a23:gkyTqamYlt1lj+cmom8KZhTo5gxBJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xJOUTqEbK2PMDTxfN8kOd+3oUNUvMXWydI2TVFprCg2QVtH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/raf658SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+ZG31GONgWYubDpKsfPb8XuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FYFE+uQtCHlcz
 OcdIxMDNDOlv/mfyb3uH4GAhux7RCXqFJkUtnclyXTSCuwrBMicBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQTZj/7C7pm9AusrmL2bzxDqFGVjaE2+GPUigd21dABNfKIIoXVFZgMwRzwS
 mTu/n31XzhDGeyj6Rmr9naot7XXrT/pR9dHfFG/3rsw6LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIjobU3/V6mUvHyWBq3pHPCtRkZM/JTDuczwAKA0KzZ50CeHGdsZjdHZMYrq4wwSCAm2
 0Ghm87vA3pksNW9UXuX+7GVhSm/NSgcMSkJYipsZQ8E5cTz5YI+lBTCSv59H6OvyN74Azf9x
 3aNtidWr7MekcIGyY2l8l3dxTGhvJ7ESkgy/Aq/Y46+xhlyaIjgY8mj7kLWqK4fao2YVVKG+
 nMDnqBy8dwzMH1ErwTVKM1lIV1jz6/t3OH06bK3I6Qcyg==
IronPort-HdrOrdr: A9a23:KogSBarza61K9vaBWFI2Yc4aV5rdeYIsimQD101hICG9vPbo8/
 xG+8576faUslgssR4b9OxoVJPrfZqYz+8W3WBzB9iftXfd2FdARbsKheDfKn/bak7DH4VmuZ
 uIHZIObeHYPBxWgdn35Q+gH81l4tWWmZrY/Nv2/jNBQR5nbqd44xw8MAaUFUVqWBJLbKBJcq
 Z0nvA3wAaISDAwctmxAGUDUqzoot3Gk4+jXDs9biRXkDVnSViTmcTH+9/y5GZkbw9y
X-Talos-CUID: 9a23:higoXmGFTs2vijwGqmJrqE4WQMk9YETGyXzzLRWbL15yYbSaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3A1TslTQ/J2RDjL19fKVdXtMiQf8Zx7/mHUW09rbU?=
 =?us-ascii?q?llc2AMR0qIweBniviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,232,1774310400"; 
   d="scan'208";a="501785172"
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Jun 2026 17:26:00 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-07.cisco.com (Postfix) with ESMTPS id 1F8E6180004B3;
	Mon, 29 Jun 2026 17:26:00 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Mon, 29 Jun 2026 10:25:56 -0700
Subject: [PATCH net-next v10 04/12] enic: add admin RQ buffer management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-enic-sriov-v2-admin-channel-v2-v10-4-62569af83417@cisco.com>
References: <20260629-enic-sriov-v2-admin-channel-v2-v10-0-62569af83417@cisco.com>
In-Reply-To: <20260629-enic-sriov-v2-admin-channel-v2-v10-0-62569af83417@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782753956; l=3986;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=3gL3NIFaVF+0H+Ofn5EKlW0eoZSHlup+Ozy7hX6+HN4=;
 b=DEcS11NpHe6UDWpHWfOZQmYwIX4V7XaZaVwXrRd6j6lcTA99kmPS2VSr7vggsyJDnKdRhjFyg
 Q1S205e8F6kDJAYqKjLzVBlpA2Xdu31ORpvL76kmUFxXwjgLN+JvQoJ
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-07.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302744-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8A326DDC7D

The admin receive queue needs pre-posted DMA buffers for incoming
mailbox messages from VFs. Each buffer is a kmalloc'd region mapped
for DMA (2048 bytes, sufficient for any MBOX message).

Add enic_admin_rq_fill(gfp) to post buffers at open time, and
enic_admin_rq_drain() to unmap and free them at close time.
Wire both into the admin channel open/close paths. The gfp_t
parameter lets the caller pass the allocation context; both current
callers -- channel open and the CQ-poll work handler that refills
after draining (added in the next patch) -- run in process context
and use GFP_KERNEL.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_admin.c | 66 +++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index 50b46b92c88f..b2be42092106 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -3,6 +3,7 @@
 
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
+#include <linux/dma-mapping.h>
 
 #include "vnic_dev.h"
 #include "vnic_wq.h"
@@ -34,10 +35,63 @@ static void enic_admin_wq_buf_clean(struct vnic_wq *wq,
 	}
 }
 
-/* No-op: admin RQ buffer teardown is handled in enic_admin_channel_close */
 static void enic_admin_rq_buf_clean(struct vnic_rq *rq,
 				    struct vnic_rq_buf *buf)
 {
+	struct enic *enic = vnic_dev_priv(rq->vdev);
+
+	if (!buf->os_buf)
+		return;
+
+	dma_unmap_single(&enic->pdev->dev, buf->dma_addr, buf->len,
+			 DMA_FROM_DEVICE);
+	kfree(buf->os_buf);
+	buf->os_buf = NULL;
+}
+
+static int enic_admin_rq_post_one(struct enic *enic, gfp_t gfp)
+{
+	struct vnic_rq *rq = &enic->admin_rq;
+	struct rq_enet_desc *desc;
+	dma_addr_t dma_addr;
+	void *buf;
+
+	buf = kmalloc(ENIC_ADMIN_BUF_SIZE, gfp);
+	if (!buf)
+		return -ENOMEM;
+
+	dma_addr = dma_map_single(&enic->pdev->dev, buf, ENIC_ADMIN_BUF_SIZE,
+				  DMA_FROM_DEVICE);
+	if (dma_mapping_error(&enic->pdev->dev, dma_addr)) {
+		kfree(buf);
+		return -ENOMEM;
+	}
+
+	desc = vnic_rq_next_desc(rq);
+	rq_enet_desc_enc(desc, (u64)dma_addr | VNIC_PADDR_TARGET,
+			 RQ_ENET_TYPE_ONLY_SOP, ENIC_ADMIN_BUF_SIZE);
+	vnic_rq_post(rq, buf, 0, dma_addr, ENIC_ADMIN_BUF_SIZE, 0);
+
+	return 0;
+}
+
+static int enic_admin_rq_fill(struct enic *enic, gfp_t gfp)
+{
+	struct vnic_rq *rq = &enic->admin_rq;
+	int err;
+
+	while (vnic_rq_desc_avail(rq) > 0) {
+		err = enic_admin_rq_post_one(enic, gfp);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void enic_admin_rq_drain(struct enic *enic)
+{
+	vnic_rq_clean(&enic->admin_rq, enic_admin_rq_buf_clean);
 }
 
 static int enic_admin_qp_type_set(struct enic *enic, u32 enable)
@@ -171,6 +225,13 @@ int enic_admin_channel_open(struct enic *enic)
 	vnic_wq_enable(&enic->admin_wq);
 	vnic_rq_enable(&enic->admin_rq);
 
+	err = enic_admin_rq_fill(enic, GFP_KERNEL);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "Failed to fill admin RQ buffers: %d\n", err);
+		goto disable_queues;
+	}
+
 	err = enic_admin_qp_type_set(enic, QP_ENABLE);
 	if (err) {
 		netdev_err(enic->netdev,
@@ -188,6 +249,7 @@ int enic_admin_channel_open(struct enic *enic)
 		netdev_warn(enic->netdev, "Failed to disable admin WQ\n");
 	if (vnic_rq_disable(&enic->admin_rq))
 		netdev_warn(enic->netdev, "Failed to disable admin RQ\n");
+	enic_admin_rq_drain(enic);
 	enic_admin_free_resources(enic);
 	return err;
 }
@@ -218,7 +280,7 @@ void enic_admin_channel_close(struct enic *enic)
 			    "Failed to disable admin RQ: %d\n", err);
 
 	vnic_wq_clean(&enic->admin_wq, enic_admin_wq_buf_clean);
-	vnic_rq_clean(&enic->admin_rq, enic_admin_rq_buf_clean);
+	enic_admin_rq_drain(enic);
 	vnic_cq_clean(&enic->admin_cq[0]);
 	vnic_cq_clean(&enic->admin_cq[1]);
 	enic_admin_free_resources(enic);

-- 
2.43.0


