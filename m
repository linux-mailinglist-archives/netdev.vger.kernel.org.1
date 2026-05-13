Return-Path: <netdev+bounces-287648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JYlI5OZBGqwLwIAu9opvQ
	(envelope-from <netdev+bounces-287648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:32:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C03536338
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A92B53059DDA
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C5F4C6F02;
	Wed, 13 May 2026 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="XnEvNzFC"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3A34C6EF3;
	Wed, 13 May 2026 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685370; cv=none; b=mTa/4tVB7CWVD8eqokdSu3AquxAVpcFCbkCcyVoFfk5ix+CrDij1TRdd0tg8CGS50H4x5O5qmMr/hmurgVoNMcv6tKwzJ6QGMEgtkcugf+L80dYi78t4Vu4IqEB//JEXa3YET421g/BJoFK2GjM/zmNvYhYYlYNzHGtS7N6flm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685370; c=relaxed/simple;
	bh=rahtvEHjyG03MHv75pkt847hFSWGTg6b86WsY5tEoN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fENBHZA5G0i4z3PKNq3xg4NY549EnP2fGNQ69tO8UkSJnvLiqW3qkx8uc4oYnQgDfSMZymvTwaIQIV584TKpC2i8Uik2FikXHktYXmfmjmIH1KpqjMQwG60nYhiwlbrWsMQdaVnFPwZ9wvGJFKqxyv9t0FVH3ZW7+Y8MHWNri1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=XnEvNzFC; arc=none smtp.client-ip=173.37.142.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=10537; q=dns/txt;
  s=iport01; t=1778685368; x=1779894968;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=nNzaRjGD90Dx0TuiJhJgbREnHiKYrYEuLUFfOl2vkXM=;
  b=XnEvNzFCwtQUv2m+Oqa3CM7nidm0UTqrw+CImZTEovdkHEWuF4Yi5QM+
   US900nQWy+5sIVp+TS9l4B1pLA996Uo/O29aE7tokJlkvE+FebXbdDN6h
   dbaPqcMT9O5sOREDSNN1+OKloxEfW0bsHCOgiIofFkL8SpxSuiuGxDMPm
   ayo08m41josOHkEgVLLd0mLM27WhuTgVg49xChgARVWfw4spjCPK3TapF
   TnC6KYUuTXx+66nqMHGbgPT33W8jplUSiiyLB7qWvfhgl1iXWKBB0G849
   mI9HW1D0UqcEgkOaVThZ4/GZkLZ+rhQMQCNwy9427fB4JcRR0BTJmSoAT
   A==;
X-CSE-ConnectionGUID: 8IzwCOh4Qh+IHqWf2XRmAg==
X-CSE-MsgGUID: GIxp4UGuTSmmwWOPEMFbWQ==
X-IPAS-Result: =?us-ascii?q?A0BFAgCnlARq/5D/Ja1aHgEBCxIMggULgleBUENJhFePU?=
 =?us-ascii?q?4Ihnh0UgWsPAQEBD1EEAQGFBgKNMgImNAkOAQIEAwIDAQEBAQEBAQEBAQELA?=
 =?us-ascii?q?QEFAQEBAgEHBYEOE4ZchlsCAQMjBFIQJQImAgJGEAYBEoMCgnQDswx6fzOBA?=
 =?us-ascii?q?YR92USBZAELFAGBCi6FcoJnAYFwhAY7hEAnG4FJRIEUAYNohAUBBBWDf4JpB?=
 =?us-ascii?q?IMcFIF7jH0JP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCFC8PBBYyHXAMJ?=
 =?us-ascii?q?xIsFzNYGwcFgUuCBXIUMQQhgQKEX3gjLANOgUMDCxgNSBEsNwYOGwQ9AW4Hi?=
 =?us-ascii?q?j8dD4EoF3FZNQFNb4EhHCySYAiDdo1da4E1n1mEJoFkoA4BMpdmkwWZBiKjS?=
 =?us-ascii?q?W6EaIFoPIFZMxoIGxWDIlMZD44qAxbMOycyPQEBBwIHDQMLgWiQABEXgVUBA?=
 =?us-ascii?q?Q?=
IronPort-Data: A9a23:glWXraDvDyz2rBVW/+niw5YqxClBgxIJ4kV8jS/XYbTApGkghWYCz
 WpKCzrSaareNjGmetknOY6yoEhV68DXmNNhOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZvCCeA+n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jWGthh
 fuo+5eBYAL8gGYtWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEk9R8E2oRPdEh+qVWIXhx+
 6YoEjUkYUXW7w626OrTpuhEnM8vKozveYgYoHwllW6fBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGYzBPjDS0Un1lM/E5sinfyohXnXeDxDo1XTrq0yi4TW5FMtjeCyYYaJIrRmQ+16v1aA+
 l/p4ljCBxQFC/un5B+r+E2V07qncSTTHdh6+KeD3vJjnlCW7mAaFhATUVy1vb+/h1LWc99TN
 kkd6Ccyhac180OvQ5/2WBjQiH2ZtBc0WNdKFeA+rgaXxcL86gCVHGUbDThMdNArqucyWDosk
 FSJ9/vxDDZitry9U3+R9r6I6zi1PEA9KW4EeD9BTgYf5dTniJ88gwiJTdt5FqOxyNrvFlnYx
 T2WoCUgr6scgNRN1Kih+13DxTW2qfD0ohUd/A7bWCehqwh+foPgP9Pu4lnA5vEGJ4GcJrWcg
 EU5dwGlxLhmJfmweOalGY3hwJnBCy65DQDh
IronPort-HdrOrdr: A9a23:gVBHJ629gnPbRHJcyarwDQqjBEQkLtp133Aq2lEZdPWaSL39qy
 nIppUmPH7P5gr5N0tMpTntAsO9qDbnhPxICOoqUotKIjOHhILAFugLhrcKgQeQeBEWndQw6U
 4PSdkaNPTASXV3ksr+5hC1CJIDzMnvytHQuc7ui1pgUg1ubbht9ENCCgidGlBrXwUuP+teKH
 Pl3LshmxOQPVIKc8+8Gn4JG8LHp9HNidbaRCRuPW9e1OFL5gnYkoIT1HOjr2wjbw8=
X-Talos-CUID: =?us-ascii?q?9a23=3A7QrvqmqIEA5V9rzYTs4r9gfmUZAEYGL263eMGk/?=
 =?us-ascii?q?7KEZwd7PPeWWV0awxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A9I5HYw4qt+g5xiaIi0iXNeg0xoxHwrS2VH0ijKk?=
 =?us-ascii?q?9vsybCgtIFhKzhguOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,232,1770595200"; 
   d="scan'208";a="745079440"
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
  by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 May 2026 15:16:02 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-07.cisco.com (Postfix) with ESMTPS id B00821800048F;
	Wed, 13 May 2026 15:16:01 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Wed, 13 May 2026 08:15:39 -0700
Subject: [PATCH net-next v7 02/10] enic: add admin channel open and close
 for SR-IOV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-enic-sriov-v2-admin-channel-v2-v7-2-68b9f4141f4c@cisco.com>
References: <20260513-enic-sriov-v2-admin-channel-v2-v7-0-68b9f4141f4c@cisco.com>
In-Reply-To: <20260513-enic-sriov-v2-admin-channel-v2-v7-0-68b9f4141f4c@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778685359; l=10910;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=rahtvEHjyG03MHv75pkt847hFSWGTg6b86WsY5tEoN4=;
 b=ME8rQ2c+srl9V1pEoTWkLaQ00kbO0oYK0uThDp+/BSgI8ORbc8vb1AIqX8MN1F8X+mbHgnJzK
 oIZq0SjQSfOCANOGFqMcdLI71WXtsik1fr4wEigDs7XYLHIS8nxBzc6
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-07.cisco.com
X-Rspamd-Queue-Id: 94C03536338
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287648-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cisco.com:email,cisco.com:mid,cisco.com:dkim]
X-Rspamd-Action: no action

