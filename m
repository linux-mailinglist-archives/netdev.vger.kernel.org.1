Return-Path: <netdev+bounces-190329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D13EAB63EA
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D672A16D959
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 07:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC7A1A2381;
	Wed, 14 May 2025 07:15:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936CF1DA31D
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747206925; cv=none; b=EUy0RQgZaQZpN62zhAuLAsdMQ7cEQzqQxC8cIEZjGsspnyDa1A7qcbUVpVwtKp1le8S/fi37zXt5qOnvcTkrZZ8fT9qVICzvWkjY0ISSKKXWfZ2LdFjVl0HrGKNyeLDVcYJJPV+mXUhnoN5NmzLI64I8kmzSi3KD8PQE3Bfs2P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747206925; c=relaxed/simple;
	bh=GAx0cPO1sRRwDyB3alcJRBmqpo63k/bxnkLomjOBuq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=km/SuvnB2l43CSU2QW/JK8kN4ZZ0VIAgSug6Q4Nd/3RonaN1mZMLRAFTvsEI/r7qDBdl61p8ZsxW1dqYuIZwcL8/ApBJunsavC5rr/0vrQhxyIR9t6eGx61dAE7+b8BVi4XFc2D1a1a6Ap9qlfIydLbDls+RHDXUp0WIfrW8gRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz11t1747206851ta8eeec28
X-QQ-Originating-IP: iCog0yeBIF/m0yri9sxyKG+oPgkfZGd7eeiu4bjkWqs=
Received: from localhost.localdomain ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 14 May 2025 15:14:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11972504029498066162
EX-QQ-RecipientCnt: 11
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Zengbing Tu <tuzengbing@didiglobal.com>
Subject: [PATCH net-next v3 4/4] net: bonding: add tracepoint for 802.3ad
Date: Wed, 14 May 2025 15:13:39 +0800
Message-ID: <48CD159AB03D8F02+20250514071339.40803-5-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514071339.40803-1-tonghao@bamaicloud.com>
References: <20250514071339.40803-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N+v2p8NjVRtQkODWlPNFBq2MfyiT102BqFCLsbkD/SGScbE0LdRNpPGt
	vzWY5vazHb5rI2dzih2WIeLwauvLoOAkhM+HD8uazEsQHqIsDz0LCZXRkUBizrM9yLFt6RM
	90brg0PZ9TiZ4nnASdhqKsBlwgU8Y4W9fTTX2yTikHSji5eIJRXjEeQtJocCie/bMzGw0UO
	7UOZwsA6jGq/ZKGb5ULV6S1eReRq2TQEkeR45iGYRkLPPaFx21x0F2JxsFfao3F+GZ2Mo2g
	R6KSKVG0OG8xFV7f5Kk8tRkyzO/frq1u4JXlRZs7tzJ10zQSHjyH78HEd/J5J5anrNyP4lZ
	VWe4x+FKIMekxscq84MmhsN4OzAQS0kl0I1qU5BojY2ElAUDzaph5mZHseFveVz3eYGoAoi
	5lFpn74oJnC5zgAD07FWWGA+N1xcKEW3h3GQeTRGZcelhbcIPAh0IWNMl5od7w6pQpjI2rE
	sgURK8VDRnZrs73mAUfZ5fM4/+3TtNICdlrnJmvqiufmDsl+cX/9A6nD7j/u8On1+V+vGuh
	GGds5aLv9wg/Uo0V/yMCkhFB2huVCFwpC4Z9rTBVZV04/+k6fFnwYUKjT3PcQ6NULJCKyuZ
	fOUyU8C/oIIr+y4yNnD5oTOq78TjfShjbxwmjCc60V0736oN8nSDK9eg5mGIWpCGOP0wYHD
	a4OG80nk/LtV1CkSBvSr9AMTAacUL8WtlVqcH1sZ3B/cMnqX3lNEmI0gsMgmldrc1ITuvWM
	ui/0u1wQZSvtIargCmb+SbiYTg6O/mFCzAiAt31a0P+fmikpOmUCqaWDwdMSCGIu3G3RKtg
	aHS+I4yC8zOPWChScF74R+m6PGbHOTxGRwn+d8UmD5TpbQ60OKRMGczHaPgvFx7JN/r8esp
	qT7wTQdJdLEqGSWi+LfiFWv8pi3LHDQ8fDRKQke5vYPCD5X6xNOmSb08X0DVjVpR855T21X
	Nj7L50Mg2kv/otAZ+cq5gEPZn2in7xY4sQ+WcKgEvoXH6wFplYXpvfa+bcHh8J987ddGWMu
	SoVl/8bs8BYacR95J+
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Users can monitor NIC link status changes through netlink. However, LACP
protocol failures may occur despite operational physical links. There is
no way to detect LACP state changes. This patch adds tracepoint at LACP state
transition.

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
---
 drivers/net/bonding/bond_3ad.c |  6 ++++++
 include/trace/events/bonding.h | 37 ++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 include/trace/events/bonding.h

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index d1c2d416ac87..55703230ab29 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -16,6 +16,9 @@
 #include <net/bond_3ad.h>
 #include <net/netlink.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/bonding.h>
+
 /* General definitions */
 #define AD_SHORT_TIMEOUT           1
 #define AD_LONG_TIMEOUT            0
@@ -1146,6 +1149,9 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 			  port->actor_port_number,
 			  last_state,
 			  port->sm_mux_state);
+
+		trace_3ad_mux_state(port->slave->dev, last_state, port->sm_mux_state);
+
 		switch (port->sm_mux_state) {
 		case AD_MUX_DETACHED:
 			port->actor_oper_port_state &= ~LACP_STATE_SYNCHRONIZATION;
diff --git a/include/trace/events/bonding.h b/include/trace/events/bonding.h
new file mode 100644
index 000000000000..1ee4b07d912a
--- /dev/null
+++ b/include/trace/events/bonding.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#if !defined(_TRACE_BONDING_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_BONDING_H
+
+#include <linux/netdevice.h>
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM bonding
+
+TRACE_EVENT(3ad_mux_state,
+	TP_PROTO(struct net_device *dev, u32 last_state, u32 curr_state),
+	TP_ARGS(dev, last_state, curr_state),
+
+	TP_STRUCT__entry(
+		__field(int, ifindex)
+		__string(dev_name, dev->name)
+		__field(u32, last_state)
+		__field(u32, curr_state)
+	),
+
+	TP_fast_assign(
+		__entry->ifindex = dev->ifindex;
+		__assign_str(dev_name);
+		__entry->last_state = last_state;
+		__entry->curr_state = curr_state;
+	),
+
+	TP_printk("ifindex %d dev %s last_state 0x%x curr_state 0x%x",
+		  __entry->ifindex, __get_str(dev_name),
+		  __entry->last_state, __entry->curr_state)
+);
+
+#endif /* _TRACE_BONDING_H */
+
+#include <trace/define_trace.h>
-- 
2.34.1


