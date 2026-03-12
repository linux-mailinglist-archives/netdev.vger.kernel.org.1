Return-Path: <netdev+bounces-267227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AKWBANBs2l6TgAAu9opvQ
	(envelope-from <netdev+bounces-267227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:41:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FCB27B02F
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47776326B80F
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 22:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064A93BD237;
	Thu, 12 Mar 2026 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="JZ+6YizI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730FB3BD24D
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773354930; cv=none; b=oSZvRm/Fshx12OA1RKRbyVkbwFiGPvHjAljyp1I5LQjz5qjjrrLfuaXXFUJMB47piqeOrcy3rGb4NpCTo2eyoTndr85slrAyNm1eBSP97G1HkKXoTM0hydJ4jSC2tIAv2SBLB3xsZeVHxOs518X7aiqK0CkWT01EFD4xp7QCDL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773354930; c=relaxed/simple;
	bh=G3lAJEGIzOMjHC/w2zD2WcOKWET3ZX4PkXRW3E0aC98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCc/DvD7fP30GeQgbra/hljFjmLSeRqG8cf2Nqt+C7IReBw0Sdc4OG0D+v0EIHKAse+78zp8OilT2vJ4xQUCmNMQL94yLK1gLT8noZr5fdxFVXkgS8dJuPC85K+kVx5mYffh0pdWzLF+QMV2vVQiw31ebqsoZwAh8Jv2LelRAB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=JZ+6YizI; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35a03da7bd6so948082a91.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773354926; x=1773959726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzxTmIvDilrbiI026msD2EOVwu+JY7leoshXAkQYWUA=;
        b=JZ+6YizIMNvaRhiHZCvrCc4Q2kVdqZaBDT6B+s5uOhoOOW0zPLc3uXYV9v3OHI0igx
         H04f53AkIO8hWx5gTWqrvCQlZ2C8uPVlD6r2WGq4E9U7o6obQrP903lvkqGjhW/wk+0t
         9m6lH7thIGdvp9ewRA63wKtRhLXyy5gOU8xuW9ENyVKVReByF3/CSdFnI2DEGJOVKTPW
         W9X92e/H7NAMUpZY5T4m1Axd1GtwGRNKYHiZOnr6tivZAa4fETCVLIGAA1Hk2DkWdY5O
         Ka4ZdavDyjs5P3q2M6A6cQBBmDsPiCorBMJmEjM3mYbk6SpXwZh6sPYa40IYhfSpl4Rv
         OXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773354926; x=1773959726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vzxTmIvDilrbiI026msD2EOVwu+JY7leoshXAkQYWUA=;
        b=RgpC6q65zJpIt+6ChHXqU7dfac9nHkc4nCjt6hJSRij8WQu8AYCUzlhZOnHGTG2Kjn
         WbauMWKv7qCrbTPTgU6932eZL7hApXoeKHOBcS9mOEmMFXKNjk4Nj6r0lMdutsvtLvIn
         WUE+n72CZ+4PUvb+T7eN2rbqsXDt7QDIxXEoGUSdoYJo7QM5z8YBvzQNTVPBWKr6BewJ
         vedKyu0BG6qRHTP67HEGmRglI/l3BUocE3Cc1iVzNYi6WwR7z8t1VwHUGIeQVj3MKq7y
         ek4QBE2axFKONt2SrVWTu5O6izZkN7A8+G2ogmUrlPlnFnwKris2N52j1VaUquzQHL5b
         892A==
X-Gm-Message-State: AOJu0YydyfQrjYvtVO/n9g9G81M0goXIOyFtUu62eiPYlb+Zm6j9rx2u
	yXNEAxGmynPfkubGg4vVDor0Gmh/dhR8ZKH4d2pVKRJTHFa3UmGksxYgcdniNn7r3mzy5P98hZt
	K3l6e3aA=
X-Gm-Gg: ATEYQzwdl8bo9mThzh5VF91N77JeeCmcd92xOS1wqLyfjlBvEvJNC7xpCa4ATwQDEoC
	aiMLepI+LdMP65c8F0oU77PIusHgcPzlprDBJ//Sh8VY/T2971IKVtCu60idzzHYrcT2uXK8CRM
	PyHoIkOHc7xlMYgu349JtUF3pDcrrVU2Ia7Y0JwbKexgrFDou15LvTO6iQKPiiTUVzL7dwz3J6j
	vRnEmMq5aa/ewY+gFz/JE1xKjNpBE2ikmupuqhh7318/fEOQOguWMrVaq3J9h7jDMMNSYXD7mxU
	Z2GmSd2clJlTpwoc+UZEX3g7qYgO4hY9Gk0siem2ECb7bNbiyNXLhU/PFr5ePKEjn40T0A+jnmY
	5cmWfc7Gfwduo20EnRuJn17cRctUCxABJC8p7SgR0k9njp9eGrJbhBHt3Mbp+AGhUfxwm8qQcGy
	sbryVM
X-Received: by 2002:a17:90a:e7d1:b0:340:b912:536 with SMTP id 98e67ed59e1d1-35a220555eamr943023a91.31.1773354926610;
        Thu, 12 Mar 2026 15:35:26 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359fc97356dsm7682310a91.8.2026.03.12.15.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 15:35:26 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net-next v2 11/12] net: netdevsim: Add support for SW USO
