Return-Path: <netdev+bounces-293312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCh3MpGIGmpt5QgAu9opvQ
	(envelope-from <netdev+bounces-293312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 08:49:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4503460B7EA
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 08:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 263043060495
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 06:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A65384CE6;
	Sat, 30 May 2026 06:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFgoihqL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8D199949
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780123785; cv=none; b=u1PNGIU1kZougpxtXQYgg8uZy1V6AWyhbOYoTuKlJrHoTYwWpxZlu8Oy5ya1GsE94lCtZYI77LMWU5lgp0vxxObWZ6S5yxg5QY9b/394ncfpkyP429D+bhS9+h2D2tBHpac6RezmPiWkOODnZF0Uxq8ufj373WII2Dp3XAoWTCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780123785; c=relaxed/simple;
	bh=YJu/hGqCZ/x6BPnocLXNDfK+2HdLM+a6mWCKV6S32gc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eNLHGpxDBYwmWqPteFtcvr0HKsdl70FJ/qjcQC3RM4knv7W6Q7ascufb4bgz2rkeMbHfs37sLpfA61a3lXIgJKXFN1gh2RFE+G1o0BLQQ+/GCkm5a1sdJc6O2D+5JQTGkZvB+1eufrdoxSj39d1dLvEeY41nnoIhMoMVgaZ4AYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFgoihqL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2baca4df358so92581775ad.2
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 23:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780123784; x=1780728584; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G8NAUea0YD24JXOa/aqrN+/ZpdlmTLfkczxznQ++dPw=;
        b=oFgoihqL4KMRI0ciwduW3OIg+3K5HBWEHhnBW10/CroUDOgcK3IWh7nukczVrGpOiP
         /SUnCo3QWpi6kd/uosH05Vz1aZJdl+O/tQDPG3AyOL60r/nUqSRVzQI/o2BCRz8WCuqW
         2trPt79zeor4NUfNxO7N/59uxYPpWSDYcrHS0ZXU3efAh7B+j/rg9ddCTj/mBmIvDSep
         FuHqhpNWip5g0sAkwG69Ng9znHuXL+Z+85zhFpHlVEEhFMlfxPA6kJTP+s8B+IuIm4cP
         qhE/49xtoTHKsALQ//COUAXrUckqsBzdV84x8q+NSgRAl8rzWDjTxp0+7+bvBorKnvTA
         6WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780123784; x=1780728584;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8NAUea0YD24JXOa/aqrN+/ZpdlmTLfkczxznQ++dPw=;
        b=bmrhtvJptXs8BPtPf13JoCj4KOE0yQQ6MDN+aZDvxHrLO4wXrTkVYbtx77hkctYRLO
         ujoObVYO8UwDdI6I4kkBNYoktWjj+H/i0dzObUTkZd8+jnwNW5C1N0O6vGE/s9umBfh5
         JbE7JxvKo4UDj0DcRXlD7VAvCnz29UWfDMSN9ZGjMMCFTnzHWPmKToZqNslDHvLy1BfG
         3tP50AqbiyBmCctZ4oTaXxsLFPXK8trIDB4PplVSqPyNiWFhNkg2fZnlSoUilJx4gloB
         InYkvU2T/xQhZJ9TB6a/Z0S3elzfpceEzv14mR4aORnGbbTtC3YCC8l/p6Mdfqv708YH
         EnDw==
X-Gm-Message-State: AOJu0YxAGhXxT4Xas5DuRwhtqwh3DL0DPAZOws7ikpkvaHZBEzagSUKg
	N7xkF7IRwcE5VgmbBwzF9NLaatSoabmdyZaL7mTMbTtPoSmBf+dvPex4cqipdQ==
X-Gm-Gg: Acq92OHSqeuZ1yygFON29An/eSm0wuWRBn/AQotiwIz7AfJyR/ElzHPMY7btrYWrdWp
	yEQutj3dWmpDplLdm+LTv9CBLj6Ndl2+QPLp2he5Kt0VxHcy/PRGDUdWLWgA/S9JjwvfGkRobyR
	gG1Mb4LEdzz4tu8PYkqxkho1hsKaogcNSV0mM7+3mIgZmPK9Z1kZs9zhNrpRQpTbDq9a7KbPO5Y
	81Fw8WsDNhbVTZRSBv+JTv3Z8tIUfvekEcaV22Ccn2guSo5o9YYaRXR2xKfxdQiP5HYPIRCTga8
	CaF1G8FydKh9NuUlArlMRZy0dnDFAvYg6FoxlJ2hBdV3kbJxpRrlGNkT+UD723ie9WTmSGCg7PH
	cb+n6aylpm2RDE/KSP9EgSSYh/rF0ER7jkTJuHsXZLQpEjcwRno2R5sXmJGgpsqEjdPeyOEfmpB
	ZUdudzzJW6ZLV3f3Pqg4n76aRpwjoRnHWs8TMG7D42WSJGPHRjHFMVllSFAGHQgV4D
X-Received: by 2002:a17:903:244d:b0:2bd:c310:f7c9 with SMTP id d9443c01a7336-2bf367b2353mr37205065ad.2.1780123783611;
        Fri, 29 May 2026 23:49:43 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a1e095sm43155285ad.32.2026.05.29.23.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 23:49:43 -0700 (PDT)
Date: Sat, 30 May 2026 15:49:39 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net] ipv4: protect egress device access in the output path
 with rcu_read_lock
