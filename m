Return-Path: <netdev+bounces-271194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBZQBs7HwmmIlgQAu9opvQ
	(envelope-from <netdev+bounces-271194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:20:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27704319E99
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE8D9302711D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791083A9D9B;
	Tue, 24 Mar 2026 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTSjouQi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC01E3ECBDB
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774372385; cv=none; b=t68oGvSVGe8htT+W68+a8x0Rc8TP1NlfV3IBlCpe/EX3VO4DLR/EQWQXpLxW6Un2iIU+v2ZS6HSKTH79sV+xbtL5CFjyQHaa2K1u7dXQ7Q1BRArYfKSkxPxAousysAwBAK3BlcucMHImnNq+ki5PjQHQuL2nXqCvCnHBj+d8pAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774372385; c=relaxed/simple;
	bh=491Tcown/a9xJe2UVVZge7bi+yCcfx9T9Zxk9y6fmwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7dCMIj33Z4C4lawvvxnyDkYiXHQwfY8bf8VlgjrbUyV0QATfeudvbJJrmcoTrXPb/yFM70BKLvoynjlY6u2Df4c6iDAXbFEMo1WGFnbNUZlC57pzflunpIo3ZpJCumfRCNCKE4HVAetyEc3w6U+Fi32ZJN6sGwSUQAo4EdiCoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTSjouQi; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b40003d13so3582189f8f.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774372382; x=1774977182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJMlBk0LHljD+8TN+Z7TlRerRypJBegR6DyJbZSccno=;
        b=fTSjouQiYgunZdE8GnG0BDU/D8JLDOJjH8SCRggnmTHqq089760ThkEQuHw9vvy9/F
         mJqAiSLww4597MSsazXiOr/wZicNBZypLFdUBIYXyLy17wTildtjNHUppvwt+4MTFVnd
         SwDX++nBtIBUlM/fjudQMIP9Xxl5X8eEYGbaTrtp2FG9qdT/ULwowCrV+iXvISzen0jY
         cd775a5HoLJIEsF1bdAjUgiNf42iWMyow7OrRw9qbXJ6ih+Yy20MzrJ6ax35i6BfkxyK
         inDaZdfezK0fRYNCb3pHOjMSS1NNpo8eIUCunXQbJEWJvZ0+3XJ6BbmuS9zwusoPrQkK
         4lXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774372382; x=1774977182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vJMlBk0LHljD+8TN+Z7TlRerRypJBegR6DyJbZSccno=;
        b=ASI2cLvEzpMUsABxmmmy6j1pwl8VmdmBWcbD6w0NGB1lPiX1fxsF5K31SAHv6+aE8W
         nEJGNL/CTVLUEsnOMvDeVS3b9GXgHYA03YCcZ/ihd6/vf9xuxjAi+eeX0kUW1t0gNUan
         NDLaoG61tZyNbTFDWL/TZZvXW7jSSEIaX7qD4b5wMQiy2WqGAHdK2QiKz9Pk+RirQYHV
         EkCzSNwrDQxoeqlLHItp9xYCyywIiFN05x7O9zUrNJCXrIaRZuD/v5+lgbdhhzMf8KFI
         VfW3X0Lv7vDnaK5ori1qExKZ/AbK28uGk7hghauzLekH435x/sEafiAYBT++sweZ+rMr
         Ja5w==
X-Gm-Message-State: AOJu0YwK8LYJ5PH757oBTZkiX4XqmvQ+d7yG8hH+gsaZs30XDrqaVUev
	V6bMKB2Vt0bnyGAUFYxlmrwGaw1eUyct+MUHR1FnRmMlMIdyzyGNZ/Z2
X-Gm-Gg: ATEYQzyqnDv/pS8gKBeGvQXi5n32RaUwu3e6vxxLFdFxuYA9Ftbef6osMo1mvI3qubI
	JCbzI+zANVihYluuC4SI5gBfZdj3D+IYuDavNdemAtnIRpkpD6owgblxGcJrOwwAXmrngizxaAX
	QdpoGr/f2LxST63goteJ6onhmEJxcJprXtbNIlJJUQDL0SMzoKwHQR5+A5nAPWzbjjcHxwcr4en
	fxhDS9e96U/CPACwr670IrLRG/KP+5NS9u0oJLyEWQoBHpzO1ZuqRRhNctzraaRac9omit6dlrV
	PAnjPlZc9KH2PeY93grVJfUZHGZEy3SEdh8rB6vyEdluzqPgPtG+9A7aiGbWUg7G667Nen+rWQl
	U7ztgSeXSbf4v00FxzTj4Oix8bNx0hMBV8JhVNLFol1h8NKMWW38cCLqQsZy68pYkXUHYT+F7/U
	mJE40zCOaICJi8FlIjoJpuhiAHdKeHgOgo6yfL/hi5rVqxRNCh44OAspJEmKmdOuJ7g1f9ljLWo
	5yaM9YdOgIi
X-Received: by 2002:a05:6000:18a8:b0:439:fe98:20f9 with SMTP id ffacd0b85a97d-43b88a0fb14mr372296f8f.27.1774372382226;
        Tue, 24 Mar 2026 10:13:02 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b646b0b0csm37396023f8f.15.2026.03.24.10.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 10:13:01 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] netfilter: ctnetlink: use netlink policy range checks
