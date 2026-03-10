Return-Path: <netdev+bounces-266338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOOIG0aMsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:25:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA06F2583D1
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45B86304F09F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDA93EDAB5;
	Tue, 10 Mar 2026 21:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="mQK48bf2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9493EC2C2
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177779; cv=none; b=E66mONKosbOrOievcbkdYsiglKuJbz/LpGO0vQQn+m0255m2W1LYgpH4B+DMO5usLfLkRUH3Bk6vxLl4QyfYA2pHMHi9H5IncUdZ3ImcCBFtDZcyT2h8WBNq9E0uMj7ysuF6HG68lNSh3HVve/meIoSy2suXg1Po8cDfyjj2KHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177779; c=relaxed/simple;
	bh=7zhwd/yH+NbmLERZKdu4eKpm0EQlFIvQsCyvSDX/uHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKQsI2hzc5+MtecH1Wl+bdhGV06oEAyHwGMlhUEad33zJfdVIiRkr3xcmnXy9AhLH+h1J3/APEI5eaH0JpOfU2YX/ZFS7K98Hc5V26OuJ/jTgSkhkfGY67wOoQ+ianZRKndEQqO3d+bKCBHDomb4cqCUEKqNtoH9wCLjrTXYIHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=mQK48bf2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad4d639db3so59608305ad.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773177773; x=1773782573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K99iY/zLnMAtTJc6rl7mUQQjo8+bfTAMRl6zpUzhIbc=;
        b=mQK48bf2MBf++K7llVtWhlZ8eTToYmilq9O18Q+bEm5bbUjh2FXFrUL9LdJ++uVT6F
         csXDVEyTiXnZAaMN+0tYX51ulUST1Q4jjApumCmnN8Tn9BcbUNlU0PVBFQdAeXyvIt1J
         frZNgfXDVwODZFVOOnzp75E8oaku5Bt0I6y8mmwEOhyojlFMYTkhnoqdrwfuIOP0zN4J
         CqVVsoFZwp632IJoei5GLby9WT/WYYmOBuo8n3K/77/BV9h0/nHprLmm/FAQjYGPcoFs
         ldtuX2VigIWJt+hmYSxlfXBWkTjJZfydW1GVP6wiB4CU86RLo7pq8cuVb0Y3u9DOQDbu
         6ZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177773; x=1773782573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K99iY/zLnMAtTJc6rl7mUQQjo8+bfTAMRl6zpUzhIbc=;
        b=tDJ4S333tOjPSaFWcBurSDRZqWBYQY5m8dE9y9Ss9TIRK/0Anb/lBHFZ5k3GPrGx3u
         Hk/PA1ilg25KK7bRYoGcZmjLYpUblYcEFti3ntwK7EgzmuGrp41byA4haqM9AVCqsn1b
         sQty7qdRGeYB8i4f5UTLboaHlHLWPsPvwA2iwggim1rNeSBUU78eSmNuHE/8MAptJ5n0
         UR4r2z/yp8kFWfEnNTmUweiBCK3ikAcT0Ges6T0MOgJyzFeTORjT2CgHvWVwofUZhB0G
         V/FJ9JQIsnFBE2iP6g5EFmXiEQd957T36B+iwnGIyBpEOojxcBIOg6Qed6HD2NOUEHdA
         0MFQ==
X-Gm-Message-State: AOJu0YyPnrMtpmQh3Xqnk0jnPTEGYpk1BDu0+2Xh9KIn1EdCIXd0n1l2
	SvTjwf6rcUoabNSWPMSBib00c30v7Uav2XWhZ7k/c4wl3t4qTwVGxvxqgpW2HpjYKYxU4pmo6EN
	vIjBJr2I=
X-Gm-Gg: ATEYQzxP/AGMbpWbayZJghYFH4y/UnLxmLDTN5Ng/vRzpcugqsCbJrYRbTzON4rWfbp
	v3Xrwt5vSob2x8ffGhrRtY3ZyvEULcVxQlwgc026/y7R4oIoTty3XZQ36FxnJ9EGb4aFZnqHfyi
	Gd7lo7qzkUaSAL0c3izSSADOaNB3d1ujfY0TZzmHzeBJ8XAGxUP+92GS5wYAKBG4AM53RSRDbTB
	ceD54bvU4KZdZz2ya2NDCYCUBBawhJyqWCTzVdqcX9QuSNaN5dOhZfPbFyr5fBb4DZDPSqulYLS
	YngcbLpyHoijzYMcVd/sv4PZEk6dev1YO9hyHzeVJXorkYeSNlys6Y7QnJrF0OpVBDW+yT/Yjtj
	LL0lvlLw8BJPoNg3bUDSV4yEOr9doR0Fq7+plYYQ1g4FB1l4P2w1/XdbNVglq0miInCYxbJ7GYN
	p/
X-Received: by 2002:a17:902:ce89:b0:2ae:a928:f544 with SMTP id d9443c01a7336-2aeae8f0001mr2199725ad.45.1773177772920;
        Tue, 10 Mar 2026 14:22:52 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae34de20sm1774915ad.60.2026.03.10.14.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:22:52 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net-next 06/10] net: bnxt: Add TX inline buffer infrastructure
Date: Tue, 10 Mar 2026 14:21:54 -0700
Message-ID: <20260310212209.2263939-7-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310212209.2263939-1-joe@dama.to>
References: <20260310212209.2263939-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DA06F2583D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-266338-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:mid,dama.to:email,dama-to.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add per-ring pre-allocated inline buffer fields (tx_inline_buf,
tx_inline_dma, tx_inline_size) to bnxt_tx_ring_info and helpers to
allocate and free them.

The inline buffer will be used by the SW USO path for pre-allocated,
pre-DMA-mapped per-segment header copies. In the future, this
could be extended to support TX copybreak.

Allocation helper is marked __maybe_unused in this commit because it
will be wired in later.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 35 +++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  4 +++
 2 files changed, 39 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b801daf3f328..906e842d9c53 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3962,6 +3962,39 @@ static int bnxt_alloc_rx_rings(struct bnxt *bp)
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
@@ -3980,6 +4013,8 @@ static void bnxt_free_tx_rings(struct bnxt *bp)
 			txr->tx_push = NULL;
 		}
 
+		bnxt_free_tx_inline_buf(txr, pdev);
+
 		ring = &txr->tx_ring_struct;
 
 		bnxt_free_ring(bp, &ring->ring_mem);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index c5dd341e7d95..41d933a4c282 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -992,6 +992,10 @@ struct bnxt_tx_ring_info {
 	dma_addr_t		tx_push_mapping;
 	__le64			data_mapping;
 
+	void			*tx_inline_buf;
+	dma_addr_t		tx_inline_dma;
+	unsigned int		tx_inline_size;
+
 #define BNXT_DEV_STATE_CLOSING	0x1
 	u32			dev_state;
 
-- 
2.52.0


