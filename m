Return-Path: <netdev+bounces-293380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG8cNRTeG2psGwkAu9opvQ
	(envelope-from <netdev+bounces-293380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 09:07:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF90614C81
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 09:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EB8F302A7C6
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 07:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9813427FB1C;
	Sun, 31 May 2026 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXn/w87M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D52194C96
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780211217; cv=none; b=FMYOuWEhVnG020ecQ7wEreGZuudh/ECBHG56Kr8s/ZcYshL3DcVWv4soQl49RRsDFZa4/Bk0MhprTu5gdhKtAc/sAwAL/76QiTY7d+L03tyahGy6AAkbOiHz7KDqC/8lvl7HKrQ0rdgApJ/KSfuoYdQXIQX/gvDtOyLOEcuUdLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780211217; c=relaxed/simple;
	bh=2n1S3UdEH1tCuxcSgeJOch7A28fmTjJCkvcwxEhZMn0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=evtVrW5torHxAQREmKKkzUDDvB2j/5j2lEM/evAgfzXubL7HUUPp27Vgky2q0WqwmTkWT0vphaeRt+Mgi4o1rjG+EW6cOwzwdTGHi1xEjGinhJhjcYeWT/g3nHOHHRnx+TYb7Teqhrh4wxjkYfV3vXbHw6W+Wcj25thjWkbU8rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXn/w87M; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0c3546924so2196715ad.3
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 00:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780211215; x=1780816015; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1vHCfOD9z8oLErcr4IHsFUk3SvJ8sswyXodSXdbNsxQ=;
        b=GXn/w87MtoL0GgUIJ+1G1TaMgSSeFe+3CbugRpbk595Pcx/POurHAnzoGxIBx4YLIr
         5hQfSdIaH1WEj/hRyyLLUWKBS/lPVcUU09ldhLtQN/1/+RqllcBHi30ODwaMJr8vrZSX
         zhMUk44bDVZR752WffVJ04OEO7tMT/ETAhyyzHfw2kJSCUU7ZozgAK5pPeNCTosIj+xI
         F26XmsgrihZiSgy8FBa9ik7ABp0G0PFDodhkcTXGtF6+AB+BeQppYC90ZzMi25OoquMS
         HFzJnHHKLN2vY5g671CaPMTWqYtdjDk7+ZEkulT9TXDjGpPAnUCLxv0kwNAGEfsX2UcT
         I5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780211215; x=1780816015;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vHCfOD9z8oLErcr4IHsFUk3SvJ8sswyXodSXdbNsxQ=;
        b=JF7QiD34Eq49AtGJBhVVO773gHYqLoCCqMvT9yJ4OrpkxBhP2rkSx84fNnk49LE+2l
         7AVZi8Sf3ZqNyCbB6oUJzeyEGmBmTCtWSgUBMUSLR1XqHX/YkwV+3l7saC89ffQPvdbI
         +vGI2dtyrp7FkD5UTtJ+hatQMu3z2hwLWS613Kph1+2MY0uWRfdisgJpAtE0GZrhAnwA
         ApSxnOSonFQf+xe3b35hvOrAx1gujSyKhLOhG9lSMZgv+Gz9ByTLKaEqCehfyaD1zu++
         3zYXiIFOThv3/QY0o226xy4TXW48JdpI7sPiIwCyIfY9bx40YCpBaFjqTor+v96klcgI
         QhoQ==
X-Gm-Message-State: AOJu0YxrR2uRiEMIR++j3RsynBgvDymxwaTuIuoH/AfwuR6FwIjTEFGx
	nWQVRI/Qz9AFCtHg0tQawhAtFboLC48pHMCz/BdPcvKgFsGnqyuVimLv
X-Gm-Gg: Acq92OFbtBiV4nlXCcNYlwGPTv8yR/owoq/ka6JSrd9sU0aMPTNfwN91BJz9PBHkHY9
	t3dHId9jetP7BOeje0W1Sia5iX+XWR9HepijdbpfZWRDTy+220FqyasQ/5lzeCT/afzA13IbsVd
	QElwKuux//l5QRMWp1UB2kU6H1GkXwznKRQA09Dh11Ra5btV1aCPnI+jmssnlNkimMpdR18j2Y4
	h45kXJFbQKrTC0BSMIb7pdxqhaJ/JKR1OGgbaQ2OxumCT3ykcaicqytu6l3b6wdrTfH+StUpsgP
	CUju/D8uVNWRzhZt06F7y+IA+Kmgkmzi2k6yZ5Sv/lS38AxRTQ4saNWXcTb+TpBHQ+AOTVsOv8Q
	GUEyifnok0pqkbgfMyofUr+pXyyg7tXTbPclBEeWAPw/Wzt4pMpno7937Q28jDG8rql43NkZvKj
	Z56XSx+1ty7PoWiF7arPODqpFj0ccIizYEx3FbNrBz78RnSsbgi741+g==
X-Received: by 2002:a17:902:ecc7:b0:2c0:b319:fb36 with SMTP id d9443c01a7336-2c0b31a00c7mr39009385ad.28.1780211215268;
        Sun, 31 May 2026 00:06:55 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c0ce622c26sm6915705ad.67.2026.05.31.00.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 00:06:54 -0700 (PDT)
Date: Sun, 31 May 2026 16:06:50 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, andrew+netdev@lunn.ch,
	kuniyu@google.com, jlayton@kernel.org
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net v2] net: protect egress device access in the output path
 with rcu_read_lock
