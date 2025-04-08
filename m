Return-Path: <netdev+bounces-180073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7CAA7F720
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF351781A5
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 07:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B51263F31;
	Tue,  8 Apr 2025 07:55:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA4425F987
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744098927; cv=none; b=nhLdLL+dqr/NX+/9vnzITIxfI0XFQjFTzNk5JHNm7JKkc+aL4pF/tX4UPCU0//6JGpcWH4tgAZn++u2PF21kWfXgE+AEF1QIfarQ+4xWMwCFnJpqcuAHdh+JjHKvctauE/6rnosdRu2Ym7nvWUZqHCzOEvJF61iMQqegqbZ3X6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744098927; c=relaxed/simple;
	bh=3zv+IUQBHZtpunbaw5YqTM1cCGLzo+qdCT3k8yc3Woo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H14Cr4q1WZ51WPYepjlvGpNAl5JkZu0l1Dlsay/fdiaqCVqH45xM8vWu28mrnK0VdYdifbvSOV7yCgef5amAOVpcNCXsMZftHZUwRz65XqAbvMZHg0Y6b1vN0wOKVPDqjO6hGiCpUreSNxhSC0zl5bTJFllvWePgXU68FZ46OpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: izesmtpsz19t1744098849t627298
X-QQ-Originating-IP: BxeaNbB3jwPVZdDrhP9TmTqIG/KhpaI87NnWGbmuDw0=
Received: from wxdbg.localdomain.com ( [183.159.168.74])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Apr 2025 15:54:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6104756855174649655
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net] net: txgbe: Update module description
Date: Tue,  8 Apr 2025 16:19:58 +0800
Message-Id: <20250408081958.289773-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: izesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OGvgEoGelOUdgZ2B1WRiYkCtnFwwQLuCUE4AZijQT5MaZU0foNzOY/yv
	LLFjVtmsB8OUmdJMVv872F0K8KntR3ZSH04QfJWBZobCgzoQByEijpE6V2unFIO8HJoMLxd
	NnFBDhzHkbmqICBMIg/E3J6wUxZHJyaInFKX2K572jEgARCWY7By8hU7Vhn3rt3s0p6sO/j
	3sD5h0wpA+OZdZlTleahHRX1TimJD4y/Urnhtk0EaDRlHnL03UA57SGD9Av9jYWFl1NEc/8
	fXTA+xxxNDv+0cEShN20nzV0/f2mpZnQV+xYugwfR4naaXAyXnd6cgdPzN2zWOoZ+u+FMT0
	hegRVZO/p6N1wAniXE03Deyg75nNqMaDxANVPXc/p1jBAycSmZEp3U7fsgql+DtyI2t6kfq
	UMgB7nSjrHsHVrw3Vu4hfNa7E1VMUnZgzKRsboSgJAuEzETwAzSxyj8b8nCSY3m61olwPuZ
	xsyMxZyxQ70gL4ub/9pGvuOUIH4kSMxCcX7pDXJa1JaYOLX22TJnjlifithEtAChf/NsLLH
	Muc95igmBCU2K6dqLVtt5bId9gzHYTsi/aZqojuLiH7PZTtza3WxGsN99xTAkz8y6tieVF7
	fJFY+1Noh9k0zfNYwcmfcmULl0FAkkptalE+p8wylwfWNJGH+KcUhGQHsAAStkp2iSHkcIu
	K6yEJ2XGHoS5CpuWF71Ms+K1vGqp1ty848IpWotP7HUKoVqRglY2kS+VnAQ2jhgHHgdAaXa
	18mg/1QrDksmxRFml9cTSgpoL49Tl/+EPGzZwmuf+jN6LyDETk6YrkvzRP1ax4oBu5EUl8E
	xOkASVFu6UjRnaDtijB7mQUsKTSjNr4vdPdVIWLU+5fZ83t4Ux4CzjVCzp4d3ArAowxoVID
	re5odV4+32lf3Qxej8W7mLmgH7ckaTzxbYSj8RQl4zBDcuPAGRiWZGkDw8t2suAGnUODfng
	3zx/NFG9CHOucKyUewmbtdnAOSP8QA4IWNKzbTnvcdoQal8ErsMyQmhUIsHYtpuzyDezRWt
	C4ARIosZhv2w9QQvW/ZjMgVcEMLA0=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Because of the addition of support for 40G/25G devices, update the module
description.

Fixes: 2e5af6b2ae85 ("net: txgbe: Add basic support for new AML devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/Kconfig            | 4 ++--
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/Kconfig b/drivers/net/ethernet/wangxun/Kconfig
index 47e3e8434b9e..2428f045d513 100644
--- a/drivers/net/ethernet/wangxun/Kconfig
+++ b/drivers/net/ethernet/wangxun/Kconfig
@@ -40,7 +40,7 @@ config NGBE
 	  will be called ngbe.
 
 config TXGBE
-	tristate "Wangxun(R) 10GbE PCI Express adapters support"
+	tristate "Wangxun(R) 40/25/10GbE PCI Express adapters support"
 	depends on PCI
 	depends on COMMON_CLK
 	depends on I2C_DESIGNWARE_PLATFORM
@@ -55,7 +55,7 @@ config TXGBE
 	select PCS_XPCS
 	select LIBWX
 	help
-	  This driver supports Wangxun(R) 10GbE PCI Express family of
+	  This driver supports Wangxun(R) 40/25/10GbE PCI Express family of
 	  adapters.
 
 	  More specific information on configuring the driver is in
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index a2e245e3b016..6a09728b9871 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -822,5 +822,5 @@ module_pci_driver(txgbe_driver);
 
 MODULE_DEVICE_TABLE(pci, txgbe_pci_tbl);
 MODULE_AUTHOR("Beijing WangXun Technology Co., Ltd, <software@trustnetic.com>");
-MODULE_DESCRIPTION("WangXun(R) 10 Gigabit PCI Express Network Driver");
+MODULE_DESCRIPTION("WangXun(R) 40/25/10 Gigabit PCI Express Network Driver");
 MODULE_LICENSE("GPL");
-- 
2.27.0


