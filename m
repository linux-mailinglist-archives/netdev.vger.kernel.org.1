Return-Path: <netdev+bounces-269942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ14ObRdvWl09QIAu9opvQ
	(envelope-from <netdev+bounces-269942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:46:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B922DBFD4
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BCA0302C288
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC27A3CD8D6;
	Fri, 20 Mar 2026 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="bh2smwQ/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ABA3CD8B4
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017733; cv=none; b=JDC3BB3nudBWAIKSaKiquQuXs97u1/o9fI8noRSVszIP9n8MevEoLSxnVpuNJ6td8X0s6uF64rHdG50W7vmhcErnTbJzZda1vcRcb7fvKEJ1pixKy62ZV3by1MaUBCnmO6asD4x74HSbxQAwfu5W86dhEHUJAL8HiohERMbRpV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017733; c=relaxed/simple;
	bh=tk6yIcgDNmYbIICltKD6OaLCHNSA9DvyfvCudVZWJRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cijE13u1/1WW8s1OFmzT6NUb1SjSC0H9ZIbtFA3wAK6hJE9BRvnn0we/RIzoqMs8mwTVO9gok8oi0TeqMoNKmbtbUc/3bc4i8nvgJMsJ5qpsckmxDPsiGBAyMo+J1huvVX2NywWRn72uWNLnKlKRw7J6ChTkmX5jskGHj2PTM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=bh2smwQ/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82c20b9fb16so160490b3a.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774017731; x=1774622531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGXsa+qFOM0/tzQzSS33c8kc0mVqkh8Ml/C2OypIk08=;
        b=bh2smwQ/tGrl5yHrGGZbNYyHFi67UFFscGfjrDg2+A2uFyECYF+WZii3j1O0DTOhdW
         0Pi4cD/FB7UmMHC+HkaFwRn93e9dp8T0eJSrN+NvVyiuthkqbVGLtCpCajeqdmLXMxDc
         J6jIeVQGMyQWNYBuUBiOLYljGkp3h1RRKYHl4HZuEM/EaIPhdg9RoJDLKHaNzByGWhIf
         8Ks/5s9J2SGTrnje8ptb+1TuQBCXRMpBzgbhNgkjNA2X/CiOomZqopvMnuQ5OcBerLQx
         9khbclzZ1czhwulgPnMuHmF5XrcN6Am6+E463OlqTZUnjUeATi/jSnYY2L7Wj5JGHRz+
         ZyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774017731; x=1774622531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rGXsa+qFOM0/tzQzSS33c8kc0mVqkh8Ml/C2OypIk08=;
        b=dr6nWlo86XIhUxqW5hNC/i2Jlbl6uSCsANB1fxXG2VEzzRAPOGVa+viGvjk6jxaU0A
         20wk/g0WVFdJmyWlx+fwaVqBMPgKs6lvPL1PWQfl/lC3BJ0PKki4nwzUjdtZq363CpYd
         GuaFhahGI5yt8dfqqUOIY8E0eal0vCZZB8uV6FgNrsCKxoNUVUh63p0SngDjLHylMEsY
         qLyfOtMY0mPmdLOHnvQ6e5wXxmU7w+UJBAdLC7BEKvzIWrwD0y2lgKlaxhmtnCysghUo
         sxv7Bo/aPbKTXn6OwgIi2tuTgROfLHEEHNwXZbz5wVBxmFBc1VxtkE1/UZx1iLqChnVm
         WuEA==
X-Gm-Message-State: AOJu0Yw9ZVhDhcfKCk85XgGdoiaHMilxLR1QwKV0shHXkvq5KzguYRK7
	pOPcJbkLCnNpMypRwsTSLLZ4QkedCEBwXziTzCxpbNvh6rQ9R5vxF3m3uPcuS7JTBrl7DJ+A9yv
	QsxilBrw=
X-Gm-Gg: ATEYQzyxp3yBPYrB+OHfDFmOv2Cd0LM4jv3klRJ0Pq9g3UWeI/SdXPa8BgMZ7nikvvM
	7aMGUijzmhTQAmz0FvWdSd6HDBjVqL5F8BW4zowEUq6Oqv+7//tLT574K+HPgi/dYPJ6JT+XS+M
	z6cU/vovdSd9xYfalSHh11Xh/wTLo0uJnzXbHnrT/lGUCJ1AyhEjE+QMYBs7ywOi/31WKyf32YV
	k+5NQk6XLGo1IGg7OoqPrOHzHNwrNFrEng/7ptNu/VprirCJpwodoh5GIMGFUCyWdINnJzYNBgP
	D/Z+KSiqMrSRUY56VY/BNSgyZttMwODGu2PuLfNS/wCfLRYMLkdUExKvbm5k3o5nAgGFbwD2FQH
	h0ZW81g1nQOoxpZNi7wnInbW2VL6iL4B2clJbGToXGRsbbUj8TzZyXEDNjTmQebm5/YYaWSw21K
	DaTUiuWBk/IJWJ1Mc=
X-Received: by 2002:a05:6a20:3948:b0:398:9fc9:e07c with SMTP id adf61e73a8af0-39bcea31be3mr2935202637.24.1774017731199;
        Fri, 20 Mar 2026 07:42:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b041059a5sm2844280b3a.53.2026.03.20.07.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:42:10 -0700 (PDT)
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
Subject: [net-next v4 11/12] net: netdevsim: Add support for SW USO
Date: Fri, 20 Mar 2026 07:41:32 -0700
Message-ID: <20260320144141.260246-12-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320144141.260246-1-joe@dama.to>
References: <20260320144141.260246-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-269942-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.987];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: 88B922DBFD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for UDP Segmentation Offloading in software (SW USO). This
is helpful for testing when real hardware is not available. A test which
uses this codepath will be added in a following commit.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v4:
   - Added parentheses around the gso_type check for clarity. No functional
     change.

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
+	    (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4))
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


