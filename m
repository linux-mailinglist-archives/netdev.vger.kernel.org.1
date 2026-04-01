Return-Path: <netdev+bounces-274276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHK8Lj6tzWlRfwYAu9opvQ
	(envelope-from <netdev+bounces-274276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:41:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 204E9381BF6
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA9EF3082A5F
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 23:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827F33F0A83;
	Wed,  1 Apr 2026 23:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="u+tcLmxn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C6C3F1653
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775086689; cv=none; b=omAbtUh5gHZcoFj5GW8frnrZy3iiIMrgTeVmQuMWsPCrrUQEUacqddxBpRvZJvuEZ06/u8brmfGw8hWzxf+ZYu/cVwSb5Bcfd6Yq+aASrNTSkBYCFV+nyOefW3pjBJIkNRozfPIZooXt8tVlE/3I5HTgbXFd3FbnG+Lw9KFWLE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775086689; c=relaxed/simple;
	bh=8yrRK6KOpkG48wfofnXf88ckxyX6LR4sGxYt1H48M+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=St2HNOgcSvx1Wt6TOFSUndgoFW/WuWduq+jM3zwse0Nx//JztRNm/VAGoMqns7RJU6jzqNBkBfUvSDkzgH6HTJK8C6+Tz7coiujI85THqj4WLfqJlIRMteGYhiG8jEVgr683djDZVe0yR5GcnhQgnRoryHtMQRN5KE74fW98/cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=u+tcLmxn; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso103132a91.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 16:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1775086683; x=1775691483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Y1kCqtr6G4/Db8CIqyy23JCMHMGVwKALhaotwfTTB0=;
        b=u+tcLmxn2xlniD4vnLtuREB0Up/0/Jyac57HbFlVzt2MNeyBQMXZ2a7HIyL2yAPBOv
         kWvoJnxjzNdVXoTmVPe0JzNgpQ1ZUeaQYKW3nY9ilGTVWUmOP+lNknRhRvm5GiDX//g+
         30GLjZ1hjxvfWuPHO4vMP1Z3vD+VxeElHFHkVNL5apJf2uvRX8EYNdVFpXdcDDaT9TLl
         +z5QR9rHUJd+fpzggiMJ+wSCIUhjgcJwUourMUezy0q9IVvWH2gNchkoBmAZUrmqR+lV
         D9Ow2OZUL4mZpl9GDJSDp2MWwG0IRq1PDpd+w7BhddU4RObS1L9VfzmFnpbczYY2+F81
         y3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775086683; x=1775691483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Y1kCqtr6G4/Db8CIqyy23JCMHMGVwKALhaotwfTTB0=;
        b=eYcdH2TjcwkuEZuRHub1rwILLC8fj0T/3Ihw0cwCiSmv3LX9qAoyUZ3UUlVmPhp9am
         Veaz6pF3dASzOEzJ7r7Kbz8zMmfde/pbaUjoUAE7Nuc9as65udJBph2HDOdcfjLk8uyE
         9RfcnuZxaGyR3RnWC8OsYvUJzwSfUlH6HflcuE3kfewO7jlCcPUloeCiw4QXwrO9qZim
         3LTwntr6BbYJQJsNHGMUo87MgxZ3e9+8j+01TeD4GzG6WAa392nCBkT0G2lJo/H5p+3C
         a1qAXYoQ6fXYH8LRHyM4UR6ULVj1+GEgayNjSShxi9gd+6yXJ1IikEHFs/XICKg5mvO7
         wIzQ==
X-Gm-Message-State: AOJu0YzA5YlH0WEuMyWYfvRUAGDcqDeIRyPdGfwS8Guwc+e32TsjqqCV
	fT2pFXEM8QCp30zU4X7RZzt7LwKi05e3Jf1FnkRL0EdmPs8i2uHD/cMMrZ5CwkGSy/QISIrltBi
	EO0DM13w=
X-Gm-Gg: ATEYQzzVjOJ6uhAawEWMG5RE4oi5D3RWhgj9i0D7G24/+7+Qpo8Ckw7gzGNvKYQmmiv
	YioW7a6h+5KwH0YZqfJPXjw+hBl4Wc0oAueHW1ihEChXVtCV9bTFYjOtMK3AWVYJto6esZg5EUc
	IlRObneHu0nUqHaFv6nQTmOoWBFZf4Cvl/Yayh1B06kSlslcWZKHgGxJ/lfOKcRynEOeYvZxxu2
	8AGze83cVvOSa11iHhe1Mqq+OCWREltOEbNUVJktrWg3iMIE3lcUt2C2hAa6i+14PpUu98AQ39R
	slWvAQzXz/fqHVHHfIr0ZJAjCN9MFQNE/XgXkWJe3uyZGei1tl02jAlyYZgstNykeMtB1CzP3tY
	7/Fves9mpKvuKipZBsEQblvZXykc3eHjBglqztNkmB53BYqYa5PJnOypPO0QTMmpsZ+Kc5CnrWw
	m3yws=
X-Received: by 2002:a17:90b:51c4:b0:35a:cf:64a6 with SMTP id 98e67ed59e1d1-35dc7013459mr5144107a91.23.1775086683078;
        Wed, 01 Apr 2026 16:38:03 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6563597sm1083101a12.16.2026.04.01.16.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 16:38:02 -0700 (PDT)
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
Subject: [net-next v7 05/10] net: bnxt: Add TX inline buffer infrastructure
Date: Wed,  1 Apr 2026 16:37:33 -0700
Message-ID: <20260401233745.2333858-6-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401233745.2333858-1-joe@dama.to>
References: <20260401233745.2333858-1-joe@dama.to>
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
	TAGGED_FROM(0.00)[bounces-274276-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,dama-to.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: 204E9381BF6
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
index acd76d9bf403..815c01d75ecc 100644
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
index 24a32ba7157a..9ee8ab266e28 100644
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


