Return-Path: <netdev+bounces-257026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNvgCAtMhGm82QMAu9opvQ
	(envelope-from <netdev+bounces-257026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:51:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B56F7EF9A1
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC2AB3003627
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A6135F8B6;
	Thu,  5 Feb 2026 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dKV+Ih1+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f227.google.com (mail-dy1-f227.google.com [74.125.82.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B7435D617
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277896; cv=none; b=c0i5NnFADIw6btc5c7hdRIL2TO9j+F4NaJW/SbIgVv4/UHgZJsTkekNqu32TMoV6Sv4P9VnGVxFCLhIMMh35R/WaKfct6ViH7UBmDCXzlcevSYmFNzqlfH6p0BusWKClwigca8/c42xbhuwrMmKFL6xEYofWBEIfalID2G90S00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277896; c=relaxed/simple;
	bh=tdJMXTTIfYvuzZKJx1Ev9/Jj2HH5TbX6pMoSiVeoY5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nR3ZNBWtJj4FI93Sjk22Hi6EIDwpoAs5ZQ5+JurbSGkQSd7SlqItZONiINf5SYdyQn6FyIS2S4GYgCIiebyYK/YnQ5FTvWwsIIhIbH8yPvEQKtKh/IH28UwBRmgOZOM+GYc59VQzSmgJ4HYPgFkdHHPs7W+3o/r5JrBWLj5qiRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dKV+Ih1+; arc=none smtp.client-ip=74.125.82.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f227.google.com with SMTP id 5a478bee46e88-2b718524994so42156eec.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:51:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770277896; x=1770882696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDNp96WCVrv/qI9QGPf7v2+3I3uNz6J8WTAmDy+jP8g=;
        b=i2Wz0wsB0gZ6aZaW/mQDoCIJCATkmnje8ULQvNjEHQeYlw0m7m9j5xVPW522tFcqyx
         dAlkBn/L8ibNPzwI/VLLstG7zmY0xm/RNiIaZSXYT+FXQi9D1qpKkPgJ8KpX+oClV/yK
         bAx0i2lgfL/AwjGpSaUUzZ0e+a3LoaKoMO6AQ6QahfQ7OAYwAU1AfYN2enCnzcUKElRn
         XrdhftBikJwR9BnzLj8MLFjOQRjPlmYaB7G7eBwzTtNZ6RxiVbYAx7wrUO9xUA2wRaHP
         mowrmKWME58p6PjBKoXP6K+8olf0C/rMtpRbqIg0i07L4a9PC0BYCCEqixzN1YeVfSA1
         o1zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrUllyxkhhjzR+KoHmYnOO40j1okfyqIt3Zxhp3tjnO2U4szTozKSSzL09IrPVWSiwmXeseIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgyA7YTPAYndAsNQxaNS9UjXcX7+Bi0wPR+0tV/dSqw+WQhp2D
	BSGcMlWQLt84GlowE3fqH2h9Re1nEUk4rIJmjmtoGz5TxleEunnk9PznsbbQPiMEWtDYPE6JlXa
	3OHppkYm81xT1vzPnVkRcF7pU1bJ6/iUvS8ktURcGiTXYvgd0wm7CpP1Qs1un+/j86gBiUfhJiS
	EMwoRwLmLszoQhw4inSX7l1LunaRVX6bpVEybMhs2yYlFWBEDMjv30piZ4KNAwB/DoC2+MXwK2P
	d23I1e1pY1oylb9cLOMAN+uCQlx
X-Gm-Gg: AZuq6aKEk+SbAoTXS+53McRH7eQyi1DIkbtulZ8ydhLKM1POXBux3EcfMOa5Bfzdvmi
	J63i2E3VDG0hhAAKLX8U/KpKHpgWNbcRCxv94KwAC34SnPChY6IKN+Ri/qgiitWz5HB5zXJQQIW
	NtxzAIBArMrKEN3AJUrsOwtD2u2FlpUi5oguD5AFZJWir2mYLe1z39nT+pU+XSFsWxc3TZ21uNp
	th5Z5cae+x9+3iViFaayfLBFkPUhsSbH9dcXFQRkSTVqmVvC9kxYpmg/HMX+XayvNpe+Ad7hgPu
	BFg0PChmsOzh80co5jzmqlV+ZsXVqOvA6+rpI9ISWMi2JFE6GShCNHQFK41w9UblkF/i7xqCSOX
	t2NxTAxUIx6c6zIdRgAxncMrot2bmWNMOyldwnOTP2es0N+lDJ7dBxv2VrLmxUmHplHyD24aY+y
	8lclalSaPAaPGDsFht/rMiaSEsT1KONDNWncE7lfqCq6D8CSz/toyzsiVjSW8=
X-Received: by 2002:a05:7300:bc08:b0:2b7:121a:99f with SMTP id 5a478bee46e88-2b8370da7c8mr955281eec.0.1770277895608;
        Wed, 04 Feb 2026 23:51:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2b832db47f6sm637610eec.6.2026.02.04.23.51.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Feb 2026 23:51:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b727dfa8dfso26655eec.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770277894; x=1770882694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KDNp96WCVrv/qI9QGPf7v2+3I3uNz6J8WTAmDy+jP8g=;
        b=dKV+Ih1+iDcYcHcdpSr/0vpzNupqNUsXCVlUzipa6orFmxAUcmLAa+0ulk6pf4jqK9
         c1sn+JRqhzi1IOh5Ys9vXRFoVchJCvHDUnZbcjPzG9S1POysEdmALN32cvHx4YQMcobS
         QRi8btgUTICxxTfiJ3qySCNkoXKiBoAF1mpCk=
X-Forwarded-Encrypted: i=1; AJvYcCXct75K5k4dGWoepIm5MTymaiHKZIAfU9VvBCXzssRSevgwtq2cJ/p31liXV3Iwm7/S4e6406A=@vger.kernel.org
X-Received: by 2002:a05:7300:5794:b0:2ab:ca55:8940 with SMTP id 5a478bee46e88-2b837421026mr955937eec.7.1770277893875;
        Wed, 04 Feb 2026 23:51:33 -0800 (PST)
X-Received: by 2002:a05:7300:5794:b0:2ab:ca55:8940 with SMTP id 5a478bee46e88-2b837421026mr955927eec.7.1770277893210;
        Wed, 04 Feb 2026 23:51:33 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832e4cd26sm3047244eec.12.2026.02.04.23.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:51:32 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
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
Subject: [PATCH v6.1-v6.12 ] ipv6: use RCU in ip6_xmit()
Date: Thu,  5 Feb 2026 07:47:22 +0000
Message-ID: <20260205074722.2091297-1-keerthana.kalyanasundaram@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257026-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B56F7EF9A1
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


