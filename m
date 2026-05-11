Return-Path: <netdev+bounces-286654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKtNIHTdAWptlgEAu9opvQ
	(envelope-from <netdev+bounces-286654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:45:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0293750F3CE
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B21E63006F30
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60423EC2E9;
	Mon, 11 May 2026 13:41:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F7B2F8EB7
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506901; cv=none; b=j0T3+H8O+gSaoRxyFIVcPOTZhgE1nbe9Dkv+0fkxgBJFUUCiwQW/Ol9Wh/Kr6cpgcmOKLCj9oSAFCssv0XD7lggCvfeKHsXyOHzw7Uh+A1ueSEUBdKMSllSU5G+3QZPgdfqSZniJrPmjIZWCEI/ulXJ4W5RuHdCXUc2sPDG5vXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506901; c=relaxed/simple;
	bh=TeGbMd6UvwcPKF5foNAf2iQ0GRMCFiZCOWwYAUhfoBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnPEpY2p4t1FKKVwZwjqTwCtLh7+/hQT9cP2T8E4OzuK0O3BeFT2bKOdIK3ADuIclLKPFs+e2UGJuABlXHIQSh4sZO64qvISlfEv5NqEx+64T+hdTTUrQ1/YqgBzn+7wgvKm9voGx3H4kijIzQCfYqb/pFwdNBz1IrXm2elS3to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowABXz_9w3AFqGPYDAQ--.4427S3;
	Mon, 11 May 2026 21:41:07 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	sd@queasysnail.net,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	ronbogo@outlook.com,
	zylzyl2333@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] xfrm: espintcp: publish ULP context before entry points
Date: Mon, 11 May 2026 21:40:58 +0800
Message-ID: <c30b645074a1b379e0f7fe297f917c66137d9964.1778464688.git.zylzyl2333@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1778464688.git.zylzyl2333@gmail.com>
References: <cover.1778464688.git.zylzyl2333@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowABXz_9w3AFqGPYDAQ--.4427S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww4xJr4Duw4rGw1kJw1kXwb_yoW7Cw4DpF
	Z8ua43J3yqqrW3CFn2yrWqqr13G3WkZFyUK347XFy2vr1qgr15AF4qyFy2vFn7Cayvk3W5
	JwsFq3WYvr1xXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQEECWoBl+UHBwAAsU
X-Rspamd-Queue-Id: 0293750F3CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-286654-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,secunet.com,gondor.apana.org.au,queasysnail.net,gmail.com,lzu.edu.cn,outlook.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.852];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,lzu.edu.cn:email]
X-Rspamd-Action: no action

From: Yilin Zhu <zylzyl2333@gmail.com>

espintcp_init_sk() installs sk_prot, sk_socket->ops, and socket callbacks
while setting up the ULP state. These entry points can be observed by
receive and write-space paths before the attaching thread finishes.

Previously, espintcp_data_ready() could dereference icsk_ulp_data before
the new context was published, and espintcp_write_space() could schedule
ctx->work before INIT_WORK() initialized it.

Initialize the queues, saved callbacks, and TX work item before storing
the context in icsk_ulp_data.  Then publish sk_prot, sk_socket->ops, and
the socket callbacks only after smp_wmb(), paired with an ordered context
load in espintcp_getctx().  Use READ_ONCE()/WRITE_ONCE() for lockless
socket pointer accesses.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Co-developed-by: Peihan Liu <ronbogo@outlook.com>
Signed-off-by: Peihan Liu <ronbogo@outlook.com>
Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 include/net/espintcp.h | 13 +++++++++--
 net/xfrm/espintcp.c    | 52 +++++++++++++++++++++++++++---------------
 2 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/include/net/espintcp.h b/include/net/espintcp.h
index c70efd704b6d..034be559786b 100644
--- a/include/net/espintcp.h
+++ b/include/net/espintcp.h
@@ -34,7 +34,16 @@ static inline struct espintcp_ctx *espintcp_getctx(const struct sock *sk)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
 