Message-ID: <ahveCu-zzFlpeVut@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293380-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4EF90614C81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ip_mc_output(), __ip_local_out(), xfrm4_output(), raw_send_hdrinc(),
xfrm_output_resume() and vrf_output() read the egress network device
from rt->dst.dev / skb_dst(skb)->dev / skb_dst_dev(skb) and then pass
that pointer as the 'out' device argument of NF_HOOK without holding
rcu_read_lock.

dst->dev is a field protected by RCU. When a device is unregistered its
value is replaced with blackhole_netdev, and the previous device is
freed after an RCU grace period. A section that reads dst->dev and uses
that pointer must therefore hold rcu_read_lock. The functions above are
missing this protection, so when the egress device is unregistered
concurrently with transmission, a LOCAL_OUT / POST_ROUTING hook (nft
meta oif, selinux_ip_postroute_compat, etc.) can reference a device
pointer that is no longer valid.

In the leaves above, wrap the section that reads the device and runs
NF_HOOK in rcu_read_lock(), and read the device through the RCU
accessors (skb_dst_dev_rcu() / dst_dev_rcu()). As a result, the RCU
grace period cannot complete while a transmission is in flight, so the
egress device is not freed and the hook always references a valid
device.

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Changed to a net-wide patch that also fixes the issue in
raw_send_hdrinc(), xfrm_output_resume() and vrf_output().
- v1: https://lore.kernel.org/all/ahqIg6vURwYI0LJ5@v4bel/
---
 drivers/net/vrf.c       | 16 +++++++++++-----
 net/ipv4/ip_output.c    | 27 +++++++++++++++++++--------
 net/ipv4/raw.c          |  4 +++-
 net/ipv4/xfrm4_output.c | 13 +++++++++----
 net/xfrm/xfrm_output.c  |  4 +++-
 5 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 46209917ae4d..e9a1dd961805 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -833,17 +833,23 @@ static int vrf_finish_output(struct net *net, struct sock *sk, struct sk_buff *s
 
 static int vrf_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb_dst(skb)->dev;
+	struct net_device *dev;
+	int ret;
+
+	rcu_read_lock();
+	dev = skb_dst_dev_rcu(skb);
 
 	IP_UPD_PO_STATS(net, IPSTATS_MIB_OUT, skb->len);
 
 	skb->dev = dev;
 	skb->protocol = htons(ETH_P_IP);
 
-	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
-			    net, sk, skb, NULL, dev,
-			    vrf_finish_output,
-			    !(IPCB(skb)->flags & IPSKB_REROUTED));
+	ret = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
+			   net, sk, skb, NULL, dev,
+			   vrf_finish_output,
+			   !(IPCB(skb)->flags & IPSKB_REROUTED));
+	rcu_read_unlock();
+	return ret;
 }
 
 /* set dst on skb to send packet to us via dev_xmit path. Allows
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
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 68e88cb3e55c..555e62eacdc6 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -410,9 +410,11 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 				skb_transport_header(skb))->type);
 	}
 
+	rcu_read_lock();
 	err = NF_HOOK(NFPROTO_IPV4, NF_INET_LOCAL_OUT,
-		      net, sk, skb, NULL, rt->dst.dev,
+		      net, sk, skb, NULL, skb_dst_dev_rcu(skb),
 		      dst_output);
+	rcu_read_unlock();
 	if (err > 0)
 		err = net_xmit_errno(err);
 	if (err)
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
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index cc35c2fcbbe0..2b69ac55c8a5 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -604,9 +604,11 @@ int xfrm_output_resume(struct sock *sk, struct sk_buff *skb, int err)
 		if (!skb_dst(skb)->xfrm)
 			return dst_output(net, sk, skb);
 
+		rcu_read_lock();
 		err = nf_hook(skb_dst(skb)->ops->family,
 			      NF_INET_POST_ROUTING, net, sk, skb,
-			      NULL, skb_dst(skb)->dev, xfrm_output2);
+			      NULL, skb_dst_dev_rcu(skb), xfrm_output2);
+		rcu_read_unlock();
 		if (unlikely(err != 1))
 			goto out;
 	}
-- 
2.43.0


