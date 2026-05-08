Return-Path: <netdev+bounces-285874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIx6GnT5/WlilQAAu9opvQ
	(envelope-from <netdev+bounces-285874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:55:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 739B64F82CC
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF6573018D4C
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 14:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829B83FB7F4;
	Fri,  8 May 2026 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCGIrpTP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB523FA5F9
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252045; cv=none; b=rCoRzS9TdoU5knTq5pxmmcMbDGPxfWdVwQW/YVGgWk8s66rkUG9reXBPmFKJpPIUI0foYDrCw/8Ka5DsKW7ckPvHzqCZyOjkIj7XRRlWWGyWS+SGMhqqfKJuKEtMvgn2PghGN7jZqakpIOXsopfrM36H0ORWcyMB8nJ3UKnZSwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252045; c=relaxed/simple;
	bh=4rUe0GE39WnEOhgpkhyqxnVyQIK5B+AS+6s0cJLDi2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FqHriNbhL3H8xUDNru9tqG6sZ9KeJrbs7B2e2Y6mRpI0Rq502w4B/HpeqDvjvteS4//TW3OLtrLnyT9VX3+9mT99cUGwOFC4CXFyjAdhVTKWFtliMe5QnTAR/XPq+nuQm7LRwtz0VAFyQLT+qG+nPKJwurXGFHv5yox8DtRFsUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCGIrpTP; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-42fbf95cca8so1572379fac.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 07:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252041; x=1778856841; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edNVxC7/EX13maCPvj5hXjKR9NoEcXJSooB20xW4P3g=;
        b=mCGIrpTP2qDMUfDehJ2fXUmz30dTunmnu1xKMzGz+a4V93jOjoiQTvmOcmFfSEkt3n
         GUgKtr4qVyXdiQMbtE4oBmACnNqNcV0uLZOqyNQl0obrPNvoc0p4ZHuvQD9XX6iaTUe9
         +I+7XtmdgO+pBT6IJAGhxDtseJipNlhErP/tzOR2FRQH0ndtDgI0c3K3LFR+bchJblV0
         XvSONjmEkUjz7mxsfXCnhzwreq1zfG76v9SuJebzmL4qwElnHtcOmX1rJO5OGI8bhbva
         Woh1xsNt4eRMjVD18oEvmXvKf86pvZsq7IQNS/qqgz0sZKNCu3LafBESS5OdlKPOLJnK
         WU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252041; x=1778856841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=edNVxC7/EX13maCPvj5hXjKR9NoEcXJSooB20xW4P3g=;
        b=s9y+mz5a7bD5L4o/zCtqZh6SKLZeXq1k55w/dwbAQk1w8hldEw6+bJDwNNRetu9Q1I
         CE8+1zHdpTlCa9l5IxNJLlrnnE9z9rhsO2qwinxRYU63blRKUpNFvPhm09DohmxatETj
         KoZ6wG8xIy64CaEcChktcXXwYlTpsQq9KXfvTXln66vZMQIZB9QIMl2Y02OMesk0VMR5
         ZzONCdN000O7rxr1OyWnwKpsUQbJ5nz1Rth0/eBfNO4UGaLFSipvJGbgzAHzLcVsubZv
         DGw6M+5UvTYGHIZWtmzchPQo1lg7DO35XIyM5fnzh85jEky0vof7Cfw26AFStbcpoMSa
         5wRQ==
X-Gm-Message-State: AOJu0YxR+mlDLmTt9zs4sWIAMW+woeoEvbeYjk0U4nuAML5NYdDe5cTI
	+oUyFZxGadiRv3lWv4GAQXSclNparGW4KzxSTYON/VFXSLNNEUCn4eA65BZGLA==
X-Gm-Gg: AeBDieuWBzMatHor8ecy4yfunGQuUgiBwIoQj0+I3ldrPreqp4RhtMhTWQ6eqyfqsYg
	5jynolnROwGXKxUbXoSYDk5laoB9njV/AfjhBoHC0dXfDjrKU7uAAvsdIWUtwULWTbox+R0uvaQ
	6KRcjDY1VivrxWRzjhwosjWQ8NOeW4weCmFrciN1zkLHcEr9B+tzv4wOeKWh5zD5SNajVhjC/HE
	M8mZNLhoz+Epmt1gRfS4RPt+AHI+9fcuv+VHR/83gaVdi4xVA437wPZvsLd2dMW1WucuIjbko9W
	qJchjbdwPvmNMwuRglBY+fiBRhf0VUOID7vYhfzD+58VWdZcprv/RrvImNhIRByoJ2+lSPQiMjP
	HStO+Ka/FxcKHfKshqp3P8jb98pXHDCn36OHgjI+AXYEoO9J0MCL7QkxTzV/A2lX6GspvRmSe1K
	AXMUZdtcm2yQxHWOoTaAUM+Bd1BwBXXZVNkoFNfZi+Xz/Zlqy/dRmGOXBPQN00y+4y6ESxLYOIL
	A==
X-Received: by 2002:a05:6870:f617:b0:433:ce4d:c211 with SMTP id 586e51a60fabf-43556b27b5bmr1741882fac.7.1778252041495;
        Fri, 08 May 2026 07:54:01 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-435573e90c1sm1849809fac.16.2026.05.08.07.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 07:54:01 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 08 May 2026 07:53:46 -0700
Subject: [PATCH net-next 3/6] netdevsim: psp: move rx processing into
 nsim_poll()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-nsim-psp-crypto-v1-3-4b50ed09b794@gmail.com>
References: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
In-Reply-To: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 739B64F82CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285874-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[psp.py:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

nsim_do_psp() does PSP decap and skb extension creation in the tx
path. This has the slightly undesirable property of not allowing the
psp rx code to run on PSP packets cooked up in userspace and
transmitted on a packet socket from the peer dev (e.g. packetdrill).

This commit instead triggers the psp rx path just based on parsing the
received skb. The current code relies on a bit of a hack to simulate
authentication with the proper key: the peer's psd->generation was
placed into the tx key, and during decap used to fill out the
extension the packet before being sent up the psp rx path. This commit
removes that hack, which creates a transient break in psp.py test
cases that rely on this behavior (e.g. data_send_bad_key). Subsequent
commits which introduce real aes-gcm crypto will restore the correct
behavior.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/netdevsim/netdev.c    |  18 ++---
 drivers/net/netdevsim/netdevsim.h |  14 ++--
 drivers/net/netdevsim/psp.c       | 143 ++++++++++++++++++++++++++------------
 3 files changed, 113 insertions(+), 62 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index a750768912b5..9c0db7b91fd6 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -103,19 +103,13 @@ static int nsim_napi_rx(struct net_device *tx_dev, struct net_device *rx_dev,
 static int nsim_forward_skb(struct net_device *tx_dev,
 			    struct net_device *rx_dev,
 			    struct sk_buff *skb,
-			    struct nsim_rq *rq,
-			    struct skb_ext *psp_ext)
+			    struct nsim_rq *rq)
 {
 	int ret;
 
 	ret = __dev_forward_skb(rx_dev, skb);
-	if (ret) {
-		if (psp_ext)
-			__skb_ext_put(psp_ext);
+	if (ret)
 		return ret;
-	}
-
-	nsim_psp_handle_ext(skb, psp_ext);
 
 	return nsim_napi_rx(tx_dev, rx_dev, rq, skb);
 }
@@ -123,7 +117,6 @@ static int nsim_forward_skb(struct net_device *tx_dev,
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
-	struct skb_ext *psp_ext = NULL;
 	struct net_device *peer_dev;
 	unsigned int len = skb->len;
 	struct netdevsim *peer_ns;
@@ -147,7 +140,7 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		peer_dev = peer_ns->netdev;
 	}
 
-	dr = nsim_do_psp(skb, ns, peer_ns, &psp_ext);
+	dr = nsim_psp_handle_tx(skb, ns);
 	if (dr)
 		goto out_drop_free;
 
@@ -165,7 +158,7 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	skb_tx_timestamp(skb);
 	if (unlikely(nsim_forward_skb(dev, peer_dev,
-				      skb, rq, psp_ext) == NET_RX_DROP))
+				      skb, rq) == NET_RX_DROP))
 		goto out_drop_cnt;
 
 	if (!hrtimer_active(&rq->napi_timer))
