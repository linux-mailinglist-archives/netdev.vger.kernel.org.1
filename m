Return-Path: <netdev+bounces-283588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEyoJy0x92lidQIAu9opvQ
	(envelope-from <netdev+bounces-283588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 13:27:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1974B5469
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 13:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 161FA303A84D
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 11:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3179352C58;
	Sun,  3 May 2026 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="E92Qe/Ft"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF4734D389;
	Sun,  3 May 2026 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777807450; cv=none; b=e3sj1A5KOkANqJf+i8H6zbNMqIA6iN77yuUBLBhgDncrtofqKlnFSeOyJoCw2gWoVWO2jBc8uOAYBNhw1UovmWRwRd4oD2TmUsnVid1Ei/Y4G6iNY406fXsg75M3IM70XEck57vtFK7ZYI1WKQHP/7AkI6LGRbBUOKaIMDcmYDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777807450; c=relaxed/simple;
	bh=9zpd/txLttPW3uuD2/DhiCw+LPXtnqyXW0Y+kpn/Y1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bsZ0zqhp1DmLXu8jMJzJM1cxP1P5Tj2dB8QDW1CnNHc48FBfZpEgQsy8wxmlcFrQQo+RkjQ/c6re4atBJoiW1t0fCjDsib4EB4rtOA0VHiwQi6QUHDzDrEdYL8IvLkzp/lDS2oDFTMJzor9yswoxvP/4E5s1WA5RNPqhvneBAcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=E92Qe/Ft; arc=none smtp.client-ip=173.37.142.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=9048; q=dns/txt;
  s=iport01; t=1777807448; x=1779017048;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=dR68T1HVCfUDwmwTAMKpL+GC8TWYIs6Vwc/0JTzPkkg=;
  b=E92Qe/FtFPaW1t4CDwRRqkAtQrzD3qupJLqw5iY7rDlMKoa01j4gDxof
   Fnle6QS22KSXTpWde6WB5hf+9cb/H7gdttVOw1yx1gphL/J31oMtdw9Zm
   wpi3U7TPBGgPU4hKhj//3vXG/tESrr+znMnT8u13z07OG+PVBAmGwkLF7
   Dv0Vhxg4ujS1txZdyQZUSYETLW4ztQ0HweQ9q39ubseKtdsHCm+S7oWw1
   skOalGXjeO1G8mqVfNqjFKTPWYPjQPwTNFNbDd2Vg9wE32vgxZWsAhBP8
   doRywLukFlE3DxpcPdeIm512ea6ssOsqG9ynQHqTa40oXL2nHQBjDZ20/
   Q==;
X-CSE-ConnectionGUID: bz/W7YWzTO24B2QFQ7ERYg==
X-CSE-MsgGUID: p4i5KOSBRZ2mHym8aDc6kw==
X-IPAS-Result: =?us-ascii?q?A0BIAgDQLvdp/4v/Ja1QCh4BAQsSDIIFC4JXgU9DSYRXj?=
 =?us-ascii?q?1OCIZ4dFIFrDwEBAQ9RBAEBhQYCjTECJjQJDgECBAEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QEBAQsBAQUBAQECAQcFgQ4ThlyGWwIBAyMEUhAlAiYCAkUBEAYBEoMCgnQDt?=
 =?us-ascii?q?B56fzOBAYR92UOBZAELFAGBCi6FcoJmAYFwhAY7hD8nG4FJRIEUAYNohAUBE?=
 =?us-ascii?q?AmDf4JpBIMcFIFeIIJxiiwJP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCF?=
 =?us-ascii?q?BwTDwQWMh1wDCcSLBc0WBsHBYFLgwBtFDEEIYEFhGB4IywDTnIDCxgNSBEsN?=
 =?us-ascii?q?wYOGwQ9AW4HimYdD4E/agcBgQ0BE4EpVzEZLJZ6jV1roQ6EJoFkjFqTNAEyl?=
 =?us-ascii?q?2aTBZkGIqNJboRogWg8gVkzGggbFYMiUxkPji0WHMk8JjI9AQEHAgcNAwuBa?=
 =?us-ascii?q?JACDxcHgU4BAQ?=
IronPort-Data: A9a23:WVSSzqrl+5Rlhn8d5lsCbZFHSuVeBmLYZBIvgKrLsJaIsI4StFCzt
 garIBmCb/mDZTD3L9p0YY+/8koEvZXSmNViHVBl+CBhQSIS9+PIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9j8kif3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYgTNNwJcaDpOtfre8Eg35ZwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0uxlRl4Rx
 MMKFBdXMjrZvsyPn5+Be+Y506zPLOGzVG8ekmtrwTecCbMtRorOBv2Qo9RZxzw3wMtJGJ4yZ
 eJANmEpN0uGOUASfA5MWfrSn8/w7pX7WyZRtFOOpak3y2PS1wd2lrPqNbI5f/TVH5UEwR3E+
 DKuE2LRGk0baf+48hC/wCippv7KzSrXU9wRC+jtnhJtqBjJroAJMzUaXEW2pNG1g1CzXtZYJ
 VBS/CcyxYA/+FGuR8vwQzW3p3mLuhNaUN1Ve8U59QuE4qnZ+QCUAi4DVDEpQNUguNU7Wn8s2
 0OFks3BASFptvueSRq17r6eoDWzETIYIW8LeWkPSg5ty93ippwjyxHCVNBuFIargdDvXzL92
 TaHqG45nbp7pcgGy6m243jZjD+24JvEVAg44kPQRG3N0+9iTJSua4rt7R3Q6uxNad7DCFKAp
 3MD3cOZ6YjiEK2wqcBEe81VdJnB2hpPGGS0bYJHd3X5ywmQxg==
IronPort-HdrOrdr: A9a23:eYLYFKgGbXBWFQnCmT3kXdjiB3BQXiwji2hC6mlwRA09TyVXrb
 HLoB19737JYVcqNk3I9ursBEDtexnhHNtOkOss1NSZMzUOxlHJEGgK1+KLqAEIWReOldK1vp
 0NT0ERMqyUMXFKyev3/wW8Fc8t252k/LDAv5am815dCSxndK1k6R50EUKgEkNwTBRbHpZRLu
 v72iM+nUvGRV0nKuKmG3ICQ+/P4/fPlJ7gfFo6IiRP0nj3sdttg4SKaSRxGXwlIkhy/Ys=
X-Talos-CUID: =?us-ascii?q?9a23=3AXF7pQGmOAjADf6Gloa4VLFpkC9vXOXfPi0iPEnC?=
 =?us-ascii?q?qNUEzFJfPcHGpp45eosU7zg=3D=3D?=
X-Talos-MUID: 9a23:0PYkPQnpZVuL6IaVHZQjdnp6aMY1wIOVIno/y5AmqszUPAB7ZTSC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,213,1770595200"; 
   d="scan'208";a="728973468"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 May 2026 11:23:00 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPS id A7325180007C2;
	Sun,  3 May 2026 11:22:59 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Sun, 03 May 2026 04:22:43 -0700
Subject: [PATCH net-next v6 06/10] enic: add MBOX core send and receive for
 admin channel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-enic-sriov-v2-admin-channel-v2-v6-6-0af4fbc2d86d@cisco.com>
References: <20260503-enic-sriov-v2-admin-channel-v2-v6-0-0af4fbc2d86d@cisco.com>
In-Reply-To: <20260503-enic-sriov-v2-admin-channel-v2-v6-0-0af4fbc2d86d@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777807375; l=9303;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=9zpd/txLttPW3uuD2/DhiCw+LPXtnqyXW0Y+kpn/Y1k=;
 b=8Q5gsM+eCSltrgB0Un1gZ7JJfaWGB5lI+2eUOk0Dqw6h6GPvzmTxLmCDKolQb9IDoudx/gptR
 hhjtOAJjtDkDQppC8rUztm/itg0v+//XVj0jbdMFhzi4qUEGLP4+1Fn
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-02.cisco.com
X-Rspamd-Queue-Id: EF1974B5469
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283588-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:dkim,cisco.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Implement the mailbox protocol engine used for PF-VF communication
over the admin channel.

The send path (enic_mbox_send_msg) builds a message with a common
header, DMA-maps it, posts a single WQ descriptor with the
destination vnic ID encoded in the VLAN tag field, and polls
the WQ CQ for completion.

The receive path (enic_mbox_recv_handler) is installed as the admin
RQ callback and validates incoming message headers. PF/VF-specific
dispatch will be added in subsequent commits.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/Makefile     |   2 +-
 drivers/net/ethernet/cisco/enic/enic.h       |   6 +
 drivers/net/ethernet/cisco/enic/enic_admin.c |  22 +++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c  | 162 +++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_mbox.h  |   8 ++
 5 files changed, 198 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/Makefile b/drivers/net/ethernet/cisco/enic/Makefile
index 7ae72fefc99a..e38aaf34c148 100644
--- a/drivers/net/ethernet/cisco/enic/Makefile
+++ b/drivers/net/ethernet/cisco/enic/Makefile
@@ -4,5 +4,5 @@ obj-$(CONFIG_ENIC) := enic.o
 enic-y := enic_main.o vnic_cq.o vnic_intr.o vnic_wq.o \
 	enic_res.o enic_dev.o enic_pp.o vnic_dev.o vnic_rq.o vnic_vic.o \
 	enic_ethtool.o enic_api.o enic_clsf.o enic_rq.o enic_wq.o \
-	enic_admin.o
+	enic_admin.o enic_mbox.o
 
diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 1c09da3c0b1a..42f345aceced 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -292,6 +292,8 @@ struct enic {
 
 	/* Admin channel resources for SR-IOV MBOX */
 	bool has_admin_channel;
+	/* set on send timeout; cleared on channel re-open */
+	bool mbox_send_disabled;
 	struct vnic_wq admin_wq;
 	struct vnic_rq admin_rq;
 	struct vnic_cq admin_cq[2];
@@ -304,6 +306,10 @@ struct enic {
 	u64 admin_msg_drop_cnt;
 	void (*admin_rq_handler)(struct enic *enic, void *buf,
 				 unsigned int len);
+
+	/* MBOX protocol state */
+	struct mutex mbox_lock;
+	u64 mbox_msg_num;
 };
 
 static inline struct net_device *vnic_get_netdev(struct vnic_dev *vdev)
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index 5445815139b5..43e697b7b424 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -19,6 +19,7 @@
 #include "cq_enet_desc.h"
 #include "wq_enet_desc.h"
 #include "rq_enet_desc.h"
+#include "enic_mbox.h"
 
 /* Clean up any admin WQ buffers still held by hardware at close time.
  * Normally buffers are freed inline after send completion, but a timed-out
@@ -197,7 +198,25 @@ unsigned int enic_admin_rq_cq_service(struct enic *enic, unsigned int budget)
 			goto next_desc;
 		}
 
-		enic_admin_msg_enqueue(enic, buf->os_buf, bytes_written);
+		if (enic->admin_rq_handler) {
+			u16 sender_vlan;
+
+			/* Firmware sets the CQ VLAN field to identify the
+			 * sender: 0 = PF, 1-based = VF index.  Overwrite
+			 * the untrusted src_vnic_id in the MBOX header with
+			 * the hardware-verified value.
+			 */
+			sender_vlan = le16_to_cpu(rq_desc->vlan);
+			if (bytes_written >= sizeof(struct enic_mbox_hdr)) {
+				struct enic_mbox_hdr *hdr = buf->os_buf;
+
+				hdr->src_vnic_id = (sender_vlan == 0) ?
+					cpu_to_le16(ENIC_MBOX_DST_PF) :
+					cpu_to_le16(sender_vlan - 1);
+			}
+
+			enic_admin_msg_enqueue(enic, buf->os_buf, bytes_written);
+		}
 
 next_desc:
 		enic_admin_rq_buf_clean(rq, rq->to_clean);
@@ -477,6 +496,7 @@ int enic_admin_channel_open(struct enic *enic)
 	if (!enic->has_admin_channel)
 		return -ENODEV;
 
+	enic->mbox_send_disabled = false;
 	err = enic_admin_alloc_resources(enic);
 	if (err) {
 		netdev_err(enic->netdev,
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
new file mode 100644
index 000000000000..3b2fc9822176
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2025 Cisco Systems, Inc.  All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+
+#include "vnic_dev.h"
+#include "vnic_wq.h"
+#include "vnic_cq.h"
+#include "enic.h"
+#include "enic_admin.h"
+#include "enic_mbox.h"
+#include "wq_enet_desc.h"
+
+#define ENIC_MBOX_POLL_TIMEOUT_US	5000000
+#define ENIC_MBOX_POLL_INTERVAL_US	100
+
+static void enic_mbox_fill_hdr(struct enic *enic, struct enic_mbox_hdr *hdr,
+			       u8 msg_type, u16 dst_vnic_id, u16 msg_len)
+{
+	memset(hdr, 0, sizeof(*hdr));
+	hdr->dst_vnic_id = cpu_to_le16(dst_vnic_id);
+	hdr->msg_type = msg_type;
+	hdr->msg_len = cpu_to_le16(msg_len);
+	hdr->msg_num = cpu_to_le64(++enic->mbox_msg_num);
+}
+
+int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
+		       void *payload, u16 payload_len)
+{
+	u16 total_len = sizeof(struct enic_mbox_hdr) + payload_len;
+	struct vnic_wq *wq = &enic->admin_wq;
+	struct wq_enet_desc *desc;
+	unsigned long timeout;
+	dma_addr_t dma_addr;
+	u16 vlan_tag;
+	void *buf;
+	int err;
+
+	/* Serialize MBOX sends. The admin channel is a low-frequency
+	 * control path; holding the mutex across the poll is acceptable.
+	 */
+	mutex_lock(&enic->mbox_lock);
+
+	if (!enic->has_admin_channel || enic->mbox_send_disabled) {
+		err = -ENODEV;
+		goto unlock;
+	}
+
+	if (vnic_wq_desc_avail(wq) == 0) {
+		err = -ENOSPC;
+		goto unlock;
+	}
+
+	buf = kmalloc(total_len, GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	enic_mbox_fill_hdr(enic, buf, msg_type, dst_vnic_id, total_len);
+	if (payload_len) {
+		void *dst = buf + sizeof(struct enic_mbox_hdr);
+
+		memcpy(dst, payload, payload_len);
+	}
+
+	dma_addr = dma_map_single(&enic->pdev->dev, buf, total_len,
+				  DMA_TO_DEVICE);
+	if (dma_mapping_error(&enic->pdev->dev, dma_addr)) {
+		kfree(buf);
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	/* Firmware uses vlan field for routing: 0 = PF, 1-based = VF index */
+	if (dst_vnic_id == ENIC_MBOX_DST_PF)
+		vlan_tag = 0;
+	else
+		vlan_tag = dst_vnic_id + 1;
+
+	desc = vnic_wq_next_desc(wq);
+	wq_enet_desc_enc(desc, (u64)dma_addr | VNIC_PADDR_TARGET,
+			 total_len, 0, 0, 0, 1, 1, 0, 1, vlan_tag, 0);
+	vnic_wq_post(wq, buf, dma_addr, total_len, 1, 1, 1, 1, 0, 0);
+	vnic_wq_doorbell(wq);
+
+	timeout = jiffies + usecs_to_jiffies(ENIC_MBOX_POLL_TIMEOUT_US);
+	err = -ETIMEDOUT;
+	while (time_before(jiffies, timeout)) {
+		if (enic_admin_wq_cq_service(enic)) {
+			err = 0;
+			break;
+		}
+		usleep_range(ENIC_MBOX_POLL_INTERVAL_US,
+			     ENIC_MBOX_POLL_INTERVAL_US + 50);
+	}
+	/* Final check in case completion arrived during the last sleep */
+	if (err && enic_admin_wq_cq_service(enic))
+		err = 0;
+
+	if (!err) {
+		wq->to_clean = wq->to_clean->next;
+		wq->ring.desc_avail++;
+		dma_unmap_single(&enic->pdev->dev, dma_addr, total_len,
+				 DMA_TO_DEVICE);
+		kfree(buf);
+	} else {
+		netdev_err(enic->netdev,
+			   "MBOX send timed out (type %u dst %u), disabling channel\n",
+			   msg_type, dst_vnic_id);
+		/*
+		 * The WQ descriptor is still live in hardware. Do not unmap
+		 * or free the buffer: the device may still DMA from dma_addr.
+		 * Mark the channel unusable so no further sends are attempted.
+		 */
+		enic->mbox_send_disabled = true;
+	}
+
+	netdev_dbg(enic->netdev,
+		   "MBOX send msg_type %u dst %u vlan %u err %d\n",
+		   msg_type, dst_vnic_id, vlan_tag, err);
+unlock:
+	mutex_unlock(&enic->mbox_lock);
+	return err;
+}
+
+static void enic_mbox_recv_handler(struct enic *enic, void *buf,
+				   unsigned int len)
+{
+	struct enic_mbox_hdr *hdr = buf;
+
+	if (len < sizeof(*hdr)) {
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: truncated message (len %u < %zu)\n",
+				    len, sizeof(*hdr));
+		return;
+	}
+
+	if (hdr->msg_type >= ENIC_MBOX_MAX) {
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: unknown msg type %u\n",
+				    hdr->msg_type);
+		return;
+	}
+
+	netdev_dbg(enic->netdev,
+		   "MBOX recv: type %u from vnic %u len %u\n",
+		   hdr->msg_type, le16_to_cpu(hdr->src_vnic_id),
+		   le16_to_cpu(hdr->msg_len));
+}
+
+void enic_mbox_init(struct enic *enic)
+{
+	enic->mbox_msg_num = 0;
+	mutex_init(&enic->mbox_lock);
+	enic->admin_rq_handler = enic_mbox_recv_handler;
+}
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.h b/drivers/net/ethernet/cisco/enic/enic_mbox.h
index a52f1d25cb21..73fd7f783ee2 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.h
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.h
@@ -80,4 +80,12 @@ struct enic_mbox_pf_link_state_ack_msg {
 	struct enic_mbox_generic_reply ack;
 };
 
+#define ENIC_MBOX_DST_PF	0xFFFF
+
+struct enic;
+
+void enic_mbox_init(struct enic *enic);
+int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
+		       void *payload, u16 payload_len);
+
 #endif /* _ENIC_MBOX_H_ */

-- 
2.43.0


