Return-Path: <netdev+bounces-290428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFs3BXQMD2pyEgYAu9opvQ
	(envelope-from <netdev+bounces-290428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:45:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 633AB5A62CC
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0885320E517
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3F53D522C;
	Thu, 21 May 2026 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="mcajz30w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EEB3D45F2
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369294; cv=none; b=u5zSwXoEnHT5GSA61jtej0re+y4QaBy0fWrxExJF6DVPHIO9h2J9WKgKQtU7vQ7lgJV3duG+6RJV5rJHxc8uvT3KDOpSymfdh9gJHuHQH3ilAkVBOLYHmmmgOkkSiHL+bHXtEZEuiMra+g8ZHI6Li333GxZ3Y+wnIIJRz3kHfB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369294; c=relaxed/simple;
	bh=07rXQtx6bL5yNi+yGLTyDxbcKFB6Q3GEhu3F3J7jti0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k4eC5aHNTmWXN/acQ15MCraltQZKcECs1nuzOoDFrotDfACzAQ64YFh2o4cAWHop9ggOqqs7jhOagp4c1tYmgCGp4y861e+BcSp+RoePlyua6/5pgOieeenKaVhkrqQp4Q3slEZxr1C5jWq0tD0OJnYL1hbHet7zqZMSeI6huoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=mcajz30w; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8c7154725easo71772946d6.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779369291; x=1779974091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xagyUorDlVS2ZyXIvbVBSCw8IrHf4H2n8ajnGsDGm78=;
        b=mcajz30w7Jd69Yl1XgveLntoEnF3tv+Hfb5bi/EeFnBDprOEkaM4O48Huip+VmJsFr
         HtJdyGNU3ML8WaikRAtZrTtq5hOwI1eRGUpvY5Z5ybNVv9ZoteEPdgxRKWOsjriINge2
         pfZ3Ks+gGaBCOWB2S8U0I01xDwad3ZOda1UY1rJI6mVNkiO9/z+BQ83fD+8FlXD2o41L
         SkKEuZtwdq2jjFpCjgrmamh44x6vEshWJ0RRbe0NFQhzuKWrn0PmU51xJrboWofZkZy+
         Ko7lMbA9VH6BZ3oJuedhWvtkeE9J/KUvUWS990g2DO07mZQUSncp8XMFH54PQhzrgN8R
         9lSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369291; x=1779974091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xagyUorDlVS2ZyXIvbVBSCw8IrHf4H2n8ajnGsDGm78=;
        b=KjR63Fd06USI3Hn95yYpShRA3HCwWPQFNurxiOTNsfXApd5udMHqe7Q1cN+neh59PR
         EICQd1yGJwS4K0hdC/tvSuUsdKWidxlfl1a5qPzk3jx+pAFQslxhAwWZ9hTiuCgn73Xg
         HKd8RN55sgwBmBYPZwOPBcfpTkHDq12ypLzoAq9XxD0bBohKQkRsWwsxQ1tN8y6wRkPJ
         y6nEGWpLK/xDDZmGlzdQA6VU3imnr0j0roW+Qn2kbZxOPKQ/K3nXsAoy77Dw4YY+H6y3
         1ETHbgMy201fSPsfZ0DkdQEuq8pkG+7MGm9Mvid0/H2R1jEf6SEOPhr3sd/vuhQWsTzU
         V47g==
X-Gm-Message-State: AOJu0YxoqCLVHWpO8QCh5VDPVVeWaFMtMUqZGq/MAFJPtP8TyDdy89Ot
	5leWmafei73LMdXkXIK6CqbOiYmido+oTicZRm8SFMteXjsg3e5Xugyodkc31kprzxGjR+tpa/U
	0w4UalA==
X-Gm-Gg: Acq92OHH/bCg5JmseQ//gfdUBDHT3gbrCMakxov3K9LbeESkVY4B7au0vY/ufq3taIG
	+5cuMWb1scripdUfYVwRaSmUrFhaSm/tYoArpqsl6KK1+SxH4srZ3Vmugv4k3jZsVW/Po9DI/Ug
	k1He5O50+aR+iwApmx90ynVwN0cvIB+P7EWbEhZtLw0VSTNaxMKluoznxZGkA5uZSntz1Ce7m7h
	zj6mx/vu7pUgks+0cMWNNS1eevJeNk31q34ueynZ2iDfB1YROtlrN5Z+Yu2V28NhklWq9ZKUJGA
	MkGbpTjvhLFMm8tbsI5gDT7LSm6mbOwybflylQ7pkcSNXE+BfRpILu3XRWkUsyWkb/DowGR7SjU
	jA5Rkx1ig4iK4nchVv/7wNZdS3bOq9kuluFXoGzz1up8MYW7LlEbnHhPnXRQXeNrjQTh4WyYvwP
	AFjLCJ/whMJiSunb03I3/4uG3qRsAjLWozwRXCMg==
X-Received: by 2002:a05:6214:acf:b0:89a:f0b:60e9 with SMTP id 6a1803df08f44-8cc6e303e84mr41709976d6.13.1779369291115;
        Thu, 21 May 2026 06:14:51 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc781d6d7esm4527116d6.39.2026.05.21.06.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:14:50 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	victor@mojatatu.com,
	andrew+netdev@lunn.ch,
	rajat.gupta@oss.qualcomm.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH v2 net 1/1] geneve: fix Use-After-Free in RX path