-	/* RCU is only needed for diag */
-	return (__force void *)icsk->icsk_ulp_data;
+	/*
+	 * The caller reached an ESP entry point by observing sk_prot,
+	 * sk_socket->ops, or one of the socket callbacks.  Keep the ctx
+	 * load after that observation so the caller cannot see the new
+	 * entry point while still seeing stale icsk_ulp_data.
+	 *
+	 * Pairs with smp_wmb() in espintcp_init_sk().
+	 */
+	smp_rmb();
+
+	return (__force void *)READ_ONCE(icsk->icsk_ulp_data);
 }
 #endif
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index a2756186e13a..d847632e7d4e 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -440,7 +440,9 @@ static void espintcp_destruct(struct sock *sk)
 
 bool tcp_is_ulp_esp(struct sock *sk)
 {
-	return sk->sk_prot == &espintcp_prot || sk->sk_prot == &espintcp6_prot;
+	const struct proto *prot = READ_ONCE(sk->sk_prot);
+
+	return prot == &espintcp_prot || prot == &espintcp6_prot;
 }
 EXPORT_SYMBOL_GPL(tcp_is_ulp_esp);
 
@@ -451,10 +453,12 @@ static void build_protos(struct proto *espintcp_prot,
 static int espintcp_init_sk(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
+	const struct proto_ops *ops;
 	struct strp_callbacks cb = {
 		.rcv_msg = espintcp_rcv,
 		.parse_msg = espintcp_parse,
 	};
 	struct espintcp_ctx *ctx;
+	struct proto *prot;
 	int err;
 
@@ -472,34 +476,46 @@ static int espintcp_init_sk(struct sock *sk)
 
 	__sk_dst_reset(sk);
 
-	strp_check_rcv(&ctx->strp);
 	skb_queue_head_init(&ctx->ike_queue);
 	skb_queue_head_init(&ctx->out_queue);
+	ctx->saved_data_ready = READ_ONCE(sk->sk_data_ready);
+	ctx->saved_write_space = READ_ONCE(sk->sk_write_space);
+	ctx->saved_destruct = READ_ONCE(sk->sk_destruct);
+	INIT_WORK(&ctx->work, espintcp_tx_work);
+
+	/* avoid using task_frag */
+	sk->sk_allocation = GFP_ATOMIC;
+	sk->sk_use_task_frag = false;
 
 	if (sk->sk_family == AF_INET) {
-		sk->sk_prot = &espintcp_prot;
-		sk->sk_socket->ops = &espintcp_ops;
+		prot = &espintcp_prot;
+		ops = &espintcp_ops;
 	} else {
 		mutex_lock(&tcpv6_prot_mutex);
 		if (!espintcp6_prot.recvmsg)
-			build_protos(&espintcp6_prot, &espintcp6_ops, sk->sk_prot, sk->sk_socket->ops);
+			build_protos(&espintcp6_prot, &espintcp6_ops,
+				     READ_ONCE(sk->sk_prot),
+				     READ_ONCE(sk->sk_socket->ops));
 		mutex_unlock(&tcpv6_prot_mutex);
 
-		sk->sk_prot = &espintcp6_prot;
-		sk->sk_socket->ops = &espintcp6_ops;
+		prot = &espintcp6_prot;
+		ops = &espintcp6_ops;
 	}
-	ctx->saved_data_ready = sk->sk_data_ready;
-	ctx->saved_write_space = sk->sk_write_space;
-	ctx->saved_destruct = sk->sk_destruct;
-	sk->sk_data_ready = espintcp_data_ready;
-	sk->sk_write_space = espintcp_write_space;
-	sk->sk_destruct = espintcp_destruct;
 	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
-	INIT_WORK(&ctx->work, espintcp_tx_work);
 
-	/* avoid using task_frag */
-	sk->sk_allocation = GFP_ATOMIC;
-	sk->sk_use_task_frag = false;
+	/*
+	 * Publish the fully initialized ctx before publishing any entry point
+	 * that can call espintcp_getctx().  The read barrier there runs after
+	 * the caller has observed one of these pointers.
+	 */
+	smp_wmb();
+	WRITE_ONCE(sk->sk_prot, prot);
+	WRITE_ONCE(sk->sk_socket->ops, ops);
+	WRITE_ONCE(sk->sk_data_ready, espintcp_data_ready);
+	WRITE_ONCE(sk->sk_write_space, espintcp_write_space);
+	WRITE_ONCE(sk->sk_destruct, espintcp_destruct);
+
+	strp_check_rcv(&ctx->strp);
 
 	return 0;
 
@@ -530,7 +546,7 @@ static void espintcp_close(struct sock *sk, long timeout)
 
 	strp_stop(&ctx->strp);
 
-	sk->sk_prot = &tcp_prot;
+	WRITE_ONCE(sk->sk_prot, &tcp_prot);
 	barrier();
 
 	disable_work_sync(&ctx->work);
-- 
2.47.3


