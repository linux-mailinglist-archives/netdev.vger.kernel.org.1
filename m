Return-Path: <netdev+bounces-170625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D2FA4965B
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 111EA7A3669
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659A825C719;
	Fri, 28 Feb 2025 10:00:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-12.us.a.mail.aliyun.com (out198-12.us.a.mail.aliyun.com [47.90.198.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD42A25C700;
	Fri, 28 Feb 2025 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736857; cv=none; b=Kju1I2a3pCefSctyqY9oyaOyMjz2HxTxz2jTUCaipqarEpvjmFHRkKGZiGPY6MxNsHZLe7JPyvpnksMbyiXnOfnycfixd+7L3FvUaw4w84EayKjmnoUTE72VyABAXYI/sDFX3dXSphG31XaoxNXTugRMT7l/aNQm9kXGnq+U3JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736857; c=relaxed/simple;
	bh=T/HPbv1PGiMRr03PFoY1hMdTweVwOtuTGKoPOotDdVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V4+d9AOLAaopM+Jz/PxozTTX+qxfoJKu4j2THFv7zo+jUTTTzdSL++7ZeZqo17g2A5Nd2sKraiEYt0RMEyic6g5HSAnkG8B9K0RQV8Fq8Wi6lRlXFAVgO8UxmhP+4M72E2jHRNrAirBKSqw6nLsDkuw2FeIV8O7yYcrNBeMTU+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.bfyn1Mk_1740736841 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 18:00:41 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Frank <Frank.Sae@motor-comm.com>,
	netdev@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Parthiban.Veerasooran@microchip.com,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: [PATCH net-next v3 13/14] motorcomm:yt6801: Add makefile and Kconfig
Date: Fri, 28 Feb 2025 18:00:19 +0800
Message-Id: <20250228100020.3944-14-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
References: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Makefile in the motorcomm folder to build yt6801 driver.
Add the YT6801 and NET_VENDOR_MOTORCOMM entry in the Kconfig.
Add the CONFIG_YT6801 entry in the Makefile.
Add the motorcomm entry in the Kconfig.
Add the CONFIG_NET_VENDOR_MOTORCOMM entry in the Makefile.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 drivers/net/ethernet/Kconfig                  |  1 +
 drivers/net/ethernet/Makefile                 |  1 +
 drivers/net/ethernet/motorcomm/Kconfig        | 27 +++++++++++++++++++
 drivers/net/ethernet/motorcomm/Makefile       |  6 +++++
 .../net/ethernet/motorcomm/yt6801/Makefile    |  8 ++++++
 5 files changed, 43 insertions(+)
 create mode 100644 drivers/net/ethernet/motorcomm/Kconfig
 create mode 100644 drivers/net/ethernet/motorcomm/Makefile
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/Makefile

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 977b42bc1..a02ef77f8 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -127,6 +127,7 @@ source "drivers/net/ethernet/micrel/Kconfig"
 source "drivers/net/ethernet/microchip/Kconfig"
 source "drivers/net/ethernet/mscc/Kconfig"
 source "drivers/net/ethernet/microsoft/Kconfig"
+source "drivers/net/ethernet/motorcomm/Kconfig"
 source "drivers/net/ethernet/moxa/Kconfig"
 source "drivers/net/ethernet/myricom/Kconfig"
 
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 99fa180de..f1f44396f 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_NET_VENDOR_META) += meta/
 obj-$(CONFIG_NET_VENDOR_MICREL) += micrel/
 obj-$(CONFIG_NET_VENDOR_MICROCHIP) += microchip/
 obj-$(CONFIG_NET_VENDOR_MICROSEMI) += mscc/
+obj-$(CONFIG_NET_VENDOR_MOTORCOMM) += motorcomm/
 obj-$(CONFIG_NET_VENDOR_MOXART) += moxa/
 obj-$(CONFIG_NET_VENDOR_MYRI) += myricom/
 obj-$(CONFIG_FEALNX) += fealnx.o
diff --git a/drivers/net/ethernet/motorcomm/Kconfig b/drivers/net/ethernet/motorcomm/Kconfig
new file mode 100644
index 000000000..abcc6cbcc
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/Kconfig
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Motorcomm network device configuration
+#
+
+config NET_VENDOR_MOTORCOMM
+	bool "Motorcomm devices"
+	default y
+	help
+	  If you have a network (Ethernet) device belonging to this class,
+	  say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about Motorcomm devices. If you say Y, you will be
+	  asked for your specific device in the following questions.
+
+if NET_VENDOR_MOTORCOMM
+
+config YT6801
+	tristate "Motorcomm(R) 6801 PCI-Express Gigabit Ethernet support"
+	depends on PCI && NET
+	help
+	  This driver supports Motorcomm(R) 6801 gigabit ethernet family of
+	  adapters.
+
+endif # NET_VENDOR_MOTORCOMM
diff --git a/drivers/net/ethernet/motorcomm/Makefile b/drivers/net/ethernet/motorcomm/Makefile
new file mode 100644
index 000000000..511940680
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Motorcomm network device drivers.
+#
+
+obj-$(CONFIG_YT6801) += yt6801/
diff --git a/drivers/net/ethernet/motorcomm/yt6801/Makefile b/drivers/net/ethernet/motorcomm/yt6801/Makefile
new file mode 100644
index 000000000..2f370d933
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Motor-comm Corporation.
+#
+# Makefile for the Motorcomm(R) 6801 PCI-Express ethernet driver
+#
+
+obj-$(CONFIG_YT6801) += yt6801.o
+yt6801-objs :=  yt6801_desc.o  yt6801_net.o  yt6801_pci.o
-- 
2.34.1


