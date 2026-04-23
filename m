Return-Path: <netdev+bounces-280802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJc/J9hJ6mkhxgIAu9opvQ
	(envelope-from <netdev+bounces-280802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:33:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87447454F08
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E000C302708A
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC624390CB5;
	Thu, 23 Apr 2026 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="jfc7vLXt"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DEA384235;
	Thu, 23 Apr 2026 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961815; cv=none; b=BY5jmClf00gE4HqDuUF05sad5+z5zxwfPymu2sNaRQrSUJ3rFRb2f9o0ooJJWGxtPtY108aMh7JVhTyiLcrHMvkmmxxahBsH0nJsnF1m4T7ZSfY7GgaP7lTnsEVH1t7lWfZq7l//YApb61L1ViOa+cCXWWJTw1Uc7ZEsNtoGEmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961815; c=relaxed/simple;
	bh=qlhfeksZz+XKX74y86PMSctRMUhiqOEZnpCahTINQR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=susBgfK/WGH51kRLm+P0AqF5ybiJpk6oZWnv0UK69oEws6vyJSF0bKyWlnL/zXa15LZWN2erYkP1hxmnFB9rbx5k73Zdo1Tj7esIjDCUmmLtv8+wQpLZNcY+jzYkgktmkvjT8R8IR3ZL99expqRW96bb2HtNsSFViIKZVDhYNiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=jfc7vLXt; arc=none smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=7994; q=dns/txt;
  s=iport01; t=1776961813; x=1778171413;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=rq8RkynOrOnd72OONYo14/aNiZR3uYmftnvTm/IgRNo=;
  b=jfc7vLXt+y5Yl5TmHARJmbHXRMJpXwHj12FpZfS8BSCaG5hvU0nG552o
   A+rCqqADSXQtZBIq/eOZEK6qWLrIxYNx0bFa+EoZNZm237Ghlge3nNjgv
   UdEXvGW37tKCFc+Uwxtr9W70rGfR7gWaxEiEdFWCLf4f2pbT2ImqiQEMt
   PVIwlh0PVFE8vbAkZ7uJid90A8ptfwfJqMMm9MH1n67414B8Sb7b5G/Z/
   +VySASywCsxHuu+3RkeUZjE/TMKNAZUlp0YDsdDgEnLYnLmUEWa31u+CO
   Js4xWxbPejMAdX0b44b57ZG3E+vPWIB1EjtgX779QxrDRvjfXDfyb1y2I
   w==;
X-CSE-ConnectionGUID: f3RziMF3QOKXdE+Mm/VnVw==
X-CSE-MsgGUID: ErlZvQhHRlqIrB+RrBbm7w==
X-IPAS-Result: =?us-ascii?q?A0AnAACSPupp/4//Ja1aHQEBAQEJARIBBQUBgWsQBggBC?=
 =?us-ascii?q?wGCUoFPQ0mEV4gchzeCIZ4dFIFrDwEBAQ9RBAEBhQYCjSwCJjQJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQEBAQEKAQEFAQEBAgEHBYEOE4ZchlsCAQMjBFIQJQImA?=
 =?us-ascii?q?gJGEAYBEoMCgnQDsDt6fzOBAYR9sySBZAELFAGBCi4BhXGCZgGBcIQGO4Q/J?=
 =?us-ascii?q?xuBSUSBFAGDaIQFAQQVg3+CaQSDHBSBfo0fCT+BAhwDWSwBVRMNCgsHBWFSM?=
 =?us-ascii?q?wMgCgsSEhgVAhQvDwQWMh1wDCcSLBc0WBsHBYFLhAltFDEEIYELgyqBNnsDC?=
 =?us-ascii?q?xgNSBEsNwYOGwQ9AW4HijQgD4E5cVk1AU1vgSGTKAiDdo1da4E1n1mEJoFko?=
 =?us-ascii?q?A4BMpdmkwWZBiKjSW6EaIFoPIFZMxoIGxWDIlMZD44tFsofJjI9AQEHAgcNA?=
 =?us-ascii?q?wuBaJAAEReBVQEB?=
IronPort-Data: A9a23:7eCbYqNCx7MJvb3vrR2SlsFynXyQoLVcMsEvi/4bfWQNrUpzgzUCy
 GRKX2mPPamOMWejLdglOdnioUoAsZ/Ux4cxSXM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeap1yFjmA9knF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WVjlV
 e/a+ZWFZgf5gWUsbgr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQrl58R7PSq
 07rldlVz0uBl/sfIorNfoXTLiXmdoXv0T2m0RK6bUQNbi9q/UTe2o5jXBYVhNw+Zz+hx7idw
 /0V3XC8pJtA0qDkwIwgvxdk/y5WM/Z86r7iDyOGlu+jw2CFVn6r/fNQExRjVWEY0r4f7WBm7
 /cULnUJKxuEne/zmOz9Qeh3jcNlJ87uVG8dkig/lneCUrB8HM2FGvmRjTNb9G9YasRmBv/CZ
 tEZajpHZxXbaBoJMVASYH47tLj03yCkLG0H8zp5o4Ia+Wzh0jVx8ILpKfvPUJ+wX+9fmxmH8
 zeuE2PRR0ty2Mak4TaM7H+pruPGgy7+XIUcCPu+++ICqFCf22kaGhAKfVS8pva9hwi1XNc3A
 08J8CMGrqUo8kGvCN7nUHWQqXiIpBMDGNxdD+E39imJ16zSpQ2ZbkAcRzRMbt0OrsI6RTU2k
 FSOmrvBAT1pra3QSn+H8LqQhS29NDJTLmIYYyIACwwf7LHLpowvgh/RZshsHbTzjdDvHzz0h
 TeQo0ADa647l8UH0eC/uFvAmT/p/saPRQ8u7QKRVWWghu9kWLOYi0WTwQCzxZ59wEyxFzFtY
 FBsdxCi0d0z
IronPort-HdrOrdr: A9a23:6JaBXq3Bu13SKiua10UqLwqjBB4kLtp133Aq2lEZdPU0SKGlfp
 aV7YwmPHjP+U8ssRAb6La90cy7K080mqQb3WB8B9mftUzdyQmVxeJZnOzfKl/bak7DH7VmpN
 1dmsFFYbWdMbE5t7ee3ODfKbcdKbG8m5xA7t2uq0uFIzsLV4hQqz1XJyzeOlFqQjJLH4M+E4
 CRj/A33AZJeR4sH7aGL0hAZcfvjZngsqncTTsvOj4Az02voFqTmc3H+xrz5GZqb9uYq41ShV
 QskGbCl9KeW+nQ8G6g60bjq654tfGk7OBsOfy0pqEuW0TRYp7DXvUQZ1WF1gpF3N1GuD4R4a
 bxSw5LBbUM10/s
X-Talos-CUID: =?us-ascii?q?9a23=3AodO1amiVgnSvEXNukjy6RZslUjJufCbn3nb1DRS?=
 =?us-ascii?q?BLkVZRJDWbFrXxqVajJ87?=
X-Talos-MUID: 9a23:puF+EQWU0T2uvCzq/BL2gAN8DcdI2aC3KVon0q8ckcOBajMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,195,1770595200"; 
   d="scan'208";a="741137873"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Apr 2026 16:29:03 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id E22D318000279;
	Thu, 23 Apr 2026 16:29:02 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Thu, 23 Apr 2026 09:28:03 -0700
Subject: [PATCH net-next v5 02/10] enic: add admin channel open and close
 for SR-IOV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-enic-sriov-v2-admin-channel-v2-v5-2-caa9f504a3dc@cisco.com>
References: <20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com>
In-Reply-To: <20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776961741; l=8200;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=qlhfeksZz+XKX74y86PMSctRMUhiqOEZnpCahTINQR4=;
 b=fd93zLe6yeVoSiUPLtNURBAcLNEp92yDuemCbwlfrhdOC5/MT9RdvMT0VL0xk1JxA37qxou/0
 YxOKvEG9QC3Dw3LfQ/hddc7zqoYeR82clZ9WVugbYk3LAFtSFdGMOgD
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-06.cisco.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280802-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:dkim,cisco.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87447454F08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/ethernet/cisco/enic/enic_admin.c  | 186 ++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_admin.h  |  15 +++
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |   9 ++
 4 files changed, 212 insertions(+), 1 deletion(-)

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
index 000000000000..afb50aa413f4
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -0,0 +1,186 @@
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
+	err = vnic_cq_alloc_with_type(enic->vdev, &enic->admin_cq[0], 0,
+				      ENIC_ADMIN_DESC_COUNT,
+				      sizeof(struct cq_desc),
+				      RES_TYPE_ADMIN_CQ);
+	if (err)
+		goto free_rq;
+
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