Date: Thu, 21 May 2026 09:14:36 -0400
Message-Id: <20260521131436.748832-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290428-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mojatatu-com.20251104.gappssmtp.com:dkim,mojatatu.com:mid,mojatatu.com:email]
X-Rspamd-Queue-Id: 633AB5A62CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Context: This commit fixes a UAF in Geneve. The UAF component was discovered
because it is triggered by a buggy 'pedit' action[1]. the buggy pedit uses
skb_store_bits() and can write into shared or non-linear data without copying
the entire skb head. The Geneve device invoking either pskb_may_pull() or
iptunnel_pull_header() is much more likely to reallocate the skb head, freeing
the memory pointed to by geneve's stale geneveh pointer.

Note, although the patch looks big it's mostly re-arranging functions to avoid
forward declaration.

Sample UAF below:
....
BUG: KASAN: slab-use-after-free in geneve_udp_encap_recv+0x2e8c/0x3190
Read of size 1 at addr ffff88811bab3c08 by task kworker/u32:1/62

CPU: 4 UID: 0 PID: 62 Comm: kworker/u32:1 Not tainted 7.1.0-rc3-00182-g0e3e91779b94 #551 PREEMPT(full)
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <IRQ>
 dump_stack_lvl+0x8c/0xd0
 print_report+0xce/0x5e0
 ? geneve_udp_encap_recv+0x2e8c/0x3190
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? kasan_complete_mode_report_info+0x80/0x200
 ? geneve_udp_encap_recv+0x2e8c/0x3190
 kasan_report+0xd6/0x110
 ? geneve_udp_encap_recv+0x2e8c/0x3190
 __asan_report_load1_noabort+0x18/0x20
 geneve_udp_encap_recv+0x2e8c/0x3190
 ? get_stack_info+0x38/0xc0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __pfx_geneve_udp_encap_recv+0x10/0x10
 ? udp4_lib_lookup2+0x31c/0x700
 ? __pfx_udp_ehashfn+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __xfrm_policy_check2.constprop.0+0x40/0x5b0
 udp_queue_rcv_one_skb+0x65e/0xd20
 udp_queue_rcv_skb+0x142/0xb00
 udp_unicast_rcv_skb+0xd3/0x2c0
 udp_rcv+0x198f/0x2570
 ? srso_alias_return_thunk+0x5/0xfbef5
 ip_protocol_deliver_rcu+0x1f8/0x3c0
 ip_local_deliver_finish+0x362/0x5d0
....

[1]https://lore.kernel.org/netdev/20260519033950.2037-1-rajat.gupta@oss.qualcomm.com/
Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1->v2 Address gemini-sashiko.
1. local variable "len" initialization in geneve_post_decap_hint()
   Although doesnt contribute to the fix, it was introduced in fd0dd796576e
2. resolve out-of-bounds transport header for non-GSO packets
---
 drivers/net/geneve.c   | 174 ++++++++++++++++++++++-------------------
 include/linux/skbuff.h |   5 ++
 2 files changed, 98 insertions(+), 81 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index c6563367d382..dc5f5394836a 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -256,6 +256,79 @@ static struct geneve_dev *geneve_lookup_skb(struct geneve_sock *gs,
 	return NULL;
 }
 
