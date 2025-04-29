Return-Path: <netdev+bounces-186630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C3DA9FF54
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 04:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2243AC579
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 02:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EE0214A90;
	Tue, 29 Apr 2025 02:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="doq19GrQ"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C20214A73;
	Tue, 29 Apr 2025 02:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745892103; cv=none; b=Dolu5/wHgynUsgvV2q3WgcrZGMHzeYCfGVQ6EGkdUhcoH3xVTDYex1qTAiBRuroxboTapcLlIkb4D+p8cSfQSfpuiiMB2n42Cq/FdzsorK4KGvt+qjgyME58O2D1i4PjNuEV3JTEyGYrQb+C18XdX2tFQ6/LE06d7aNvGTJCtbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745892103; c=relaxed/simple;
	bh=zKwVa4Gxl+T60ClLmm/1G5pm0OWgEypuwGYSDNLjjt0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FiWKUI4juZ7/T+80LpB5X3TmiFJoUjTioO5fGmkd5fwCfDlJ7wNZXr/VnscUCCG0tbQnUKxKQ7I/pEv45ULgELwkhyB4NcpYYVL9bYpYOqYCQs3UtxrEePZGcfNY4LknH9ppGhHLg+azD4pyC9rYpCKEpxBf1zjkWjbPJ/2hEeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=doq19GrQ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dc761840249d11f09b6713c7f6bde12e-20250429
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=tuj9BGUeMzegQ0lV1ZfFdTK//nspAIt+974jv6fTnJA=;
	b=doq19GrQproFjoinsb2/rxU5UbsDXd5+nk4ketEZuCd7cAiuNYxot4tDs1ANElXTgzlE+o5G4L7Fi7l6Iv+tcOiVPRsBqTB7QLQDfWjVSiUhhORd4+PwA9aulMlJZB5PHbUCECfaNcRYfvCFUtQeNM0pq+eeJK0rflGmxQHlslY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:8bb4811a-d7cb-4fd6-88d9-d07dec403c52,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:0220fa6f-e08c-41ab-89e8-3ba0a33da853,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: dc761840249d11f09b6713c7f6bde12e-20250429
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1754018810; Tue, 29 Apr 2025 10:01:27 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 29 Apr 2025 10:01:26 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 29 Apr 2025 10:01:25 +0800
From: Shiming Cheng <shiming.cheng@mediatek.com>
To: <edumazet@google.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
CC: <shiming.cheng@mediatek.com>, <lena.wang@mediatek.com>, Jibin Zhang
	<jibin.zhang@mediatek.com>
Subject: [PATCH v3] net: use sock_gen_put() when sk_state is TCP_TIME_WAIT
Date: Tue, 29 Apr 2025 09:59:48 +0800
Message-ID: <20250429020412.14163-1-shiming.cheng@mediatek.com>
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

From: Jibin Zhang <jibin.zhang@mediatek.com>

It is possible for a pointer of type struct inet_timewait_sock to be
returned from the functions __inet_lookup_established() and
__inet6_lookup_established(). This can cause a crash when the
returned pointer is of type struct inet_timewait_sock and
sock_put() is called on it. The following is a crash call stack that
shows sk->sk_wmem_alloc being accessed in sk_free() during the call to
sock_put() on a struct inet_timewait_sock pointer. To avoid this issue,
use sock_gen_put() instead of sock_put() when sk->sk_state
is TCP_TIME_WAIT.

mrdump.ko        ipanic() + 120
vmlinux          notifier_call_chain(nr_to_call=-1, nr_calls=0) + 132
vmlinux          atomic_notifier_call_chain(val=0) + 56
vmlinux          panic() + 344
vmlinux          add_taint() + 164
vmlinux          end_report() + 136
vmlinux          kasan_report(size=0) + 236
vmlinux          report_tag_fault() + 16
vmlinux          do_tag_recovery() + 16
vmlinux          __do_kernel_fault() + 88
vmlinux          do_bad_area() + 28
vmlinux          do_tag_check_fault() + 60
vmlinux          do_mem_abort() + 80
vmlinux          el1_abort() + 56
vmlinux          el1h_64_sync_handler() + 124
vmlinux        > 0xFFFFFFC080011294()
vmlinux          __lse_atomic_fetch_add_release(v=0xF2FFFF82A896087C)
vmlinux          __lse_atomic_fetch_sub_release(v=0xF2FFFF82A896087C)
vmlinux          arch_atomic_fetch_sub_release(i=1, v=0xF2FFFF82A896087C)
+ 8
vmlinux          raw_atomic_fetch_sub_release(i=1, v=0xF2FFFF82A896087C)
+ 8
vmlinux          atomic_fetch_sub_release(i=1, v=0xF2FFFF82A896087C) + 8
vmlinux          __refcount_sub_and_test(i=1, r=0xF2FFFF82A896087C,
oldp=0) + 8
vmlinux          __refcount_dec_and_test(r=0xF2FFFF82A896087C, oldp=0) + 8
vmlinux          refcount_dec_and_test(r=0xF2FFFF82A896087C) + 8
vmlinux          sk_free(sk=0xF2FFFF82A8960700) + 28
vmlinux          sock_put() + 48
vmlinux          tcp6_check_fraglist_gro() + 236
vmlinux          tcp6_gro_receive() + 624
vmlinux          ipv6_gro_receive() + 912
vmlinux          dev_gro_receive() + 1116
vmlinux          napi_gro_receive() + 196
ccmni.ko         ccmni_rx_callback() + 208
ccmni.ko         ccmni_queue_recv_skb() + 388
ccci_dpmaif.ko   dpmaif_rxq_push_thread() + 1088
vmlinux          kthread() + 268
vmlinux          0xFFFFFFC08001F30C()

Fixes: c9d1d23e5239 ("net: add heuristic for enabling TCP fraglist GRO")
Signed-off-by: Jibin Zhang <jibin.zhang@mediatek.com>
Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
---
 net/ipv4/tcp_offload.c   | 2 +-
 net/ipv6/tcpv6_offload.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 2308665b51c5..f55026b597ff 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -432,7 +432,7 @@ static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
 				       iif, sdif);
 	NAPI_GRO_CB(skb)->is_flist = !sk;
 	if (sk)
-		sock_put(sk);
+		sock_gen_put(sk);
 }
 
 INDIRECT_CALLABLE_SCOPE
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index a45bf17cb2a1..b1f284e0c15a 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -42,7 +42,7 @@ static void tcp6_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
 					iif, sdif);
 	NAPI_GRO_CB(skb)->is_flist = !sk;
 	if (sk)
-		sock_put(sk);
+		sock_gen_put(sk);
 #endif /* IS_ENABLED(CONFIG_IPV6) */
 }
 
-- 
2.45.2


