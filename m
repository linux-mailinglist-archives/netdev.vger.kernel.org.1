Return-Path: <netdev+bounces-247277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A34CF6675
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 03:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83C55301FF94
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 02:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E96C21FF47;
	Tue,  6 Jan 2026 02:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oW3XSoEO"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA28155C97;
	Tue,  6 Jan 2026 02:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767664945; cv=none; b=nSAV5gebvrfK4kTAnGDHeIuk52upl6e5BGll7XYJIdD32n4hQIenGCg42G5X+Zw8tl3GbJYv2IsE90iFYM8oTCMhUC81kqF4bECRtRocawxx6Nk3o97PilwLFlP8bn1l9K9nhRyl3nzfL1MvXNThI4/TyHXL3rIKGi3KfWejn1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767664945; c=relaxed/simple;
	bh=sC8THeOWYJ2BcxnAKBPtBAQ3vpRao174cklxG6HR3Xk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hdYzh1J2O3CP2lKp92IAsSyC+cT1q/4NFzxWmH1fhK7qs4wO7vCuVX+dm0pH8PdkK2KDI2+5bRwyvqr0oM/3eYvgHr9k2cyEGAskrjFzE4q58B1iHWVM279C3pTtVtU4k8TmJX9YN2QAjTMDnIC3FCP6HyrOHLyifWHwkzDkFZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oW3XSoEO; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b948187eeaa311f08a742f2735aaa5e5-20260106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ozFm2cUi7R2uaTVnYXyGlphaCfb41GyYxTe1x77jtUY=;
	b=oW3XSoEOX3MPQO7pg4ANHGDb/VOEAmR0axX5c/Pq6ze+haYzHupx/5umgR2vwtSQWVXjZgfkosLt8BxYFU6hgzpM9V6bO2UG+pYfRX0dTkigogKLex8d2MKXbnf9xW9pIUTS3hsbDhFCh7gTLQK8FfDtCr4fd25wVny0C2uTSU4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.9,REQID:222f18f4-018c-49be-afd1-8c99c4201ba2,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:5047765,CLOUDID:4c02201c-569f-4a0f-9948-b21a1d8a5571,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b948187eeaa311f08a742f2735aaa5e5-20260106
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 756133105; Tue, 06 Jan 2026 10:02:15 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 6 Jan 2026 10:02:14 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 6 Jan 2026 10:02:13 +0800
From: Shiming Cheng <shiming.cheng@mediatek.com>
To: <willemdebruijn.kernel@gmail.com>, <willemb@google.com>,
	<edumazet@google.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <matthias.bgg@gmail.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <Lena.Wang@mediatek.com>, Shiming Cheng <shiming.cheng@mediatek.com>
Subject: [PATCH] net: fix udp gso skb_segment after pull from frag_list
Date: Tue, 6 Jan 2026 10:02:03 +0800
Message-ID: <20260106020208.7520-1-shiming.cheng@mediatek.com>
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

Commit 3382a1ed7f77 ("net: fix udp gso skb_segment after  pull from
frag_list")
if gso_type is not SKB_GSO_FRAGLIST but skb->head_frag is zero,
then detected invalid geometry in frag_list skbs and call
skb_segment. But some packets with modified geometry can also hit
bugs in that code. Instead, linearize all these packets that fail
the basic invariants on gso fraglist skbs. That is more robust.
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
  [118.376829] [C201134] rxq0_pus: [name:traps&]Internal error: Oops - BUG: 00000000f2000800 [#1]
  [118.470774] [C201134] rxq0_pus: [name:mrdump&]Kernel Offset: 0x178cc00000 from 0xffffffc008000000
  [118.470810] [C201134] rxq0_pus: [name:mrdump&]PHYS_OFFSET: 0x40000000
  [118.470827] [C201134] rxq0_pus: [name:mrdump&]pstate: 60400005 (nZCv daif +PAN -UAO)
  [118.470848] [C201134] rxq0_pus: [name:mrdump&]pc : [0xffffffd79598aefc] skb_segment+0xcd0/0xd14
  [118.470900] [C201134] rxq0_pus: [name:mrdump&]lr : [0xffffffd79598a5e8] skb_segment+0x3bc/0xd14
  [118.470928] [C201134] rxq0_pus: [name:mrdump&]sp : ffffffc008013770

Fixes: 3382a1ed7f77 ("net: fix udp gso skb_segment after pull from frag_list")
Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
---
 net/ipv4/udp_offload.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 19d0b5b09ffa..606d9ce8c98e 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -535,6 +535,12 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 			uh->check = ~udp_v4_check(gso_skb->len,
 						  ip_hdr(gso_skb)->saddr,
 						  ip_hdr(gso_skb)->daddr, 0);
+	} else if (skb_shinfo(gso_skb)->frag_list && gso_skb->head_frag == 0) {
+		if (skb_pagelen(gso_skb) - sizeof(*uh) != skb_shinfo(gso_skb)->gso_size) {
+			ret = __skb_linearize(gso_skb);
+			if (ret)
+				return ERR_PTR(ret);
+		}
 	}
 
 	skb_pull(gso_skb, sizeof(*uh));
-- 
2.45.2


