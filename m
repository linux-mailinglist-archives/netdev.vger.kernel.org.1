Return-Path: <netdev+bounces-182017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 126E1A875A0
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 03:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C073188F76C
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 01:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF52A2BCF5;
	Mon, 14 Apr 2025 01:59:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DF433FD
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 01:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744595979; cv=none; b=JTybOxca9ASTkgOeYp3Jtb8JlSQPfOi37vtbUR5c/yI3gTLCU9SnQY8wIXzw9RalQhsiiJVkudlS4yotW3fVfH1g6UXdOqiTQphtizCdm4mc9GOL6gxPmOqQaImTQE4U+GbKOEVeTwuKFrcFwPjYjsHJr0vB62Vojn+S3CcPXgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744595979; c=relaxed/simple;
	bh=iGd8LWQSiKRimv1mB0bssVsLD9xFt1i2nZ80G9Y5MQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QZMQZnP7MK3Fg2eaRtJOWOwK5K935ZOWprkwgE1NaoQrcKYZ6dRjtvFEMJwF/H2sZVdYtbhEt3BN6aD2pRDfpMAVt7JPJi3LcGCYYy7a9kd5CyfRiCYKoxXHxW891t8XS4yKA2JBGgl0nLF5NKUISgXYAClwVMR0akySNQCeaXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: izesmtpsz16t1744595922t44b407
X-QQ-Originating-IP: WcjarAxRG7CgoxaoV6fwrJ1y1shhAG/uWehwLx0yKJg=
Received: from wxdbg.localdomain.com ( [36.20.107.143])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Apr 2025 09:58:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 916333804882134327
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
Subject: [PATCH net-next v3] net: txgbe: Update module description
Date: Mon, 14 Apr 2025 10:24:21 +0800
Message-Id: <20250414022421.375101-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: OSjQccS6YHkHwsrHaNk7uRCJjlSFirNQ4VPPwOdEiz6A35c17p6SaBPB
	+vCwBsV2U6dVUHAYukWui4ai2KFpG89t9PLhmy4ogdTT+pdASac24VDOXgMQjfL9SaIrWfL
	55HPwpuC1fi3FIXoAFUGeFs7NTDAgjhkep2lHq4LeIQ2Z4gY5+E8nY3sHaNOlBmRFJQ6UN+
	bG6KPy7e8ugZWt86Nmha6RiYFB4dCr5OjR+szqUP1QXibaQnkfgGimId11aWwyI+ARhiXAV
	9Sy8A/ERbtU3NUh6lkiae5rrgbyOBR3nzgBJB3Ar5ny/HT//91GwKs4wBYR2RYTlZb7JAud
	3mOgYgTVlZDAneHl668Zee347ZY7Dv5BfgfTBuU/Gowf9djrBKxHRXMDbXNwOwCJj+FlzW8
	cVsj3THUfKwvnoX7sAFeerI+GXI+2fjoEELNCd1Z1I9NZLdS16YeB5wfbOjZpdO6vMV5IGQ
	Kv0gtzZaq0i0Lm66NxrBM9dhS02HWGMfzwseXnCdjOarDbUO7hqAjqBoS3ahrlG7PH45g2q
	gBN3LTluWri3tASV4iwqnesmhPkSWEKFsOpsz7EbW7dW24WVd4s1d+EXrL2tUSDLI3Qg+29
	bpq+ONfZg/eRBxGJCbzgeSz4IKTlnHkvTBJKs2UdIgJty8efduouppjZYn2XNCMrooGSDUV
	7oPynZdKJL17PIIj7a48bA5jtB1nXsJyANHls9txV5GXc0+NRq3KPRqLTX3I/FVXD4j5++E
	NAG5x7XDQv2wKASjvSlXk5FBgzvur5oQUkW2oKxeTRI/u077RHlbCNlOOXt0a+at4PAmP4L
	8lXzhMbARWNmDaiPMz9aEH8bdRJL6FVIuxkyZ8kSYuOWdXoSF262Xvhbb/uEPmeqcbgo3fA
	UAx8JFtzWxWxzl9/7SK1gZLni7IHENDegqMtpUJE71U0TGp94qv35/w/T67z1XGtw9enX9X
	zE63U1pXzidFZYvd5nJHHNRermFQv0VRtW6jtd8P7Wzm6T5l0yf4fuBhqU133J+3SSfjHs3
	mtgr2YHYwdI2RI/sKQ7+rSyDoE5ODPP/6tRmADcA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Because of the addition of support for 25G/40G devices, update the module
description.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
v3:
 - remove fixes tag
v2:
 - post for net-next
 - sort device speeds from the slowest
---
 drivers/net/ethernet/wangxun/Kconfig            | 4 ++--
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/Kconfig b/drivers/net/ethernet/wangxun/Kconfig
index 47e3e8434b9e..e5fc942c28cc 100644
--- a/drivers/net/ethernet/wangxun/Kconfig
+++ b/drivers/net/ethernet/wangxun/Kconfig
@@ -40,7 +40,7 @@ config NGBE
 	  will be called ngbe.
 
 config TXGBE
-	tristate "Wangxun(R) 10GbE PCI Express adapters support"
+	tristate "Wangxun(R) 10/25/40GbE PCI Express adapters support"
 	depends on PCI
 	depends on COMMON_CLK
 	depends on I2C_DESIGNWARE_PLATFORM
@@ -55,7 +55,7 @@ config TXGBE
 	select PCS_XPCS
 	select LIBWX
 	help
-	  This driver supports Wangxun(R) 10GbE PCI Express family of
+	  This driver supports Wangxun(R) 10/25/40GbE PCI Express family of
 	  adapters.
 
 	  More specific information on configuring the driver is in
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 6d9134a3ce4d..db5166a6db2c 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -849,5 +849,5 @@ module_pci_driver(txgbe_driver);
 
 MODULE_DEVICE_TABLE(pci, txgbe_pci_tbl);
 MODULE_AUTHOR("Beijing WangXun Technology Co., Ltd, <software@trustnetic.com>");
-MODULE_DESCRIPTION("WangXun(R) 10 Gigabit PCI Express Network Driver");
+MODULE_DESCRIPTION("WangXun(R) 10/25/40 Gigabit PCI Express Network Driver");
 MODULE_LICENSE("GPL");
-- 
2.27.0