+/*
+ * Look for GRO hint in the genenve options; if not found or does not pass basic
+ * sanitization return 0, otherwise the offset WRT the geneve hdr start.
+ */
+static unsigned int
+geneve_opt_gro_hint_off(const struct genevehdr *gh, __be16 *type,
+			unsigned int *gh_len)
+{
+	struct geneve_opt *opt = (void *)(gh + 1);
+	unsigned int id, opt_len = gh->opt_len;
+	struct geneve_opt_gro_hint *gro_hint;
+
+	while (opt_len >= (GENEVE_OPT_GRO_HINT_SIZE >> 2)) {
+		if (opt->opt_class == htons(GENEVE_OPT_NETDEV_CLASS) &&
+		    opt->type == GENEVE_OPT_GRO_HINT_TYPE &&
+		    opt->length == GENEVE_OPT_GRO_HINT_LEN)
+			goto found;
+
+		/* check for bad opt len */
+		if (opt->length + 1 >= opt_len)
+			return 0;
+
+		/* next opt */
+		opt_len -= opt->length + 1;
+		opt = ((void *)opt) + ((opt->length + 1) << 2);
+	}
+	return 0;
+
+found:
+	gro_hint = (struct geneve_opt_gro_hint *)opt->opt_data;
+
+	/*
+	 * Sanitize the hinted hdrs: the nested transport is UDP and must fit
+	 * the overall hinted hdr size.
+	 */
+	if (gro_hint->nested_tp_offset + sizeof(struct udphdr) >
+	    gro_hint->nested_hdr_len)
+		return 0;
+
+	if (gro_hint->nested_nh_offset +
+	    (gro_hint->nested_is_v6 ? sizeof(struct ipv6hdr) :
+				      sizeof(struct iphdr)) >
+	    gro_hint->nested_tp_offset)
+		return 0;
+
+	/* Allow only supported L2. */
+	id = gro_hint->inner_proto_id;
+	if (id >= ARRAY_SIZE(proto_id_map))
+		return 0;
+
+	*type = proto_id_map[id];
+	*gh_len += gro_hint->nested_hdr_len;
+
+	return (void *)gro_hint - (void *)gh;
+}
+
+static const struct geneve_opt_gro_hint *
+geneve_opt_gro_hint(const struct genevehdr *gh, unsigned int hint_off)
+{
+	return (const struct geneve_opt_gro_hint *)((void *)gh + hint_off);
+}
+
+static unsigned int
+geneve_sk_gro_hint_off(const struct sock *sk, const struct genevehdr *gh,
+		       __be16 *type, unsigned int *gh_len)
+{
+	const struct geneve_sock *gs = rcu_dereference_sk_user_data(sk);
+
+	if (!gs || !gs->gro_hint)
+		return 0;
+	return geneve_opt_gro_hint_off(gh, type, gh_len);
+}
+
 /* geneve receive/decap routine */
 static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 		      struct sk_buff *skb, const struct genevehdr *gnvh)
@@ -299,6 +372,21 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 	if (tun_dst)
 		skb_dst_set(skb, &tun_dst->dst);
 
+	if (skb->encapsulation) {
+		unsigned int len = 0, hint_off;
+		__be16 p;
+
+		hint_off = geneve_sk_gro_hint_off(gs->sock->sk, gnvh, &p, &len);
+		if (hint_off && len <= skb_headlen(skb)) {
+			const struct geneve_opt_gro_hint *gro_hint;
+
+			gro_hint = geneve_opt_gro_hint(gnvh, hint_off);
+			skb_set_transport_header(skb, gro_hint->nested_tp_offset);
+		}
+	} else {
+		skb_unset_transport_header(skb);
+	}
+
 	if (gnvh->proto_type == htons(ETH_P_TEB)) {
 		skb_reset_mac_header(skb);
 		skb->protocol = eth_type_trans(skb, geneve->dev);
@@ -407,79 +495,6 @@ static int geneve_hlen(const struct genevehdr *gh)
 	return sizeof(*gh) + gh->opt_len * 4;
 }
 
