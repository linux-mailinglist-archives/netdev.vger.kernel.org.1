Return-Path: <netdev+bounces-306284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U/VSIfW0T2pFnAIAu9opvQ
	(envelope-from <netdev+bounces-306284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:49:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E77E73276D
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:49:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kYA8oM0q;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306284-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306284-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7131F30087D2
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E4938657D;
	Thu,  9 Jul 2026 14:49:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BB036D4E1
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 14:49:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608556; cv=none; b=lQiXsaNWdrTkiHE3/3emX57BOMbl+HFi+s7aN+OQW5r6eY7lengwpfIgW/RJ4crMJx7iksSq2g6vAkUzxBdTy2ims8oqatjz6CrrD+yRbmA81t41Ck7l1fJeR15jrvfBG0+QScySVG7GI/dC4Vj1F7HlvieSgT/dTAUWuERQ3Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608556; c=relaxed/simple;
	bh=ZRFhpPUtEW8B4kUm7ia+hrYUQRCVnSj6Ua1MmfP0hjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NjcoklAd3iMe87IFU8lm9W1XuB/uwOStBwkDJq5QWd01BPuZ+/DCBOSR9q+SxGkZmKEy6eHDzoAwDBT3HiL9nVEr+8y6B1hh7tktU5As1WSeL1oiLRr2Ks3eOfBicThFQngm6z6JrmYvpSkGbLheyu02jz/9L7Rr9N6cy4cGUxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYA8oM0q; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so15871435e9.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783608553; x=1784213353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ca30GWBimSiK84bMP03NLphqnI2ZnfW4HWnsucbkbvA=;
        b=kYA8oM0q+6squSpMX5GXqOXfw/HC2NqqB+6ASg7aunlY0ThvECpk3JlMEFcz9Bygv/
         PVgbxjRcM6qSRSuiLrmTnk7wQgLLJhvyIGxR9GutX3nEnfqfypjuaBO/59oM8zbOPZUK
         Sr7r7KFI9BQtrRAFgqTWoPy7MNo1fSVI9IVdyIzTkw8bg+QuP0uv79yVjOqV1N0TKqce
         h5Vc/TTQ3SwdHazLkl8l7BePu+Fv+BgncGGOj7W/jKNZHPPpO4hlXUbSD+3LmGBKUDZB
         y79zK5P0ZrW6KFlL43EMeNm1OdP/53MCjCu+6g1oEoxwxKMBN28GTQZ6TLK6EfKdSa31
         Pn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608553; x=1784213353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ca30GWBimSiK84bMP03NLphqnI2ZnfW4HWnsucbkbvA=;
        b=CsmcPa+jxnorlEIPOF5I2EtxTauBOV78x5JSjdIBzjecISzZP6RzEYTO1JcZV0y5R8
         UEJA55qbFtAQevCPYN9+4KbUfVdYKVY1yLWrcMNwtFIY6gXYao6iYCpz41hnOLppq1qf
         pjEAqxAu2q5dPYEGQJsAVPva2xdrmre5KoKno4HK//OyIfzl/SIF14htti755PVgo1hM
         cTzS4onoLjq314AW5wz35DnXcf4KqdYcwmxeFOF29oQf14GTqbCMXpLzZvL0mD8dlGCT
         vyBqKEgQjFHLxsNqHjqk/ZSsk6X7ZqpBUrAPScVZS8xpUGRKLhzvEpVdELRvY2gtzGvB
         zsCg==
X-Forwarded-Encrypted: i=1; AHgh+RqkTXYjAFeiJrQLJ1qQKSFmxukhvVQmeKrSNh8mgo9ut9a3HLXA562arpy2jm1wjNYraxWMdHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+nSOo8JZq82eXbzj5MrxtQ4GGhm1qgvaT98romtGXnA/aAUId
	NMhE06AKHgTuVRWONMXUOMJhY+tV1Th/cVx0ynKdSlHEo9U6YXZqLspr
X-Gm-Gg: AfdE7ckf6gbQx+J4r4XBUB/sw56XmJl+ZyQR0yYi8PxPi/mKSl2wRAQS2jufc8Bkrnu
	4pqq7wBxzVegOgZ8h+S8nmJbnebRhJNjALwPiq3zFs5b/SS5zQsZRK6IZgWrm7QrM0B8D7Ip9In
	//s95wrIfYtlns2R65gEfi/3XPPWCTQoBqANYstJzEoa6GCOAMwAGo/EPzDAawbiZiBfohmX1Cx
	vfIkJpy8ygan1Xg5bQdLLc2Zkk5ud5/ri+Y+XFSa1XH7VCnNOjiyEGCt0effpAeWf1icOT67HY9
	KFr4/C/zy10cNH0Ujrx0U5jsemSmNtZrFNvhYUWOvh5TrTDu1eleWnQ+u3QW37ULWFJzR6FZtsD
	2/+6YwAORQ7SiCNRwdOHQZVa0cAeeBJZjhGBPnI5BlqrRPPi8p4vIsIh2Ui1bmuJa2OIdMrhdBC
	R6ZGnMs9mihFYMhELHfgStV8bXinx55wVfXLv7Pt8UbXagjP93EhbaXk2e8w==
X-Received: by 2002:a05:600c:4f8b:b0:493:bb4d:4dfe with SMTP id 5b1f17b1804b1-493e68ddce0mr78828435e9.23.1783608553221;
        Thu, 09 Jul 2026 07:49:13 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-493eb6d53absm64357595e9.6.2026.07.09.07.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:49:12 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	jordan@jrife.io,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org,
	sdf.kernel@gmail.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v11 1/5] bpf: add bpf_icmp_send kfunc