@@ -379,6 +372,9 @@ static int nsim_rcv(struct nsim_rq *rq, int budget)
 
 		skb = skb_dequeue(&rq->skb_queue);
 
+		if (nsim_psp_handle_rx(ns, skb))
+			continue;
+
 		if (xdp_prog) {
 			/* skb might be freed directly by XDP, save the len */
 			skblen = skb->len;
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index d909c4160ea1..dcea76429bac 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -451,22 +451,22 @@ static inline void nsim_macsec_teardown(struct netdevsim *ns)
 #if IS_ENABLED(CONFIG_INET_PSP)
 int nsim_psp_init(struct netdevsim *ns);
 void nsim_psp_uninit(struct netdevsim *ns);
-void nsim_psp_handle_ext(struct sk_buff *skb, struct skb_ext *psp_ext);
 enum skb_drop_reason
-nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
-	    struct netdevsim *peer_ns, struct skb_ext **psp_ext);
+nsim_psp_handle_tx(struct sk_buff *skb, struct netdevsim *ns);
+bool nsim_psp_handle_rx(struct netdevsim *ns, struct sk_buff *skb);
 #else
 static inline int nsim_psp_init(struct netdevsim *ns) { return 0; }
 static inline void nsim_psp_uninit(struct netdevsim *ns) {}
 static inline enum skb_drop_reason
-nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
-	    struct netdevsim *peer_ns, struct skb_ext **psp_ext)
+nsim_psp_handle_tx(struct sk_buff *skb, struct netdevsim *ns)
 {
 	return 0;
 }
 
-static inline void
-nsim_psp_handle_ext(struct sk_buff *skb, struct skb_ext *psp_ext) {}
+static inline bool nsim_psp_handle_rx(struct netdevsim *ns, struct sk_buff *skb)
+{
+	return false;
+}
 #endif
 
 int nsim_setup_tc(struct net_device *dev, enum tc_setup_type type,
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 75740e2a731f..e8831d4bf394 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -6,18 +6,10 @@
 
 #include "netdevsim.h"
 
-void nsim_psp_handle_ext(struct sk_buff *skb, struct skb_ext *psp_ext)
-{
-	if (psp_ext)
-		__skb_ext_set(skb, SKB_EXT_PSP, psp_ext);
-}
-
 enum skb_drop_reason
-nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
-	    struct netdevsim *peer_ns, struct skb_ext **psp_ext)
+nsim_psp_handle_tx(struct sk_buff *skb, struct netdevsim *ns)
 {
 	enum skb_drop_reason rc = 0;
-	struct psp_dev *peer_psd;
 	struct psp_assoc *pas;
 	struct net *net;
 	void **ptr;
@@ -46,47 +38,110 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 		goto out_unlock;
 	}
 
-	/* Now pretend we just received this frame */
-	peer_psd = rcu_dereference(peer_ns->psp.dev);
-	if (peer_psd && peer_psd->config.versions & (1 << pas->version)) {
-		bool strip_icv = false;
-		u8 generation;
-
-		/* We cheat a bit and put the generation in the key.
-		 * In real life if generation was too old, then decryption would
-		 * fail. Here, we just make it so a bad key causes a bad
-		 * generation too, and psp_sk_rx_policy_check() will fail.
-		 */
-		generation = pas->tx.key[0];
-
-		skb_ext_reset(skb);
-		skb->mac_len = ETH_HLEN;
-		if (psp_dev_rcv(skb, peer_psd->id, generation, strip_icv)) {
-			rc = SKB_DROP_REASON_PSP_OUTPUT;
-			goto out_unlock;
-		}
-
-		*psp_ext = skb->extensions;
-		refcount_inc(&(*psp_ext)->refcnt);
-		skb->decrypted = 1;
-
-		u64_stats_update_begin(&ns->psp.syncp);
-		u64_stats_inc(&ns->psp.tx_packets);
-		u64_stats_inc(&ns->psp.rx_packets);
-		u64_stats_add(&ns->psp.tx_bytes,
-			      skb->len - skb_inner_transport_offset(skb));
-		u64_stats_add(&ns->psp.rx_bytes,
-			      skb->len - skb_inner_transport_offset(skb));
-		u64_stats_update_end(&ns->psp.syncp);
-	} else {
-		skb->ip_summed	= CHECKSUM_NONE;
-	}
+	skb->decrypted = 0;
 
