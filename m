Return-Path: <netdev+bounces-270677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFgaFT2LwWlxTwQAu9opvQ
	(envelope-from <netdev+bounces-270677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:49:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EB12FB913
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D99A30EF380
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1885F3BC68C;
	Mon, 23 Mar 2026 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="B9O+J6HS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BE33D5240
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291166; cv=none; b=gMPwbiGHazyuGFdncyL+19gB5K5OJqfPaGUoPHEX5HJ7nd8fdF1Fpp+1Nqci4aDEmO4lFVx9MxcgshUD3bO0As59CA+GH33HMdX/wZATyJ/b0KRYGqFu0zEtch1GhYMr6Js1X3yoYag/kyXzIWPwu4YByWKXg09Uzy/Qo1n6Ix8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291166; c=relaxed/simple;
	bh=uWnYZfxpXWzMEdoD4OoQj78mYr7rYihNxdLMDApkweE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YY8vdRUnGpruKrPziupgClcfbJrI/TusnQWv41YJSm1BNuBsKpC6roglyCxRtDqS/Jm2Yf8iIEv1quxUhhhsFhwDdg5XOK+7w1+EljD/9Q35eD26RzpWxldwCAuCu1lIe226JzL7Y5VsibjPFXy368YcEQxfDQ4n6NpCE/ES1d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=B9O+J6HS; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35a1cc6e478so301435a91.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774291160; x=1774895960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGwTwQhNH9Rzs+EHOpg8GEhPLriykUGXInx1g7lVTBM=;
        b=B9O+J6HSsJWNg3SHA+JGq5LDdFSMOBFt6wlHUMEHU9WK/PPYiU2RnOj5LHNDfrEMtK
         CVyM0Kv+vZ7JnugSubFL7k0HooL/PyksbjvGl/O6Nmu+K02+D2FQJxSTTM3I+0CNrf1M
         SNob16SGynY35ntATZfC9C7SJ2eKNyBwWe2Nh4+h+RLgQ8E4rEkOzCUoZz4XvzV6CXk3
         9joAb+Wip6lnPrSMDDAlCn1TlWae+NJ7YJavkZkvLNJyGx/P/cxdQhk2KYn/uxBPXhUw
         fQwF1e4wvEUkN2PzTIozYOx4s9d0tG1P3gQjkdsFg/HdqB2io+HFHIgq+AIlJmwoAMCs
         H8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291160; x=1774895960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lGwTwQhNH9Rzs+EHOpg8GEhPLriykUGXInx1g7lVTBM=;
        b=tVNEDxfxKQZnkShvKaojxsZHpFmYLqg6fXcbkXoYOKLpYRYhrazEfT2rRwKBxk5K9+
         9iph3eqjK0Cv7LXtsutk5BTuhX6GAJvs0YcgqMh3Mk7gGnN0azDYuRPTy/3Pap75z916
         ftu2JFVqDsDgkdJsxyjCmPTBj54FVqqI65xkVcwEPLTxfHHXHHlCobbUiw/1KjUZXSJY
         kAuPYpAOXfyKC1F7rJ29lUL3vNXgtrcO+1FLU1CRUJNfJgg11mpFHU26B6IDsve/WFss
         TrLR69WWYvLs/b8rF25A5UFt85OM75liZO4/F1UqxofgdXqhBNrlLDAFQz53+1uFG4tz
         3jrA==
X-Gm-Message-State: AOJu0Yw+gI5OUhI1wvaQ8uyrV0LuIFL/QRn7KnAyYMkHgzDC4ZYesESH
	24iUvtAei6Cbp9453F3e+/cNi4xNxZd2GWT30ga00EQ5ZFOWFW37NxI+RcRVT7bJr1LDq9S+iPj
	713kFEOE=
X-Gm-Gg: ATEYQzxanbSH17PmEew8sfWpeZuCCTaW1KhFP81xZLyGAMbeIBxXDNrkGGYKu/O+6qi
	/bdy56rScFS50JbXXLWlgjOA0F8D07rMDk2nh5OI5cIeBMzfSqEKdE8fl7SH8B/EBVxvFb3jRB6
	WbIEwKDsScuAK+iR3MvI4qwSYo9MxvW//MobTse3iZW9zHQbDUtBj47nKJBJ11Ro/kMdjE4pnaK
	7rvrGs3kJFzu8ZrcbjztXo026lmVND9rV//J3b+xfCpz6ax+tucrcRC1+30zkmiV1Dk8QObMttn
	2jG+M0UlU4Ep4siHstqvkuqvmcwyy6JGzFMzb3H3F1d+vLlWUMJFuj77/zFOyFn+R281yJY9xds
	alL2SSup9RbDuZ/8q8QsDEWKYcKZpzv53uJRzDWTNcIGchAWMjsJKwB+V4hRamaXXtvaF75ceBM
	9UAtWMhZoSvUI=
X-Received: by 2002:a17:90b:3d02:b0:358:db7b:f686 with SMTP id 98e67ed59e1d1-35bd2cece11mr10315385a91.26.1774291160417;
        Mon, 23 Mar 2026 11:39:20 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd4130765sm10100901a91.16.2026.03.23.11.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:39:19 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v5 11/12] net: netdevsim: Add support for SW USO
Date: Mon, 23 Mar 2026 11:38:36 -0700
Message-ID: <20260323183844.3146982-12-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260323183844.3146982-1-joe@dama.to>
References: <20260323183844.3146982-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-270677-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email,dama.to:email,dama.to:mid,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D0EB12FB913
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for UDP Segmentation Offloading in software (SW USO). This
is helpful for testing when real hardware is not available. A test which
uses this codepath will be added in a following commit.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v5:
   - Added Pavan's Reviewed-by. No functional changes.

 v4:
   - Added parentheses around the gso_type check for clarity. No functional
     change.

 rfcv2:
   - new in rfcv2

 drivers/net/netdevsim/netdev.c | 100 ++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index c71b8d116f18..f228bcf3d190 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -30,6 +30,7 @@
 #include <net/rtnetlink.h>
 #include <net/udp_tunnel.h>
 #include <net/busy_poll.h>
+#include <net/tso.h>
 
 #include "netdevsim.h"
 
@@ -120,6 +121,98 @@ static int nsim_forward_skb(struct net_device *tx_dev,
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
@@ -132,6 +225,10 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	int rxq;
 	int dr;
 
+	if (skb_is_gso(skb) &&
+	    skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
+		return nsim_uso_segment_xmit(dev, skb);
+
 	rcu_read_lock();
 	if (!nsim_ipsec_tx(ns, skb))
 		goto out_drop_any;
@@ -938,7 +1035,8 @@ static void nsim_setup(struct net_device *dev)
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


