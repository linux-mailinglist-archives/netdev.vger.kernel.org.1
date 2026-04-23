Return-Path: <netdev+bounces-280799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLKdIaNM6mkhxgIAu9opvQ
	(envelope-from <netdev+bounces-280799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:45:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A2D455128
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2B873038B95
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C551387341;
	Thu, 23 Apr 2026 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="hb6zFtNe"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8CB37DEA8;
	Thu, 23 Apr 2026 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961814; cv=none; b=hgr/tY40LZ1EW7ZUS8dXLbKv2QKIQr0Z56MyGsnzMwVlIS9q77AlRV0FtQ95fhxMZJZ5iC6gNECfkEc3aF8NAQKvazB1p/HxifxkSpspnJA9AxAPfEFQMs5MNpWxXq9uSYOnQSX85C7cmClANDMNuN01TmFZe1LZJoXOonfZDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961814; c=relaxed/simple;
	bh=3UXiwEguexDSU5q9sXykOpn4fjIRMVeBycb+uHtZMiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PapjY9zs2hgS5PxWPJcX9GfafSkrJyJTXXi1O5LlvX20a0j9A3UwsVTqQdTHgcAOeZqTZzaCWVvWgyi2Lggl/KTHVua9hosxWOWTpfuAmk/BuZKQhgYvGGFm4dPKvRTgM8fBKClSa1zc8EFoJwwMd7KG7qk1FcjlbEURGXRV0hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=hb6zFtNe; arc=none smtp.client-ip=173.37.142.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=8529; q=dns/txt;
  s=iport01; t=1776961812; x=1778171412;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=iD3A2YdfU8gmEgjI03DI0UYPW1uFfq1azzwfwXueZ/k=;
  b=hb6zFtNe8r40de6EakOCdKMJb9Te29KGvPJDE9ylF/NTFo2qRxn03s9W
   jGj/lEmjXmHkIfMYZiWPRu/Kc5r5pZKmUEsuN5hg3+LPKJLOJ2e5AtPP6
   DWpvTIg6Q+L0s8JodwnLfqsrZw774bx4zJn6rIEUKFfFcHOSrLuJh+QiI
   ol+a4M7Bevp2GH4xc/t3PiKHVXAXWAwd6AuEImRP2dRgDPuy4025k9oby
   y+QDk4lQYP7k+rj4HbxQCtTrLC+t2TazEqF7Sag/YZ+ORRlCmeaozsbmf
   Y5KAw2PHFNvAjF3bXLo0n+ijuHeiusGXkEowLhEGiwKZufWyRpbZziIkk
   g==;
X-CSE-ConnectionGUID: 1oD8PgVtT0eZ+B2uDldJgQ==
X-CSE-MsgGUID: MPobrCY+S/Os275FNwHdFw==
X-IPAS-Result: =?us-ascii?q?A0BIAgAkSOpp/4//Ja1aglmCGD+BT0NJhFePU4IhkU2MU?=
 =?us-ascii?q?BSBaw8BAQEPUQQBAYUGAo0sAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELA?=
 =?us-ascii?q?QEFAQEBAgEHBYEOE4ZchlsCAQMjBFIQJQImAgJGEAYBEoIqWIJ0A7NRen8zg?=
 =?us-ascii?q?QGEfdlCgWQBCxQBgQouhXKCZgGBcIQGO4Q/JxuBSUSBFYNohAUag3+CaQSDH?=
 =?us-ascii?q?BSEZ4o3CT+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSEhgVAhQcEw8EFjIdcAwQF?=
 =?us-ascii?q?xIsFzRYGwcFgUuECW0UMQQhgQuDKoE2gQEDCxgNSBEsNwYOGwQ9AW4HijYgD?=
 =?us-ascii?q?4E5agdLMBRCOTEBewUwkwsdg36NXWuBNZ9ZhCaBZKAOATKXZpMFmQYio0xrh?=
 =?us-ascii?q?GiBaDyBWTMaCBsVgyJTGQ+OLRYcyHImMj0CBwIHDQMLkXmBbAEB?=
IronPort-Data: A9a23:0OKaB65FJJj4piFbRcZw6QxRtPjGchMFZxGqfqrLsTDasY5as4F+v
 jEeWmzTOfuPYGH3Kt0ga4zioBsFusKBmtAxSws5r38yZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH2dOC98RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wo+KUzBHf/g2Qqaj5OsPrYwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eZIo0qt54P31yr
 fEqaxpXczyHi8C5+efuIgVsrpxLwMjDJogTvDRkiDreF/tjGc6FSKTR7tge1zA17ixMNa+BP
 IxCNnw1MUmGOkEUUrsUIMpWcOOAnXDjciZYq1K9rqss6G+Vxwt0uFToGIWPIYbWH5oMxS50o
 Erjx2PzGDord+fY7iHfrS+CoPDvkQ3kDdd6+LqQs6QCbEeo7mAaFhATfVeyv/S8jkmwR5RZJ
 lB80icisK075kG3Ztb6WBK8rTiPuRt0c9lNGeQS6wyXzKfQpQGDCQAsRzhNctE598k7WTAny
 HeNgtXvQzdv2JWNQHiQ8La8tz6+OSEJa2QFYEcsSQoD/smmo4wpiB/LZshsHbTzjdDvHzz0h
 TeQo0AWgbgPgcMV/7u08EqBgD+2oJXNCAkv6W3qsnmN9Ah1YsuhIoev81WetagGJ4eCRV7Ht
 38B8ySD0N0z4Vi2vHTlaI0w8HuBvZ5p7BW0bYZTIqQc
IronPort-HdrOrdr: A9a23:0hN+6qBJ4TkQSX7lHela55DYdb4zR+YMi2TDGXoBLSC9Ffb4qy
 nOppomPHDP5Qr5NEtLpTnEAtjjfZq+z/FICPcqXYtKNTOO0ACVxcNZnOjfKlbbdxEWmNQtsJ
 tIQuxSBML9CF5igd2/wgWpeuxQueWvweSEifjTynF1QRovUaFv6A9lFh2We3cGIjWufaBJc6
 a0145guyeqf2gRY4CQA3kIWPWGmvjw/aiWGSLvw3UcmXOzZfTC0s+ALySl
X-Talos-CUID: 9a23:OOo22mE8Sisg84JnqmI+82JEIs8bbkGFwUWTCRWlJWJlarKsHAo=
X-Talos-MUID: 9a23:Di9bmwiYxCj11q7/ffUbbcMpEf9v6b6FOQM21rId4ZbZGwpvGzuzk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,195,1770595200"; 
   d="scan'208";a="723242713"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Apr 2026 16:29:07 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id 7E1BF18000279;
	Thu, 23 Apr 2026 16:29:06 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Thu, 23 Apr 2026 09:28:08 -0700
Subject: [PATCH net-next v5 07/10] enic: add MBOX PF handlers for VF
 register and capability
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-enic-sriov-v2-admin-channel-v2-v5-7-caa9f504a3dc@cisco.com>
References: <20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com>
In-Reply-To: <20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776961741; l=8869;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=3UXiwEguexDSU5q9sXykOpn4fjIRMVeBycb+uHtZMiI=;
 b=VT1Oc5zN/LbiAqrKNktX38AH5FJBA8j+AWp/9GstvrUtVSucx4ynvnMEP3PXxWb6U05nacroQ
 rSbVaRWtEr4BKoyCh/lvdWCeFQYtJYQWcwuP1MWAb0mtc9ciqEJFyyi
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-06.cisco.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[cisco.com:server fail,sin.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-280799-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cisco.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cisco.com:email,cisco.com:dkim,cisco.com:mid]
X-Rspamd-Queue-Id: 90A2D455128
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement PF-side mailbox message processing for SR-IOV V2
admin channel communication.

When the PF receives messages from VFs, the dispatch routes
them to type-specific handlers:
  - VF_CAPABILITY_REQUEST: reply with protocol version 1
  - VF_REGISTER_REQUEST: mark VF registered, reply, then
    send PF_LINK_STATE_NOTIF with link enabled
  - VF_UNREGISTER_REQUEST: mark VF unregistered, send reply
  - PF_LINK_STATE_ACK: log errors from VF acknowledgment

Per-VF state (struct enic_vf_state) is tracked via enic->vf_state
which will be allocated when SRIOV V2 is enabled.

Remove the CONFIG_PCI_IOV guard from num_vfs in struct enic. The
PF handlers reference enic->num_vfs for VF ID bounds checking in
enic_mbox.c, which is compiled unconditionally. The field must be
visible regardless of CONFIG_PCI_IOV to avoid build failures.

Add enic_mbox_send_link_state() helper for PF-initiated link
state notifications, also used later by ndo_set_vf_link_state.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |   7 +-
 drivers/net/ethernet/cisco/enic/enic_mbox.c | 182 +++++++++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.h |   1 +
 3 files changed, 186 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 42f345aceced..9b1fa3857df5 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -256,9 +256,7 @@ struct enic {
 	struct enic_rx_coal rx_coalesce_setting;
 	u32 rx_coalesce_usecs;
 	u32 tx_coalesce_usecs;
-#ifdef CONFIG_PCI_IOV
 	u16 num_vfs;
-#endif
 	enum enic_vf_type vf_type;
 	unsigned int enable_count;
 	spinlock_t enic_api_lock;
@@ -310,6 +308,11 @@ struct enic {
 	/* MBOX protocol state */
 	struct mutex mbox_lock;
 	u64 mbox_msg_num;
+
+	/* PF: per-VF MBOX state, allocated when SRIOV V2 is enabled */
+	struct enic_vf_state {
+		bool registered;
+	} *vf_state;
 };
 
 static inline struct net_device *vnic_get_netdev(struct vnic_dev *vdev)
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
index 3b2fc9822176..f3c0e94c2417 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -127,10 +127,175 @@ int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
 	return err;
 }
 
+int enic_mbox_send_link_state(struct enic *enic, u16 vf_id, u32 link_state)
+{
+	struct enic_mbox_pf_link_state_notif_msg notif = {};
+
+	if (!enic->vf_state || vf_id >= enic->num_vfs ||
+	    !enic->vf_state[vf_id].registered) {
+		netdev_dbg(enic->netdev,
+			   "MBOX: skip link state to unregistered VF %u\n",
+			   vf_id);
+		return 0;
+	}
+
+	notif.link_state = cpu_to_le32(link_state);
+	return enic_mbox_send_msg(enic, ENIC_MBOX_PF_LINK_STATE_NOTIF, vf_id,
+				  &notif, sizeof(notif));
+}
+
+static int enic_mbox_pf_handle_capability(struct enic *enic, void *msg,
+					  u16 vf_id, u64 msg_num)
+{
+	struct enic_mbox_vf_capability_reply_msg reply = {};
+
+	reply.reply.ret_major = cpu_to_le16(0);
+	reply.version = cpu_to_le32(ENIC_MBOX_CAP_VERSION_1);
+
+	return enic_mbox_send_msg(enic, ENIC_MBOX_VF_CAPABILITY_REPLY, vf_id,
+				  &reply, sizeof(reply));
+}
+
+static int enic_mbox_pf_handle_register(struct enic *enic, void *msg,
+					u16 vf_id, u64 msg_num)
+{
+	struct enic_mbox_vf_register_reply_msg reply = {};
+	int err;
+
+	if (!enic->vf_state || vf_id >= enic->num_vfs) {
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: register from invalid VF %u\n",
+				    vf_id);
+		return -EINVAL;
+	}
+
+	/* VF re-registering (e.g. guest reboot without clean unregister):
+	 * mark the previous registration inactive before accepting the new one.
+	 */
+	if (enic->vf_state[vf_id].registered) {
+		netdev_dbg(enic->netdev,
+			   "MBOX: VF %u re-register, cleaning previous state\n",
+			   vf_id);
+		enic->vf_state[vf_id].registered = false;
+	}
+
+	reply.reply.ret_major = cpu_to_le16(0);
+	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_REGISTER_REPLY, vf_id,
+				 &reply, sizeof(reply));
+	if (err)
+		return err;
+
+	enic->vf_state[vf_id].registered = true;
+	netdev_info(enic->netdev, "VF %u registered via MBOX\n", vf_id);
+
+	err = enic_mbox_send_link_state(enic, vf_id,
+					ENIC_MBOX_LINK_STATE_ENABLE);
+	if (err)
+		netdev_warn(enic->netdev,
+			    "VF %u: failed to send initial link state: %d\n",
+			    vf_id, err);
+	/* Registration succeeded; link state will be (re-)sent on next
+	 * enic_link_check() event.
+	 */
+	return 0;
+}
+
+static int enic_mbox_pf_handle_unregister(struct enic *enic, void *msg,
+					  u16 vf_id, u64 msg_num)
+{
+	struct enic_mbox_vf_register_reply_msg reply = {};
+	int err;
+
+	if (!enic->vf_state || vf_id >= enic->num_vfs) {
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: unregister from invalid VF %u\n",
+				    vf_id);
+		return -EINVAL;
+	}
+
+	/* VF is unloading; clear local state regardless of whether
+	 * the reply is successfully delivered to avoid the PF treating
+	 * a dead VF as still registered.
+	 */
+	enic->vf_state[vf_id].registered = false;
+
+	reply.reply.ret_major = cpu_to_le16(0);
+	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_UNREGISTER_REPLY, vf_id,
+				 &reply, sizeof(reply));
+
+	netdev_info(enic->netdev, "VF %u unregistered via MBOX\n", vf_id);
+
+	return err;
+}
+
+static void enic_mbox_pf_process_msg(struct enic *enic,
+				     struct enic_mbox_hdr *hdr, void *payload)
+{
+	u16 vf_id = le16_to_cpu(hdr->src_vnic_id);
+	u16 msg_len = le16_to_cpu(hdr->msg_len);
+	int err = 0;
+
+	if (!enic->vf_state) {
+		netdev_dbg(enic->netdev,
+			   "MBOX: PF received msg but SRIOV not active\n");
+		return;
+	}
+
+	if (vf_id >= enic->num_vfs) {
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: PF received msg from invalid VF %u\n",
+				    vf_id);
+		return;
+	}
+
+	switch (hdr->msg_type) {
+	case ENIC_MBOX_VF_CAPABILITY_REQUEST:
+		err = enic_mbox_pf_handle_capability(enic, payload, vf_id,
+						     le64_to_cpu(hdr->msg_num));
+		break;
+	case ENIC_MBOX_VF_REGISTER_REQUEST:
+		err = enic_mbox_pf_handle_register(enic, payload, vf_id,
+						   le64_to_cpu(hdr->msg_num));
+		break;
+	case ENIC_MBOX_VF_UNREGISTER_REQUEST:
+		err = enic_mbox_pf_handle_unregister(enic, payload, vf_id,
+						     le64_to_cpu(hdr->msg_num));
+		break;
+	case ENIC_MBOX_PF_LINK_STATE_ACK: {
+		struct enic_mbox_pf_link_state_ack_msg *ack = payload;
+
+		if (msg_len < sizeof(*hdr) + sizeof(*ack))
+			break;
+		if (le16_to_cpu(ack->ack.ret_major))
+			netdev_warn(enic->netdev,
+				    "MBOX: VF %u link state ACK error %u/%u\n",
+				    vf_id, le16_to_cpu(ack->ack.ret_major),
+				    le16_to_cpu(ack->ack.ret_minor));
+		break;
+	}
+	default:
+		netdev_dbg(enic->netdev,
+			   "MBOX: PF unhandled msg type %u from VF %u\n",
+			   hdr->msg_type, vf_id);
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	if (err)
+		netdev_warn(enic->netdev,
+			    "MBOX: PF handler for msg type %u from VF %u failed: %d\n",
+			    hdr->msg_type, vf_id, err);
+}
+
 static void enic_mbox_recv_handler(struct enic *enic, void *buf,
 				   unsigned int len)
 {
 	struct enic_mbox_hdr *hdr = buf;
+	void *payload;
+	u16 msg_len;
 
 	if (len < sizeof(*hdr)) {
 		if (net_ratelimit())
@@ -148,10 +313,23 @@ static void enic_mbox_recv_handler(struct enic *enic, void *buf,
 		return;
 	}
 
+	msg_len = le16_to_cpu(hdr->msg_len);
+	if (msg_len < sizeof(*hdr) || msg_len > len) {
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: invalid msg_len %u (buf len %u)\n",
+				    msg_len, len);
+		return;
+	}
+
 	netdev_dbg(enic->netdev,
 		   "MBOX recv: type %u from vnic %u len %u\n",
-		   hdr->msg_type, le16_to_cpu(hdr->src_vnic_id),
-		   le16_to_cpu(hdr->msg_len));
+		   hdr->msg_type, le16_to_cpu(hdr->src_vnic_id), msg_len);
+
+	payload = buf + sizeof(*hdr);
+
+	if (enic->vf_state)
+		enic_mbox_pf_process_msg(enic, hdr, payload);
 }
 
 void enic_mbox_init(struct enic *enic)
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.h b/drivers/net/ethernet/cisco/enic/enic_mbox.h
index 73fd7f783ee2..f1de67db1273 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.h
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.h
@@ -87,5 +87,6 @@ struct enic;
 void enic_mbox_init(struct enic *enic);
 int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
 		       void *payload, u16 payload_len);
+int enic_mbox_send_link_state(struct enic *enic, u16 vf_id, u32 link_state);
 
 #endif /* _ENIC_MBOX_H_ */

-- 
2.43.0


