Return-Path: <netdev+bounces-283583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA1vE4ww92lbdQIAu9opvQ
	(envelope-from <netdev+bounces-283583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 13:25:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F5A4B542D
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 13:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 811B03009B2F
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D09313267;
	Sun,  3 May 2026 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="c6x8p1j0"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2115A25487C;
	Sun,  3 May 2026 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777807403; cv=none; b=SxSmo9tCtc0ol3N7D1Rkaek4lqoBZ4gHIeADrtV4SLIMgLe0Jzd/Ou/0g5f1lbNf5AmQXZ7vGQDlV6JiheOo0IikxX2HoJXdG7YbR1LLUL1hw22cEGMLRtE67RKsIYHieLcDljsov1TZ4OaojomtW/6LMl9DSDNk+RK/7muL3AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777807403; c=relaxed/simple;
	bh=whURRJxU0a7V8S0T7aAuNL/DTzxt+Nmk3HDi4L19IlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZDWsgYQ3vs020e64U56uY9q2EkqKfIqQ4LFqSeUtHKaDs53FkVY3RtArufrsy1HREamh0agSuBqWqOKSX5eOswxUoYdVJV1ubAaEnQk1Yu+zptjfzbB/L/GIPspq3cGSHtPbl4G5oGNzJ5A56nJEy5a1YWNm3JOZ+xROZTaGrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=c6x8p1j0; arc=none smtp.client-ip=173.37.142.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=9070; q=dns/txt;
  s=iport01; t=1777807401; x=1779017001;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=NtiLDbbYQdXvwPLn9P/TF+is/CjPXYfAuDYX1dZwcLU=;
  b=c6x8p1j0rG4zRLKFzWKf9yXatFgq2mKzUUce0NG6VO/ic4ru7Xh+AEF7
   71+rQM+hgzo1yo6w2JgG3GLOmKGUjAzXi7IcmhebFlG0zU8syvlUCcWsu
   CZcVHsVrmlqwKm/+V4i/zvSZ6dGp3bq/LnKE+M0P3J/9F+tGteeZG7XPE
   oMsiajB5DSpN85GBxgzdIKLKXUT2L/P1TPrmDS8qQ8GvlaPZ8BkalBouW
   k9tDq/7r2FpRw8fFbOlIrdZvbWwKSyfvPNQZhdaQdOml/1aJTf3m77A1p
   gDd2ruBRXfXKjS5+gXcrEgaAjzXzujTNW0CDT2R2SiH6CMfom81zEK1ks
   A==;
X-CSE-ConnectionGUID: +DW/7vbqRNy1ftqyyom+kQ==
X-CSE-MsgGUID: TfsN5muGQxSVn8pomjcfpQ==
X-IPAS-Result: =?us-ascii?q?A0AaAADHL/dp/4v/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBglaBT0NJhFeIHIc3giGeHRSBaw8BAQEPUQQBAYUGAo0xAiY0CQ4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4ZchlsCAQMjBFIQJ?=
 =?us-ascii?q?QImAgJGEAYBEoMCgnQDtB56fzOBAYR92UOBZAELFAGBCi4BhXGCZgGBcIQGO?=
 =?us-ascii?q?4Q/JxuBSUSBFAGDaIQFAQQVg3+CaQSDHBSBfo0dCT+BAhwDWSwBVRMNCgsHB?=
 =?us-ascii?q?WFSMwMgCgsSEhgVAhQvDwQWMh1wDCcSLBc0WBsHBYFLgwBtFDEEIYEFhGB4I?=
 =?us-ascii?q?ywDTnIDCxgNSBEsNwYOGwQ9AW4HimYdD4EoF3FZNQFNb4EhHCySYAiDdo1da?=
 =?us-ascii?q?4E1n1mEJoFkoA4BMpdmkwWZBiKjSW6EaIFoPIFZMxoIGxWDIlMZD44qAxbJX?=
 =?us-ascii?q?SYyPQEBBwIHDQMLgWiQABEXgVUBAQ?=
IronPort-Data: A9a23:G9SGmaisBUZUwtoQHYkhVVwFX161oBEKZh0ujC45NGQN5FlHY01je
 htvDTuPO6yJamqmLdtxPoS/pEoH7MLRnd4wTVM6ry5nESpjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOOn9SUgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZeEULOZ82QsaDxMtvrY8EoHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqVb1tkwXn9E7
 MY+OWkDcgmSluWzg7GCH7wEasQLdKEHPasFsX1miDWcBvE8TNWbGePB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWYQZ/5JEWxI9EglHkeiFZs1KWpYI84nPYy0p6172F3N/9JYfTGJsMxRnGz
 o7A11j3GTdHMcGw8Cq+zHT8nujKnyj1QLtHQdVU8dYv2jV/3Fc7BBQIWF6TrfCnh0u6XNxDb
 UoZ5kIGoKQv8UW5Q8XVUBq/r3qJ+BUbXrJ4EPAw4SmOx7DS7gLfAXILJhZIbtA8udB1QzE22
 lKXt9f0Azopu739YWqU/LqSrBuoNCQVJHNEbigBJSMB4t/+sMQwgwjJQ9JLDqG4lJv2FCv2z
 jTMqzIx750VgNIH2ruT41/KmXSvq4LPQwpz4R/YNl9J9Stjb4KjIojt4l/B4LMYdsCST0KKu
 z4PnM32AP0yMKxhXRelGI0ldIxFLd7fWNEAqTaDx6Ucygk=
IronPort-HdrOrdr: A9a23:cLH1eaoQ2lX8sOnWHUxLChQaV5rdeYIsimQD101hICG9vPbo8/
 xG+8576faUslgssR4b9OxoVJPrfZqYz+8W3WBzB9iftXfd2FdARbsKheDfKn/bak7DH4VmuZ
 uIHZIObeHYPBxWgdn35Q+gH81l4tWWmZrY/Nv2/jNBQR5nbqd44xw8MAaUFUVqWBJLbKBJcq
 Z0nvA3wAaISDAwctmxAGUDUqzoot3Gk4+jXDs9biRXkDVnSViTmcTH+9/y5GZkbw9y
X-Talos-CUID: =?us-ascii?q?9a23=3AVbSyNGuU3jti5NIuNv3y/Yty6ItmXkKak2naOnW?=
 =?us-ascii?q?eGD9nVKSEWFiVu6Bdxp8=3D?=
X-Talos-MUID: 9a23:y89CTApII/PtToXr8TEezw1sL+E15rmBMVA2r5NWo86BNyd+Iw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,213,1770595200"; 
   d="scan'208";a="731561376"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 May 2026 11:22:57 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPS id BC413180007D0;
	Sun,  3 May 2026 11:22:56 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Sun, 03 May 2026 04:22:39 -0700
Subject: [PATCH net-next v6 02/10] enic: add admin channel open and close
 for SR-IOV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-enic-sriov-v2-admin-channel-v2-v6-2-0af4fbc2d86d@cisco.com>
References: <20260503-enic-sriov-v2-admin-channel-v2-v6-0-0af4fbc2d86d@cisco.com>
In-Reply-To: <20260503-enic-sriov-v2-admin-channel-v2-v6-0-0af4fbc2d86d@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777807374; l=9322;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=whURRJxU0a7V8S0T7aAuNL/DTzxt+Nmk3HDi4L19IlA=;
 b=SGuZBHcp7YxalRWKHT1RLxe+cYKlCMg/ntszdrVueOupiipSBzBEH14hDC+WEFhqCU4b/WIDd
 w1VXMuM2fAOCoLx+iH4O3qlYVO1tuvPl/SQ62ZtB15rvPtDh2AIzYCW
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-02.cisco.com
X-Rspamd-Queue-Id: B6F5A4B542D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283583-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:dkim,cisco.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The V2 SR-IOV design uses a dedicated admin channel (WQ/RQ/CQ/INTR
on separate BAR resources) for PF-VF mailbox communication rather
than firmware-proxied devcmds.

Introduce enic_admin_channel_open() and enic_admin_channel_close().
Open allocates and initialises the admin WQ, RQ, two CQs (one per
direction) and one SR-IOV interrupt, then issues CMD_QP_TYPE_SET to
tell firmware the queues are admin-type. Close reverses the sequence.

enic_admin_wq_buf_clean() unmaps and frees any WQ buffers still held
at close time, fixing a DMA mapping leak when a send times out.

Add CMD_QP_TYPE_SET (97) and QP_TYPE_ADMIN/DATA defines to
vnic_devcmd.h.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/Makefile      |   3 +-
 drivers/net/ethernet/cisco/enic/enic_admin.c  | 207 ++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_admin.h  |  15 ++
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |   9 ++
 4 files changed, 233 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cisco/enic/Makefile b/drivers/net/ethernet/cisco/enic/Makefile
index a96b8332e6e2..7ae72fefc99a 100644
--- a/drivers/net/ethernet/cisco/enic/Makefile
+++ b/drivers/net/ethernet/cisco/enic/Makefile
@@ -3,5 +3,6 @@ obj-$(CONFIG_ENIC) := enic.o
 
 enic-y := enic_main.o vnic_cq.o vnic_intr.o vnic_wq.o \
 	enic_res.o enic_dev.o enic_pp.o vnic_dev.o vnic_rq.o vnic_vic.o \
-	enic_ethtool.o enic_api.o enic_clsf.o enic_rq.o enic_wq.o
+	enic_ethtool.o enic_api.o enic_clsf.o enic_rq.o enic_wq.o \
+	enic_admin.o
 
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
new file mode 100644
index 000000000000..18ca23eef216
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2025 Cisco Systems, Inc.  All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+
+#include "vnic_dev.h"
+#include "vnic_wq.h"
+#include "vnic_rq.h"
+#include "vnic_cq.h"
+#include "vnic_intr.h"
+#include "vnic_resource.h"
+#include "vnic_devcmd.h"
+#include "enic.h"
+#include "enic_admin.h"
+#include "cq_desc.h"
+#include "wq_enet_desc.h"
+#include "rq_enet_desc.h"
+
+/* Clean up any admin WQ buffers still held by hardware at close time.
+ * Normally buffers are freed inline after send completion, but a timed-out
+ * send intentionally leaves the buffer live until the queue is stopped.
+ */
+static void enic_admin_wq_buf_clean(struct vnic_wq *wq,
+				    struct vnic_wq_buf *buf)
+{
+	struct enic *enic = vnic_dev_priv(wq->vdev);
+
+	if (buf->os_buf) {
+		dma_unmap_single(&enic->pdev->dev, buf->dma_addr,
+				 buf->len, DMA_TO_DEVICE);
+		kfree(buf->os_buf);
+		buf->os_buf = NULL;
+	}
+}
+
+/* No-op: admin RQ buffer teardown is handled in enic_admin_channel_close */
+static void enic_admin_rq_buf_clean(struct vnic_rq *rq,
+				    struct vnic_rq_buf *buf)
+{
+}
+
+static int enic_admin_qp_type_set(struct enic *enic, u32 enable)
+{
+	u64 a0 = QP_TYPE_ADMIN, a1 = enable;
+	int wait = 1000;
+	int err;
+
+	spin_lock_bh(&enic->devcmd_lock);
+	err = vnic_dev_cmd(enic->vdev, CMD_QP_TYPE_SET, &a0, &a1, wait);
+	spin_unlock_bh(&enic->devcmd_lock);
+
+	return err;
+}
+
+static int enic_admin_alloc_resources(struct enic *enic)
+{
+	int err;
+
+	err = vnic_wq_alloc_with_type(enic->vdev, &enic->admin_wq, 0,
+				      ENIC_ADMIN_DESC_COUNT,
+				      sizeof(struct wq_enet_desc),
+				      RES_TYPE_ADMIN_WQ);
+	if (err)
+		return err;
+
+	err = vnic_rq_alloc_with_type(enic->vdev, &enic->admin_rq, 0,
+				      ENIC_ADMIN_DESC_COUNT,
+				      sizeof(struct rq_enet_desc),
+				      RES_TYPE_ADMIN_RQ);
+	if (err)
+		goto free_wq;
+
+	/* admin_cq[0] is the WQ completion queue.  WQ CQEs are always
+	 * 16 bytes wide; firmware always writes 16-byte CQEs for WQ
+	 * completions on every WQ, including the admin channel WQ.
+	 * Use sizeof(struct cq_desc) accordingly.
+	 */
+	err = vnic_cq_alloc_with_type(enic->vdev, &enic->admin_cq[0], 0,
+				      ENIC_ADMIN_DESC_COUNT,
+				      sizeof(struct cq_desc),
+				      RES_TYPE_ADMIN_CQ);
+	if (err)
+		goto free_rq;
+
+	/* admin_cq[1] is the RQ completion queue.  Its descriptor size
+	 * must match what firmware writes.  enic_ext_cq() called earlier
+	 * in probe issues CMD_CQ_ENTRY_SIZE_SET for VNIC_RQ_ALL,
+	 * programming firmware to write CQ entries of (16 << enic->ext_cq)
+	 * bytes for every RQ CQ on the vNIC, including the admin RQ CQ.
+	 * Allocating with the same size keeps the host poller and
+	 * firmware in lockstep:
+	 *
+	 *   - The color/valid bit lives at byte (desc_size - 1) of every
+	 *     cq_enet_rq_desc[_32|_64] variant, so enic_admin_cq_color()
+	 *     reads it from the correct offset.
+	 *   - Only the first 15 bytes of the descriptor (vlan,
+	 *     bytes_written_flags, ...) are accessed by the admin path;
+	 *     these fields are identical across all three variants (see
+	 *     comment in enic_rq.c above cq_enet_rq_desc_dec()).
+	 */
+	err = vnic_cq_alloc_with_type(enic->vdev, &enic->admin_cq[1], 1,
+				      ENIC_ADMIN_DESC_COUNT,
+				      16 << enic->ext_cq,
+				      RES_TYPE_ADMIN_CQ);
+	if (err)
+		goto free_cq0;
+
+	/* PFs have dedicated SRIOV_INTR resources for admin channel.
+	 * VFs lack SRIOV_INTR; use a regular INTR_CTRL slot instead.
+	 */
+	if (vnic_dev_get_res_count(enic->vdev, RES_TYPE_SRIOV_INTR) >= 1)
+		err = vnic_intr_alloc_with_type(enic->vdev,
+						&enic->admin_intr, 0,
+						RES_TYPE_SRIOV_INTR);
+	else
+		err = vnic_intr_alloc(enic->vdev, &enic->admin_intr,
+				      enic->intr_count);
+	if (err)
+		goto free_cq1;
+
+	return 0;
+
+free_cq1:
+	vnic_cq_free(&enic->admin_cq[1]);
+free_cq0:
+	vnic_cq_free(&enic->admin_cq[0]);
+free_rq:
+	vnic_rq_free(&enic->admin_rq);
+free_wq:
+	vnic_wq_free(&enic->admin_wq);
+	return err;
+}
+
+static void enic_admin_free_resources(struct enic *enic)
+{
+	vnic_intr_free(&enic->admin_intr);
+	vnic_cq_free(&enic->admin_cq[1]);
+	vnic_cq_free(&enic->admin_cq[0]);
+	vnic_rq_free(&enic->admin_rq);
+	vnic_wq_free(&enic->admin_wq);
+}
+
+static void enic_admin_init_resources(struct enic *enic)
+{
+	vnic_wq_init(&enic->admin_wq, 0, 0, 0);
+	vnic_rq_init(&enic->admin_rq, 1, 0, 0);
+	vnic_cq_init(&enic->admin_cq[0], 0, 1, 0, 0, 1, 0, 1, 0, 0, 0);
+	vnic_cq_init(&enic->admin_cq[1], 0, 1, 0, 0, 1, 0, 1, 0, 0, 0);
+	vnic_intr_init(&enic->admin_intr, 0, 0, 1);
+}
+
+int enic_admin_channel_open(struct enic *enic)
+{
+	int err;
+
+	if (!enic->has_admin_channel)
+		return -ENODEV;
+
+	err = enic_admin_alloc_resources(enic);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "Failed to alloc admin channel resources: %d\n",
+			   err);
+		return err;
+	}
+
+	enic_admin_init_resources(enic);
+
+	vnic_wq_enable(&enic->admin_wq);
+	vnic_rq_enable(&enic->admin_rq);
+
+	err = enic_admin_qp_type_set(enic, 1);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "Failed to set admin QP type: %d\n", err);
+		goto disable_queues;
+	}
+
+	return 0;
+
+disable_queues:
+	enic_admin_qp_type_set(enic, 0);
+	vnic_wq_disable(&enic->admin_wq);
+	vnic_rq_disable(&enic->admin_rq);
+	enic_admin_free_resources(enic);
+	return err;
+}
+
+void enic_admin_channel_close(struct enic *enic)
+{
+	if (!enic->has_admin_channel)
+		return;
+
+	enic_admin_qp_type_set(enic, 0);
+
+	vnic_wq_disable(&enic->admin_wq);
+	vnic_rq_disable(&enic->admin_rq);
+
+	vnic_wq_clean(&enic->admin_wq, enic_admin_wq_buf_clean);
+	vnic_rq_clean(&enic->admin_rq, enic_admin_rq_buf_clean);
+	vnic_cq_clean(&enic->admin_cq[0]);
+	vnic_cq_clean(&enic->admin_cq[1]);
+	vnic_intr_clean(&enic->admin_intr);
+
+	enic_admin_free_resources(enic);
+}
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.h b/drivers/net/ethernet/cisco/enic/enic_admin.h
new file mode 100644
index 000000000000..569aadeb9312
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright 2025 Cisco Systems, Inc.  All rights reserved. */
+
+#ifndef _ENIC_ADMIN_H_
+#define _ENIC_ADMIN_H_
+
+#define ENIC_ADMIN_DESC_COUNT	64
+#define ENIC_ADMIN_BUF_SIZE	2048
+
+struct enic;
+
+int enic_admin_channel_open(struct enic *enic);
+void enic_admin_channel_close(struct enic *enic);
+
+#endif /* _ENIC_ADMIN_H_ */
diff --git a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
index 7a4bce736105..a1c8f522c7d7 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
@@ -455,8 +455,17 @@ enum vnic_devcmd_cmd {
 	 */
 	CMD_CQ_ENTRY_SIZE_SET = _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 90),
 
+	/*
+	 * Set queue pair type (admin or data)
+	 * in: (u32) a0 = queue pair type (0 = admin, 1 = data)
+	 * in: (u32) a1 = enable (1) / disable (0)
+	 */
+	CMD_QP_TYPE_SET = _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 97),
 };
 
+#define QP_TYPE_ADMIN	0
+#define QP_TYPE_DATA	1
+
 /* CMD_ENABLE2 flags */
 #define CMD_ENABLE2_STANDBY 0x0
 #define CMD_ENABLE2_ACTIVE  0x1

-- 
2.43.0


