Return-Path: <netdev+bounces-195929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C3FAD2C3C
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 05:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578813B01E0
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 03:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CC81CEAC2;
	Tue, 10 Jun 2025 03:46:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6596825DCE5
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 03:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749527199; cv=none; b=j5XcZnJ53ra48M1Z3kjhdCGflQkkMcCCcvrOHUMlEGwptZlk0Y6rbJHXZWl57LkIQ4XrOPG6U/aDjOsmv83b8b30+D6XjrxP26aSVg6JFoFDJQbfckfpnRC2KwHtwfudt/lGZemSns4BDi/q3rEV2eLIKonk/Zn9yqiRVVhifSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749527199; c=relaxed/simple;
	bh=VyDvBEV3fO1OBjk1ynvl3O2WEV+B2F9EQqba8/egRPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LYtixSJzT2EBnMdvCsPGfEdVnlJFajoy1FBAQLrnLwf6R7Dtkz7cYKrHiBgGUWD9pKMs5rrw3FcgsOhgB427sVb8dqDEayKyoIAbffy6070+KIipqNSujbtVfgvU+E4iyoJSHQg7/H9ZxcMU6oBy5EDs9qB3sMWHDZS2/vHhO+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz18t1749527177t5f63e611
X-QQ-Originating-IP: ljHJWc5mYsz8c+zAitdh98wqTyP6NzWQ7V1j3ZUwtzY=
Received: from localhost.localdomain ( [111.202.70.101])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Jun 2025 11:46:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13480387239181489020
EX-QQ-RecipientCnt: 15
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
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Zengbing Tu <tuzengbing@didiglobal.com>
Subject: [net-next v6 4/4] net: bonding: add tracepoint for 802.3ad
Date: Tue, 10 Jun 2025 11:44:45 +0800
Message-Id: <10b8f570bd59104a1c7d5ecdc9a82c6ec61d2d1c.1749525581.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1749525581.git.tonghao@bamaicloud.com>
References: <cover.1749525581.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M28vnsO5i7WeoD+SBIk8rxz+6ocB2ABaSU/0KOGGMJxcxuMPWSwwwL0y
	Ea+7Dft3kMPmjjuiylIaOaRYvkEBxPS2c99TW+qw7+qpnHJfqrzkTqpKvnXmvYmYV+pjVrq
	BFxSr49wpUvsBwENoLDqOYl8ZDwImno56pQ8nmdjaslA97KgmsqCLxXJqz0ywkCq/l5RoE5
	C4Y6dGfVeaaDBzZZwaeQN5utd/tYkIWFpxuGbJ8pOqLOaxJV09NiCdXaMYpgp8z9QOd48fl
	zXG1gjR4vsJIDQ1Ew7/VVjksQtNW1iBpYvRDOwyOGaBO4YxY5UTO2HcNcZ/gUqzlzpIp0kT
	IJRURRs9ur9efERAX3pEnenROQLWdA6dyVSHHiv6H70h6n9QiLAbn+/MFoP4pQy1QeaMEW7
	kOg0tx6CkcDOF1aiN7BkHYyL9zaVfunXL+FD5HkC0VJtdmlbvsTMXGRfLbZ9eQ7JihbYM5m
	12E72Dl4aZzjK1LysPcB1KiQ+rgRuYSw5bt8aUOHY6heKw6+RUUJW0KJkUicaIGvPB+cU2A
	oMcCMOBiExq85hnKvTf5AX5inxL1yCiv1a2NWgdl4RfN5cywBXlqwYsl4mgwZ4Ogm9BSXlZ
	UUfwnkruvmo9e4Hu49pmBljPeAAGLtQAY8HOLRfbydouq4LuMJdPfXVRcrvPFKvvh3Hju6h
	M90tSUIl6hRalDGCUipsE/z6E+U2qtS0rj9aW8n4zF8FdTBeIvrNjQPzDjvgj2QKSbQoSyB
	nlhIkB0Qc/yy/bWX51Mv09OOQb+KSOI66/CqI74SwMUvzHTfJFqXEnWr0/GMRwcJXNCwqfN
	/1z+NiL/pSRZdRoKPa79EOejjwcat6T+D1ImkcvIo/TBW+/Z5lYWEVAC6bgfaE5CMJ6qSPm
	H2LaqjKVbzFTu2CmfC1H08e3r7R+XpBtmgOr/GEYqlfAxBvIlvecCfgKL4ueEdJk+SahxFD
	A6SDJQK+BTg1wlfT4Sb2LkVGZI9QNAvBw0lS2mYPG9OGONIvhvnc3N2a0
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Users can monitor NIC link status changes through netlink. However, LACP
protocol failures may occur despite operational physical links. There is
no way to detect LACP state changes. This patch adds tracepoint at
LACP state transition.

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
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


