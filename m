Return-Path: <netdev+bounces-297172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7ur6CldEKGpUBQMAu9opvQ
	(envelope-from <netdev+bounces-297172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:50:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E236629C3
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:50:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=WVHUvEZP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297172-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297172-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22F343129FE8
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7B84BCABE;
	Tue,  9 Jun 2026 16:32:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B674BC020;
	Tue,  9 Jun 2026 16:32:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022776; cv=none; b=HF4zEUphE/9+WSsDjlBszW2OsO03hQYH9vrWkOfWTmj8fk1UN1kdwdNsRUzMGb0mMSO/DeYRXxbW5oNaB9lBmrR6Qjx2iZ/DmFxE1Er/b8IqukbgonvF54X4+8MLygSDLYtIIo8dI21Csc/wK26f9HSV/yNiRYvVWbSz5Tc822s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022776; c=relaxed/simple;
	bh=ZPi9K+smQv5qTQqT85z/NyNntS9Rwouv0nOUJ93vmiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=er/fjxwn3s+uM0+aEf6VDMaU968n2G0vIbz3f9MK0tOaWdr35qK3rK2buokJL1hlTL9/XQrvDcYhwtltx0i3hSv6W2niqPJTWulBP3W06lbVWNocITRsP2sA3OfXrjDxAVbcsCB2GkiX3Sw/OqK+zxvnM0tcva5BN1EB0vX3KfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=WVHUvEZP; arc=none smtp.client-ip=173.37.86.75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3813; q=dns/txt;
  s=iport01; t=1781022775; x=1782232375;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=kns4Mab/JliJKmkozoUpqJaxGVnLf8P8NwQOX4HNIqo=;
  b=WVHUvEZP/SY4XdAG31LMSN5CQxt2A6CTyMo5j/rhNKf9bhzM5FGlMedz
   dGJAcLOSDElQpH3WybjcZi5ltPI2RfGp19oAAAk+LX5tKBiL/Beb6zKt7
   JjZh7lK7j+lqLZhs1GLPubYJupX5CpCQrx2McvYSlW1NxheBqGRyJ2B/I
   pL2itp5Xl86icO0HR+qv7ue6+N34pMYWIXa1t+gcaTpN1oiwPbjMNYaiT
   0G2RPrBfiyNFoMtDWrSUthY5EaTM9uLFjwD1DhBv7ZF8Dyw3YoGqlM8QH
   eUjsIxgKmYPftFU+riRmL3KWmhzRD1fC8w9OcJ/fwdz2yQQeU+L0S9B6K
   Q==;
X-CSE-ConnectionGUID: oBhW94dNQ0Kz8wT0MslEbg==
X-CSE-MsgGUID: lWaMohr/R9ysxPwwBmLNAQ==
X-IPAS-Result: =?us-ascii?q?A0AaAAAaPyhq/4//Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBglaBUkNJhFeIHIc3giGeHoF+DwEBAQ9RBAEBhQYCjTcCJjQJDgECB?=
 =?us-ascii?q?AMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGXIZbAgEDIwRSECUCJgICR?=
 =?us-ascii?q?hAGARKDAoJ0A7Ugen8zgQGEfdlFgWYBCxQBgQouAYVwgmkBgXCEBjuEQScbg?=
 =?us-ascii?q?UlEgRWDaIEZgwaDf4JqBIMcEpBnCT+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSE?=
 =?us-ascii?q?hgVAhQvDwQWMh1wDCcSLBc0WBsHBYFKgTsUMQQhgQWFEiMfAzmBFYF8gShna?=
 =?us-ascii?q?RUxNU0DCxgNSBEsNwYOGwQ9AW4HjDoXD4FIcVk1FIEpIzSTcggVg2GNX2uBN?=
 =?us-ascii?q?Z9ZhCaBZqAPATKXZ5MEmQYipDaEaIFoPIFZMxoIGxWDIlMZD44qAxbLficyP?=
 =?us-ascii?q?wcCBw8CkgSBbAEB?=
IronPort-Data: A9a23:ILwPGqsynpKHr88pBcEJlFZeYefnVJZfMUV32f8akzHdYApBsoF/q
 tZmKW2DM/qNZ2DxL9B2aISx9BgCvp+GyNU3S1BlqS89F3sRgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav666yEgiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuFZDdJ5xYuajhKs/zb+Us21BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIw/cx3PjAS+
 dohcBMfPg+/38etxJ+xRbw57igjBJGD0II3oHpsy3TdSP0hW52GG/uM7t5D1zB2jcdLdRrcT
 5NGMnw0M1KaPkAJYwtMYH49tL/Aan3XaDREqUmVpqof6GnIxws327/oWDbQUoDbH5wPzx/D+
 Qoq+Uz9PRg/M9yFjgDU42m8vvDQtybffqsrQejQGvlCxQf7KnYoIBEfS1a+ifWwlEO7X9VRN
 woS9zZGhaU+6UmiXNThdxK/p3GAs1gXXN84O+4n4gilyafO5QudQG8eQVZpYdoqrsIpBjony
 lOEgfvtGDpp9raVIVqF/72ZqzKaIyUZLWYeIyQDSGMt59jlvZF2jR/VSNtnOLC6g8ezGjzqx
 T2O6i8kiN07i8MX26il1U7IjijqpZXTSAMxoALNUQqYAhhRfoWpYcmsrFPc9/sFdNjfRViat
 39CkM+bhAwTMayweOW2aL1lNNmUCzytaVUwXXYH80EdygmQ
IronPort-HdrOrdr: A9a23:dXaU7qMMWCHGIsBcTjejsMiBIKoaSvp037Dk7TEUdfUzSK2lfq
 GV8sjzuiWYtN98YhsdcJW7Scu9qBDnmqKdn7NwAV7KZmCP01dAbrsSjrcKqAeNJ8SRzJ856Y
 5QN4VzF9H0C0F3loLZ7BnQKadY/PC3tI2lmuvayW5gVkVRa69m5xpkEQrzKDwReOA/P+tfKL
 OsouxaujGnZXMbKu6/BnUDQqz/guejruOfXfbDbCRXkjVnSliTmcXHLyQ=
X-Talos-CUID: =?us-ascii?q?9a23=3AW6taw2gkwp/0YKu6rrcVwuV25jJudVfd8yaML2m?=
 =?us-ascii?q?BUUV7GKKpEXqL/I5unJ87?=
X-Talos-MUID: 9a23:n717PgW5cjdXdw3q/DvTjRRlNN0v2fW/E1A1joosvu2iHBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,196,1774310400"; 
   d="scan'208";a="492129137"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 09 Jun 2026 16:32:49 +0000
Received: from [127.0.0.1] (unknown [10.25.128.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id 9BC0018000268;
	Tue,  9 Jun 2026 16:32:48 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Tue, 09 Jun 2026 09:32:29 -0700
Subject: [PATCH net-next v8 03/10] enic: add admin RQ buffer management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-enic-sriov-v2-admin-channel-v2-v8-3-8ad8babbb826@cisco.com>
References: <20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com>
In-Reply-To: <20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781022766; l=3879;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=ZPi9K+smQv5qTQqT85z/NyNntS9Rwouv0nOUJ93vmiY=;
 b=hO0ymRDEV9Y6Z+YEoED0rfumDiaPIupOPXB4iyErk5VaHY9dPFcSUMYjilCy3KANzETSqmLUB
 FrLWo8XafNhA6ki8vyKKCFvQk1ZgoRWMYDKgOrYhCsp7kYX7rEmMnuj
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.186];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.186, [10.25.128.186]
X-Outbound-Node: rcdn-l-core-06.cisco.com
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
	TAGGED_FROM(0.00)[bounces-297172-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90E236629C3

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


