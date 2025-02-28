Return-Path: <netdev+bounces-170626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90219A49665
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721FF18856B3
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0712620C6;
	Fri, 28 Feb 2025 10:00:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-8.us.a.mail.aliyun.com (out198-8.us.a.mail.aliyun.com [47.90.198.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CFA2566E2;
	Fri, 28 Feb 2025 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736858; cv=none; b=eVV2gTSHMb62I1YzjaOAEwKOtZA2OU/1NaVYbFBnDENua64L8wEREuWab4PVpweCEk/tURnemtxrEpfXXiqfBtpMPIHcHBigCknWhDlHOSduwN18lGIoeaUWbAzzV2RqjGZlz7Tozw1D5p3GFWAFX1ZSj0g6S7ijTXOHjuf3tf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736858; c=relaxed/simple;
	bh=fypNBqsI7gBTZM4RhcruoTMGebOUNPDKibTuPVUpOQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D66+vD1l8ifMyPoaPKc7P7cv7aKGE4DPQPwPdABRLe79kPuYvQXQBS/uhdVVfHVT9+CAkxDMCLkHYxrXCsjM7xcPwb8iJKpPBIl5iM+FKNKA/iCRyXYrromj4FbaxJPNanXKBm8TA3Mz3nWpsXgBgdYkazxtSuQ0nAUBrShfbhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.bfyn1Nf_1740736841 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 18:00:42 +0800
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
Subject: [PATCH net-next v3 14/14] motorcomm:yt6801: update ethernet documentation and maintainer
Date: Fri, 28 Feb 2025 18:00:20 +0800
Message-Id: <20250228100020.3944-15-Frank.Sae@motor-comm.com>
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
index 6fc196149..f8b88408d 100644
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
index 8019d5a97..9b1530020 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16012,6 +16012,14 @@ F:	drivers/most/
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


