Return-Path: <netdev+bounces-272206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCxWEJV/xWkk+wQAu9opvQ
	(envelope-from <netdev+bounces-272206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:48:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DB933A60D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 606E630887A3
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DCB33E373;
	Thu, 26 Mar 2026 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LTqCys0w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373BD2E1EFC
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774550741; cv=none; b=t2blVRswLYeYDP2WKXco0ykTqNINsgZMig3+NZ5/yQvw7P2GVU5CsHrTDmoLQn9rGAPgoCfWFFHBFoMCCBGDubPin2BLfvI37qKViRR2EcLpH9Sk+LPVKYvyn1oohaWEKY/MfXgPk83APHMIgb5GXXjH0F7jQ8mIagM32CSLCG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774550741; c=relaxed/simple;
	bh=hYMyuJFSyDxRL6fA8HGW/YVi/RGL018tmXHbrRu8I1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cDobolBY8qEQsgWJFtK3n6tR4QsJPGpvaHDtpbMD9myhiRhe8yeNGvTSBykd/TtrKDIk9UBdu9OcMAP+6rYAYIXePriHBREu91Xhq1FcGQOdCgRn7kt5LAFqBbXq4TWcauZZqXXlQeFEWFvK7vYuE9eO21eKnrmxOMLRxJZTrqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LTqCys0w; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-89a1347051aso20058596d6.2
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774550739; x=1775155539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0NG0P+BeVFeENLrKQZvFEzZ1BkfXuPjeM9xRtKRAuo=;
        b=MNxziedrjyK0PqGQlzzHBtNcJW5AtXLf1orcSA5BGAWe8K2CmJEHL9IO850Wa82hL6
         jak7UvUtjj6BFo4g5NlSW7pRLOnHtJg3VlHBfIQATUNWXQCf3rMgKb9neX/5RzqxQ52H
         GMBekokEhyMsVKBuBULnbRej5yKY1b+3d/A/kBKyKRccMWnJLsCtlSBZAG+72DjEklIJ
         fav8f3kVzHl8bshH5+tlpRdmOoKv3pwRr/FLeHI6Obi2wSdOpoO+t9FsMhSfMpRjjfhd
         P9epmIaYn/ge1hwycmKj+zRWN9BkcAlx8az86pUS750EInJXkJDRHUl9N1yWHIrvhRg2
         Zf6g==
X-Gm-Message-State: AOJu0YzYKQBxKLlajostVWn596oVauPGifuOo3mSk2C0+5hVjlTdQwGB
	8TTkYt1JuPqvCPBVQKtknDyulezpAy2JIE1TfDrRQxJi5OMj0Hmf6eemG29IFytq9dI6Mmb/uyC
	33119rqmaLsK3B7EofUbhgKfX/EZMt0RF4s7R4QL7tylyr6vgUOvozFG4DyM+Y8xNEkbgVXlT9d
	12wsfxe/aB24yzkz/JpQTa7El7N2S67GdN8DD/GtOCFYGfnYqQuMtVI+Uq1Dtwp1HzGRnpsm4Fy
	w0CQvhYvw==
X-Gm-Gg: ATEYQzxugocVWiHaunugTtNMLcMKGNNKZj2lq9ww45UvbK6sebWHvR5ixKg9vpUOyIP
	rk9MiPYx/ss/cueiEC3n+jb600gGie5rhJoM6r4XavNO7WModxror8uXVDNBzpUCz7ilz158nH2
	C8RrI8vTJxC1Pl3Cm6sHMZcrDftDSbmQ3qAS4twO2uC58AMG7YOGpZtPa/Pumw89QhCJDk+bF+E
	7JxtCV7BgszqATaQfVYv/a6728BYnS7ccr2uQXm3TtS7V4vex52eYhFkU1lOOLh22F1ldxY6ylo
	2SFaE8sadg/svP+o6fOcHEy0LyIXsX7dgaJGnkOzNTW28r85vq12S2fwZ5PHJlfNs2aINjbaa+e
	s57a9G0WydE3+1Km6yzbq0Dmi9bS97+BsCKoeXwQaJ8+Iq3xRiFsOhkyc/1F6JI+wceh1K7FbO7
	FM4JbF02XuHvTkpinqADhHs4QARdbqLb65WTS/+4V0F/S+lGAg+qgc6yU=
X-Received: by 2002:a05:6214:5009:b0:899:fc48:4e68 with SMTP id 6a1803df08f44-89cc49ba0c0mr130050326d6.4.1774550739007;
        Thu, 26 Mar 2026 11:45:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89cd59ab8b7sm3802076d6.18.2026.03.26.11.45.38
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2026 11:45:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5093787e2fdso61766271cf.2
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774550738; x=1775155538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0NG0P+BeVFeENLrKQZvFEzZ1BkfXuPjeM9xRtKRAuo=;
        b=LTqCys0wacAfizCCP4/+Pb0t5rtfvL76bAFD5ayE6E+Y7Q8cF3epPk7hP5AY8aV8rD
         QPFxCHHfQAOvrzBjGTd5RC2oQPE5ovx2asiuFUYNcqY9QzUFOPU6bDAR2/oWiWfqINBA
         00OxBpMK+UwksatqQ2XjmFrLChabgGfwo2MJI=
X-Received: by 2002:ac8:5a8a:0:b0:509:37b0:7b06 with SMTP id d75a77b69052e-50b80c9d459mr126925361cf.11.1774550737860;
        Thu, 26 Mar 2026 11:45:37 -0700 (PDT)
X-Received: by 2002:ac8:5a8a:0:b0:509:37b0:7b06 with SMTP id d75a77b69052e-50b80c9d459mr126924781cf.11.1774550737337;
        Thu, 26 Mar 2026 11:45:37 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd5a18eddsm31054196d6.30.2026.03.26.11.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:45:36 -0700 (PDT)
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
Subject: [PATCH net 2/2] net: bcmgenet: fix racing timeout handler
Date: Thu, 26 Mar 2026 11:45:29 -0700
Message-Id: <20260326184529.1393438-3-justin.chen@brodcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,lunn.ch,broadcom.com,gmail.com,tipi-net.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272206-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: A6DB933A60D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Justin Chen <justin.chen@broadcom.com>

The bcmgenet_timeout handler tries to take down all tx queues when
a single queue times out. This is over zealous and causes many race
conditions with queues that are still chugging along. Instead lets
only restart the timed out queue.

Fixes: 13ea657806cf ("net: bcmgenet: improve TX timeout")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Tested-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 22 ++++++++-----------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 3e1fc3bb8297..d33c4fa071a3 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3477,27 +3477,23 @@ static void bcmgenet_dump_tx_queue(struct bcmgenet_tx_ring *ring)
 static void bcmgenet_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
-	u32 int1_enable = 0;
-	unsigned int q;
+	struct netdev_queue *txq = netdev_get_tx_queue(dev, txqueue);
+	struct bcmgenet_tx_ring *ring = &priv->tx_rings[txqueue];
 
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