+	u64_stats_update_begin(&ns->psp.syncp);
+	u64_stats_inc(&ns->psp.tx_packets);
+	u64_stats_add(&ns->psp.tx_bytes,
+		      skb->len - skb_inner_transport_offset(skb));
+	u64_stats_update_end(&ns->psp.syncp);
 out_unlock:
 	rcu_read_unlock();
 	return rc;
 }
 
+/* Returns true if skb was consumed, false otherwise. */
+bool nsim_psp_handle_rx(struct netdevsim *ns, struct sk_buff *skb)
+{
+	struct psp_dev *psd;
+	struct psphdr *psph;
+	struct udphdr *uh;
+	int payload_len;
+	u32 versions;
+	int psp_off;
+	bool is_udp;
+	int l3_hlen;
+	u8 version;
+	u32 psd_id;
+	int err;
+
+	if (skb->protocol == htons(ETH_P_IP)) {
+		struct iphdr *iph;
+
+		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+			return false;
+
+		iph = (struct iphdr *)skb->data;
+		if (iph->ihl < 5)
+			return false;
+
+		is_udp = iph->protocol == IPPROTO_UDP;
+		l3_hlen = iph->ihl * 4;
+	} else if (skb->protocol == htons(ETH_P_IPV6)) {
+		struct ipv6hdr *ip6h;
+
+		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
+			return false;
+		ip6h = (struct ipv6hdr *)skb->data;
+		is_udp = ip6h->nexthdr == IPPROTO_UDP;
+		l3_hlen = sizeof(struct ipv6hdr);
+	} else {
+		return false;
+	}
+
+	if (!is_udp)
+		return false;
+
+	if (!pskb_may_pull(skb, l3_hlen + sizeof(struct udphdr) + PSP_HDR_SIZE))
+		return false;
+
+	uh = (struct udphdr *)(skb->data + l3_hlen);
+	if (uh->dest != htons(PSP_DEFAULT_UDP_PORT))
+		return false;
+
+	psph = (struct psphdr *)(uh + 1);
+	version = FIELD_GET(PSPHDR_VERFL_VERSION, psph->verfl);
+
+	rcu_read_lock();
+	psd = rcu_dereference(ns->psp.dev);
+	if (psd) {
+		versions = READ_ONCE(psd->config.versions);
+		psd_id = psd->id;
+	}
+	rcu_read_unlock();
+
+	if (!psd || !(versions & (1 << version))) {
+		skb->ip_summed = CHECKSUM_NONE;
+		return false;
+	}
+
+	psp_off = l3_hlen + sizeof(struct udphdr);
+	payload_len = skb->len - psp_off - PSP_HDR_SIZE - PSP_TRL_SIZE;
+	if (payload_len < 0)
+		goto drop;
+
+	skb_push(skb, ETH_HLEN);
+	skb->mac_len = ETH_HLEN;
+	err = psp_dev_rcv(skb, psd_id, 0, false);
+	if (err)
+		goto drop;
+
+	skb_reset_mac_header(skb);
+	skb_pull(skb, ETH_HLEN);
+	skb->decrypted = 1;
+
+	u64_stats_update_begin(&ns->psp.syncp);
+	u64_stats_inc(&ns->psp.rx_packets);
+	u64_stats_add(&ns->psp.rx_bytes, payload_len);
+	u64_stats_update_end(&ns->psp.syncp);
+
+	return false;
+
+drop:
+	kfree_skb_reason(skb, SKB_DROP_REASON_PSP_INPUT);
+	return true;
+}
+
 static int
 nsim_psp_set_config(struct psp_dev *psd, struct psp_dev_config *conf,
 		    struct netlink_ext_ack *extack)

-- 
2.52.0


