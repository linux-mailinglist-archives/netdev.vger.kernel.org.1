Return-Path: <netdev+bounces-300291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4ngwAsdPM2qL/QUAu9opvQ
	(envelope-from <netdev+bounces-300291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 03:54:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C8869D115
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 03:54:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=GS5nrvSS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300291-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300291-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8DBD30EB0EA
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 01:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2B32DB7BB;
	Thu, 18 Jun 2026 01:53:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A942DAFDE;
	Thu, 18 Jun 2026 01:53:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781747639; cv=none; b=DNfaZTAK2QvXtF6ivQzULvAiIXP/w2T1tmCgIWjARhu7S369dURzkFds+FLqaCNr/aDUTxExS05p+cip9OOQSWuVtwLJuUjLs2MG3+AmSsAV423gM9MWsgaLPZtlbCB9nifP35Qly9BitpQQdzqEAA4ldbsz4fhyFFbyMILF+Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781747639; c=relaxed/simple;
	bh=xo6LQQV4Ht0+WI+HafBPv5lKFZgvQiAhEoQ3DVnDaF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GOnPoLDxO3dCD7q+iE7sh82vVADiTKMvdwnkfcwe0BA7pqL41IDDCmjva0N1xsq2YkqAcl3YE6wbwyQJ0j/r46oaRYzaZzXo1/m4ZX8/4kxHzMykmNu3EsNXK/BWfRUtIltJFmCcNXjtHN1ZaF+wSOzs12sT+FxpgtIH2f7Xgaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=GS5nrvSS; arc=none smtp.client-ip=173.37.86.77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3920; q=dns/txt;
  s=iport01; t=1781747637; x=1782957237;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=7VA9ptIiRnwhz47lI+ZaUgqa++UrTIUUnU7FoKHGdnE=;
  b=GS5nrvSS6fbM0E4ICZIr7OFPOgZTA0lFR5JyHHkO5lIJR4uyBB+Ykqnk
   fnIocrRnUaYUMAItbBUPTraME0Ou8hzKnpYc4qBXVZHVtr2VTodxsA6qk
   OIVPEEeR5a1jfia6m0SlNF0cYkCZA9irRE5dPg3VhhGAFHAEyQ7+97G3Q
   7LVZd00X0q3wDZEWL8Zkg/DrWlPmRv4I48u4Vzmha79D0ea+a9QEWlrC/
   NWQ5O9+tARgF2ZLq+bn1vHnw7+GN8RlP2AuiioYBbXe+LZXR6vsWyPSqI
   pTZQeLakPuP5N3D8qX7ai6tTqs5UjXGRV9pVhn1UxlomskDfd5d7CZ067
   g==;
X-CSE-ConnectionGUID: jMp+Dc3sStqoVl5VmK9F7w==
X-CSE-MsgGUID: SrZQzPdkQ2W2SwtgYp6XzA==
X-IPAS-Result: =?us-ascii?q?A0BFAgBwTjNq/4r/Ja1aHgEBCxIMggULgleBUkNJhFePU?=
 =?us-ascii?q?4Ihnh6Bfg8BAQEPUQQBAYUGAo1EAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQsBA?=
 =?us-ascii?q?QUBAQECAQcFgQ4ThlyGWwIBAyMEUhAlAiYCAkYQBgESgwKCdAOyaXp/M4EBh?=
 =?us-ascii?q?H3ZRoFmAQsUAYEKLoVxgmoBgXCEBjuEQScbgUlEgRWDaYEZgwaDf4JqBIMcE?=
 =?us-ascii?q?pEnCT+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSEhgVAhQvDwQWMh1wDCcSLBc0W?=
 =?us-ascii?q?BsHBYEegScvBCGBA4UDIx8DOX+BbYElZ2YVMDWBAQERHwqBGwMLGA1IESw3B?=
 =?us-ascii?q?g4bBD0BbgeMeRcPgUxfEj0cNRSBKQ8UGRuBD5JjCBWDYY1fa4E1n1qEJ4Fmo?=
 =?us-ascii?q?A8BMpdnkwWZCCOkN4RogWg8gVkzGggbFYMiUxkPjioDFslhJzI/BwIHDwKSB?=
 =?us-ascii?q?IFsAQE?=
IronPort-Data: A9a23:rTmJ4aNPRz50O4jvrR1llsFynXyQoLVcMsEvi/4bfWQNrUoh1zwPy
 zBKUG+HMqnYMDancoolPojl9EhVuZHdyNZgS3M5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFTmE+kvF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WV/lV
 e/a+ZWFZgf7gmEsbgr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj6/dLFAIaNtYDwfpuBl9Kq
 MIdC2EjMQ/W0opawJrjIgVtrt4oIM+uOMYUvWttiGmAS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2M0PHwsYDUXUrsTIIk3gOazhnr/WzZZs1mS46Ew5gA/ySQtgea3a4qJJYTiqcN9pVyqn
 3D+82fAWC5AD8ODxgudrEK+r7qa9c/8cMdIfFGizdZmiUOew0QfAQMbUF+8r+X/jEOiM/pSJ
 1ER8zgjsYA980ukStS7VBq9yFaHoxQVc9ldCes37EeK0KW8yw+fCnIJUX1HZcAqudEeQSEs0
 BmCn7vBHTVlvbuUYWiQ+redsXW5Pi19BWsDYzIUCAgI+d/upKktgR/VCNVuCqi4ipvyAz6Y6
 zaHsCQzmZ0NgsMRkaa251bKh3SrvJehc+Iuzh/cUmTg6kZyY5SoItTxr1Pa9v1Hao2eSzFto
 UQ5piRX18hWZbnlqcBHaLxl8G2BjxpdDADhvA==
IronPort-HdrOrdr: A9a23:kE0GDq0dfY6VVip1ef5qkQqjBEQkLtp133Aq2lEZdPWaSL39qy
 nIppUmPH7P5gr5N0tMpTntAsO9qDbnhPxICOoqUotKIjOHhILAFugLhrcKgQeQeBEWndQw6U
 4PSdkaNPTASXV3ksr+5hC1CJIDzMnvytHQuc7ui1pgUg1ubbht9ENCCgidGlBrXwUuP+teKH
 Pl3LshmxOQPVIKc8+8Gn4JG8LHp9HNidbaRCRuPW9e1OFL5gnYkoIT1HOjr2wjbw8=
X-Talos-CUID: 9a23:UdVZGm8EYNQee+jVMuqVv0wxAoMJeSbG92vJJHG8VFhsa+y7FkDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3An+XzGA2wpxBK2EjxEtGjsH0XkTUj2L6cMVI1nZY?=
 =?us-ascii?q?/4fbeDjNsNAaF0gSla9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,210,1774310400"; 
   d="scan'208";a="496238470"
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Jun 2026 01:53:51 +0000
Received: from [127.0.0.1] (unknown [10.25.128.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id CC47B1800030F;
	Thu, 18 Jun 2026 01:53:50 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Wed, 17 Jun 2026 18:53:26 -0700
Subject: [PATCH net-next v9 03/10] enic: add admin RQ buffer management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-enic-sriov-v2-admin-channel-v2-v9-3-37f5f5af4c93@cisco.com>
References: <20260617-enic-sriov-v2-admin-channel-v2-v9-0-37f5f5af4c93@cisco.com>
In-Reply-To: <20260617-enic-sriov-v2-admin-channel-v2-v9-0-37f5f5af4c93@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781747628; l=3986;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=xo6LQQV4Ht0+WI+HafBPv5lKFZgvQiAhEoQ3DVnDaF0=;
 b=0OHQs0ihgdth2DRERjoXzZjVKiRBpf0ghsyCOdxy4J3CDtyyvZ8LTJHQBIqXegDQ7IwPI+uek
 kM18j9kgfgDCXSLfggr1yS3vBLC60pWdU8ad/tQoqRVebRX1cLDGCX9
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300291-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 72C8869D115

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


