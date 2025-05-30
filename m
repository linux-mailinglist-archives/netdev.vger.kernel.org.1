Return-Path: <netdev+bounces-194293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A217CAC85FC
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 03:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE991BC141D
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 01:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1F0148850;
	Fri, 30 May 2025 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Uy9M2H8x"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFA69475;
	Fri, 30 May 2025 01:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748568183; cv=none; b=R4Oudds5r1q2lH18Tgwn6twTQvWGUx5bc846BL+VG9cjcvZJ58NS8SkUKbc4eVAgTFcnCtrKQb0kEPnIl0InVt3ZSdwfKI2FoifyMGzLpKQt0zRQJQVq6zOmXeLbScgzhNZegi4F4gvdyPBkR17e+AcbWqRVNuzw8jF0oB3lVw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748568183; c=relaxed/simple;
	bh=pfifIOZ6L41ab8gAlCxvqrKmjqTJMmJ7xVknGjPKv+o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J94EXCmSuKdNFkteV6PpjvqL4Gc411rgk9yq5KBCyJGV6+YLXTC2+SE/b8Mwur5gS+kNq2G3f2pzRLrPGWar0RUuERzUFYkgfnMnvPmVGWWPit9XvP+uEXlD60cUOO4xBqmWWTxX+HjHBypm9UKydexOrHr89BJpMgaS7DTOjhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Uy9M2H8x; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9cf79b2a3cf411f0813e4fe1310efc19-20250530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=FWvi6FV2yTRRNHn1Lyg8KOEvBAvCbi10ARhlbgXCrEo=;
	b=Uy9M2H8xR5YbISt0/49cNMuDuvgOd5qn68yYXWXH2cRBMPyEYinI5MuVBG4/BFevoWW4APFY0M1C+bpkx7bbdscj+N1K4fjMbc0m/e8oMjAYSz6aqjwrBWGco1D6V3Bhlqi/0vcMeuW3nCqOccmaV3s+r7fZYamk48YEEJigthk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:da3d13a5-d6b0-44f8-8bb0-80ea183b5e5a,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:e2734459-eac4-4b21-88a4-d582445d304a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9cf79b2a3cf411f0813e4fe1310efc19-20250530
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1993078269; Fri, 30 May 2025 09:22:55 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 30 May 2025 09:22:53 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 30 May 2025 09:22:52 +0800
From: Shiming Cheng <shiming.cheng@mediatek.com>
To: <willemdebruijn.kernel@gmail.com>, <willemb@google.com>,
	<edumazet@google.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <matthias.bgg@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<shiming.cheng@mediatek.com>, <lena.wang@mediatek.com>
Subject: [PATCH net v6] net: fix udp gso skb_segment after pull from frag_list
Date: Fri, 30 May 2025 09:26:08 +0800
Message-ID: <20250530012622.7888-1-shiming.cheng@mediatek.com>
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

Commit a1e40ac5b5e9 ("net: gso: fix udp gso fraglist segmentation after
pull from frag_list") detected invalid geometry in frag_list skbs and
redirects them from skb_segment_list to more robust skb_segment. But some
packets with modified geometry can also hit bugs in that code. We don't
know how many such cases exist. Addressing each one by one also requires
touching the complex skb_segment code, which risks introducing bugs for
other types of skbs. Instead, linearize all these packets that fail the
basic invariants on gso fraglist skbs. That is more robust.

If only part of the fraglist payload is pulled into head_skb, it will
always cause exception when splitting skbs by skb_segment. For detailed
call stack information, see below.

Valid SKB_GSO_FRAGLIST skbs
- consist of two or more segments
- the head_skb holds the protocol headers plus first gso_size
- one or more frag_list skbs hold exactly one segment
- all but the last must be gso_size

Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
modify fraglist skbs, breaking these invariants.

In extreme cases they pull one part of data into skb linear. For UDP,
this  causes three payloads with lengths of (11,11,10) bytes were
pulled tail to become (12,10,10) bytes.

The skbs no longer meets the above SKB_GSO_FRAGLIST conditions because
payload was pulled into head_skb, it needs to be linearized before pass
to regular skb_segment.

    skb_segment+0xcd0/0xd14
    __udp_gso_segment+0x334/0x5f4
    udp4_ufo_fragment+0x118/0x15c
    inet_gso_segment+0x164/0x338
    skb_mac_gso_segment+0xc4/0x13c
    __skb_gso_segment+0xc4/0x124
    validate_xmit_skb+0x9c/0x2c0
    validate_xmit_skb_list+0x4c/0x80
    sch_direct_xmit+0x70/0x404
    __dev_queue_xmit+0x64c/0xe5c
    neigh_resolve_output+0x178/0x1c4
    ip_finish_output2+0x37c/0x47c
    __ip_finish_output+0x194/0x240
    ip_finish_output+0x20/0xf4
    ip_output+0x100/0x1a0
    NF_HOOK+0xc4/0x16c
    ip_forward+0x314/0x32c
    ip_rcv+0x90/0x118
    __netif_receive_skb+0x74/0x124
    process_backlog+0xe8/0x1a4
    __napi_poll+0x5c/0x1f8
    net_rx_action+0x154/0x314
    handle_softirqs+0x154/0x4b8

    [118.376811] [C201134] rxq0_pus: [name:bug&]kernel BUG at net/core/skbuff.c:4278!
    [118.376829] [C201134] rxq0_pus: [name:traps&]Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
    [118.470774] [C201134] rxq0_pus: [name:mrdump&]Kernel Offset: 0x178cc00000 from 0xffffffc008000000
    [118.470810] [C201134] rxq0_pus: [name:mrdump&]PHYS_OFFSET: 0x40000000
    [118.470827] [C201134] rxq0_pus: [name:mrdump&]pstate: 60400005 (nZCv daif +PAN -UAO)
    [118.470848] [C201134] rxq0_pus: [name:mrdump&]pc : [0xffffffd79598aefc] skb_segment+0xcd0/0xd14
    [118.470900] [C201134] rxq0_pus: [name:mrdump&]lr : [0xffffffd79598a5e8] skb_segment+0x3bc/0xd14
    [118.470928] [C201134] rxq0_pus: [name:mrdump&]sp : ffffffc008013770

Fixes: a1e40ac5b5e9 ("gso: fix udp gso fraglist segmentation after pull from frag_list")
Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
---
 net/ipv4/udp_offload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index a5be6e4ed326..59ddb85c858c 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -273,6 +273,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	bool copy_dtor;
 	__sum16 check;
 	__be16 newlen;
+	int ret = 0;
 
 	mss = skb_shinfo(gso_skb)->gso_size;
 	if (gso_skb->len <= sizeof(*uh) + mss)
@@ -301,6 +302,10 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
 			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
 
+		ret = __skb_linearize(gso_skb);
+		if (ret)
+			return ERR_PTR(ret);
+
 		 /* Setup csum, as fraglist skips this in udp4_gro_receive. */
 		gso_skb->csum_start = skb_transport_header(gso_skb) - gso_skb->head;
 		gso_skb->csum_offset = offsetof(struct udphdr, check);
-- 
2.45.2


