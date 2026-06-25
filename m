Return-Path: <netdev+bounces-301939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8OsxEA0LPWpEwQgAu9opvQ
	(envelope-from <netdev+bounces-301939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 13:03:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ECC6C4F21
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 13:03:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mimX07OL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301939-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301939-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 765B03001D79
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4995D3AC0D3;
	Thu, 25 Jun 2026 11:03:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCCE3AEF23
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 11:03:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385414; cv=none; b=c/jHZDwLBQ4iVp/Mr8Awx8j07/o34/YakDJE3iJUCkp2IGQdA6DWj2jiDGqBpaNa5k+fphAALIOFwk20X9ZNcBGoJFjp4mx8elANJIGC2QGL379EzFoT3jWsRDgzsZHXKySj+atQzerr4bwbWaqAG7n/keiZV6Wy46WoUSzKLxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385414; c=relaxed/simple;
	bh=pGrPvigNQomTZg+yIiWmTRGVWTpeIzulMWGMercaVgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JHmwtZXumJJ0Xkr/l+c7l09lERoqGYQLZ/kxAa/OMNF0j+HxWVkVpH+Pa8ecUVaDdCqcWzgn/BVGZ8UYSafyZORpfEW6mCLrc6Vw4hhMhC8OWAIdlwx2VAuEjZNhG4KXJXA2QHVZGE9kYlHBI/OMXn1/eS8Wh1FXJlssAJHdkyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mimX07OL; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49241896317so9643585e9.3
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 04:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782385409; x=1782990209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rinWcAerH3qNMotm0IPYw3JUA24H1mMr9Uz3XuEExc=;
        b=mimX07OL+2Jzk//KcbM4fSAH5VfBuGmvUpAaw34MlSYuUfPe0SHjSCnq0vEgggoNzx
         YEIwM7SDyogtBtNoc0qFaKT0yiBSPDuWSpENZE9NhBl5Wy45Fyp/b7MVPGWXilONc0Vo
         FoiLkPJo+HOP8qEVWEWdbHTfD8yUhkewQh5sBMbvQ1v+nPMWspEDxfZg6SoqwhL94lAm
         6iLjRY8xElUmHiYUHO4lmyFgiCwqri8ZH/Ylf6+QJ26jAYJcJNp5eyNTIx2GAS/Qi02y
         e8CXtVDUD54kIiILnlQxw/QeVA3LCr7TA9fKq5wQxxoP+tiIYY6Z9Nz0LzOA0G4+X6Yx
         ycZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782385409; x=1782990209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6rinWcAerH3qNMotm0IPYw3JUA24H1mMr9Uz3XuEExc=;
        b=iKFhgAwIoOlP0hBg5wxxm59Y487FsjEMsHaZR+voiCUVPkYU1brfoYKdeB+oaEPJBQ
         6NS8MtF/V+nsB3hotAfCATRfY2DW3pYH4V5QpRpqc6jHAxe99ykerFqArm+zlvB51LvT
         UX4bL7ACqfdNIM/elCWj0S+LMvka+l9KAchyoE8FO6BRF4qy53WKJVtnCGTYqoV+qolQ
         Lm+XJhR9LZVqNFcqZSF6NB1WeX7xJMeQkWK1H8DTNmTupzKwTaRWMt9eL1G8cU8ZVerG
         i17MSMhGa8EUUv5ESoCoKV5HXZZpz/IrKdNKBZErFfqfJaDn6SdohbDiaLKFE4gUYfH4
         ucaA==
X-Forwarded-Encrypted: i=1; AFNElJ+Lnarv8cHlM3eFjmUuUIlfk6rMa8K5S3hZu7fHaK7e1aV22MRxpd0cOFi0u+f9yHz4+7oIOZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzySs16Z9lXAFrdI34rOhtA2025qA1xsP+aMNDd/c4rVYlIOxnV
	8sdaZrnXkDdWPPO/PeaEp81W4Rdxznx29dhgMjfkwPTxAd3bHpL1uUBo
X-Gm-Gg: AfdE7cnETK98KsPfFeYeJSUCLx7cW95bybUqhU9CQEbnA4AT2CX5w/JRrIvNk4MWw4J
	/kX5uz5IrNpkqCohNKbunFZB07xkj5/AbGP95RERpTGabc3cyzEqIVwDe6n+xE+963b/XLxe7Tw
	7sG3nM+6vGgbzgSM2J8h1F9CLDS/910eZdvMstTNhx8ggzBBI6HLUviQD5+eKNKaCraRoOq+cir
	3QmE7OM/rpSWxs7bPZAS4x6ZM3OIudq/Wi/7hSaqfZMMf9vpdnAe/yu9FuoKtOtkhaDL/E3gbmD
	aNubKv/9Ym1xNKhZwP6/OxBrjotkmnqShFm7jmvmKrT3n5HABzElqmVjpczbkquyzz0xqfmp3Hz
	LB1I0b9WUtlH/jumvn79myawUdOR7Q/L+tdSfEtc1gabRLyEqyTlCG+k8Q5o4hqvgfhCG7OkR8A
	CSs97ud4HeS7hdbZr4
X-Received: by 2002:a05:600c:4747:b0:492:40f4:9fab with SMTP id 5b1f17b1804b1-49266889b4amr26167985e9.29.1782385408815;
        Thu, 25 Jun 2026 04:03:28 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-46c9ed7491esm11071917f8f.37.2026.06.25.04.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:03:28 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v10 1/5] bpf: add bpf_icmp_send kfunc
