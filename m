Return-Path: <netdev+bounces-191438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFA5ABB7D1
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EACEB1891FFD
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738A452F99;
	Mon, 19 May 2025 08:44:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294A226AAB8
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644299; cv=none; b=uyFPKr6hlgY6U1C50KmyzRrSApVNWt4A4eAk84rF2oJsOl48lRbrqYRfdzhbFft+vJwpj/Meqw2T2sWzp/ql+E8v7HTI5N182SUHS3Udz4+/FVTCX7biPszsHmfSxG26bNa0Dk4mLnErHfIw5ppmsLn+2rNm4RzhSDHH78GPyKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644299; c=relaxed/simple;
	bh=L4He3zMPg6gtceqZSvMFu4ohCmw5ZcGFDwRCZQViHiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKEQekm6YyUiyC1S18QwOnLswf9StNeQnG3INjKqx6s5iZ3MX+1l2JawZMdmFTSbS3bfMsc7gq9+pFt+nfiXAJCuKVdd+Q5RtPBVEEG5XQSqRKIW/J47aoZgNxZari6vxc83I1tokOX2WwLei25XcE6B9vZARvJPwEtlvkMb5ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz15t1747644225t03a9d697
X-QQ-Originating-IP: XZCW1RcYyoz8cip9Y9LJFhaWRwB8qCuHexMgOwlOWrA=
Received: from localhost.localdomain ( [111.202.70.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 19 May 2025 16:43:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10570029911911749509
EX-QQ-RecipientCnt: 12
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
	Zengbing Tu <tuzengbing@didiglobal.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next v5 4/4] net: bonding: add tracepoint for 802.3ad
Date: Mon, 19 May 2025 16:43:15 +0800
Message-ID: <504B22A76A3E5D9D+20250519084315.57693-5-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519084315.57693-1-tonghao@bamaicloud.com>
References: <20250519084315.57693-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MdoRYM9mYrydcXunzjcOjP0k34RK+BHtqn9a05YA0CyxAd8ivtEDjd3N
	43Bffm8n8FxqozZeTu4RPMR76+i0UBjGu+0GW/Ptm+m3/jTqCbdSrv1jrkLJSbY8nUzOx2w
	vn8FUu9TbhtFcgi8XbcZ+je0qmLYHau9U6qGIGl15uj6BuRVVpDtp3+IhPKQHj4SZ+TYLCG
	3W+NMzc3YkGDdQtNYamMZGfHZYUt7K9kYZ5zXcc1r10uwLEzIHpGWxYQfzNReDKjfxzRBO+
	9fjVK30zN0qkHU8IQe4zudVQg9ytTGDZmSsLBLvGxaIcKsBxq7qeFiV8YjaLMJcAyV9w31m
	nyV4DEM6MWryo09u9vBAGLcS1jfnBLrbdkS9FZ98u7YI0TIjh7mpjnGgqnZCSSn1Yl0Z+Fg
	EPo4tLqDFJ4w4yUNgp5A26I9fj6JhJgUqFuPLEo6kyTOiTUwhF4PrTlVmXBB0mdC5l5Yq3o
	T5f1vRti2RhKxt/w7BTS18VECcwSE9ktsuQq6oDBJ1jLOH+jGR48jclnDtEtFxGX6IUvxck
	vFbtney1xKCv+spfCfUKEM55aoO3IOwxzWVe0CRlE3PkIywTRdAUUa96xItMLqOPwoSQ14w
	Lq/c62LZBC6SMgyZBsBHS4pfQMwg48QOUrlRNJY2LdDGbjPSB9Sfd28Dbb2HofBdtj89/1O
	KaaADFzc0Tf/SJfZcTQYMgE0kWbEwihUcSwh5ZAWSgSIUgrqKGVMrvu8lnO/FJU2GtZzB5C
	37khJ0aoK3RRaF8HfaMbp/HiK+J77O/79CZYskO6hXw7Lo2Dhpb7ROdOdpn7dn7g1IAnuqj
	zzuVjTwp2gNtaIf9YkCPUjPyn0qgRmyhbT0QMQfeolw2jxmEnz9S887Xf8mHcYUtFYfelET
	iOJDYL39ksUWTKy/LtatKgZFRdx6fG04xXb/2vuD5lFeHcqcujoX7c1i4ONfxBAuctJXeJ2
	z7/OZ/MDT3YZec2Y3jUDmZJXyYbatmvorjOQXhZgEoKX/JU5U6ErFwtpD9SaOrK414y7Vne
	m5N5kBmg==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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


