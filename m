Return-Path: <netdev+bounces-278591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICcPCYDN3mkfIgAAu9opvQ
	(envelope-from <netdev+bounces-278591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:28:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 246BC3FF088
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A269301A2EB
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 23:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2663BA248;
	Tue, 14 Apr 2026 23:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4Dm09PD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3732439D6C6
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776209272; cv=none; b=DEis4ZU8OL13Co0FU8J7moq5Hl31Ufuvz5EdxxKZGKwQMS/einhO7aO5zLxkT9FO4ypYQZSwXFAvUMkEytWe1l4rFKgODRIqacQMrPic6sGAmT0nTpILpBWP/7xJUJojXjIwfVb0yPCtOi84Lr9FCmQXIDXzZP2iNA1D3psWJ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776209272; c=relaxed/simple;
	bh=4ojetKFw+N+gPNsqHUboQU6M2VnP9rLu3/qxtKKWjrM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lrZ4RnfHNk0xjbvtGfsBdvmOn+QMewpVSeOU57wiD/ZSXhByYo6dFL+c3gKRAxKmXM1jpY5sV+P797ps+bpLvWPl0W7znai/SwtcN682XvfC144GQDkOoydiBenddA5cMtCTwdztbAIaONbm8FrxF5XlFAweltP2qWuXSGkhtFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4Dm09PD; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66ba9898ae8so9090369a12.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 16:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776209269; x=1776814069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AE9p9L2vInBswuWEO3djotwwSehMW4lANL0Mw7wd5Cg=;
        b=I4Dm09PDqa9oxwotRt/yiV1LWg6uJogNAs9l5/SQhdDJxWImr7MQ1DcwrJRMg6t8ZY
         oyrzAxw4mhgR3drQzixbi971DojRlDDVPhYkPL8ZzT/RaepLWfOyWs6sKLbdFi2jSuon
         rQK/Iz89zxFJAIUfTyEgSsOJa8vqhOBh44L7R+xTa4OEgiKE9S0RfaxGh+8r6jQP/AhC
         16TsOcGS3pT2KNokMavdT5B0bzf6twtzr/50MmYPFkjx+/L9kXEqYcuQ/ZeK/ISTo72t
         cUC9DA9+1HJLk+MPdewfk0pzU3CXh8PEa2WP2XF+1B8zoIquJKdluf/F//0lrG2gJAVf
         JJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776209269; x=1776814069;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE9p9L2vInBswuWEO3djotwwSehMW4lANL0Mw7wd5Cg=;
        b=pIhAJPE7f+3iOYTMS8XtC2b1kplg3NJtgleuyUEJwgvBKmVX/QaOT5tQeE6wQNUiYY
         cyWhGWX8YPNzrOHDD1mr9BXk1+4Upq9IS8DozVlT+CfyiimYpPSktZjaTvQEVVlHn8bv
         06XY1dfCAYrqfkITnZ1j3Nz0v8Wzk2782xOUmdtZujWwklpMcmfL4tSk1Qtrmu+pnFr0
         WgnrOFB50JVdcC11P94PRl1ccgSxkVWTXiYiNBlftg1mib0cMeLSef1OsV68ahVxhyUb
         yHushr5edtpBq6ETg+9CJAi+DSWlEJ3mrQz3zaKtyNfjfJD7d2S/L2IfiTfyTeaum2k1
         eOMQ==
X-Gm-Message-State: AOJu0YyQzvIOzcmr6RFCcgz7/QMqW7Aw62007Zh7PsEdTogwi8ZSm0/S
	GQUNkB3atuUmUtgYP8Mr86r1GrzwPHk5mmG4xGm8xavO5jgXBJlzF47XkkxAnfYf
X-Gm-Gg: AeBDieub9yI0JY6oKMmplmQ6AW0Tlo0N2aD4t3+Cf8b8zrUzjFuCJNA2GD9ddO6Ug1J
	PEIF9dzWRLYXdS7m/NJVmeMH0o8N1TmAJPpOiZk8NlBRxZNjihWQx8++Q6EEg6s/EV3g4PyavKD
	TW+gq7K3tlzROqHY08elghh7NQkNmLgBa9kvX1hi+ecJfBUuPmKx5Cgw+TVNx9+pu4FeTYKn7xK
	j5FLyWOFnnhc/BqGIrAMQC+ot3uCFnCHij96a0qxMCmJfNIYHmhVVeNpoZf5y7ySrp86bCYFg8p
	IvOuhAHHR2VCPnU67meFk+ifvh5MMYX+hop9p03Mc0GkmXpiXL0qwAOpvxto2DUpUD+CzyMQm8w
	M1aXV19EO/raqVIYS0J0nMiMqK34SaAFpbhHzt3VFcc0DUcgzrDiAmP+hnTic5GMaTVoscxN81v
	0HJiDb3UZt63y2uUbUpZUtW35s3k1fJ7UUKWbgl1nFTWK9zhMpo5zfLwFIp7HrL416DSFU+1Au2
	iXh
X-Received: by 2002:a17:906:99c2:b0:b94:231f:26ca with SMTP id a640c23a62f3a-b9d46228023mr1163681966b.20.1776209269053;
        Tue, 14 Apr 2026 16:27:49 -0700 (PDT)
Received: from dau-home-pc ([185.229.191.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6de97e43sm461945266b.13.2026.04.14.16.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 16:27:48 -0700 (PDT)
Date: Wed, 15 Apr 2026 02:27:45 +0300
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH net-next 1/2] udp: fix encapsulation packet resubmit in
 multicast deliver
Message-ID: <ad7NcQvBWXdxOu8z@dau-home-pc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad7MsSJOuUU6EGwS@dau-home-pc>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-278591-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[littlesmilingcloud@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 246BC3FF088
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a UDP encapsulation socket (e.g., FOU) receives a multicast
packet, __udp4_lib_mcast_deliver() and __udp6_lib_mcast_deliver()
incorrectly call consume_skb() when udp_queue_rcv_skb() returns a
positive value. A positive return value from udp_queue_rcv_skb()
indicates that the encap_rcv handler (e.g., fou_udp_recv) has
consumed the UDP header and wants the packet to be resubmitted to
the IP protocol handler for further processing (e.g., as a GRE
packet).

The unicast path in udp_unicast_rcv_skb() handles this correctly by
returning -ret, which propagates up to ip_protocol_deliver_rcu() for
resubmission. The GSO path in udp_queue_rcv_skb() also handles this
correctly by calling ip_protocol_deliver_rcu() directly. However, the
multicast path destroys the packet via consume_skb() instead of
resubmitting it, causing silent packet loss.

This bug affects any UDP encapsulation (FOU, GUE) combined with
multicast destination addresses. In practice, it causes ~50% packet
loss on FOU/GRETAP tunnels configured with multicast remote addresses,
with the exact ratio depending on the early demux cache hit rate
(packets that hit early demux take the unicast path and are handled
correctly).

Fix this by calling ip_protocol_deliver_rcu() (IPv4) or
ip6_protocol_deliver_rcu() (IPv6) instead of consume_skb() when the
return value is positive, matching the behavior of the GSO path.

Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
Assisted-by: Claude:claude-opus-4-6
---
 net/ipv4/udp.c | 13 +++++++++----
 net/ipv6/udp.c | 13 +++++++++----
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index e9e2ce9522ef..8c2d4367cba2 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2467,6 +2467,7 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	struct udp_hslot *hslot;
 	struct sk_buff *nskb;
 	bool use_hash2;
+	int ret;
 
 	hash2_any = 0;
 	hash2 = 0;
@@ -2500,8 +2501,10 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 			__UDP_INC_STATS(net, UDP_MIB_INERRORS);
 			continue;
 		}
-		if (udp_queue_rcv_skb(sk, nskb) > 0)
-			consume_skb(nskb);
+		ret = udp_queue_rcv_skb(sk, nskb);
+		if (ret > 0)
+			ip_protocol_deliver_rcu(dev_net(nskb->dev), nskb,
+						ret);
 	}
 
 	/* Also lookup *:port if we are using hash2 and haven't done so yet. */
@@ -2511,8 +2514,10 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	}
 
 	if (first) {
-		if (udp_queue_rcv_skb(first, skb) > 0)
-			consume_skb(skb);
+		ret = udp_queue_rcv_skb(first, skb);
+		if (ret > 0)
+			ip_protocol_deliver_rcu(dev_net(skb->dev), skb,
+						ret);
 	} else {
 		kfree_skb(skb);
 		__UDP_INC_STATS(net, UDP_MIB_IGNOREDMULTI);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 15e032194ecc..f74935d9f7d7 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -949,6 +949,7 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	struct udp_hslot *hslot;
 	struct sk_buff *nskb;
 	bool use_hash2;
+	int ret;
 
 	hash2_any = 0;
 	hash2 = 0;
@@ -987,8 +988,10 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 			continue;
 		}
 
-		if (udpv6_queue_rcv_skb(sk, nskb) > 0)
-			consume_skb(nskb);
+		ret = udpv6_queue_rcv_skb(sk, nskb);
+		if (ret > 0)
+			ip6_protocol_deliver_rcu(dev_net(nskb->dev), nskb,
+						 ret, true);
 	}
 
 	/* Also lookup *:port if we are using hash2 and haven't done so yet. */
@@ -998,8 +1001,10 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	}
 
 	if (first) {
-		if (udpv6_queue_rcv_skb(first, skb) > 0)
-			consume_skb(skb);
+		ret = udpv6_queue_rcv_skb(first, skb);
+		if (ret > 0)
+			ip6_protocol_deliver_rcu(dev_net(skb->dev), skb,
+						 ret, true);
 	} else {
 		kfree_skb(skb);
 		__UDP6_INC_STATS(net, UDP_MIB_IGNOREDMULTI);
-- 
2.47.3


