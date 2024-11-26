Return-Path: <netdev+bounces-147441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D85A49D9840
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 14:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B44164796
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EE51D4354;
	Tue, 26 Nov 2024 13:20:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECC41D2B22
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732627200; cv=none; b=mdcV1H4y1xjYTTtd4n8bjF9t1P2Iy3yZxJPE6Y+iZwF9vWxuZyuixVuX96+hTrlTLwuh4EAX5hj92Do86f5CksrxW2JrQ34atCg4XZhnztvL6uuyx/8WY276wC4+7G+UqAf+beAaDHteRW2a0Er5AJIxQXFnOK2ZOXKEe0vc0t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732627200; c=relaxed/simple;
	bh=Bf+F3wkPUvI4YlFpmLDMpedy/e8itnPqS8SvRRUdhTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NWkuvS1miVO28uLTOR/fFwO0s36PPOIbBxiMjUIiNskgDROZcD4nCpGckJ6h365cTwN/ABOpY6LMLHjKNa/q7MDwBYBW71qFVUr4N6Anu+m6mM3qfUxrZy3TDRmVoTigpfNsUqlc6XHw+xg9G1NcbxsoeQF0CjEY9dXNJ8l7juU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelsoft.com; spf=pass smtp.mailfrom=kernelsoft.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelsoft.com
Received: from localhost.localdomain (unknown [183.69.133.42])
	by mail (Coremail) with SMTP id AQAAfwAno91NykVnw842Ag--.64100S2;
	Tue, 26 Nov 2024 21:17:02 +0800 (CST)
From: tianyu2 <tianyu2@kernelsoft.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org
Subject: [RFC] ipv4: remove useless arg
Date: Tue, 26 Nov 2024 21:19:12 +0800
Message-Id: <20241126131912.601391-1-tianyu2@kernelsoft.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAno91NykVnw842Ag--.64100S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4ktw1kKw13Cr1fJF1rtFb_yoW8Xw4xpF
	45Kan8ArykWr4UW34kKF97W34ayw1rG34ak3y8Aw13G34DJF4FgF1DKF4YyF1YkrWxKa13
	XFyagw13Gw1kCFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY
	62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7V
	CY1x0262k0Y48FwI0_Jr0_Gr1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW5GwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
	0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IUYeT5PUUUUU==
X-CM-SenderInfo: xwld05zxs6yvxuqhz2xriwhudrp/

When I wanted to kprobe the ip_rcv_finish_core, I found that using x1 to
pass "struct sk_buff *skb"."struct sock *sk" was not used in the
function, causing the compiler to optimize away. This resulted in a
hard to use kprobe. Why not delete him?

Signed-off-by: tianyu2 <tianyu2@kernelsoft.com>
---
 net/ipv4/ip_input.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index e7196ecffafc..2ff88c598988 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -314,7 +314,7 @@ static bool ip_can_use_hint(const struct sk_buff *skb, const struct iphdr *iph,
 
 int tcp_v4_early_demux(struct sk_buff *skb);
 int udp_v4_early_demux(struct sk_buff *skb);
-static int ip_rcv_finish_core(struct net *net, struct sock *sk,
+static int ip_rcv_finish_core(struct net *net,
 			      struct sk_buff *skb, struct net_device *dev,
 			      const struct sk_buff *hint)
 {
@@ -444,7 +444,7 @@ static int ip_rcv_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (!skb)
 		return NET_RX_SUCCESS;
 
-	ret = ip_rcv_finish_core(net, sk, skb, dev, NULL);
+	ret = ip_rcv_finish_core(net, skb, dev, NULL);
 	if (ret != NET_RX_DROP)
 		ret = dst_input(skb);
 	return ret;
@@ -610,7 +610,7 @@ static void ip_list_rcv_finish(struct net *net, struct sock *sk,
 		skb = l3mdev_ip_rcv(skb);
 		if (!skb)
 			continue;
-		if (ip_rcv_finish_core(net, sk, skb, dev, hint) == NET_RX_DROP)
+		if (ip_rcv_finish_core(net, skb, dev, hint) == NET_RX_DROP)
 			continue;
 
 		dst = skb_dst(skb);
-- 
2.27.0