Date: Tue, 24 Mar 2026 17:12:59 +0000
Message-ID: <20260324171259.318041-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324163033.310087-1-devnexen@gmail.com>
References: <20260324163033.310087-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-271194-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email]
X-Rspamd-Queue-Id: 27704319E99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace manual range and mask validations with netlink policy
annotations in ctnetlink code paths, so that the netlink core rejects
invalid values early and can generate extack errors.

- CTA_PROTOINFO_TCP_STATE: reject values > TCP_CONNTRACK_SYN_SENT2 at
  policy level, removing the manual >= TCP_CONNTRACK_MAX check.
- CTA_PROTOINFO_TCP_WSCALE_ORIGINAL/REPLY: reject values > TCP_MAX_WSCALE
  (14). The normal TCP option parsing path already clamps to this value,
  but the ctnetlink path accepted 0-255, causing undefined behavior when
  used as a u32 shift count.
- CTA_FILTER_ORIG_FLAGS/REPLY_FLAGS: use NLA_POLICY_MASK with
  CTA_FILTER_F_ALL, removing the manual mask checks.
- CTA_EXPECT_FLAGS: use NLA_POLICY_MASK with NF_CT_EXPECT_MASK, adding
  a new mask define grouping all valid expect flags.

Extracted from a broader nf-next patch by Florian Westphal, scoped to
ctnetlink for the fixes tree.

