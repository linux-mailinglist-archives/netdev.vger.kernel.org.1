Return-Path: <netdev+bounces-300296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DTfPCClRM2rI/QUAu9opvQ
	(envelope-from <netdev+bounces-300296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 04:00:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7716269D180
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 04:00:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=GZcNVxhJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300296-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300296-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 722CC30ED711
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 01:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2A42E8DEC;
	Thu, 18 Jun 2026 01:54:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A470B2BE043;
	Thu, 18 Jun 2026 01:54:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781747648; cv=none; b=DmgkRb51nkx/zCmzjkTVPtHLj6+GyW6b8KMEniVxD+LDdYU81VZCb4EkKhkw0QytxBshGGO+YvH+9xsrVojwhRLBsecBcCqykJJHHaUvMuFiIR51Wu5sHXhfpcBchXtfaisHFX4/EshHkJovlvLeWw6EBKS295womGq2pweVnP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781747648; c=relaxed/simple;
	bh=LjrtgnczNNy1M5OnxQqy5d/xC1ncnEQgJRSvKIuUtYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hFTkENwYe97zQ5sb7RiOAXhZ+G3aB/uws66+hpaTKgcv0MUL9051urAOclWRj5NkDaMjJDLglENa26/93SNyg7cF22CJwKcLCJpSB1EgPdyJNrlV9Pi4Kg3PX7ECXA4rcQgGQFl4vppAED3n8nWfUXc/AoRjOY9HfG47zO6ZejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=GZcNVxhJ; arc=none smtp.client-ip=173.37.86.80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=10730; q=dns/txt;
  s=iport01; t=1781747640; x=1782957240;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=LUq4QXRPrJ0cavUApNEfE7yfTUK3cQ4NI94yh6Ny8n4=;
  b=GZcNVxhJY0F+a5deJKPykkynFI9hLh/SWlkAyenbcVtxc52j42dq1dnw
   oKLMLB4dvZn5CAVStzGqA8EnB0jvGz0BpBqOb0D+qCaawfs/WgJONuUQ5
   3EKsHRBQwBfkYPy/x7ieliutIHERWwJK5NpC38jz8++1B5623h4X7dpaj
   uzWGvE2KYRuW5GdCjR/ScKsGUVLS+5yNMCJ+6I5ns0AY20KAgIb55ysLW
   xaq179Q0tgeVI3IOKmDGZrQOpWGypI3aZjCyPcmLUVqEjuP1J9eanA/Qo
   EW7O6UgJUrIZUm7TClshAOBG5QJ5YIdSz527VeehOtMwZgh/VD0tGV+zy
   A==;
X-CSE-ConnectionGUID: s7aSTeBfQ2W6FXB7DnB15g==
X-CSE-MsgGUID: u1V3Fe5CRdilwUBOPLr1Ag==
X-IPAS-Result: =?us-ascii?q?A0BIAgD4TjNq/4r/Ja1QCoJZgleBUkNJhFePU4IhgRadC?=
 =?us-ascii?q?BSBag8BAQEPUQQBAYUGAo1EAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQsBAQUBA?=
 =?us-ascii?q?QECAQcFgQ4ThlyGWwIBAyMECwFGECUCJgICRQEQBgESgwKCdAOyanp/M4EBh?=
 =?us-ascii?q?H3ZRoFmAQsUAYEKLoVxgmoBgXCEBjuEQScbgUlEgRQBgnN2hAUBEAkLg3SCa?=
 =?us-ascii?q?gSDHBKBWCB/jjAJP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCFBwTDwQWM?=
 =?us-ascii?q?h1wDCcSLBc0WBsHBYEegScvBCGBA4UDIx8DOX+BbYElZ2YVMDWBAQERHwqBG?=
 =?us-ascii?q?wMLGA1IESw3Bg4bBD0BbgeMeRcPgUxqBwGBDQETaDMOIzAEMRksFwKWYY5Ko?=
 =?us-ascii?q?Q+EJ4FmjFuTNAEyl2eTBZkII6NJboRogWg8gVkzGggbFYMiUxkPji0WHMlFJ?=
 =?us-ascii?q?zI9AQEHAgcOAwuBaJACDxcHgU4BAQ?=
IronPort-Data: A9a23:8QTf8Kg5RxLuTW7xCeT+zIKnX161oBEKZh0ujC45NGQN5FlHY01je
 htvWWCFM/7fMWP0Kdp2b9vkoE5QuZSBzN9jGgRpriEwHnhjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOOn9SUgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZeDULOZ82QsaDxMtfvc8E8HUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUDpe9MPWxk+
 8VCF24jXjrcq+Scme+0H7wEasQLdKEHPasFsX1miDWcBvE8TNWbGuPB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWYQd/5JEWxI9EglHkeiFZs1KWpYI84nPYy0p6172F3N/9Jo3XHp0PxBnBz
 o7A13mgPEo0OYG08zaE9m2RrMj3uTmicY1HQdVU8dYv2jV/3Fc7BBQIWF6TrfCnh0u6XNxDb
 UoZ5kIGoKQv8UW5Q8XVUBq/r3qJ+BUbXrJ4EPAw4SmOx7DS7gLfAXILJhZIbtA8udB1QzE22
 lKXt9f0Azopu739YWqU/LqSrBuoNCQVJHNEbigBJSMB4t/+sMQwgwjJQ9JLDqG4lJv2FCv2z
 jTMqzIx750VgNIH2ruT41/KmXSvq4LPQwpz4R/YNl9J9Stjb4KjIojt4l/B4LMYdcCST0KKu
 z4PnM32AP0yMKxhXRelGI0ldIxFLd7cWNEAqTaDx6Ucygk=
IronPort-HdrOrdr: A9a23:2OSLHqCWiO5VWfblHela55DYdb4zR+YMi2TDGXoBLSC9Ffb4qy
 nOppomPHDP5Qr5NEtLpTnEAtjjfZq+z/FICPcqXYtKNTOO0ACVxcNZnOjfKlbbdxEWmNQtsJ
 tIQuxSBML9CF5igd2/wgWpeuxQueWvweSEifjTynF1QRovUaFv6A9lFh2We3cGIjWufaBJc6
 a0145guyeqf2gRY4CQA3kIWPWGmvjw/aiWGSLvw3UcmXOzZfTC0s+ALySl
X-Talos-CUID: 9a23:51UAMW5RxOXTATtUB9ss7xEdIfwoWHPklkiODX+SVkpvYuTIRgrF
X-Talos-MUID: 9a23:qRefwQQoRrYHv7eLRXTx3Q85Gso1yJ6iCUQSrL8hg+2ebAV/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,210,1774310400"; 
   d="scan'208";a="495302271"
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Jun 2026 01:53:53 +0000
Received: from [127.0.0.1] (unknown [10.25.128.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id 073D11800030F;
	Thu, 18 Jun 2026 01:53:52 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Wed, 17 Jun 2026 18:53:29 -0700
Subject: [PATCH net-next v9 06/10] enic: add MBOX core send and receive for
 admin channel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-enic-sriov-v2-admin-channel-v2-v9-6-37f5f5af4c93@cisco.com>
References: <20260617-enic-sriov-v2-admin-channel-v2-v9-0-37f5f5af4c93@cisco.com>
In-Reply-To: <20260617-enic-sriov-v2-admin-channel-v2-v9-0-37f5f5af4c93@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781747628; l=11165;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=LjrtgnczNNy1M5OnxQqy5d/xC1ncnEQgJRSvKIuUtYo=;
 b=qJWGv3amu936/JI8D4esQjhG9u8aUqodC/S3rLFZ6gg+GicJoQAiThH0zPnoES6RowFuHESxT
 WRqGj9yCfiVCW4I4OdDNC7oqfJCB+K5P/uXYapQ9tNnZNTViShoJxQo
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300296-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7716269D180

Implement the mailbox protocol engine used for PF-VF communication
over the admin channel.

The send path (enic_mbox_send_msg) builds a message with a common
header, DMA-maps it, posts a single WQ descriptor with the
destination vnic ID encoded in the VLAN tag field, and polls
the WQ CQ for completion.

MBOX sends are gated by enic->mbox_send_disabled: enic_mbox_send_msg()
returns early while it is set. The flag is cleared in
enic_admin_channel_open() only once the admin WQ/RQ/CQ and interrupt
are fully programmed, and set again at the start of
enic_admin_channel_close(), so a send can never race a not-yet-ready
or torn-down admin channel.

The receive path (enic_mbox_recv_handler) is installed as the admin
RQ callback and validates incoming message headers. PF/VF-specific
dispatch will be added in subsequent commits.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/Makefile     |   2 +-
 drivers/net/ethernet/cisco/enic/enic.h       |   6 +
 drivers/net/ethernet/cisco/enic/enic_admin.c |  35 +++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c  | 170 +++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_mbox.h  |   8 ++
 5 files changed, 218 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/Makefile b/drivers/net/ethernet/cisco/enic/Makefile
index 7ae72fefc99a..e38aaf34c148 100644
--- a/drivers/net/ethernet/cisco/enic/Makefile
+++ b/drivers/net/ethernet/cisco/enic/Makefile
@@ -4,5 +4,5 @@ obj-$(CONFIG_ENIC) := enic.o
 enic-y := enic_main.o vnic_cq.o vnic_intr.o vnic_wq.o \
 	enic_res.o enic_dev.o enic_pp.o vnic_dev.o vnic_rq.o vnic_vic.o \
 	enic_ethtool.o enic_api.o enic_clsf.o enic_rq.o enic_wq.o \
-	enic_admin.o
+	enic_admin.o enic_mbox.o
 
diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 42f2ac3df212..1d6a88d7f8ac 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -292,6 +292,8 @@ struct enic {
 
 	/* Admin channel resources for SR-IOV MBOX */
 	bool has_admin_channel;
+	/* set on send timeout; cleared on channel re-open */
+	bool mbox_send_disabled;
 	struct vnic_wq admin_wq;
 	struct vnic_rq admin_rq;
 	struct vnic_cq admin_cq[2];
@@ -303,6 +305,10 @@ struct enic {
 	struct list_head admin_msg_list;
 	void (*admin_rq_handler)(struct enic *enic, void *buf,
 				 unsigned int len);
+
+	/* MBOX protocol state — mbox_lock serializes admin WQ sends */
+	struct mutex mbox_lock;
+	u64 mbox_msg_num;
 };
 
 static inline struct net_device *vnic_get_netdev(struct vnic_dev *vdev)
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index ec85fd446d02..8edf7ad4557d 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -19,6 +19,7 @@
 #include "cq_enet_desc.h"
 #include "wq_enet_desc.h"
 #include "rq_enet_desc.h"
+#include "enic_mbox.h"
 
 /* Clean up any admin WQ buffers still held by hardware at close time.
  * Normally buffers are freed inline after send completion, but a timed-out
@@ -191,7 +192,26 @@ unsigned int enic_admin_rq_cq_service(struct enic *enic)
 			goto next_desc;
 		}
 
-		enic_admin_msg_enqueue(enic, buf->os_buf, bytes_written);
+		if (enic->admin_rq_handler) {
+			u16 sender_vlan;
+
+			/* Firmware sets the CQ VLAN field to identify the
+			 * sender: 0 = PF, 1-based = VF index.  Overwrite
+			 * the untrusted src_vnic_id in the MBOX header with
+			 * the hardware-verified value.
+			 */
+			sender_vlan = le16_to_cpu(rq_desc->vlan);
+			if (bytes_written >= sizeof(struct enic_mbox_hdr)) {
+				struct enic_mbox_hdr *hdr = buf->os_buf;
+
+				hdr->src_vnic_id = (sender_vlan == 0) ?
+					cpu_to_le16(ENIC_MBOX_DST_PF) :
+					cpu_to_le16(sender_vlan - 1);
+			}
+
+			enic_admin_msg_enqueue(enic, buf->os_buf,
+					       bytes_written);
+		}
 
 next_desc:
 		enic_admin_rq_buf_clean(rq, rq->to_clean);
@@ -428,8 +448,9 @@ static void enic_admin_init_resources(struct enic *enic)
 		     VNIC_CQ_MSG_DISABLE,
 		     intr_offset,
 		     0 /* cq_message_addr */);
+	/* coalescing_timer, coalescing_type, mask_on_assertion */
 	vnic_intr_init(&enic->admin_intr,
-		       0, 0, 1); /* coalescing_timer, coalescing_type, mask_on_assertion */
+		       0, 0, 1);
 }
 
 static void enic_admin_msg_drain(struct enic *enic)
