Return-Path: <netdev+bounces-306825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hAdAINcfUmoYMQMAu9opvQ
	(envelope-from <netdev+bounces-306825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:49:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4C57414FC
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:49:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DKmrFnAz;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306825-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306825-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52AF0301ABB0
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601D43AD51F;
	Sat, 11 Jul 2026 10:49:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129B3BCD1E
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:49:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766963; cv=none; b=d0sE1OBh9LiBr99+T9o0/1pVv+Y+xAJ4Zr5A5vqNtcDQku5e5cK9RQWz/tSGtWCK8rI1W0lwcoE0ZUxjNb75jUfiuNQeELmL8PP2IwX9vNWw66N1lThnA+p/SBFV22Jndstw7JcQ3xwsfiCAj5YZXfiIO5zuWyc0joPnCAcwq9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766963; c=relaxed/simple;
	bh=pZfKjc6KzCpgg2NGA/vRzrfRTtPD6PV5ZEhO/+7IKIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5yP1R4y/3VzNjGMOyzsbv2uxRQM1r2+GgUO5jiLAcr1+EpphyRBwrtJ4nizkwF6LjcdDSgknCcGnsuZDUMSGOfOKBzuRzkPbZns6993KR1/sBs7LJMejmjo+yCOC1gplW8lS7Zjy4ou+PF4Wlub3BUU98I/ml8FKV94GvuoVkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKmrFnAz; arc=none smtp.client-ip=209.85.218.52
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15bf399d3bso211768666b.2
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766956; x=1784371756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N+is6er/vQbeTSe1nArWPwfO9mnF36kI85LBEEl/BK0=;
        b=DKmrFnAz6ynWu4aXfavUX3BpjdI6H6//NBmYWo6zYSKXmb8gRDm5vTeGCcrFiE+qta
         WLxfec/LqsyUvBTdwaRisfYIuw18bsShKuhq2sirsC/KsfI82/aLZJhSb0WLOEiEggWI
         5IuLuq9Ei4jha8wYYZMaYe5fgYRxRFucbD3hmbe+5vjp/xV9sqOmKdcAuRAlVJutRKC/
         84PyVkH/POjKjM2NwWGgrTyAyFzo1o5lYIZ9F21TOH2RhMUsd9Ux1odeETOaR+HXHcK6
         7f7LicbcL92eBGxX2nT0LTWNOsi+/JFL8WlbE8tA4D7K4JA4UppPpZiIqhbsNjf57qS7
         Shmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766956; x=1784371756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N+is6er/vQbeTSe1nArWPwfO9mnF36kI85LBEEl/BK0=;
        b=Qbn9UQnMj5R/68Eh7FitC/FUsjQQ/kLyl9JnZpZRJ7pAU3MdRrYbXjdQQao1Yw82tN
         OyX8ubkBBH2P4unr/e51YV4pHOgdrOWKc+QNVbnP67cI634FcKcuale0SlypOuzoFYKa
         JdAugbzzR+/2OXkHXOeIQt77vl1uoaWJTWLrd6PqbpwNHiqLD51vUyezgdErWDLnLw9K
         5IiDfSIGbyqiK/onrafVqtnJ877Z+9r5F+xkZ/lR/IL23U+4pWphP5LeWqr2f3YxIEUV
         4adJt5DdveVYGLZLU9p3SOmfKc3MMDUFwdoXY0LsISLPPsdH1jJ0LuUZ5u8xXCcJJ7Z7
         xK+Q==
X-Gm-Message-State: AOJu0Yy7jyAWlH3i7OfpP1gIDZQD+cfKI9SwsCa/mmWlL7Cqze4S4bkj
	swl5mT4VrNfYmGVmfmbqj6kvpZPFRTO18KD7yr1bdKcQGxYlbhOyxQBsxR+lgw==
X-Gm-Gg: AfdE7cm9xBQuECzQ3Mg9x4WXX8rKSSuem6uMDRRY5cywm91flpll9SIAyQqmcfaal1a
	PJl3P5vlBugaRX8y3+2LD/1xKhl9GS0u1RB5Ru25Tpf7PC3uSjMkxS+d3wF1ROTj9loVVd3U/tb
	bG6rm725zSXQfqjY/igZ1FMHxGxNvku43PAkrtOO/exAuExF8C7I4t5zT0wwFtEKolGGION1AwE
	LMUG+U/yyCOp74PhjGGJxUvix3P2xV2TOxweGczkZuUSl88r1+0oDdNIAly1gJny9CBEP276V0x
	ZSUQDqnhgeGsMF3o/W4A97L0NYBgrBxawCSbRSztZvViCDTeBA9jl03fJpLceIiA8f+D8gMO/et
	8fZfOTmP2eSo+erTg85QkNpo8Zh+IIyS2Tw/AZWVJQclJwkMGeYVUoJbkxetBlw4TY6cZaqtCXb
	Z76Wwt5LUm3nt41U97uw0EMzGQK4Qd6r5hQCIiCMqn9MfBMnpFRuO6P5QXY4Sts2g2sRHX0Ub59
	/HcDvIWPOHgnnd3S+Gopk6XNLGB7aZMOB/o6EB1S1RQvG6VLA==
X-Received: by 2002:a17:907:6d20:b0:c12:34f0:f7b8 with SMTP id a640c23a62f3a-c161ea6be7dmr77791966b.55.1783766956021;
        Sat, 11 Jul 2026 03:49:16 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-222-132.dab.02.net. [82.132.222.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15beb53b86sm609123166b.25.2026.07.11.03.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:49:12 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	io-uring@vger.kernel.org,
	asml.silence@gmail.com
Subject: [RFC 03/10] io_uring/zcrx: switch to pcpu refcounting
Date: Sat, 11 Jul 2026 11:48:32 +0100
Message-ID: <3a990539e205fab5bafb5185471e73b308647a2f.1783614400.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783614400.git.asml.silence@gmail.com>
References: <cover.1783614400.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-306825-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jhs@mojatatu.com,m:io-uring@vger.kernel.org,m:asml.silence@gmail.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A4C57414FC

We'll need a faster way to pin a zcrx instance for get_netmem(). Switch
refcounting to percpu_ref.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 36 ++++++++++++++++++++++++++++++------
 io_uring/zcrx.h |  4 +++-
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index ef82e064e796..f501fc75d7b6 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -32,6 +32,8 @@
 
 #define IO_DMA_ATTR (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
 
+static void ifq_pcpu_release(struct percpu_ref *ref);
+
 static inline struct io_zcrx_ifq *io_pp_to_ifq(struct page_pool *pp)
 {
 	return pp->mp_priv;
@@ -535,16 +537,22 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
 {
 	struct io_zcrx_ifq *ifq;
+	int ret;
 
 	ifq = kzalloc_obj(*ifq);
 	if (!ifq)
 		return NULL;
+	ret = percpu_ref_init(&ifq->refs, ifq_pcpu_release, 0, GFP_KERNEL_ACCOUNT);
+	if (ret) {
+		kfree(ifq);
+		return NULL;
+	}
+	percpu_ref_get(&ifq->refs);
 
 	ifq->if_rxq = -1;
 	spin_lock_init(&ifq->ctx_lock);
 	spin_lock_init(&ifq->rq.lock);
 	mutex_init(&ifq->pp_lock);
-	refcount_set(&ifq->refs, 1);
 	refcount_set(&ifq->user_refs, 1);
 	return ifq;
 }
@@ -606,13 +614,28 @@ static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
 	io_free_rbuf_ring(ifq);
 	free_uid(ifq->user);
 	mutex_destroy(&ifq->pp_lock);
+	percpu_ref_exit(&ifq->refs);
 	kfree(ifq);
 }
 
+static inline void zcrx_release_work(struct work_struct *work)
+{
+	struct io_zcrx_ifq *ifq = container_of(work, struct io_zcrx_ifq, release_work);
+
+	io_zcrx_ifq_free(ifq);
+}
+
+static void ifq_pcpu_release(struct percpu_ref *ref)
+{
+	struct io_zcrx_ifq *ifq = container_of(ref, struct io_zcrx_ifq, refs);
+
+	INIT_WORK(&ifq->release_work, zcrx_release_work);
+	queue_work(system_wq, &ifq->release_work);
+}
+
 static void io_put_zcrx_ifq(struct io_zcrx_ifq *ifq)
 {
-	if (refcount_dec_and_test(&ifq->refs))
-		io_zcrx_ifq_free(ifq);
+	percpu_ref_put(&ifq->refs);
 }
 
 static void io_zcrx_return_niov_freelist(struct net_iov *niov)
@@ -683,6 +706,7 @@ static void zcrx_unregister_user(struct io_zcrx_ifq *ifq, struct io_ring_ctx *ct
 	if (refcount_dec_and_test(&ifq->user_refs)) {
 		io_close_queue(ifq);
 		io_zcrx_scrub(ifq);
+		percpu_ref_kill(&ifq->refs);
 	}
 }
 
@@ -727,7 +751,7 @@ static int zcrx_export(struct io_ring_ctx *ctx, struct io_zcrx_ifq *ifq,
 	if (!mem_is_zero(ce, sizeof(*ce)))
 		return -EINVAL;
 
-	refcount_inc(&ifq->refs);
+	percpu_ref_get(&ifq->refs);
 	refcount_inc(&ifq->user_refs);
 
 	file = anon_inode_create_getfile("[zcrx]", &zcrx_box_fops,
@@ -784,7 +808,7 @@ static int import_zcrx(struct io_ring_ctx *ctx,
 		return -EBADF;
 
 	ifq = file->private_data;
-	refcount_inc(&ifq->refs);
+	percpu_ref_get(&ifq->refs);
 	refcount_inc(&ifq->user_refs);
 
 	scoped_guard(mutex, &ctx->mmap_lock) {
@@ -1285,7 +1309,7 @@ static int io_pp_zc_init(struct page_pool *pp)
 	if (pp->p.dma_dir != DMA_FROM_DEVICE)
 		return -EOPNOTSUPP;
 
-	refcount_inc(&ifq->refs);
+	percpu_ref_get(&ifq->refs);
 	return 0;
 }
 
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index fa00900e479e..205b9b40c74d 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -7,6 +7,7 @@
 #include <linux/socket.h>
 #include <net/page_pool/types.h>
 #include <net/net_trackers.h>
+#include <linux/percpu-refcount.h>
 
 #define ZCRX_SUPPORTED_REG_FLAGS	(ZCRX_REG_IMPORT | ZCRX_REG_NODEV)
 #define ZCRX_FEATURES			(ZCRX_FEATURE_RX_PAGE_SIZE |\
@@ -64,7 +65,7 @@ struct io_zcrx_ifq {
 	struct device			*dev;
 	struct net_device		*netdev;
 	netdevice_tracker		netdev_tracker;
-	refcount_t			refs;
+	struct percpu_ref		refs;
 	/* counts userspace facing users like io_uring */
 	refcount_t			user_refs;
 
@@ -81,6 +82,7 @@ struct io_zcrx_ifq {
 	u32				fired_notifs;
 	u64				notif_data;
 	struct zcrx_notif_stats		*notif_stats;
+	struct work_struct		release_work;
 };
 
 #if defined(CONFIG_IO_URING_ZCRX)
-- 
2.54.0


