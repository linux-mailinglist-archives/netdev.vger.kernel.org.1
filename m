Return-Path: <netdev+bounces-280800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHcoHGtL6mkhxgIAu9opvQ
	(envelope-from <netdev+bounces-280800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:40:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB70245508A
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1A2630F9E24
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF22390986;
	Thu, 23 Apr 2026 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="JEabg0RC"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB6C38236C;
	Thu, 23 Apr 2026 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961815; cv=none; b=ifZclVBxEjUE0JcxUGSu5uHHdfDfNMJ27U53bxNnaRSGuPXUxKExubj3re1r+Dp7KqMUuUaIk6q7k+GuTvvsdM66YVXp2QhZS/RGMznVwGtvKHvzVK85SzzIdoj5kU6JeVNy3y/4y7B6tj90+eRjSOWs3olBF5YifDX9T5nr03c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961815; c=relaxed/simple;
	bh=HlsW+rOR6r7jE0j2X0/hlwQbrLlmvK2iJsMrubN+vtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iyyMcEauov9pBxoAOSpZCShNDn8y9l5Cjg965mXdHt7y/9PnKW8xUdbSrGZvpqEgQj8yN6IQW6ivqWOa4GSKz8zGVoUyLrj81CHb6NPTnb0+WZ0GgxbzBGuHMUeWgMhE108UpOTHm/vOPmNndqw9yIqLXB5jZEqmF6Mt6Apf4S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=JEabg0RC; arc=none smtp.client-ip=173.37.142.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=9125; q=dns/txt;
  s=iport01; t=1776961813; x=1778171413;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=7VaO9v3qrXxObjoPeIq02bU+iGQzzZhl+AN0HAV8KI4=;
  b=JEabg0RCluvjMlory01ZDTc7lBvChwqObf6rYh0AoNS2S7fY1TTO/Ybv
   9zFCZ4W2N9vfCQMm6DYG66bP0j/5mqbL3PUYV9EgBfRqoswnJJMy85UL4
   clH7RupEunb9a/YRDN1Y7XWt7Y+uJzln0LDV2IY9SHHpe9MGLDPwTNipO
   ARh9pywXJkZlOpoZtfVGQsg/Ydeti5xqu3M2uzgPDeQBV1MPSyFTiBmUd
   yGGytdO6SjtJ0LeCL33tXbGESvycrKXLTyyX7UOpQ0jt4qrTJcZIIdUgp
   J8jjJacv5U/sftqslCXni+hFcxjS2ruTaVQ8ocOt+YNPH/upcrnLeVYrk
   g==;
X-CSE-ConnectionGUID: Hd6AquzNTcaDCruSnsNhNw==
X-CSE-MsgGUID: Osy37k5URZSag9E3UbOuWw==
X-IPAS-Result: =?us-ascii?q?A0BIAgAkSOpp/4//Ja1QCh4BAQsSDIIFC4JXgU9DSYRXj?=
 =?us-ascii?q?1OCIZ4dFIFrDwEBAQ9RBAEBhQYCjSwCJjQJDgECBAEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QEBAQsBAQUBAQECAQcFgQ4ThlyGWwIBAyMEUhAlAiYCAkUBEAYBEoMCgnQDs?=
 =?us-ascii?q?1F6fzOBAYR92UKBZAELFAGBCi6FcoJmAYFwhAY7hD8nG4FJRIEUAYNohAUBE?=
 =?us-ascii?q?AmDf4JpBIMcFIFeIINSiU4JP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCF?=
 =?us-ascii?q?BwTDwQWMh1wDCcSLBc0WBsHBYFLhAltFDEEIYELgyqBNoEBAwsYDUgRLDcGD?=
 =?us-ascii?q?hsEPQFuB4o2IA+BOWoHAYENAROBKVcxGSyWeo1da6EOhCaBZIxakzQBMpdmk?=
 =?us-ascii?q?wWZBiKjSW6EaIFoPIFZMxoIGxWDIlMZD44tFhzIciYyPQEBBwIHDQMLgWiQA?=
 =?us-ascii?q?g8XB4FOAQE?=
IronPort-Data: A9a23:ayqc6q2xG9eHj/4WHvbD5RNwkn2cJEfYwER7XKvMYLTBsI5bpzFTz
 jceXj3SPvuIZDP3fY9zb4jl/UhSvJaEz9c2TwM93Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yFjmH4E/xbtANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXX4
 rsen+WFYAX7g2IuaTpPg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGLE1oFJQF6MBLCmhi3
 uYFEzYWSBClmLfjqF67YrEEasULNsLnOsYb/3pn1zycVahgSpHYSKKM7thdtNsyrpkRRrCFO
 IxDNGcpNUibC/FMEg9/5JYWh+60h2L/cD1wo1OOrq1x6G/WpOB0+Oe3bYKLI43aFa25mG6/v
 XOdoGekPysoD9WQmBfez3iLm9DQyHaTtIU6UefQGuRRqFGa2GEWIBEfS1a+pf63lgi4Vs43A
 0EY5y8nv6Uu3EOsSdb5Uluzp3vslh0BUdN4EOAg7gyJjK3O7G6xD24IVDNeK9orqMM7WxQuy
 1mP2djpbRR3ubeYT3O17LqYrTqufyMSKAcqYS4CUBtA4NT5pow3pgzAQ8wlE6OviNDxXzbqz
 FiiqiUii7gNpdAE2r/9/l3dhT+o4J/TQWYICh7/RGmp6EZ9IYWifYHtsQad5vdbJ4HfRV6E1
 JQZp/WjACk1JcnlvESwrC8lRtlFO97t3OXgvGNS
IronPort-HdrOrdr: A9a23:p0KZ36x3kFBZtKufRV15KrPw2r1zdoMgy1knxilNoNJuA6ilfq
 eV/cjztCWbtN9/YhwdcLy7UpVoBEmsl6KdgrN/AV7dZmnbUQKTRekI0WKh+UyCJ8SUzIJgPM
 lbAs1DIey1IFRkgcP9+QWiV/Qt0LC8gdmVrNab4ntzQQRtcq16qz14BAGSD1FsSGB9dPwE/e
 Knl616jgvlX2gLZcKmAXRAde3Cq9rX0K/CW3c9dmYaAM3kt0LT1FY8eCLopSsjbw==
X-Talos-CUID: 9a23:18vxuGwP5uPIg4vFe34QBgU0Fp4Ma2DP6kvbKmOTE3tSTqazSXmPrfY=
X-Talos-MUID: 9a23:gqptwwUuC4/iomzq/Bj3lWo9N5pV2ZaVAU9cvM47se6ZCjMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,195,1770595200"; 
   d="scan'208";a="725061988"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Apr 2026 16:29:06 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id C48B31800039B;
	Thu, 23 Apr 2026 16:29:05 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Thu, 23 Apr 2026 09:28:07 -0700
Subject: [PATCH net-next v5 06/10] enic: add MBOX core send and receive for
 admin channel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-enic-sriov-v2-admin-channel-v2-v5-6-caa9f504a3dc@cisco.com>
References: <20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com>
In-Reply-To: <20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776961741; l=9389;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=HlsW+rOR6r7jE0j2X0/hlwQbrLlmvK2iJsMrubN+vtY=;
 b=OB2K+75RVnWh8RQ7AT2ZA6njug3J8M2uI8EZ1ZNY18hEeuReCIjRwh+nyoKt19xaKEg7T1wDh
 u11EtUtQvODDpn7LCDAvpmr10+Tiqv6yQ0sQiplrbx21/V+T9TKHdNB
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-06.cisco.com
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
	TAGGED_FROM(0.00)[bounces-280800-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cisco.com:email,cisco.com:dkim,cisco.com:mid]
X-Rspamd-Queue-Id: CB70245508A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/ethernet/cisco/enic/enic_admin.c |  23 +++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c  | 162 +++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_mbox.h  |   8 ++
 5 files changed, 199 insertions(+), 2 deletions(-)

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
index cf1528c85506..e097e6f8d8d4 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -19,6 +19,7 @@
 #include "cq_enet_desc.h"
 #include "wq_enet_desc.h"
 #include "rq_enet_desc.h"
+#include "enic_mbox.h"
 
 /* Clean up any admin WQ buffers still held by hardware at close time.
  * Normally buffers are freed inline after send completion, but a timed-out
@@ -167,7 +168,26 @@ unsigned int enic_admin_rq_cq_service(struct enic *enic, unsigned int budget)
 					buf->dma_addr, buf->len,
 					DMA_FROM_DEVICE);
 
-		enic_admin_msg_enqueue(enic, buf->os_buf, buf->len);
+		if (enic->admin_rq_handler) {
+			struct cq_enet_rq_desc *rq_desc = desc;
+			u16 sender_vlan;
+
+			/* Firmware sets the CQ VLAN field to identify the
+			 * sender: 0 = PF, 1-based = VF index.  Overwrite
+			 * the untrusted src_vnic_id in the MBOX header with
+			 * the hardware-verified value.
+			 */
+			sender_vlan = le16_to_cpu(rq_desc->vlan);
+			if (buf->len >= sizeof(struct enic_mbox_hdr)) {
+				struct enic_mbox_hdr *hdr = buf->os_buf;
+
+				hdr->src_vnic_id = (sender_vlan == 0) ?
+					cpu_to_le16(ENIC_MBOX_DST_PF) :
+					cpu_to_le16(sender_vlan - 1);
+			}
+
+			enic_admin_msg_enqueue(enic, buf->os_buf, buf->len);
+		}
 
 		enic_admin_rq_buf_clean(rq, rq->to_clean);
 		rq->to_clean = rq->to_clean->next;
@@ -413,6 +433,7 @@ int enic_admin_channel_open(struct enic *enic)
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


