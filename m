Return-Path: <netdev+bounces-143636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D35A9C36BD
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 03:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E171F22002
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 02:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C163C3C;
	Mon, 11 Nov 2024 02:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="BHuhJPP4"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBAB13A27E;
	Mon, 11 Nov 2024 02:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731293815; cv=none; b=mSmtjjxMrcj1zWSrJpu8e5sZSABFSUgyBQpWsPCIwG5prLULWb6A04g4bXqHap3w4R+1GUVOJx/f8uPweVn0DF2rlefXkuC9/RXiUEOzz0oLVbl7LMkTsEtAPbzfoeuz3QurBkch8cTRNJuZ0NL+jZg723d3cAvXZ8SdBQpQ4Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731293815; c=relaxed/simple;
	bh=6u9gYwMYdkqbZ6KIhI6EYIbRmBK9Pq5HTFD76Ad/wK4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKekZZhyJy9OlYVwB8GWWHL2zALJiNbSa5LcYLDXT6o+7g9Eci30j8jgn9Hsz4QBxinhGnQ6nccpYQop916bhBHCfeI1YfbP4cGyWaKVhs81Udd98gcVeoPXM6J5Z9cax+P4zTCAEBl62E3aXz4cbh+fB2C6hxpUaRw49LLdhEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=BHuhJPP4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AB2uZtiD1487826, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731293795; bh=6u9gYwMYdkqbZ6KIhI6EYIbRmBK9Pq5HTFD76Ad/wK4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=BHuhJPP4P7UdGGYIk6z6mAu5+XOBmpkID3xn5o9AxUWFQmNwJmSIc/1NUnBOscIsI
	 xXjbgmwngr/H1yfzKNnv1bVDIwExImjD4vnjN9vbW5WRpyj/vXI13LxI06nyEZZDjt
	 mp+XK0xDsgQbcYmY07wkAZm6C+ccPuh7q7aL6QJVtOa/XHIpmJuuo5NXJiHFwOfWJa
	 VGaXql77r7Aai8KHhaT15bcYVIPsFPz3nf6x6SKPYE/5WCw/mRkBzBVF+x+ozkTRXj
	 fpbv7bwo7t8ZP3IfvPBLt5pDTW3jNPpPYGrIv4vSUbkqW8m+zifUgjplSSehPMPOhE
	 1AVOeqemWwfkw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AB2uZtiD1487826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 10:56:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 10:56:35 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 11 Nov
 2024 10:56:35 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next 2/2] rtase: Fix error code in rtase_init_one()
Date: Mon, 11 Nov 2024 10:55:32 +0800
Message-ID: <20241111025532.291735-3-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111025532.291735-1-justinlai0215@realtek.com>
References: <20241111025532.291735-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Change the return type of rtase_check_mac_version_valid() to int. Add
error handling for when rtase_check_mac_version_valid() returns an error.

Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 73ebdf0bc376..ba1d376d2319 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1984,9 +1984,9 @@ static void rtase_init_software_variable(struct pci_dev *pdev,
 	tp->dev->max_mtu = RTASE_MAX_JUMBO_SIZE;
 }
 
-static bool rtase_check_mac_version_valid(struct rtase_private *tp)
+static int rtase_check_mac_version_valid(struct rtase_private *tp)
 {
-	bool known_ver = false;
+	int ret = -ENODEV;
 
 	tp->hw_ver = rtase_r32(tp, RTASE_TX_CONFIG_0) & RTASE_HW_VER_MASK;
 
@@ -1995,11 +1995,11 @@ static bool rtase_check_mac_version_valid(struct rtase_private *tp)
 	case RTASE_HW_VER_906X_7XC:
 	case RTASE_HW_VER_907XD_V1:
 	case RTASE_HW_VER_907XD_VA:
-		known_ver = true;
+		ret = 0;
 		break;
 	}
 
-	return known_ver;
+	return ret;
 }
 
 static int rtase_init_board(struct pci_dev *pdev, struct net_device **dev_out,
@@ -2119,9 +2119,12 @@ static int rtase_init_one(struct pci_dev *pdev,
 	tp->pdev = pdev;
 
 	/* identify chip attached to board */
-	if (!rtase_check_mac_version_valid(tp))
-		return dev_err_probe(&pdev->dev, -ENODEV,
-				     "unknown chip version, contact rtase maintainers (see MAINTAINERS file)\n");
+	ret = rtase_check_mac_version_valid(tp);
+	if (ret != 0) {
+		dev_err(&pdev->dev,
+			"unknown chip version, contact rtase maintainers (see MAINTAINERS file)\n");
+		goto err_out_release_board;
+	}
 
 	rtase_init_software_variable(pdev, tp);
 	rtase_init_hardware(tp);
@@ -2129,7 +2132,7 @@ static int rtase_init_one(struct pci_dev *pdev,
 	ret = rtase_alloc_interrupt(pdev, tp);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "unable to alloc MSIX/MSI\n");
-		goto err_out_1;
+		goto err_out_del_napi;
 	}
 
 	rtase_init_netdev_ops(dev);
@@ -2162,7 +2165,7 @@ static int rtase_init_one(struct pci_dev *pdev,
 					     GFP_KERNEL);
 	if (!tp->tally_vaddr) {
 		ret = -ENOMEM;
-		goto err_out;
+		goto err_out_free_dma;
 	}
 
 	rtase_tally_counter_clear(tp);
@@ -2173,13 +2176,13 @@ static int rtase_init_one(struct pci_dev *pdev,
 
 	ret = register_netdev(dev);
 	if (ret != 0)
-		goto err_out;
+		goto err_out_free_dma;
 
 	netdev_dbg(dev, "%pM, IRQ %d\n", dev->dev_addr, dev->irq);
 
 	return 0;
 
-err_out:
+err_out_free_dma:
 	if (tp->tally_vaddr) {
 		dma_free_coherent(&pdev->dev,
 				  sizeof(*tp->tally_vaddr),
@@ -2189,12 +2192,13 @@ static int rtase_init_one(struct pci_dev *pdev,
 		tp->tally_vaddr = NULL;
 	}
 
-err_out_1:
+err_out_del_napi:
 	for (i = 0; i < tp->int_nums; i++) {
 		ivec = &tp->int_vector[i];
 		netif_napi_del(&ivec->napi);
 	}
 
+err_out_release_board:
 	rtase_release_board(pdev, dev, ioaddr);
 
 	return ret;
-- 
2.34.1


