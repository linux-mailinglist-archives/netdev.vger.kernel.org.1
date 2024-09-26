Return-Path: <netdev+bounces-129893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB3A986E4B
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 09:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52E4282570
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 07:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8101D194AD1;
	Thu, 26 Sep 2024 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YNgoiFsI"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110A2192B79;
	Thu, 26 Sep 2024 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337318; cv=none; b=RkJsugLoC9lCh6p83gluQqMhUSZPJA3EHM8A01sTRG95tow2qPestc3niy3KXmoH65iMDoTj7OuAVcLOxO+FvOkABOF1LHI1g1QKd6bTThN66gwj7fbp1avY5HulACQvGLqrvnTWLwWQO68x+oTnxC6nuUSOyb80+ff+jq8GUmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337318; c=relaxed/simple;
	bh=14MN4WJFc40PK3xhiPHOoUBKfZx23EHVNRynp4GTYWM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rn4IZ/mS24WeRrrQom+vT6pFZCxOPWDTYe0/Y8/CZZvyAMVwDWg9lZSIrvwIe22edSh4bDghfraBWvGhcvEROD/bqL8wbOjUBlV5WTLbnZy1xJcsIh0ySlsPTBx4EZN0QpJ633GZ2qw10hJvVFo1AV51F7tPf5nqeeepX+J6HE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YNgoiFsI; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a40a76967bdc11efb66947d174671e26-20240926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=e1SvC+8nTrTTGDqea1bs7+UZiB4ykSG5Yh6a6VUwB0w=;
	b=YNgoiFsISDUPuyRj2XZAC/YlV1bIsLafV7Yb5bTENTzp134DN9QHQ5MCX4tvDPGm1Z1Hk17UJvqS3s73Ymyki7TmAhlIQ9n6PInOKPQyGaWc84Hb7FBwSt4MqKtIiHNaaxGTH+8w+x8w3Ki0YbViIUomHzeRA2ZaxhOgwL6gk3k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:cbcc196c-1c37-4f2c-86b5-cac16f286100,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:d027ccd0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a40a76967bdc11efb66947d174671e26-20240926
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1200892854; Thu, 26 Sep 2024 15:55:04 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Sep 2024 15:55:03 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Sep 2024 15:55:02 +0800
From: Lena Wang <lena.wang@mediatek.com>
To: <edumazet@google.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<pabeni@redhat.com>, <kuba@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Lena Wang
	<lena.wang@mediatek.com>
Subject: [PATCH net] tcp: check if skb is true to avoid crash
Date: Thu, 26 Sep 2024 15:56:38 +0800
Message-ID: <20240926075646.15592-1-lena.wang@mediatek.com>
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

A kernel NULL pointer dereference reported.
Backtrace:
vmlinux tcp_can_coalesce_send_queue_head(sk=0xFFFFFF80316D9400, len=755)
+ 28 </alps/OfficialRelease/Of/alps/kernel-6.6/net/ipv4/tcp_output.c:2315>
vmlinux  tcp_mtu_probe(sk=0xFFFFFF80316D9400) + 3196
</alps/OfficialRelease/Of/alps/kernel-6.6/net/ipv4/tcp_output.c:2452>
vmlinux  tcp_write_xmit(sk=0xFFFFFF80316D9400, mss_now=128,
nonagle=-2145862684, push_one=0, gfp=2080) + 3296
</alps/OfficialRelease/Of/alps/kernel-6.6/net/ipv4/tcp_output.c:2689>
vmlinux  tcp_tsq_write() + 172
</alps/OfficialRelease/Of/alps/kernel-6.6/net/ipv4/tcp_output.c:1033>
vmlinux  tcp_tsq_handler() + 104
</alps/OfficialRelease/Of/alps/kernel-6.6/net/ipv4/tcp_output.c:1042>
vmlinux  tcp_tasklet_func() + 208

When there is no pending skb in sk->sk_write_queue, tcp_send_head
returns NULL. Directly dereference of skb->len will result crash.
So it is necessary to evaluate the skb to be true here.

Fixes: 808cf9e38cd7 ("tcp: Honor the eor bit in tcp_mtu_probe")
Signed-off-by: Lena Wang <lena.wang@mediatek.com>
---
 net/ipv4/tcp_output.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 4fd746bd4d54..12cde5d879c5 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2338,17 +2338,19 @@ static bool tcp_can_coalesce_send_queue_head(struct sock *sk, int len)
 	struct sk_buff *skb, *next;
 
 	skb = tcp_send_head(sk);
-	tcp_for_write_queue_from_safe(skb, next, sk) {
-		if (len <= skb->len)
-			break;
+	if (skb) {
+		tcp_for_write_queue_from_safe(skb, next, sk) {
+			if (len <= skb->len)
+				break;
 
-		if (unlikely(TCP_SKB_CB(skb)->eor) ||
-		    tcp_has_tx_tstamp(skb) ||
-		    !skb_pure_zcopy_same(skb, next) ||
-		    skb_frags_readable(skb) != skb_frags_readable(next))
-			return false;
+			if (unlikely(TCP_SKB_CB(skb)->eor) ||
+			    tcp_has_tx_tstamp(skb) ||
+			    !skb_pure_zcopy_same(skb, next) ||
+			    skb_frags_readable(skb) != skb_frags_readable(next))
+				return false;
 
-		len -= skb->len;
+			len -= skb->len;
+		}
 	}
 
 	return true;
-- 
2.45.2


