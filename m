Return-Path: <netdev+bounces-270672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBBeFNWSwWnuTwQAu9opvQ
	(envelope-from <netdev+bounces-270672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:21:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7592FC201
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86DC131FBD8C
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C693090C5;
	Mon, 23 Mar 2026 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Y0WysUY9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9812306B37
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291155; cv=none; b=kqUmEd5JB7A8z579fB0dl3Eq1F32l0hBgc8Qu7XyUs7i2lLKSldksws/+5kDMuXpWL8ukxBe/l7yby+SXiDe4oqzrdFuoShhTEmAN2t5BiooT8GaMrIwBb26GGgzyRiWvJWDRFJ2GdakiY5J/1xd0inXx8K2/03iEh4BKgqapXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291155; c=relaxed/simple;
	bh=893kAeGclOk4fSk78cvUgba6Sya5sswIG+0f/z9UDDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5eJf/D3YHnRUW5LiCEBxghHvjobDq/56KZ7Uy8OPATV4p/JxKulrkQCci2n9sW5zUoZLa42MtA7rvpKd0mEqq48AsdRVDjKUpv8n90zcTUh8E17D+hYMFoIuD4s1g73KdkVuG8Awi0Y4vARGJS0Gtq6VczFaGFz2zy+cJ8ennE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Y0WysUY9; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35a1cc6e478so301370a91.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774291151; x=1774895951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEdEGPSrIUj5fWAalmJxUK7ZuzZ9BH5SshMhMwYuV3c=;
        b=Y0WysUY9qtnZJ0PpTDzoQGKK4VN4Mk7Bk/f/94OQfJHkHVNC2z9cLtr+ChJzvUIV22
         Y3mSJBWU0ATdXQ4QGbaBibJ8U5Q4UIj99vcY5lMLq5C1/sLYiSN31lLS3foxCRiFgm05
         L0JDo5DTfV30Vp5sXe9vwePjMDNoPVNeqO6PBQrK7NzlwhWWfVEuvKbgCipTNtZruyHj
         8y9IMtkf8QUf+EVW+zqhjLKbY6J7L9a6cTtfTrKNtbzKL7TXctoGVr/12I33Wy4+Lrem
         BvKA7pvQ3AwJX8bZjbqEegmuJFusjd+cvRIehhRyRjrmHm1yii09uMK9HDVKfGKVJ7m0
         5aAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291151; x=1774895951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wEdEGPSrIUj5fWAalmJxUK7ZuzZ9BH5SshMhMwYuV3c=;
        b=EHANKRDPGr0VKatvODoNVRABSErwlC6+JvNQUFw6Ne5bnrf4/5ng/i0CHlvx5vdShO
         ZSenZNVImQ+jtyHQARsJsKfMH3GhW6K0sAxpzmlqDiopZndaWKX1ch1cFgOxezOxSEDY
         kKRgR7YQSg156claEQh0DCEMdAiOUHXx1IpfaU+ZxYIdvr/aN1pYABihdD7NOqZfZTYv
         6l+IEJX5PGE48ksfYIidvMND/jj0Gy+Z0QdInyau6Mchj8OghFM6LzuAnK12pQ17BzAA
         Qcwp2JytsniXR2DzZj/neJkUhfc88ibwE/TNkHMDiWJp1n4tLonJNkysQ+g2GrApGjUA
         pYyg==
X-Gm-Message-State: AOJu0Yy3DfZ3EK2q06h+PdhT7HhKhhxQEVPvM4vBhuUZMmlzCVc1G9wL
	wAmyomuVxo/8Gkhjepztc2WK651Auty94NmxMv0bzSD4Fm6fwdaKXBJJf8kbZjgAKa6IRSyIijp
	kRGC7KkQ=
X-Gm-Gg: ATEYQzzjKIo7pKlNQQ9a3+goALK8XcVrBhYPfFtMq7dLAE8wlQytUPajrGrV0VcxgQ1
	mTVDMeXxWMLl/3Bwzgm2ieiin0/aEyIuMYJe/ty0DItQpCFN/k1XqOwegbr3c+qaOvCBjpZXHx1
	LSCCoeKo5WjDvKy66gBCstTBwo5zYVMEWgafAa80Ykox/sskqx+MB7NtV9P9ZL42JJjrWTaRtnh
	lQH+xMRRjFuDSkDBBzUh5B6599QkbjnJH8FC5fiauWKdcEmb9NwfBkF8kIJdDS9PLIPzC7/9uv4
	f6RCnsT5nspKhKHzeOfd6tx0bIx9puiMyYfT1gbYsc9Ow8PrzQaXFuNi18nodWntollIFrWyklQ
	2Jn4wgPBWxOss4CFYqgt6qiHmafdA/76W+QHNIUJiRiXE2MDrx0hE66dgs0LFxOlPtZlCNOsngf
	O6zXw=
X-Received: by 2002:a17:90a:517:b0:35b:e4f8:55ab with SMTP id 98e67ed59e1d1-35be4f87ae4mr4169478a91.6.1774291150605;
        Mon, 23 Mar 2026 11:39:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd410e7b8sm9717171a91.14.2026.03.23.11.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:39:10 -0700 (PDT)
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
Subject: [net-next v5 06/12] net: bnxt: Add TX inline buffer infrastructure
Date: Mon, 23 Mar 2026 11:38:31 -0700
Message-ID: <20260323183844.3146982-7-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260323183844.3146982-1-joe@dama.to>
References: <20260323183844.3146982-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-270672-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim,dama.to:email,dama.to:mid,broadcom.com:email]
X-Rspamd-Queue-Id: BB7592FC201
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
index fe15b32b12e7..2759a4e2b148 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3985,6 +3985,39 @@ static int bnxt_alloc_rx_rings(struct bnxt *bp)
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
@@ -4003,6 +4036,8 @@ static void bnxt_free_tx_rings(struct bnxt *bp)
 			txr->tx_push = NULL;
 		}
 
+		bnxt_free_tx_inline_buf(txr, pdev);
+
 		ring = &txr->tx_ring_struct;
 
 		bnxt_free_ring(bp, &ring->ring_mem);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index a6b04652600e..751dbc055fdd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -994,6 +994,12 @@ struct bnxt_tx_ring_info {
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


