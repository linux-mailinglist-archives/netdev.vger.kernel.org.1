Return-Path: <netdev+bounces-245040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1ACCC5EFC
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 04:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66034300BBBF
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 03:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A6C27FD7C;
	Wed, 17 Dec 2025 03:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Tlni7/FI"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEEC23D7C7;
	Wed, 17 Dec 2025 03:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765943762; cv=none; b=NsbW/zdmpYAjaG/3010QPbyHzB8B2zRWKmmC3o1i/g0nZo+WDqv4xMJ/UrL11tN815CF77BUVoM10OLmtTzx8ngvvgeK5AD078VG71h89SP/7iEaBR6ptc0uA0Jh44rzltPhaOxtNTjNuWRCB7SqkdbwWb7VEdxRVwClcaTRdbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765943762; c=relaxed/simple;
	bh=LE0uHuh6pTS+B0PdD5RafJ+S+XfDAz4yBSHP/iVnrZk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uXFsft623Kk/CyluwERF4hUrxNt505xu25kcHKr2SeNNivBerj2vWIm36Ta0EOj1WHDPkSIhtdHzqCD8KZ865Bu5HtCznzJYL3lfONtexzzXdWhSbJdAtiaQmFtzz5jMjr+5OVm2jpjSrMMuxUcnJ1EPw2XMV/+y38C1aIuxARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Tlni7/FI; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 48f769bedafc11f0b33aeb1e7f16c2b6-20251217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=g6vBW2JewppFyaRLb6KGyeqKVlYw6haEmZpTMY8QxvI=;
	b=Tlni7/FISvDqX4RHVG3FxCMKhoNzFiQ8m8hrBTkHN/TCMoxCbPdWonNZdiwU6+wLPhQNMsjust2OZlW64AIkp8lXrpcRfMsWoSg116LddbRckcasrpP31cbAMHLc2bwDlk3PcPX28sP6D8958jocsdyZOv8IyLhWc2JedZRpFao=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:7f37a831-eed9-4c19-9ade-06229eace0b8,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:2e469b28-e3a2-4f78-a442-8c73c4eb9e9d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 48f769bedafc11f0b33aeb1e7f16c2b6-20251217
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jibin.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1373861328; Wed, 17 Dec 2025 11:55:53 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 11:55:52 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 11:55:51 +0800
From: Jibin Zhang <jibin.zhang@mediatek.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
CC: <wsd_upstream@mediatek.com>, <shiming.cheng@mediatek.com>,
	<defa.li@mediatek.com>, Jibin Zhang <jibin.zhang@mediatek.com>
Subject: [PATCH] net: fix segmentation of forwarding fraglist GRO
Date: Wed, 17 Dec 2025 11:55:42 +0800
Message-ID: <20251217035548.8104-1-jibin.zhang@mediatek.com>
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
 net/ipv4/tcp_offload.c | 3 ++-
 net/ipv4/udp_offload.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index fdda18b1abda..162a384a15bb 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -104,7 +104,8 @@ static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(struct tcphdr)))
 		return ERR_PTR(-EINVAL);
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
+	if ((skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) && skb_has_frag_list(skb) &&
+	    (skb->protocol == skb_shinfo(skb)->frag_list->protocol)) {
 		struct tcphdr *th = tcp_hdr(skb);
 
 		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 19d0b5b09ffa..704fb32d10d7 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -512,7 +512,8 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		return NULL;
 	}
 
-	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
+	if ((skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) && skb_has_frag_list(gso_skb) &&
+	    (gso_skb->protocol == skb_shinfo(gso_skb)->frag_list->protocol)) {
 		 /* Detect modified geometry and pass those to skb_segment. */
 		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
 			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
-- 
2.45.2