Fixes: c8e2078cfe41 ("[NETFILTER]: ctnetlink: add support for internal tcp connection tracking flags handling")
Co-developed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 .../uapi/linux/netfilter/nf_conntrack_common.h   |  4 ++++
 net/netfilter/nf_conntrack_netlink.c             | 16 +++++-----------
 net/netfilter/nf_conntrack_proto_tcp.c           | 10 +++-------
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/include/uapi/linux/netfilter/nf_conntrack_common.h b/include/uapi/linux/netfilter/nf_conntrack_common.h
index 26071021e986..56b6b60a814f 100644
--- a/include/uapi/linux/netfilter/nf_conntrack_common.h
+++ b/include/uapi/linux/netfilter/nf_conntrack_common.h
@@ -159,5 +159,9 @@ enum ip_conntrack_expect_events {
 #define NF_CT_EXPECT_INACTIVE		0x2
 #define NF_CT_EXPECT_USERSPACE		0x4
 
+#ifdef __KERNEL__
+#define NF_CT_EXPECT_MASK	(NF_CT_EXPECT_PERMANENT | NF_CT_EXPECT_INACTIVE | \
+				 NF_CT_EXPECT_USERSPACE)
+#endif
 
 #endif /* _UAPI_NF_CONNTRACK_COMMON_H */
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index c156574e1273..d7a4207d112e 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -910,8 +910,8 @@ struct ctnetlink_filter {
 };
 
 static const struct nla_policy cta_filter_nla_policy[CTA_FILTER_MAX + 1] = {
-	[CTA_FILTER_ORIG_FLAGS]		= { .type = NLA_U32 },
-	[CTA_FILTER_REPLY_FLAGS]	= { .type = NLA_U32 },
+	[CTA_FILTER_ORIG_FLAGS]		= NLA_POLICY_MASK(NLA_U32, CTA_FILTER_F_ALL),
+	[CTA_FILTER_REPLY_FLAGS]	= NLA_POLICY_MASK(NLA_U32, CTA_FILTER_F_ALL),
 };
 
 static int ctnetlink_parse_filter(const struct nlattr *attr,
@@ -925,17 +925,11 @@ static int ctnetlink_parse_filter(const struct nlattr *attr,
 	if (ret)
 		return ret;
 
-	if (tb[CTA_FILTER_ORIG_FLAGS]) {
+	if (tb[CTA_FILTER_ORIG_FLAGS])
 		filter->orig_flags = nla_get_u32(tb[CTA_FILTER_ORIG_FLAGS]);
-		if (filter->orig_flags & ~CTA_FILTER_F_ALL)
-			return -EOPNOTSUPP;
-	}
 
-	if (tb[CTA_FILTER_REPLY_FLAGS]) {
+	if (tb[CTA_FILTER_REPLY_FLAGS])
 		filter->reply_flags = nla_get_u32(tb[CTA_FILTER_REPLY_FLAGS]);
-		if (filter->reply_flags & ~CTA_FILTER_F_ALL)
-			return -EOPNOTSUPP;
-	}
 
 	return 0;
 }
@@ -2634,7 +2628,7 @@ static const struct nla_policy exp_nla_policy[CTA_EXPECT_MAX+1] = {
 	[CTA_EXPECT_HELP_NAME]	= { .type = NLA_NUL_STRING,
 				    .len = NF_CT_HELPER_NAME_LEN - 1 },
 	[CTA_EXPECT_ZONE]	= { .type = NLA_U16 },
-	[CTA_EXPECT_FLAGS]	= { .type = NLA_U32 },
+	[CTA_EXPECT_FLAGS]	= NLA_POLICY_MASK(NLA_BE32, NF_CT_EXPECT_MASK),
 	[CTA_EXPECT_CLASS]	= { .type = NLA_U32 },
 	[CTA_EXPECT_NAT]	= { .type = NLA_NESTED },
 	[CTA_EXPECT_FN]		= { .type = NLA_NUL_STRING },
diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index 0c1d086e96cb..b67426c2189b 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -1385,9 +1385,9 @@ static int tcp_to_nlattr(struct sk_buff *skb, struct nlattr *nla,
 }
 
 static const struct nla_policy tcp_nla_policy[CTA_PROTOINFO_TCP_MAX+1] = {
-	[CTA_PROTOINFO_TCP_STATE]	    = { .type = NLA_U8 },
-	[CTA_PROTOINFO_TCP_WSCALE_ORIGINAL] = { .type = NLA_U8 },
-	[CTA_PROTOINFO_TCP_WSCALE_REPLY]    = { .type = NLA_U8 },
+	[CTA_PROTOINFO_TCP_STATE]	    = NLA_POLICY_MAX(NLA_U8, TCP_CONNTRACK_SYN_SENT2),
+	[CTA_PROTOINFO_TCP_WSCALE_ORIGINAL] = NLA_POLICY_MAX(NLA_U8, TCP_MAX_WSCALE),
+	[CTA_PROTOINFO_TCP_WSCALE_REPLY]    = NLA_POLICY_MAX(NLA_U8, TCP_MAX_WSCALE),
 	[CTA_PROTOINFO_TCP_FLAGS_ORIGINAL]  = { .len = sizeof(struct nf_ct_tcp_flags) },
 	[CTA_PROTOINFO_TCP_FLAGS_REPLY]	    = { .len = sizeof(struct nf_ct_tcp_flags) },
 };
@@ -1414,10 +1414,6 @@ static int nlattr_to_tcp(struct nlattr *cda[], struct nf_conn *ct)
 	if (err < 0)
 		return err;
 
-	if (tb[CTA_PROTOINFO_TCP_STATE] &&
-	    nla_get_u8(tb[CTA_PROTOINFO_TCP_STATE]) >= TCP_CONNTRACK_MAX)
-		return -EINVAL;
-
 	spin_lock_bh(&ct->lock);
 	if (tb[CTA_PROTOINFO_TCP_STATE])
 		ct->proto.tcp.state = nla_get_u8(tb[CTA_PROTOINFO_TCP_STATE]);
-- 
2.53.0


