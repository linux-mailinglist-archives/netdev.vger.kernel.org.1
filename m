Return-Path: <netdev+bounces-283633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LXBF1N392mEiAIAu9opvQ
	(envelope-from <netdev+bounces-283633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 18:26:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D77B4B6721
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 18:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0C0E30060B2
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE873CD8D0;
	Sun,  3 May 2026 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lacGE2xF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C13CBE84
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777825591; cv=none; b=ZtCgA0wRN8Ln+SbwATkPCFVCRB53vURAd0VjaF4RSMcvYtrYgjP2WQnaY7ziEQDPPb4R8NEOek9b/mO0F33Rz4K++GloxQrM2d+ZsxYt+0gtkFaIS5gie+KcYhrxXzocb2IoyMTjdtV7zJBkiXYL/BlWO5ZQ9L6yZO7jMFkkkLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777825591; c=relaxed/simple;
	bh=iWy4oAPkgs8cmIDV4jisE4x6QoSBLvsTaYWdsteovZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lbl9BdAABOXVuYDuPwGhJ2p55CxgsAjPgWsQNH3tOzD4ggAg4mJNi5Zv6Yh4/5ZYk9Bg9RTFQJyxtft+z0jjS5QEe+TXPpf/sWHWgppKXnvqu+6H/nxx9/Y91cEs4oPN9BUDdsPSEFhcoTBg4+y/0G/EZTo3Qzh2p2XMQMgcxPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lacGE2xF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f8b60e485so1561009b3a.0
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777825587; x=1778430387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1OXlDvR00KN5EgUZsriT8WnGpvoPbCTL1Vxu0+S0hc=;
        b=lacGE2xFykt6Xu7wbRjZDlNXdghNhKj1fJxnb2ATQUKvq8fZoqbVGcFO1CyoiDB2Mp
         bk+DSoNGMT3IfRIiL9l21UeJkP9N5zwQeaO4itxEFu7EHs6XdUnOgsU9fxAe7bWG4cVN
         SPTc0mEis0Vz9RDPuRNxhZ0BcQw+wfmIHiDiq9ELgQq8pG/tSvL3cBy5DOUr7t2KFmfY
         qS1+bHQpGOWmgb9e83BbriRt65dcDumJ42DuYmsUXtn4baU6xWush8rFKFxvICAzcqVH
         HXfHcLbURA5ill4+/9mPCmnmRo1691dvfE/8uwSJpjHhITL9KTm3wfz+9lrqZNv/tqET
         4LOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777825587; x=1778430387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M1OXlDvR00KN5EgUZsriT8WnGpvoPbCTL1Vxu0+S0hc=;
        b=ZSm0eKEqgWH0fzhVjDD1iZ+tCSkkX95hRNDNxy7sksDHTSIbnRyV/hP+68MHcpUqE8
         9qXqS2JD587IUuYXCQSIsfTQGdgyajahrmYUlP02fZviNR/IEG9X0Fq5gjmTYpLgFHcO
         oyfHXUMIZz9yS71aMwRTkK2DCWL8uPez3IZ+vz5xIIBwsE2jFD/h+YAO4+SRJvpDfW/M
         1oPbUlZ4Q+8kbBMaLAO/AJgNwDhZOtNbHwGkYuE+gJFhKoY07jgXSx/+JAveHZvxBOGQ
         ZC2VeQhxlXlAVXCljZA0VePVpok+QrCeT6+L4YsYOabMUBD/Ye8h0zl1yvlV3L6Z6+Q4
         y78Q==
X-Forwarded-Encrypted: i=1; AFNElJ84RzZfjUg6w7xxJv2gFa+K2GFLjotx7y+QcVWrtH+EAT8t5JWsJJOI2L3azqx26w3nAAWIFLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx02LsSAl1FyUTd4G+OvhyuFyaJ7dmYsrEP9kh/Bpz7k/Smy89f
	7ZHp4LFcrNyI4tz8XjtPRwKxWj8cwlekgwbUabYWBbPzWE5iEZEIHIdU
X-Gm-Gg: AeBDieuggiwjhaAxv2su5Scd05JwMRbwdJHS2GxHi1wbl4ZqmllxdDElbJ/4IhQuNZY
	AigDMYQO2kN6XzvLBFyzsJ0npVWVPFGmipIcfYULmpB7f7Mdmh8iPkfXeFgueT66ZyO6CW8xz6o
	kP+O+LMaaWQT076PnAWl6uXjfRvFmHZ1MTW5xaNQIFU2o/hBu259FQAuyODMCe9BrpR7rRNdM/5
	XFRLMEAfZ/pDpJwp7vhDf+YO8seFnrwgIoFqk8idJvJd9Li0MeSdtuDr1KD5J7OaSgknuOQ3mmr
	JGarhQTPXWuq/r90psOa6R0Bybe7qLfzSU2BG5HM9wk2Ui2HLpDbXk6BS4ycBUbPjQnjclhtttK
	WwsqtbL/0Q9bbPfiiJqIMzqdPPoqQZMBE+kUGATIqq/Hj730vG0+McikJsJeHAnN+/6wsYHXMxY
	A1I/Mw5qDfgEva+bnqBhehTixQMx0N2X5hooHwlzTAQg8Cgs5NA3YDzUY=
X-Received: by 2002:a05:6a00:ab89:b0:82c:9c47:fef9 with SMTP id d2e1a72fcca58-8352d02558fmr5675855b3a.2.1777825587264;
        Sun, 03 May 2026 09:26:27 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b8500dsm9788911b3a.58.2026.05.03.09.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 09:26:26 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Mon, 04 May 2026 01:25:58 +0900
Subject: [PATCH 5/7] seg6: add End.M.GTP6.D.Di behavior
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-srv6-mup-v1-v1-5-e0a6791575cb@gmail.com>
References: <20260504-srv6-mup-v1-v1-0-e0a6791575cb@gmail.com>
In-Reply-To: <20260504-srv6-mup-v1-v1-0-e0a6791575cb@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrea Mayer <andrea.mayer@uniroma2.it>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=23751;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=iWy4oAPkgs8cmIDV4jisE4x6QoSBLvsTaYWdsteovZQ=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBp93cix8Dun/ggRgtpWKfYXOpCMJZSSFkn9shdD
 6fBwOVcNbCJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCafd3IgAKCRAq19F1Kl0b
 TZp+D/4o9ogpouWVAJIA2sLXi0b6k6j1MumI00wR6qEElI0uNb1jr57hPt0gtvRZZwyZBpGS3Cd
 Zss+mUK6Xg7E2S9bMEbsnEsmWIPnzZqMPPlJ9uJjrXRCnCq78Xh6kg4FTm3MSez4hqJKMa/VvCe
 /llF8BMY72jEk1B2xeBSqDVSoGLybHarIfx+MmCmBV47k4dznu+cXVfN9DtAqvw+8e6iHQ/uG91
 sl7GZAdx7wSNBEfou68xRM6y/GsxLftrYMSR5Fd9/rv+lVABktV4/BUOnsFmT/FrCNHRuZddncX
 SOL+lUqLP0JEVSIk3QxwgRCQ5F5rXmKTzPpgTzD5RnNaos1rD8+9MrHFrJJdOY38MJQ7Pcbc1Hz
 +AcSK07Mx4WNH7LjPoJp6oyum/G4L0DAJk32vqpDZQzh/thFDUAwONESb0ytK8MBPtigkc8J3mu
 Qz53hOZyuGdJIXBGXRXjOmoJvegh+xsC0oZX1M2DXM397wbA7HdZILmiHwMPk0Iq/zdAVwOvcq9
 Zpwr9Hx6u6qj4bnZMNQhN0aIEjw+XsY/y9w0obEZ5lN2/msz/cRl+m+guqJ/ySKAMSLD/BY6hEp
 s+rfLh+VZFK9SWlWz6kuygLjJb1LJgPQGkre8DReIDUSw0w4nFiw3EpdpG2RxPgIIG4t8QdCmAw
 m27iZMfMksf+kHg==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Queue-Id: 8D77B4B6721
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283633-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.sh:url,srv6_end_m_gtp6_d_di_test.sh:url,rfc-editor.org:url]

