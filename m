Return-Path: <netdev+bounces-304649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id koq9Om77R2r5iQAAu9opvQ
	(envelope-from <netdev+bounces-304649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:11:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F09A704C90
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:11:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=dCMo9PcZ;
	dmarc=pass (policy=reject) header.from=cisco.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304649-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304649-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 533B5303F46B
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 18:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C7131E848;
	Fri,  3 Jul 2026 18:10:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7431B131;
	Fri,  3 Jul 2026 18:10:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102212; cv=none; b=G+ESmoqX/XF6LmzggMRUDvRyanygHqgAAnd9afhMh7vTqI6aputyrCmt441RbCTUNFq4t3PBxSwIuvb9cdWubkiU26nZcYI1PI8SKCn7GyaQwE2ZbUlL5mNw26at9zJWgqrX7MD79vPX3k1hxIvEqrO9a3vPPgNL5aq0S1BLAcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102212; c=relaxed/simple;
	bh=XKmxGbgJ6OtD4WdMxcJtNFPeVAzWvG5iePE4m79iwtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A2F6qs6uBeckf+eO55RpIpwqqDX78YW4pVXd1us6X9GBvkJx35vrBn33hx0+5jhxdm6N/FbyQZix0wwlAnN/63Zi/udiDV7uoJHkD6uUl0xlUTlhH/hw1TMXbDJQUHA015ykwQjPkZX9OsO1lahXIHo9/B3Zdy3NwR5YwrRN8QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=dCMo9PcZ; arc=none smtp.client-ip=173.37.86.80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11529; q=dns/txt;
  s=iport01; t=1783102209; x=1784311809;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=WTMnLzvsPchHlZe3PsMJfphHoqBGiAyAucRJv2XhpMA=;
  b=dCMo9PcZsOhBfOQMbO0Uh7nLHcTXe6Oi2UxdMXr36zde0Pb2jC3dEIwD
   Gf0bs4+VznpmLeR1ubUIPPCKPHvyW1+f5gDOMKmMEYmajoINCOPcxooG7
   2gBu2K5JN9cjhpFfLQEywUvaVnmtKJUdNlQwh8Gd4RbVeP9An1pAZP0zC
   BzwdJdUfq1z4kuq8fm+MjdIVFAfHUaTXTBhjpghYIeLbMM1WJd3Y0nstk
   W74/E1rsX11LeHNyRyZM7aYKpTFpti+rOxntrfX7BYKbJ5N1jnmYIpgBi
   Gg/qCyI1vFVfdVDHl4FJUGPbZVXP1l6ddJqeFkSv9LKVFSz+qpoRPkBVA
   A==;
X-CSE-ConnectionGUID: boxkPcjHSbS1kNzcIJjB9A==
X-CSE-MsgGUID: 0cR0sprYR4+ps66HAS1rfg==
X-IPAS-Result: =?us-ascii?q?A0BHAgBV+Udq/5P/Ja1QCh4BAQsSDIIFC4JXgVJDSYRXj?=
 =?us-ascii?q?1OCIYEWnQgUgWoPAQEBD1EEAQGFBgKNSwImNAkOAQIEAwIDAQEBAQEBAQEBA?=
 =?us-ascii?q?QELAQEFAQEBAgEHBYEOE4ZchlsCAQMjBAsBRhAlAiYCAkUBEAYBEoMCgnQDv?=
 =?us-ascii?q?AV6fzOBAYR92UaBZgELFAGBCi6FcYJqAYFwhAY7hEEnG4FJRIEUAYJzdoQFA?=
 =?us-ascii?q?RAJC4N0gmoEgxwSgVggaY4+CT+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSEhgVA?=
 =?us-ascii?q?hQcEw8EFjIdcAwnEiwXNFgbBwWBHYEVMQQhgQSEeSMfAzl/gTB1SnkzgQIBE?=
 =?us-ascii?q?h4KgVKBJgMLGA1IESw3Bg4bBD0BbgeNABcPgUxqBwE8HSEJCgETaDMOIzAEM?=
 =?us-ascii?q?RksFwKWYY5KoQ+EJ4FmjFuTNAEyl2eTBZkII6NJBmiEaIFoPIFZMxoIGxWDI?=
 =?us-ascii?q?lMZD44tFhzSHicyPQIHAgcOAwuRag8XB4FOAQE?=
IronPort-Data: A9a23:AEGIQK6QRCLarPhNyZ7MTQxRtPjGchMFZxGqfqrLsTDasY5as4F+v
 jBKUW/QOf2PZmXzethwbYi2pE4BsJ7QmNUySAJl/i48Zn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH2dOC98RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wo/qUzBHf/g2Qqaj1MsPrZwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eN4oI+d58A0F1/
 8dBKxYfZTGhhcjn6efuIgVsrpxLwMjDJogTvDRkiDreF/tjGMiFSKTR7tge1zA17ixMNa+BP
 IxCNnw1MUmGOkEQUrsUIMpWcOOAnXDjciZYq1K9rqss6G+Vxwt0uFToGIeNIYLRGpoLxS50o
 Eqe9F6hGQkABebDiiKerCyMr9SWhy30Ddd6+LqQs6QCbEeo7mAaFhATfVeyv/S8jkmwR5RZJ
 lB80icisK075kG3Ztb6WBK8rTiPuRt0c9lNGeQS6wyXzKfQpQGDCQAsRzhNctE598k7WTAny
 HeNgtXvQzdv2JWNQHiQ8La8tz6+OSEJa2QFYEcsSQoD/smmo4wpiB/LZshsHbTzjdDvHzz0h
 TeQo0AWgbgPgcMV/7u08EqBgD+2oJXNCAkv6W3qsnmN9Ah1YsuhIoev81WetK4GJ4eCRV7Ht
 38B8ySD0N0z4Vi2vHTlaI0w8HuBvp5p7BW0bYZTIqQc
IronPort-HdrOrdr: A9a23:zuYUqK2/oVsXeVlHM85kDQqjBEQkLtp133Aq2lEZdPWaSL39qy
 nIppUmPH7P5gr5N0tMpTntAsO9qDbnhPxICOoqUotKIjOHhILAFugLhrcKgQeQeBEWndQw6U
 4PSdkaNPTASXV3ksr+5hC1CJIDzMnvytHQuc7ui1pgUg1ubbht9ENCCgidGlBrXwUuP+teKH
 Pl3LshmxOQPVIKc8+8Gn4JG8LHp9HNidbaRCRuPW9e1OFL5gnYkoIT1HOjr2wjbw8=
X-Talos-CUID: =?us-ascii?q?9a23=3A8PQiGGijrRU4uIiLA7k3AlszhzJueHrNz0/bIW+?=
 =?us-ascii?q?DA10wS5uHQn6y+ok1up87?=
X-Talos-MUID: 9a23:JHWa9QZemmYXp+BT7zTW3Cp6LvZSv+e2Ex5Tsbw94tOKOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,145,1779148800"; 
   d="scan'208";a="503637763"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Jul 2026 18:09:00 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTPS id 11453180008A1;
	Fri,  3 Jul 2026 18:09:00 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Fri, 03 Jul 2026 11:08:56 -0700
Subject: [PATCH net-next v11 07/12] enic: add MBOX core send and receive
 for admin channel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260703-enic-sriov-v2-admin-channel-v2-v11-7-5b739f1fe9e5@cisco.com>
References: <20260703-enic-sriov-v2-admin-channel-v2-v11-0-5b739f1fe9e5@cisco.com>
In-Reply-To: <20260703-enic-sriov-v2-admin-channel-v2-v11-0-5b739f1fe9e5@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783102134; l=11981;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=XKmxGbgJ6OtD4WdMxcJtNFPeVAzWvG5iePE4m79iwtE=;
 b=T1SuIzdMrWRqTbQNAYdePnBrYCztSozsZhlMZg7KWRcUqD+K8ORi1X/X5nBsCnVpYrBnDe3mC
 nUPqzDYWsIMDGtf4TbP4sJTb0R8WGedCFrHY46zTv5jyCXTMlkUYB7+
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-10.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304649-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,cisco.com:from_mime,cisco.com:email,cisco.com:mid,cisco.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F09A704C90

Implement the mailbox protocol engine used for PF-VF communication
over the admin channel.

The send path (enic_mbox_send_msg) builds a message with a common
header, DMA-maps it, posts a single WQ descriptor with the
destination vnic ID encoded in the VLAN tag field, and polls
the WQ CQ for completion.

MBOX sends are gated by enic->mbox_send_disabled: enic_mbox_send_msg()
returns early while it is set.  It is set at the very start of both
enic_admin_channel_open() and enic_admin_channel_close(), and is
cleared in enic_admin_channel_open() only once the admin WQ/RQ/CQ and
interrupt are fully allocated, programmed and enabled.  Keeping it set
for the whole open sequence means an early failure that returns before
the channel is ready (as well as a not-yet-ready or torn-down channel)
leaves sends disabled, so a concurrent sender can never race an MBOX
send against a half-open or freed admin_wq.

The receive path (enic_mbox_recv_handler) is installed as the admin
RQ callback and validates incoming message headers. PF/VF-specific
dispatch will be added in subsequent commits.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/Makefile     |   2 +-
 drivers/net/ethernet/cisco/enic/enic.h       |   6 +
 drivers/net/ethernet/cisco/enic/enic_admin.c |  42 ++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c  | 170 +++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_mbox.h  |   8 ++
 5 files changed, 225 insertions(+), 3 deletions(-)

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
index 401123e6df1d..b009d87da4bd 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -297,6 +297,8 @@ struct enic {
 	 * left the resources freed.
 	 */
 	bool admin_chan_up;
+	/* set on send timeout; cleared on channel re-open */
+	bool mbox_send_disabled;
 	struct vnic_wq admin_wq;
 	struct vnic_rq admin_rq;
 	struct vnic_cq admin_cq[2];
@@ -309,6 +311,10 @@ struct enic {
 	unsigned int admin_msg_count;	/* current depth of admin_msg_list */
 	void (*admin_rq_handler)(struct enic *enic, void *buf,
 				 unsigned int len);
+
+	/* MBOX protocol state — mbox_lock serializes admin WQ sends */
+	struct mutex mbox_lock;
+	u64 mbox_msg_num;
 };
 
 static inline struct net_device *vnic_get_netdev(struct vnic_dev *vdev)
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index c9b19ed002fb..4b279a142042 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -19,6 +19,7 @@
 #include "cq_enet_desc.h"
 #include "wq_enet_desc.h"
 #include "rq_enet_desc.h"
+#include "enic_mbox.h"
 
 /* Clean up any admin WQ buffers still held by hardware at close time.
  * Normally buffers are freed inline after send completion, but a timed-out
@@ -213,7 +214,26 @@ unsigned int enic_admin_rq_cq_service(struct enic *enic)
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
@@ -467,8 +487,9 @@ static void enic_admin_init_resources(struct enic *enic)
 		     VNIC_CQ_MSG_DISABLE,
 		     intr_offset,
 		     0 /* cq_message_addr */);
+	/* coalescing_timer, coalescing_type, mask_on_assertion */
 	vnic_intr_init(&enic->admin_intr,
-		       0, 0, 1); /* coalescing_timer, coalescing_type, mask_on_assertion */
+		       0, 0, 1);
 }
 
 static void enic_admin_msg_drain(struct enic *enic)
@@ -491,6 +512,13 @@ int enic_admin_channel_open(struct enic *enic)
 	if (!enic->has_admin_channel)
 		return -ENODEV;
 
+	/* Keep MBOX sends disabled for the entire open sequence.  It is
+	 * cleared only after every resource is allocated and enabled below,
+	 * so any early error return here leaves sends disabled and a
+	 * concurrent sender cannot touch a half-open or freed admin_wq.
+	 */
+	WRITE_ONCE(enic->mbox_send_disabled, true);
+
 	err = enic_admin_alloc_resources(enic);
 	if (err) {
 		netdev_err(enic->netdev,
@@ -533,6 +561,14 @@ int enic_admin_channel_open(struct enic *enic)
 
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
@@ -574,6 +610,8 @@ void enic_admin_channel_close(struct enic *enic)
 	if (!enic->admin_chan_up)
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