@@ -493,6 +514,14 @@ int enic_admin_channel_open(struct enic *enic)
 
 	vnic_intr_unmask(&enic->admin_intr);
 
+	/* Only now that the admin WQ/RQ/CQ and interrupt are fully allocated,
+	 * programmed and enabled is it safe to allow MBOX sends.  Clearing this
+	 * earlier opened a window where a concurrent sender (e.g. link-notify
+	 * work scheduled by a post-reset link-up) could call enic_mbox_send_msg()
+	 * against a not-yet-allocated admin_wq and crash.
+	 */
+	WRITE_ONCE(enic->mbox_send_disabled, false);
+
 	netdev_dbg(enic->netdev,
 		   "admin channel open: intr=%u wq_avail=%u rq_avail=%u cq0_color=%u cq1_color=%u\n",
 		   enic->admin_intr_index,
@@ -525,6 +554,8 @@ void enic_admin_channel_close(struct enic *enic)
 	if (!enic->has_admin_channel)
 		return;
 
+	WRITE_ONCE(enic->mbox_send_disabled, true);
+
 	netdev_dbg(enic->netdev, "admin channel close\n");
 
 	vnic_intr_mask(&enic->admin_intr);
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
new file mode 100644
index 000000000000..3709704bee02
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2025 Cisco Systems, Inc.  All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+
+#include "vnic_dev.h"
+#include "vnic_wq.h"
+#include "vnic_cq.h"
+#include "enic.h"
+#include "enic_admin.h"
+#include "enic_mbox.h"
+#include "wq_enet_desc.h"
+
+#define ENIC_MBOX_POLL_TIMEOUT_US	5000000
+#define ENIC_MBOX_POLL_INTERVAL_US	100
+
+static void enic_mbox_fill_hdr(struct enic *enic, struct enic_mbox_hdr *hdr,
+			       u8 msg_type, u16 dst_vnic_id, u16 msg_len)
+{
+	memset(hdr, 0, sizeof(*hdr));
+	hdr->dst_vnic_id = cpu_to_le16(dst_vnic_id);
+	hdr->msg_type = msg_type;
+	hdr->msg_len = cpu_to_le16(msg_len);
+	hdr->msg_num = cpu_to_le64(++enic->mbox_msg_num);
+}
+
+int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
+		       void *payload, u16 payload_len)
+{
+	u16 total_len = sizeof(struct enic_mbox_hdr) + payload_len;
+	struct vnic_wq *wq = &enic->admin_wq;
+	struct wq_enet_desc *desc;
+	unsigned long timeout;
+	dma_addr_t dma_addr;
+	u16 vlan_tag;
+	void *buf;
+	int err;
+
+	/* Serialize MBOX sends. The admin channel is a low-frequency
+	 * control path; holding the mutex across the poll is acceptable.
+	 */
+	mutex_lock(&enic->mbox_lock);
+
+	if (!enic->has_admin_channel || READ_ONCE(enic->mbox_send_disabled)) {
+		err = -ENODEV;
+		goto unlock;
+	}
+
+	if (vnic_wq_desc_avail(wq) == 0) {
+		err = -ENOSPC;
+		goto unlock;
+	}
+
+	buf = kmalloc(total_len, GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	enic_mbox_fill_hdr(enic, buf, msg_type, dst_vnic_id, total_len);
+	if (payload_len) {
+		void *dst = buf + sizeof(struct enic_mbox_hdr);
+
+		memcpy(dst, payload, payload_len);
+	}
+
+	dma_addr = dma_map_single(&enic->pdev->dev, buf, total_len,
+				  DMA_TO_DEVICE);
+	if (dma_mapping_error(&enic->pdev->dev, dma_addr)) {
+		kfree(buf);
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	/* Firmware uses vlan field for routing: 0 = PF, 1-based = VF index */
+	if (dst_vnic_id == ENIC_MBOX_DST_PF)
+		vlan_tag = 0;
+	else
+		vlan_tag = dst_vnic_id + 1;
+
+	desc = vnic_wq_next_desc(wq);
+	wq_enet_desc_enc(desc, (u64)dma_addr | VNIC_PADDR_TARGET,
+			 total_len,
+			 0, 0, 0,       /* mss, hdr_len, offload_mode */
+			 1, 1,          /* eop, cq_entry */
+			 0,             /* fcoe_encap */
+			 1, vlan_tag,   /* vlan_tag_insert, vlan_tag */
+			 0);            /* loopback */
+	vnic_wq_post(wq, buf, dma_addr, total_len,
+		     1, 1,              /* sop, eop */
+		     1, 1,              /* desc_skip_cnt, cq_entry */
+		     0, 0);             /* compressed_send, wrid */
+	vnic_wq_doorbell(wq);
+
+	timeout = jiffies + usecs_to_jiffies(ENIC_MBOX_POLL_TIMEOUT_US);
+	err = -ETIMEDOUT;
+	while (time_before(jiffies, timeout)) {
+		if (enic_admin_wq_cq_service(enic)) {
+			err = 0;
+			break;
+		}
+		usleep_range(ENIC_MBOX_POLL_INTERVAL_US,
+			     ENIC_MBOX_POLL_INTERVAL_US + 50);
+	}
+	/* Final check in case completion arrived during the last sleep */
+	if (err && enic_admin_wq_cq_service(enic))
+		err = 0;
+
+	if (!err) {
+		wq->to_clean = wq->to_clean->next;
+		wq->ring.desc_avail++;
+		dma_unmap_single(&enic->pdev->dev, dma_addr, total_len,
+				 DMA_TO_DEVICE);
+		kfree(buf);
+	} else {
+		netdev_err(enic->netdev,
+			   "MBOX send timed out (type %u dst %u), disabling channel\n",
+			   msg_type, dst_vnic_id);
+		/*
+		 * The WQ descriptor is still live in hardware. Do not unmap
+		 * or free the buffer: the device may still DMA from dma_addr.
+		 * Mark the channel unusable so no further sends are attempted.
+		 */
+		WRITE_ONCE(enic->mbox_send_disabled, true);
+	}
+
+	netdev_dbg(enic->netdev,
+		   "MBOX send msg_type %u dst %u vlan %u err %d\n",
+		   msg_type, dst_vnic_id, vlan_tag, err);
+unlock:
+	mutex_unlock(&enic->mbox_lock);
+	return err;
+}
+
+static void enic_mbox_recv_handler(struct enic *enic, void *buf,
+				   unsigned int len)
+{
+	struct enic_mbox_hdr *hdr = buf;
+
+	if (len < sizeof(*hdr)) {
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: truncated message (len %u < %zu)\n",
+				    len, sizeof(*hdr));
+		return;
+	}
+
+	if (hdr->msg_type >= ENIC_MBOX_MAX) {
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: unknown msg type %u\n",
+				    hdr->msg_type);
+		return;
+	}
+
+	netdev_dbg(enic->netdev,
+		   "MBOX recv: type %u from vnic %u len %u\n",
+		   hdr->msg_type, le16_to_cpu(hdr->src_vnic_id),
+		   le16_to_cpu(hdr->msg_len));
+}
+
+void enic_mbox_init(struct enic *enic)
+{
+	enic->mbox_msg_num = 0;
+	mutex_init(&enic->mbox_lock);
+	enic->admin_rq_handler = enic_mbox_recv_handler;
+}
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.h b/drivers/net/ethernet/cisco/enic/enic_mbox.h
index a52f1d25cb21..73fd7f783ee2 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.h
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.h
@@ -80,4 +80,12 @@ struct enic_mbox_pf_link_state_ack_msg {
 	struct enic_mbox_generic_reply ack;
 };
 
+#define ENIC_MBOX_DST_PF	0xFFFF
+
+struct enic;
+
+void enic_mbox_init(struct enic *enic);
+int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
+		       void *payload, u16 payload_len);
+
 #endif /* _ENIC_MBOX_H_ */

-- 
2.43.0