Add the End.M.GTP6.D.Di drop-in mode variant of End.M.GTP6.D
(RFC 9433 Section 6.4).  Unlike End.M.GTP6.D, the drop-in variant
does NOT fold the GTP-U identifiers into Args.Mob.Session: the
original outer IPv6 destination is preserved at SRH[0] of the new
SRH, so the destination side can keep the original address
untouched while still benefiting from SR Policy steering.

The augmented SRH builder/destroyer is shared with End.M.GTP6.D.
The TEID and QFI parsed out of the inbound GTP-U header are
intentionally discarded for this variant (matching RFC 9433
Section 6.4).

When net.netfilter.nf_hooks_lwtunnel=1, the inner T-PDU traverses
NF_INET_PRE_ROUTING between the GTP-U strip and the SRv6 push,
mirroring End.DX4 / End.DX6.

Non-T-PDU GTP-U messages are forwarded the same way as in
End.M.GTP6.D: passed through via the lwtunnel's saved orig_input
to a downstream peer that owns the GTP-U control plane.

Configuration:

  ip -6 route add 2001:db8:f::/64 \
      encap seg6local action End.M.GTP6.D.Di \
          srh segs 2001:db8:2::e,2001:db8:3::e \
          src 2001:db8:2::1 \
      dev <dev>

Link: https://www.rfc-editor.org/rfc/rfc9433.html#section-6.4
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/uapi/linux/seg6_local.h                    |   2 +
 net/ipv6/seg6_local.c                              | 222 +++++++++++
 tools/testing/selftests/net/Makefile               |   1 +
 .../selftests/net/srv6_end_m_gtp6_d_di_test.sh     | 426 +++++++++++++++++++++
 4 files changed, 651 insertions(+)

diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
index 7d3d3d245b47..326da65ad5aa 100644
--- a/include/uapi/linux/seg6_local.h
+++ b/include/uapi/linux/seg6_local.h
@@ -80,6 +80,8 @@ enum {
 	SEG6_LOCAL_ACTION_END_M_GTP6_E	= 19,
 	/* IPv6/GTP-U decap into SRv6 (RFC 9433 Section 6.3) */
 	SEG6_LOCAL_ACTION_END_M_GTP6_D	= 20,
+	/* IPv6/GTP-U decap into SRv6, drop-in mode (RFC 9433 Section 6.4) */
+	SEG6_LOCAL_ACTION_END_M_GTP6_D_DI = 21,
 
 	__SEG6_LOCAL_ACTION_MAX,
 };
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 6ac4de529c08..cecf87cc84e5 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -2577,6 +2577,216 @@ static void seg6_end_m_gtp6_d_aug_destroy(struct seg6_local_lwt *slwt)
 	slwt->mobile_info.aug_srh = NULL;
 }
 
+/* Per-skb context preserved across the NF_INET_PRE_ROUTING hook on
+ * the inner T-PDU exposed by End.M.GTP6.D.Di.  Only the original
+ * outer DA is needed in the finish half (it is stamped into SRH[0]
+ * after seg6_do_srh_encap()).
+ */
+struct seg6_mobile_gtp6_d_di_cb {
+	struct in6_addr	orig_dst;
+};
+
+#define SEG6_MOBILE_GTP6_D_DI_CB(skb)	\
+	((struct seg6_mobile_gtp6_d_di_cb *)((skb)->cb))
+
+static int input_action_end_m_gtp6_d_di_finish(struct net *net,
+					       struct sock *sk,
+					       struct sk_buff *skb)
+{
+	struct seg6_mobile_gtp6_d_di_cb cb = *SEG6_MOBILE_GTP6_D_DI_CB(skb);
+	struct dst_entry *orig_dst = skb_dst(skb);
+	enum skb_drop_reason reason;
+	const struct seg6_mobile_info *minfo;
+	struct seg6_local_lwt *slwt;
+	struct ipv6_sr_hdr *new_srh;
+	int inner_proto;
+	int err;
+
+	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
+	minfo = &slwt->mobile_info;
+
+	inner_proto = (skb->protocol == htons(ETH_P_IP)) ? IPPROTO_IPIP
+							 : IPPROTO_IPV6;
+
+	err = seg6_do_srh_encap(skb, minfo->aug_srh, inner_proto);
+	if (err) {
+		reason = (err == -ENOMEM) ? SKB_DROP_REASON_SEG6_MOBILE_NOMEM
+					  : SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+
+	skb->protocol = htons(ETH_P_IPV6);
+
+	/* Stamp the prepended segments[0] (originally zeroed in
+	 * minfo->aug_srh) with the saved original outer DA, in the
+	 * in-skb SRH that seg6_do_srh_encap() just pushed.
+	 */
+	new_srh = (struct ipv6_sr_hdr *)(skb_network_header(skb) +
+					 sizeof(struct ipv6hdr));
+	new_srh->segments[0] = cb.orig_dst;
+
+	ipv6_hdr(skb)->saddr = minfo->src_addr;
+
+	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
+	nf_reset_ct(skb);
+	skb_dst_drop(skb);
+
+	seg6_lookup_any_nexthop(skb, NULL, 0, false, slwt->oif);
+	return dst_input(skb);
+
+drop:
+	kfree_skb_reason(skb, reason);
+	return -EINVAL;
+}
+
+/* RFC 9433 Section 6.4 -- End.M.GTP6.D.Di
+ * Drop-in interconnect variant of End.M.GTP6.D: instead of folding the
+ * GTP-U identifiers into Args.Mob.Session, the original outer IPv6 DA
+ * is preserved at SRH[0] so the destination side can keep the address
+ * untouched.
+ *
+ * When net.netfilter.nf_hooks_lwtunnel=1 the inner T-PDU is exposed
+ * to NF_INET_PRE_ROUTING after the GTP-U strip and before the SRv6
+ * push, identical to End.M.GTP6.D.
+ */
+static int input_action_end_m_gtp6_d_di(struct sk_buff *skb,
+					struct seg6_local_lwt *slwt)
+{
+	enum skb_drop_reason reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_GTPU;
+	unsigned int outer_len, inner_off;
+	int gtp_hdrlen, inner_proto, inner_nfproto;
+	struct in6_addr orig_dst;
+	struct ipv6_sr_hdr *srh;
+	struct ipv6hdr *ip6h;
+	struct udphdr *uh;
+	u32 teid;
+	u8 inner_first, qfi;
+
+	BUILD_BUG_ON(sizeof(struct seg6_mobile_gtp6_d_di_cb) >
+		     sizeof_field(struct sk_buff, cb));
+
+	srh = seg6_get_srh(skb, 0);
+	if (srh && srh->segments_left != 0) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_INVALID_SRH_SL;
+		goto drop;
+	}
+
+	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr))) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+
+	ip6h = ipv6_hdr(skb);
+	orig_dst = ip6h->daddr;
+
+	/* Same dispatch as End.M.GTP6.D (RFC 9433 Section 6.4 reuses
+	 * the S01-S11 logic from Section 6.3): GTP-U traffic is
+	 * decapsulated and re-encapsulated, anything else falls
+	 * through to End.
+	 */
+	{
+		__be16 frag_off;
+		u8 nh = ip6h->nexthdr;
+		int upper_off;
+
+		upper_off = ipv6_skip_exthdr(skb, sizeof(*ip6h), &nh,
+					     &frag_off);
+		if (upper_off < 0) {
+			/* Outer IPv6 ext-header walk failed; the GTP-U
+			 * envelope below it is unreachable.
+			 */
+			reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_GTPU;
+			goto drop;
+		}
+
+		if (nh != IPPROTO_UDP)
+			return input_action_end(skb, slwt);
+
+		if (!pskb_may_pull(skb, upper_off + sizeof(*uh))) {
+			reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_GTPU;
+			goto drop;
+		}
+
+		ip6h = ipv6_hdr(skb);
+		uh = (struct udphdr *)((u8 *)ip6h + upper_off);
+		if (uh->dest != htons(GTP1U_PORT))
+			return input_action_end(skb, slwt);
+
+		/* TEID/QFI are not consumed by the drop-in variant
+		 * (RFC 9433 Section 6.4); seg6_mobile_parse_gtpu() is
+		 * still required to compute the GTP-U header length so
+		 * the outer chain (IPv6+UDP+GTP) can be popped correctly.
+		 */
+		gtp_hdrlen = seg6_mobile_parse_gtpu(skb,
+						    upper_off + sizeof(*uh),
+						    &teid, &qfi);
+		if (gtp_hdrlen == -EOPNOTSUPP)
+			return seg6_mobile_passthrough_non_tpdu(skb);
+		if (gtp_hdrlen < 0) {
+			reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_GTPU;
+			goto drop;
+		}
+		(void)teid;
+		(void)qfi;
+
+		outer_len = upper_off + sizeof(*uh) + gtp_hdrlen;
+	}
+
+	if (!pskb_may_pull(skb, outer_len + 1)) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+
+	inner_off = outer_len;
+	inner_first = *((u8 *)skb->data + inner_off);
+	switch (inner_first >> 4) {
+	case 4:
+		inner_proto = IPPROTO_IPIP;
+		inner_nfproto = NFPROTO_IPV4;
+		break;
+	case 6:
+		inner_proto = IPPROTO_IPV6;
+		inner_nfproto = NFPROTO_IPV6;
+		break;
+	default:
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+
+	if (!pskb_may_pull(skb, outer_len +
+			   ((inner_proto == IPPROTO_IPIP) ?
+			    sizeof(struct iphdr) : sizeof(struct ipv6hdr)))) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+
+	skb_pull_rcsum(skb, outer_len);
+	skb_reset_network_header(skb);
+
+	skb->protocol = (inner_proto == IPPROTO_IPIP) ? htons(ETH_P_IP)
+						      : htons(ETH_P_IPV6);
+
+	skb_set_transport_header(skb,
+				 (inner_proto == IPPROTO_IPIP) ?
+				 sizeof(struct iphdr) :
+				 sizeof(struct ipv6hdr));
+	nf_reset_ct(skb);
+
+	SEG6_MOBILE_GTP6_D_DI_CB(skb)->orig_dst = orig_dst;
+
+	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
+		return NF_HOOK(inner_nfproto, NF_INET_PRE_ROUTING,
+			       dev_net(skb->dev), NULL, skb, skb->dev,
+			       NULL, input_action_end_m_gtp6_d_di_finish);
+
+	return input_action_end_m_gtp6_d_di_finish(dev_net(skb->dev), NULL,
+						   skb);
+
+drop:
+	kfree_skb_reason(skb, reason);
+	return -EINVAL;
+}
+
 /* RFC 9433 Section 6.5 -- End.M.GTP6.E
  * Receives an SRv6 packet whose current SID is an End.M.GTP6.E SID
  * (Segments Left == 1) and re-encapsulates the inner payload in
@@ -2920,6 +3130,18 @@ static struct seg6_action_desc seg6_action_table[] = {
 			.destroy_state = seg6_end_m_gtp6_d_aug_destroy,
 		},
 	},
+	{
+		.action		= SEG6_LOCAL_ACTION_END_M_GTP6_D_DI,
+		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_SRH)		     |
+				  SEG6_F_ATTR(SEG6_LOCAL_MOBILE_SRC_ADDR),
+		.optattrs	= SEG6_F_LOCAL_COUNTERS |
+				  SEG6_F_ATTR(SEG6_LOCAL_OIF),
+		.input		= input_action_end_m_gtp6_d_di,
+		.slwt_ops	= {
+			.build_state = seg6_end_m_gtp6_d_aug_build,
+			.destroy_state = seg6_end_m_gtp6_d_aug_destroy,
+		},
+	},
 	{
 		.action		= SEG6_LOCAL_ACTION_END_MAP,
 		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_NH6),
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 70cec00aebdb..ad1e2ff3842f 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -84,6 +84,7 @@ TEST_PROGS := \
 	sctp_vrf.sh \
 	skf_net_off.sh \
 	so_txtime.sh \
+	srv6_end_m_gtp6_d_di_test.sh \
 	srv6_end_m_gtp6_d_test.sh \
 	srv6_end_m_gtp6_e_test.sh \
 	srv6_end_m_gtp4_e_test.sh \
diff --git a/tools/testing/selftests/net/srv6_end_m_gtp6_d_di_test.sh b/tools/testing/selftests/net/srv6_end_m_gtp6_d_di_test.sh
new file mode 100755
index 000000000000..e2101501e866
--- /dev/null
+++ b/tools/testing/selftests/net/srv6_end_m_gtp6_d_di_test.sh
@@ -0,0 +1,426 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Selftest for the SRv6 End.M.GTP6.D.Di drop-in behavior
+# (RFC 9433 Section 6.4).
+#
+# Topology mirrors srv6_end_m_gtp6_d_test.sh.  The key difference is
+# that the End.M.GTP6.D.Di action preserves the original outer IPv6
+# destination address (here 2001:db8:f::dead) as the final SRH segment,
+# rather than folding GTP-U identifiers into Args.Mob.Session.
+
+source lib.sh
+
+readonly TIMEOUT=4
+
+tcpdump_pid=""
+have_vrf=0
+
+cleanup()
+{
+	if [ -n "$tcpdump_pid" ]; then
+		kill "$tcpdump_pid" 2>/dev/null
+		wait "$tcpdump_pid" 2>/dev/null
+	fi
+	cleanup_all_ns
+}
+
+trap cleanup EXIT
+
+setup()
+{
+	setup_ns gnb srgw srupf lupf srupf_vrf
+
+	ip -n "$gnb" link set lo up
+	ip -n "$srgw" link set lo up
+	ip -n "$srupf" link set lo up
+	ip -n "$lupf" link set lo up
+	ip -n "$srupf_vrf" link set lo up
+
+	ip link add veth-n3 netns "$gnb" type veth peer name veth-n3-srgw \
+		netns "$srgw"
+	ip -n "$gnb" addr add 2001:db8:1::2/64 dev veth-n3 nodad
+	ip -n "$srgw" addr add 2001:db8:1::1/64 dev veth-n3-srgw nodad
+	ip -n "$gnb" link set veth-n3 up
+	ip -n "$srgw" link set veth-n3-srgw up
+
+	# srgw <-> srupf  (SR-aware UPF, T-PDU SRv6 destination)
+	ip link add veth-n9 netns "$srgw" type veth peer name veth-n9-srupf \
+		netns "$srupf"
+	ip -n "$srgw" addr add 2001:db8:2::1/64 dev veth-n9 nodad
+	ip -n "$srupf" addr add 2001:db8:2::e/64 dev veth-n9-srupf nodad
+	ip -n "$srgw" link set veth-n9 up
+	ip -n "$srupf" link set veth-n9-srupf up
+
+	# srgw <-> lupf  (legacy UPF, GTP-U control plane recipient)
+	ip link add veth-n6 netns "$srgw" type veth peer name veth-n6-lupf \
+		netns "$lupf"
+	ip -n "$srgw" addr add 2001:db8:6::1/64 dev veth-n6 nodad
+	ip -n "$lupf" addr add 2001:db8:6::e/64 dev veth-n6-lupf nodad
+	ip -n "$srgw" link set veth-n6 up
+	ip -n "$lupf" link set veth-n6-lupf up
+
+	ip netns exec "$srgw" sysctl -wq net.ipv6.conf.all.forwarding=1
+
+	local srupf_mac srgw_n9_mac lupf_mac
+	srupf_mac=$(ip -n "$srupf" -j link show veth-n9-srupf | \
+		python3 -c 'import sys, json; print(json.load(sys.stdin)[0]["address"])')
+	srgw_n9_mac=$(ip -n "$srgw" -j link show veth-n9 | \
+		python3 -c 'import sys, json; print(json.load(sys.stdin)[0]["address"])')
+	lupf_mac=$(ip -n "$lupf" -j link show veth-n6-lupf | \
+		python3 -c 'import sys, json; print(json.load(sys.stdin)[0]["address"])')
+	ip -n "$srgw" -6 neigh replace 2001:db8:2::e dev veth-n9 \
+		lladdr "$srupf_mac" nud permanent 2>/dev/null || true
+	ip -n "$srupf" -6 neigh replace 2001:db8:2::1 dev veth-n9-srupf \
+		lladdr "$srgw_n9_mac" nud permanent 2>/dev/null || true
+	# Non-T-PDU passthrough: pre-resolve the Echo Request DA so the
+	# srgw can hand the packet off to the legacy upf via veth-n6.
+	ip -n "$srgw" -6 neigh replace 2001:db8:f::dead dev veth-n6 \
+		lladdr "$lupf_mac" nud permanent 2>/dev/null || true
+
+	ip -n "$gnb" -6 route add 2001:db8:f::/64 via 2001:db8:1::1
+
+	# dev veth-n6 is the legacy UPF leg for non-T-PDU passthrough; T-PDU
+	# encap takes the IPv6 SR Policy path via a separate FIB lookup.
+	ip -n "$srgw" -6 route add 2001:db8:f::/64 \
+		encap seg6local action End.M.GTP6.D.Di \
+			srh segs 2001:db8:2::e,2001:db8:3::e \
+			src 2001:db8:2::1 \
+		dev veth-n6
+
+	ip -n "$srupf" -6 route add 2001:db8:3::/64 dev veth-n9-srupf
+
+	# Per-route VRF case: a second SR-side upf in its own VRF.  The
+	# End.M.GTP6.D.Di SID for this tenant binds the SRv6 underlay output
+	# to the VRF via 'oif'.  Reported as [SKIP] when CONFIG_NET_VRF is not loaded.
+	modprobe vrf 2>/dev/null
+	if ip -n "$srgw" link add vrf-n9 type vrf table 100 2>/dev/null; then
+		have_vrf=1
+		ip -n "$srgw" link set dev vrf-n9 up
+
+		ip link add veth-n9-2 netns "$srgw" type veth peer name \
+			veth-n9-2-srupf netns "$srupf_vrf"
+		ip -n "$srgw" link set dev veth-n9-2 master vrf-n9
+		ip -n "$srgw" addr add 2001:db8:4::1/64 dev veth-n9-2 nodad
+		ip -n "$srupf_vrf" addr add 2001:db8:4::e/64 dev veth-n9-2-srupf \
+			nodad
+		ip -n "$srgw" link set dev veth-n9-2 up
+		ip -n "$srupf_vrf" link set dev veth-n9-2-srupf up
+
+		local upf_vrf_mac srgw_e2_mac
+		upf_vrf_mac=$(ip -n "$srupf_vrf" -j link show \
+			veth-n9-2-srupf | python3 -c \
+			'import sys, json; print(json.load(sys.stdin)[0]["address"])')
+		srgw_e2_mac=$(ip -n "$srgw" -j link show veth-n9-2 | \
+			python3 -c \
+			'import sys, json; print(json.load(sys.stdin)[0]["address"])')
+		ip -n "$srgw" -6 neigh replace 2001:db8:4::e dev veth-n9-2 \
+			lladdr "$upf_vrf_mac" nud permanent 2>/dev/null || true
+		ip -n "$srupf_vrf" -6 neigh replace 2001:db8:4::1 \
+			dev veth-n9-2-srupf lladdr "$srgw_e2_mac" nud permanent \
+			2>/dev/null || true
+
+		ip -n "$gnb" -6 route add 2001:db8:f0::/64 via 2001:db8:1::1
+
+		ip -n "$srgw" -6 route add 2001:db8:f0::/64 \
+			encap seg6local action End.M.GTP6.D.Di \
+				srh segs 2001:db8:4::e,2001:db8:5::e \
+				src 2001:db8:4::1 oif vrf-n9 \
+			dev veth-n9-2
+
+		ip -n "$srupf_vrf" -6 route add 2001:db8:5::/64 \
+			dev veth-n9-2-srupf
+	fi
+}
+
+check_dependencies()
+{
+	if ! command -v tcpdump >/dev/null; then
+		echo "SKIP: tcpdump is required"; exit "$ksft_skip"
+	fi
+	if ! command -v python3 >/dev/null; then
+		echo "SKIP: python3 is required"; exit "$ksft_skip"
+	fi
+	if ! python3 -c "import scapy.all" 2>/dev/null; then
+		echo "SKIP: python3-scapy is required"; exit "$ksft_skip"
+	fi
+
+	if ! ip route help 2>&1 | grep -qF "End.M.GTP6.D.Di"; then
+		echo "SKIP: iproute2 too old, missing seg6local action End.M.GTP6.D.Di"
+		exit "$ksft_skip"
+	fi
+}
+
+send_gtpu()
+{
+	local outer_dst="$1"
+	local srgw_mac
+
+	srgw_mac=$(ip -n "$srgw" -j link show veth-n3-srgw | \
+		python3 -c 'import sys, json; print(json.load(sys.stdin)[0]["address"])')
+
+	SRGW_MAC="$srgw_mac" OUTER_DST="$outer_dst" \
+		ip netns exec "$gnb" python3 - <<'PY'
+import os
+from scapy.all import IPv6, UDP, IP, ICMP, sendp, Ether
+mac = os.environ['SRGW_MAC']
+outer_dst = os.environ['OUTER_DST']
+gtpu = bytes.fromhex(
+    "34 ff 00 24 00 00 01 23 00 00 00 85"
+    "01 00 05 00")
+inner = bytes(IP(src='10.0.0.1', dst='10.0.0.2') / ICMP())
+pkt = (Ether(dst=mac) /
+       IPv6(src='2001:db8:1::2', dst=outer_dst) /
+       UDP(sport=2152, dport=2152) /
+       (gtpu + inner))
+sendp(pkt, iface='veth-n3', verbose=False)
+PY
+}
+
+send_gtpu_echo()
+{
+	local outer_dst="$1"
+	local srgw_mac
+
+	srgw_mac=$(ip -n "$srgw" -j link show veth-n3-srgw | \
+		python3 -c 'import sys, json; print(json.load(sys.stdin)[0]["address"])')
+
+	SRGW_MAC="$srgw_mac" OUTER_DST="$outer_dst" \
+		ip netns exec "$gnb" python3 - <<'PY'
+import os
+from scapy.all import IPv6, UDP, sendp, Ether
+mac = os.environ['SRGW_MAC']
+outer_dst = os.environ['OUTER_DST']
+gtpu_echo = bytes.fromhex("32 01 00 04 00 00 00 00 42 42 00 00")
+pkt = (Ether(dst=mac) /
+       IPv6(src='2001:db8:1::2', dst=outer_dst) /
+       UDP(sport=2152, dport=2152) /
+       gtpu_echo)
+sendp(pkt, iface='veth-n3', verbose=False)
+PY
+}
+
+run_echo_test()
+{
+	local outer_dst="$1"
+	local out
+	local rc
+
+	out=$(mktemp)
+
+	ip netns exec "$lupf" tcpdump -U -nni veth-n6-lupf -w "$out" \
+		'udp port 2152' 2>/dev/null &
+	tcpdump_pid=$!
+	sleep 1
+
+	send_gtpu_echo "$outer_dst"
+
+	sleep 1
+	kill -INT "$tcpdump_pid" 2>/dev/null
+	wait "$tcpdump_pid" 2>/dev/null
+	tcpdump_pid=""
+
+	OUTER_DST="$outer_dst" python3 - "$out" <<'PYEOF'
+import os, sys
+from scapy.all import rdpcap, IPv6, UDP
+
+want_dst = os.environ['OUTER_DST']
+pkts = rdpcap(sys.argv[1])
+for p in pkts:
+    if IPv6 not in p or UDP not in p:
+        continue
+    if p[UDP].sport != 2152 or p[UDP].dport != 2152:
+        continue
+    if p[IPv6].dst != want_dst:
+        continue
+    payload = bytes(p[UDP].payload)
+    if len(payload) >= 2 and payload[1] == 0x01:
+        sys.exit(0)
+sys.exit("no GTPv1-U Echo Request observed at lupf "
+         "(End.M.GTP6.D.Di failed to pass non-T-PDU through)")
+PYEOF
+	rc=$?
+	rm -f "$out"
+	return $rc
+}
+
+capture_traffic()
+{
+	local capture_ns="$1"
+	local capture_iface="$2"
+	local outer_dst="$3"
+	local out="$4"
+
+	ip netns exec "$capture_ns" tcpdump -U -nni "$capture_iface" -w "$out" \
+		'ip6' 2>/dev/null &
+	tcpdump_pid=$!
+	# Give tcpdump a brief moment to attach the BPF filter.
+	sleep 1
+
+	send_gtpu "$outer_dst"
+
+	sleep 1
+	kill -INT "$tcpdump_pid" 2>/dev/null
+	wait "$tcpdump_pid" 2>/dev/null
+	tcpdump_pid=""
+}
+
+run_test()
+{
+	local outer_dst="$1"			# GTP-U outer IPv6 DA
+	local capture_ns="${2:-$srupf}"	# netns where SRv6 should land
+	local capture_iface="${3:-veth-n9-srupf}"
+	local out
+
+	out=$(mktemp)
+	capture_traffic "$capture_ns" "$capture_iface" "$outer_dst" "$out"
+
+	# scapy field check: an SRv6 (RT6 type=4) packet must reach upf
+	# and one of the SRH segments must contain the original outer DA
+	# (preserved by the drop-in variant).
+	OUTER_DST="$outer_dst" python3 - "$out" <<'PYEOF'
+import os, sys
+from scapy.all import rdpcap, IPv6, IPv6ExtHdrSegmentRouting
+
+outer_dst = os.environ['OUTER_DST'].lower()
+pkts = rdpcap(sys.argv[1])
+for p in pkts:
+    if not (IPv6 in p and IPv6ExtHdrSegmentRouting in p):
+        continue
+    srh = p[IPv6ExtHdrSegmentRouting]
+    if srh.type != 4:
+        continue
+    addrs = [str(a).lower() for a in srh.addresses]
+    if outer_dst in addrs:
+        sys.exit(0)
+    sys.exit(f"original DA not in SRH segments: {addrs}")
+sys.exit("no SRv6 (RT6 type=4) packet observed")
+PYEOF
+	local rc=$?
+	rm -f "$out"
+	return $rc
+}
+
+# Verify that nf_hooks_lwtunnel=1 makes the inner T-PDU 5-tuple
+# visible to nftables on the SR Gateway.  The nft rule matches on the
+# inner IPv4 source address (10.0.0.1, set by send_gtpu()); a DROP
+# verdict must prevent any SRv6 packet from reaching the upf, an
+# ACCEPT verdict must let it through unchanged.
+run_nf_test()
+{
+	local verdict="$1"		# drop | accept
+	local expect_da="$2"	# preserved-DA address, empty when no packet expected
+	local outer_dst="2001:db8:f::dead"
+	local out
+
+	ip netns exec "$srgw" nft flush chain ip filter prerouting
+	ip netns exec "$srgw" nft add rule ip filter prerouting \
+		ip saddr 10.0.0.1 "$verdict"
+
+	out=$(mktemp)
+	capture_traffic "$srupf" "veth-n9-srupf" "$outer_dst" "$out"
+
+	if [ -n "$expect_da" ]; then
+		OUTER_DST="$expect_da" python3 - "$out" <<'PYEOF'
+import os, sys
+from scapy.all import rdpcap, IPv6, IPv6ExtHdrSegmentRouting
+
+outer_dst = os.environ['OUTER_DST'].lower()
+pkts = rdpcap(sys.argv[1])
+for p in pkts:
+    if not (IPv6 in p and IPv6ExtHdrSegmentRouting in p):
+        continue
+    srh = p[IPv6ExtHdrSegmentRouting]
+    addrs = [str(a).lower() for a in srh.addresses]
+    if outer_dst in addrs:
+        sys.exit(0)
+sys.exit("expected SRv6 packet not observed at upf despite nft accept")
+PYEOF
+	else
+		python3 - "$out" <<'PYEOF'
+import sys
+from scapy.all import rdpcap, IPv6, IPv6ExtHdrSegmentRouting
+
+pkts = rdpcap(sys.argv[1])
+for p in pkts:
+    if IPv6 in p and IPv6ExtHdrSegmentRouting in p:
+        sys.exit("SRv6 packet leaked to upf despite nft drop on inner")
+sys.exit(0)
+PYEOF
+	fi
+	local rc=$?
+	rm -f "$out"
+	return $rc
+}
+
+main()
+{
+	local rc=0
+
+	check_dependencies
+	setup
+
+	if run_test "2001:db8:f::dead"; then
+		echo "TEST: End.M.GTP6.D.Di (default) [PASS]"
+	else
+		echo "TEST: End.M.GTP6.D.Di (default) [FAIL]"
+		rc=1
+	fi
+
+	if run_echo_test "2001:db8:f::dead"; then
+		echo "TEST: End.M.GTP6.D.Di (non-T-PDU passthrough) [PASS]"
+	else
+		echo "TEST: End.M.GTP6.D.Di (non-T-PDU passthrough) [FAIL]"
+		rc=1
+	fi
+
+	# VRF binding: SRv6 underlay output goes through vrf-n9 (table 100).
+	# Reported as [SKIP] when CONFIG_NET_VRF is not loaded.
+	if [ "$have_vrf" = "1" ]; then
+		if run_test "2001:db8:f0::dead" "$srupf_vrf" "veth-n9-2-srupf"; then
+			echo "TEST: End.M.GTP6.D.Di (oif vrf-n9) [PASS]"
+		else
+			echo "TEST: End.M.GTP6.D.Di (oif vrf-n9) [FAIL]"
+			rc=1
+		fi
+	else
+		echo "TEST: End.M.GTP6.D.Di (oif vrf-n9) [SKIP] (CONFIG_NET_VRF not loaded)"
+	fi
+
+	# Inner T-PDU netfilter hook: only meaningful when nft is present
+	# and the kernel exposes net.netfilter.nf_hooks_lwtunnel.
+	if command -v nft >/dev/null && \
+	   ip netns exec "$srgw" sysctl -wq \
+		net.netfilter.nf_hooks_lwtunnel=1 2>/dev/null; then
+		ip netns exec "$srgw" nft add table ip filter
+		ip netns exec "$srgw" nft \
+			'add chain ip filter prerouting { type filter hook prerouting priority 0; }'
+
+		if run_nf_test drop ""; then
+			echo "TEST: End.M.GTP6.D.Di (nft drop on inner) [PASS]"
+		else
+			echo "TEST: End.M.GTP6.D.Di (nft drop on inner) [FAIL]"
+			rc=1
+		fi
+
+		if run_nf_test accept "2001:db8:f::dead"; then
+			echo "TEST: End.M.GTP6.D.Di (nft accept on inner) [PASS]"
+		else
+			echo "TEST: End.M.GTP6.D.Di (nft accept on inner) [FAIL]"
+			rc=1
+		fi
+	else
+		echo "TEST: End.M.GTP6.D.Di (inner-flow netfilter hook) [SKIP]" \
+		     "(nft or nf_hooks_lwtunnel unavailable)"
+	fi
+
+	if [ "$rc" -eq 0 ]; then
+		echo "TEST: End.M.GTP6.D.Di [PASS]"
+		exit "$ksft_pass"
+	else
+		echo "TEST: End.M.GTP6.D.Di [FAIL]"
+		exit "$ksft_fail"
+	fi
+}
+
+main "$@"

-- 
2.50.1


