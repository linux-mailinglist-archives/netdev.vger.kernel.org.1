Return-Path: <netdev+bounces-287651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGxrLiebBGqILwIAu9opvQ
	(envelope-from <netdev+bounces-287651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:39:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC825364DF
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3D8D31A0B03
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8480D4C9567;
	Wed, 13 May 2026 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="DYDe4Z0p"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836364C77A5;
	Wed, 13 May 2026 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685373; cv=none; b=VFFlmSKnPLV7phGX/97PO/kW4bgTFqp2gnRltorsKBXZk+0sswFTn0w9KJP4BJYCdfX5G/7uEIY7i/T7hINLWZ534MNCg6Db4G1sARbcbmnYvBC3EVJvGapup6BcrpNIWum9x5EsYdQ8ELudMGDVx72KLniZ974UCZhgisFap24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685373; c=relaxed/simple;
	bh=m9ORrJ/+23FHsn3EZVUdPqmZnO3NCYGuv8JL/0lr/Gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gQ9L5ylkCx+Pka+CueLZmEnLTP6QdxWiJ2pp6ffHi3oJ8VauUwYvlVMK26WDzSkLlIxyBSMR9O5NvAT0exa9WtEqAAZTjn4hY6N+jmqgP6ev6Dj15InTY5dFHcE6r02WkRDUyYi/9FHbeZDWHzCHA1ZYzw+L7tR+wggN+OD2zJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=DYDe4Z0p; arc=none smtp.client-ip=173.37.142.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=14598; q=dns/txt;
  s=iport01; t=1778685371; x=1779894971;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=9a7KD6izkEAOndFZkJtEMkYeO4Jdp4t5i1BthxLNU1c=;
  b=DYDe4Z0p071nM53q7Yl6GT9iXfcIfW/vqhVbK9EYtbP/xvpKAhMxXI3c
   HOAQcYc+ScuDrs9yls95Ff9MKwPY40iTGunOrOoXRFkUZBzUW6ZWlw5NM
   P8/zhMVpFUxC7Ho3tU9hrrfxC9KuQb52yuwrDQmSrooBXp9p+hd/vIjQ2
   WDcD0MsipJkZ2J2lNfkE/0WMxgOunFaFbKEzIIdcN6KjdJ+bSU5NqsMsy
   fXQT938jK58gTQ3lA0SwdxC0Kp8I0xtrU65VKRBG6DvpX6osqYg0QetwU
   1rl85lNP6wCyS70MfY5XeJWpCLweMUx9WM9sJDVNGoZbkchfCZidsn86v
   g==;
X-CSE-ConnectionGUID: +iqbNErOQmSLinqHtdF0vw==
X-CSE-MsgGUID: JCV8Evt5S6StiOhH00qT4Q==
X-IPAS-Result: =?us-ascii?q?A0ADAACnlARq/5D/Ja1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBgXwFAQEBAQsBglaBUENJhFeIHIc3giGRTYxQgX8PAQEBD1EEA?=
 =?us-ascii?q?QGFBgKNMgImNAkOAQIEAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4Zch?=
 =?us-ascii?q?lsCAQMjBFIQJQImAgJGEAYBEoMCgnQDswx6fzOBAYR92USBZAELFAGBCi4Bh?=
 =?us-ascii?q?XGCZwGBcIQGO4RAJxuBSUSBFAGDaIQahASCaQSCInoUhWeBAIgRCT+BAhwDW?=
 =?us-ascii?q?SwBVRMNCgsHBWFSMwMgCgsSEhgVAhQvDwQWMh1wDCcSLBczWBsHBYFLggVyF?=
 =?us-ascii?q?DEEIYEChF94IywDToFDAwsYDUgRLDcGDhsEPQFuB4o/HQ+BP3EBWAEaBxR6N?=
 =?us-ascii?q?gw8CBMdFBkcKZJjGwKDYYwngTZrgTWfWYQmgWSgDgEyhASTYjOSUpkGIqMzN?=
 =?us-ascii?q?AEYN4RogWg8gVkzGggbFTuCZ1MZD44qAxYczB8nMj0CBwIHDQMLkWgEgXkBA?=
 =?us-ascii?q?Q?=
IronPort-Data: A9a23:wquNoqOyp07j1GjvrR1llsFynXyQoLVcMsEvi/4bfWQNrUongmFRz
 GMYCjrQOqvYYTT3eNB/a97loEkAscDQxoNlG3M5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFTmE+kvF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WVjlV
 e/a+ZWFZgf4gmUsawr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj67ZvFUsQEJc/w+NMJWBI7
 NwEJB5VcA/W0opawJrjIgVtrt4oIM+uOMYUvWttiGmGS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzMHwsYDUXUrsTIIk3gOazhnr/WzZZs1mS46Ew5gA/ySQujOW1b4uJJ4DiqcN9vG2m9
 k/Y4znCXCoGNfuf6WLd607wv7qa9c/8cMdIfFGizdZmiUOew0QfAQMbUF+8r+X/jEOiM/pSJ
 1ER8zgjsYA980ukStS7VBq9yFaHoxQVc9ldCes37EeK0KW8yw+fCnIJUX1HZcAqudEeQSEs0
 BmCn7vBHTVlvbuUYWiQ+redsXW5Pi19BWsDYzIUCAgI+d/upKktgR/VCNVuCqi4ipvyAz6Y6
 zaHsCQzmZ0NgsMRkaa251bKh3SrvJehc+Iuzh/cUmTg6kZyY5SoItT3r1Pa9v1Hao2eSzFto
 UQ5piRX18hWZbnlqcBHaLxl8G2BjxpdDADhvA==
IronPort-HdrOrdr: A9a23:QRFfna5jvv0kupBFVQPXwD7XdLJyesId70hD6qm+c20wTiX+ra
 GTdZUguyMc5wx9ZJhNo7q90ey7MBHhHP1OjrX5Q43DYOCOggLBR72Kr7GSoAEIcBeTygcy79
 YET4FOTPD9ElR+i9/3+02bH8ZI+qj/zImYwcrT0HtpSxhncOVb7wl/AhuGCUEefnghOXNALu
 v62uN34xy9ZH8QcsO3QlMBX+TFupn3saiOW29/O/bigzP+9w9BL9XBYmOl4is=
X-Talos-CUID: 9a23:s8iFFWFVc9I8Q79vqmIk9VcePO0/VUTY91PRJVaYFWpHEKOKHAo=
X-Talos-MUID: 9a23:sYImUAXIHyxuYJDq/B3HumFPKts12PqVFEEqkbVe49C4aRUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,232,1770595200"; 
   d="scan'208";a="745079454"
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
  by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 May 2026 15:16:03 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-07.cisco.com (Postfix) with ESMTPS id 2B037180004BA;
	Wed, 13 May 2026 15:16:03 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Wed, 13 May 2026 08:15:41 -0700
Subject: [PATCH net-next v7 04/10] enic: add admin CQ service with MSI-X
 interrupt and NAPI polling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-enic-sriov-v2-admin-channel-v2-v7-4-68b9f4141f4c@cisco.com>
References: <20260513-enic-sriov-v2-admin-channel-v2-v7-0-68b9f4141f4c@cisco.com>
In-Reply-To: <20260513-enic-sriov-v2-admin-channel-v2-v7-0-68b9f4141f4c@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778685359; l=15064;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=m9ORrJ/+23FHsn3EZVUdPqmZnO3NCYGuv8JL/0lr/Gw=;
 b=2LeOpFEI0lHarlmDZZ0nA4DQ1h/RBIaPNwa+LuPy2jhCrTSIgjj3UpUU/dJIYjA6cdp69idBv
 RooWcR6GsxUCWvRxZ3URN0b4A96JtFtmGbUyADSrVMHt2HAI+PGr/rZ
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-07.cisco.com
X-Rspamd-Queue-Id: 3FC825364DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287651-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:mid,cisco.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add completion queue service for the admin channel WQ and RQ, driven
by an MSI-X interrupt and NAPI polling.

The receive pipeline is: MSI-X ISR -> NAPI poll -> RQ CQ service ->
message enqueue -> workqueue handler -> admin_rq_handler callback.
NAPI drains the RQ CQ in softirq context, copying each received
buffer into an enic_admin_msg and appending it to a spinlock-protected
list.  A system workqueue handler then processes each message in
process context where sleeping (mutex, GFP_KERNEL allocations) is
safe.

The WQ CQ service counts transmit completions and is called from the
synchronous MBOX send path.  Interrupt generation is disabled on the
WQ CQ (admin_cq[0]) because it is polled synchronously; only the RQ
CQ (admin_cq[1]) is interrupt-driven via NAPI.

The NAPI poll path refills admin RQ buffers with GFP_ATOMIC.  Log a
rate-limited warning when admin RQ buffer refill fails in NAPI context.

The admin channel open/close paths set up and tear down the MSI-X
interrupt, NAPI instance, and workqueue.  CQ init enables interrupt
delivery on the RQ CQ and sets the interrupt offset so completions
trigger the admin ISR.

The admin interrupt is allocated from the RES_TYPE_INTR_CTRL pool
at index == intr_count, the first slot beyond the data-path IRQs.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h       |   8 +
 drivers/net/ethernet/cisco/enic/enic_admin.c | 303 ++++++++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_admin.h |  12 ++
 3 files changed, 319 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 08472420f3a1..1c09da3c0b1a 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -296,6 +296,14 @@ struct enic {
 	struct vnic_rq admin_rq;
 	struct vnic_cq admin_cq[2];
 	struct vnic_intr admin_intr;
+	struct napi_struct admin_napi;
+	unsigned int admin_intr_index;
+	struct work_struct admin_msg_work;
+	spinlock_t admin_msg_lock;	/* protects admin_msg_list */
+	struct list_head admin_msg_list;
+	u64 admin_msg_drop_cnt;
+	void (*admin_rq_handler)(struct enic *enic, void *buf,
+				 unsigned int len);
 };
 
 static inline struct net_device *vnic_get_netdev(struct vnic_dev *vdev)
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index b28fc6c656cc..9ebc69c7dda6 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -4,6 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
 
 #include "vnic_dev.h"
 #include "vnic_wq.h"
@@ -15,6 +16,7 @@
 #include "enic.h"
 #include "enic_admin.h"
 #include "cq_desc.h"
+#include "cq_enet_desc.h"
 #include "wq_enet_desc.h"
 #include "rq_enet_desc.h"
 
@@ -94,6 +96,248 @@ static void enic_admin_rq_drain(struct enic *enic)
 	vnic_rq_clean(&enic->admin_rq, enic_admin_rq_buf_clean);
 }
 
