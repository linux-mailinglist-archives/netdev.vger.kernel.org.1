Return-Path: <netdev+bounces-287649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NhiCaefBGqbMAIAu9opvQ
	(envelope-from <netdev+bounces-287649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:58:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38870536A18
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C04963464430
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854714C8FE5;
	Wed, 13 May 2026 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="DwsPWLH/"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45AE4C6F0D;
	Wed, 13 May 2026 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685372; cv=none; b=D6k6X8cjv7a8rdEUu6ia2NgiYbxBaPKZ3JXoA9ywbpztU8b/NZPxc96H53S0YhZvEOHQkTlvG0oyhTzcpUHqwvCTxuq6qC3LlcNPhLtzNuRAASDh1XLVvhkwax+Ju8QV0F3mGla/Q686cpOaM6yRi/nS/ZyoUF9/LZVS2PeRCmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685372; c=relaxed/simple;
	bh=ZPi9K+smQv5qTQqT85z/NyNntS9Rwouv0nOUJ93vmiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rGnWxkHptC1fJPddDGOwVc/EROkp3wRRI1XPQJTv6PoAxH36hMnbAJA6EqpKTDpRYtlWsCuD+FxYEEXOrsnH+AgWbTxxRlH0a8b/N+3AXHLkO7mxOlHkatO+BsuauXVKURIANiawIOPQ3Hw4uvYYXGUH6TNTM6oraN+W+8hwM4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=DwsPWLH/; arc=none smtp.client-ip=173.37.142.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3813; q=dns/txt;
  s=iport01; t=1778685371; x=1779894971;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=kns4Mab/JliJKmkozoUpqJaxGVnLf8P8NwQOX4HNIqo=;
  b=DwsPWLH/yfC9CDKUql22RlvTaQx8OuuTnVt7MIUldUZ4j2yqH6KZoJc/
   xyfVAp+hOocCRSPXKDxPggGeQxqNrgLU5ZiEwkAdavt8DBHGk5s6/9rcC
   +YL9Sm8t3gqVZwNpz8JOE2pGZgYttXOzsFswuaf3lw1+a9JiDx/CPvdJ7
   uGiNmYhQxSTBGCNOsCiFFaFawJ6hgBNgDUtTgRzEpD5pIyyWI6B4jBZmC
   F9vXN9oTS8cmi9TznnA13X0Ayj/rC97HpNOOxUozkqpKBlAH6Cyr7RwzA
   sseIcYjxc2FdK0w4bvKAgI9eN+slWIAertnLQhhnb2bzTkjMK1XelLLAB
   Q==;
X-CSE-ConnectionGUID: mBIVidjRTMKE429n5hHE0Q==
X-CSE-MsgGUID: oPjuaCpgSY+ii/53IZpEEg==
X-IPAS-Result: =?us-ascii?q?A0BFAgCnlARq/5D/Ja1aHgEBCxIMggULgleBUENJhFePU?=
 =?us-ascii?q?4Ihnh2Bfw8BAQEPUQQBAYUGAo0yAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQsBA?=
 =?us-ascii?q?QUBAQECAQcFgQ4ThlyGWwIBAyMEUhAlAiYCAkYQBgESgwKCdAOzDHp/M4EBh?=
 =?us-ascii?q?H3ZRIFkAQsUAYEKLoVygmcBgXCEBjuEQCcbgUlEgRWDaIEZgwaDf4JpBIMcF?=
 =?us-ascii?q?I54CT+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSEhgVAhQvDwQWMh1wDCcSLBczW?=
 =?us-ascii?q?BsHBYFLggVyFDEEIYEChF94IywDToFDAwsYDUgRLDcGDhsEPQFuB4o/HQ+BP?=
 =?us-ascii?q?3FZNRSBKSM0k3IIFYNhjV1rgTWfWYQmgWSgDgEyl2aTBZkGIqQ3hGiBaDyBW?=
 =?us-ascii?q?TMaCBsVgyJTGQ+OKgMWzDsnMj8HAgcOApIEgWwBAQ?=
IronPort-Data: A9a23:jDNKS6lsSPESA72/SBrBtPfo5gxBJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIbD2iGOvyOY2b1eo9waYTnp0JVucPRm9dhSwJopXxjF1tH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/raf658SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+Za31GONgWYubDpJsvnb8XuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FYgy29h2DWN0y
 dk7BWxXPxbeh8KbmIvuH4GAhux7RCXqFJkUtnclyXTSCuwrBMicBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQTZj/7C7pm9AusrmL2bzxDqFGVjaE2+GPUigd21dABNfKKJoHSGpQJwhfwS
 mTu+Fz7HxgxLNOk+HmE8zXx3c79hQ7WV9dHfFG/3rsw6LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIjobU3/V6mUvHyWBq3pHPCtRkZM/JTDuczwAKA0KzZ50CeHGdsZjdHZMYrq4wwSCAm2
 0Ghm87vA3pksNW9UXuX+7GVhSm/NSgcMSkJYipsZQ8E5cTz5YI+lBTCSv59H6OvyN74Azf9x
 3aNtidWr7MekcIGyY2l8l3dxTGhvJ7ESkgy/Aq/Y46+xhlyaIjgY8mj7kLWqK4fao2YVVKG+
 nMDnqBy8dwzMH1ErwTVKM1lIV1jz6/t3OH06bK3I6Qcyg==
IronPort-HdrOrdr: A9a23:MaMnWai/QujXMdVVZ3aedVIl0XBQXiwji2hC6mlwRA09TyVXrb
 HLoB19737JYVcqNk3I9ursBEDtexnhHNtOkOss1NSZMzUOxlHJEGgK1+KLqAEIWReOldK1vp
 0NT0ERMqyUMXFKyev3/wW8Fc8t252k/LDAv5am815dCSxndK1k6R50EUKgEkNwTBRbHpZRLu
 v72iM+nUvGRV0nKuKmG3ICQ+/P4/fPlJ7gfFo6IiRP0nj3sdttg4SKaSRxGXwlIkhy/Ys=
X-Talos-CUID: =?us-ascii?q?9a23=3AGqpPBWpQTA9USgvHnJAmvEjmUcUPU0PcwHXqH2q?=
 =?us-ascii?q?bJDozGbvISX+9oJoxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AQvYbIwx9W8Z0h1AyENY9wFaj142aqKOWCl0Euo0?=
 =?us-ascii?q?JgPjHNC03Zmy8viyab4Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,232,1770595200"; 
   d="scan'208";a="745079449"
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
  by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 May 2026 15:16:03 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-07.cisco.com (Postfix) with ESMTPS id 6D7E9180004A6;
	Wed, 13 May 2026 15:16:02 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Wed, 13 May 2026 08:15:40 -0700
Subject: [PATCH net-next v7 03/10] enic: add admin RQ buffer management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-enic-sriov-v2-admin-channel-v2-v7-3-68b9f4141f4c@cisco.com>
References: <20260513-enic-sriov-v2-admin-channel-v2-v7-0-68b9f4141f4c@cisco.com>
In-Reply-To: <20260513-enic-sriov-v2-admin-channel-v2-v7-0-68b9f4141f4c@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778685359; l=3879;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=ZPi9K+smQv5qTQqT85z/NyNntS9Rwouv0nOUJ93vmiY=;
 b=1bmgFrhSXPiocbM2hQP52g4tXLjFFYL7ksd3FFxcHr/9fdlo8pLKmZyYfZtdfpjLk4Pk6lU1t
 os9WsvLRJm4DGGOhidTQsqfvhrms4jvVt7fvKLL3t0LUL84H/BkaU+W
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-07.cisco.com
X-Rspamd-Queue-Id: 38870536A18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287649-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:mid,cisco.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The admin receive queue needs pre-posted DMA buffers for incoming
mailbox messages from VFs. Each buffer is a kmalloc'd region mapped
for DMA (2048 bytes, sufficient for any MBOX message).

Add enic_admin_rq_fill(gfp) to post buffers at open time, and
enic_admin_rq_drain() to unmap and free them at close time.
Wire both into the admin channel open/close paths. The gfp_t
parameter allows GFP_KERNEL at open time and GFP_ATOMIC when
refilling from NAPI context (added in the next patch).

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_admin.c | 66 +++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index aa21868a9209..b28fc6c656cc 100644
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
@@ -186,6 +247,7 @@ int enic_admin_channel_open(struct enic *enic)
 		netdev_warn(enic->netdev, "Failed to disable admin WQ\n");
 	if (vnic_rq_disable(&enic->admin_rq))
 		netdev_warn(enic->netdev, "Failed to disable admin RQ\n");
+	enic_admin_rq_drain(enic);
 	enic_admin_free_resources(enic);
 	return err;
 }
@@ -209,7 +271,7 @@ void enic_admin_channel_close(struct enic *enic)
 			    "Failed to disable admin RQ: %d\n", err);
 
 	vnic_wq_clean(&enic->admin_wq, enic_admin_wq_buf_clean);
-	vnic_rq_clean(&enic->admin_rq, enic_admin_rq_buf_clean);
+	enic_admin_rq_drain(enic);
 	vnic_cq_clean(&enic->admin_cq[0]);
 	vnic_cq_clean(&enic->admin_cq[1]);
 	enic_admin_free_resources(enic);

-- 
2.43.0


