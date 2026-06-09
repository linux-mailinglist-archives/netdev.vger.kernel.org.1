Return-Path: <netdev+bounces-297173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WQm2FRFIKGo7BgMAu9opvQ
	(envelope-from <netdev+bounces-297173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:06:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8AF662C09
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:06:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=TfVy5mKu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297173-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297173-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13AE3342B0EE
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF284BCAD3;
	Tue,  9 Jun 2026 16:32:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F2B4A1389;
	Tue,  9 Jun 2026 16:32:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022779; cv=none; b=iJiw8TDHBRUgVyE2S+nWk3DrAVOKByzA0dl06z2LM0AVXGNLIHsrpVimGfMo6T+ZsKORfoUjMWVgVVgMHitsuB8WzvVyw/Ip7agQPXQcoYKXQ5RIp/3seh6XiP9xeJeNPO1HVEnjaNMZf4sNjMPFxqE8RjhTFfTgoTmgCcnB5jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022779; c=relaxed/simple;
	bh=DJOEZz0LgusiJsaMcuyJ/mo5kxauoqkYFLtqBtwJznQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g4lMRygNfFaDLZHC0rKh0D7a8ceZ1NSB5tvZN2IK/oVAtZMCYpLNxhxqv6ozl3c3af08X7EVL7STKSZTt+xZ8oeULGHji5QrRNfYrxjchHA9LkUHLBM3eqABelu2+GA2wudSagcDoWfvsV69ElUykNKVMiqx0i/EJyuRL+gqGHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=TfVy5mKu; arc=none smtp.client-ip=173.37.86.76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3222; q=dns/txt;
  s=iport01; t=1781022777; x=1782232377;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Ismjn8aCzPjNAuW3z5gQmVHzab5Wc6BkN3bhmJ9vQgA=;
  b=TfVy5mKuOoDufC5YkFXxto8vjY3DSoioQSqsJdEcV1KbdG8YuBMT+jLW
   k+zzTkQGrDTBA0BKjYTaNPloUhv/KgFaLoPevMPq7I+pxsHcldV9o5jUb
   LL3r8dzf2MrSR6M66IwmOg2uxRwEWGT35urvPBErl0BiWWfjgYwy4Mivl
   I2pOIOKzvsYpeDDqw8OVViXEyyf5xQN/svXlZfnrb7KI/38Gs8px/1AYj
   1b3y3SHMF0sLhETVzFrNoQ6RScv+Qd2ob4rywspwLoPgpBhBweuzQkeN6
   TT8JFwEY+SgV//Hi74hUQ78S/8qptb7l/QiVNwU37YML15ayMciUBJ6AE
   A==;
X-CSE-ConnectionGUID: bxkTENIkTme9ysH9oik4zA==
X-CSE-MsgGUID: rFmG8o5bQseYTXbnHEx45Q==
X-IPAS-Result: =?us-ascii?q?A0BgAwAaPyhq/4//Ja1aHgEBCxIMggULhClDSYRXj1OCI?=
 =?us-ascii?q?ZFNjFEUgWoPAQEBD1EEAQGFBgKNNwImNAkOAQIEAwIDAQEBAQEBAQEBAQELA?=
 =?us-ascii?q?QEFAQEBAgEHBYEOE4ZchlsCAQMjRBIQJQImAgJGEAYBEoMCgnQDtSB6gTKBA?=
 =?us-ascii?q?YR92UWBZwsUAYEKLoVxgmkBgXCEBjuEQScbgUlEgRQBg2iEBQEZg3+CagSDH?=
 =?us-ascii?q?BKQZwk/gQIcA1ksAVUTDQoLBwVhUjMDIAoLEhIYFQIUHBMPBBYyHXAMJxIsF?=
 =?us-ascii?q?zRYGwcFgUqBOxQxBCGBBYUSIx8DOYEVgXyBKGdpFTE1TQMLGA1IESw3Bg4bB?=
 =?us-ascii?q?D0BbgeMOhcPgUhxgQ58NWMal1aNX2uhDoQmgWagDwEyl2eTBJkGIqMaQwlQh?=
 =?us-ascii?q?GiBaDyBWTMaCBsVgyJTGQ/aQScyPQIHAgcOAwuReYFsAQE?=
IronPort-Data: A9a23:kdAARa4WoCzewNMyNgNL6QxRtPjGchMFZxGqfqrLsTDasY5as4F+v
 jRNUWCCPv2CYGD2ftBzb96x9BwG65aBndFhTAc/pX9nZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH2dOC98RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wo/6UzBHf/g2QqajxMuvrawP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eN50bxstRIGJy8
 PFJOSstPxeChL6k6efuIgVsrpxLwMjDJogTvDRkiDreF/tjGc6FSKTR7tge1zA17ixMNa+BP
 IxCNnw1MUmGOkEUUrsUIMpWcOOAnXDjciZYq1K9rqss6G+Vxwt0uFToGIaEIIbUH5kNwC50o
 Erc0WHWUhZHPuWExAu5wniqpsLfwX7CDdd6+LqQs6QCbEeo7mAaFhATfVeyv/S8jkmwR5RZJ
 lB80icisK075kG3Ztb6WBK8rTiPuRt0c9lNGeQS6wyXzKfQpQGDCQAsRzhNctE598k7WTAny
 HeNgtXvQzdv2JWNQHiQ8La8tz6+OSEJa2QFYEcsSQoD/smmo4wpiB/LZshsHbTzjdDvHzz0h
 TeQo0AWgbgPgcMV/7u08EqBgD+2oJXNCAkv6W3qsnmN9Ah1YsuhIoev81WetagGJ4eCRV7Ht
 38B8ySD0N0z4Vi2vHTlaI0w8HuBvp5p7BW0bYZTIqQc
IronPort-HdrOrdr: A9a23:qousgajz4Uskq6/X5K8jZWEMFXBQXiwji2hC6mlwRA09TyVXrb
 HLoB19737JYVcqNk3I9ursBEDtexnhHNtOkOss1NSZMzUOxlHJEGgK1+KLqAEIWReOldK1vp
 0NT0ERMqyUMXFKyev3/wW8Fc8t252k/LDAv5am815dCSxndK1k6R50EUKgEkNwTBRbHpZRLu
 v72iM+nUvGRV0nKuKmG3ICQ+/P4/fPlJ7gfFo6IiRP0nj3sdttg4SKaSRxGXwlIkhy/Ys=
X-Talos-CUID: 9a23:MkybNmz2c8mFkV0V/97TBgUeCsMZX1v8z0vVLh6pEkY4T7yWFU25rfY=
X-Talos-MUID: 9a23:dyLd1wuibQ2BTJaUNc2nnh9nG5dvvq6XE008raUMvempJXAtAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,196,1774310400"; 
   d="scan'208";a="492262406"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 09 Jun 2026 16:32:50 +0000
Received: from [127.0.0.1] (unknown [10.25.128.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id 191B8180004B3;
	Tue,  9 Jun 2026 16:32:50 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Tue, 09 Jun 2026 09:32:31 -0700
Subject: [PATCH net-next v8 05/10] enic: define MBOX message types and
 header structures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-enic-sriov-v2-admin-channel-v2-v8-5-8ad8babbb826@cisco.com>
References: <20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com>
In-Reply-To: <20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781022766; l=3237;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=DJOEZz0LgusiJsaMcuyJ/mo5kxauoqkYFLtqBtwJznQ=;
 b=GYWqy1Huhn2H2tnE6QRoSOI6b6ZXYeIZIK3gVkqf4jsYojF8dOknRh4gadXxQQ9U5w8HP2TBB
 UPy1U8Vlw+7AMv/9GHX2Si0NMzbpKKaMgnofQR3sEoFwtOYhFAKWkPX
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
	TAGGED_FROM(0.00)[bounces-297173-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC8AF662C09

Define the mailbox protocol structures for PF-VF communication:
message header, generic reply, and per-message-type payloads for
capability negotiation, VF registration/unregistration, and link
state notification/acknowledgment.

Include linux/types.h and linux/bits.h for __le16/__le32/__le64
and BIT() used in the header.

Message types use an even=request / odd=reply convention.  The
header carries source and destination VNIC IDs, a monotonically
increasing message number, and the total message length.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_mbox.h | 83 +++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.h b/drivers/net/ethernet/cisco/enic/enic_mbox.h
new file mode 100644
index 000000000000..a52f1d25cb21
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright 2025 Cisco Systems, Inc.  All rights reserved. */
+
+#ifndef _ENIC_MBOX_H_
+#define _ENIC_MBOX_H_
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+/*
+ * Mailbox protocol for PF-VF communication over the admin channel.
+ *
+ * Even numbers are requests, odd numbers are replies/acks.
+ * The prefix indicates the initiator: VF_ = VF-initiated, PF_ = PF-initiated.
+ */
+enum enic_mbox_msg_type {
+	ENIC_MBOX_VF_CAPABILITY_REQUEST		= 0,
+	ENIC_MBOX_VF_CAPABILITY_REPLY		= 1,
+	ENIC_MBOX_VF_REGISTER_REQUEST		= 2,
+	ENIC_MBOX_VF_REGISTER_REPLY		= 3,
+	ENIC_MBOX_VF_UNREGISTER_REQUEST		= 4,
+	ENIC_MBOX_VF_UNREGISTER_REPLY		= 5,
+	ENIC_MBOX_PF_LINK_STATE_NOTIF		= 6,
+	ENIC_MBOX_PF_LINK_STATE_ACK		= 7,
+	ENIC_MBOX_MAX
+};
+
+struct enic_mbox_hdr {
+	__le16 src_vnic_id;
+	__le16 dst_vnic_id;
+	u8 msg_type;
+	u8 flags;
+	__le16 msg_len;
+	__le64 msg_num;
+};
+
+struct enic_mbox_generic_reply {
+	__le16 ret_major;
+	__le16 ret_minor;
+};
+
+#define ENIC_MBOX_ERR_GENERIC		BIT(0)
+#define ENIC_MBOX_ERR_VF_NOT_REGISTERED	BIT(1)
+#define ENIC_MBOX_ERR_MSG_NOT_SUPPORTED	BIT(2)
+
+/* ENIC_MBOX_VF_CAPABILITY_REQUEST / _REPLY */
+#define ENIC_MBOX_CAP_VERSION_0		0
+#define ENIC_MBOX_CAP_VERSION_1		1
+
+struct enic_mbox_vf_capability_msg {
+	__le32 version;
+	__le32 reserved[32];
+};
+
+/* The embedded enic_mbox_generic_reply has 2-byte alignment, but the
+ * __le32 members give this struct 4-byte natural alignment.  Receive
+ * buffers come from kmalloc (>= 8-byte aligned), so there is no
+ * misaligned access risk when casting from the receive buffer.
+ */
+struct enic_mbox_vf_capability_reply_msg {
+	struct enic_mbox_generic_reply reply;
+	__le32 version;
+	__le32 reserved[32];
+};
+
+/* ENIC_MBOX_VF_REGISTER / _UNREGISTER */
+struct enic_mbox_vf_register_reply_msg {
+	struct enic_mbox_generic_reply reply;
+};
+
+/* ENIC_MBOX_PF_LINK_STATE_NOTIF / _ACK */
+#define ENIC_MBOX_LINK_STATE_DISABLE	0
+#define ENIC_MBOX_LINK_STATE_ENABLE	1
+
+struct enic_mbox_pf_link_state_notif_msg {
+	__le32 link_state;
+};
+
+struct enic_mbox_pf_link_state_ack_msg {
+	struct enic_mbox_generic_reply ack;
+};
+
+#endif /* _ENIC_MBOX_H_ */

-- 
2.43.0