+static unsigned int enic_admin_cq_color(void *cq_desc, unsigned int desc_size)
+{
+	u8 type_color = *((u8 *)cq_desc + desc_size - 1);
+
+	return (type_color >> CQ_DESC_COLOR_SHIFT) & CQ_DESC_COLOR_MASK;
+}
+
+unsigned int enic_admin_wq_cq_service(struct enic *enic)
+{
+	struct vnic_cq *cq = &enic->admin_cq[0];
+	unsigned int work = 0;
+	void *desc;
+
+	desc = vnic_cq_to_clean(cq);
+	while (enic_admin_cq_color(desc, cq->ring.desc_size) !=
+	       cq->last_color) {
+		/* Ensure color bit is read before descriptor fields */
+		rmb();
+		vnic_cq_inc_to_clean(cq);
+		work++;
+		desc = vnic_cq_to_clean(cq);
+	}
+
+	return work;
+}
+
+static void enic_admin_msg_enqueue(struct enic *enic, void *buf,
+				   unsigned int len)
+{
+	struct enic_admin_msg *msg;
+
+	msg = kmalloc(struct_size(msg, data, len), GFP_ATOMIC);
+	if (!msg) {
+		enic->admin_msg_drop_cnt++;
+		return;
+	}
+
+	msg->len = len;
+	memcpy(msg->data, buf, len);
+
+	spin_lock(&enic->admin_msg_lock);
+	list_add_tail(&msg->list, &enic->admin_msg_list);
+	spin_unlock(&enic->admin_msg_lock);
+}
+
+unsigned int enic_admin_rq_cq_service(struct enic *enic, unsigned int budget)
+{
+	struct vnic_cq *cq = &enic->admin_cq[1];
+	struct vnic_rq *rq = &enic->admin_rq;
+	struct cq_enet_rq_desc *rq_desc;
+	struct vnic_rq_buf *buf;
+	u16 bwf, bytes_written;
+	unsigned int work = 0;
+	void *desc;
+
+	desc = vnic_cq_to_clean(cq);
+	while (work < budget &&
+	       enic_admin_cq_color(desc, cq->ring.desc_size) !=
+	       cq->last_color) {
+		/* Ensure CQ descriptor fields are read after
+		 * the color/valid check.
+		 */
+		rmb();
+		buf = rq->to_clean;
+
+		/* Decode the actual number of bytes hardware wrote into
+		 * the RX buffer.  buf->len is the static allocation size
+		 * (ENIC_ADMIN_BUF_SIZE) and would expose uninitialised
+		 * heap memory beyond the real payload.  bytes_written_flags
+		 * is at the same offset in every cq_enet_rq_desc[_32|_64]
+		 * variant.
+		 */
+		rq_desc = desc;
+		bwf = le16_to_cpu(rq_desc->bytes_written_flags);
+		bytes_written = bwf & CQ_ENET_RQ_DESC_BYTES_WRITTEN_MASK;
+		if (bytes_written > buf->len)
+			goto next_desc;
+
+		dma_sync_single_for_cpu(&enic->pdev->dev,
+					buf->dma_addr, buf->len,
+					DMA_FROM_DEVICE);
+
+		/* Drop on hardware error indications.  Admin messages
+		 * are internal to the VIC, not received over the wire.
+		 * Firmware sets TRUNCATED when the message does not fit
+		 * in the posted buffer, and FCS_OK is always set on
+		 * healthy admin completions.
+		 */
+		if (bwf & CQ_ENET_RQ_DESC_FLAGS_TRUNCATED) {
+			netdev_warn_once(enic->netdev,
+					 "admin RQ: truncated message dropped\n");
+			goto next_desc;
+		}
+		if (!(rq_desc->flags & CQ_ENET_RQ_DESC_FLAGS_FCS_OK)) {
+			netdev_warn_once(enic->netdev,
+					 "admin RQ: bad FCS, dropping message\n");
+			goto next_desc;
+		}
+
+		enic_admin_msg_enqueue(enic, buf->os_buf, bytes_written);
+
+next_desc:
+		enic_admin_rq_buf_clean(rq, rq->to_clean);
+		rq->to_clean = rq->to_clean->next;
+		rq->ring.desc_avail++;
+
+		vnic_cq_inc_to_clean(cq);
+		work++;
+		desc = vnic_cq_to_clean(cq);
+	}
+
+	if (enic_admin_rq_fill(enic, GFP_ATOMIC))
+		work = budget;
+
+	return work;
+}
+
+static irqreturn_t enic_admin_isr_msix(int irq, void *data)
+{
+	struct napi_struct *napi = data;
+
+	napi_schedule_irqoff(napi);
+
+	return IRQ_HANDLED;
+}
+
+static void enic_admin_msg_work_handler(struct work_struct *work)
+{
+	struct enic *enic = container_of(work, struct enic, admin_msg_work);
+	void (*handler)(struct enic *, void *, unsigned int);
+	struct enic_admin_msg *msg, *tmp;
+	LIST_HEAD(local_list);
+
+	handler = READ_ONCE(enic->admin_rq_handler);
+
+	spin_lock_bh(&enic->admin_msg_lock);
+	list_splice_init(&enic->admin_msg_list, &local_list);
+	spin_unlock_bh(&enic->admin_msg_lock);
+
+	list_for_each_entry_safe(msg, tmp, &local_list, list) {
+		if (handler)
+			handler(enic, msg->data, msg->len);
+		list_del(&msg->list);
+		kfree(msg);
+	}
+}
+
+static int enic_admin_napi_poll(struct napi_struct *napi, int budget)
+{
+	struct enic *enic = container_of(napi, struct enic, admin_napi);
+	unsigned int credits;
+	unsigned int rq_work;
+
+	credits = vnic_intr_credits(&enic->admin_intr);
+
+	rq_work = enic_admin_rq_cq_service(enic, budget);
+
+	if (rq_work > 0)
+		schedule_work(&enic->admin_msg_work);
+
+	if (rq_work < budget && napi_complete_done(napi, rq_work)) {
+		vnic_intr_return_credits(&enic->admin_intr,
+					 credits ?: 1,
+					 1 /* unmask */, 0);
+	} else {
+		if (credits)
+			vnic_intr_return_credits(&enic->admin_intr, credits,
+						 0 /* don't unmask */, 0);
+	}
+
+	return rq_work;
+}
+
+static int enic_admin_setup_intr(struct enic *enic)
+{
+	unsigned int intr_index = enic->intr_count;
+	int err;
+
+	if (vnic_dev_get_intr_mode(enic->vdev) != VNIC_DEV_INTR_MODE_MSIX ||
+	    intr_index >= enic->intr_avail)
+		return -ENODEV;
+
+	/* The admin INTR uses a slot in the same RES_TYPE_INTR_CTRL
+	 * strided array of per-vector control blocks (mask, coalescing
+	 * timer, credit return) that the data-path IRQs occupy in BAR0.
+	 * vnic_intr_alloc() defaults to RES_TYPE_INTR_CTRL, which is what
+	 * we want here.
+	 */
+	err = vnic_intr_alloc(enic->vdev, &enic->admin_intr, intr_index);
+	if (err) {
+		netdev_warn(enic->netdev,
+			    "Failed to alloc admin intr at index %u: %d\n",
+			    intr_index, err);
+		return err;
+	}
+
+	enic->admin_intr_index = intr_index;
+
+	snprintf(enic->msix[intr_index].devname,
+		 sizeof(enic->msix[intr_index].devname),
+		 "%s-admin", enic->netdev->name);
+	enic->msix[intr_index].isr = enic_admin_isr_msix;
+	enic->msix[intr_index].devid = &enic->admin_napi;
+
+	netif_napi_add(enic->netdev, &enic->admin_napi,
+		       enic_admin_napi_poll);
+	napi_enable(&enic->admin_napi);
+
+	err = request_irq(enic->msix_entry[intr_index].vector,
+			  enic->msix[intr_index].isr, 0,
+			  enic->msix[intr_index].devname,
+			  enic->msix[intr_index].devid);
+	if (err) {
+		netdev_warn(enic->netdev,
+			    "Failed to request admin MSI-X irq: %d\n", err);
+		napi_disable(&enic->admin_napi);
+		netif_napi_del(&enic->admin_napi);
+		vnic_intr_free(&enic->admin_intr);
+		return err;
+	}
+
+	enic->msix[intr_index].requested = 1;
+
+	netdev_dbg(enic->netdev,
+		   "admin channel using MSI-X interrupt (index %u)\n",
+		   intr_index);
+
+	return 0;
+}
+
+static void enic_admin_teardown_intr(struct enic *enic)
+{
+	unsigned int intr_index = enic->admin_intr_index;
+
+	napi_disable(&enic->admin_napi);
+	netif_napi_del(&enic->admin_napi);
+
+	free_irq(enic->msix_entry[intr_index].vector,
+		 enic->msix[intr_index].devid);
+	enic->msix[intr_index].requested = 0;
+}
+
 static int enic_admin_qp_type_set(struct enic *enic, u32 enable)
 {
 	u64 a0 = QP_TYPE_ADMIN, a1 = enable;
@@ -173,6 +417,7 @@ static int enic_admin_alloc_resources(struct enic *enic)
 
 static void enic_admin_free_resources(struct enic *enic)
 {
+	vnic_intr_free(&enic->admin_intr);
 	vnic_cq_free(&enic->admin_cq[1]);
 	vnic_cq_free(&enic->admin_cq[0]);
 	vnic_rq_free(&enic->admin_rq);
@@ -181,6 +426,8 @@ static void enic_admin_free_resources(struct enic *enic)
 
 static void enic_admin_init_resources(struct enic *enic)
 {
+	unsigned int intr_offset = enic->admin_intr_index;
+
 	vnic_wq_init(&enic->admin_wq,
 		     0, 0, 0); /* cq_index, err_intr_enable, err_intr_offset */
 	vnic_rq_init(&enic->admin_rq,
@@ -189,20 +436,34 @@ static void enic_admin_init_resources(struct enic *enic)
 		     VNIC_CQ_FC_DISABLE,
 		     VNIC_CQ_COLOR_ENABLE,
 		     0, 0, 1, /* cq_head, cq_tail, cq_tail_color */
-		     VNIC_CQ_INTR_DISABLE,
+		     VNIC_CQ_INTR_DISABLE, /* polled synchronously by mbox send */
 		     VNIC_CQ_ENTRY_ENABLE,
 		     VNIC_CQ_MSG_DISABLE,
-		     0, /* interrupt_offset */
+		     intr_offset,
 		     0 /* cq_message_addr */);
 	vnic_cq_init(&enic->admin_cq[1],
 		     VNIC_CQ_FC_DISABLE,
 		     VNIC_CQ_COLOR_ENABLE,
 		     0, 0, 1, /* cq_head, cq_tail, cq_tail_color */
-		     VNIC_CQ_INTR_DISABLE,
+		     VNIC_CQ_INTR_ENABLE,
 		     VNIC_CQ_ENTRY_ENABLE,
 		     VNIC_CQ_MSG_DISABLE,
-		     0, /* interrupt_offset */
+		     intr_offset,
 		     0 /* cq_message_addr */);
+	vnic_intr_init(&enic->admin_intr,
+		       0, 0, 1); /* coalescing_timer, coalescing_type, mask_on_assertion */
+}
+
+static void enic_admin_msg_drain(struct enic *enic)
+{
+	struct enic_admin_msg *msg, *tmp;
+
+	spin_lock_bh(&enic->admin_msg_lock);
+	list_for_each_entry_safe(msg, tmp, &enic->admin_msg_list, list) {
+		list_del(&msg->list);
+		kfree(msg);
+	}
+	spin_unlock_bh(&enic->admin_msg_lock);
 }
 
 int enic_admin_channel_open(struct enic *enic)
@@ -220,6 +481,18 @@ int enic_admin_channel_open(struct enic *enic)
 		return err;
 	}
 
+	spin_lock_init(&enic->admin_msg_lock);
+	INIT_LIST_HEAD(&enic->admin_msg_list);
+	INIT_WORK(&enic->admin_msg_work, enic_admin_msg_work_handler);
+
+	err = enic_admin_setup_intr(enic);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "Admin channel requires MSI-X, SR-IOV unavailable: %d\n",
+			   err);
+		goto free_resources;
+	}
+
 	enic_admin_init_resources(enic);
 
 	vnic_wq_enable(&enic->admin_wq);
