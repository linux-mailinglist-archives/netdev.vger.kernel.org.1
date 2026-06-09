Return-Path: <netdev+bounces-297169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7BsFFmBDKGoDBQMAu9opvQ
	(envelope-from <netdev+bounces-297169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:46:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5C96628C3
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:46:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=hKtHeQit;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297169-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297169-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DCF1310E55B
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1B44B8DE8;
	Tue,  9 Jun 2026 16:32:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C65E496903;
	Tue,  9 Jun 2026 16:32:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022772; cv=none; b=iiZiyux72vgyPdYjAezvhJQbo3aHWfvjBt7y5rdSmlwT3orVeMsVbu+cc1r/NSlFxfDl5ksqDvHzypChDVvnV28H93GB03iijDPfbR0n/Nc5CEwfAgxEeGQOSowmU32p0qcKvDAt60k/w5S3BilXUWmODUrti132Prrb4ieBBeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022772; c=relaxed/simple;
	bh=A25gONtnaWKhb1ocBjwgbtmNeIXSSx2gWPB1si8zQKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pjtZpGB9u1KoPGuD4S/EumLkjFjfjju2R9P6dTLFsvv7H4KL8cslJcEYaxRdOQlFxlK0D3JXNEi1S45vGvlmr6HpdgHZSde0cw3QkNCCVJbn9f2rSjkJ86U7Z11hGmD7PBH6kb74SlYhSSighfPVkTwiqgdfLHP/g2Wy9JnSElI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=hKtHeQit; arc=none smtp.client-ip=173.37.86.77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=10537; q=dns/txt;
  s=iport01; t=1781022770; x=1782232370;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=y/wT+XTHaO5LcOe/d9RnEXtHek4BKEG1iYuAoyFJMKo=;
  b=hKtHeQit/2vTgrkFqTmj/emX5wJG9ZSYlLsSma/xoT9ZDWabtwZ0WkY4
   dWDegGT444ua1xtTnzdkkptIiPqF+eDHUkyjgJJd+xW3wr40ZB5o3advS
   YVzeGiPAvDT3l4O0/t2wet7ZXmxiOg3QtLcoUQxDR1n/rOThi5koPGWCx
   DjbEUjSEx73K7mQuFCWq/FhruEd1sN0Tix2pPAXKjxCU7omMizzUiNdG4
   chLFibwMdSoMyJtHmsk9A4Gw88vejLE0grkcMnIBb2n+Uctc32zNE1l80
   iNzOalLkHy3ax2CSwHWCrz0qobSqnUY7f3rUuXtgwEIX5JrMv7Tyv1imh
   A==;
X-CSE-ConnectionGUID: PVh1gKNXR8mptgsli0w5IQ==
X-CSE-MsgGUID: lDkxSqijQ92ywU7ti0aqLQ==
X-IPAS-Result: =?us-ascii?q?A0AIAAAaPyhq/4//Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF8BgEBAQsBglaBUkNJhFeIHIc3giGeHhSBag8BAQEPUQQBAYUGAo03A?=
 =?us-ascii?q?iY0CQ4BAgQDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThlyGWwIBAyMEU?=
 =?us-ascii?q?hAlAiYCAkYQBgESgwKCdAO1IHp/M4EBhH3ZRYFmAQsUAYEKLgGFcIJpAYFwh?=
 =?us-ascii?q?AY7hEEnG4FJRIEUAYNohAUBBBWDf4JqBIMcEoF7jmwJP4ECHANZLAFVEw0KC?=
 =?us-ascii?q?wcFYVIzAyAKCxISGBUCFC8PBBYyHXAMJxIsFzRYGwcFgUqBOxQxBCGBBYUSI?=
 =?us-ascii?q?x8DOYEVgXyBKGdpFTE1TQMLGA1IESw3Bg4bBD0BbgeMOhcPgTEXcVk1AU1vg?=
 =?us-ascii?q?SEcLJJgCIN2jV9rgTWfWYQmgWagDwEyl2eTBJkGIqNIboRogWg8gVkzGggbF?=
 =?us-ascii?q?YMiUxkPjioDFst+JzI9AQEHAgcOAwuBaJAAEReBVQEB?=
IronPort-Data: A9a23:Ftl6AKjAAPLK22kOSSXVn5R8X161oBEKZh0ujC45NGQN5FlHY01je
 htvDW/XPfiJa2f1fYhyO4zj8RwGsJ/dyYViTgNvriEyRiNjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOOn9SUgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZeDULOZ82QsaDxMtfrS8EoHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUgxOYuDkJox
 cZILSgRYQuHhrqpnZOCH7wEasQLdKEHPasFsX1miDWcBvE8TNWbHePB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWZgx/5JEWxI9EglHkeiFZs1KWpYI84nPYy0p6172F3N/9Jo3QHJwKxRfHz
 o7A12DVAQEhLd2d8Gvf422R2fPOxSrifLtHQdVU8dYv2jV/3Fc7BBQIWF6TrfCnh0u6XNxDb
 UoZ5kIGoKQv8UW5Q8XVUBq/r3qJ+BUbXrJ4EPAw4SmOx7DS7gLfAXILJhZIbtA8udB1QzE22
 lKXt9f0Azopu739YWqU/LqSrBuoNCQVJHNEbigBJSMB4t/+sMQwgwjJQ9JLDqG4lJv2FCv2z
 jTMqzIx750VgNIH2ruT41/KmXSvq4LPQwpz4R/YNl9J9Stjb4KjIojt4l/B4LMYcsCST0KKu
 z4PnM32AP0yMKxhXRelGI0ldIxFLd7cWNEAqTaDx6Ucygk=
IronPort-HdrOrdr: A9a23:o/m3hKOC1v8HFMBcTjejsMiBIKoaSvp037Dk7TEUdfUzSK2lfq
 GV8sjzuiWYtN98YhsdcJW7Scu9qBDnmqKdn7NwAV7KZmCP01dAbrsSjrcKqAeNJ8SRzJ856Y
 5QN4VzF9H0C0F3loLZ7BnQKadY/PC3tI2lmuvayW5gVkVRa69m5xpkEQrzKDwReOA/P+tfKL
 OsouxaujGnZXMbKu6/BnUDQqz/guejruOfXfbDbCRXkjVnSliTmcXHLyQ=
X-Talos-CUID: =?us-ascii?q?9a23=3AxZchwGvcFt+lG2769t9va13x6IsdTH2Ew1T2E3X?=
 =?us-ascii?q?oDH51R6aRSAePpYJdxp8=3D?=
X-Talos-MUID: 9a23:m71rugTF512TJAq7RXToqDJyD95p4Z3/UlESrMoaupGNLAhJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,196,1774310400"; 
   d="scan'208";a="492117397"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 09 Jun 2026 16:32:48 +0000
Received: from [127.0.0.1] (unknown [10.25.128.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id DD7A71800027A;
	Tue,  9 Jun 2026 16:32:47 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Tue, 09 Jun 2026 09:32:28 -0700
Subject: [PATCH net-next v8 02/10] enic: add admin channel open and close
 for SR-IOV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-enic-sriov-v2-admin-channel-v2-v8-2-8ad8babbb826@cisco.com>
References: <20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com>
In-Reply-To: <20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781022766; l=10910;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=A25gONtnaWKhb1ocBjwgbtmNeIXSSx2gWPB1si8zQKc=;
 b=1wT3k7h5WhDGyXjDjXuoXGqDcMBVELCdaKo+FpGddPbq8nSkxKEyNOcv4W9hbIAWpNd7aKo4r
 9Ud1qxYLh5wD0ECjAYsfj0+q/NlUCdzjcUD9wuob8nazutvJOvlNl1X
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297169-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC5C96628C3

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
index 3b6efa743dba..90ca06691ebd 100644
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


