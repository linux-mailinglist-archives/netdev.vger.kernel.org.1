Return-Path: <netdev+bounces-145722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4FC9D0855
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 05:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D8F4B21427
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 04:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C935181745;
	Mon, 18 Nov 2024 04:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="pC2J3n+z"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B86E2BE;
	Mon, 18 Nov 2024 04:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731903023; cv=none; b=iGMLQORElTe0kmk/C0tywOM3Dpqf66+362iRFi/yR7DCppxAaji+h7vIf+WI/U0353X+iqn8F0SSRoISy1TiVMmJ23pS5EB+j4kEexJ5KK41hIiypT7sw/NKjNqleWw4dz5p/G990cRQOzPn6Kfn0aOHWWnqWe/7rZE9b/+XZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731903023; c=relaxed/simple;
	bh=CUZXK3npAiC71j5t/rX7zvVV7NzMRI88NuO+GHcvZJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FA9h3Gb9xAoiJo/NkZFO8mC9Pzf+D/IkIYf+pSgT9SUqxmjGu/F2JobV9fSdZIfbhmCz5z8QpKQNRsfl5zQQXfSFt1j8+P4sGEuf/doBCTLys0uTzECEiwJzF4HBSWsc6qH6t9saNA/bXzN9C82/Hb0qwcoFLkR6qDpEhuTScpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=pC2J3n+z; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI4A7nM4108783, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731903007; bh=CUZXK3npAiC71j5t/rX7zvVV7NzMRI88NuO+GHcvZJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pC2J3n+zBDDX+z06tcNVQ3rqXzhTXpIy6Q9b8aYNcFYldyk+h27VA3RxeUZNowpDO
	 HuAdPL5vzD+4gMU7tc/DrdtDbRtyTJ20s6BmLi+ORL4R2lNNsjlZhu8wna2g3XW0Nn
	 EQ1T3YiVjVcVUPuhKRGxL6eP+t2alZK0J2ic5GbQ/sUvvhgpC4qfatEKOMqhfiE8F/
	 D4Cy/2okh/8apjsC5eGC87TRYJ4nGJWNKaRaLe4iGa7RI87SwkimCk3/EIV5mxSsUh
	 7VoNF1zR8zvCrg6EX9VgqfwzO3ZYJ0seLc4UrgkVHZZq9vmQVXkGnPxaGizD2ZXI+D
	 7IsLeB3VCf9PQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI4A7nM4108783
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 12:10:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 12:10:06 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Nov
 2024 12:10:05 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v3 3/4] rtase: Corrects error handling of the rtase_check_mac_version_valid()
Date: Mon, 18 Nov 2024 12:08:27 +0800
Message-ID: <20241118040828.454861-4-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118040828.454861-1-justinlai0215@realtek.com>
References: <20241118040828.454861-1-justinlai0215@realtek.com>
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

Corrects error handling of the rtase_check_mac_version_valid().

Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 5b8012987ea6..26331a2b7b2d 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -2122,6 +2122,7 @@ static int rtase_init_one(struct pci_dev *pdev,
 		dev_err(&pdev->dev,
 			"unknown chip version: 0x%08x, contact rtase maintainers (see MAINTAINERS file)\n",
 			tp->hw_ver);
+		goto err_out_release_board;
 	}
 
 	rtase_init_software_variable(pdev, tp);
@@ -2196,6 +2197,7 @@ static int rtase_init_one(struct pci_dev *pdev,
 		netif_napi_del(&ivec->napi);
 	}
 
+err_out_release_board:
 	rtase_release_board(pdev, dev, ioaddr);
 
 	return ret;
-- 
2.34.1


