Return-Path: <netdev+bounces-120878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C5395B1F0
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4112528233F
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 09:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E977418595F;
	Thu, 22 Aug 2024 09:39:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9BB183CC9;
	Thu, 22 Aug 2024 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319583; cv=none; b=FFf+5QOlTm3xc2vZsH8PbtADn8/AqCgpn0jVF7mLev/ybOUGXfF3OW8IJ4pGr/8wcJ5ytADThAMlEhiq0IOKehHQTSI9GySNWn850MJ0xAQu6Da+AWrHvIczQsy6olcQaSDRXDGLwXDazpC16PZp4qs6k67aBL6deZ04IGBa+L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319583; c=relaxed/simple;
	bh=WushfD6vdnXkxgpb/FoW0A7gtMJRdBCa629d7wgPqZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PIK5P4GAumCbPMPUs+S/opEgAW8lT5gaUiaAven6X9r55AINIvrxmdvTJdrHSFDjR73j6sJBuah0jU64FiT1HZA8GgZWOMgRmb7Ez1th8uvXrYZbOsVzT2QCoRy0PmmF+dSsitKIbWga7FGzMtMX7UNDhwRgHs4BXxTMJ+kFWYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WqJ662YdgzVkrZ;
	Thu, 22 Aug 2024 17:38:06 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D044140134;
	Thu, 22 Aug 2024 17:39:39 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 17:39:38 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V3 net-next 09/11] net: hibmcge: Add a Makefile and update Kconfig for hibmcge
Date: Thu, 22 Aug 2024 17:33:32 +0800
Message-ID: <20240822093334.1687011-10-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240822093334.1687011-1-shaojijie@huawei.com>
References: <20240822093334.1687011-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000007.china.huawei.com (7.193.23.189)

Add a Makefile and update Kconfig to build hibmcge driver.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/Kconfig          | 16 +++++++++++++++-
 drivers/net/ethernet/hisilicon/Makefile         |  1 +
 drivers/net/ethernet/hisilicon/hibmcge/Makefile | 10 ++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/Makefile

diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
index 3312e1d93c3b..66444794ce86 100644
--- a/drivers/net/ethernet/hisilicon/Kconfig
+++ b/drivers/net/ethernet/hisilicon/Kconfig
@@ -7,7 +7,6 @@ config NET_VENDOR_HISILICON
 	bool "Hisilicon devices"
 	default y
 	depends on OF || ACPI
-	depends on ARM || ARM64 || COMPILE_TEST
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
@@ -18,6 +17,8 @@ config NET_VENDOR_HISILICON
 
 if NET_VENDOR_HISILICON
 
+if ARM || ARM64 || COMPILE_TEST
+
 config HIX5HD2_GMAC
 	tristate "Hisilicon HIX5HD2 Family Network Device Support"
 	select PHYLIB
@@ -141,4 +142,17 @@ config HNS3_ENET
 
 endif #HNS3
 
+endif # ARM || ARM64 || COMPILE_TEST
+
+config HIBMCGE
+	tristate "Hisilicon BMC Gigabit Ethernet Device Support"
+	depends on PCI && PCI_MSI
+	select PHYLIB
+	help
+	  If you wish to compile a kernel for a BMC with HIBMC-xx_gmac
+	  then you should answer Y to this. This makes this driver suitable for use
+	  on certain boards such as the HIBMC-210.
+
+	  If you are unsure, say N.
+
 endif # NET_VENDOR_HISILICON
diff --git a/drivers/net/ethernet/hisilicon/Makefile b/drivers/net/ethernet/hisilicon/Makefile
index 7f76d412047a..0e2cadfea8ff 100644
--- a/drivers/net/ethernet/hisilicon/Makefile
+++ b/drivers/net/ethernet/hisilicon/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_HNS_MDIO) += hns_mdio.o
 obj-$(CONFIG_HNS) += hns/
 obj-$(CONFIG_HNS3) += hns3/
 obj-$(CONFIG_HISI_FEMAC) += hisi_femac.o
+obj-$(CONFIG_HIBMCGE) += hibmcge/
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/Makefile b/drivers/net/ethernet/hisilicon/hibmcge/Makefile
new file mode 100644
index 000000000000..ea223b7207af
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Makefile for the HISILICON BMC GE network device drivers.
+#
+
+ccflags-y += -I$(src)
+
+obj-$(CONFIG_HIBMCGE) += hibmcge.o
+
+hibmcge-objs = hbg_main.o hbg_hw.o hbg_mdio.o hbg_irq.o hbg_txrx.o hbg_ethtool.o
-- 
2.33.0


