Return-Path: <netdev+bounces-135643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DB699EA1D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF40B287119
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BB22281F2;
	Tue, 15 Oct 2024 12:41:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750B82281CD;
	Tue, 15 Oct 2024 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996109; cv=none; b=f1Knx1N5YguvDkdZVMm5PQLv2YmOCIjUy/kuwhsNtdoVCVWiTJpHktW4W7unscCeMCnISboT+q315/v19sbzf7gqzXhJ1+1FM6dQi/PbOb+atzPgkPgnUP0todzPaBvP5Kku5RTmK9U6MoniZOjYsc19wvgTRmoQWTvCsCJDDFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996109; c=relaxed/simple;
	bh=zWwnN2a0LbypivRhJR+UIk+D/aXrd/hpTHzPnq2lgDg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YtVS45UaPfvexIaoBdrnHl2mOIsVBIpGjfhnk5P8GjJK+USnE3MBHtc94zDtfTqBaOSipi4IgaDtrkN4CFnGacajbz1uBjH1GwAFMae7PYJOMMqDhedZEikaXHj6C1SCoIcAuJQjLjO1Qo+JQePUsE7bnfBjiXC3t6qnT0OKhVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XSYcG0SxKz20qQX;
	Tue, 15 Oct 2024 20:41:02 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 3258F1400D4;
	Tue, 15 Oct 2024 20:41:45 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:41:44 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
	<kalesh-anakkur.purayil@broadcom.com>, <christophe.jaillet@wanadoo.fr>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V12 RESEND net-next 09/10] net: hibmcge: Add a Makefile and update Kconfig for hibmcge
Date: Tue, 15 Oct 2024 20:35:15 +0800
Message-ID: <20241015123516.4035035-10-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241015123516.4035035-1-shaojijie@huawei.com>
References: <20241015123516.4035035-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)

Add a Makefile and update Kconfig to build hibmcge driver.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
ChangeLog:
v10 -> v11:
  - Remove "ccflags-y += -I$(src)" from Makefile, suggested by Jakub.
  v10: https://lore.kernel.org/all/20240912025127.3912972-1-shaojijie@huawei.com/
v9 -> v10:
  - Add "select MOTORCOMM_PHY" and "select REALTEK_PHY" in Kconfig.
  v9: https://lore.kernel.org/all/20240910075942.1270054-1-shaojijie@huawei.com/
v2 -> v3:
  - Add "select PHYLIB" in Kconfig, reported by Jakub.
  v2: https://lore.kernel.org/all/20240820140154.137876-1-shaojijie@huawei.com/
v1 -> v2:
  - fix build errors reported by kernel test robot <lkp@intel.com>
    Closes: https://lore.kernel.org/oe-kbuild-all/202408192219.zrGff7n1-lkp@intel.com/
    Closes: https://lore.kernel.org/oe-kbuild-all/202408200026.q20EuSHC-lkp@intel.com/
  v1: https://lore.kernel.org/all/20240819071229.2489506-1-shaojijie@huawei.com/
RFC v1 -> RFC v2:
  - Support to compile this driver on all arch in Kconfig,
    suggested by Andrew and Jonathan.
  RFC v1: https://lore.kernel.org/all/20240731094245.1967834-1-shaojijie@huawei.com/
---
 drivers/net/ethernet/hisilicon/Kconfig         | 18 +++++++++++++++++-
 drivers/net/ethernet/hisilicon/Makefile        |  1 +
 .../net/ethernet/hisilicon/hibmcge/Makefile    |  8 ++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/Makefile

diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
index 3312e1d93c3b..65302c41bfb1 100644
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
@@ -141,4 +142,19 @@ config HNS3_ENET
 
 endif #HNS3
 
+endif # ARM || ARM64 || COMPILE_TEST
+
+config HIBMCGE
+	tristate "Hisilicon BMC Gigabit Ethernet Device Support"
+	depends on PCI && PCI_MSI
+	select PHYLIB
+	select MOTORCOMM_PHY
+	select REALTEK_PHY
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
index 000000000000..ae58ac38c206
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Makefile for the HISILICON BMC GE network device drivers.
+#
+
+obj-$(CONFIG_HIBMCGE) += hibmcge.o
+
+hibmcge-objs = hbg_main.o hbg_hw.o hbg_mdio.o hbg_irq.o hbg_txrx.o hbg_ethtool.o
-- 
2.33.0


