Return-Path: <netdev+bounces-154887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE47A003B1
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 06:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 033F87A19F3
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 05:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152511865EB;
	Fri,  3 Jan 2025 05:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KdgoD3eF"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB776D2FB;
	Fri,  3 Jan 2025 05:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735882879; cv=none; b=NKrn6eoUcvlPfzrwnYQROdBu7IL80VUBCRJXE4/FJTUOmJA91wBPx3FT8k7lX/GXbxY7fYj3lMwQgWltLE78hyPiT6/+6Fg8q7LsZx0jJoZGoay3tnRWS6GJnU5NJAEc9oZ8idM4ORpaZiLZCGR+qLMR1GsQGwi/NVApa+MYqcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735882879; c=relaxed/simple;
	bh=3IrOZxFKj4iNnfXXjBXxQULBlrkbv6ty/ojadt9orX4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cZTCTNYTbmLT80Uvv3sySur77pn7TkirONcnMYc4N6qYu/lxKDHBpakBiXzxw5t1cIvwA+ZxjtCeXLAjKOw4CVgCdRrQ5pHjs6HRNcgbtmXn0P9PVMUihczVy3Yzy/XMxSFha+ZB7v1fcDjxkdKU39a1O0Z12FxfiSL5zem9Vh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=KdgoD3eF; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5596ed3ac99511efbd192953cf12861f-20250103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Eg4Oi75Mp1rTvatlYQI4XUjpgg0k+tOQGw3eIL+gTkE=;
	b=KdgoD3eFnnRyhud7vYZxYUy1SqJIxLwgU1XhlcKKyjMtMncPS4k3DQi+Xz7395yZsc9WSQqDjyUU/HIRDWO5rKYbRT1BRqkqcxiN9/DVpwn12Y50lmZSslUtcE+Felu6a8yCf58BeLjampe/xaRfbDCdAf/qKfWk1oZHtICNv90=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:23b2c9a6-685a-4220-aac9-747f2d1b7e16,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:b5904b37-e11c-4c1a-89f7-e7a032832c40,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5596ed3ac99511efbd192953cf12861f-20250103
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1009232442; Fri, 03 Jan 2025 13:41:09 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 Jan 2025 13:41:09 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 Jan 2025 13:41:08 +0800
From: Shiming Cheng <shiming.cheng@mediatek.com>
To: <willemdebruijn.kernel@gmail.com>, <davem@davemloft.net>,
	<dsahern@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
CC: <netdev@vger.kernel.org>, <lena.wang@mediatek.com>, Shiming Cheng
	<shiming.cheng@mediatek.com>
Subject: [PATCH net v2] ipv6: socket SO_BINDTODEVICE lookup routing fail without IPv6 rule.
Date: Fri, 3 Jan 2025 13:43:49 +0800
Message-ID: <20250103054413.31581-1-shiming.cheng@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

When using socket IPv6 with SO_BINDTODEVICE, if IPv6 rule is not
matched, it will return ENETUNREACH. In fact, IPv4 does not behave
this way. IPv4 prioritizes looking up IP rules for routing and
forwarding, if not matched it will use socket-bound out interface
to send packets. The modification here is to make IPv6 behave the
same as IPv4. If IP rule is not found, it will also use socket-bound
out interface to send packts.

Fixes: 6f21c96a78b8 ("ipv6: enforce flowi6_oif usage in ip6_dst_lookup_tail()")
Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
---
 include/net/ip6_route.h |  2 ++
 net/ipv6/ip6_output.c   |  7 ++++++-
 net/ipv6/route.c        | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 6dbdf60b342f..0625597def6f 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -214,6 +214,8 @@ void rt6_multipath_rebalance(struct fib6_info *f6i);
 
 void rt6_uncached_list_add(struct rt6_info *rt);
 void rt6_uncached_list_del(struct rt6_info *rt);
+struct rt6_info *ip6_create_rt_oif_rcu(struct net *net, const struct sock *sk,
+		struct flowi6 *fl6, int flags);
 
 static inline const struct rt6_info *skb_rt6_info(const struct sk_buff *skb)
 {
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f7b4608bb316..95728c8921cb 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1156,8 +1156,13 @@ static int ip6_dst_lookup_tail(struct net *net, const struct sock *sk,
 		*dst = ip6_route_output_flags(net, sk, fl6, flags);
 
 	err = (*dst)->error;
-	if (err)
+	if (err && (flags & RT6_LOOKUP_F_IFACE)) {
+		*dst = (struct dst_entry *)ip6_create_rt_oif_rcu(net, sk, fl6, flags);
+		if (!*dst)
+			goto out_err_release;
+	} else if (err) {
 		goto out_err_release;
+	}
 
 #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
 	/*
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 67ff16c04718..7d7450fab44f 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1214,6 +1214,40 @@ static struct rt6_info *ip6_create_rt_rcu(const struct fib6_result *res)
 	return nrt;
 }
 
+struct rt6_info *ip6_create_rt_oif_rcu(struct net *net, const struct sock *sk,
+				       struct flowi6 *fl6, int flags)
+{
+	struct rt6_info *rt;
+	unsigned int prefs;
+	int err;
+	struct net_device *dev = dev_get_by_index_rcu(net, fl6->flowi6_oif);
+
+	if (!dev)
+		return NULL;
+	rt = ip6_dst_alloc(dev_net(dev), dev, flags);
+
+	if (!rt)
+		return NULL;
+	rt->dst.error = 0;
+	rt->dst.output = ip6_output;
+	rt->dst.lastuse = jiffies;
+	prefs = sk ? inet6_sk(sk)->srcprefs : 0;
+	err = ipv6_dev_get_saddr(net, dev, &fl6->daddr, prefs, &fl6->saddr);
+
+	if (err) {
+		dst_release(&rt->dst);
+		return NULL;
+	}
+	rt->rt6i_dst.addr = fl6->daddr;
+	rt->rt6i_dst.plen = 128;
+	rt->rt6i_src.addr = fl6->saddr;
+	rt->rt6i_dst.plen = 128;
+	rt->rt6i_idev = in6_dev_get(dev);
+	rt->rt6i_flags = flags;
+	return rt;
+}
+EXPORT_SYMBOL_GPL(ip6_create_rt_oif_rcu);
+
 INDIRECT_CALLABLE_SCOPE struct rt6_info *ip6_pol_route_lookup(struct net *net,
 					     struct fib6_table *table,
 					     struct flowi6 *fl6,
-- 
2.45.2


