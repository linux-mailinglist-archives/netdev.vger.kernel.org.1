Return-Path: <netdev+bounces-124796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2291296AF3E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 05:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5562E1C24A9D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 03:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9CA44376;
	Wed,  4 Sep 2024 03:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Tr8x5Cob"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329B842A92;
	Wed,  4 Sep 2024 03:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725420293; cv=none; b=hWBxPS+MI4HRhkcCuPa+y7z1PYRADog9xDSrTz4X1rg0Nf+k4LTUU5QqKN1HxsjNmUwcsl247ulCnU4yRJhijQ9vW8DCKWt2eaemQMIR6rMyo5itI/FoXvYINqlRhpbvSUd1ctr++sjKwqqn7aRglInJa5wGBcMEMS/23XWKcXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725420293; c=relaxed/simple;
	bh=j9Ewh3BXZp8v8EOZ/8ToAZeZl09nfFkigGhXGCppxz0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMgtrCITH+fLEL7iqFyuoH3tB8GF8dMZr/iANjmE+waywhjIxBWvbMyZ9xkNzjYN7A4AKP7FeDZrwe0m45/8795YAKJ0gYyNih61Bqa6MfsN/0y0KpqTz3oLWqbCXLTm3fqwc1qUsOriPO3xt7bqbYrVB8kmfgTJn0kjnD1B45o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Tr8x5Cob; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4843OOVG02041262, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1725420264; bh=j9Ewh3BXZp8v8EOZ/8ToAZeZl09nfFkigGhXGCppxz0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Tr8x5CobTlx9O/b4HhhYB15gvZbigWdJ8l6lU9dvfr/v2kXOxdW3f4hhYs/8TsoGy
	 +xwrYn12RBqzTcEQfrmHnarszncKBKtJd4yXhOjSB6B95EhKQCMzbHOj7Ijc+VbmzM
	 qLmHLRQ5gmJSVlYn7om00AZvsVIq23ZVsb9vu7WfmYktFwiDMyX6y2K44QF57icpWn
	 dTu55Lv84hoIJJbt3U5UzzJTfUYloGEwK/xGK0X42GniX46XO0LVbHDyOkt358p32Q
	 N56e6On1WzMvo6gNvrRrBnhup0Dxvm16sJKHfcMidAh3GjSt9JW8tt66O7bCPZ+O4/
	 NI6UZCWQP1z4g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4843OOVG02041262
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 11:24:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 11:24:25 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 4 Sep
 2024 11:24:24 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v30 09/13] rtase: Implement pci_driver suspend and resume function
Date: Wed, 4 Sep 2024 11:21:10 +0800
Message-ID: <20240904032114.247117-10-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904032114.247117-1-justinlai0215@realtek.com>
References: <20240904032114.247117-1-justinlai0215@realtek.com>
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

Implement the pci_driver suspend function to enable the device
to sleep, and implement the resume function to enable the device
to resume operation.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index ea569a2d8b8b..7a31bef0576a 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -2151,12 +2151,63 @@ static void rtase_shutdown(struct pci_dev *pdev)
 	rtase_reset_interrupt(pdev, tp);
 }
 
+static int rtase_suspend(struct device *device)
+{
+	struct net_device *dev = dev_get_drvdata(device);
+
+	if (netif_running(dev)) {
+		netif_device_detach(dev);
+		rtase_hw_reset(dev);
+	}
+
+	return 0;
+}
+
+static int rtase_resume(struct device *device)
+{
+	struct net_device *dev = dev_get_drvdata(device);
+	struct rtase_private *tp = netdev_priv(dev);
+	int ret;
+
+	/* restore last modified mac address */
+	rtase_rar_set(tp, dev->dev_addr);
+
+	if (!netif_running(dev))
+		goto out;
+
+	rtase_wait_for_quiescence(dev);
+
+	rtase_tx_clear(tp);
+	rtase_rx_clear(tp);
+
+	ret = rtase_init_ring(dev);
+	if (ret) {
+		netdev_err(dev, "unable to init ring\n");
+		rtase_free_desc(tp);
+		return -ENOMEM;
+	}
+
+	rtase_hw_config(dev);
+	/* always link, so start to transmit & receive */
+	rtase_hw_start(dev);
+
+	netif_device_attach(dev);
+out:
+
+	return 0;
+}
+
+static const struct dev_pm_ops rtase_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(rtase_suspend, rtase_resume)
+};
+
 static struct pci_driver rtase_pci_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = rtase_pci_tbl,
 	.probe = rtase_init_one,
 	.remove = rtase_remove_one,
 	.shutdown = rtase_shutdown,
+	.driver.pm = pm_ptr(&rtase_pm_ops),
 };
 
 module_pci_driver(rtase_pci_driver);
-- 
2.34.1


