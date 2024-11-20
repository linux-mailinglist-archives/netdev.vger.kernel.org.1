Return-Path: <netdev+bounces-146472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9DC9D38E4
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7661F25ED0
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3274419E98A;
	Wed, 20 Nov 2024 10:57:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-17.us.a.mail.aliyun.com (out198-17.us.a.mail.aliyun.com [47.90.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10A81AAE00;
	Wed, 20 Nov 2024 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100223; cv=none; b=Mj+9pRmH0OyrGWsJ4OANnH/2svmEYBgnp0qf+kTEyiEQI5FYyrLTh1e3ZfCQWaWG28oDBjxko7xi5R0lO1epYwI5xaVVuYFHrRJ/kn16fxpgmoxyXmC71ZRmE3vBOUhVbwG65sPGAoYp2NtQnVxm4oRNegT/ww37lGxx8YZpYBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100223; c=relaxed/simple;
	bh=EmhAm8eaURBDLb9g0pu8AdTnxGYLQF+n8L4F/thtkm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/GvCnlLMCOQHUNrvoET5E89yYgKIzucqgfZ7V79RHO31FkvqrHydxdj6vuw6x7qNHg+X4+9/cDfG6pxVZ/28vEwJj6wHyOtInMhuNqcN6SY9B26fqjOJSnCnTNq3uQ+LfRxW/JVM9wBIly+jhCj5JYsshMjDSIFJ+a0rP8QzRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aGmppel_1732100207 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 18:56:47 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com,
	Frank.Sae@motor-comm.com
Subject: [PATCH net-next v2 17/21] motorcomm:yt6801: Update the Makefile and Kconfig in the motorcomm
Date: Wed, 20 Nov 2024 18:56:21 +0800
Message-Id: <20241120105625.22508-18-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. Add the YT6801 and NET_VENDOR_MOTORCOMM entry in the Kconfig.
2. Add the CONFIG_YT6801 entry in the Makefile.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 drivers/net/ethernet/motorcomm/Kconfig  | 27 +++++++++++++++++++++++++
 drivers/net/ethernet/motorcomm/Makefile |  6 ++++++
 2 files changed, 33 insertions(+)
 create mode 100644 drivers/net/ethernet/motorcomm/Kconfig
 create mode 100644 drivers/net/ethernet/motorcomm/Makefile

diff --git a/drivers/net/ethernet/motorcomm/Kconfig b/drivers/net/ethernet/motorcomm/Kconfig
new file mode 100644
index 000000000..e85d11687
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
+	  the questions about Synopsys devices. If you say Y, you will be asked
+	  for your specific device in the following questions.
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
-- 
2.34.1