-/*
- * Look for GRO hint in the genenve options; if not found or does not pass basic
- * sanitization return 0, otherwise the offset WRT the geneve hdr start.
- */
-static unsigned int
-geneve_opt_gro_hint_off(const struct genevehdr *gh, __be16 *type,
-			unsigned int *gh_len)
-{
-	struct geneve_opt *opt = (void *)(gh + 1);
-	unsigned int id, opt_len = gh->opt_len;
-	struct geneve_opt_gro_hint *gro_hint;
-
-	while (opt_len >= (GENEVE_OPT_GRO_HINT_SIZE >> 2)) {
-		if (opt->opt_class == htons(GENEVE_OPT_NETDEV_CLASS) &&
-		    opt->type == GENEVE_OPT_GRO_HINT_TYPE &&
-		    opt->length == GENEVE_OPT_GRO_HINT_LEN)
-			goto found;
-
-		/* check for bad opt len */
-		if (opt->length + 1 >= opt_len)
-			return 0;
-
-		/* next opt */
-		opt_len -= opt->length + 1;
-		opt = ((void *)opt) + ((opt->length + 1) << 2);
-	}
-	return 0;
-
-found:
-	gro_hint = (struct geneve_opt_gro_hint *)opt->opt_data;
-
-	/*
-	 * Sanitize the hinted hdrs: the nested transport is UDP and must fit
-	 * the overall hinted hdr size.
-	 */
-	if (gro_hint->nested_tp_offset + sizeof(struct udphdr) >
-	    gro_hint->nested_hdr_len)
-		return 0;
-
-	if (gro_hint->nested_nh_offset +
-	    (gro_hint->nested_is_v6 ? sizeof(struct ipv6hdr) :
-				      sizeof(struct iphdr)) >
-	    gro_hint->nested_tp_offset)
-		return 0;
-
-	/* Allow only supported L2. */
-	id = gro_hint->inner_proto_id;
-	if (id >= ARRAY_SIZE(proto_id_map))
-		return 0;
-
-	*type = proto_id_map[id];
-	*gh_len += gro_hint->nested_hdr_len;
-
-	return (void *)gro_hint - (void *)gh;
-}
-
-static const struct geneve_opt_gro_hint *
-geneve_opt_gro_hint(const struct genevehdr *gh, unsigned int hint_off)
-{
-	return (const struct geneve_opt_gro_hint *)((void *)gh + hint_off);
-}
-
-static unsigned int
-geneve_sk_gro_hint_off(const struct sock *sk, const struct genevehdr *gh,
-		       __be16 *type, unsigned int *gh_len)
-{
-	const struct geneve_sock *gs = rcu_dereference_sk_user_data(sk);
-
-	if (!gs || !gs->gro_hint)
-		return 0;
-	return geneve_opt_gro_hint_off(gh, type, gh_len);
-}
-
 /* Validate the packet headers pointed by data WRT the provided hint */
 static bool
 geneve_opt_gro_hint_validate(void *data,
@@ -571,7 +586,7 @@ static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
 				  struct genevehdr **geneveh)
 {
 	const struct geneve_opt_gro_hint *gro_hint;
-	unsigned int len, total_len, hint_off;
+	unsigned int len = 0, total_len, hint_off;
 	struct ipv6hdr *ipv6h;
 	struct iphdr *iph;
 	struct udphdr *uh;
@@ -585,10 +600,10 @@ static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
 		return 0;
 
 	gro_hint = geneve_opt_gro_hint(*geneveh, hint_off);
-	if (unlikely(!pskb_may_pull(skb, gro_hint->nested_hdr_len)))
+	if (unlikely(skb_ensure_writable(skb, gro_hint->nested_hdr_len)))
 		return -ENOMEM;
 
-	*geneveh = geneve_hdr(skb);
+	*geneveh = (struct genevehdr *)(skb->data - gh_len);
 	gro_hint = geneve_opt_gro_hint(*geneveh, hint_off);
 
 	/*
@@ -612,9 +627,6 @@ static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
 	 */
 	skb->encapsulation = 1;
 
-	/* GSO expect a valid transpor header, move it to the current one. */
-	skb_set_transport_header(skb, gro_hint->nested_tp_offset);
-
 	/* Adjust the nested IP{6} hdr to actual GSO len. */
 	if (gro_hint->nested_is_v6) {
 		ipv6h->payload_len = htons(total_len - sizeof(*ipv6h));
@@ -629,7 +641,7 @@ static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
 	}
 
 	/* Adjust the nested UDP header len and checksum. */
-	uh = udp_hdr(skb);
+	uh = (struct udphdr *)(skb->data + gro_hint->nested_tp_offset);
 	uh->len = htons(skb->len - gro_hint->nested_tp_offset);
 	if (uh->check) {
 		len = skb->len - gro_hint->nested_nh_offset;
@@ -691,7 +703,7 @@ static int geneve_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	 * After hint processing, the transport header points to the inner one
 	 * and we can't use anymore on geneve_hdr().
 	 */
-	geneveh = geneve_hdr(skb);
+	geneveh = (struct genevehdr *)(skb->data - (sizeof(struct genevehdr) + opts_len));
 	if (geneve_post_decap_hint(sk, skb, sizeof(struct genevehdr) +
 				   opts_len, &geneveh)) {
 		DEV_STATS_INC(geneve->dev, rx_errors);
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2bcf78a4de7b..f535838cff68 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3125,6 +3125,11 @@ static inline void skb_set_transport_header(struct sk_buff *skb,
 	skb->transport_header += offset;
 }
 
+static inline void skb_unset_transport_header(struct sk_buff *skb)
+{
+	skb->transport_header = (typeof(skb->transport_header))~0U;
+}
+
 static inline unsigned char *skb_network_header(const struct sk_buff *skb)
 {
 	return skb->head + skb->network_header;
-- 
2.34.1


