Return-Path: <netdev+bounces-189439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F213AAB2131
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 06:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0F21BC1140
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 04:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEE31C5F13;
	Sat, 10 May 2025 04:48:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBED1B0F33
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 04:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746852504; cv=none; b=F6wD21EUJxklZMTcO6lNkzyJ6AtoR6M9KVkXOLv5T+z+KlQH1LgyLjNItt7dqS+UYWPAyC+Xbvrwh+G6lAQ02sDrubOpFCWR0E/ibgguQt+LB9AFJqmocrM5awkEu3YWhIZm5i90gtKIkMktu8u1CRJmfY80DbjLCxmqidPx0HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746852504; c=relaxed/simple;
	bh=uPrlcZEtyzRtvySgjanORGMgKiqZEpPSyLtz19ByCsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lS4iJNv+ubvHGa5oY7YaIg9EgRpWqa4D51+wo8hp4xJtU3gEjTBqZtPyJRX4vhNXYpVgTHrxS3MuAEcVYsutEQER23XkNe7U0RfKuTDkxToSWpWH7xeZ894d67F4cYZbYQIxoJLPEfGPtu5gcCXdg3KItouabXxCsdkfBwx4yCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz12t1746852336t89fe89fe
X-QQ-Originating-IP: xU8IPsipLrv86IOHm72M0UjwugVHSeOeHBD9Jb9IzgQ=
Received: from macbook-dev.xiaojukeji.com ( [111.201.145.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 10 May 2025 12:45:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6556987884993357446
EX-QQ-RecipientCnt: 10
From: tonghao@bamaicloud.com
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 4/4] net: bonding: add tracepoint for 802.3ad
Date: Sat, 10 May 2025 12:45:04 +0800
Message-Id: <20250510044504.52618-5-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20250510044504.52618-1-tonghao@bamaicloud.com>
References: <20250510044504.52618-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MUe2PhP7Eq79QA16Lk7F1k/MdJvIHBkP91c37vJyT3FmcvqDIXjU1xdL
	jfUOcZXaTwSHLb0C4vnvGed+9Y8bvSgIMpNHBjNy7j7TXl+XHateyJ5XgY0wDlxF/k/5djA
	l72zD9rs0wTinPPZQim9YZdTK/K2NkdsaBbMaCWGc1k7AKatUpy2RCI/plcTbn5c7h6ZR3S
	1UNMN7Qf/qU6HAn0fxouwLE8nmBYd7LPCQkYmRU4oDjnPz+maO86YoDlum9IHrY8k560+KE
	9woXpJapdRcwS4PpapwGlbDdai9YqGkHWC4emXvhqYrYliG0z2yXIOhwGPjs04UoYPkepRm
	z+bUqv0NKxyb/RjTmBxtYIGI5/Yw1X478Tw2yj/AHsOUO8cN7jzMUhRTVx3qTF7FUO+Rh3P
	Rxqg2PDG6eSdCQv35+tHo5z2ZOqgbr7BvvXVMA1F0c5I3Cda/iu9feCAOwZMHHL+08xhgIE
	RRr1IYCsQ5xcQ7IobZ+CfwOftkM3A0DQjYo6eyygsu6/L6NAgeXvi/CWKcHeOPfAMsESYB+
	zfGgo9k02PdFQCOnYCGq4w+zvSq+n/91izfcLc3RwS98Bf7xs+C7xhcS0JwauAtv4KV2jVV
	qFrKs7FfWVW2641LQFDDSVd56q2qRheQE2ACO6yv+C19w3Z3cDop6MnBFIAUpTL+JF205WY
	0dDc6ytaxdwfgYFouzjMa9ohFOXUilhX4TJr/8R3QhUsJ9ksmNafWl08J9Ft/ox9qwKrRq8
	CmRfbz6/qW5O+IUktYLqPjPEChv7KeHOxpyiea4kRl79COg0QfOwmC5onlXCdtCSqwtWTdy
	l9cSf7iw2AcVraDpghaZECoR9RXQ9XuCu0+dAsNW1vYKuKVYIWovej7YtZ3nUfmS05LuJaN
	BdTu0MCpxGliFcwTYUewKOfhO4WtY/wqkfQEjqphMfGdEt5CWPps9RTYPAC2JOgIVWL+jTi
	JM4G9QP1RJBv6DPMpG0nWEXhaRXBJR72wG9tAFK4SRwcXUxojDhXxZPnsSpklxgf79PCrtd
	Mofgek7w==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

From: Tonghao Zhang <tonghao@bamaicloud.com>

Users can monitor NIC link status changes through netlink. However, LACP
protocol failures may occur despite operational physical links. There is
no way to detect LACP state changes. This patch add tracepoint at LACP state
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
---
 drivers/net/bonding/bond_3ad.c |  6 ++++++
 include/trace/events/bonding.h | 37 ++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 include/trace/events/bonding.h

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 6577ce54d115..962be118f3a8 100644
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
@@ -1148,6 +1151,9 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
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


