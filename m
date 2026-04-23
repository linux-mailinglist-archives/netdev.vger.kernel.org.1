Return-Path: <netdev+bounces-280803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILQoNeRJ6mkhxgIAu9opvQ
	(envelope-from <netdev+bounces-280803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:33:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B33AE454F11
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 373D3303D356
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE4B3921FA;
	Thu, 23 Apr 2026 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="ALINaMRe"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146B435F5E0;
	Thu, 23 Apr 2026 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961815; cv=none; b=dzk+vjMQK7LqSMEn6PjdWBPqShYNDCVRsStTY+XrpjG8rk7Bx685NrVOGzfgjo1ZHQZ1khPSjFgEV+Nsdx/wHa620782eby8rYxfGt1H9Depha4RWpiQqWtUvveP42kYfAtw4Cu99nuvGLU97xYgcyzm36XotbidcSgh9rjo8GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961815; c=relaxed/simple;
	bh=DJOEZz0LgusiJsaMcuyJ/mo5kxauoqkYFLtqBtwJznQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SFaYynK4hc4dhJ5oRA0/fvRjcpLCYz5cVtFtBg8sCF81xFfaixyvQDhoYtrtQzjsMVCUu7hIA2ZFgxTU3MP9hg0G90PuGmtRLShpVaqWNML9KkSLThnv0P+/q9W4fzkrDwMczSBi2yOY2My216ACtr4W3fm3bg+jgMk6AT1lgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=ALINaMRe; arc=none smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3222; q=dns/txt;
  s=iport01; t=1776961814; x=1778171414;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Ismjn8aCzPjNAuW3z5gQmVHzab5Wc6BkN3bhmJ9vQgA=;
  b=ALINaMRex5NHQqTNhJOlJ52dI7y313H/0/GUbqw7iaYKWqGBoJvPPu35
   Z31PdUYXQ8dlt6L/CLVGzBUM6+NmwyRVQXgFHx1V8NhrVO0cbmMj3V1TE
   EbJW/GSXH6f07AscUjd2ti1eYdF0+01VWGDXpWzMcd2kL67tOijwVQw2V
   5AWEJdCG13tyVQojCkgMDHfevrIw92oYPNZvuJGdQv73psa5nA+eD1KrH
   IeNE2N/Wv0XVTxHBeCpGLQzBomGwAp52RBaJ3ptWCYDZAY3wGyXVulRDa
   RyVhZFzmy96J4Q4mTxpE/kExzLUvt9owdiOHd49eIfTOok0NsWj/MWshZ
   g==;
X-CSE-ConnectionGUID: Sp0WM8DsR0ibt25vhWyBpw==
X-CSE-MsgGUID: 4JFg5GW1S6aYTrnZ7q31sg==
X-IPAS-Result: =?us-ascii?q?A0BlAwCSPupp/4//Ja1aHgEBCxIMgWsQDwuEIkNJhFePU?=
 =?us-ascii?q?4IhkU2MUBSBaw8BAQEPUQQBAYUGAo0sAiY0CQ4BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBCgEBBQEBAQIBBwWBDhOGXIZbAgEDI0QSECUCJgICRhAGARKDAoJ0A?=
 =?us-ascii?q?7A7eoEygQGEfbMkgWULFAGBCi6FcoJmAYFwhAY7hD8nG4FJRIEUAYNohAUBG?=
 =?us-ascii?q?YN/gmkEgxwUjx0JP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCFBwTDwQWM?=
 =?us-ascii?q?h1wDCcSLBc0WBsHBYFLhAltFDEEIYELgyqBNnsDCxgNSBEsNwYOGwQ9AW4Hi?=
 =?us-ascii?q?jQgD4E5cYEOfDVjGpdWjV1roQ6EJoFkoA4BMpdmkwWZBiKjG0MJUIRogWg8g?=
 =?us-ascii?q?VkzGggbFYMiUxkP2GImMj0CBwIHDQMLkXmBbAEB?=
IronPort-Data: A9a23:0ofkAanRqJuwLSeXjvJM0Qvo5gy2J0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIdCDuFOfeLYWegKtt3a9m2oUkGupCBnIJhSQs/ri8yRVtH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4Errav69/ScUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+Za31GONgWYubDpIsfnb9HuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSq
 zHrlezREsvxpn/BO/v9+lrJWhRiro36YWBivkFrt52K2XCukMCdPpETb5LwYW8P49mAcksYJ
 N9l7fRcQi9xVkHAdXh0vxRwS0lD0aN6FLDvGmDnjunD41b8K3rm368zEkEJLKcA5bMiaY1O3
 aRwxDEldBuPgaeyhbm8UOQp3pplJ8jwN4RZsXZlpd3bJa95GtaYHOOQuIIehWtr7ixNNa62i
 84xcjNzbQ/AYB1nMVYMA5V4l+Ct7pX6W2IE8QvO+vpmvQA/yiQt8pbibfXqI+fUTPRphECq+
 Xudpn/2V0Ry2Nu3jGDtHmiXruPGgy7+cI4bCrC98vlknBuVy3B7IBAaSF6ys/SlokG5XN1bJ
 gof/S9Ghasv/kWDTdTnWRC85nmesXY0UtxcCeAlqweA1qbZ/S6dG24CCDVBAPQ+vcU7Qz0Cz
 FKFn9r1QzdotdW9TXOb66fRrj6oPyURBXENaDVCTgYf5dTn5oYpgXrnSNt/HKOrpsP6FCu2w
 D2QqiU6wbIJgqY2O76T51vLhXeo45POVANwvluRVWO+5QQ/b4mgD2C11WXmAT97BN7xZjG8U
 LIswqByMMhm4UmxqRGw
IronPort-HdrOrdr: A9a23:NcbXZqNH8wvgcMBcTjejsMiBIKoaSvp037Dk7TEUdfUzSK2lfq
 GV8sjzuiWYtN98YhsdcJW7Scu9qBDnmqKdn7NwAV7KZmCP01dAbrsSjrcKqAeNJ8SRzJ856Y
 5QN4VzF9H0C0F3loLZ7BnQKadY/PC3tI2lmuvayW5gVkVRa69m5xpkEQrzKDwReOA/P+tfKL
 OsouxaujGnZXMbKu6/BnUDQqz/guejruOfXfbDbCRXkjVnSliTmcXHLyQ=
X-Talos-CUID: 9a23:/5USQ25+qXzCsNJ0Sdssz1ZMJeV1XmbnlHbaPxXlF2ZWWZeNVgrF
X-Talos-MUID: 9a23:VLz/Kwg36pODc4JTibHMfsMpaOVG7PmBNxk2z5w3h9OCB3NpYG6Gg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,195,1770595200"; 
   d="scan'208";a="741137896"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Apr 2026 16:29:05 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id 12C4F180003A3;
	Thu, 23 Apr 2026 16:29:05 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Thu, 23 Apr 2026 09:28:06 -0700
Subject: [PATCH net-next v5 05/10] enic: define MBOX message types and
 header structures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-enic-sriov-v2-admin-channel-v2-v5-5-caa9f504a3dc@cisco.com>
References: <20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com>
In-Reply-To: <20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776961741; l=3237;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=DJOEZz0LgusiJsaMcuyJ/mo5kxauoqkYFLtqBtwJznQ=;
 b=LH19yqNKUjfWP4c7hGUeeYRh4z9YSD1ooJfuioS+NgNR/OCyit2Ibohn7cf/Aq4uN4CYob0BV
 blM+JC5eHLUB/XTgKuyX2/jj94gRn187YDsepYqPiCkwrKq6Lfajq0L
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-06.cisco.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280803-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:dkim,cisco.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B33AE454F11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


