Return-Path: <netdev+bounces-261183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAiEE23Fn2kRdwQAu9opvQ
	(envelope-from <netdev+bounces-261183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 05:00:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8C11A0BC8
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 05:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26374302E855
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3009F27991E;
	Thu, 26 Feb 2026 04:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ue371qLC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E675C1B6CE9
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 04:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772078426; cv=none; b=d+uyshiOxI0MXMf1hXD3LwR8sytroq8bBSxvdfTNR2k0TJozMg2r5v0bKFIVViRDHtMqow2MpMQTwFcC2oNAPfkT1Ioyk5knEx33HXlLXaWuZY6WtWw31l1bNuhGqvaUwPiACifwWfFAkhmZ55l4FPeZY80hqjPS/GLIQsAB7og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772078426; c=relaxed/simple;
	bh=p4ObQhsGaquv0/UOLFNM3wnBoRUtCqhdQS05+BaaZZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NWDvQHY8GC2BOuAL4t/I92yxThqOBnGTMS3JUm1bV15bHrUP2X1e+quMSUJ4QjP8ig5tIgDFOsM8Gy6uR7/dQkBVWccWnJGlGd2E2PzuyiQNnJ6WmNB2TxTvuxUgT0bVZM+65kp01qVUOlb2WCLwjdrBCCRD8Mb0jWnFqZ7mpQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ue371qLC; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-c632ca0c317so10265a12.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 20:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772078424; x=1772683224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95I2cawC7z6ZKTb4xOnbEbjbg0EhuyvB5ErtjRNQPtM=;
        b=UoapEikFGQ0gCBwVPg3/lykoLSxdzm/7JNgkTWKBNaY7PkTZs0CmiXUVS4eb46kgaK
         A2tCPtAUOwu+8q/bYAFTEiSGQE7O5GroYKrtdaq8ggur7DZDMXvWzfNlZdIlyRfkp+QU
         puwPc5c90CDpB1hPwC8W4844H0RCcIzQZDR4Omf0i7jkKyWGDtSmZpYe2M++2BhnqA1E
         h2KQo1zUQaALe3dnERKtNnVsJlrJEnFHMlqPTLY0LTpxRU0+CeD6gbGxYGt8JNkaCOVU
         cYm+KPsQkkmZkPUALh96bxnx5x0EAa8+8jdQJGghok6xL7gIqENsjMW2UIkyVAkM2OcH
         gy7g==
X-Forwarded-Encrypted: i=1; AJvYcCU/J15EXCx9+Yh8TSFT68uBlZ7/GIK97E//XfN69wWD4qm2CCa2rOmQoUCgLqpeFW94wpNq8YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV5FfBqFKqPTAmY4Z/TDTmcweCmcAuT0ZsAoKGXayNV2/0RJra
	KJv3FdTSJIqNHbV1P62v6HbOkfbuVNuxOsXANMEa6UgUISlLJ6dqnbY6yF5JlRa0bWnmx7QK3Qa
	YCMQWtCMIn4YH4/JnRMQ7LhJwDVYMum8bZKW4Hb4RJP1A6RHw9RPeXi2gs5bLZvrgBhQH6qscAL
	V8h5a/dZ6mUrvUOEeoiem1C6Vu37UbTLXjI8AMwvE+kWdTXmoUG3/BXhvqbfmq93R1Y7JtCbFDN
	vqGOurzHZVrZhQsDzKWOw7YHQM1+AU=
X-Gm-Gg: ATEYQzzixe6wqbfNuhAM9XbjgT61RoKzyxgtVsxd7sQK4lWrZ2+X5RX8TR+S3/Ix2xH
	IssXMvFKm4WjQycgFf8RGKd8n3j9T449piC+pnWFDHmCE/v840/jh+Vn7IMw85VEoReEPBEoi0Z
	v5kezuDmHQ05jC0lYAbNie8SFR3ZIa3p9/IEQtN4H8PBiIuJTMKrjnn9to3aX8luMgUYDytb9KZ
	kOvmJ++BuKhr7ToHX8v5gjwrdUC+oHS13G0uCBpfs1MtahW4xJ9Zx6CvlhcwIzzco1RKdfOwf5S
	qWhKLNHNEmMMUvOElnbpjtHhf6iH6AngHAY/oQ7AnhHJF/lreTM+s7e7EAzonzKkLhgZ118VmyM
	4eboNeOZuoVoNzMmfHp8xPM8Wj/jq7UIIy/Xa09fn+PNz3moZfHuu3XMGQ/tgf+uhx06MIg1xCd
	z4bwC5t/OP/NKhYawh22jPXZH63av+6ETYcjnymzGenizXOTK5iecqly15BrOLLu3FqjHwFg+Gq
	szW
X-Received: by 2002:a17:90b:3fce:b0:340:b8f2:24fa with SMTP id 98e67ed59e1d1-358ae7c4508mr11693772a91.2.1772078423857;
        Wed, 25 Feb 2026 20:00:23 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c70fa7fbc8asm58036a12.12.2026.02.25.20.00.23
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2026 20:00:23 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8954ab64c65so4267506d6.3
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 20:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772078422; x=1772683222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=95I2cawC7z6ZKTb4xOnbEbjbg0EhuyvB5ErtjRNQPtM=;
        b=Ue371qLCTX3lduQg88jZDHlneLrEfAVXZe0B1B6LXFx1EY7YzxX0V3eHzehlcAdN9Q
         3qV2spec3wi5eQzZ1dOc1FqLAbCp+FoGCYtEyJLo8Z2eHDdVyZ2af+nXUpL0XSOgGomc
         byeHXGGpVf3vgB5hMRFioE7iKDnRHEe4gB97Q=
X-Forwarded-Encrypted: i=1; AJvYcCWC1s8ixdLucqHyH42sWvWF5akYBdfdxrVjUI/gBtp1Q3bJODBQgqJ1gYvhaSy+Kkb7hE3gJx0=@vger.kernel.org
X-Received: by 2002:a05:620a:6910:b0:8cb:52c2:6f19 with SMTP id af79cd13be357-8cb8ca764b3mr1787882285a.7.1772078422373;
        Wed, 25 Feb 2026 20:00:22 -0800 (PST)
X-Received: by 2002:a05:620a:6910:b0:8cb:52c2:6f19 with SMTP id af79cd13be357-8cb8ca764b3mr1787874285a.7.1772078421559;
        Wed, 25 Feb 2026 20:00:21 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6541f1sm103331185a.3.2026.02.25.20.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 20:00:20 -0800 (PST)
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
Subject: [PATCH v3 v6.1-v6.6] ipv6: use RCU in ip6_xmit()
Date: Thu, 26 Feb 2026 03:55:08 +0000
Message-ID: <20260226035508.3222136-1-keerthana.kalyanasundaram@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261183-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,msgid.link:url];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_NEQ_ENVFROM(0.00)[keerthana.kalyanasundaram@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BC8C11A0BC8
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
Changes in v3:
- Updated authors

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


