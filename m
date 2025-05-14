Return-Path: <netdev+bounces-190355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6381AAB677C
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 11:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C1C189280E
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F22E2253BC;
	Wed, 14 May 2025 09:27:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56D7221F1B
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747214826; cv=none; b=ugaSb/mh5p0UuPrX3xtptnPbKGIRhdimjYDFMGNweZzYSymMjwoNHXTH2N3n4F36iVa+ct2CDoYRQ+8rY5nb1uIkT5ri/8GIFa0y73akW810o03ygK2BwL8KIYS0WjlvsOzARPDDUeUrO4PqV88dwUgNW0tMHemneJgR23BeUUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747214826; c=relaxed/simple;
	bh=GAx0cPO1sRRwDyB3alcJRBmqpo63k/bxnkLomjOBuq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hM4+lTnNdvKQhV2LnHFDtQ0qWYJcDeUffgbyComK66v0RIAmo+1yxyge9caGBFgKoBPVyuPg8ga4r3ZnVb3HwHhrSDns8cqzfNAxA+rBTVY0jyED8TbPhREzfGXNS9CImTWokzgJlp9llglhZS7mjdTin7bZXlzySmH5FVjY1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz7t1747214771t40c3ce4b
X-QQ-Originating-IP: Li5xEDQHtqV0uHV1GnGvLUqRwRot5KzKFNNeAqP39rI=
Received: from localhost.localdomain ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 14 May 2025 17:26:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17572314117757724046
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
Subject: [PATCH net-next v4 4/4] net: bonding: add tracepoint for 802.3ad
Date: Wed, 14 May 2025 17:25:34 +0800
Message-ID: <DDF908383E15A2CE+20250514092534.27472-5-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514092534.27472-1-tonghao@bamaicloud.com>
References: <20250514092534.27472-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M4B45z97fsbxul+Fe50/jvau1Qvqg/xgEOuwILF26n7dgFrlEyzjujTH
	5Hhu7QsL9z4caICjiNmtk6t6TnZ1YgMPN0IVHyl2ukBP5bx4dIqQxao58DRO5L2wBA+4Kll
	SdpGDpuOEIu643/X5YIuOLoGh3tOxcRMYbleEyBULeQBasZmxrcBOd9yZAbCBtTluJ2Sh5E
	v98ZWE/iX+e3UoEvkiHOCil9IFNqwP6gYfwiT/yKQZZ4/Uh0rzHH9pGuctdQ4QYdfOmbN+P
	qWuuTiP/cR/9qHcocZSGPBTEe6HaDFy/AMKqqy7nknMBdL3dfGu1cEsFU13zX/8E8yaaA8k
	Aiyd06PQf9eo9cejsvjrPMFAbFP8e4QRKr0G9J73jo/T/iZ0dSIB8H9l2d46d4hchLyB1nw
	mOdhXohxiAeUnqjY9xfboTUJo0OBPsUzMzFx5qPp6BxW/dAg3Nvczx5YP3PaiafromdiWru
	XrbDMR7BimCPp4dC3VxmKVjEy9rUpyFniC+usAEcwjkNbTU/escTJdJQma20JzbLU6ufedK
	fDIS7x9wvuBSFsu85dEAE+P0hqHv95KPjsH4gvxM96Ws5MBWmlu/L9Ghdl+Nn3RbufTq8xp
	u0jfma3El+Ku0DLUAAwhjx9R7RqRYloX/deLO/eVJGKZoiaO+ifFN8nihOFD5cTJjQ0VhdG
	oMub758rx9lwW6H/3q/BONCTRKYyDPfECygLwKT6edLUAETqa/9Eiznqz7X1MCD5zq+l1wj
	7Yt5XBR5kPSPnZtJUBxqMNsTjFb1WZPeYKCLv0emUiJSNJ7ltYTdRJ/002/MgHZi2JRoGHv
	1uCZX3lIBhE1tbtFCIKIE6TqAo8caESsTmrkIDtv2niRCLmxoZ53FvBh5ATJ94VMqDvdSo/
	x1R7oY+Al8v97lT5zFXqthy/zGEQOUjsyplCpI3wDyjqbW0ohSPXCm3SJgPh4vWiz1sn3bJ
	KkbjKO88OD37Rag1ZdXr1f+m8q8/AaZwIC11upvh/MWwI8z/XxFxy5jjwHvqZ3gqpHrrlnF
	CoLLnAhFEUNMd/rH+mHNiDJ3WF2KlFuC+Q958iIQ==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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