The V2 SR-IOV design uses a dedicated admin channel (WQ/RQ/CQ/INTR
on separate BAR resources) for PF-VF mailbox communication rather
than firmware-proxied devcmds.

Introduce enic_admin_channel_open() and enic_admin_channel_close().
Open allocates and initialises the admin WQ, RQ, and two CQs (one per
direction), then issues CMD_QP_TYPE_SET to tell firmware the queues are
admin-type. Close reverses the sequence.

enic_admin_wq_buf_clean() unmaps and frees any WQ buffers still held
at close time, fixing a DMA mapping leak when a send times out.

Add CMD_QP_TYPE_SET (97), QP_TYPE_ADMIN/DATA, and QP_ENABLE/QP_DISABLE
defines to vnic_devcmd.h. Add VNIC_CQ_* named constants to vnic_cq.h
so CQ initialisation parameters are self-documenting from their first
introduction.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/Makefile      |   3 +-
 drivers/net/ethernet/cisco/enic/enic_admin.c  | 216 ++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_admin.h  |  15 ++
 drivers/net/ethernet/cisco/enic/vnic_cq.h     |   9 ++
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  11 ++
 5 files changed, 253 insertions(+), 1 deletion(-)

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
index 000000000000..aa21868a9209
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -0,0 +1,216 @@
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
+	return 0;
+
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
+	vnic_cq_free(&enic->admin_cq[1]);
+	vnic_cq_free(&enic->admin_cq[0]);
+	vnic_rq_free(&enic->admin_rq);
+	vnic_wq_free(&enic->admin_wq);
+}
+
+static void enic_admin_init_resources(struct enic *enic)
+{
+	vnic_wq_init(&enic->admin_wq,
+		     0, 0, 0); /* cq_index, err_intr_enable, err_intr_offset */
+	vnic_rq_init(&enic->admin_rq,
+		     1, 0, 0); /* cq_index, err_intr_enable, err_intr_offset */
+	vnic_cq_init(&enic->admin_cq[0],
+		     VNIC_CQ_FC_DISABLE,
+		     VNIC_CQ_COLOR_ENABLE,
+		     0, 0, 1, /* cq_head, cq_tail, cq_tail_color */
+		     VNIC_CQ_INTR_DISABLE,
+		     VNIC_CQ_ENTRY_ENABLE,
+		     VNIC_CQ_MSG_DISABLE,
+		     0, /* interrupt_offset */
+		     0 /* cq_message_addr */);
+	vnic_cq_init(&enic->admin_cq[1],
+		     VNIC_CQ_FC_DISABLE,
+		     VNIC_CQ_COLOR_ENABLE,
+		     0, 0, 1, /* cq_head, cq_tail, cq_tail_color */
+		     VNIC_CQ_INTR_DISABLE,
+		     VNIC_CQ_ENTRY_ENABLE,
+		     VNIC_CQ_MSG_DISABLE,
+		     0, /* interrupt_offset */
+		     0 /* cq_message_addr */);
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
+	err = enic_admin_qp_type_set(enic, QP_ENABLE);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "Failed to set admin QP type: %d\n", err);
+		goto disable_queues;
+	}
+
+	return 0;
+
+disable_queues:
+	enic_admin_qp_type_set(enic, QP_DISABLE);
+	if (vnic_wq_disable(&enic->admin_wq))
+		netdev_warn(enic->netdev, "Failed to disable admin WQ\n");
+	if (vnic_rq_disable(&enic->admin_rq))
+		netdev_warn(enic->netdev, "Failed to disable admin RQ\n");
+	enic_admin_free_resources(enic);
+	return err;
+}
+
+void enic_admin_channel_close(struct enic *enic)
+{
+	int err;
+
+	if (!enic->has_admin_channel)
+		return;
+
+	enic_admin_qp_type_set(enic, QP_DISABLE);
+
+	err = vnic_wq_disable(&enic->admin_wq);
+	if (err)
+		netdev_warn(enic->netdev,
+			    "Failed to disable admin WQ: %d\n", err);
+	err = vnic_rq_disable(&enic->admin_rq);
+	if (err)
+		netdev_warn(enic->netdev,
+			    "Failed to disable admin RQ: %d\n", err);
+
+	vnic_wq_clean(&enic->admin_wq, enic_admin_wq_buf_clean);
+	vnic_rq_clean(&enic->admin_rq, enic_admin_rq_buf_clean);
+	vnic_cq_clean(&enic->admin_cq[0]);
+	vnic_cq_clean(&enic->admin_cq[1]);
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
diff --git a/drivers/net/ethernet/cisco/enic/vnic_cq.h b/drivers/net/ethernet/cisco/enic/vnic_cq.h
index d46d4d2ef6bb..35ffa3230713 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_cq.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_cq.h
@@ -76,6 +76,15 @@ int vnic_cq_alloc(struct vnic_dev *vdev, struct vnic_cq *cq, unsigned int index,
 int vnic_cq_alloc_with_type(struct vnic_dev *vdev, struct vnic_cq *cq,
 			    unsigned int index, unsigned int desc_count,
 			    unsigned int desc_size, unsigned int res_type);
+#define VNIC_CQ_FC_ENABLE	1
+#define VNIC_CQ_FC_DISABLE	0
+#define VNIC_CQ_COLOR_ENABLE	1
+#define VNIC_CQ_INTR_ENABLE	1
+#define VNIC_CQ_INTR_DISABLE	0
+#define VNIC_CQ_ENTRY_ENABLE	1
+#define VNIC_CQ_MSG_ENABLE	1
+#define VNIC_CQ_MSG_DISABLE	0
+
 void vnic_cq_init(struct vnic_cq *cq, unsigned int flow_control_enable,
 	unsigned int color_enable, unsigned int cq_head, unsigned int cq_tail,
 	unsigned int cq_tail_color, unsigned int interrupt_enable,
diff --git a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
index 7a4bce736105..47b3f1c754cf 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
@@ -455,8 +455,19 @@ enum vnic_devcmd_cmd {
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
+#define QP_ENABLE	1
+#define QP_DISABLE	0
+
 /* CMD_ENABLE2 flags */
 #define CMD_ENABLE2_STANDBY 0x0
 #define CMD_ENABLE2_ACTIVE  0x1

-- 
2.43.0


