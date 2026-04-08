Return-Path: <netdev+bounces-276737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEoaE0rg1mm4JQgAu9opvQ
	(envelope-from <netdev+bounces-276737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:10:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F123C4AF1
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B172D30BA4BD
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 23:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51B03A4F5F;
	Wed,  8 Apr 2026 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="ugwuwA1A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474503A2548
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 23:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689588; cv=none; b=Z3Sp61FSunbF37xaT2DFh9rgVUShPtBJuwbgQzcOuk/UHWyhDj7epzZ3LrrHtqA0BRSLuk0PhSvI4z0QTG0Y6I/dLFom2+umFUqNHHJGNTxz+POw8+y0JhXerJ/52Lpz+c8en8lv2mdyYMLwqQWgFHCEwule3xW9u9Y6YZiwsXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689588; c=relaxed/simple;
	bh=8w1yvo40Mcow3i5mEHFfEWtVjjXczfx9WgRXGd/eCtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9InIRGQYrMZNkzCwmc/CPF4Y4BhypWc4tKinBjo1TZKm167wpXJvfHFoCo01ms+YU+kqRE281B18fDz2cE/e2W9l/PsP1y3YXqgFR661dgoMawUcviC2/Hb2V/yB6pW1KYQxcvCtT8pBSi1zKXpDKHUKufyvKd/mA1FaYZQ4ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=ugwuwA1A; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so307352a91.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 16:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775689582; x=1776294382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnRAQ5V4t4u8fZFyOBxhZgdMrI5z8qJPA9QEsYZg+gU=;
        b=ugwuwA1ArHv8bLM+5ew3jp4RuUYzJo0dV+3d12eR7KOmqrxmaIWy1lOk5FNaFgoX03
         vIAKL5slMaQ+g86G7DwYW3Kl8bitULZMpdihbE3bXx6AW6BHkI5w3oTNOLi+zoDftCVt
         mWUQcfc+1MvKtXfE84CjCDsp0+er+ZOgf7UcS15SBMryJoVT0ECVuHIF0QqoQsBaEu+T
         m3KFUO/eVGUYARNJgikUT99hjNT5naWUyiyF6sad5ZTT+98Wbl5O4iPJhbPOYLYIr8EH
         r43pPhp6ApzR4L7hhzVxVLjjNdbh+N5uPI1C5rRQqKfOo/CgZaby+2piKmlPjtlZPNqJ
         Ntog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775689582; x=1776294382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MnRAQ5V4t4u8fZFyOBxhZgdMrI5z8qJPA9QEsYZg+gU=;
        b=aA88TrlaywNc/muNKHWQGDo/78vpYwkt4059MwpBJBSG8egGVjCnVzlFR6u5zK+vTc
         5sdBNLWx3bkPxpYAk19+BohPArtNoMOyTYL1sdKt2pRfP1JC+LV8V/pJbS/pfEy1KT/m
         +/U5JtUyshxpN4JtBpL5H8lXPWOuvNoGNoyCf3oBzlC6bTGlK0XJX1skEtNqX3kQE/FW
         i3Qkto45dmsTqu2LYAGbvZrm2QxB74Tc+bcosqP20Eo0R+DeZK9Ab3+pbgx5jfcyfifC
         rCo1OiDv40dnuHwRybs1MfZ4N3nlC5KQYhd+LAs1ih3L468VlBg1Z/TKSsgSJJfocV3y
         0eJA==
X-Gm-Message-State: AOJu0YxG+1mWBFvKCCQDuKyxPX0ls3Okx/JtUQGIPtOZxpMvXD4epGjJ
	afAqvBj1J81ioZ3WfpAOlveQlnGIzR5KjqTiZAWb5xYNVsrGGA5tEJv6f2O0FrFwnYvDLVI3Ta2
	xLPhqrUc=
X-Gm-Gg: AeBDies0SgRF4cFbll1rQKeac9H2Y6BSzcWzMkLA4oeNat3orH8RGiOMbrPeren999t
	kUrf64UxEKWu0MImWCiPvfcYL2LYBTJCCEuTQVTXo3TW+4wusVia51CiKxCW5J/p0Wx7jFJoyF8
	XlQD0ZDeNTolcG96PjVnYC5Zn0Il4Y7l5KLTcYfO7EGhTeUXpSSVilohTG270JsfLbZQf7j4HSS
	ttX5mwTpZ99ZCmilihHDwLdma4+By1+hG/Z+XTihOTWvP1uuMlTKrqI9o2rIzjDZHj6Z3Ot+DGw
	06sbJ2GSxPIshoQE+7d1sDqUd44ZJTHqf7YarKvZs/pSq59Sh0PDZcImJ7ci+yB2ya7iyh8oNtG
	okGGpk6KzGlcB3ap2so3BMbvayPo8+IqB++hqiPFdtEJsoCbjYYM9vxTNfY4IzNt14ovjI4J38B
	kZdBE=
X-Received: by 2002:a17:90b:4a48:b0:35d:a861:36dd with SMTP id 98e67ed59e1d1-35de691b2fdmr22131751a91.25.1775689582234;
        Wed, 08 Apr 2026 16:06:22 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274756621sm210947835ad.20.2026.04.08.16.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 16:06:21 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v10 05/10] net: bnxt: Add TX inline buffer infrastructure
