Return-Path: <netdev+bounces-269163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNUjIxz6umlwdwIAu9opvQ
	(envelope-from <netdev+bounces-269163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:16:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7182C1E77
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D669310AE47
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAE13F076D;
	Wed, 18 Mar 2026 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="NCH4DYky"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D503F0ABD
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861229; cv=none; b=JAsq9rHVDegBOMyQ83BO0wOEx8J9T2s+Ht0oXgGnPOBH/mVcVCIkVDC8GcRCo5jxMbfxKswo8XYy37ZdCEYDLSA/3a+xyVCn4IaefDV737kP15dwKQ9vY2SmQ5Yum7Yau2SdcdKNCjBIKqz4bf7pD/JKZc50V9MxSocl5E5KtQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861229; c=relaxed/simple;
	bh=7Zu0Dz91B8pcyek/pNRIrZNMIcp1uoJ9XU9YtqJIP40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHsPcZtL7MQ0CBKQtHAI9B0bA3bRLrHBvQUPvVt1VH8EQH1WEwiXp67Dq361UVneFWtRkJ1lTMa3ZBPyJrKSL3kfoUDqUSejuhEDO7Ssn3ZhzZJxQ5EKzl/8i/bkIaE5+7QqiUNyjN3QsABC8HLb4h/3k01P6k1HvM8uv2V5MeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=NCH4DYky; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82987437624so116356b3a.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773861226; x=1774466026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXOL9iubHrTOR9uFk5hJvutezBCpUTAEEHozBYZRA8g=;
        b=NCH4DYkyBX58Kx7hUMDoFO5B+DtXuTiIYKM2nPQ0i7jQd2ZYCBg5CborI3YA5GGHyi
         WgxDPt6Ull5T4DUsZSb5OlO2ErFt+LDiT1frUsa+m0jKgbgPXEBMlxJd/PMYaBHzv4ub
         Z5dETOZDB8YJs99/Y+2NWQV5WsILBBqXC/hhUBeqpHAioc1KyMMWNH7uotZvF7hoeruX
         8MiFzOrC27E8p+uJLOmkrx82trTXnmU3caOge/uDYuPi9gk8l7icnF5X2QksoxNO/JeN
         Y6qsobjmCeTPeBw7Gw9mfg4uPZBtcP9AUcmJL5fuQjQuWRN8tcFF+QacfgMLBE20MTVl
         tqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861226; x=1774466026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SXOL9iubHrTOR9uFk5hJvutezBCpUTAEEHozBYZRA8g=;
        b=CQ558AgW42jgLQ8G2QGrgC+e3NCcBix99Xl3Wr27n1G4dKZRKxTHiTalJs4HOCz4NV
         BkeBPfOMr2bd2I96vsRJwb1QTkmW/0S+cGln6jNaKWEaTjFN30kpku48S/glDrgf4uhW
         H3mH+Ass1yn3qn9Tofj7Wh8l084/UaJBz4xE6VDk4ZE+fuYSOxh+2umAK1K5QrFdogux
         LXMQgMNq0kdU+yL3mFc0TbKjm7aEDg3eg9qU/zek7yz9FhTw7hxmEPHbfhJnHADARzL/
         QDWW8oDiz1cWE3csIBXlbyCQSk1BIDAddfVDM0Nhh44h3xCitK9ePHEBKj/zkl17jduB
         enBQ==
X-Gm-Message-State: AOJu0YxJmfadoqx6Ec+hKaeAkBXPT/AX3TEotvK/+fWCZe2imySwLhIR
	P4cvdT6G/xGfH72F4HnshaxVAEGmWRZe58SfSJKdMBu5H0oVAsjlcwNKmiIRvaqjv86As1KDhcF
	PnU4n/uo=
X-Gm-Gg: ATEYQzy1i0vF3HchY5+8ZFHWVeUZnOCDU46KvDn1fzPB3ybmDYv+fBMnOwDFzmUl+EB
	8wYSMLWp3uNIdvJpDSuodQVV75tNINU+rSgSiXv4QEA+M6k65x/8xBfEyw2GQyaRw86LP32qOoV
	M1TjuzTFdVJTCN856fEut1cyGlHTGLODcFJr3wP1qmSU96CpTmwixSm4xySSH0D19ENxWX2adUE
	YheQs9qU1O3u8KxEVE6IRXF9GXiX/eYAXljjT33g5pazslAVZfGmdMSBohoFv5uZuZFooiZjlLi
	66AfJPsplfFtIqV+sqYu0AOPvAWfbrJsHqXXBnKBXBU7QzYDBJryZjklParEbXJAG5lgee7u5bB
	y7/a3OxWjl8ryA6C6tb2Ojfx0P9hX1bGE13Gbe2P4Qiv+/Xw1aqQtIYR0BnxndpBo472po73kAg
	oCSGw=
X-Received: by 2002:aa7:9d89:0:b0:829:b23b:d150 with SMTP id d2e1a72fcca58-82a7a8eb3c8mr318691b3a.20.1773861225619;
        Wed, 18 Mar 2026 12:13:45 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6af06bd7sm3550133b3a.0.2026.03.18.12.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:13:45 -0700 (PDT)
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
Subject: [net-next v3 06/12] net: bnxt: Add TX inline buffer infrastructure
Date: Wed, 18 Mar 2026 12:13:11 -0700
Message-ID: <20260318191325.1819881-7-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318191325.1819881-1-joe@dama.to>
References: <20260318191325.1819881-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269163-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EC7182C1E77
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
Signed-off-by: Joe Damato <joe@dama.to>
---
 rfcv2:
   - Added a producer and consumer to correctly track the in use header slots.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 35 +++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  6 ++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ea8081aeb5ae..8929264a54b1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3983,6 +3983,39 @@ static int bnxt_alloc_rx_rings(struct bnxt *bp)
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
@@ -4001,6 +4034,8 @@ static void bnxt_free_tx_rings(struct bnxt *bp)
 			txr->tx_push = NULL;
 		}
 
+		bnxt_free_tx_inline_buf(txr, pdev);
+
 		ring = &txr->tx_ring_struct;
 
 		bnxt_free_ring(bp, &ring->ring_mem);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index a822bbb71146..d9543d6048d8 100644
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


