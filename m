Return-Path: <netdev+bounces-181464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA2AA85178
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 04:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03288464E1A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 02:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E851EA90;
	Fri, 11 Apr 2025 02:17:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06BC27932A
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744337860; cv=none; b=ucaenQsoSlIWg/leTUel7VNK8mlCb57suLuwW02BdzNDVwi7sD2jYFmu+Q/rt9llQ8YzXr6vl4QPilJ99WfK9SfkckDgcqHIEbYNVMl6mRq8Aofx2EDNgvf4X7c/M5OU8MmqFAN4QHo4oEbRvwhq6upDC411rKqL2n6R3YubQG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744337860; c=relaxed/simple;
	bh=rCwNUhMjQO4zSOp8eCZR5c1yD2ffSdot1jqUoKHbfp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i1Wo+ugLapzQEySYYnYYF0fb6RUmAnevZ95LxV3OhLO680y1PZC0gArw9/EAp8uRy6WV5oRUbq/6BEXH7mALGMAAM/MSrkgDBXX9OPgsacQIL64UPIMyi+wuU4nx36kxjjh4gJT0QpePYBdU7r2y6FBSpWmOQ1nYdakgZXyuSVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz7t1744337780tbfb407
X-QQ-Originating-IP: H+ByFVKiVrppbXyKOIlmKLpL3WrGzdfQij9dS8vhY8Q=
Received: from wxdbg.localdomain.com ( [220.184.249.159])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 11 Apr 2025 10:16:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5105452606245489037
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
Subject: [PATCH net-next v2] net: txgbe: Update module description
Date: Fri, 11 Apr 2025 10:42:05 +0800
Message-Id: <20250411024205.332613-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ONeCszOCk2GV9GfJLl88X2e6YZeh5IXmY+fM8WZx4031JKTfcF6djCeC
	/GCxdivWuGXC1CWe8kjmSMdiDnuPCc/QuRBqoTqgbz4XoLA+AEnfNC2w5UcuomXyvw6XtFA
	VO94WwUJUreY9IVZ3UTd/qqjgXjzXIfJ8rT8+p3ZTVkfGOOwpzON0TYcamDQHcn8LCGR+aB
	duw7IdTjjH8q67wEKkSxrReMhUr9t+DfqlhjOJHq/SBWBd6AKP7fdUukbqpCZvttUcfsrfT
	63p8yBZLbWRlNIBFodTBnSJCv72rMB5mdOTKRBq83ny4c78kRJZ2uZrHcpn9on0yAA9JEuc
	pSsD6VuEEH42euLdMstlo1OEiR2r9AF1XosS5Hgbg6EPTWhNXaHHyKHawZc202LySBUMztg
	J5Ap82xu2HhOAPBGUW464u+b3fzB/sTVAEuBjccPQ39I9ncqytMIt19Zn5zNDTcHBeERjLO
	xsBRmQoB0aZuCmGGxrpGEmzEqZlUTtf7B0cLsnkeZswajX2OQceXeqkYuPH6LjB5MHEON8E
	KESdz5Jl/LoRxS5+IdnMnCwmB0ShlNyKRdOPUJPg2oEPFqw/4Py7srjDo6wUEvEW8dvj9D8
	m0BMhX2Kj6MCO7BPuCru9LC1fpVIYmCq2SmYZ1LOwzNn+yzScLDjDkSN99JI0vpZtWeG1vb
	yxFTkm/KV98eRm73vNR1WWOg7+4SDUj8vzd43lbNVYLUimDbe50ib+nRe9v6L+wTaqPOpEA
	a8vuIUt6wQ2WtdKv7mTQf5YpwZsELug2RWvmKAJX6Zzu8LAb9o3ujYaXSKTpbVizLM42N4C
	ij9oodMg9gMwFS9rLFKo/w0hHaFsQ2Mpi7VI++brucQ11tbSUaqdRgVkOEAuWrWzwS8MIkx
	S4aMHiLRerGC4TLJaxXv2/sHn8y9D3TLCPzYoNaBlByvAb347b3rloNpqBbNWP3pSTBHRLN
	UQU+6isp15cphmWE90iN69Qejm6pze36TsilvoNpp0i4uNSzTeNcNuc/b5Db/v5CBAtkv6w
	tOW1Yq7qZEikJr0stO
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Because of the addition of support for 25G/40G devices, update the module
description.

Fixes: 2e5af6b2ae85 ("net: txgbe: Add basic support for new AML devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
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