Message-ID: <ahqIg6vURwYI0LJ5@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293312-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 4503460B7EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ip_mc_output(), __ip_local_out() and xfrm4_output() read the egress
network device from rt->dst.dev / skb_dst_dev(skb) and then pass that
pointer as the 'out' device argument of NF_HOOK without holding
rcu_read_lock.

dst->dev is a field protected by RCU. When a device is unregistered its
value is replaced with blackhole_netdev, and the previous device is
freed after an RCU grace period. A section that reads dst->dev and uses
that pointer must therefore hold rcu_read_lock. The three functions
above are missing this protection, so when the egress device is
unregistered concurrently with transmission, a LOCAL_OUT / POST_ROUTING
hook (nft meta oif, selinux_ip_postroute_compat, etc.) can reference a
device pointer that is no longer valid.

In all three leaves, wrap the section that reads the device and runs
NF_HOOK in rcu_read_lock(), and read the device through the RCU
accessors (skb_dst_dev_rcu() / dst_dev_rcu()). As a result, the RCU
grace period cannot complete while a transmission is in flight, so the
egress device is not freed and the hook always references a valid
device.

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv4/ip_output.c    | 27 +++++++++++++++++++--------
 net/ipv4/xfrm4_output.c | 13 +++++++++----
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 5bcd73cbdb41..92a70b7e74a6 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -102,6 +102,7 @@ EXPORT_SYMBOL(ip_send_check);
 int __ip_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct iphdr *iph = ip_hdr(skb);
+	int err;
 
 	IP_INC_STATS(net, IPSTATS_MIB_OUTREQUESTS);
 
@@ -117,9 +118,12 @@ int __ip_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 	skb->protocol = htons(ETH_P_IP);
 
-	return nf_hook(NFPROTO_IPV4, NF_INET_LOCAL_OUT,
-		       net, sk, skb, NULL, skb_dst_dev(skb),
-		       dst_output);
+	rcu_read_lock();
+	err = nf_hook(NFPROTO_IPV4, NF_INET_LOCAL_OUT,
+		      net, sk, skb, NULL, skb_dst_dev_rcu(skb),
+		      dst_output);
+	rcu_read_unlock();
+	return err;
 }
 
 int ip_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
@@ -368,7 +372,11 @@ static int ip_mc_finish_output(struct net *net, struct sock *sk,
 int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct rtable *rt = skb_rtable(skb);
-	struct net_device *dev = rt->dst.dev;
+	struct net_device *dev;
+	int ret;
+
+	rcu_read_lock();
+	dev = dst_dev_rcu(&rt->dst);
 
 	/*
 	 *	If the indicated interface is up and running, send the packet.
@@ -407,6 +415,7 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 		if (ip_hdr(skb)->ttl == 0) {
 			kfree_skb(skb);
+			rcu_read_unlock();
 			return 0;
 		}
 	}
@@ -419,10 +428,12 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 				ip_mc_finish_output);
 	}
 
-	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
-			    net, sk, skb, NULL, skb->dev,
-			    ip_finish_output,
-			    !(IPCB(skb)->flags & IPSKB_REROUTED));
+	ret = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
+			   net, sk, skb, NULL, skb->dev,
+			   ip_finish_output,
+			   !(IPCB(skb)->flags & IPSKB_REROUTED));
+	rcu_read_unlock();
+	return ret;
 }
 
 int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
diff --git a/net/ipv4/xfrm4_output.c b/net/ipv4/xfrm4_output.c
index 0ae67d537499..d5dc084777a3 100644
--- a/net/ipv4/xfrm4_output.c
+++ b/net/ipv4/xfrm4_output.c
@@ -30,10 +30,15 @@ static int __xfrm4_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 int xfrm4_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
-			    net, sk, skb, skb->dev, skb_dst_dev(skb),
-			    __xfrm4_output,
-			    !(IPCB(skb)->flags & IPSKB_REROUTED));
+	int ret;
+
+	rcu_read_lock();
+	ret = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
+			   net, sk, skb, skb->dev, skb_dst_dev_rcu(skb),
+			   __xfrm4_output,
+			   !(IPCB(skb)->flags & IPSKB_REROUTED));
+	rcu_read_unlock();
+	return ret;
 }
 
 void xfrm4_local_error(struct sk_buff *skb, u32 mtu)
-- 
2.43.0


