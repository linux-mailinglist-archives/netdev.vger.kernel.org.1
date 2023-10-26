Return-Path: <netdev+bounces-44545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D63307D88AD
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 21:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FC33B212D3
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 19:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC933AC25;
	Thu, 26 Oct 2023 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAkdRLjA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7D53AC20
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 19:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6046BC433C8;
	Thu, 26 Oct 2023 19:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698346868;
	bh=Mi4aTHxhbyBlRBqh76YLWHt6c+16AklrlDx3sfrx72o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cAkdRLjA61W3Ktzh9IbwOCsXNiZhot4KgDdzprssd/zIJaMrcpdb2onMuzuhCq4uF
	 An74eusMcumPerPd84tihOdB2hun8pnuaKruMxCg33YTkq4iaYDkL1eTB3PG8iH6D1
	 kZWTvGILKBuHbZ8ulWGXvT1IkT45oi0qm7IQe4u09jsG3C/H4kycCls3CHL6NZRldL
	 t+lMgul1689kWR+xEM6/tH+3DMHLoNVU95VSXOt1vQteqo41ivHJg3b80PBgtLOkad
	 hVy8LyazzmapXP87aZIrwkuXuniRI3ajwfISeFNrVnB/LX4W33fDIOvZcYPGu89WUc
	 nIw9Zpo3lwVIQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH net-next 1/4] net: fill in MODULE_DESCRIPTION()s in kuba@'s modules
Date: Thu, 26 Oct 2023 12:00:58 -0700
Message-ID: <20231026190101.1413939-2-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231026190101.1413939-1-kuba@kernel.org>
References: <20231026190101.1413939-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Fill it in for the modules I maintain.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: linux-wireless@vger.kernel.org
---
 drivers/net/netdevsim/netdev.c              | 1 +
 drivers/net/wireless/mediatek/mt7601u/usb.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 2eac92f49631..aecaf5f44374 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -470,4 +470,5 @@ static void __exit nsim_module_exit(void)
 module_init(nsim_module_init);
 module_exit(nsim_module_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Simulated networking device for testing");
 MODULE_ALIAS_RTNL_LINK(DRV_NAME);
diff --git a/drivers/net/wireless/mediatek/mt7601u/usb.c b/drivers/net/wireless/mediatek/mt7601u/usb.c
index cc772045d526..d2ee6540ebb2 100644
--- a/drivers/net/wireless/mediatek/mt7601u/usb.c
+++ b/drivers/net/wireless/mediatek/mt7601u/usb.c
@@ -365,6 +365,7 @@ static int mt7601u_resume(struct usb_interface *usb_intf)
 
 MODULE_DEVICE_TABLE(usb, mt7601u_device_table);
 MODULE_FIRMWARE(MT7601U_FIRMWARE);
+MODULE_DESCRIPTION("MediaTek MT7601U USD Wireless LAN driver");
 MODULE_LICENSE("GPL");
 
 static struct usb_driver mt7601u_driver = {
-- 
2.41.0


