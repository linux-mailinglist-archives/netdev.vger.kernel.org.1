Return-Path: <netdev+bounces-269938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C7rHLNdvWl09QIAu9opvQ
	(envelope-from <netdev+bounces-269938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:46:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFFF2DBFCD
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A92BE30472BD
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DADB3CA496;
	Fri, 20 Mar 2026 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="WFZC5c9I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627343C9ED5
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017723; cv=none; b=ZMx7bM3e5ggTOgcFpHBU9clcHtHWjgPZY1mnw3HtXZHbtU5B9ELgCbTg5QrDI8kw/3KUp/eAPXBDbZKp/diaxc2IaHuuEGFPyayQffxTENquEsMzx6DYDtbpZl8ew7mxYmZfiqPeJNfGjx/FRZIxxBM2Jv0rSGvgnsQw2azDUAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017723; c=relaxed/simple;
	bh=7Zu0Dz91B8pcyek/pNRIrZNMIcp1uoJ9XU9YtqJIP40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8YG3I83omGYKSgv1Rqhe2laMVWUnolmR6iF7I0h+qEZ6XSgJ0kKKdV3XHa/ckxFHvpU+CHECgu7JEqocviu8hWm35pVTMSgWprfzc2ISTKbEub0eH/ztbjHyc+01FqldBn2Wn8GQ/sAcERHbfgbq7Y73jaU9r5znDeK60mklO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=WFZC5c9I; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82c2239140aso133823b3a.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774017721; x=1774622521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXOL9iubHrTOR9uFk5hJvutezBCpUTAEEHozBYZRA8g=;
        b=WFZC5c9IH0Y8WxULW0z10sbs8RMkQSKfw5A5HSeiE7ebA1EtYHFlkM88NjC80rKo5M
         1Rbt8uZk7AhXMOCBEjVKrnsMN5113XHtKOIfQpvFfwIBRtyjISoPNlV2XClbzFWWOK3/
         uLU7XaqN2RnQNOS/CK+2KycfR6VfoZU5RKWz7PHekdjLzY/rVVWPMBhL48wzQ5MTgrw4
         EhFgLN/j+Knl9bjJIgo/z05jqOo6ESQ36YSNmNIVg/j4cOiEnv3S0vaTRpqJMgEd0/jS
         NNJSeY+x+Rzp4eaj6E4YrMadhNZuk8NBcgcPCs94YQPZERGkQ8A8X7pyIB5aGA9/IgQs
         JVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774017721; x=1774622521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SXOL9iubHrTOR9uFk5hJvutezBCpUTAEEHozBYZRA8g=;
        b=XqUpXxTLsfSkMJ2OzmcYzPTVcOvsv+6meBUp5IbCJANM7dhoh0P8HvEkw4T4qFhpL6
         LpDhdV1xC0Db6ccTUNJx7adpcgElVVNSVKb1YqphQYP4n0GVyToFHcwP5HN6xKMxi0gI
         0vtWx07yxZRhAlrZA/CYu9+A4BEWMLUoXihIBWX7DaaaBwV8wPWbJ0+ilUOcjyhIZByv
         Ku8Cl64eYELLYbHWGN3yZivusvuYaz4odzxJ/ItxcrrXsxjYBLyNyI34bdCehQq5nNV5
         E/tXtyDYDJcY2dm73dpjYubZfUar6bRWb32XtdfRMkdlRfLk0L8ssP3eXgJ3FHbrWC6q
         /s1g==
X-Gm-Message-State: AOJu0YwvQiI4bV/qjQ8Q6btKsBgz8oGd1QI7HarFqzVK7WQk+tvV4lVI
	MKBeL0/FGJ3gnrLeL0DI/HW/T2jJ7HkQWz2vRTZb+hiL6H00ldJRhKGTauM/X5e4hS+pdfaoB9E
	pvnXzKtY=
X-Gm-Gg: ATEYQzyeNjuHYQB6M+2YpHw5u4FIfAYWi6RyIFTKU7OH6Lsbdf3LcoYSSLex1F4YrJo
	dW7yvgWxHMikjdwtvVLhYiOl4zWUZyVibX6myfP3N7I8nOCGDNQb9XQ39uqbJ1XU6BISciP0kqn
	yr8GN4fgXjE+YGyT2QYcZh0fSMpZVFkaAAU201ao/cgi2xfyE+3OaVmvL8S4cQLUA6BEYk4pmcA
	H56JPCH61enRmHwDWJPmI9vNV52aOhyqbDHosKl5MNyCDOiL4xih4XkFvoqqpvtDt1dY+t0I3LB
	L9+qwkhTbbah4hs/9dxS4Aa60r9qZbmDV4oWdU6HeSqFG2AUV0CM4+mTAeAxeHw3eiA8C5LlYhk
	2nYZ+sIQmJ6C39mN4UiR3d+8iQq2CwNM2+fs52u4SjmjrTuvWtJ/yEpzPzPgtqRqdKJpfbNMy+e
	1Os+I=
X-Received: by 2002:a05:6a00:299b:b0:82a:f02:7355 with SMTP id d2e1a72fcca58-82a8c35c866mr2564897b3a.32.1774017721399;
        Fri, 20 Mar 2026 07:42:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03aa9619sm2261657b3a.6.2026.03.20.07.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:42:01 -0700 (PDT)
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
Subject: [net-next v4 06/12] net: bnxt: Add TX inline buffer infrastructure
Date: Fri, 20 Mar 2026 07:41:27 -0700
Message-ID: <20260320144141.260246-7-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320144141.260246-1-joe@dama.to>
References: <20260320144141.260246-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-269938-lists,netdev=lfdr.de];
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
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.987];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: 6FFFF2DBFCD
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


