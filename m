Return-Path: <netdev+bounces-271681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLycGPUexGmZwgQAu9opvQ
	(envelope-from <netdev+bounces-271681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:44:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D669132A0B9
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F49630BBD7F
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E35406264;
	Wed, 25 Mar 2026 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fia0/wgW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0A9405ADA
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460179; cv=none; b=agHCSQKsUI3X7qGZ7GUxkUAWDYaXMJWko5FywCWvBIJwwA2Bj9QizwJSYZcTbmB+FqeMAM4+zyGd1aFvGKgDDv1hpezzUb1D/y/szOGnPDusuhvAgU8aZVA7KiOeSk4nrI7YkDm18GKimY7tJ2LpH+aZmFjArZYhbkj4fmqSPxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460179; c=relaxed/simple;
	bh=NbqbX7Vo+aSGj+EtIF7vTga7nxYvSK8AjrIqZ5ZSyJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D6Ohh7sNlvA9U/UOHc7YbVvc1tGjBzHZ6ra2td1HDFiCxJkXI3iAcSalNHNd5uyI/q4yIs6jcu4yVX4OkxO5w1pLYJdrN5+B6R4QwNKowxa1b38a39pYZfT5A//n0f7DkIf8u6u0EeDFsADKvlDCdxkt0SjnHX42MPsb9miRXD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fia0/wgW; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-35bb7afdc38so67321a91.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 10:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774460177; x=1775064977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hpuNbOoVHye+ZLHBqearhM+JMoJXrmzW+ATFoxVzxY=;
        b=oAgrYEkfvQ3BZoucfPmhfi1gLBHv5CPGnpZe9XprPrdrRvKHeIXyvVs0xRFJXDhN1D
         LLrqkoxONNty63Cju6zdtLkNH8YxNM3hUNmGfnPFA2yWZVxpKKqA0kDmhZJz2qtlW5TL
         wMJh4RZM56cjQQWfgcbcHoaLFJgmZXBKKBDdQRAdqwVsNOMB5hPaPkXU73mnwj6wfSfb
         WKLGqFM1SV0hYblutY1dQhyqxpNqyQA+WDqWwfsxzVEzEFplEj1/E6qpTVeJdZ5H8cFu
         UtfH/LdaJxVtU9bluiMwXjE6IvzUpPOIOSApdDpFnn/JyaM2xtTPwpniCsoDTpdeG2My
         7WkQ==
X-Gm-Message-State: AOJu0YxohS9byCDIRHrNM0GpD/m4LVJ9K9WItmywNOmnGLxDtZyD7p0L
	+L72KrK6oJU+OVQh9IfR+ep1m77neGYBeR1s2XucXCOIOoAjc2ppnGL+xVrHgLJwVIKecLqkDmJ
	HW6YYXzf7vbANGB9j9UBDkLmaWjtJJQtbPYHUD7pBuAyNJLM/CY9SB3lrx0ZrCa2nrXQv2zriVV
	bAG2gihW50V7Y4bBVndkpwQU/z2KXuIYh8Xsl4Yrcy9onZvqLNs+KIB/uYi6j3xw+Tx2qyUrBMJ
	QLlK4QKbA==
X-Gm-Gg: ATEYQzxxfTKGRan8QtOBuDNF3a/H46kx1aqekuCDE2rb3KuAVRpcNRa7reX1kfZV/ku
	IoQCycrTqukSwU+U2Ri5/krxY52KjW03wic3Ux2dpHv70I1jiZYCLY1EipBfE/+G5Yvke6SOFnc
	LJYMjGvxhE7TMFB9nY7s92MRZDvMpVQWnudDCMZ3FnGXpUgg4D9RhA/Msz8ImB5bhd2QqakLU2m
	LZaszIgJI/DJlpku3HWVZWYiG6NMWUkugMgPfHnlmSGQEIUkwUckblQFwqjrNoUVD6ombHioFCm
	ggIp0oYbinfcaR8u3SNFpMHcz3OVl92f/IBAtoPXrkrs4BB2b6Hf3CHjKWvECH0ExNbDqaQ3YRc
	Nqpv4zMON3WTMi2OFMZhLzn5ttNvdeZz5mxMVVQc2heRJ90VctB1TEFDJbm4yUeNoVC5R9HRoQr
	oabRbfP0UPBeKtNBqk2064kJ4K+LN5T+f4iwtUh+xQ4wH6+KG5OicUu94=
X-Received: by 2002:a17:90b:3f0c:b0:35b:e553:9cc2 with SMTP id 98e67ed59e1d1-35c0ddb2f1amr4011224a91.26.1774460176915;
        Wed, 25 Mar 2026 10:36:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35c1a12ab20sm58541a91.6.2026.03.25.10.36.16
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2026 10:36:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b4ca7e7c2so3929281cf.3
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 10:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774460175; x=1775064975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6hpuNbOoVHye+ZLHBqearhM+JMoJXrmzW+ATFoxVzxY=;
        b=fia0/wgWp73GiNE0qEqzV9W+TEneO3KbXKRNcnCXjEk5LSslK1qH+PBoE8mTFrLlIB
         OQUc2KHtIU83q4Sdfn6OiYt+By3HD3mtnwRfgDTniiuvtCA34iDnZAlZMrt30KEEXzI9
         p8mDcSQ4dYxDIZp4vVIFhafQr3xi6+IdPwJdw=
X-Received: by 2002:a05:622a:15cc:b0:50b:3be7:b16 with SMTP id d75a77b69052e-50b80e4b3a4mr60192401cf.37.1774460175290;
        Wed, 25 Mar 2026 10:36:15 -0700 (PDT)
X-Received: by 2002:a05:622a:15cc:b0:50b:3be7:b16 with SMTP id d75a77b69052e-50b80e4b3a4mr60191631cf.37.1774460174383;
        Wed, 25 Mar 2026 10:36:14 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b920f77dasm3954381cf.3.2026.03.25.10.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 10:36:14 -0700 (PDT)
From: justin.chen@broadcom.com
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	bcm-kernel-feedback-list@broadcom.com,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH RFC net] net: bcmgenet: fix leaking and racing timeout handler
Date: Wed, 25 Mar 2026 10:36:02 -0700
Message-Id: <20260325173602.3676778-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-271681-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D669132A0B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Justin Chen <justin.chen@broadcom.com>

