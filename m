Return-Path: <netdev+bounces-302747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WoHNM4asQmox/gkAu9opvQ
	(envelope-from <netdev+bounces-302747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:33:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 387C16DDC53
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:33:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=k1SHTSb5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302747-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302747-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89DA2313FE4F
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B5946AF1D;
	Mon, 29 Jun 2026 17:26:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ABA46AF2B;
	Mon, 29 Jun 2026 17:26:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753985; cv=none; b=MuUwYOIYfMlZXdEIkM13/jKgA/ancTg0KZaGSo3xBeS4Vwm9j9DMPO6hSsb8i7ChvKBwVKMg99WxL9nCYdeDFgROo+VydBr/gnQv50HPbgRe69SSsMuZp+u29L6JsfxfBd2kIRAEiYeIUztS5vl7BPyrVmZsQH36DRZ6CxCLHIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753985; c=relaxed/simple;
	bh=DJOEZz0LgusiJsaMcuyJ/mo5kxauoqkYFLtqBtwJznQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kRFV8Q1tWwBiNfxG6Bmu1WoAVtPUeAsgitmDNRykvAn9Ox3hLlWEfyN7uKMLsJFhxzN7vO/A1jWuQ3Yvr/ygsO265/dhaX0JsUUuttN6DFjNcDL9gP/Tdmxrqs5U/H1BEPrBeEmdNv1flVcGPmD02syRbkKyJv7uDj2Op62CSNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=k1SHTSb5; arc=none smtp.client-ip=173.37.86.76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3222; q=dns/txt;
  s=iport01; t=1782753983; x=1783963583;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Ismjn8aCzPjNAuW3z5gQmVHzab5Wc6BkN3bhmJ9vQgA=;
  b=k1SHTSb5MAeeUQ8hxGPIDDMxrquSfb6pKfhsTmqgx3yYTiG2AL0V+Qxq
   eqb8GjoetPrpuD5wHFE7FZGcLUrhiXdbFkjB1bD0w08xOPR8btVm0q13L
   TE0NvXtm+tfY4aojDRx49WfuIPyBMkPgetqBRcA7zd/c/epGmKY9YhhU7
   xC3ed6SubSf1kotU88u4nreJ/DLWp6wWyFmYXCb6n7FvQL9KsGkHblS6V
   W7lTp+JKfdLOhyJSKGT/aVfIgdxFVp8dBhV3v4SRQF5qozzYpM+1OzKk/
   CZW+mp+C3G0nHw0rJ8lZ+dVJ0w+LXDN73fvsnpHw61dXwN0pmKF5EGYud
   g==;
X-CSE-ConnectionGUID: veuvTtVrQK6Yr4+5ITmxtg==
X-CSE-MsgGUID: BisBCaOKQCmLVKHtRWOkYA==
X-IPAS-Result: =?us-ascii?q?A0A6AABUqkJq/5D/Ja1aHQEBAQEJARIBBQUBgXwIAQsBh?=
 =?us-ascii?q?ChDSYRXiByHN4IhkU2MURSBag8BAQEPUQQBAYUGAo1LAiY0CQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThlyGWwIBAyNEEhAlAiYCAkYQBgESg?=
 =?us-ascii?q?wKCdAO4c3qBMoEBhH3ZRoFnCxQBgQouAYVwgmoBgXCEBjuEQScbgUlEgRQBg?=
 =?us-ascii?q?2mEBQEZg3+CagSDHBKRBgk/gQIcA1ksAVUTDQoLBwVhUjMDIAoLEhIYFQIUH?=
 =?us-ascii?q?BMPBBYyHXAMJxIsFzRYGwcFgR2BFS8EIYEEhH0jHwM5f4EwdVhmFTA1gREeC?=
 =?us-ascii?q?oFSJwMLGA1IESw3Bg4bBD0BbgeMXRcPgUxxgQ58NWMal1aNX2uhD4QngWagD?=
 =?us-ascii?q?wEyl2eTBZkII6MbQwlQhGiBaDyBWTMaCBsVgyJTGQ+OX8w/JzI9AQEHAgcOA?=
 =?us-ascii?q?wuBaJARgWwBAQ?=
IronPort-Data: A9a23:MO23T6mb9wqFJK8IR5NytGXo5gxBJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xJLXm+BbvePNmDxeYh+aIrnpxgDsZ/TxoM1HFZk/H88QVtH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/raf658SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+ZG31GONgWYubDpKsfPb8XuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FZMV5/hLHV9Uz
 N9GGSpRLU2iu+em3L3uH4GAhux7RCXqFJkUtnclyXTSCuwrBMicBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQTZj/7C7pm9AusrmL2bzxDqFGVjaE2+GPUigd21dABNfKIIobRGJQKxxzwS
 mTu1WXiKDoTE/+m4j+hzFGMmtXwuiDKcddHfFG/3rsw6LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIjobU3/V6mUvHyWBq3pHPCtRkZM/JTDuczwAKA0KzZ50CeHGdsZjdHZMYrq4wwSCAm2
 0Ghm87vA3pksNW9UXuX+7GVhSm/NSgcMSkJYipsZQ8E5cTz5YI+lBTCSv59H6OvyN74Azf9x
 3aNtidWr7MekcIGyY2l8l3dxTGhvJ7ESkgy/Aq/Y46+xhlyaIjgY8mj7kLWqK4fao2YVVKG+
 nMDnqBy8dwzMH1ErwTVKM1lIV1jz6rt3OH06bK3I6Qcyg==
IronPort-HdrOrdr: A9a23:0+/xV6hatFxi1fN9cx3Y1HRTXnBQXiwji2hC6mlwRA09TyVXrb
 HLoB19737JYVcqNk3I9ursBEDtexnhHNtOkOss1NSZMzUOxlHJEGgK1+KLqAEIWReOldK1vp
 0NT0ERMqyUMXFKyev3/wW8Fc8t252k/LDAv5am815dCSxndK1k6R50EUKgEkNwTBRbHpZRLu
 v72iM+nUvGRV0nKuKmG3ICQ+/P4/fPlJ7gfFo6IiRP0nj3sdttg4SKaSRxGXwlIkhy/Ys=
X-Talos-CUID: 9a23:mW6gg2EAOvw4rZ05qmJ5+VMKJtwbaET+kkbKfwzlKFpsWKGaHAo=
X-Talos-MUID: 9a23:kYd+HgR6dShjMmotRXTGhSpIH85PwJ2FDWQzsrUagfajNh1ZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,232,1774310400"; 
   d="scan'208";a="502359712"
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Jun 2026 17:26:02 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-07.cisco.com (Postfix) with ESMTPS id C4622180004BC;
	Mon, 29 Jun 2026 17:26:01 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Mon, 29 Jun 2026 10:25:58 -0700
Subject: [PATCH net-next v10 06/12] enic: define MBOX message types and
 header structures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-enic-sriov-v2-admin-channel-v2-v10-6-62569af83417@cisco.com>
References: <20260629-enic-sriov-v2-admin-channel-v2-v10-0-62569af83417@cisco.com>
In-Reply-To: <20260629-enic-sriov-v2-admin-channel-v2-v10-0-62569af83417@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782753956; l=3237;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=DJOEZz0LgusiJsaMcuyJ/mo5kxauoqkYFLtqBtwJznQ=;
 b=PBW+Cfmsdy3nTQaNsasnRW00qm9vganX2kJQY7PFZ/nN+2oXm/8OgK4n8CKD5n3EoBO+jU2as
 ui6vQ5YmcGRBvhXx82LqMbTYFghZoBnm4M8V9gpORpP4A+ylIoEMnta
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-07.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302747-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 387C16DDC53

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


