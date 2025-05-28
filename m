Return-Path: <netdev+bounces-193865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3264AC6156
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 07:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AFC81BC284B
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 05:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60432063E7;
	Wed, 28 May 2025 05:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OKpEdFge"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652D120296A;
	Wed, 28 May 2025 05:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748411037; cv=none; b=FIQxD60nx8L+4fZDJ5nCcA+kjVHgng25tOwssPrcSL+L984b+iH6GSWECbjUqdyzkgkp9As+bel8VUMqBuVEed52ETBGmdeeaiJaYaTKBfPxOnpIu/ngQp6kaG9o5lChuwO+kEqAFJ1B77QUqdvd9h3DMSO+R5VV4Ao7QWDb8OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748411037; c=relaxed/simple;
	bh=BjhYdU8zIsDfSu5tKkeASlKHUT4Q53Q1G1X0YfnzDh4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B121WhTJr0KYNrlGUAJqtf/DbI3MDHFXtUgntQbwbExAGbVfAzKN1/X2deZ6wjsQ2TFbkcPEAuMdICKcTc6R5knoYz5YwmNrgx2/NKUdzap8nfP+RgNjjqSegK7jQpX7c7abLRtowT1DcK9CVXcfedf7zNW4etCXV3VX7sWAplc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OKpEdFge; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bba0d6aa3b8611f0813e4fe1310efc19-20250528
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qDqcO+1lT1CdVZbL9zzydevEmoh/kdOll60G7116BHU=;
	b=OKpEdFger6mJk8dF4y/beTkkfUsGwlANtMvuk2DQqxKY8DXonmpBhLrGoTmNnJZu3SmnVstFNx5HpSOwkcbqAjoetwUdID8HlzNPLNOlVttp+BU0SBuZMYxv43PKnLXbRCBq4+B3gVbg9cSUGRUeg9Mzz0MzZHxKz+EVzrbMFzU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:2052d81e-d4d7-4f7b-a52d-50c428ed460b,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:86be3159-eac4-4b21-88a4-d582445d304a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bba0d6aa3b8611f0813e4fe1310efc19-20250528
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 744441040; Wed, 28 May 2025 13:43:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 28 May 2025 13:43:49 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 28 May 2025 13:43:48 +0800
From: Shiming Cheng <shiming.cheng@mediatek.com>
To: <willemdebruijn.kernel@gmail.com>, <willemb@google.com>,
	<edumazet@google.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <matthias.bgg@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<shiming.cheng@mediatek.com>, <lena.wang@mediatek.com>
Subject: [PATCH net v4] net: fix udp gso skb_segment after pull from frag_list
Date: Wed, 28 May 2025 13:46:28 +0800
Message-ID: <20250528054715.32063-1-shiming.cheng@mediatek.com>
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

Detect invalid geometry due to pull from frag_list, and pass to
regular skb_segment. If only part of the fraglist payload is pulled
into head_skb, it will always cause exception when splitting
skbs by skb_segment. For detailed call stack information, see below.

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

Fixes: a1e40ac5b5e9 ("net: gso: fix udp gso fraglist segmentation after pull from frag_list")
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