The bcmgenet_timeout handler tries to take down all tx queues when
a single queue times out. This is over zealous and causes many race
conditions with queues that are still chugging along. Instead lets
only restart the timed out queue.

While reclaiming the tx queue we fast forward the write pointer to
drop any data in flight. These dropped frames are not added back
to the pool of free bds. We also need to tell the netdev that we
are dropping said data.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 24 +++++++++----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 482a31e7b72b..f69cf490445c 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1985,6 +1985,7 @@ static unsigned int bcmgenet_tx_reclaim(struct net_device *dev,
 		drop = (ring->prod_index - ring->c_index) & DMA_C_INDEX_MASK;
 		released += drop;
 		ring->prod_index = ring->c_index & DMA_C_INDEX_MASK;
+		ring->free_bds += drop;
 		while (drop--) {
 			cb_ptr = bcmgenet_put_txcb(priv, ring);
 			skb = cb_ptr->skb;
@@ -1996,6 +1997,7 @@ static unsigned int bcmgenet_tx_reclaim(struct net_device *dev,
 		}
 		if (skb)
 			dev_consume_skb_any(skb);
+		netdev_tx_reset_queue(netdev_get_tx_queue(dev, ring->index));
 		bcmgenet_tdma_ring_writel(priv, ring->index,
 					  ring->prod_index, TDMA_PROD_INDEX);
 		wr_ptr = ring->write_ptr * WORDS_PER_BD(priv);
@@ -3475,27 +3477,23 @@ static void bcmgenet_dump_tx_queue(struct bcmgenet_tx_ring *ring)
 static void bcmgenet_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
-	u32 int1_enable = 0;
-	unsigned int q;
+	struct bcmgenet_tx_ring *ring = &priv->tx_rings[txqueue];
+	struct netdev_queue *txq = netdev_get_tx_queue(dev, txqueue);
 
 	netif_dbg(priv, tx_err, dev, "bcmgenet_timeout\n");
 
-	for (q = 0; q <= priv->hw_params->tx_queues; q++)
-		bcmgenet_dump_tx_queue(&priv->tx_rings[q]);
-
-	bcmgenet_tx_reclaim_all(dev);
+	bcmgenet_dump_tx_queue(ring);
 
-	for (q = 0; q <= priv->hw_params->tx_queues; q++)
-		int1_enable |= (1 << q);
+	bcmgenet_tx_reclaim(dev, ring, true);
 
-	/* Re-enable TX interrupts if disabled */
-	bcmgenet_intrl2_1_writel(priv, int1_enable, INTRL2_CPU_MASK_CLEAR);
+	/* Re-enable the TX interrupt for this ring */
+	bcmgenet_intrl2_1_writel(priv, 1 << txqueue, INTRL2_CPU_MASK_CLEAR);
 
-	netif_trans_update(dev);
+	txq_trans_cond_update(txq);
 
-	BCMGENET_STATS64_INC((&priv->tx_rings[txqueue].stats64), errors);
+	BCMGENET_STATS64_INC((&ring->stats64), errors);
 
-	netif_tx_wake_all_queues(dev);
+	netif_tx_wake_queue(txq);
 }
 
 #define MAX_MDF_FILTER	17
-- 
2.34.1


