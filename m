Return-Path: <netdev+bounces-300676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lbtKC/sSNWqXmgYAu9opvQ
	(envelope-from <netdev+bounces-300676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:59:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4286A5139
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:59:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=iO7vLZGs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300676-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300676-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65C14301C588
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D2036C5B2;
	Fri, 19 Jun 2026 09:58:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f100.google.com (mail-ua1-f100.google.com [209.85.222.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6B7369D58
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 09:58:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781863092; cv=none; b=SMsoqUxKZ2H2vkEzTYv6FokBEr0oe3iFGT4rWXERC2nxdEvyUbxRkdoEwMJCb0nO3DaWUoMWu5nP5JNaJeSPhsTXJF/R8sqvOpddSDX37/3wC1/dRA/+EGMlyG7l8s/JI0pO76/jeowKgvAmY0VbN1tgW3EIorTdtATg+R1EKvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781863092; c=relaxed/simple;
	bh=IEn6N3iU6QjaodYk5qDEpFHlgrN2QjMwqgISplwfHP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lyjfImm0MZxW3lz6W/Fq2cfu/tORSI252FyER/sJiiWY4K4UQu48wcHN5yTgpOujRil/fPxDjgLEvp3Qtnbh2bCLlUE55n2/jbp6CQ9zgLbU6OsqQDL8T3wmn/iN6cnTylEko9ff+WoeVhwTHHbf9NrfYw8bxNuAbHM8a/j5WAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iO7vLZGs; arc=none smtp.client-ip=209.85.222.100
Received: by mail-ua1-f100.google.com with SMTP id a1e0cc1a2514c-966d4da9fa6so373047241.0
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 02:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781863086; x=1782467886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0w1vsxUJI0JQJt2Tz8nUeF9KKHPDE+aPNVG7KYxhUoA=;
        b=pqrB0wQo1Y4yfza6QxzKXzmhIRHuP+kOGqJ9LcffQD5RIiPVJchjFqOHW2lb9ZUNqe
         F+YJq2sOoRD7m/ffyH181WHgXYTWbhGsxYTzItXyHOrIXn9DtS3W92b+SVVNXuHGVjgC
         MqkVh9ItpcZz7G/bmFbUdxmYQwxPy71Yt6mf2svm50nmhdeiszq0JipC1gweN0CqSAfK
         Q0DySQ1Gzmq6rzWXIuULMTT/WD+RH/r/AA3EaG87wJudD0nNbR4ghNyxasvExBsbG284
         pVUCaiPNuchFLAbjSAxWl0E2U/hqpXwbsM72HDQ6KzS8fp9GOv8ZDepfiNmuQmtrLqXb
         lw7g==
X-Forwarded-Encrypted: i=1; AFNElJ94lXFJCEfbD6nsq1ffxBQDbaRHylMdptdyrjzeKnSqeZw25x1DwnDrAZe/TyV75NbmGrFBi1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT8IgQLOIhfHv/CYJk8HZtrxdxYatVW0u59QvCAT3AWUjqpUiJ
	JMX76bsiZ3JA8aaPy/Tz6sn2Jg0XumNOb2hZQxKtyJPkWbLcR7rCRdGRnzD5CKFLVzB1ISTltH1
	zxlspTTqSr4JzUXZxSS8EVZzbnkGxLB0Y2wNGbeGqJlFjZp0nG3do8W39gN1xFiJ3p83jKfQHP/
	+TryCIaIbnTCXbKtVbId29Uv/V12ZsJ+xToInPJny1sL/WKUy+qqMeAdOsAwcBF1wRr+UiFiW7E
	hz7Kpqg5Jprbut26A==
X-Gm-Gg: AfdE7cl6fXjG+TjO7F0vbHF9cS9mX7D1MX6H17cJGBvbwU936t/92Yz9JOCFY7ByJ6h
	AZdseiYQ7vordtvPKd+vXBKD/nprxU0Dt2kGzwwD/JpiybZuGlGBCagsvGBNtf64OgvYmeeUNCJ
	m5EdWsjLMCkubOuKfqiW3DeA1yKkiBTzddndhRUm/9CO4FnwGFBqf3/CA828PlMzcelCPEiGOKg
	5PBTiDWG+0ANwNo/7s/CVFPyPDN563QsmtVTANXYfaC0f0TiY6NrvcPQg2NtJ+OdRhCasnbXpPS
	o+85MGMEkkIKephPpXDdAsF5CsZ73SW+iOXfXz3b3CIDBq1sztUj/xPf5Kp3BfTIQCHUz1JhmCG
	1arl5iPhuaa8ORwHPbNshnP5hVt9pY9YfUkbAOQGCPzym5InlU2FTt7nTEF2F2wW6ewfbgy6Bjz
	SmvMlKS/XFqtJyF5G7IIOGzeQ4ferYhI7DgMRuXeuHGTML27g+iXXF
X-Received: by 2002:a05:6102:4187:b0:726:cd42:d023 with SMTP id ada2fe7eead31-72a7680f4f6mr587433137.11.1781863086205;
        Fri, 19 Jun 2026 02:58:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-72a3490cf21sm156660137.10.2026.06.19.02.58.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2026 02:58:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso3507662eec.0
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 02:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781863084; x=1782467884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0w1vsxUJI0JQJt2Tz8nUeF9KKHPDE+aPNVG7KYxhUoA=;
        b=iO7vLZGsqBmIVTW+0pGPaSRRyUP+dpNZEw7S/eShSb6pHeSLVi+tJjCdWGaoN9xK+v
         L2h9loLIDatlYzUNDzHY8mSShqyJVnmssLWSYrztxv3h0Ruk22di6NIPRZ/2e54+2+uI
         fd75CLXiGO6rxWGpqiM1J7urB34kAFjJ/uT2k=
X-Forwarded-Encrypted: i=1; AFNElJ+D8DOk6aIncvHD6gNuHh7kU9usuN06kAr6JNWi1GvPpRazEFd7UYtiIDNoeQJpeC7ZYj4Em/M=@vger.kernel.org
X-Received: by 2002:a05:7300:7fa7:b0:2fc:9d97:d59a with SMTP id 5a478bee46e88-30c0d17fb0emr888583eec.32.1781863084395;
        Fri, 19 Jun 2026 02:58:04 -0700 (PDT)
X-Received: by 2002:a05:7300:7fa7:b0:2fc:9d97:d59a with SMTP id 5a478bee46e88-30c0d17fb0emr888572eec.32.1781863083755;
        Fri, 19 Jun 2026 02:58:03 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c06d5bec5sm1851910eec.26.2026.06.19.02.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 02:58:03 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v6.1 2/3] netfilter: nf_tables: fix set size with rbtree backend
Date: Fri, 19 Jun 2026 02:28:49 -0700
Message-Id: <20260619092850.1274076-3-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619092850.1274076-1-shivani.agarwal@broadcom.com>
References: <20260619092850.1274076-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:vamsi-krishna.brahmajosyula@broadcom.com,m:yin.ding@broadcom.com,m:tapas.kundu@broadcom.com,m:sashal@kernel.org,m:shivani.agarwal@broadcom.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[shivani.agarwal@broadcom.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,netfilter.org:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300676-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivani.agarwal@broadcom.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A4286A5139

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 8d738c1869f611955d91d8d0fd0012d9ef207201 ]

The existing rbtree implementation uses singleton elements to represent
ranges, however, userspace provides a set size according to the number
of ranges in the set.

Adjust provided userspace set size to the number of singleton elements
in the kernel by multiplying the range by two.

Check if the no-match all-zero element is already in the set, in such
case release one slot in the set size.

Fixes: 0ed6389c483d ("netfilter: nf_tables: rename set implementations")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Shivani: Modified to apply on 6.1.y ]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 include/net/netfilter/nf_tables.h |  6 ++++
 net/netfilter/nf_tables_api.c     | 49 +++++++++++++++++++++++++++++--
 net/netfilter/nft_set_rbtree.c    | 43 +++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index dafa0a32e..3329c2eae 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -422,6 +422,9 @@ struct nft_set_ext;
  *	@remove: remove element from set
  *	@walk: iterate over all set elements
  *	@get: get set elements
+ *	@ksize: kernel set size
+ *	@usize: userspace set size
+ *	@adjust_maxsize: delta to adjust maximum set size
  *	@privsize: function to return size of set private data
  *	@init: initialize private data of new set instance
  *	@destroy: destroy private data of set instance
@@ -470,6 +473,9 @@ struct nft_set_ops {
 					       const struct nft_set *set,
 					       const struct nft_set_elem *elem,
 					       unsigned int flags);
+	u32				(*ksize)(u32 size);
+	u32				(*usize)(u32 size);
+	u32				(*adjust_maxsize)(const struct nft_set *set);
 	void				(*commit)(struct nft_set *set);
 	void				(*abort)(const struct nft_set *set);
 	u64				(*privsize)(const struct nlattr * const nla[],
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index ec4bfe53b..15bfdf07c 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4264,6 +4264,14 @@ static int nf_tables_fill_set_concat(struct sk_buff *skb,
 	return 0;
 }
 
+static u32 nft_set_userspace_size(const struct nft_set_ops *ops, u32 size)
+{
+	if (ops->usize)
+		return ops->usize(size);
+
+	return size;
+}
+
 static int nf_tables_fill_set(struct sk_buff *skb, const struct nft_ctx *ctx,
 			      const struct nft_set *set, u16 event, u16 flags)
 {
@@ -4328,7 +4336,8 @@ static int nf_tables_fill_set(struct sk_buff *skb, const struct nft_ctx *ctx,
 	if (!nest)
 		goto nla_put_failure;
 	if (set->size &&
-	    nla_put_be32(skb, NFTA_SET_DESC_SIZE, htonl(set->size)))
+	    nla_put_be32(skb, NFTA_SET_DESC_SIZE,
+			 htonl(nft_set_userspace_size(set->ops, set->size))))
 		goto nla_put_failure;
 
 	if (set->field_count > 1 &&
@@ -4698,6 +4707,15 @@ static bool nft_set_is_same(const struct nft_set *set,
 	return true;
 }
 
+static u32 nft_set_kernel_size(const struct nft_set_ops *ops,
+			       const struct nft_set_desc *desc)
+{
+	if (ops->ksize)
+		return ops->ksize(desc->size);
+
+	return desc->size;
+}
+
 static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 			    const struct nlattr * const nla[])
 {
@@ -4880,6 +4898,9 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 		if (err < 0)
 			return err;
 
+		if (desc.size)
+			desc.size = nft_set_kernel_size(set->ops, &desc);
+
 		err = 0;
 		if (!nft_set_is_same(set, &desc, exprs, num_exprs, flags)) {
 			NL_SET_BAD_ATTR(extack, nla[NFTA_SET_NAME]);
@@ -4902,6 +4923,9 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 	if (IS_ERR(ops))
 		return PTR_ERR(ops);
 
+	if (desc.size)
+		desc.size = nft_set_kernel_size(ops, &desc);
+
 	udlen = 0;
 	if (nla[NFTA_SET_USERDATA])
 		udlen = nla_len(nla[NFTA_SET_USERDATA]);
@@ -6327,6 +6351,27 @@ static bool nft_setelem_valid_key_end(const struct nft_set *set,
 	return true;
 }
 
+static u32 nft_set_maxsize(const struct nft_set *set)
+{
+	u32 maxsize, delta;
+
+	if (!set->size)
+		return UINT_MAX;
+
+	if (set->ops->adjust_maxsize)
+		delta = set->ops->adjust_maxsize(set);
+	else
+		delta = 0;
+
+	if (check_add_overflow(set->size, set->ndeact, &maxsize))
+		return UINT_MAX;
+
+	if (check_add_overflow(maxsize, delta, &maxsize))
+		return UINT_MAX;
+
+	return maxsize;
+}
+
 static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			    const struct nlattr *attr, u32 nlmsg_flags)
 {
@@ -6671,7 +6716,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	}
 
 	if (!(flags & NFT_SET_ELEM_CATCHALL)) {
-		unsigned int max = set->size ? set->size + set->ndeact : UINT_MAX;
+		unsigned int max = nft_set_maxsize(set);
 
 		if (!atomic_add_unless(&set->nelems, 1, max)) {
 			err = -ENFILE;
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 426becaad..26e1d994f 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -775,6 +775,46 @@ static bool nft_rbtree_estimate(const struct nft_set_desc *desc, u32 features,
 	return true;
 }
 
+/* rbtree stores ranges as singleton elements, each range is composed of two
+ * elements ...
+ */
+static u32 nft_rbtree_ksize(u32 size)
+{
+	return size * 2;
+}
+
+/* ... hide this detail to userspace. */
+static u32 nft_rbtree_usize(u32 size)
+{
+	if (!size)
+		return 0;
+
+	return size / 2;
+}
+
+static u32 nft_rbtree_adjust_maxsize(const struct nft_set *set)
+{
+	struct nft_rbtree *priv = nft_set_priv(set);
+	struct nft_rbtree_elem *rbe;
+	struct rb_node *node;
+	const void *key;
+
+	node = rb_last(&priv->root);
+	if (!node)
+		return 0;
+
+	rbe = rb_entry(node, struct nft_rbtree_elem, node);
+	if (!nft_rbtree_interval_end(rbe))
+		return 0;
+
+	key = nft_set_ext_key(&rbe->ext);
+	if (memchr(key, 1, set->klen))
+		return 0;
+
+	/* this is the all-zero no-match element. */
+	return 1;
+}
+
 const struct nft_set_type nft_set_rbtree_type = {
 	.features	= NFT_SET_INTERVAL | NFT_SET_MAP | NFT_SET_OBJECT | NFT_SET_TIMEOUT,
 	.ops		= {
@@ -791,5 +831,8 @@ const struct nft_set_type nft_set_rbtree_type = {
 		.lookup		= nft_rbtree_lookup,
 		.walk		= nft_rbtree_walk,
 		.get		= nft_rbtree_get,
+		.ksize		= nft_rbtree_ksize,
+		.usize		= nft_rbtree_usize,
+		.adjust_maxsize = nft_rbtree_adjust_maxsize,
 	},
 };
-- 
2.53.0


