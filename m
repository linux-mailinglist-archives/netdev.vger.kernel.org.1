Return-Path: <netdev+bounces-304641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FjwrGt36R2rDiQAAu9opvQ
	(envelope-from <netdev+bounces-304641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:09:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D00A704C53
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:09:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=Aho04Rhx;
	dmarc=pass (policy=reject) header.from=cisco.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304641-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304641-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 985A43030F15
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 18:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492D131353C;
	Fri,  3 Jul 2026 18:09:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C0730DD2F;
	Fri,  3 Jul 2026 18:09:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102148; cv=none; b=RL4VUTYXdaVubBRa0pFGsEaTTXE3M1Gsq+pLoAWdRnxI3qfgP0X54gZr9oSEMaN4bZiMA+Xhd5a88HSLthZfrStJqz1wvmulQJ1onKui6Ua2eWDOs7bBYc/ZEPbswEbpQ/53ml9wLUwoyuEkaZhZ1l95B/9jnZKgbuin9gVYMUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102148; c=relaxed/simple;
	bh=DJOEZz0LgusiJsaMcuyJ/mo5kxauoqkYFLtqBtwJznQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d3DWK7mP7f6tpYwv98nlh1Mov94jJwuZ7qyvhxYRf62DBQO39ZsDXzDeJU76PnWbYlrBLuqDxJM8kHubEdpnRN5xd66o9A5vQUTNn8PWNfDgmdr7fIDl/kRC6eujKUaK28BgQ790eNr3qi8r8JDUvdCkpqlzj7AZbOirtvQlK+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=Aho04Rhx; arc=none smtp.client-ip=173.37.86.76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3222; q=dns/txt;
  s=iport01; t=1783102146; x=1784311746;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Ismjn8aCzPjNAuW3z5gQmVHzab5Wc6BkN3bhmJ9vQgA=;
  b=Aho04RhxO+0P+yFl8wOuKahAWrohu1RfjvW/BmtlEdrYGsQ/KyfJYxEA
   2j91XjfHi5yFQ3DdSk8piJ/qtUgiS9j7udqOclTuKyGgHsrYQL3S5w0Ge
   B6J23R3uPbuD5/8RJFPDJ6+Xh1pOtEx8bQVnGuH3koWpue9SBB/7n0qKh
   7dmdzVUJXxpJVV1/Z+4y8Kjzew6OhpaFUwY9hEOxXE3PLARJnAbCBH+97
   abN8H2Me87dEC0L0Q9t+KcXfzVA7wBWYCInnzS62tS5jW+qLJEdwMaqR1
   mNworjr2BLY9R0mqs8YVtNBkW8HK2g3rNDMs0EbEjpC2SijGEfcAFtje2
   w==;
X-CSE-ConnectionGUID: U9sgogeoSVCKIirPocVOxA==
X-CSE-MsgGUID: 1JeFU2yRTKSC8eMT5Uj1RQ==
X-IPAS-Result: =?us-ascii?q?A0A6AADU+Udq/5P/Ja1aHQEBAQEJARIBBQUBgXwIAQsBh?=
 =?us-ascii?q?ChDSYRXiByHN4IhkU2MURSBag8BAQEPUQQBAYUGAo1LAiY0CQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThlyGWwIBAyNEEhAlAiYCAkYQBgESg?=
 =?us-ascii?q?wKCdAO8BXqBMoEBhH3ZRoFnCxQBgQouAYVwgmoBgXCEBjuEQScbgUlEgRQBg?=
 =?us-ascii?q?2mEBQEZg3+CagSDHBKRHwk/gQIcA1ksAVUTDQoLBwVhUjMDIAoLEhIYFQIUH?=
 =?us-ascii?q?BMPBBYyHXAMJxIsFzRYGwcFgR2BFTEEIYEEhHkjHwM5f4EwdUp5M4ECARIeC?=
 =?us-ascii?q?oFSgSYDCxgNSBEsNwYOGwQ9AW4HjQAXD4FMcYEOfDVjGpdWjV9roQ+EJ4Fmo?=
 =?us-ascii?q?A8BMpdnkwWZCCOjG0MJUIRogWg8gVkzGggbFYMiUxkPjl/SHicyPQEBBwIHD?=
 =?us-ascii?q?gMLgWiQEYFsAQE?=
IronPort-Data: A9a23:pNnUGanjUUBOliFrky52oh3o5gxBJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xJNWTuPbPuKZGqgLdp2YIni9BsC7cOGyNI2GlNtqHs8EFtH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/raf658SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+ZC31GONgWYubDpLs/nb8nuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FbBJ4elwDmxJz
 sIzCxEMdCiEjNyR0JvuH4GAhux7RCXqFJkUtnclyXTSCuwrBMmbBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQTZT/7C7pm9AusrmL2bzxDqFGVjaE2+GPUigd21dABNfKIIoDVH54MxxfwS
 mTupkb0LCxAJeaj6gGuon+JurLyn3rBYddHfFG/3rsw6LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIjobU3/V6mUvHyWBq3pHPCtRkZM/JTDuczwAKA0KzZ50CeHGdsZjdHZMYrq4wwSCAm2
 0Ghm87vA3pksNW9UXuX+7GVhSm/NSgcMSkJYipsZQ8E5cTz5YI+lBTCSv59H6OvyN74Azf9x
 3aNtidWr7MekcIGyY2l8l3dxTGhvJ7ESkgy/Aq/Y46+xhlyaIjgY8mj7kLWqK8Yao2YVVKG+
 nMDnqBy8dwzMH1ErwTVKM1lIV1jz6/t3OH06bK3I6Qcyg==
IronPort-HdrOrdr: A9a23:zcnAaaAxyHJzBPTlHela55DYdb4zR+YMi2TDGXoBLSC9Ffb4qy
 nOppomPHDP5Qr5NEtLpTnEAtjjfZq+z/FICPcqXYtKNTOO0ACVxcNZnOjfKlbbdxEWmNQtsJ
 tIQuxSBML9CF5igd2/wgWpeuxQueWvweSEifjTynF1QRovUaFv6A9lFh2We3cGIjWufaBJc6
 a0145guyeqf2gRY4CQA3kIWPWGmvjw/aiWGSLvw3UcmXOzZfTC0s+ALySl
X-Talos-CUID: =?us-ascii?q?9a23=3Ay1X/xmnza85Dlpd2gQj3IsJ57G3XOUCM13jXLEK?=
 =?us-ascii?q?/MlhCa5yUU2eX851Dg+M7zg=3D=3D?=
X-Talos-MUID: 9a23:hm0zwgiHcjoTPS2g13RsJsMpbeVlzZn0GXoxsq4t68ShCXFNOW6ntWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,145,1779148800"; 
   d="scan'208";a="504723119"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Jul 2026 18:09:00 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTPS id 5925518000A6B;
	Fri,  3 Jul 2026 18:08:59 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Fri, 03 Jul 2026 11:08:55 -0700
Subject: [PATCH net-next v11 06/12] enic: define MBOX message types and
 header structures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-enic-sriov-v2-admin-channel-v2-v11-6-5b739f1fe9e5@cisco.com>
References: <20260703-enic-sriov-v2-admin-channel-v2-v11-0-5b739f1fe9e5@cisco.com>
In-Reply-To: <20260703-enic-sriov-v2-admin-channel-v2-v11-0-5b739f1fe9e5@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783102134; l=3237;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=DJOEZz0LgusiJsaMcuyJ/mo5kxauoqkYFLtqBtwJznQ=;
 b=KwojU4/FNcAUJ+Zvbz+2t/j4RQHaVZk2+7veozipaedbydwwUUI0LNpLF1mNIeKjnNPkEs4Wu
 2/UzC/MbUOfBq6A6bQ3rwTtQU7GxSEFDrUkp5M9Liz5vXel4VKyCROp
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304641-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,cisco.com:from_mime,cisco.com:email,cisco.com:mid,cisco.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D00A704C53

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


