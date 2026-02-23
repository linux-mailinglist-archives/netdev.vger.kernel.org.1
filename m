Return-Path: <netdev+bounces-260000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDkdNqA4nGlCBgQAu9opvQ
	(envelope-from <netdev+bounces-260000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:23:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3911756DA
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 510A8301E4B7
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37D93612DD;
	Mon, 23 Feb 2026 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Giec4etg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D51034EF02
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845785; cv=none; b=sxmP6NYvlqcUbWtpUa+8gX+XLRiuX/lnHrrOK1iSws0cLGGgO86QA2bWVTs+hjvYLh2U70fO2XD6ZdFbFJ4r0OJjWlLCORPr7SNLqWgrfY4K61RkX4WP8Du2wyFb7W5yZW02lmO19HlZ2f+HXm5rJkv+LoXQ2EgCVppV61bQbW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845785; c=relaxed/simple;
	bh=OCwdj7Oh5C+efhQCrlN1d+zmPFTrH4fhSIEXXLkQ4sM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hIFcZPq8u1fcg7kDJ9+cK5J1rg2K1q9qQTn7Ua/AT0ejYlV6j7GNym8wX+K9tbgyqfEVQYS6XovCzTODX9o5xfWbkqxwgTEarMgUBj8B3RB/wVyQrzzZl9vNWmWjLyC3EFrhsnaz3SnNN4osztbceLpop1GQpVXGe1DQqXye2YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Giec4etg; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-c6e8125e82cso270019a12.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 03:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845784; x=1772450584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygNO1gCaOojuV3uvydJE9/w7V+rMBG5fJx8eoEfJcQI=;
        b=RmebTU+3W1DR2iYpo29B42rDqWh/Dk4pdVoZ54upd4RrbfXE20jWBkz17hxXKFWRXN
         oORlGdLpGX0Z0ZURcIEWdXKmFtVbJBL9hiw6J9pMqpjxDZQR9o99rXXCIIh9BIGCX4Br
         3OacR+16fgp6Njxrhjwgq0Pl/zJIuZSE0Ks4ry0k0tYSpV3mrLcsG6DxdMsnMemy4XyU
         rBLWZjbxLvyqKiyzNpbjBvmcZhfionmubhaBaroVe68CIpPFDtG1z7ZI1eE+NaSufVj2
         ecG1JleIBkf8VN4beGriF5NwxN85t1Elf2+WAz54LhNYMD2TvqW2K1rUMwZq2g8AgGxC
         X9cg==
X-Forwarded-Encrypted: i=1; AJvYcCVPMWinTC2hFejcVuuxkTsbtxf2hvfLwmgpbt79p9qmcebJdqglnjX0wp85zK5W1wV+u7p7c1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy125gkeWI5pwksIBSTknzyJwlbhIcoCVHVdlFVrY36eyTqHmpf
	Ersf1OHy6DqmAX22WxQyM2deYA08gahHOv/E9YBs+edd1B5eopr42A7B3Dll+ElwQNjCIg2no8A
	1a6SwkEXnpzcI/6z65EypcIpKr3o5Em8gCSZ8KkKXxDd/wD90aPa4llsErVK0BIXivVLxSJytQf
	lxZcCNSa8eqyIesWlEs8ow62FOwGpNb6D7e/VzKWYsIJutLemRUR+JBY/3liRoLCJflCZ+QcMUJ
	snbCsaDIP51E8XZrjCDXg4lsVTSiAo=
X-Gm-Gg: AZuq6aIHGYFi/crHptKncN29cSzaGPc0Y6y53TxUH9Bi3BTdXLai+AuR721qShSrsRG
	3J+jcyIsSJGE9qoO0zzp3KH0JNbVRpHWCLO9JZ974vaJF87KU51PZ5110xJzmc+bpJDD7TfYtZa
	9BgJvIq6dh29PwQOXuOf1LbgMTQT77ohft/NVpB1DlMPVG6T3V9FGrEgcbvCAlCu2XmqQlgReTi
	1unrPHtfJRIJZzpyCJ21zkEiIfU3GkUBVc+m2m+ambnC3fteZ71o6tWsE6RQ5+YvTagxXVXPOSf
	91ZC73+dXdjYBTI1Lc4prOVHpEMtjrIAqGRqzRvkboiwcJgg9GOoO0VTsrASG+Ll+KhlBu0GnOT
	Fs50gws6mVx2OrAYiJdydPBe7ivsmlFDzqf9jJl/SZqrxu6Q00OAq++FNVrmbghLqvbdRTdJvJu
	OF+jdHWN0uxDXZnUe7hH2t2pXNXoiTm5LixI5p74otgZmfrMs5Y7X2Aib8mHdnvPDolfHWn46M7
	SeK
X-Received: by 2002:a05:6a20:12ce:b0:35d:8ded:c580 with SMTP id adf61e73a8af0-39545fb20bemr4905782637.6.1771845783624;
        Mon, 23 Feb 2026 03:23:03 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-826dd63f09esm846501b3a.2.2026.02.23.03.23.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2026 03:23:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8954a05270eso41065636d6.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 03:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771845781; x=1772450581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ygNO1gCaOojuV3uvydJE9/w7V+rMBG5fJx8eoEfJcQI=;
        b=Giec4etgaBfzJsz8gJhbAe8qhQrsjK5KBYgKGBPRRTCkdNCYUw37f6Ob1iiauNYSiF
         zwmRYKO8hL2eebPBwBSvHWqTn1A4s0s8Jt6P0UR1A8yjQDTsDKZQy6EEqFunNhoISD0C
         WBogVR7HFL0kyv1PgXjGCS3zMa5okgz8lCLWs=
X-Forwarded-Encrypted: i=1; AJvYcCWz7XyKByBvzuDpH7RytBVOot0ctM2yco+B4DmT9USocrx5MZI08MCvMMqexTydekd4s4Ui+b8=@vger.kernel.org
X-Received: by 2002:a05:6214:4c8a:b0:897:3f5:6a9a with SMTP id 6a1803df08f44-89979df1e45mr83323426d6.6.1771845781471;
        Mon, 23 Feb 2026 03:23:01 -0800 (PST)
X-Received: by 2002:a05:6214:4c8a:b0:897:3f5:6a9a with SMTP id 6a1803df08f44-89979df1e45mr83323186d6.6.1771845780975;
        Mon, 23 Feb 2026 03:23:00 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e242fb8sm67106496d6.33.2026.02.23.03.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:23:00 -0800 (PST)
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
Subject: [PATCH v2 v5.10-v5.15 ] ipv6: use RCU in ip6_xmit()
Date: Mon, 23 Feb 2026 11:17:55 +0000
Message-ID: <20260223111755.4165135-1-keerthana.kalyanasundaram@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260000-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0D3911756DA
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


