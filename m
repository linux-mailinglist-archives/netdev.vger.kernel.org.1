Return-Path: <netdev+bounces-276191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DSII7p/1Wn36wcAu9opvQ
	(envelope-from <netdev+bounces-276191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 00:05:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FCA3B5352
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 00:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A49C3071D8C
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 22:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7371382371;
	Tue,  7 Apr 2026 22:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="lAu3VoqJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79826382283
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775599414; cv=none; b=NCi31Wm4qw3/wVS0n33/FPvtqKcrqr/LfeMtXQWFQdhBFXlWOTjvYIiO1F/ZsAgETUYJg5f+D0hdqyyvfzM4KEOgDuNIMMIDjzU1+LGDzb2gXMU+e8RlcZiGYmPQCj/ueg6HAzVuIOEzMuP8t4ULM/d6n6tgFyuzz4DnzAoXpF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775599414; c=relaxed/simple;
	bh=cC+5Wx7mvSuD5TmmI90JQNyOVlCxmvA8yGpUrQItxjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxe9ULMfpywqGzQZmc48cmrlbixrfCGzup1x/+ObZUT0Me4hc9LkxQ6fk3V2rPyTV8i0rwk4EipzBZjYsOxRYunGI076YLFvPZ+2cAsfKDWhniRUNzRSZAy5OEFqAwSBum7aAm9UN9zeQbOzqBtiR86oF5CCdAwWMAoTMuFC5dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=lAu3VoqJ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8296dabef74so5259540b3a.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 15:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775599412; x=1776204212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgieY5sH43uwA7fRoCGN+5l2gJuDhD3AI8cPry4udUQ=;
        b=lAu3VoqJkSMdWORDehjCWd30zTPXUrBtZaAAtl4GPsnjJW2JBDWIC+aQYTV815FNi9
         Vjkfq5BgV2yIc8BcdsXhjbIwFB+csUyLHrY87rvXuzYOBejNpGhqY1wVuq/qt8QVHE7l
         0qGmKbkcdtqqxFUKBVLBV7UnVfvOK2T6TPq/zTGsxAcOAnfzXlkG8E4WiWT0hUWuFHYB
         L+dF9oyZqlQ72kibXLiYX5LCauBhWCgF+40FO0pKwFnDwKmV/3mQFDVZxubvXslBl1w/
         dBh185zUkx8OCTtrLI+b5t3EAZOngU8pU2kLiaZ53WwXIIvYEANdLn8fcP+J8mUtKIWI
         WLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775599412; x=1776204212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NgieY5sH43uwA7fRoCGN+5l2gJuDhD3AI8cPry4udUQ=;
        b=fI4s8+refFbXtzDiJotHh6ovycec1wnZRyiwiUYrZU8iSW8jYGIOcBUZhk94r+qQnr
         9FUo/Jx0qWNYSHFqhSCt+0M0dGpnyJ4K3jRTwWAElBM9bw4J1HnvSkyY/iE4tt3cxb+d
         GeSKTglrdOpZm90zltmTNSgO04y+IW2mqotOyODyU7EtRghE8tHbNXizPQYA3d811cfz
         GE8EqQ+/xjdM/JJ3O1+Pnn3xjPNPEz7Dtzo4PNSPT51pbKSEvqpBZYHDvIrfZEkX19jY
         Xf9fbm88gIFUdxrKNRe6eCgfPvEGosvKhOPXcJmNuEg0JmQIwLEOfuLcgCof70Z3beSH
         KbdA==
X-Gm-Message-State: AOJu0Yx9IEaqgHHBdUGW9qxDhp2YciooHAfK6jc0WQB/Krpn6d40BIex
	SX2NgpoPYtbN+MppyoI1ZrDMOfOGBIYpFhV3SyMr6sG+BkEOdafACx0ycd+MjGndsKkf9McEFlx
	gMyMp
X-Gm-Gg: AeBDieu+R3MN9ho0hHgMzWcKxCjakfNlVm44pIkoPR8xlGXE7bvE2caLvcp2D7emEdw
	KdhJHPr1XHE7fqBRP8vrC5dj4RLRklLhbrTobRJZ52V9+AG9g9oytKstmCyb/pzU2Oa/zHgB2Al
	JniQgLDDbWkZ3u5+sxiyr2MexCopUmyzZzaVG+PmktySYFn0qs70DM17E4YQa3VtDdowdNFGv5N
	IjZYhJSANiMtnzY3en+jUiwB9jaZhLEJlZ8SThQOcGy2kOfcvoCc78lCgDTkGqNXnOSQ4AcMVPV
	qEKxQh57yTeMmY79nfPb3bEjWNdNE12J9bh2fpaB4oknd3iGJCGHmIhWMifCj5JDK0y+2mIjipg
	mzDdmeHP64HxjItlLJKVXdlKIZkwOizYRJ7xe3urvztE9k5ikVIGi5CpSrFZw8v6iIIfOg7k+D+
	h4szL0
X-Received: by 2002:a05:6a00:3cd3:b0:82c:df25:fbd9 with SMTP id d2e1a72fcca58-82d0dbaf921mr18749972b3a.50.1775599412604;
        Tue, 07 Apr 2026 15:03:32 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4d::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b272bdsm19487562b3a.12.2026.04.07.15.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 15:03:32 -0700 (PDT)
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
Subject: [net-next v9 05/10] net: bnxt: Add TX inline buffer infrastructure
Date: Tue,  7 Apr 2026 15:03:01 -0700
Message-ID: <20260407220313.3990909-6-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407220313.3990909-1-joe@dama.to>
References: <20260407220313.3990909-1-joe@dama.to>
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
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-276191-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email,dama.to:mid,dama-to.20251104.gappssmtp.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: 04FCA3B5352
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
index 32a0e71e9fb7..74968ca1f4e2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3977,6 +3977,39 @@ static int bnxt_alloc_rx_rings(struct bnxt *bp)
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
@@ -3995,6 +4028,8 @@ static void bnxt_free_tx_rings(struct bnxt *bp)
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


