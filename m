Return-Path: <netdev+bounces-260001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EL4CUQ5nGlCBgQAu9opvQ
	(envelope-from <netdev+bounces-260001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:25:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C291757B5
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A27ED3003EEA
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AD134D90E;
	Mon, 23 Feb 2026 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="emLW9sKd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2AF35CB8B
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845821; cv=none; b=Q+26EJjOQjSpdwKh/cs4uvHd7J9feCmCq1Ivut4RQTfDJOSdLnVva49FxT83uDUZ5M2G2Oy3wEOBJ6Qm4qIvsuEjxEGVWW9+8ELTiwLW6ZwJZ7NXIrUeY/aaO1HWvoJWEZzJKiFhci5xZscleiqYBmvXsUFtI7ZBlgPrk2K5yzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845821; c=relaxed/simple;
	bh=lvTW1+OHeoqBwGRfC687Y/+rOdge+5sxdrNLssMANaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nVGX0b5wHs8Cf+o3YMa4VzJVkbxq80RLGkmZ4F212kEH1Snme7qt6lBGz5BPpzcFg2jaUW0F5cRwNuruDwSi1lDX569+hOVROwWTL6Sp+MIDoeA424zTt/ldom90ynEVP1KqPtYwskg6vn9bSFgMEzWHblamB1UGfK/oEuqBF2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=emLW9sKd; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-5675a558da2so119313e0c.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 03:23:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845819; x=1772450619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCb3mGAPKai1Hpobl7lKadHZ3M3yFOIt6q/w7eisnl8=;
        b=Zy1/eq06unFB8OPkAPRSr6GNakpYHysiH05adnHnkJTcscOoSnVJuOmwhE1q8ht/7M
         H2WZ2xvKT1Zx8yOfbW7b5q2Vf/pNttibJpZYcQt46+H1m7QbsEVZm48Z4p3O3+dstRQj
         VB/Uid3PYyqZpD2IzNTlH1PXgj5hO76p/pPSwYdnlcmgk7M+EqSyl7yGNN+yzk+lWyjY
         R1Z1x59X+P/o52pjGHyXQn1DOijEkxQzCnks/QRx7oNk02VKtxwz8GrWfEXW50V3qwQr
         qAcl5TkIV4Es3e1QqqDXfoT1Z68qAOhO/TmtjEFh1lQnuwa2gXu1MpdJz2YY/TYPECoT
         2XMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgxfU6vp24/AHzuEs+tch3DSczo4WGtJyDzrZZzZ2HN2pbodQIc5i/ETCWCiigd/y/09sUHL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3YUPL1BGsS2OXlrVrfsobDlShZ1xGnS9gipzCiNGciFGBcHWk
	j+NAwCPq4MLEiDf4b9wzr0SAEEqCZ9/ybGW2+w953Wr17UDFfWVaBUhQW7IOGEazn+dTtixn+9e
	csioY1nlpHDC1is9NOyPic0175wu2BI47WQnCVT9BhjWnnwdoQbgnBtHxD+7M+Ww+UPPQxHNtXn
	EyNXJGFWt8eZ/OL4dQXVocy2rRuuhopyQcLMxg8ZZhviU1QRzPZfksVu6Xh9QP6fqmZQnTE6f+V
	T+xb5+/23vQNIHNd5jRFBINMfuDj7I=
X-Gm-Gg: AZuq6aJ8woS0OkmQ9H/cpCrUBJARg1QKycA1m8zzm4fAZJQ26WHlq95RPxFVaN2WShd
	icik3/YZsC+DVGKOOTrrPF/UwjKbowLSWSVILTLKhE6QQeIpvMzdTjwokUMuwgm/aSnsRWrGx8X
	DqDN/MGo+egR5oTpx78evfgpTu25Ncjx/440LmZvzRq9XH1UMmI7oXjPR3w4Ogoe45BpsseNHK7
	jfQ/duNOTneiRjOc3EA9AV4fn7hRpiFDbtVXIT8bJK8hcMAwJp0OZmOs6oUc87iqvJbgAP8tBPv
	aidgb5Q55PKezwEsyTeAhMhlVP5p+BiI1SHIDpf+hxI6TUVq2SYc+OYCm8L6+UxGu1Byk40srPh
	Q0+O8vscptqZh3fDqEglw6t2NP+yrsXW4Pqm4A284cOhs5n+2FY5YpNKVIIngFmVh6kwOuCUGNC
	LKaI+++VSuOziL0j7WhVG00Y7AHf64CTV06JH0XGK3wxGOFDzEfdFLRLJKDXLjbutegvJF7PrkV
	pmv
X-Received: by 2002:a05:6122:12b6:b0:566:221b:c68e with SMTP id 71dfb90a1353d-568e4714d0dmr1088189e0c.1.1771845819318;
        Mon, 23 Feb 2026 03:23:39 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-568e58822a7sm1297802e0c.5.2026.02.23.03.23.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2026 03:23:39 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-506dd37f21bso44905441cf.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 03:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771845818; x=1772450618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vCb3mGAPKai1Hpobl7lKadHZ3M3yFOIt6q/w7eisnl8=;
        b=emLW9sKd0dgGGO2zoNvCfufRt5neLfwkuKiAG6KO+UrqOe54qMiTkzKm8mGSySw3hl
         0EfJpWojcJIrouejhaoT28ViGqEY2NyO5xn1KqwJEpC48RZ8/ZivN3jR9F2XZ9KsbKIi
         h6h78jA5sGN5rYiZ45NFhCxQc2ZQ5SQlreofk=
X-Forwarded-Encrypted: i=1; AJvYcCWYXyTr+/Ne+6V6oUCGb2y9X0vmB8cZJqrqh4zFShIxmI78uqFcz7HmvOh/RbwakNubLxbAYaQ=@vger.kernel.org
X-Received: by 2002:a05:622a:1990:b0:4f1:b3c1:20f8 with SMTP id d75a77b69052e-5070bbd7824mr89593761cf.4.1771845818639;
        Mon, 23 Feb 2026 03:23:38 -0800 (PST)
X-Received: by 2002:a05:622a:1990:b0:4f1:b3c1:20f8 with SMTP id d75a77b69052e-5070bbd7824mr89593571cf.4.1771845818162;
        Mon, 23 Feb 2026 03:23:38 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d059502sm685245285a.11.2026.02.23.03.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:23:37 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kafai@fb.com,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 v6.1-v6.6] ipv6: use RCU in ip6_xmit()
