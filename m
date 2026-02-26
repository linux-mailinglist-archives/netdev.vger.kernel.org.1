Return-Path: <netdev+bounces-261184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOqLJ6bFn2kRdwQAu9opvQ
	(envelope-from <netdev+bounces-261184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 05:01:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 041F51A0BF5
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 05:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C20BC3067046
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF085389470;
	Thu, 26 Feb 2026 04:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BYHD/+Fy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f225.google.com (mail-oi1-f225.google.com [209.85.167.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3D41B6CE9
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 04:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772078443; cv=none; b=H04mAHM88zrpNvUy65MRlitohc3Dbep/+QpcAh79rDETPCwIBK06eaV0E+ZbVjhjbh4JjeBrR1tt92HPDqgy2/zgRn3KUmeZt1lAIf96k1sxy9+ZX1YAsTQQhFR1VR1w6aRsbhp0z9n0KiMoTAqRq3l5A7FJq9dmne97oP3/7jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772078443; c=relaxed/simple;
	bh=OCwdj7Oh5C+efhQCrlN1d+zmPFTrH4fhSIEXXLkQ4sM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qEvvzaI67CTgQ3ybXKLYZi6bg6V0ZKu0J0fDrSchI+K/g0lzhC1kdDq8Wowq+cRY4ZsCbcuG+jbU+KuI2MfDzi9A0heK4BxDwz/YMXDZDlNXK1WtAgwlzKAVLlWl3A/pXMJENdZHMaV6T2JW6Ih1+9+fRV1YP9QYGG2O/P4vkno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BYHD/+Fy; arc=none smtp.client-ip=209.85.167.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f225.google.com with SMTP id 5614622812f47-4638d477938so74992b6e.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 20:00:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772078441; x=1772683241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygNO1gCaOojuV3uvydJE9/w7V+rMBG5fJx8eoEfJcQI=;
        b=pOLa/Tk85EiZOsUxP0RNa3vefedTr7Nph4rOoMEi26Fkz6pLEizqU+DIJaJUcniPWP
         uCI06UBPK0UU5D73oy8nwJAhxkDyhSB+zPeTxjwPdD+0UXwPrEOB/G6VNJSsapu0wcDO
         KedkfuTvOGwaxeJTZQYetsBEtGu8qvtqfbku7HL3nyTbRM1XpjURmM9s4SZV4ro81+LG
         CI1jeD8ZG1OamA5bOEy9iyipRciRBM69GsnRp4tIdnkjOPwiTl8CjWSUDEMLk1ZtDR6Q
         a6ig6dooSQkr0eTm6LfZ3HY5vupaGRHFUJUyFRR/8mQg2SkCqi5iMeZtZLuhrXtks6hX
         8OhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGBlfNXhK8xk1W4/9v5y19Hf5TebS2pJ78g2PP3BJvHgGj1WgB0L0HZut0Orkd9fLmQGDaqN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk1SPmv1j9TDT920QJzZtHBXKB5DXbt/g6qUzD3T6/rH1uuhxx
	t/ZJAwK5JJ2qTE4WpdL1bFBhgXoY2H2bFZMSUXDEBQp7PGSI70wjsDPf1rIW2c+mIz/FThz0qak
	VoE6bIHqkeFcVJbfNg/r5ZvynUJhxKG4TOq1XdKJoKfLhghCO3mOolIeu1MzRaNBTMg0bgFd9rG
	4KYm+Q+X/ssj1Y74QNwC6jHfMzsazI999hKU7LAlVoyu2sOdUhC1HDZoT1CAMNMEfO41aPWBAvR
	8nEQh8D++64V0VY12fDCKRTGW1R4VA=
X-Gm-Gg: ATEYQzyC20/mNtEJfCQ4mf/zEKS9n07zxCFdd4L2lKo/ufHP/gBK88bGTIfjqPLBNSd
	o4Gr1ppnzs7s/74LjzLkCQVNiMzEhhRT/bUWDln+4iYtvW7ZhR3HpAzH+e9Hc4AwNR0H2HoYDoH
	gZpyAOpxXG44PeRhBdSWmtLSnNsvimMIZGHEsdP4tI8pC2SP12dSfR3i0SSpaf5JAPIC6T8bk0f
	E41JRMZutECqhK6ASzo2q4WZljKJXCiYgjowPttwE1j7qhFzfqsKyJs68FeTH3ih/fOrFTmLVnL
	ehOKDDug4Z/lt1t7gygl4WG0efZ2ka6acAsiAmi78anhHUev3HQky5ubEXrBb40TzbVnXmfOyCR
	Y34+j5ms9mHWPGdoX1R9tUti5Z4dkARU4d5nHiPcfHGwpKWRREUIemnEI7/onToH4dwoUDPSTUg
	AXCLAa8zw72ydke1hNwC+Tf8K60OMcTq611HhACsRxZ7sRSZYqnd5Darhu+18jntFP/TdMkT+NX
	BpF
X-Received: by 2002:a05:6830:268f:b0:7cf:d108:65f with SMTP id 46e09a7af769-7d52be03c9bmr9464577a34.2.1772078441364;
        Wed, 25 Feb 2026 20:00:41 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7d58661a974sm88744a34.5.2026.02.25.20.00.41
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2026 20:00:41 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8954937be97so5114606d6.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 20:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772078440; x=1772683240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ygNO1gCaOojuV3uvydJE9/w7V+rMBG5fJx8eoEfJcQI=;
        b=BYHD/+Fys3HLicSUPGqwyOzkNxW1NEyazqoJmYDBwo5HUfptM6l/Km/Z6eEuYUeQ9G
         Wqubx5SQlg7aN5pmTbg5k5oGgUj8nBIkTSjIhwBlnxKTG/NQzDMozkuAqFc/+YpwS4As
         TvQlZWmDcxKoqLPBY1czHjUOJgti3IpYrr7RA=
X-Forwarded-Encrypted: i=1; AJvYcCUtWWzg2GjErQip+aCS+eTey0qE/T0RVQx/n8zqpPvNF1qeOZpOp02KTuXh2+wArkjR492SUQw=@vger.kernel.org
X-Received: by 2002:a05:6214:8011:b0:899:b749:d40b with SMTP id 6a1803df08f44-899b749d509mr48891256d6.0.1772078440528;
        Wed, 25 Feb 2026 20:00:40 -0800 (PST)
X-Received: by 2002:a05:6214:8011:b0:899:b749:d40b with SMTP id 6a1803df08f44-899b749d509mr48890886d6.0.1772078439948;
        Wed, 25 Feb 2026 20:00:39 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf67814bsm118473585a.17.2026.02.25.20.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 20:00:39 -0800 (PST)
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
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v3 v5.10-v5.15 ] ipv6: use RCU in ip6_xmit()
Date: Thu, 26 Feb 2026 03:55:28 +0000
Message-ID: <20260226035528.3222150-1-keerthana.kalyanasundaram@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-261184-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
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
X-Rspamd-Queue-Id: 041F51A0BF5
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
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
Changes in v2:
- None

 net/ipv6/ip6_output.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 426330b8d..3411da42a 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -255,33 +255,34 @@ bool ip6_autoflowlabel(struct net *net, const struct ipv6_pinfo *np)
 int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	     __u32 mark, struct ipv6_txoptions *opt, int tclass, u32 priority)
 {
-	struct net *net = sock_net(sk);
 	const struct ipv6_pinfo *np = inet6_sk(sk);
 	struct in6_addr *first_hop = &fl6->daddr;
 	struct dst_entry *dst = skb_dst(skb);
-	struct net_device *dev = dst->dev;
 	struct inet6_dev *idev = ip6_dst_idev(dst);
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
 	head_room = sizeof(struct ipv6hdr) + LL_RESERVED_SPACE(dev);
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
@@ -329,17 +330,21 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
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
@@ -348,7 +353,9 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 
 	IP6_INC_STATS(net, idev, IPSTATS_MIB_FRAGFAILS);
 	kfree_skb(skb);
-	return -EMSGSIZE;
+unlock:
+	rcu_read_unlock();
+	return ret;
 }
 EXPORT_SYMBOL(ip6_xmit);
 
-- 
2.40.4


