Return-Path: <netdev+bounces-280797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MpFKm1N6mkhxgIAu9opvQ
	(envelope-from <netdev+bounces-280797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:48:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9953845518A
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 218983032F6F
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5687C38229F;
	Thu, 23 Apr 2026 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="EIFNvRET"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782333590AE;
	Thu, 23 Apr 2026 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961813; cv=none; b=S8Nf10kOy7N9Y6NnMHHDNw+84qCVrOgltJWAFwF2gSfmbwUprvcID6gqVC5d4z16eCMFijXUphaU4O602GwmDVQQhqe5ducVWLybosUZyf60kXWUx1UEVdHb35/pB75z8XAkojiTuwBcF0BYQnRi3r/mZkXFroMBbtn7QY21t5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961813; c=relaxed/simple;
	bh=4snTvNDTFctwNaanim5qhFqEho3/iG5kKLIInaCFbOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ldxKBXex7meFu7u95D2HCkmoZFGwoCY6BNxHcXic8YPPzsH0BnddtCJAB5lppIs6nXcAfq+OVSuzbYs3FlMLkRknjBIeNuRv5ZqtOtaiTpAmTR1i5HhBvfgaphPpOVr6nXSbOEtiurxMoz0ixSA1n45pGTJZd+jLUvDHxIyLh4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=EIFNvRET; arc=none smtp.client-ip=173.37.142.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3582; q=dns/txt;
  s=iport01; t=1776961811; x=1778171411;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=yOd99C02HCfv6xc441zXMqGrOo5haJdo0vCAYX9IyQQ=;
  b=EIFNvRETnlAhlA9RyfDrCrY+7+Ha5nnJnMWEOvVIRfcZIkhBwDoWmbWR
   RUhTB8r0O3IwbyQhIN967xeXc4+v1PgZZa92Y4zo9CkyIumEgSYcxmdOU
   gOw9kaLihSsGFn7Qpf5jhyru1o1N8o71UOVtpt1tVHu4ChCkUHBStRhw1
   8+cDPDb6+8hr4W/cIZCzIh3kMRJQ0Bf9DEcZu3yLPTkTRByIJ+WQBJGuF
   tJfenl9aWPh/iwEYWxa948J2Fl9SsaRAjsRUT3rPYT6SxQzLdl87xcACX
   1QjTYoJKV42pCYA73I+mG+LAVIGDemu2OWqinBQn9tFJFJ4oFfUD6EDDA
   A==;
X-CSE-ConnectionGUID: A0UGU7J+RvO1HMK0FXBZmA==
X-CSE-MsgGUID: 9TLaDjtWRziKrt7nQ+6jlg==
X-IPAS-Result: =?us-ascii?q?A0AnAAAkSOpp/4//Ja1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?laBT0NJhFeIHIc3giGeHYF/DwEBAQ9RBAEBhQYCjSwCJjQJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThlyGWwIBAyMEUhAlAiYCAkYQB?=
 =?us-ascii?q?gESgwKCdAOzUXp/M4EBhH3ZQoFkAQsUAYEKLgGFcYJmAYFwhAY7hD8nG4FJR?=
 =?us-ascii?q?IEVg2iBGYMGg3+CaQSDHBSPHgk/gQIcA1ksAVUTDQoLBwVhUjMDIAoLEhIYF?=
 =?us-ascii?q?QIULw8EFjIdcAwnEiwXNFgbBwWBS4QJbRQxBCGBC4MqgTaBAQMLGA1IESw3B?=
 =?us-ascii?q?g4bBD0BbgeKNiAPgTlxgQ4UgSkjNJNyCBWDYY1da4E1n1mEJoFkoA4BMpdmk?=
 =?us-ascii?q?wWZBiKkN4RogWg8gVkzGggbFYMiUxkPjioDFskOJjI/BwIHDgKSBIFsAQE?=
IronPort-Data: A9a23:gk4CWqtn2NA1FqtKrIfXR3FqjefnVJZfMUV32f8akzHdYApBsoF/q
 tZmKWqCbKrbMGajKIgnbIW+9hlVsJ7WydZgHARs/H1jQiISgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav666yEgiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuFYzdJ5xYuajhKs/7Z80s01BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIw075KLlwR1
 78iNhdUTjWg38yG6oC+Y7w57igjBJGD0II3oHpsy3TdSP0hW52GG/uM7t5D1zB2jcdLdRrcT
 5NGMnw0M1KaPkAJYwtMYH49tL/Aan3XaDREqUmVpqof6GnIxws327/oWDbQUoPQGJ0LxxfG/
 Qoq+UyoPjUTGN6D9gCX81G2mrDJpGClWoYdQejQGvlCxQf7KnYoIBEfS1a+ifWwlEO7X9VRN
 woS9zZGhaU+6UmiXNThdxK/p3GAs1gXXN84O+4n4gilyafO5QudQG8eQVZpYdoqrsIpBjony
 lOEgfvtGDpp9raVIVqF/72ZqzKaIyUZLWYeIyQDSGMt59jlvZF2jR/VSNtnOLC6g8ezGjzqx
 T2O6i8kiN07i8MX26il1U7IjijqpZXTSAMxoALNUQqYAhhRfoWpYcmsrFPc9/sFdNjfRViat
 39CkM+bhAwTMayweOW2aL1lNNmUCzytaVUwXXYH80EdygmQ
IronPort-HdrOrdr: A9a23:xjw+964zIejEb6fvFAPXwD7XdLJyesId70hD6qm+c20wTiX+ra
 GTdZUguyMc5wx9ZJhNo7q90ey7MBHhHP1OjrX5Q43DYOCOggLBR72Kr7GSoAEIcBeTygcy79
 YET4FOTPD9ElR+i9/3+02bH8ZI+qj/zImYwcrT0HtpSxhncOVb7wl/AhuGCUEefnghOXNALu
 v62uN34xy9ZH8QcsO3QlMBX+TFupn3saiOW29/O/bigzP+9w9BL9XBYmOl4is=
X-Talos-CUID: =?us-ascii?q?9a23=3ASZUi9GquLMn8Qi07NrcshSjmUel9T1Lgk1WTGVG?=
 =?us-ascii?q?fUEZMa+W7eXWi/Yoxxg=3D=3D?=
X-Talos-MUID: 9a23:C/ntxAiWxFYWovrD4R1W/MMpZftM6oisFH83g5QlodXbMxUzZTWZg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,195,1770595200"; 
   d="scan'208";a="725061963"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Apr 2026 16:29:04 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id 9C54A18000483;
	Thu, 23 Apr 2026 16:29:03 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Thu, 23 Apr 2026 09:28:04 -0700
Subject: [PATCH net-next v5 03/10] enic: add admin RQ buffer management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-enic-sriov-v2-admin-channel-v2-v5-3-caa9f504a3dc@cisco.com>
References: <20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com>
In-Reply-To: <20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776961741; l=3640;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=4snTvNDTFctwNaanim5qhFqEho3/iG5kKLIInaCFbOg=;
 b=yIpM3C+ifEf4jNqBxglhghmd68ywH7WbZ/3cHY9S3kXcok2GElz1tAK8au9SvmvazL3k65Zwh
 eENkwc5Y9MRBtVtRAxYexEcES27kKjVj6RhSktH1hJrEPEErf1Ppg0C
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-06.cisco.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280797-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cisco.com:email,cisco.com:dkim,cisco.com:mid]
X-Rspamd-Queue-Id: 9953845518A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The admin receive queue needs pre-posted DMA buffers for incoming
mailbox messages from VFs. Each buffer is a kmalloc'd region mapped
for DMA (2048 bytes, sufficient for any MBOX message).

