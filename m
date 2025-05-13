Return-Path: <netdev+bounces-190030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCE9AB5045
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94FA1B423F4
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 09:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F7123C4E3;
	Tue, 13 May 2025 09:49:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D60201278
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129766; cv=none; b=Q5WzIIjpTf4lfoIU2XWntTTjs//UsQM5XoodagQ05GcPbmi/iAYMfKHozK4e+naWPBwp2wTODK8RWmlBSUULU6anrOx6S53vxLzVMSpMTy+y6URYzrKPm9Arb+p6m9iTmuho9RrlaZGlBo+qdNRRSL+IriM43kNpfzPC7Nbhqdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129766; c=relaxed/simple;
	bh=GAx0cPO1sRRwDyB3alcJRBmqpo63k/bxnkLomjOBuq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ne5hJg8Ycj//dva8ZG2BT9buMcsGGJtBxH3XAPv8eQ6ur3OgZCJcA+UrHsLTUSh7U3eIxzHFKrhh4o2z+6p9wlvS3rmUrvQq2KZyOJplosvJhTETIlC/m9qHG72l6wHgVoVzlvygkT1DzWrkoVDi3hXdeoHJdylRz4bDBFbyBrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz4t1747129694t9c6b0285
X-QQ-Originating-IP: /3BxdmvzfqHxG7G7NA4S7zs6LC6Ivv21qsbhIVAMjxE=
Received: from localhost.localdomain ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 May 2025 17:48:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 748024985112486689
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
Subject: [PATCH net-next v2 4/4] net: bonding: add tracepoint for 802.3ad
Date: Tue, 13 May 2025 17:47:50 +0800
Message-ID: <5B2AA2F84CCC0E4E+20250513094750.23387-5-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513094750.23387-1-tonghao@bamaicloud.com>
References: <20250513094750.23387-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M8w/1a60XBlijFmIpFU1e2C44YHaa3PmJKPQE7hIffnl+euoGYZMayAt
	oaVt/Q426W9IXfgPAOT8CEJuutQyJWKfmwT1POpjoBsnTCJUiAe3ZLB2mSogmIxlGV6ScOd
	TdPfj9wrgN/jGeLQS5m1Bph6GE99j1YGvg5gUd+HavJY4l+U4uB9WQgpmmbqLScKJxbZYLA
	QqS9JyiY1FP0I5tTFIlxYaP7tBeQdDwSkm9NIlt1t0FjIfoHkzOVqd9FDLm2Cn3qwfvf+lz
	KAyXi98s4G5miWBYuOPLPWYsYjekG/1iNie2S2x14EPNjujF8P3uoPNMVvdI1r2iYP2SFm1
	6hr5X01KFswH+w2wiDIgZRCy0zWg3KGVO00KC51RtHgJjBa3d8u4PPIUzlpBDIGJ5N5V2FH
	vJ2WXmA5Idn2oa9osArv6BQBpMeCDGUSYlYd6MIwA+/C5hUwL3eDQfpNe+E/T0XlZ8L5cr/
	5G3sxOoo03kL74RgG742gGhD4qqNcPXUOc54aQbE9DQRCknMH0uqLKECV9Iv5KcB2Jx0nLB
	Rj6czwVu9wEjf5i9Ae77lWBcKrCDwnLkzxrCcF7chx6CGBbS5SwgAKOnU+gHUb0tEaaKvnB
	M+sALCQ16lP516hmwrtgiK62EACyAKjKPYbEnKl7An1ChfYxc8qikGu2oUHn2xwGdym1fxm
	uEh6+9WH3jh9y0mVn5FDsA0VYXdrEsviFkLoxWs4ghrJxGFJQxgVFThQyWNZ4qCOH9nH60w
	fHdc8xXRc8exQq9sv31tN6MBAyNn+bLgQHu/Q6ZZEUxwk1tRoQpeihI1OI/obi7Gom34ocd
	rwEWWTZYl2t25WB/2D+GS6e7zobwqoULh9S1UnaqHglcUVn6z6ceyjnu+QTeQ7U+Pm6VIcQ
	BNtK1YvlTWLLKBF4TXlKfjsJBo8welsne0bHxZQj8oBjVWx9SvDt2tXExyvkvkiISlIAR6w
	3C7G04hArIEze3ev2Am/RcTtPN92d1OLGOOeCTdTt4WXL6aGOTz4sfKNvfbNbgKPAUXWN6J
	4te+ZFDjwrx2T/j/la
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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


