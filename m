Return-Path: <netdev+bounces-192512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B966FAC02BE
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 05:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3ED93A826A
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 03:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39AEEAD0;
	Thu, 22 May 2025 03:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CQHulVJP"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72093D76;
	Thu, 22 May 2025 03:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747883728; cv=none; b=tgPU5salpPBDE5o6l1dtDF+8mVq8NUWVMRQAhgq21OC85n3GCZGGFNhUIix22s+cYo7j17/uqhRoHn1bEa500gItX6u8mh4GMh9b6wO3Xd0TXJTzuewtB6M9pshvmVHDLKzrjjPtBg7mKNV/79Wcv7TKiC+P2X4sR1nElc1dsN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747883728; c=relaxed/simple;
	bh=VWhU4UvwDPru1UAF1FLx0jFIrFuFJ7TtaN5kZ8Ua9ik=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jb02eb5Xw0rDNP1yxwZdxIZgVjlS8K7lOXA/DF61SoHsmGejTO5dc8MNzyBnMLFbAoUEBLNQpSKGYb9JmpdJuHpTVtJY+9ZmOJwogu+XBxcGU0bgh5xrBQLFWdm5oZSWYFENDcgWOHR49IY3FLZuwyR25+TRKCzWkOF0wESf4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CQHulVJP; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fdb8020036ba11f0813e4fe1310efc19-20250522
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nG5yz4J8MR9NBO/9HQzZdDGATueiG2cUtXQFwsyHdA8=;
	b=CQHulVJP5nQ6WPXhKZCuRNTID4wXDm1HULsE1PQOdZrxGCcOLM9lEQ5XYNi1HF6DvL8FOUcrsm397aAILs7xxP9JdIgm1iGD51oP7nsdGRdzyHI49EdFo6rK9sxwUoWXTZX3oe+c48ICJZQQtuaslQ4QB1u8FMsWEc8rTpe9XAM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:20519bf7-a9b6-4c0b-a303-c9279130fb43,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:5ca5fa58-eac4-4b21-88a4-d582445d304a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fdb8020036ba11f0813e4fe1310efc19-20250522
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 113848368; Thu, 22 May 2025 11:15:19 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 22 May 2025 11:15:18 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 22 May 2025 11:15:17 +0800
From: Shiming Cheng <shiming.cheng@mediatek.com>
To: <willemdebruijin.kernel@gmail.com>, <edumazet@google.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<matthias.bgg@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<shiming.cheng@mediatek.com>, <lena.wang@mediatek.com>
Subject: [PATCH] net: fix udp gso skb_segment after pull from frag_list
Date: Thu, 22 May 2025 11:18:04 +0800
Message-ID: <20250522031835.4395-1-shiming.cheng@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK: N

    Detect invalid geometry due to pull from frag_list, and pass to
    regular skb_segment. if only part of the fraglist payload is pulled
    into head_skb, When splitting packets in the skb_segment function,
    it will always cause exception as below.

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

    When splitting packets in the skb_segment function, the first two
    packets of (11,11) bytes are split using skb_copy_bits. But when
    the last packet of 10 bytes is split, because hsize becomes nagative,
    it enters the skb_clone process instead of continuing to use
    skb_copy_bits. In fact, the data for skb_clone has already been
    copied into the second packet.

    when hsize < 0,  the payload of the fraglist has already been copied
    (with skb_copy_bits), so there is no need to enter skb_clone to
    process this packet. Instead, continue using skb_copy_bits to process
    the next packet.

    el1h_64_sync_handler+0x3c/0x90
    el1h_64_sync+0x68/0x6c
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
    __do_softirq+0x14/0x20

    [  118.376811] [C201134] dpmaif_rxq0_pus: [name:bug&]kernel BUG at net/core/skbuff.c:4278!
    [  118.376829] [C201134] dpmaif_rxq0_pus: [name:traps&]Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
    [  118.376858] [C201134] dpmaif_rxq0_pus: [name:mediatek_cpufreq_hw&]cpufreq stop DVFS log done
    [  118.470774] [C201134] dpmaif_rxq0_pus: [name:mrdump&]Kernel Offset: 0x178cc00000 from 0xffffffc008000000
    [  118.470810] [C201134] dpmaif_rxq0_pus: [name:mrdump&]PHYS_OFFSET: 0x40000000
    [  118.470827] [C201134] dpmaif_rxq0_pus: [name:mrdump&]pstate: 60400005 (nZCv daif +PAN -UAO)
    [  118.470848] [C201134] dpmaif_rxq0_pus: [name:mrdump&]pc : [0xffffffd79598aefc] skb_segment+0xcd0/0xd14
    [  118.470900] [C201134] dpmaif_rxq0_pus: [name:mrdump&]lr : [0xffffffd79598a5e8] skb_segment+0x3bc/0xd14
    [  118.470928] [C201134] dpmaif_rxq0_pus: [name:mrdump&]sp : ffffffc008013770
    [  118.470941] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x29: ffffffc008013810 x28: 0000000000000040
    [  118.470961] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x27: 000000000000002a x26: faffff81338f5500
    [  118.470976] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x25: f9ffff800c87e000 x24: 0000000000000000
    [  118.470991] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x23: 000000000000004b x22: f4ffff81338f4c00
    [  118.471005] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x21: 000000000000000b x20: 0000000000000000
    [  118.471019] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x19: fdffff8077db5dc8 x18: 0000000000000000
    [  118.471033] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x17: 00000000ad6b63b6 x16: 00000000ad6b63b6
    [  118.471047] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x15: ffffffd795aa59d4 x14: ffffffd795aa7bc4
    [  118.471061] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x13: f4ffff806d40bc00 x12: 0000000100000000
    [  118.471075] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x11: 0054000800000000 x10: 0000000000000040
    [  118.471089] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x9 : 0000000000000040 x8 : 0000000000000055
    [  118.471104] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x7 : ffffffd7959b0868 x6 : ffffffd7959aeebc
    [  118.471118] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x5 : f8ffff8132ac5720 x4 : ffffffc0080134a8
    [  118.471131] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x3 : 0000000000000a20 x2 : 0000000000000001
    [  118.471145] [C201134] dpmaif_rxq0_pus: [name:mrdump&]x1 : 000000000000000a x0 : faffff81338f5500

    BUG_ON：
         pos += skb_headlen(list_skb);
         while (pos < offset + len) {
            BUG_ON(i >= nfrags);
            size = skb_frag_size(frag);

Fixes: dbd50f238dec ("net: move the hsize check to the else block in skb_segment")
Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6841e61a6bd0..f9888f8dc3fa 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4808,7 +4808,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 		hsize = skb_headlen(head_skb) - offset;
 
-		if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
+		if (hsize == 0 && i >= nfrags && skb_headlen(list_skb) &&
 		    (skb_headlen(list_skb) == len || sg)) {
 			BUG_ON(skb_headlen(list_skb) > len);
 
-- 
2.45.2


