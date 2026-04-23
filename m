Return-Path: <netdev+bounces-280806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDH1JeRK6mkhxgIAu9opvQ
	(envelope-from <netdev+bounces-280806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:37:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCB8455005
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AAA16304688B
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6083A6B7C;
	Thu, 23 Apr 2026 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="Y2Ob1Tsp"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1463B39D6F8;
	Thu, 23 Apr 2026 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961819; cv=none; b=snO/85dHG7UO3WwszF3niYP5uH6BZNf7wgZ18VzKPOjX9uDWbCymNbTn6JTvvuRRnyDgwtyPHrjXgHHi+8IWIdaP2LNUm0f3aHwbE3VJCo330Eg8UzWfGGmpgMwfHilYhFj5C/rRdPRpnfxxQrywMTzGZLL9EpZkKHGM60v0fEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961819; c=relaxed/simple;
	bh=APLfrSE6/bUVl9FECXjWpOAWU6ipu1R/nXwWeb/u9TU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BVo4aXdxmPKbOLGOanqhFuFsqKxeP5xVmjrFV5Zf9jCOeGO9a2RW/9X+8argXBEie1nEM4mPOHZuroWtI4mHWo7cZn7w0RPvxfev50mBGK9KI+12/jvCEZrM0XP9yhG7fLaKO7Orvoa74Msl0ns+ZMEvzM/WCwAAqIn5ezDaacw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=Y2Ob1Tsp; arc=none smtp.client-ip=173.37.142.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=9844; q=dns/txt;
  s=iport01; t=1776961817; x=1778171417;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=TxMWBY1GCh2MTuzomsIGUYP5X6tocS9mKdU2RFSx6Ag=;
  b=Y2Ob1Tsp4O41XByDIozPmyHjXhHm9xqqWym6dDZy5tDV0sLXxR7N7qMa
   0NyV1zhKVswv6QN9Dbj6XISZBQE+YySpK9dcVd7GMgfD7IPhk2yfwR+fR
   joiSMGJxjHkKxEzYvxFJdYQURFScNbHEN891BCv70Gs/F/z1zpfYLjsHm
   oIn/jOvgCrG67iFD3Zq7Syn3zhqZkPAXzBB4qfnnK0ZoYoLosviEUCbw+
   GTK2iMl1jlHhbjHE74te1TYi+EjgLWDBZPIQIU25LmQrSJViI2oSRcUuN
   rqt2m/1dknZhHoBojw/WLAuO16k4K9MhRUO5v0WDHdikqA8TKQ6KzhMft
   A==;
X-CSE-ConnectionGUID: 9s7qW8rvQCG7HS+5QnB7kQ==
X-CSE-MsgGUID: CHNoVMEhTeiCD6oqb8jH8A==
X-IPAS-Result: =?us-ascii?q?A0AnAAClR+pp/4//Ja1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?laBT0NJhFeIHIc3giGeHRSBaw8BAQEPUQQBAYUGAo0sAiY0CQ4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4ZchlsCAQMjBEASECUCJgICR?=
 =?us-ascii?q?hAGARKDAoJ0A7NVen8zgQHeP4FkAQsUAYEKLgGFcYJmAYFwhAY7hD8nG4FJR?=
 =?us-ascii?q?IEVg2iEBQUVg3+CaQSCDYEPFI8eCT+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSE?=
 =?us-ascii?q?hgVAhQvDwQWMh1wDBAXEiwXNFgbBwWBS4QJbRQxBCGBC4MqgTaBAQMLGA1IE?=
 =?us-ascii?q?Sw3Bg4bBD0BbgeKNiAPgTlqBxZ5ezFnFQUwCZNhgzyNXWuBNZ9ZhCaBZKAOA?=
 =?us-ascii?q?TKEBJNikwWZBiKCNqExUIRogWg8gVkzGggbFYMiUxkPji0WHMhyJjI9AgcCB?=
 =?us-ascii?q?w0DC5FoEReBVQEB?=
IronPort-Data: A9a23:P16NCq6N8+AgED9Ay693AgxRtPjGchMFZxGqfqrLsTDasY5as4F+v
 moaWTyHMqvfajb8fNlzOdy3ph5Sv5LTmtU1HlZupSg9Zn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH2dOC98RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wo+KUzBHf/g2Qqaj5OsPrYwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4ebJZH49knG3933
 tNHCAtOMymFrb21+efuIgVsrpxLwMjDJogTvDRkiDreF/tjGc6FSKTR7tge1zA17ixMNa+BP
 IxCNnw1MUmGOkEUUrsUIMpWcOOAnXDjciZYq1K9rqss6G+Vxwt0uFToGIWPJoTVGJ4Lxi50o
 Ert30L+PDQ3NOCSyBGprHW1jL/NvXPSDdd6+LqQs6QCbEeo7mAaFhATfVeyv/S8jkmwR5RZJ
 lB80icisK075kG3Ztb6WBK8rTiPuRt0c9lNGeQS6wyXzKfQpQGDCQAsRzhNctE598k7WTAny
 HeNgtXvQzdv2JWNQHiQ8La8tz6+OSEJa2QFYEcsSQoD/smmo4wpiB/LZshsHbTzjdDvHzz0h
 TeQo0AWgbgPgcMV/7u08EqBgD+2oJXNCAkv6W3qsnmN9Ah1YsuhIoev81WetagGJ4eCRV7Ht
 38B8ySD0N0z4Vi2vHTlaI0w8HuBvZ5p7BW0bYZTIqQc
IronPort-HdrOrdr: A9a23:tbLDqKilF3vOh1qx0pBmQ7q6uHBQXiwji2hC6mlwRA09TyVXrb
 HLoB19737JYVcqNk3I9ursBEDtexnhHNtOkOss1NSZMzUOxlHJEGgK1+KLqAEIWReOldK1vp
 0NT0ERMqyUMXFKyev3/wW8Fc8t252k/LDAv5am815dCSxndK1k6R50EUKgEkNwTBRbHpZRLu
 v72iM+nUvGRV0nKuKmG3ICQ+/P4/fPlJ7gfFo6IiRP0nj3sdttg4SKaSRxGXwlIkhy/Ys=
X-Talos-CUID: =?us-ascii?q?9a23=3AWXP4UGgvdnb41HTPrBzdG4U35TJuI2aC1UiAOVG?=
 =?us-ascii?q?BIkk2aIbWFGaW0vxnqp87?=
X-Talos-MUID: 9a23:dKqtvgnzdmiX7T/OMODrdnpJFOFv3YGDCHwAkL4q5c6dP3xyG2e02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,195,1770595200"; 
   d="scan'208";a="724075360"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Apr 2026 16:29:07 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id 3AB72180003A3;
	Thu, 23 Apr 2026 16:29:07 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Thu, 23 Apr 2026 09:28:09 -0700
Subject: [PATCH net-next v5 08/10] enic: add MBOX VF handlers for
 capability, register and link state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-enic-sriov-v2-admin-channel-v2-v5-8-caa9f504a3dc@cisco.com>
References: <20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com>
In-Reply-To: <20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776961741; l=10195;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=APLfrSE6/bUVl9FECXjWpOAWU6ipu1R/nXwWeb/u9TU=;
 b=Dz3iBBi5gbgYkpBIQPM1S4T5OO6EEJ3q055+oXJ8NEzOXrn+3ZHS2+ytivCV0upSxECNCIgk7
 0LbJU3PWzk2CMWGqk8gdiGmwMVl9/0ivQk90OxNMitePATWwnf2F1TJ
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
	TAGGED_FROM(0.00)[bounces-280806-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cisco.com:email,cisco.com:dkim,cisco.com:mid]
X-Rspamd-Queue-Id: 3FCB8455005
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement VF-side mailbox message processing for SR-IOV V2
admin channel communication.

VF receive handlers:
  - VF_CAPABILITY_REPLY: store PF protocol version, signal
    completion
  - VF_REGISTER_REPLY: mark VF as registered, signal completion
  - VF_UNREGISTER_REPLY: mark VF as unregistered, signal
    completion
  - PF_LINK_STATE_NOTIF: update carrier state via
    netif_carrier_on/off, send ACK back to PF

VF initiation functions for the probe-time handshake:
  - enic_mbox_vf_capability_check: send capability request,
    wait for PF reply via completion
  - enic_mbox_vf_register: send register request, wait for
    PF confirmation via completion
  - enic_mbox_vf_unregister: send unregister request, wait
    for PF confirmation

The wait helper (enic_mbox_wait_reply) uses
wait_for_completion_timeout, signaled when the admin ISR/NAPI/
workqueue pipeline delivers the reply message.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |   9 +-
 drivers/net/ethernet/cisco/enic/enic_mbox.c | 220 ++++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_mbox.h |   3 +
 3 files changed, 231 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 9b1fa3857df5..29ce26284493 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -258,6 +258,8 @@ struct enic {
 	u32 tx_coalesce_usecs;
 	u16 num_vfs;
 	enum enic_vf_type vf_type;
+	bool vf_registered;
+	u32 pf_cap_version;
 	unsigned int enable_count;
 	spinlock_t enic_api_lock;
 	bool enic_api_busy;
@@ -305,9 +307,14 @@ struct enic {
 	void (*admin_rq_handler)(struct enic *enic, void *buf,
 				 unsigned int len);
 
-	/* MBOX protocol state */
+	/* MBOX protocol state -- single-flight: on the VF, all callers
+	 * that wait on mbox_comp run under RTNL or during probe/remove,
+	 * so only one completion is outstanding at a time. mbox_lock
+	 * protects the shared admin WQ from concurrent senders.
+	 */
 	struct mutex mbox_lock;
 	u64 mbox_msg_num;
+	struct completion mbox_comp;
 
 	/* PF: per-VF MBOX state, allocated when SRIOV V2 is enabled */
 	struct enic_vf_state {
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
index f3c0e94c2417..3819efc837bf 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -5,6 +5,7 @@
 #include <linux/netdevice.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
+#include <linux/completion.h>
 
 #include "vnic_dev.h"
 #include "vnic_wq.h"
@@ -127,6 +128,16 @@ int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
 	return err;
 }
 
+static int enic_mbox_wait_reply(struct enic *enic, unsigned long timeout_ms)
+{
+	unsigned long left;
+
+	left = wait_for_completion_timeout(&enic->mbox_comp,
+					   msecs_to_jiffies(timeout_ms));
+
+	return left ? 0 : -ETIMEDOUT;
+}
+
 int enic_mbox_send_link_state(struct enic *enic, u16 vf_id, u32 link_state)
 {
 	struct enic_mbox_pf_link_state_notif_msg notif = {};
@@ -290,6 +301,136 @@ static void enic_mbox_pf_process_msg(struct enic *enic,
 			    hdr->msg_type, vf_id, err);
 }
 
+static void enic_mbox_vf_handle_capability_reply(struct enic *enic,
+						 void *payload)
+{
+	struct enic_mbox_vf_capability_reply_msg *reply = payload;
+
+	if (le16_to_cpu(reply->reply.ret_major) == 0)
+		enic->pf_cap_version = le32_to_cpu(reply->version);
+	complete(&enic->mbox_comp);
+}
+
+static void enic_mbox_vf_handle_register_reply(struct enic *enic,
+					       void *payload)
+{
+	struct enic_mbox_vf_register_reply_msg *reply = payload;
+
+	if (le16_to_cpu(reply->reply.ret_major)) {
+		netdev_warn(enic->netdev,
+			    "MBOX: VF register rejected by PF: %u/%u\n",
+			    le16_to_cpu(reply->reply.ret_major),
+			    le16_to_cpu(reply->reply.ret_minor));
+	} else {
+		enic->vf_registered = true;
+	}
+	complete(&enic->mbox_comp);
+}
+
+static void enic_mbox_vf_handle_unregister_reply(struct enic *enic,
+						 void *payload)
+{
+	struct enic_mbox_vf_register_reply_msg *reply = payload;
+
+	if (le16_to_cpu(reply->reply.ret_major)) {
+		netdev_warn(enic->netdev,
+			    "MBOX: VF unregister rejected by PF: %u/%u\n",
+			    le16_to_cpu(reply->reply.ret_major),
+			    le16_to_cpu(reply->reply.ret_minor));
+	} else {
+		enic->vf_registered = false;
+	}
+	complete(&enic->mbox_comp);
+}
+
+static void enic_mbox_vf_handle_link_state(struct enic *enic, void *payload)
+{
+	struct enic_mbox_pf_link_state_notif_msg *notif = payload;
+	struct enic_mbox_pf_link_state_ack_msg ack = {};
+
+	switch (le32_to_cpu(notif->link_state)) {
+	case ENIC_MBOX_LINK_STATE_ENABLE:
+		if (!netif_carrier_ok(enic->netdev))
+			netif_carrier_on(enic->netdev);
+		netdev_dbg(enic->netdev, "MBOX: link state -> UP\n");
+		break;
+	case ENIC_MBOX_LINK_STATE_DISABLE:
+		if (netif_carrier_ok(enic->netdev))
+			netif_carrier_off(enic->netdev);
+		netdev_dbg(enic->netdev, "MBOX: link state -> DOWN\n");
+		break;
+	default:
+		netdev_warn(enic->netdev, "MBOX: unknown link state %u\n",
+			    le32_to_cpu(notif->link_state));
+		ack.ack.ret_major = cpu_to_le16(ENIC_MBOX_ERR_GENERIC);
+		break;
+	}
+
+	enic_mbox_send_msg(enic, ENIC_MBOX_PF_LINK_STATE_ACK, ENIC_MBOX_DST_PF,
+			   &ack, sizeof(ack));
+}
+
+static bool enic_mbox_vf_payload_ok(struct enic *enic, u8 msg_type,
+				    u16 payload_len, size_t min_len)
+{
+	if (payload_len < min_len) {
+		netdev_warn(enic->netdev,
+			    "MBOX: short payload for type %u (%u < %zu)\n",
+			    msg_type, payload_len, min_len);
+		return false;
+	}
+	return true;
+}
+
+static void enic_mbox_vf_process_msg(struct enic *enic,
+				     struct enic_mbox_hdr *hdr, void *payload,
+				     u16 payload_len)
+{
+	switch (hdr->msg_type) {
+	case ENIC_MBOX_VF_CAPABILITY_REPLY: {
+		size_t exp = sizeof(struct enic_mbox_vf_capability_reply_msg);
+
+		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
+					     payload_len, exp))
+			return;
+		enic_mbox_vf_handle_capability_reply(enic, payload);
+		break;
+	}
+	case ENIC_MBOX_VF_REGISTER_REPLY: {
+		size_t exp = sizeof(struct enic_mbox_vf_register_reply_msg);
+
+		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
+					     payload_len, exp))
+			return;
+		enic_mbox_vf_handle_register_reply(enic, payload);
+		break;
+	}
+	case ENIC_MBOX_VF_UNREGISTER_REPLY: {
+		size_t exp = sizeof(struct enic_mbox_vf_register_reply_msg);
+
+		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
+					     payload_len, exp))
+			return;
+		enic_mbox_vf_handle_unregister_reply(enic, payload);
+		break;
+	}
+	case ENIC_MBOX_PF_LINK_STATE_NOTIF: {
+		size_t exp = sizeof(struct enic_mbox_pf_link_state_notif_msg);
+
+		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
+					     payload_len, exp))
+			return;
+		enic_mbox_vf_handle_link_state(enic, payload);
+		break;
+	}
+	default:
+		netdev_dbg(enic->netdev,
+			   "MBOX: VF unhandled msg type %u\n",
+			   hdr->msg_type);
+		break;
+	}
+}
+
 static void enic_mbox_recv_handler(struct enic *enic, void *buf,
 				   unsigned int len)
 {
@@ -330,11 +471,90 @@ static void enic_mbox_recv_handler(struct enic *enic, void *buf,
 
 	if (enic->vf_state)
 		enic_mbox_pf_process_msg(enic, hdr, payload);
+	else
+		enic_mbox_vf_process_msg(enic, hdr, payload,
+					 msg_len - (u16)sizeof(*hdr));
+}
+
+int enic_mbox_vf_capability_check(struct enic *enic)
+{
+	struct enic_mbox_vf_capability_msg req = {};
+	int err;
+
+	enic->pf_cap_version = 0;
+	reinit_completion(&enic->mbox_comp);
+	req.version = cpu_to_le32(ENIC_MBOX_CAP_VERSION_1);
+
+	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_CAPABILITY_REQUEST,
+				 ENIC_MBOX_DST_PF, &req, sizeof(req));
+	if (err)
+		return err;
+
+	err = enic_mbox_wait_reply(enic, 3000);
+	if (err) {
+		netdev_warn(enic->netdev,
+			    "MBOX: no capability reply from PF\n");
+		return err;
+	}
+
+	if (enic->pf_cap_version < ENIC_MBOX_CAP_VERSION_1) {
+		netdev_warn(enic->netdev,
+			    "MBOX: PF version %u too old\n",
+			    enic->pf_cap_version);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+int enic_mbox_vf_register(struct enic *enic)
+{
+	int err;
+
+	enic->vf_registered = false;
+	reinit_completion(&enic->mbox_comp);
+
+	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_REGISTER_REQUEST,
+				 ENIC_MBOX_DST_PF, NULL, 0);
+	if (err)
+		return err;
+
+	err = enic_mbox_wait_reply(enic, 3000);
+	if (err) {
+		netdev_warn(enic->netdev,
+			    "MBOX: VF registration with PF timed out\n");
+		return err;
+	}
+
+	if (!enic->vf_registered)
+		return -ENODEV;
+
+	return 0;
+}
+
+int enic_mbox_vf_unregister(struct enic *enic)
+{
+	int err;
+
+	if (!enic->vf_registered)
+		return 0;
+
+	reinit_completion(&enic->mbox_comp);
+
+	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_UNREGISTER_REQUEST,
+				 ENIC_MBOX_DST_PF, NULL, 0);
+	if (err)
+		return err;
+
+	err = enic_mbox_wait_reply(enic, 3000);
+
+	return enic->vf_registered ? -ETIMEDOUT : 0;
 }
 
 void enic_mbox_init(struct enic *enic)
 {
 	enic->mbox_msg_num = 0;
 	mutex_init(&enic->mbox_lock);
+	init_completion(&enic->mbox_comp);
 	enic->admin_rq_handler = enic_mbox_recv_handler;
 }
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.h b/drivers/net/ethernet/cisco/enic/enic_mbox.h
index f1de67db1273..15e30ee2b0ed 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.h
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.h
@@ -88,5 +88,8 @@ void enic_mbox_init(struct enic *enic);
 int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
 		       void *payload, u16 payload_len);
 int enic_mbox_send_link_state(struct enic *enic, u16 vf_id, u32 link_state);
+int enic_mbox_vf_capability_check(struct enic *enic);
+int enic_mbox_vf_register(struct enic *enic);
+int enic_mbox_vf_unregister(struct enic *enic);
 
 #endif /* _ENIC_MBOX_H_ */

-- 
2.43.0