Date: Wed,  8 Apr 2026 16:05:54 -0700
Message-ID: <20260408230607.2019402-6-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408230607.2019402-1-joe@dama.to>
References: <20260408230607.2019402-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276737-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20251104.gappssmtp.com:dkim,dama.to:email,dama.to:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: A9F123C4AF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add per-ring pre-allocated inline buffer fields (tx_inline_buf,
tx_inline_dma, tx_inline_size) to bnxt_tx_ring_info and helpers to
allocate and free them. A producer and consumer (tx_inline_prod,
tx_inline_cons) are added to track which slot(s) of the inline buffer
are in-use.

The inline buffer will be used by the SW USO path for pre-allocated,
pre-DMA-mapped per-segment header copies. In the future, this
could be extended to support TX copybreak.

Allocation helper is marked __maybe_unused in this commit because it
will be wired in later.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v5:
   - Added Pavan's Reviewed-by. No functional changes.

 rfcv2:
   - Added a producer and consumer to correctly track the in use header slots.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 35 +++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  6 ++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index bc2dac2f137d..bd93edb09ee0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3979,6 +3979,39 @@ static int bnxt_alloc_rx_rings(struct bnxt *bp)
 	return rc;
 }
 
+static void bnxt_free_tx_inline_buf(struct bnxt_tx_ring_info *txr,
+				    struct pci_dev *pdev)
+{
+	if (!txr->tx_inline_buf)
+		return;
+
+	dma_unmap_single(&pdev->dev, txr->tx_inline_dma,
+			 txr->tx_inline_size, DMA_TO_DEVICE);
+	kfree(txr->tx_inline_buf);
+	txr->tx_inline_buf = NULL;
+	txr->tx_inline_size = 0;
+}
+
+static int __maybe_unused bnxt_alloc_tx_inline_buf(struct bnxt_tx_ring_info *txr,
+						   struct pci_dev *pdev,
+						   unsigned int size)
+{
+	txr->tx_inline_buf = kmalloc(size, GFP_KERNEL);
+	if (!txr->tx_inline_buf)
+		return -ENOMEM;
+
+	txr->tx_inline_dma = dma_map_single(&pdev->dev, txr->tx_inline_buf,
+					    size, DMA_TO_DEVICE);
+	if (dma_mapping_error(&pdev->dev, txr->tx_inline_dma)) {
+		kfree(txr->tx_inline_buf);
+		txr->tx_inline_buf = NULL;
+		return -ENOMEM;
+	}
+	txr->tx_inline_size = size;
+
+	return 0;
+}
+
 static void bnxt_free_tx_rings(struct bnxt *bp)
 {
 	int i;
@@ -3997,6 +4030,8 @@ static void bnxt_free_tx_rings(struct bnxt *bp)
 			txr->tx_push = NULL;
 		}
 
+		bnxt_free_tx_inline_buf(txr, pdev);
+
 		ring = &txr->tx_ring_struct;
 
 		bnxt_free_ring(bp, &ring->ring_mem);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 83b4136ccd31..d98a58aa30f6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -996,6 +996,12 @@ struct bnxt_tx_ring_info {
 	dma_addr_t		tx_push_mapping;
 	__le64			data_mapping;
 
+	void			*tx_inline_buf;
+	dma_addr_t		tx_inline_dma;
+	unsigned int		tx_inline_size;
+	u16			tx_inline_prod;
+	u16			tx_inline_cons;
+
 #define BNXT_DEV_STATE_CLOSING	0x1
 	u32			dev_state;
 
-- 
2.52.0


