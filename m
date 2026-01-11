Return-Path: <netdev+bounces-248797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E882AD0EB7C
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 12:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EDF3300C5D5
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 11:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6826323406;
	Sun, 11 Jan 2026 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LOsQb0YE"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7B721FF48;
	Sun, 11 Jan 2026 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768131556; cv=none; b=P8wMEKKkwzFjtFbbQALXvatKDdN/WQ1ClEHi5Z9x+YwKXfXe/hE44vr+/IUUmhS56G0uYWrS/Z+p1amJhhIkZJEyY4+X5rGQUWdAoszCnZEH2iMm4hyBGNM8ucFFGZEt/gXkXKky97TE7Pr7ccSfNUgJ2lR+aHNNrpngr2tgZsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768131556; c=relaxed/simple;
	bh=hQMJSfAe59dMl+rWf30r91qj/nVJn0m7vU484+9zGzY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G+Vkpqp/gHjs6F3f6iiM28F05V26wMe2xL/yMywHUAK31tBtnnx752QmmrhnakC78XlJzFFvfNUBQI5klCwVZaR+SU73lmuveb9Acg7PtSheGRBF/feCGIZt2czQxR/y99nnQU9WWTUDrtvd2oQkI7cELCZERiD01pQHrBJQikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LOsQb0YE; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 07813878eee011f0942a039f3f28ce95-20260111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=vmJtVU6N0MouEySwEwBNcMPu8mtgmC4osbjka7kRxyE=;
	b=LOsQb0YEu52eCBtnzdsFroT93MUYIDNW4kpJ/QIMlvGtoWse0YxRnRUCJAxPk3MO2pw3CrTfzbzwznJsHZk6/HTDHEql9Hs2Uv11H8724LunJSNGdIpT2G7gxQWyRgIgWs/9aQ2c9W7AmqgpHObxo3zx0n/zMPahxyvjkvMbZyY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.9,REQID:31191062-7dad-4ff3-8dad-f802bd1abbf2,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:5047765,CLOUDID:7dd85fe8-ef90-4382-9c6f-55f2a0689a6b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:1,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 07813878eee011f0942a039f3f28ce95-20260111
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <jibin.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1947646583; Sun, 11 Jan 2026 19:24:01 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 11 Jan 2026 19:24:00 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Sun, 11 Jan 2026 19:23:59 +0800
From: Jibin Zhang <jibin.zhang@mediatek.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
CC: <wsd_upstream@mediatek.com>, <jibin.zhang@mediatek.com>
Subject: [PATCH v2] net: fix segmentation of forwarding fraglist GRO
Date: Sun, 11 Jan 2026 19:23:46 +0800
Message-ID: <20260111112355.21504-1-jibin.zhang@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch enhances GSO segment checks by verifying the presence
of frag_list and protocol consistency, addressing low throughput
issues on IPv4 servers when used as hotspots

Specifically, it fixes a bug in GSO segmentation when forwarding
GRO packets with frag_list. The function skb_segment_list cannot
correctly process GRO skbs converted by XLAT, because XLAT only
converts the header of the head skb. As a result, skbs in the
frag_list may remain unconverted, leading to protocol
inconsistencies and reduced throughput.

To resolve this, the patch uses skb_segment to handle forwarded
packets converted by XLAT, ensuring that all fragments are
properly converted and segmented.

Signed-off-by: Jibin Zhang <jibin.zhang@mediatek.com>
---
v2: To apply the added condition to a narrower scop

  In this version, the condition (skb_has_frag_list(gso_skb) &&
(gso_skb->protocol == skb_shinfo(gso_skb)->frag_list->protocol))
is moved into inner 'if' statement to a narrower scope.

  Send out the patch again for further discussion because:

1. This issue has a significant impact and has occurred in many
countries and regions.
2. Currently, modifying BPF is not a good option, because BPF code
cannot access the header of skb on the fraglist, and the required
changes would affect a wide range of code.
3. Directly disabling GRO aggregation for XLAT flows is also not a
good solution, as this change would disable GRO even when forwarding
is not needed, and it would also require cooperation from all device
drivers.

[1]: https//patchwork.kernel.org/patch/14350844

---
 net/ipv4/tcp_offload.c | 4 +++-
 net/ipv4/udp_offload.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index fdda18b1abda..6c2c10f37f87 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -107,7 +107,9 @@ static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
 		struct tcphdr *th = tcp_hdr(skb);
 
-		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
+		if ((skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size) &&
+		    skb_has_frag_list(skb) &&
+		    (skb->protocol == skb_shinfo(skb)->frag_list->protocol))
 			return __tcp4_gso_segment_list(skb, features);
 
 		skb->ip_summed = CHECKSUM_NONE;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 19d0b5b09ffa..2a99f011793f 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -514,7 +514,9 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 
 	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
 		 /* Detect modified geometry and pass those to skb_segment. */
-		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
+		if ((skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size) &&
+		    skb_has_frag_list(gso_skb) &&
+		    (gso_skb->protocol == skb_shinfo(gso_skb)->frag_list->protocol))
 			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
 
 		ret = __skb_linearize(gso_skb);
-- 
2.45.2