Add enic_admin_rq_fill() to post buffers at open time, and
enic_admin_rq_drain() to unmap and free them at close time.
Wire both into the admin channel open/close paths.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_admin.c | 66 +++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index afb50aa413f4..67b2a5d52b1d 100644
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
+static int enic_admin_rq_post_one(struct enic *enic)
+{
+	struct vnic_rq *rq = &enic->admin_rq;
+	struct rq_enet_desc *desc;
+	dma_addr_t dma_addr;
+	void *buf;
+
+	buf = kmalloc(ENIC_ADMIN_BUF_SIZE, GFP_KERNEL);
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
+static int enic_admin_rq_fill(struct enic *enic)
+{
+	struct vnic_rq *rq = &enic->admin_rq;
+	int err;
+
+	while (vnic_rq_desc_avail(rq) > 0) {
+		err = enic_admin_rq_post_one(enic);
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
@@ -149,6 +203,13 @@ int enic_admin_channel_open(struct enic *enic)
 	vnic_wq_enable(&enic->admin_wq);
 	vnic_rq_enable(&enic->admin_rq);
 
+	err = enic_admin_rq_fill(enic);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "Failed to fill admin RQ buffers: %d\n", err);
+		goto disable_queues;
+	}
+
 	err = enic_admin_qp_type_set(enic, 1);
 	if (err) {
 		netdev_err(enic->netdev,
@@ -162,6 +223,7 @@ int enic_admin_channel_open(struct enic *enic)
 	enic_admin_qp_type_set(enic, 0);
 	vnic_wq_disable(&enic->admin_wq);
 	vnic_rq_disable(&enic->admin_rq);
+	enic_admin_rq_drain(enic);
 	enic_admin_free_resources(enic);
 	return err;
 }
@@ -177,7 +239,7 @@ void enic_admin_channel_close(struct enic *enic)
 	vnic_rq_disable(&enic->admin_rq);
 
 	vnic_wq_clean(&enic->admin_wq, enic_admin_wq_buf_clean);
-	vnic_rq_clean(&enic->admin_rq, enic_admin_rq_buf_clean);
+	enic_admin_rq_drain(enic);
 	vnic_cq_clean(&enic->admin_cq[0]);
 	vnic_cq_clean(&enic->admin_cq[1]);
 	vnic_intr_clean(&enic->admin_intr);

-- 
2.43.0


