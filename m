Return-Path: <netdev+bounces-253061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KRKGfaVdGlG7gAAu9opvQ
	(envelope-from <netdev+bounces-253061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 10:50:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E1A7D228
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 10:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76DA430097D9
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 09:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A810020D4FC;
	Sat, 24 Jan 2026 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QiMq/4qW"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCFB3EBF3A;
	Sat, 24 Jan 2026 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769248242; cv=none; b=VTunTVje9KFfXGlglX2f45pXJnzbEnoCgP5zg8mzWUUfLTEIH54XSWlF1W1HvM9AHLkdMe4TqeCLz/nD6OqYBxP+6mW83KvgPT9hl57/OwuW9fZmG19vEAzF2iX4mAhidL+cpVKL12MZNI4CGOR/TpYmD/UG8BHgVvsuAfUYLLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769248242; c=relaxed/simple;
	bh=lceM+7tl+loedWI5IIeiE5zIHpevaIM2QtpYY5MZEn4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NdQRtGiU2TEQj9mVveXdGSPVxdkqFunqEfZdAdmE8QXfhBw7gVBs6UQHYmEK4q78sFDDghuayyMEzondAu3CK+IdxgOCaCekuyAHbSiqORbWK1eHVLO/jmeXqljdA0rnmn2YsHHqLzLESuDGpUcC2X24QsXe6mZFDQ5p9L2ZzmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QiMq/4qW; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1bbc654af90a11f085319dbc3099e8fb-20260124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=EHh228QxGIXrrJVTE4aa2QYRaQvESHcQuamH6lLYXdQ=;
	b=QiMq/4qW7pDGYKe/lJWvzXjQMUous/lQdv7DVMOoiUe6pM8l4TZ6IiT7EoVS5lTNxmTm/qgjgF3vlvf4KUCMu3UzfzidNFhN23Qk43yQ9KsKdvZNLL4WBl9bhjyopAsimuFMSIiiX0EBnjuGlkndP6iyLpoY4DuIp6uyIkbknDg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:3939162c-f7c1-436c-915b-c644a7fe91c7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:01ac805a-a957-4259-bcca-d3af718d7034,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1bbc654af90a11f085319dbc3099e8fb-20260124
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jibin.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1605577255; Sat, 24 Jan 2026 17:50:25 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 24 Jan 2026 17:50:24 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Sat, 24 Jan 2026 17:50:23 +0800
From: Jibin Zhang <jibin.zhang@mediatek.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
CC: <wsd_upstream@mediatek.com>, Jibin Zhang <jibin.zhang@mediatek.com>
Subject: [PATCH v3] net: fix segmentation of forwarding fraglist GRO
Date: Sat, 24 Jan 2026 17:50:18 +0800
Message-ID: <20260124095021.3953-1-jibin.zhang@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-253061-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,davemloft.net,kernel.org,redhat.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jibin.zhang@mediatek.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mediatek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E2E1A7D228
X-Rspamd-Action: no action

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
v3: Apply the same fix to tcp6_gso_segment(), as suggested.

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

[2]: https://patchwork.kernel.org/patch/14375646

[1]: https://patchwork.kernel.org/patch/14350844

---
 net/ipv4/tcp_offload.c   | 4 +++-
 net/ipv4/udp_offload.c   | 4 +++-
 net/ipv6/tcpv6_offload.c | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

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
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index effeba58630b..3c7fd0362475 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -170,7 +170,9 @@ static struct sk_buff *tcp6_gso_segment(struct sk_buff *skb,
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
 		struct tcphdr *th = tcp_hdr(skb);
 
-		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
+		if ((skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size) &&
+		    skb_has_frag_list(skb) &&
+		    (skb->protocol == skb_shinfo(skb)->frag_list->protocol))
 			return __tcp6_gso_segment_list(skb, features);
 
 		skb->ip_summed = CHECKSUM_NONE;
-- 
2.45.2


