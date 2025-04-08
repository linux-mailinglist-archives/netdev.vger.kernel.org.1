Return-Path: <netdev+bounces-180111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3795CA7F990
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0838B172D99
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFD8266B6C;
	Tue,  8 Apr 2025 09:29:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CDF264FAA;
	Tue,  8 Apr 2025 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744104557; cv=none; b=iBlmA1Pfy8+wfx8193pSuDVt8cp4DPVxk2HUHRSikceF+BLsF9pbJiSouCUNhgj3W0b6D2I2bNke+mbPSQO61S9k6yHsWMCTDWqYbzIk9f/qLCBcDPbj6Wh9CavP0l+GojCGS1gB683FnhZ9cXTJJCJjNkASxlfNrjJFqJC+lYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744104557; c=relaxed/simple;
	bh=jNGVJohvrKFa/gqmju6iZnp7zjnvQ4yV+9hIwCbSles=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FTZYL9Q0GANcdgElM2YRLxRzqy6+dAI0Dt5AIP00tLyZ6IK9r+5UsP+tFqnnfLhFyuI0vG0bk+ucRIPzfsOSEJN7zCC36bnsqF8hHvf9uqK14/237iRACPm99ZQMoF1vt2QlrTFYzb8TqI4Orhb3+Tq7MWU+1S9vTBpTu4p5pMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.cGww7ZP_1744104542 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 17:29:02 +0800
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
	"andrew+netdev @ lunn . ch" <andrew+netdev@lunn.ch>,
	lee@trager.us,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	geert+renesas@glider.be,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: [PATCH net-next v4 14/14] yt6801: update ethernet documentation and maintainer
Date: Tue,  8 Apr 2025 17:28:35 +0800
Message-Id: <20250408092835.3952-15-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
References: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the yt6801.rst in ethernet/motorcomm folder
Add the yt6801 entry in the index.rst.
Add myself as the maintainer for the motorcomm ethernet driver.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../device_drivers/ethernet/index.rst         |  1 +
 .../ethernet/motorcomm/yt6801.rst             | 20 +++++++++++++++++++
 MAINTAINERS                                   |  8 ++++++++
 3 files changed, 29 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/motorcomm/yt6801.rst

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 05d822b90..7a158af55 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -46,6 +46,7 @@ Contents:
    mellanox/mlx5/index
    meta/fbnic
    microsoft/netvsc
+   motorcomm/yt6801
    neterion/s2io
    netronome/nfp
    pensando/ionic
diff --git a/Documentation/networking/device_drivers/ethernet/motorcomm/yt6801.rst b/Documentation/networking/device_drivers/ethernet/motorcomm/yt6801.rst
new file mode 100644
index 000000000..dd1e59c33
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/motorcomm/yt6801.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================================================
+Linux Base Driver for Motorcomm(R) Gigabit PCI Express Adapters
+================================================================
+
+Motorcomm Gigabit Linux driver.
+Copyright (c) 2021 - 2024 Motor-comm Co., Ltd.
+
+
+Contents
+========
+
+- Support
+
+
+Support
+=======
+If you got any problem, contact Motorcomm support team via support@motor-comm.com
+and Cc: netdev.
diff --git a/MAINTAINERS b/MAINTAINERS
index 4c5c2e2c1..1d7700e6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16351,6 +16351,14 @@ F:	drivers/most/
 F:	drivers/staging/most/
 F:	include/linux/most.h
 
+MOTORCOMM ETHERNET DRIVER
+M:	Frank <Frank.Sae@motor-comm.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+W:	https://www.motor-comm.com/
+F:	Documentation/networking/device_drivers/ethernet/motorcomm/*
+F:	drivers/net/ethernet/motorcomm/*
+
 MOTORCOMM PHY DRIVER
 M:	Frank <Frank.Sae@motor-comm.com>
 L:	netdev@vger.kernel.org
-- 
2.34.1