@@ -239,15 +512,29 @@ int enic_admin_channel_open(struct enic *enic)
 		goto disable_queues;
 	}
 
+	vnic_intr_unmask(&enic->admin_intr);
+
+	netdev_dbg(enic->netdev,
+		   "admin channel open: intr=%u wq_avail=%u rq_avail=%u cq0_color=%u cq1_color=%u\n",
+		   enic->admin_intr_index,
+		   vnic_wq_desc_avail(&enic->admin_wq),
+		   vnic_rq_desc_avail(&enic->admin_rq),
+		   enic->admin_cq[0].last_color,
+		   enic->admin_cq[1].last_color);
+
 	return 0;
 
 disable_queues:
+	enic_admin_teardown_intr(enic);
 	enic_admin_qp_type_set(enic, QP_DISABLE);
 	if (vnic_wq_disable(&enic->admin_wq))
 		netdev_warn(enic->netdev, "Failed to disable admin WQ\n");
 	if (vnic_rq_disable(&enic->admin_rq))
 		netdev_warn(enic->netdev, "Failed to disable admin RQ\n");
+	cancel_work_sync(&enic->admin_msg_work);
+	enic_admin_msg_drain(enic);
 	enic_admin_rq_drain(enic);
+free_resources:
 	enic_admin_free_resources(enic);
 	return err;
 }
