Return-Path: <netdev+bounces-273795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGSTECZpzGlXSwYAu9opvQ
	(envelope-from <netdev+bounces-273795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 02:39:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EC63732B6
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 02:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3984730392B3
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 00:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686031DD0D4;
	Wed,  1 Apr 2026 00:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gb/Cu1SU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f227.google.com (mail-oi1-f227.google.com [209.85.167.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE31C84A2
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 00:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003931; cv=none; b=kiw5bp6AjWAGsOymR8XwBbZKqKtwPQulvYuoh0KoYp/mQcUp6SEfPjf01Wxt4WRzg7cwDDQpX3G5OJmeIByITmnmxbqEJ/FEPEV4I5Fuf9t+A+h+dBtwARuxGQaXP0Fpxi7VmcHsXO9vSh3dKK1DeczMjgL6PFFxFWORX232O/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003931; c=relaxed/simple;
	bh=4ugauiSRyJh37zTQRKwBJf0kvw61L5ghO3MEoispJcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZydntILK3QrynrUbCCTUjsjk2BdPQRw3fX0pLddXUUCkVSi2o3XoEKVhui+jzOKZWAf4pY8FS3XPITK4HZjiGo0TfFoVprKak2tViWsp99HfF/pyINU9Z6NOfm2PyFWYAZDcV1UlpCBgLrHd9c3uBh8OGROj+WMWuOuPddyUFFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gb/Cu1SU; arc=none smtp.client-ip=209.85.167.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f227.google.com with SMTP id 5614622812f47-466f1c3c627so3960658b6e.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 17:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775003929; x=1775608729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oyJk+m7wBwZO7qo36ZVZoykMqbejewXxGbs+QICjCOA=;
        b=gUiS1XFR9HIBxsuu15Y8hRJ02hEfgTMmGddeb72C9wOSg5x62Fps0I3hEo4kDlDbkV
         3ihUVLlS8cE/XKgbErJsaYi+vCEMwXSxBr6HOvvWVVtiEW357gKUKG60BpbX7TRmUjrQ
         yC8i4FsB1vi+mN6DU+h547nVLAwOPtZB4bVauLKzXEpznekCp03IUSh3eq50iMniAnU8
         lGz7CS2G0pQovLIFOy90BYBFJGZIMj497hJXK7fTYstIkvmY0FYEElpqb2n7srus68oq
         ahJOKuMsck05JAsj9cZIi4SOXuS3/F2ZEa8OaeRJg7DH3VnnVmS2JmUd9D0QGK0D6LfN
         oOxw==
X-Gm-Message-State: AOJu0YwprqcHdjGjygjeC9Z8bMG3su9T012VGzEOSmSpIEtCUdFRHFJm
	oFUNYXMJ83JDgY1TfmwTaWtgOuzhc86Lfg9XNk4tOAuIecRTwhrzS8QR/7AvINTddLNDDRKVqdQ
	9gFNLOOAd6KUDcospvOd3LlV2Yufyw1O6M3Fmmmd2KpD434o+Y6uqSFmcVNI/TatK9quCI0EOc8
	jn1OtgGTiCnJv83Mp493WrxdFxr5BJ7Hv9HfOgrzooG+eHfnT1JpLWMZejt+6OGA8lLgljS7jsC
	bCsk0f9eg==
X-Gm-Gg: ATEYQzzc4NoMuI1WGGisBxP2PVz7NI9XVI0hOpA0Jz3JwulDjs8hkchhw6UQn5vXN7a
	q5FyjI+lM+sHcYvLAXSz1BjK31Vui7cZ6DInzuDPQy8NbAeZqYiXenSsVdY5ATxnAlbZeZhRYoe
	xDxdpGLLTKw+r5ntizRLZqxWqaOA5T+0d82l+ABL2MAWBNuidgNlFClAy9MToDo1Qd2o9JSOhnW
	TIAlFZrsunr/laO4j6UKQ7sUqlGe4omWp467Ps2Yb6HsKDlzsTTESX6W05PSVkeyHZMWuqAwYX0
	ZkWrVaeKmoHwQLUqvU0BiNG5D3q3OysybHBuhk+Cms/UZgsqGuNa3uOI2xBbhBSMOxLBa1ca3N2
	wUzjtgJ31nRG54GiUyUBt+VVofTUf4sOhgyb31e7Q2464eZM/gFlW1gTJrrp8NDsPoHbEtBCihZ
	ffy/w=
X-Received: by 2002:a05:6808:4fdf:b0:467:1da9:2b14 with SMTP id 5614622812f47-46ae01fb8aamr835635b6e.51.1775003928693;
        Tue, 31 Mar 2026 17:38:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-41d049c0459sm2112962fac.5.2026.03.31.17.38.48
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2026 17:38:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-12776bebeb3so5212185c88.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 17:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775003927; x=1775608727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyJk+m7wBwZO7qo36ZVZoykMqbejewXxGbs+QICjCOA=;
        b=gb/Cu1SU1zSehA/lBDcv9xkvBujGyD4epwPzrLbL4Lfmu93NbZG3kUtgLBxkL602Yd
         JmYvQmLGWjYtp1FjkEVWEoXziajp3wnnl7yRP9gWbb+9sSueqqsIqTHvTpUaj3zhXE4W
         7N7zVoW54QfPXEOA/7MPzpNqlmmulZ+8Gvg9s=
X-Received: by 2002:a05:7022:4581:b0:12a:6a64:8212 with SMTP id a92af1059eb24-12be63fbb32mr1204582c88.4.1775003926849;
        Tue, 31 Mar 2026 17:38:46 -0700 (PDT)
X-Received: by 2002:a05:7022:4581:b0:12a:6a64:8212 with SMTP id a92af1059eb24-12be63fbb32mr1204553c88.4.1775003926240;
        Tue, 31 Mar 2026 17:38:46 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aba581027sm17663190c88.4.2026.03.31.17.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 17:38:45 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
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
Subject: [PATCH net v2 2/4] net: bcmgenet: fix leaking free_bds
Date: Tue, 31 Mar 2026 17:38:38 -0700
Message-Id: <20260401003840.3112454-3-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401003840.3112454-1-justin.chen@broadcom.com>
References: <20260401003840.3112454-1-justin.chen@broadcom.com>
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
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,lunn.ch,broadcom.com,gmail.com,tipi-net.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273795-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D7EC63732B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 0f6e4baba25b..e89126a0c20e 100644
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


