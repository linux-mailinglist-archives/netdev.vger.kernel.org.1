Return-Path: <netdev+bounces-63202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD72A82BA9D
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 06:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F159284ABC
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 05:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37E95B5CB;
	Fri, 12 Jan 2024 05:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="QA0/dBLr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7945B5BA
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 05:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e7f58c5fbso8158195e87.1
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 21:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1705036007; x=1705640807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b+4tG41mP4l7Ohc5Jalm3vix0bi5L8YN+ujb4C4h1ag=;
        b=QA0/dBLrisqNG8n97OoRBUwxzMDg8z7YrDfZpmLAO1xicBRSPcGevCYwcfDJS3On4C
         apC+axC1RXrqjrBB1BtT772wsiXjaOjJGN3hjnD1eRCFN/Dk5dbeIzHP3CZMV4NgaqkJ
         w5tKYNm6Pjb78H/keE2NB2rHmw4QRR/e+dp848kib7sKr5Vfvah/Y2lGR1t2tAPKuxnY
         oXEGcF9YnYFbDPLknBXqEO9xtluielzbF5SEs2eVSk7gx3Fq33Ec8+EpPjJyZTANGasH
         Za9Wxt1SI9WzubLJ36JEvNO2c+yICK97/4sad1parm30szI+8DddKW31iN3yH27UsjLx
         6LWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705036007; x=1705640807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+4tG41mP4l7Ohc5Jalm3vix0bi5L8YN+ujb4C4h1ag=;
        b=p2n7uGn+rl+r+tDyM9qFiyLvoMHYpC6uy7NYKhxnracd0CMEmGJJDrMnQcGauDbOUT
         dh5IUJXR8ooQgwb3SPiJZbZAfNx8gUdgcBp8mRdj2fwtnfRDmGPTIV9Zn6m9NBdN2QM/
         9+FVzWV2WJmtbSfI3JdVU6ZwxO/Be7VCER6hECroIekhElMhlAzDuq74nSJVglPFGi/f
         5KBAisxOwaxdFte8DIE3tEHaPvT3Lg0LyhyU7Gfdxe7juKx9+vduFwCKCo8iUF3uc4el
         s6Pk3sfcvUlLhScB/ELZvLeYtMSVgrwYZzz/IbgQwNVSNfYnAu7DyDIFZd2psMU1RFWa
         UY0g==
X-Gm-Message-State: AOJu0YyolDRrV+F7XkM0e9DR4DFyVdAc90szG6kEKRuSb9aa7LpFvAIV
	WxS827QVkRiFbNM3DF8luByPsyj4zo6elg==
X-Google-Smtp-Source: AGHT+IH1MOKZzlEESJbBk4sKtsahzm0eQd1Of14vPnbqmfztXRNy/qS2PVwoSGypEfBpRUe90CGB3g==
X-Received: by 2002:a05:6512:3a94:b0:50e:55d0:855c with SMTP id q20-20020a0565123a9400b0050e55d0855cmr400740lfu.17.1705036006695;
        Thu, 11 Jan 2024 21:06:46 -0800 (PST)
Received: from cobook.home ([91.231.66.25])
        by smtp.gmail.com with ESMTPSA id q23-20020a056512211700b0050e7ed9585asm381507lfr.233.2024.01.11.21.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 21:06:46 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] net: ethernet: ravb: fix dma mapping failure handling
Date: Fri, 12 Jan 2024 11:06:39 +0600
Message-Id: <20240112050639.405784-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_mapping_error() depends on getting full 64-bit dma_addr_t and does
not work correctly if 32-bit value is passed instead.

Fix handling of dma_map_single() failures on Rx ring entries:
- do not store return value of dma_map_signle() in 32-bit variable,
- do not use dma_mapping_error() against 32-bit descriptor field when
  checking if unmap is needed, check for zero size instead.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 8649b3e90edb..4d4b5d44c4e7 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -256,8 +256,7 @@ static void ravb_rx_ring_free_gbeth(struct net_device *ndev, int q)
 	for (i = 0; i < priv->num_rx_ring[q]; i++) {
 		struct ravb_rx_desc *desc = &priv->gbeth_rx_ring[i];
 
-		if (!dma_mapping_error(ndev->dev.parent,
-				       le32_to_cpu(desc->dptr)))
+		if (le16_to_cpu(desc->ds_cc) != 0)
 			dma_unmap_single(ndev->dev.parent,
 					 le32_to_cpu(desc->dptr),
 					 GBETH_RX_BUFF_MAX,
@@ -281,8 +280,7 @@ static void ravb_rx_ring_free_rcar(struct net_device *ndev, int q)
 	for (i = 0; i < priv->num_rx_ring[q]; i++) {
 		struct ravb_ex_rx_desc *desc = &priv->rx_ring[q][i];
 
-		if (!dma_mapping_error(ndev->dev.parent,
-				       le32_to_cpu(desc->dptr)))
+		if (le16_to_cpu(desc->ds_cc) != 0)
 			dma_unmap_single(ndev->dev.parent,
 					 le32_to_cpu(desc->dptr),
 					 RX_BUF_SZ,
@@ -1949,7 +1947,7 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	struct ravb_tstamp_skb *ts_skb;
 	struct ravb_tx_desc *desc;
 	unsigned long flags;
-	u32 dma_addr;
+	dma_addr_t dma_addr;
 	void *buffer;
 	u32 entry;
 	u32 len;
-- 
2.39.2