Date: Thu, 25 Jun 2026 11:03:17 +0000
Message-Id: <20260625110321.28236-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625110321.28236-1-mahe.tardy@gmail.com>
References: <20260625110321.28236-1-mahe.tardy@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-301939-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:martin.lau@linux.dev,m:yonghong.song@linux.dev,m:emil@etsalapatis.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,m:mahe.tardy@gmail.com,m:johnfastabend@gmail.com,m:mahetardy@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,etsalapatis.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05ECC6C4F21

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
However, bpf_prog_test_run_skb can create synthetic IPv4 skbs without an
attached route. In that case, icmp_send returns early, and the kfunc
would otherwise report success despite no ICMP reply being sent. The
check also rejects metadata dsts, which are not valid struct rtable
instances. For IPv6, reject metadata dsts only: icmpv6_send can reach
icmp6_dev, where skb_rt6_info treats any non-NULL skb dst as a struct
rt6_info, which is not valid for metadata_dst.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Jordan Rife <jordan@jrife.io>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/filter.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2e96b4b847ce..0a0191586b44 100644
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

@@ -12546,6 +12549,88 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
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
+	switch (skb->protocol) {
+#if IS_ENABLED(CONFIG_INET)
+	case htons(ETH_P_IP): {
+		if (type != ICMP_DEST_UNREACH)
+			return -EOPNOTSUPP;
+		if (code < 0 || code > NR_ICMP_UNREACH ||
+		    code == ICMP_FRAG_NEEDED) /* needs a valid next-hop MTU */
+			return -EINVAL;
+
+		/* icmp_send expects skb_dst to be a real rtable. */
+		if (!skb_valid_dst(skb))
+			return -ENETUNREACH;
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
+		/* icmpv6_send may treat skb_dst as rt6_info. */
+		if (skb_metadata_dst(skb))
+			return -ENETUNREACH;
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
@@ -12588,6 +12673,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)

+BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send)
+BTF_ID_FLAGS(func, bpf_icmp_send)
+BTF_KFUNCS_END(bpf_kfunc_check_set_icmp_send)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -12618,6 +12707,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
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
@@ -12639,6 +12733,7 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_icmp_send);
 	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
 }
 late_initcall(bpf_kfunc_init);
--
2.34.1


