Return-Path: <netdev+bounces-285876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCgxBp75/WnYlQAAu9opvQ
	(envelope-from <netdev+bounces-285876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:56:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5424F82E3
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11C53302997A
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 14:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CCE3F787D;
	Fri,  8 May 2026 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y66C6sfo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8E43F6600
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252047; cv=none; b=c9X0kcNb1aIDr4ieSYvWIKoW6hNb3T/ZlhHjlLIp36SEpgJoQiJWsUPgpqMWLiMzhG/BQh2WuT7CsaKXioaLNfKbrtg1HTEB/qThmQM/iX8qEDLJTfTHsUJXGT7qihNYLJvUnyzoizJp+jTE24evupkZuDuyDyAyINs8jcR+u8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252047; c=relaxed/simple;
	bh=Jie18w538Ct7x3CbVmimV1bnCHwry8E9OuWrmJ6cumQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e+HxSYEwWsPb9Jj/I4W6R2O27Gy7LCFC/3yuX49nISai5mvR/XWv70EhWbgXBFfpq3VVr2GPIkalPz+1rBF05JZw0IfmD7MWToTIjG2EbHDmXUu86JcvP741YKkKMVzs/DzR4/cedKOH11jGJ4bjRmzWe2mHKf09lKBYyxcsIJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y66C6sfo; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-697bcc9d769so1126800eaf.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 07:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252044; x=1778856844; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/pc5hm9zFh0GvB9s3uy8ydQwYAOR2n93oEpCRRyHbDs=;
        b=Y66C6sfoXs7fYH05OJUcRJvV1jKRTahMqbmBEEFc6pEwM+vnFILwFzy7oiJXwAHzJq
         6McZilUcNdRmcBLdk8wUWGTDGi8xFdx5+vN5U8dMJzPWm7+J7IRSBj9Dj5DcL14iF9RV
         datUsrsz1sGfWsFhp8DI/u1SQCPSNebZsTKQgiRM0LA2VJciSkEzIq73hEsG7dSejPog
         2qPxIpJaS6kJkpUxi7irYcXACruv6ugox/eDmjy1ulmESnQ6wJ+zAgzy63hMz67syz8q
         2+V7KFNL9U/7MaTHkDQ9g8MAAp9iQJIrWgBmGBa/48n7HyUNPaBXGWui2NgQv936MSt+
         cRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252044; x=1778856844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/pc5hm9zFh0GvB9s3uy8ydQwYAOR2n93oEpCRRyHbDs=;
        b=WvylI8AarwWs+V6la4XpOe6SIXrxAho3ah/RvBDkelK1JKSdSbhLs4HRiqsIXMVFFw
         IEi+2VKweBUNXlMQ+xm0OY1C8pzhkTnGgTJ/FemyxYy8jhyf3aACvGL+7x950vbAelv7
         OeYSMBSSNCzqIGDeTdQzv03DvpqGnvkiDxo6BVNctX0I2Q07+bl0rr0n9SLutR6ZbbdX
         EnbaysPmq5vHIzN/x6Otg0uXIuBuwxTxbVk7SSsLS28cA2DK2Jp3q0n67kP6gPTCwUYM
         cZYM/BvgE2YH/GKv17ye79uxOaSrlc4UyhnJv/bt4wU6SxY5SgiXxf7L92o2Kmqx7Dzh
         GwoA==
X-Gm-Message-State: AOJu0YxdVVJ/MfX/Rjak0jfWyd1h4UnfFdeCr/ZjpAP3Sri4UQKoihtK
	Y3B8vRK7L/4gCgKTxufVwUmOxsFZhCvwDmoiSbufvHFQUY7PdzVI8kHYKU01SQ==
X-Gm-Gg: AeBDiesKk6qg4EHwhWI+nzVbKBuZuPDHVOOSZnvq/v1SWfLKQG6e/Vob5ukXKOlM/2e
	kyJXnkwMfYyS8Y9Yws5B5CkCieeGpyDVa2jDlCv5pA5DENPZgSB+hCnVt0ZiwW9csdgD6TuHIMR
	U3gGulqW7IcnVZ7KVq/OdNjkdx0ujCwN1Hj/oywbvcMU04OXtyTu5Of6dSIa2zdSLs7JORhZVNV
	NVkLNUS9d7QBPtZjM3KXLxQkWwj8fueJvC2lTHvpL/JFMKrP1YejgMreFGcWBv0IKoyEo/jnLhd
	PZbGkQb3oLC9Pk3TPw443S18wlKb2iS9/6j9DzIMpeO/gAJi0oBJ/2Wpx10iomfJj97/TCkl13n
	0ui3sedn8+Nv87kAdPNwEaaq0LDPc4787+x5JgqHQtSygQTqZsG02neuR7RxyQDfR24DHuUV6yy
	IVEpyy0R4IB9KlVgmngQT4pH8cK8ZxuGciT2xjo6ttxfEpZ27jtKeplH8LRXV/BXNVAAQyOvMRD
	Q==
X-Received: by 2002:a05:6820:1c92:b0:694:a17f:759d with SMTP id 006d021491bc7-69998d1d6damr7091353eaf.28.1778252044172;
        Fri, 08 May 2026 07:54:04 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4f::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25e0dbb5sm1108003eaf.13.2026.05.08.07.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 07:54:03 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 08 May 2026 07:53:48 -0700
Subject: [PATCH net-next 5/6] netdevsim: psp: add real aes-gcm encryption
 and decryption
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-nsim-psp-crypto-v1-5-4b50ed09b794@gmail.com>
References: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
In-Reply-To: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 0E5424F82E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285876-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Implement real AES-GCM-128/256 encryption and decryption for PSP
packets in the netdevsim driver, and remove gmac from supported
versions.

We now have to add and remove the PSP ICV trailer from packets. We
linearize skb's because the aesgcm crypto library does not work on
non-linear buffers.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/Kconfig         |  1 +
 drivers/net/netdevsim/psp.c | 98 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 44a220c05536..2d21ba13de15 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -611,6 +611,7 @@ config NETDEVSIM
 	select PAGE_POOL
 	select NET_SHAPER
 	select CRYPTO_LIB_AES_CBC_MACS if INET_PSP
+	select CRYPTO_LIB_AESGCM if INET_PSP
 	help
 	  This driver is a developer testing tool and software model that can
 	  be used to test various control path networking APIs, especially
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 8cdb88b1e232..4945973d523d 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <crypto/aes-cbc-macs.h>
+#include <crypto/gcm.h>
+#include <linux/ip.h>
 #include <linux/random.h>
 #include <linux/skbuff.h>
+#include <linux/timekeeping.h>
 #include <linux/unaligned.h>
 #include <net/psp.h>
 #include <net/sock.h>
@@ -44,9 +47,17 @@ enum skb_drop_reason
 nsim_psp_handle_tx(struct sk_buff *skb, struct netdevsim *ns)
 {
 	enum skb_drop_reason rc = 0;
+	u8 iv[GCM_AES_IV_SIZE];
+	struct aesgcm_ctx ctx;
 	struct psp_assoc *pas;
+	unsigned int key_size;
+	struct psphdr *psph;
+	int payload_len;
 	struct net *net;
+	u8 *authtag;
+	int psp_off;
 	void **ptr;
+	int err;
 
 	rcu_read_lock();
 	pas = psp_skb_get_assoc_rcu(skb);
@@ -72,12 +83,52 @@ nsim_psp_handle_tx(struct sk_buff *skb, struct netdevsim *ns)
 		goto out_unlock;
 	}
 
+	key_size = psp_key_size(pas->version);
+	err = aesgcm_expandkey(&ctx, pas->tx.key, key_size, PSP_TRL_SIZE);
+	if (err) {
+		rc = SKB_DROP_REASON_PSP_OUTPUT;
+		goto out_unlock;
+	}
+
+	if (skb_linearize_cow(skb) ||
+	    (skb_tailroom(skb) < PSP_TRL_SIZE &&
+	     pskb_expand_head(skb, 0, PSP_TRL_SIZE, GFP_ATOMIC))) {
+		rc = SKB_DROP_REASON_PSP_OUTPUT;
+		goto out_unlock;
+	}
+	skb_put(skb, PSP_TRL_SIZE);
+
+	if (skb->protocol == htons(ETH_P_IP)) {
+		be16_add_cpu(&ip_hdr(skb)->tot_len, PSP_TRL_SIZE);
+		ip_send_check(ip_hdr(skb));
+	} else if (skb->protocol == htons(ETH_P_IPV6)) {
+		be16_add_cpu(&ipv6_hdr(skb)->payload_len, PSP_TRL_SIZE);
+	}
+	be16_add_cpu(&udp_hdr(skb)->len, PSP_TRL_SIZE);
+
+	psph = (struct psphdr *)(skb_transport_header(skb) +
+				sizeof(struct udphdr));
+
+	/* Real impl needs to guarantee IV isn't reused on the same key */
+	psph->iv = cpu_to_be64(ktime_get_mono_fast_ns());
+	memcpy(iv, &psph->spi, sizeof(psph->spi));
+	memcpy(iv + sizeof(psph->spi), &psph->iv, sizeof(psph->iv));
+	psp_off = skb_transport_offset(skb) + sizeof(struct udphdr);
+	payload_len = skb->len - psp_off - PSP_HDR_SIZE - PSP_TRL_SIZE;
+	authtag = skb->data + skb->len - PSP_TRL_SIZE;
+
+	aesgcm_encrypt(&ctx,
+		       skb->data + psp_off + PSP_HDR_SIZE,
+		       skb->data + psp_off + PSP_HDR_SIZE,
+		       payload_len, (u8 *)psph, PSP_HDR_SIZE,
+		       iv, authtag);
+	memzero_explicit(&ctx, sizeof(ctx));
+
 	skb->decrypted = 0;
 
 	u64_stats_update_begin(&ns->psp.syncp);
 	u64_stats_inc(&ns->psp.tx_packets);
-	u64_stats_add(&ns->psp.tx_bytes,
-		      skb->len - skb_inner_transport_offset(skb));
+	u64_stats_add(&ns->psp.tx_bytes, payload_len);
 	u64_stats_update_end(&ns->psp.syncp);
 out_unlock:
 	rcu_read_unlock();
@@ -87,12 +138,17 @@ nsim_psp_handle_tx(struct sk_buff *skb, struct netdevsim *ns)
 /* Returns true if skb was consumed, false otherwise. */
 bool nsim_psp_handle_rx(struct netdevsim *ns, struct sk_buff *skb)
 {
+	u8 iv[GCM_AES_IV_SIZE];
+	struct aesgcm_ctx ctx;
 	struct psp_dev *psd;
+	u8 key[PSP_MAX_KEY];
 	struct psphdr *psph;
+	unsigned int phase;
 	struct udphdr *uh;
 	int payload_len;
 	u32 versions;
 	int psp_off;
+	u8 *authtag;
 	bool is_udp;
 	int l3_hlen;
 	u8 version;
@@ -154,9 +210,41 @@ bool nsim_psp_handle_rx(struct netdevsim *ns, struct sk_buff *skb)
 	if (payload_len < 0)
 		goto drop;
 
+	if (FIELD_GET(PSPHDR_CRYPT_OFFSET, psph->crypt_offset))
+		goto drop;
+
+	if (skb_linearize_cow(skb))
+		goto drop;
+
+	psph = (struct psphdr *)(skb->data + psp_off);
+	phase = !!(ntohl(psph->spi) & PSP_SPI_KEY_PHASE);
+
+	spin_lock_bh(&ns->psp.dev_keys_lock);
+	nsim_psp_derive_key(ns->psp.dev_keys[phase], psph->spi, version, key);
+	spin_unlock_bh(&ns->psp.dev_keys_lock);
+
+	err = aesgcm_expandkey(&ctx, key, psp_key_size(version), PSP_TRL_SIZE);
+	memzero_explicit(key, sizeof(key));
+	if (err)
+		goto drop;
+
+	memcpy(iv, &psph->spi, sizeof(psph->spi));
+	memcpy(iv + sizeof(psph->spi), &psph->iv, sizeof(psph->iv));
+	authtag = skb->data + skb->len - PSP_TRL_SIZE;
+
+	if (!aesgcm_decrypt(&ctx,
+			    skb->data + psp_off + PSP_HDR_SIZE,
+			    skb->data + psp_off + PSP_HDR_SIZE,
+			    payload_len, (u8 *)psph, PSP_HDR_SIZE,
+			    iv, authtag)) {
+		memzero_explicit(&ctx, sizeof(ctx));
+		goto drop;
+	}
+	memzero_explicit(&ctx, sizeof(ctx));
+
 	skb_push(skb, ETH_HLEN);
 	skb->mac_len = ETH_HLEN;
-	err = psp_dev_rcv(skb, psd_id, 0, false);
+	err = psp_dev_rcv(skb, psd_id, 0, true);
 	if (err)
 		goto drop;
 
@@ -274,9 +362,7 @@ static struct psp_dev_ops nsim_psp_ops = {
 
 static struct psp_dev_caps nsim_psp_caps = {
 	.versions = 1 << PSP_VERSION_HDR0_AES_GCM_128 |
-		    1 << PSP_VERSION_HDR0_AES_GMAC_128 |
-		    1 << PSP_VERSION_HDR0_AES_GCM_256 |
-		    1 << PSP_VERSION_HDR0_AES_GMAC_256,
+		    1 << PSP_VERSION_HDR0_AES_GCM_256,
 	.assoc_drv_spc = sizeof(void *),
 };
 

-- 
2.52.0


