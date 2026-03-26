Return-Path: <netdev+bounces-272205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qORdGtp+xWnw+QQAu9opvQ
	(envelope-from <netdev+bounces-272205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:45:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0364533A544
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FDB5302FB02
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABF63368B8;
	Thu, 26 Mar 2026 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Kea1tZFX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B587033E373
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774550740; cv=none; b=eyYPkAZ3qPI+g6/GSUump0yR9hQj12TcVlb+dInYyyxCQ9RzAsLIvdD/GvO4spEnB+pgxks9URR3qIKZ0LKHaGAWXWqrq2svWUbHsyMGYUqie4ofOP31cco7+RwxDvoDakcwbp8eHBd1H+DV+HzQ9P7uZO/Yj8fex4+x6Se9egs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774550740; c=relaxed/simple;
	bh=Nj5Aj/vDSDscXC1754KA78LMVm838TwDfuAwXgymlQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DokSDCE7LEwUVU9GY3fnzRnyNkp70NB12zahpJhou75OVyUI1Oj7tueM755SBaRdJIMXICQwi35dgl8K2vR2gY7Ko/Ixy7qaRL6XCG8S725UJRDOUuUnpHbwOaUJLUX4BOa8m4RyD/plJMWf4LLooJkM+nUzp3f1mNZ5CccpI8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Kea1tZFX; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-415b23dd6e5so534034fac.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774550737; x=1775155537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUmF8pkufTGkMbDVtKNxXgkFRvGMEJztc4RCxOo6LdY=;
        b=MYxFnQcGZEx9VuMTu7bFDK54z+n7C2FayoyA5VlepsSerbp80LPAvPjxo5uhY8GOgg
         we9LRusuyOMWKH0oDKOMzd6zV+Lyvw+qbz7UpPQ1K1nrps9T3IpU4pK4/WdsRm9OkUX0
         +7iKcbHAG9tPyf4g17UYRvUbJBBq1TugCyNu74MECjiEVAxkFO5eO8QmWnHLGgJ5GTzy
         r8A5VXu/+JU6gze2hQb+14BfpoWRoNhmgfFV81OOpqm83cM5B9JuWX3ekFzb6dQP7rgg
         6oR84ovYHb/nj9DY6FG+ckSH9ipulMwJX5ixs0y/2ajA8k2cpOSd82A1rhuI5BkcubRi
         TIqA==
X-Gm-Message-State: AOJu0Yyv3MmyIxwrgEX9KKWNq+Hx8Avbq8IwS5OBkFEVpwQL+lcK6t3a
	sXEpRR9o50kN8KDQhZicuXMoLPSRFCpz3OBTrm6bDD3KnJDoryyDImO1/vkb0J3F6Y79immjMNa
	0syQNRyAqQUwSzMFgLRGD4iG5HKnRo2R0HnKNRUiA4I64lmP4XVldYjQqmIgqfmOGzdoNAktv1L
	oOAOFTsnGo2hcY/IscR4fQz/+f7xK+Qfxc51JmulAt7GNN33bEjawo75Y1ODW4N9BFlkY09vXpK
	+mR4lejPA==
X-Gm-Gg: ATEYQzxOGSBAvl3UHXlSU55mV7VpFtXWS1xlgy8ncbYJNQGtBHk5fkRZZX/ucpBnzSK
	T3s0Upby5dIfkf73HauAUTIHLVYyLoK5ADgLh8iUAx/W2i5AKISGSG2G2dPWqSiU2SGVRLvnE0n
	HtyKM4urBEHSLIT4mZcR8Dgx2lddPLvoaZbfZ4IZhBNfEPRcc5ViIm12lpV+0LqYb7HAFkQsWmv
	KoDD277yzPQRzBRxR8ijDXymoQyMhUgs03xZaAIhpjBtId8LMJaiHtnPH4NJJer8291Mm8EagMC
	d5r30dBgUBZvwZ34omhZV5/SG5KSIxZbdzFFMvdmRh70EJ8VHL9xBH61YfqjdAYAmsm7dlYvOOK
	a/6UZ/sG5tiJxegoGuztnvJUUsVP7z0H2shQdDmAEv4Zs8F2rYwSq1VpWRvwsyZZorwgmwjXnax
	azKFfTAbsw7d/Fr832GwpUmdTHPRxdBBHDdaL99ubE5zatAtH8cEpj0u8=
X-Received: by 2002:a05:6870:9690:b0:417:1067:d413 with SMTP id 586e51a60fabf-41ca7050881mr4718267fac.35.1774550737482;
        Thu, 26 Mar 2026 11:45:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-41cc7aab255sm414145fac.10.2026.03.26.11.45.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2026 11:45:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8950562d351so56450926d6.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774550736; x=1775155536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUmF8pkufTGkMbDVtKNxXgkFRvGMEJztc4RCxOo6LdY=;
        b=Kea1tZFXIDrt6NHFwJugR2tKFqxBymhpLoNrctAW12pkJzRmnqK99igbRkDFhuy/g2
         40UpCtYqFNbXMsXhTjKK/D41rfXXPspcrsREgSiAz5zAMFoiu/XnzNvD0yoLRRDeM67b
         obTR/R64phiPke+b1UI1ofaK1BhBhI+hOc4KA=
X-Received: by 2002:a05:6214:310c:b0:89c:df11:8fb0 with SMTP id 6a1803df08f44-89cdf11a1d6mr32394656d6.1.1774550736225;
        Thu, 26 Mar 2026 11:45:36 -0700 (PDT)
X-Received: by 2002:a05:6214:310c:b0:89c:df11:8fb0 with SMTP id 6a1803df08f44-89cdf11a1d6mr32393876d6.1.1774550735449;
        Thu, 26 Mar 2026 11:45:35 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd5a18eddsm31054196d6.30.2026.03.26.11.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:45:35 -0700 (PDT)
From: justin.chen@broadcom.com
X-Google-Original-From: justin.chen@brodcom.com
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	bcm-kernel-feedback-list@broadcom.com,
	florian.fainelli@broadcom.com,
	opendmb@gmail.com,
	nb@tipi-net.de,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net 1/2] net: bcmgenet: fix leaking free_bds
Date: Thu, 26 Mar 2026 11:45:28 -0700
Message-Id: <20260326184529.1393438-2-justin.chen@brodcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326184529.1393438-1-justin.chen@brodcom.com>
References: <20260326184529.1393438-1-justin.chen@brodcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,lunn.ch,broadcom.com,gmail.com,tipi-net.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272205-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0364533A544
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Justin Chen <justin.chen@broadcom.com>

While reclaiming the tx queue we fast forward the write pointer to
drop any data in flight. These dropped frames are not added back
to the pool of free bds. We also need to tell the netdev that we
are dropping said data.

Fixes: f1bacae8b655 ("net: bcmgenet: support reclaiming unsent Tx packets")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Tested-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 482a31e7b72b..3e1fc3bb8297 100644
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
-- 
2.34.1