Date: Mon, 23 Feb 2026 11:18:34 +0000
Message-ID: <20260223111834.4165169-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260001-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_NEQ_ENVFROM(0.00)[keerthana.kalyanasundaram@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 79C291757B5
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 9085e56501d93af9f2d7bd16f7fcfacdde47b99c ]

Use RCU in ip6_xmit() in order to use dst_dev_rcu() to prevent
possible UAF.

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250828195823.3958522-4-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
Changes in v2:
- None

 net/ipv6/ip6_output.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f7a225da8525..4ea4da0e71c9 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -258,35 +258,36 @@ bool ip6_autoflowlabel(struct net *net, const struct ipv6_pinfo *np)
 int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	     __u32 mark, struct ipv6_txoptions *opt, int tclass, u32 priority)
 {
-	struct net *net = sock_net(sk);
 	const struct ipv6_pinfo *np = inet6_sk(sk);
 	struct in6_addr *first_hop = &fl6->daddr;
 	struct dst_entry *dst = skb_dst(skb);
-	struct net_device *dev = dst->dev;
 	struct inet6_dev *idev = ip6_dst_idev(dst);
 	struct hop_jumbo_hdr *hop_jumbo;
 	int hoplen = sizeof(*hop_jumbo);
+	struct net *net = sock_net(sk);
 	unsigned int head_room;
+	struct net_device *dev;
 	struct ipv6hdr *hdr;
 	u8  proto = fl6->flowi6_proto;
 	int seg_len = skb->len;
-	int hlimit = -1;
+	int ret, hlimit = -1;
 	u32 mtu;
 
+	rcu_read_lock();
+
+	dev = dst_dev_rcu(dst);
 	head_room = sizeof(struct ipv6hdr) + hoplen + LL_RESERVED_SPACE(dev);
 	if (opt)
 		head_room += opt->opt_nflen + opt->opt_flen;
 
 	if (unlikely(head_room > skb_headroom(skb))) {
-		/* Make sure idev stays alive */
-		rcu_read_lock();
+		/* idev stays alive while we hold rcu_read_lock(). */
 		skb = skb_expand_head(skb, head_room);
 		if (!skb) {
 			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
-			rcu_read_unlock();
-			return -ENOBUFS;
+			ret = -ENOBUFS;
+			goto unlock;
 		}
-		rcu_read_unlock();
 	}
 
 	if (opt) {
@@ -348,17 +349,21 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 		 * skb to its handler for processing
 		 */
 		skb = l3mdev_ip6_out((struct sock *)sk, skb);
-		if (unlikely(!skb))
-			return 0;
+		if (unlikely(!skb)) {
+			ret = 0;
+			goto unlock;
+		}
 
 		/* hooks should never assume socket lock is held.
 		 * we promote our socket to non const
 		 */
-		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
-			       net, (struct sock *)sk, skb, NULL, dev,
-			       dst_output);
+		ret = NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
+			      net, (struct sock *)sk, skb, NULL, dev,
+			      dst_output);
+		goto unlock;
 	}
 
+	ret = -EMSGSIZE;
 	skb->dev = dev;
 	/* ipv6_local_error() does not require socket lock,
 	 * we promote our socket to non const
@@ -367,7 +372,9 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 
 	IP6_INC_STATS(net, idev, IPSTATS_MIB_FRAGFAILS);
 	kfree_skb(skb);
-	return -EMSGSIZE;
+unlock:
+	rcu_read_unlock();
+	return ret;
 }
 EXPORT_SYMBOL(ip6_xmit);
 
-- 
2.43.7


