Return-Path: <netdev+bounces-274799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOf/ACQNz2kNsgYAu9opvQ
	(envelope-from <netdev+bounces-274799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:43:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5CB38F9AD
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E50F3071E77
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 00:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1558D273816;
	Fri,  3 Apr 2026 00:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="OS9jAOoD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FED23A9B3
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 00:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176559; cv=none; b=S2qZFWBQUMjRr6Rs2GWg28nFMSGSf3tV1+vuNLfKopY38jMcTlDBIWQw+34wtK1RBtaPl26GNTntqVWiAslebjkpgPAO0OMSHDkUg8lx6NXwre+Z+qBTUN095WZIsxJVd445SpKj++ZBkMwPcgR/6dBrrcDAdF9xuJozj5+V5wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176559; c=relaxed/simple;
	bh=cC+5Wx7mvSuD5TmmI90JQNyOVlCxmvA8yGpUrQItxjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6tAJvqWhvajEZsvEvKG0XvqFj1E0WibfGORyRLJiuPlMxdy5N9awUiclJAPIMzuUNGHrWyAPaOdbS82zCX7krqF/+wwvkkBXd1jcjXmUUqy2iL2IX6R1CdILsE3N5NqvavEkAByTm+YK77oR/kEEsZtwivnalj06Tmjwy+HL4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=OS9jAOoD; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so667938b3a.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 17:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775176557; x=1775781357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgieY5sH43uwA7fRoCGN+5l2gJuDhD3AI8cPry4udUQ=;
        b=OS9jAOoDGmV1gPmVEd7exH2xRosbjvcDCZmyjQcVP23gksU9TFfX2OsZ3SiTboVQpV
         fz2Wg5DpK3J0cb/RcodOJlib0oe1wWoz+4bQOGB8SiQoI7aRFvxFEn+LP/uX00mQQruZ
         NleB0fELFuVnRxVZc/49ZWfXQe4R4W23RYWCEHmRLic9AryMZSBTU3QE4opfRW7iG6Fr
         5SQm2DOR9eqLa3XFV1WsMuNb2rX1ey1H9vqQgbSCSjkH4Km757iDYwGaAubTJC3i8O5k
         AxBWwRjKoFkDo71+/UEPAPHcOOboHqlq+l4XmMjQLoMKkykBuR3yHxnbfMaKRoFw8FI1
         zw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775176557; x=1775781357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NgieY5sH43uwA7fRoCGN+5l2gJuDhD3AI8cPry4udUQ=;
        b=ooN+9FQ0BGKAUwcJK+9pPZt0iegiwVdl/XXZW0HYYwOwZhDfNBgvPFZ7EL2yv4Vckl
         jJzcET/MGU5vDdfK7c+hqwLZCcF/Gc7hwM74cMARh136p0pTQe3Rn+1PBBUv5TD60l5X
         fsfB9WQkeya5BTb02h8uledG+tTR4uDhVHqA+sXSS4wSaVRLgwFo6DWVUA8dxyc4AHQ7
         cetvgHqQjG8WnY5TRX//j35oWsJXJy3yQJ1ufwDsCMpz+nrZTAMFoxq+OiEitXG++jXU
         HvmIcP/RfnT27yKJ+vFU/K/1hDyzabfY8Ixoub48eETuN0VZdWx1vIhQLo0hnbrMPM04
         P2UQ==
X-Gm-Message-State: AOJu0YwzfvajJOvXHzIZ6b+tN4Ktk6DBy9wnyG83lw88PdhS+jpJwVrm
	HnODp6+COkkXS7UTbgGeIOJQpuO6dWU4CKAheqy1+Bhp4P1zmSTuFDzzloo+Pf344At2omZDBJt
	zM1IriTk=
X-Gm-Gg: ATEYQzyaHW7m1uy8RnC+WfexcCFKbFasLBmlshf7RvM92wvFSF8690D1Fi8dwXOAxkk
	A65Tqw4LmBlcKPw361cRUcRq8ofMFDyOXCDyellvwBnpbsBsJfpfrd+4ZS0avX3iBMYv6zHHuCF
	9xcsW76VfIK4Iq0h5aFcy+vEcntVEa03uWrws8DktdHZlpqs2cbDBNJMJ8AzN+aju7GFf1MbCcv
	aSVL7AyiSaPz5DcdmV2ipEYTcGI2h4WvBAIbV2gc7DEZhFZrna0n/2M1d9WPD3zI5vqW/5HiDcf
	qBlTdPN8GheQLVtKe3iAyaP660ntw905JYZSvQKYST8UUqAw5TWrjsbYHohR5aJvtJgaKfYO1nQ
	EqkVifGzixrYLVCHV/vIX8UXGnbVjqgrc/IuUjn7Ar7tS+OMLiAqTSZJ2zPDvE/zW2HyqYIi3B9
	oZvbQ=
X-Received: by 2002:a05:6a00:c8c:b0:829:8942:2ca4 with SMTP id d2e1a72fcca58-82d0da4e25dmr1067540b3a.19.1775176556667;
        Thu, 02 Apr 2026 17:35:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c6f0c3sm4225634b3a.43.2026.04.02.17.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:35:56 -0700 (PDT)
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
Subject: [net-next v8 05/10] net: bnxt: Add TX inline buffer infrastructure
Date: Thu,  2 Apr 2026 17:35:12 -0700
Message-ID: <20260403003524.2564973-6-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403003524.2564973-1-joe@dama.to>
References: <20260403003524.2564973-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-274799-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dama-to.20251104.gappssmtp.com:dkim,dama.to:email,dama.to:mid,broadcom.com:email]
X-Rspamd-Queue-Id: 0B5CB38F9AD
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


