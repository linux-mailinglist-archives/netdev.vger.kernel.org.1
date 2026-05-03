Return-Path: <netdev+bounces-283580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XoBXDiEw92lbdQIAu9opvQ
	(envelope-from <netdev+bounces-283580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 13:23:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D684B53E2
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 13:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8B923007F7C
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 11:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363D52FD7B1;
	Sun,  3 May 2026 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="KpM0q1AO"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7041F3BA4;
	Sun,  3 May 2026 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777807389; cv=none; b=CDvsPvpudo1bqZsmMj8v5w+KYTJ7w0Z2zi67ktR2RJ7sCCLIdEVOCVrXPuBCGRrDwPeWOJmhvFT0YednLLxPFWIszC0XVFGO5Nh+wKy+P8471VyoQegLoIpeyN313cNCEimID3mrCSDU+jieCC9GOt4UmrLdtJLd2ClgO1In2Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777807389; c=relaxed/simple;
	bh=DJOEZz0LgusiJsaMcuyJ/mo5kxauoqkYFLtqBtwJznQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V6aFqTWOjP9zDAeVgyWzZOVF6/gjTGIWEiQesku7+Ctsh5n1Vh8tfpvodgsfGfujoWfhP0CD0Iy+pX0hXW6O8A5N+PpbxehmqDKtL473cdxGN3o/9WBISXqqJwAgFRpGyMt6vMPFLrMgQpPWe5jTwP8fhY7gdWMzBJmd5BcL6C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=KpM0q1AO; arc=none smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3222; q=dns/txt;
  s=iport01; t=1777807387; x=1779016987;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Ismjn8aCzPjNAuW3z5gQmVHzab5Wc6BkN3bhmJ9vQgA=;
  b=KpM0q1AOqy4C48+lAWJlrLAl693i3kWamAjhs3o7XOsyrjmVq9OG088O
   GGhao8VmmkoYHIaF2HVrlK5/duk/WQzAa629dRfhjBmDNNuFk6c4BZ+WG
   rYWRC1FE84RdyzRf1sADWyEZnAgOW2IXICOaFWfdbZV4a+tBXmi3akqW1
   8CwHE8Kky4dtRqZhh/AZ9TPQqxSmk79D6Xy9br6pN1vDnssCsxt3cGNlk
   Eq/Gy/xdN901BXIMz8AIeERKoAK9bBkkkNGdy/z3K+E6b697vYIlgsNtF
   sBMdsaOljBHrDU00B6jQ06cf/ekupiA32dXFm3Zqtplndi+5ZQFNb+Jvj
   w==;
X-CSE-ConnectionGUID: iaWwy1uCSTGD8banveCnpA==
X-CSE-MsgGUID: dsafLTyxSsS5Xm7KNkHijQ==
X-IPAS-Result: =?us-ascii?q?A0BlAwCIL/dp/4v/Ja1aHgEBCxIMgWsQDwuEIkNJhFePU?=
 =?us-ascii?q?4IhkU2MUBSBaw8BAQEPUQQBAYUGAo0xAiY0CQ4BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBCgEBBQEBAQIBBwWBDhOGXIZbAgEDI0QSECUCJgICRhAGARKDAoJ0A?=
 =?us-ascii?q?7MAeoEygQGEfbMlgWULFAGBCi6FcoJmAYFwhAY7hD8nG4FJRIEUAYNohAUBG?=
 =?us-ascii?q?YN/gmkEgxwUjxsJP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCFBwTDwQWM?=
 =?us-ascii?q?h1wDCcSLBc0WBsHBYFLgwBtFDEEIYEFhGB4IywDTnIDCxgNSBEsNwYOGwQ9A?=
 =?us-ascii?q?W4HimYdD4E/cYEOfDVjGpdWjV1roQ6EJoFkoA4BMpdmkwWZBiKjG0MJUIRog?=
 =?us-ascii?q?Wg8gVkzGggbFYMiUxkP2GMmMj0BAQcCBw0DC4FokBGBbAEB?=
IronPort-Data: A9a23:WGR4OKPUTsa8tvPvrR1llsFynXyQoLVcMsEvi/4bfWQNrUpwg2EBy
 WRKWGCOPq2JZjSgKogjbIyy/UkOu8PWn9dnSnM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeap1yFjmB+0rF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WVjlV
 e/a+ZWFZgf4g2Usawr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj6/RnM14nZJAzwdpYLTFE/
 PoGJRsLdjnW0opawJrjIgVtrt4oIM+uOMYUvWttiGmDS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2M0PXwsYDUXUrsTIIk3gOazhnr/WzZZs1mS46Ew5gA/ySQujOiwYYaEK4fiqcN9kl2Rq
 Eb67nTCGSpHBNnA6hyG0nOuv7qa9c/8cMdIfFGizdZmiUOew0QfAQMbUF+8r+X/jEOiM/pSJ
 1ER8zgjsYA980ukStS7VBq9yFaHoxQVc9ldCes37EeK0KW8yw+fCnIJUX1HZcAqudEeQSEs0
 BmCn7vBHTVlvbuUYWiQ+redsXW5Pi19BWsDYzIUCAgI+d/upKktgR/VCNVuCqi4ipvyAz6Y6
 zaHsCQzmZ0NgsMRkaa251bKh3SrvJehc+Iuzh/cUmTg6kZyY5SoItTyr1Pa9v1Hao2eSzFto
 UQ5piRX18hWZbnlqcBHaLxl8G2BjxpdDADhvA==
IronPort-HdrOrdr: A9a23:3l+1zqC80f1xDdnlHela55DYdb4zR+YMi2TDGXoBLSC9Ffb4qy
 nOppomPHDP5Qr5NEtLpTnEAtjjfZq+z/FICPcqXYtKNTOO0ACVxcNZnOjfKlbbdxEWmNQtsJ
 tIQuxSBML9CF5igd2/wgWpeuxQueWvweSEifjTynF1QRovUaFv6A9lFh2We3cGIjWufaBJc6
 a0145guyeqf2gRY4CQA3kIWPWGmvjw/aiWGSLvw3UcmXOzZfTC0s+ALySl
X-Talos-CUID: =?us-ascii?q?9a23=3A/eKbY2upxGIyaGnMYI67eUVi6Iske0LC3S7NCHS?=
 =?us-ascii?q?EJko5QrSTV1K7/rtNxp8=3D?=
X-Talos-MUID: 9a23:/6WKSAVmYuV1/GLq/DP3jT9GCNZ42L+VVXAIzrYguOmFNxUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,213,1770595200"; 
   d="scan'208";a="748594993"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 May 2026 11:22:59 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPS id EAE74180007D0;
	Sun,  3 May 2026 11:22:58 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Sun, 03 May 2026 04:22:42 -0700
Subject: [PATCH net-next v6 05/10] enic: define MBOX message types and
 header structures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-enic-sriov-v2-admin-channel-v2-v6-5-0af4fbc2d86d@cisco.com>
References: <20260503-enic-sriov-v2-admin-channel-v2-v6-0-0af4fbc2d86d@cisco.com>
In-Reply-To: <20260503-enic-sriov-v2-admin-channel-v2-v6-0-0af4fbc2d86d@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777807375; l=3237;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=DJOEZz0LgusiJsaMcuyJ/mo5kxauoqkYFLtqBtwJznQ=;
 b=n11UP+DdIpvGb+6r2WYtWl6dCXegUqdRas5tokuoYwpouUnj2SWnOO6nzRLkRRv1Gp+LtC0hz
 jvSquuv225/C+PU1ZICj5RPn9VvvLRm2SiFAzac+Qf3DqJVO7GzMt+W
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-02.cisco.com
X-Rspamd-Queue-Id: 76D684B53E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283580-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cisco.com:email,cisco.com:dkim,cisco.com:mid]

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


