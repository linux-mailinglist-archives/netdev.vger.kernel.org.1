Return-Path: <netdev+bounces-185882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66599A9BFB8
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 565237A9DE6
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 07:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864F822D78E;
	Fri, 25 Apr 2025 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SevJ/7Vu"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E79D10FD;
	Fri, 25 Apr 2025 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566137; cv=none; b=OwnJi1haBNPB+KuQmdlGPux96dppWk4PQQAAgr1atdNfoYrPQbCi1LjSDvWFhqdjne8kBrO7RPe98t18RmBdImQthByJdT0DZo1oqrWWjy4thADSyUq8VYNWjtViyaYJCyVnecfzH1KYJJ1jKmR0etV0KGGRn7e0QYW1UGI/oDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566137; c=relaxed/simple;
	bh=OffDbqTBVes6nVtKvc2+GvuunHqk86fjhIel2nXw05w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HNFGB/KAMedPuDGI5wjHrRHAmlWOPvGsnDRn6KA/eUQMfkteoNRKaGytmGgkYNgRSphw/0X4TySWsSP2Kb3MUTFpEE5dKgQxlR7vgx3gYyTLKL7zG0l1C05pACmImNb6ov6lSm44j3GZ7MY4Y3Zpxe/qn9Zli9OeGc/43GWgp0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SevJ/7Vu; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e8cba82021a611f09b6713c7f6bde12e-20250425
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=JYqespCzipBArbkbxwYqmmhBdhSBu5Sof0tluCzWjzo=;
	b=SevJ/7VuOaCdLQhWKJDTlAsQ25Lq34Kp9PokzmhNpcW7MFfLs96ybN+UhzvvZLWCXcShBNh6gXu0wIn+EH/Do9/f250FIdRkJGuQ7XTURxFIzxfdDxndy/MtdXy01W7od7p7d4sFFtuFRijypwYln9g9lRX4LIZJjjkfqHYH7Tg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:bd336e9d-80d5-4a59-a328-206cda895afe,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:502c0907-829c-41bc-b3dd-83387f72f90e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e8cba82021a611f09b6713c7f6bde12e-20250425
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1674504371; Fri, 25 Apr 2025 15:28:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 25 Apr 2025 15:28:39 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 25 Apr 2025 15:28:38 +0800
From: Shiming Cheng <shiming.cheng@mediatek.com>
To: <edumazet@google.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
CC: Jibin Zhang <jibin.zhang@mediatek.com>
Subject: [PATCH] net: call inet_twsk_put() on TIMEWAIT sockets It is possible for a pointer of type struct inet_timewait_sock to be returned from the functions __inet_lookup_established() and __inet6_lookup_established(). This can cause a crash when the returned pointer is of type struct inet_timewait_sock and sock_put() is called on it. The following is a crash call stack that shows sk->sk_wmem_alloc being accessed in sk_free() during the call to sock_put() on a struct inet_timewait_sock pointer. To avoid this issue, use inet_twsk_put() instead of sock_put() when sk->sk_state is TCP_TIME_WAIT.
Date: Fri, 25 Apr 2025 15:31:13 +0800
Message-ID: <20250425073120.28195-1-shiming.cheng@mediatek.com>
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

Signed-off-by: Jibin Zhang <jibin.zhang@mediatek.com>
---
 net/ipv4/tcp_offload.c   | 8 ++++++--
 net/ipv6/tcpv6_offload.c | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 2308665b51c5..95d7cbf6a2b5 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -431,8 +431,12 @@ static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
 				       iph->daddr, ntohs(th->dest),
 				       iif, sdif);
 	NAPI_GRO_CB(skb)->is_flist = !sk;
-	if (sk)
-		sock_put(sk);
+	if (sk) {
+		if (sk->sk_state == TCP_TIME_WAIT)
+			inet_twsk_put(inet_twsk(sk));
+		else
+			sock_put(sk);
+	}
 }
 
 INDIRECT_CALLABLE_SCOPE
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index a45bf17cb2a1..5fcfa45b6f46 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -41,8 +41,12 @@ static void tcp6_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
 					&hdr->daddr, ntohs(th->dest),
 					iif, sdif);
 	NAPI_GRO_CB(skb)->is_flist = !sk;
-	if (sk)
-		sock_put(sk);
+	if (sk) {
+		if (sk->sk_state == TCP_TIME_WAIT)
+			inet_twsk_put(inet_twsk(sk));
+		else
+			sock_put(sk);
+	}
 #endif /* IS_ENABLED(CONFIG_IPV6) */
 }
 
-- 
2.46.0