Date: Thu, 12 Mar 2026 15:34:48 -0700
Message-ID: <20260312223457.1999489-12-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312223457.1999489-1-joe@dama.to>
References: <20260312223457.1999489-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-267227-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: A3FCB27B02F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for UDP Segmentation Offloading in software (SW USO). This
is helpful for testing when real hardware is not available. A test which
uses this codepath will be added in a following commit.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 rfcv2:
   - new in rfcv2

 drivers/net/netdevsim/netdev.c | 100 ++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 5ec028a00c62..f7dd7692a5d9 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -30,6 +30,7 @@
 #include <net/rtnetlink.h>
 #include <net/udp_tunnel.h>
 #include <net/busy_poll.h>
+#include <net/tso.h>
 
 #include "netdevsim.h"
 
@@ -117,6 +118,98 @@ static int nsim_forward_skb(struct net_device *tx_dev,
 	return nsim_napi_rx(tx_dev, rx_dev, rq, skb);
 }
 
+static netdev_tx_t nsim_uso_segment_xmit(struct net_device *dev,
+					 struct sk_buff *skb)
+{
+	unsigned int hdr_len, mss, total_payload, num_segs;
+	struct netdevsim *ns = netdev_priv(dev);
+	struct net_device *peer_dev;
+	unsigned int total_len = 0;
+	struct netdevsim *peer_ns;
+	struct nsim_rq *rq;
+	struct tso_t tso;
+	int i, rxq;
+
+	hdr_len = tso_start(skb, &tso);
+	mss = skb_shinfo(skb)->gso_size;
+	total_payload = skb->len - hdr_len;
+	num_segs = DIV_ROUND_UP(total_payload, mss);
+
+	udp_hdr(skb)->check = 0;
+	if (!tso.ipv6)
+		ip_hdr(skb)->check = 0;
+
+	rcu_read_lock();
+	peer_ns = rcu_dereference(ns->peer);
+	if (!peer_ns)
+		goto out_drop_free;
+
+	peer_dev = peer_ns->netdev;
+	rxq = skb_get_queue_mapping(skb);
+	if (rxq >= peer_dev->num_rx_queues)
+		rxq = rxq % peer_dev->num_rx_queues;
+	rq = peer_ns->rq[rxq];
+
+	for (i = 0; i < num_segs; i++) {
+		unsigned int seg_payload = min_t(unsigned int, mss,
+						 total_payload);
+		bool last = (i == num_segs - 1);
+		unsigned int seg_remaining;
+		struct sk_buff *seg;
+
+		seg = alloc_skb(hdr_len + seg_payload, GFP_ATOMIC);
+		if (!seg)
+			break;
+
+		seg->dev = dev;
+
+		tso_build_hdr(skb, skb_put(seg, hdr_len), &tso,
+			      seg_payload, last);
+
+		if (!tso.ipv6) {
+			unsigned int nh_off = skb_network_offset(skb);
+			struct iphdr *iph;
+
+			iph = (struct iphdr *)(seg->data + nh_off);
+			iph->check = ip_fast_csum(iph, iph->ihl);
+		}
+
+		seg_remaining = seg_payload;
+		while (seg_remaining > 0) {
+			unsigned int chunk = min_t(unsigned int, tso.size,
+						   seg_remaining);
+
+			memcpy(skb_put(seg, chunk), tso.data, chunk);
+			tso_build_data(skb, &tso, chunk);
+			seg_remaining -= chunk;
+		}
+
+		total_payload -= seg_payload;
+
+		seg->ip_summed = CHECKSUM_UNNECESSARY;
+
+		if (nsim_forward_skb(dev, peer_dev, seg, rq, NULL) == NET_RX_DROP)
+			continue;
+
+		total_len += hdr_len + seg_payload;
+	}
+
+	if (!hrtimer_active(&rq->napi_timer))
+		hrtimer_start(&rq->napi_timer, us_to_ktime(5),
+			      HRTIMER_MODE_REL);
+
+	rcu_read_unlock();
+	dev_kfree_skb(skb);
+	dev_dstats_tx_add(dev, total_len);
+	return NETDEV_TX_OK;
+
+out_drop_free:
+	dev_kfree_skb(skb);
+	rcu_read_unlock();
+	dev_dstats_tx_dropped(dev);
+	return NETDEV_TX_OK;
+}
+
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
@@ -129,6 +222,10 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	int rxq;
 	int dr;
 
+	if (skb_is_gso(skb) &&
+	    skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
+		return nsim_uso_segment_xmit(dev, skb);
+
 	rcu_read_lock();
 	if (!nsim_ipsec_tx(ns, skb))
 		goto out_drop_any;
@@ -986,7 +1083,8 @@ static void nsim_setup(struct net_device *dev)
 			    NETIF_F_HW_CSUM |
 			    NETIF_F_LRO |
 			    NETIF_F_TSO |
-			    NETIF_F_LOOPBACK;
+			    NETIF_F_LOOPBACK |
+			    NETIF_F_GSO_UDP_L4;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
 	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_HW_OFFLOAD;
-- 
2.52.0