Date: Thu,  9 Jul 2026 14:48:56 +0000
Message-Id: <20260709144900.245904-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709144900.245904-1-mahe.tardy@gmail.com>
References: <20260709144900.245904-1-mahe.tardy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-306284-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:martin.lau@linux.dev,m:yonghong.song@linux.dev,m:emil@etsalapatis.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,m:sdf.kernel@gmail.com,m:mahe.tardy@gmail.com,m:johnfastabend@gmail.com,m:sdfkernel@gmail.com,m:mahetardy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,jrife.io,linux.dev,etsalapatis.com,vger.kernel.org,google.com,redhat.com,davemloft.net];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,etsalapatis.com:email,jrife.io:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E77E73276D

This is needed in the context of Tetragon to provide improved feedback
(in contrast to just dropping packets) to east-west traffic when blocked
by policies using cgroup_skb programs.

This reuses concepts from netfilter reject target codepath with the
differences that:
* Packets are cloned since the BPF user can still let the packet pass
  (SK_PASS from the cgroup_skb progs for example) and the current skb
  need to stay untouched (cgroup_skb hooks only allow read-only skb
  payload).
* We protect against recursion since the kfunc, by generating an ICMP
  error message, could retrigger the BPF prog that invoked it.

Only ICMP_DEST_UNREACH and ICMPV6_DEST_UNREACH are currently supported.
The interface accepts a type parameter to facilitate future extension to
other ICMP control message types.

For normal cgroup_skb paths, the skb dst route should already be set.
However, bpf_prog_test_run_skb can create synthetic IPv4/IPv6 skbs
without an attached route. In that case, icmp_send returns early, and
the kfunc would otherwise report success despite no ICMP reply being
sent. This check also reject metadata dsts, which are not valid struct
rtable instances. While IPv6 would stricly require only rejecting
metadata dsts, same check is applied for API consistency.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Jordan Rife <jordan@jrife.io>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/filter.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 4f5cbcac3e78..e4697036c67b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -84,6 +84,9 @@
 #include <linux/un.h>
 #include <net/xdp_sock_drv.h>
 #include <net/inet_dscp.h>
+#include <linux/icmpv6.h>
+#include <net/icmp.h>
+#include <net/ip6_route.h>

 #include "dev.h"

@@ -12548,6 +12551,83 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
 	return 0;
 }

+/**
+ * bpf_icmp_send - Send an ICMP control message
+ * @skb_ctx: Packet that triggered the control message
+ * @type: ICMP type (only ICMP_DEST_UNREACH/ICMPV6_DEST_UNREACH supported)
+ * @code: ICMP code (0-15 except ICMP_FRAG_NEEDED for IPv4, 0-6 for IPv6)
+ *
+ * Sends an ICMP control message in response to the packet. The original packet
+ * is cloned before sending the ICMP message, so the BPF program can still let
+ * the packet pass if desired.
+ *
+ * Currently only ICMP_DEST_UNREACH (IPv4) and ICMPV6_DEST_UNREACH (IPv6) are
+ * supported.
+ *
+ * Return: 0 on success (send attempt), negative error code on failure:
+ *         -EBUSY: Recursion detected
+ *         -EPROTONOSUPPORT: Non-IP protocol
+ *         -EOPNOTSUPP: Unsupported ICMP type
+ *         -EINVAL: Invalid code parameter
+ *         -ENETUNREACH: No usable route/dst for the ICMP reply
+ *         -ENOMEM: Memory allocation failed
+ */
+__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct sk_buff *nskb;
+	struct sock *sk;
+
+	sk = skb_to_full_sk(skb);
+	if (sk && sk->sk_kern_sock &&
+	    (sk->sk_protocol == IPPROTO_ICMP || sk->sk_protocol == IPPROTO_ICMPV6))
+		return -EBUSY;
+
+	if (!skb_valid_dst(skb))
+		return -ENETUNREACH;
+
+	switch (skb->protocol) {
+#if IS_ENABLED(CONFIG_INET)
+	case htons(ETH_P_IP): {
+		if (type != ICMP_DEST_UNREACH)
+			return -EOPNOTSUPP;
+		if (code < 0 || code > NR_ICMP_UNREACH ||
+		    code == ICMP_FRAG_NEEDED) /* needs a valid next-hop MTU */
+			return -EINVAL;
+
+		nskb = skb_clone(skb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+
+		memset(IPCB(nskb), 0, sizeof(*IPCB(nskb)));
+		icmp_send(nskb, type, code, 0);
+		consume_skb(nskb);
+		break;
+	}
+#endif
+#if IS_ENABLED(CONFIG_IPV6)
+	case htons(ETH_P_IPV6):
+		if (type != ICMPV6_DEST_UNREACH)
+			return -EOPNOTSUPP;
+		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
+			return -EINVAL;
+
+		nskb = skb_clone(skb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+
+		memset(IP6CB(nskb), 0, sizeof(*IP6CB(nskb)));
+		icmpv6_send(nskb, type, code, 0);
+		consume_skb(nskb);
+		break;
+#endif
+	default:
+		return -EPROTONOSUPPORT;
+	}
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();

 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12590,6 +12670,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)

+BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send)
+BTF_ID_FLAGS(func, bpf_icmp_send)
+BTF_KFUNCS_END(bpf_kfunc_check_set_icmp_send)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -12620,6 +12704,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
 	.set = &bpf_kfunc_check_set_sock_ops,
 };

+static const struct btf_kfunc_id_set bpf_kfunc_set_icmp_send = {
+	.owner = THIS_MODULE,
+	.set = &bpf_kfunc_check_set_icmp_send,
+};
+
 static int __init bpf_kfunc_init(void)
 {
 	int ret;
@@ -12641,6 +12730,7 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_icmp_send);
 	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
 }
 late_initcall(bpf_kfunc_init);
--
2.34.1


