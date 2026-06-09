Return-Path: <netdev+bounces-297174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 00R0DSpJKGpyBgMAu9opvQ
	(envelope-from <netdev+bounces-297174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:11:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F3F662C9A
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:11:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=J2ILVT+Z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297174-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297174-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAD9334348DE
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740A34C6EF6;
	Tue,  9 Jun 2026 16:33:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960C34A138F;
	Tue,  9 Jun 2026 16:32:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022780; cv=none; b=pVkppDCTvPVFJ1hn2AhQNhDce6BtC/fLifpyEFGntMZmglBULrFwkD+hKgushGd+eySy32AXiK7RZlNiyDm8Hzad7EtRHCJbn/PAfvcET2C5AAt7VqyRmGosJ0Y0u5NgaAac3i7o/LEf3nha9CTkf9+l/zMfxv2MJ8VdF2Ycy6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022780; c=relaxed/simple;
	bh=8g9ux5CGmu4ks4G+DJiJBQLaQsJq8am4LOOoYftX1jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B8TnWnO+XXHPtFHwd6/3Y80ofQ69klx8VoNkOzr9Idn7AwqYMIFacwNuPKQc5tibUUG8ADwnd1gnU4zJO/vRjLROBhnudLd6EW/iR0/EnpFyWcs9nS4XDfsd5G000QM9zImEc4wdacnpTchs+X69vr47+PdHc2Op/laZT0FiuIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=J2ILVT+Z; arc=none smtp.client-ip=173.37.86.73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=13589; q=dns/txt;
  s=iport01; t=1781022776; x=1782232376;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=iWe7XgVd2u70FRLbvZghRIFfgLs+/3thpTscm74qGmc=;
  b=J2ILVT+ZmHg+dAetEEy94gBrcHJ78qi7f3HxC+0kaNgAao68GD1GnE/Q
   solimgiBPwc3kuOZn0NvL1m+tLrJMDhFMM4HeX97+Hz9vbGKiXpLncTHh
   ISN83nsR7jw3v+8Gv+jYAZwSgux8TmGK5B55yvSWrJMV2bZc8oOGtjCrp
   D7ZkEby123FDpIKlxJcRg0P3d0T5k7X1/+o1C1hPQgmuBSnPlJmDwDcJp
   VrYLv9QMqqJPSeSPLPlswfIZRUcJFth+A2DSkOfZF62+DpVX8s9KJGdcw
   sk8gykEHBZArzRwNdN191Vlv3PniUL75ePRV/M+zCHBwSExtXKohWDwCY
   g==;
X-CSE-ConnectionGUID: vQWnntJaTFOx/5G6RalUAA==
X-CSE-MsgGUID: YYknMf5IQZOFnn0LoysnQg==
X-IPAS-Result: =?us-ascii?q?A0ACAACmPyhq/4//Ja1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQGBfAQBAQEBAQsBglaBUkNJhFeIHIc3giGBFpA3jFGBf?=
 =?us-ascii?q?g8BAQEPUQQBAYUGAo03AiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQsBAQUBAQECA?=
 =?us-ascii?q?QcFgQ4ThlyGWwIBAyMEUhAlAiYCAkYQBgESgwKCdAO1HHp/M4EB3kKBZgELF?=
 =?us-ascii?q?AGBCi4BhXCCaQGBcIQGO4RBJxuBSUSBFAGCcnaEGoQEgmoEgiJ6EoRngQCLA?=
 =?us-ascii?q?Ak/gQIcA1ksAVUTDQoLBwVhUjMDIAoLEhIYFQIULw8EFjIdcAwnEiwXNFgbB?=
 =?us-ascii?q?wWBSoE7FDEEIYEFhRIjHwM5gRWBfIEoZ2kVMTVNAwsYDUgRLDcGDhsEPQFuB?=
 =?us-ascii?q?4w6Fw+BSHEBWBsHFHo2DDwbHRQZHCmSYxsCg2GMKYE2a4E1n1mEJoFmoA8BM?=
 =?us-ascii?q?oQEk2MzklGZBiKjZgEYN4RogWg8gVkzGggbFTuCZ1MZD44qAxYcy2InMj0CB?=
 =?us-ascii?q?wIHDgMLkWgEgXkBAQ?=
IronPort-Data: A9a23:vDh3Iq8A7Y6v4KDnxFHODrUDQH+TJUtcMsCJ2f8bNWPcYEJGY0x3y
 WIfXm+APP/fZDf0cth2aIy+/EMGvpDczII3SABupC5EQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmE4EzrauS9xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4muyyHjEAX9gWAsbDpFs/vrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2koBLIe/PpVCF1g0
 uxfdR9TVBmHusuflefTpulE3qzPLeHxN48Z/3UlxjbDALN+H9bIQr7B4plT2zJYasJmRKmFI
 ZFGL2AyMVKZP0Yn1lQ/UPrSmM+zj2X+aD1bqHqepLE85C7YywkZPL3FbIWKKofWHJgO9qqej
 lP3/GLcDEw7De645zyDqlarl/TJpCyuDer+E5X9rJaGmma7ymUNBRg+WVKlrPy9jUCiHdRSN
 yQ89yYzqKEg+VCDQd76UBm15nWDu3Y0WMdaGsU55RuLx66S5ByWbkANSDJbZcNlssIqSTE0/
 luUmdWvDjwHmKWcQ3+b95+OoD+yMDRTJmgHDQcATA0Y85zgrZs1gxbnUNluCui2g8fzFDW2x
 CqFxAA4iqkfgNAjyaq25xbEjiiqq5yPSRQ6jjg7RUq/5Q9/IYrgbIuy5B2Ds7BLLZ2SSR+Ku
 31sd9Wi0d3ixKqlzESlKNjh1pnwjxpZGFUwWWJSIqQ=
IronPort-HdrOrdr: A9a23:1Y25k6lHK+MNWkMUuTGV2/XwLQbpDfLa3DAbv31ZSRFFG/FwWf
 re+MjzsiWUtN9xYh8dcL+7VZVoLUm3yXcx2/hyAV7AZmbbURWTTL2KhLGKq1bd8m/Fh41gPM
 xbH5SWZueAaGRSvILW7Ba1FtA4zMLC0qy57N2utktFfEVGZ75t6gFhBh3eKE15QwFaGYE0fa
 DsgPav3wDQHkg/X4CcGmQPWfTFqpngkZLrZgNDOjscgTP+9Q9BLNXBYmKlNtB0aUI1/Ysf
X-Talos-CUID: 9a23:JBREmmNNEnXuDu5DRhBY8kgIOMkZXFrNiyr/fXWxDVtAYejA
X-Talos-MUID: 9a23:t9BIgwlt9gvACcFKDij6dnpTBcRuxqrzKXk/trsAvZGgMj1rPQ6S2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,196,1774310400"; 
   d="scan'208";a="477834153"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 09 Jun 2026 16:32:50 +0000
Received: from [127.0.0.1] (unknown [10.25.128.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id 5BCA718000275;
	Tue,  9 Jun 2026 16:32:49 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Tue, 09 Jun 2026 09:32:30 -0700
Subject: [PATCH net-next v8 04/10] enic: add admin CQ service with MSI-X
 interrupt and workqueue polling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-enic-sriov-v2-admin-channel-v2-v8-4-8ad8babbb826@cisco.com>
References: <20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com>
In-Reply-To: <20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781022766; l=14028;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=8g9ux5CGmu4ks4G+DJiJBQLaQsJq8am4LOOoYftX1jg=;
 b=u2mJiseO0a1FIvS/RmfQBJjDbfcRhKkvfnSPAsTJ2hz8My4V11qDgiSgt2mczLehAkkZOlcLM
 3Zr7nvr74KFCNNQ44BL6VL9tAI6YsSDq+4rxHCuXob0kvDFgw/NOQJl
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297174-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76F3F662C9A

Add completion queue (CQ) service for the admin channel work queue
(WQ) and receive queue (RQ), driven by a dedicated MSI-X interrupt
and a workqueue-based CQ poller.

The admin WQ CQ service advances the completion ring and returns the
number of descriptors consumed.  The admin RQ CQ service does the
same for receive completions and copies each received message into a
preallocated buffer.  Received messages are enqueued for deferred
dispatch by a separate work_struct so the CQ poller stays short.

When the MSI-X interrupt fires, the ISR schedules the CQ poll
work_struct.  The work handler drains all pending completions, kicks
message dispatch if work was done, and returns credits to unmask the
interrupt.

Log a rate-limited warning when admin RQ buffer refill fails so that
transient memory pressure is visible without flooding the log.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h       |   7 +
 drivers/net/ethernet/cisco/enic/enic_admin.c | 281 ++++++++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_admin.h |  12 ++
 3 files changed, 296 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 08472420f3a1..42f2ac3df212 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -296,6 +296,13 @@ struct enic {
 	struct vnic_rq admin_rq;
 	struct vnic_cq admin_cq[2];
 	struct vnic_intr admin_intr;
+	struct work_struct admin_poll_work;
+	unsigned int admin_intr_index;
+	struct work_struct admin_msg_work;
+	spinlock_t admin_msg_lock;	/* protects admin_msg_list */
+	struct list_head admin_msg_list;
+	void (*admin_rq_handler)(struct enic *enic, void *buf,
+				 unsigned int len);
 };
 
 static inline struct net_device *vnic_get_netdev(struct vnic_dev *vdev)
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index b28fc6c656cc..bfd73f443d0f 100644
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
 
@@ -94,6 +96,225 @@ static void enic_admin_rq_drain(struct enic *enic)
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
+	if (!msg)
+		return;
+
+	msg->len = len;
+	memcpy(msg->data, buf, len);
+
+	spin_lock(&enic->admin_msg_lock);
+	list_add_tail(&msg->list, &enic->admin_msg_list);
+	spin_unlock(&enic->admin_msg_lock);
+}
+
+unsigned int enic_admin_rq_cq_service(struct enic *enic)
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
+	while (enic_admin_cq_color(desc, cq->ring.desc_size) !=
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
+	if (enic_admin_rq_fill(enic, GFP_ATOMIC) && net_ratelimit())
+		netdev_warn(enic->netdev,
+			    "admin RQ refill failed\n");
+
+	return work;
+}
+
+static irqreturn_t enic_admin_isr_msix(int irq, void *data)
+{
+	struct enic *enic = data;
+
+	schedule_work(&enic->admin_poll_work);
+
+	return IRQ_HANDLED;
+}
+
+static void enic_admin_msg_work_handler(struct work_struct *work)
+{
+	struct enic *enic = container_of(work, struct enic, admin_msg_work);
+	struct enic_admin_msg *msg, *tmp;
+	LIST_HEAD(local_list);
+
+	spin_lock_bh(&enic->admin_msg_lock);
+	list_splice_init(&enic->admin_msg_list, &local_list);
+	spin_unlock_bh(&enic->admin_msg_lock);
+
+	list_for_each_entry_safe(msg, tmp, &local_list, list) {
+		if (enic->admin_rq_handler)
+			enic->admin_rq_handler(enic, msg->data, msg->len);
+		list_del(&msg->list);
+		kfree(msg);
+	}
+}
+
+static void enic_admin_poll_work_handler(struct work_struct *work)
+{
+	struct enic *enic = container_of(work, struct enic, admin_poll_work);
+	unsigned int credits;
+	unsigned int rq_work;
+
+	credits = vnic_intr_credits(&enic->admin_intr);
+
+	rq_work = enic_admin_rq_cq_service(enic);
+
+	if (rq_work > 0)
+		schedule_work(&enic->admin_msg_work);
+
+	vnic_intr_return_credits(&enic->admin_intr,
+				 credits ?: 1,
+				 1 /* unmask */, 0);
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
+	enic->msix[intr_index].devid = enic;
+
+	err = request_irq(enic->msix_entry[intr_index].vector,
+			  enic->msix[intr_index].isr, 0,
+			  enic->msix[intr_index].devname,
+			  enic->msix[intr_index].devid);
+	if (err) {
+		netdev_warn(enic->netdev,
+			    "Failed to request admin MSI-X irq: %d\n", err);
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
+	free_irq(enic->msix_entry[intr_index].vector,
+		 enic->msix[intr_index].devid);
+	cancel_work_sync(&enic->admin_poll_work);
+	enic->msix[intr_index].requested = 0;
+}
+
 static int enic_admin_qp_type_set(struct enic *enic, u32 enable)
 {
 	u64 a0 = QP_TYPE_ADMIN, a1 = enable;
@@ -173,6 +394,7 @@ static int enic_admin_alloc_resources(struct enic *enic)
 
 static void enic_admin_free_resources(struct enic *enic)
 {
+	vnic_intr_free(&enic->admin_intr);
 	vnic_cq_free(&enic->admin_cq[1]);
 	vnic_cq_free(&enic->admin_cq[0]);
 	vnic_rq_free(&enic->admin_rq);
@@ -181,6 +403,8 @@ static void enic_admin_free_resources(struct enic *enic)
 
 static void enic_admin_init_resources(struct enic *enic)
 {
+	unsigned int intr_offset = enic->admin_intr_index;
+
 	vnic_wq_init(&enic->admin_wq,
 		     0, 0, 0); /* cq_index, err_intr_enable, err_intr_offset */
 	vnic_rq_init(&enic->admin_rq,
@@ -189,20 +413,34 @@ static void enic_admin_init_resources(struct enic *enic)
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
@@ -220,6 +458,19 @@ int enic_admin_channel_open(struct enic *enic)
 		return err;
 	}
 
+	spin_lock_init(&enic->admin_msg_lock);
+	INIT_LIST_HEAD(&enic->admin_msg_list);
+	INIT_WORK(&enic->admin_msg_work, enic_admin_msg_work_handler);
+	INIT_WORK(&enic->admin_poll_work, enic_admin_poll_work_handler);
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
@@ -239,15 +490,29 @@ int enic_admin_channel_open(struct enic *enic)
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
@@ -259,6 +524,13 @@ void enic_admin_channel_close(struct enic *enic)
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
@@ -274,5 +546,6 @@ void enic_admin_channel_close(struct enic *enic)
 	enic_admin_rq_drain(enic);
 	vnic_cq_clean(&enic->admin_cq[0]);
 	vnic_cq_clean(&enic->admin_cq[1]);
+	vnic_intr_clean(&enic->admin_intr);
 	enic_admin_free_resources(enic);
 }
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.h b/drivers/net/ethernet/cisco/enic/enic_admin.h
index 569aadeb9312..3dab48c00cd3 100644
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
+unsigned int enic_admin_rq_cq_service(struct enic *enic);
 
 #endif /* _ENIC_ADMIN_H_ */

-- 
2.43.0