@@ -259,6 +546,13 @@ void enic_admin_channel_close(struct enic *enic)
 	if (!enic->has_admin_channel)
 		return;
 
+	netdev_dbg(enic->netdev, "admin channel close\n");
+
+	vnic_intr_mask(&enic->admin_intr);
+	enic_admin_teardown_intr(enic);
+	cancel_work_sync(&enic->admin_msg_work);
+	enic_admin_msg_drain(enic);
+
 	enic_admin_qp_type_set(enic, QP_DISABLE);
 
 	err = vnic_wq_disable(&enic->admin_wq);
@@ -274,5 +568,6 @@ void enic_admin_channel_close(struct enic *enic)
 	enic_admin_rq_drain(enic);
 	vnic_cq_clean(&enic->admin_cq[0]);
 	vnic_cq_clean(&enic->admin_cq[1]);
+	vnic_intr_clean(&enic->admin_intr);
 	enic_admin_free_resources(enic);
 }
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.h b/drivers/net/ethernet/cisco/enic/enic_admin.h
index 569aadeb9312..0e52d6e0586e 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.h
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.h
@@ -9,7 +9,19 @@
 
 struct enic;
 
+/* Wrapper for received admin messages queued for deferred processing.
+ * NAPI enqueues these; a workqueue handler processes them in process context
+ * where sleeping (mutex, GFP_KERNEL) is safe.
+ */
+struct enic_admin_msg {
+	struct list_head list;
+	unsigned int len;
+	u8 data[] __aligned(8);
+};
+
 int enic_admin_channel_open(struct enic *enic);
 void enic_admin_channel_close(struct enic *enic);
+unsigned int enic_admin_wq_cq_service(struct enic *enic);
+unsigned int enic_admin_rq_cq_service(struct enic *enic, unsigned int budget);
 
 #endif /* _ENIC_ADMIN_H_ */

-- 
2.43.0


