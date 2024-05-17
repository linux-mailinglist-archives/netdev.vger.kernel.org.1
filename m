Return-Path: <netdev+bounces-96899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 589EA8C81F6
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 10:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10DBA1F22060
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 08:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CD81A28D;
	Fri, 17 May 2024 07:59:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43438182D2;
	Fri, 17 May 2024 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932753; cv=none; b=APPGSNrqc9ASek3zMQAc4+Xsv8dmRpd/0l6fnt3YJGShZ/l51VgS6hcKBEazfiR9+sOgBCUbyAwAD3Uyf7yHz6fDjQHQ+fj77OooUtjUsb1jb0AXCub7jl9S7bm2rVzK9YK4jvEi62SqNB4LNmKFjpsgAsr/PVa56fbFrR5D0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932753; c=relaxed/simple;
	bh=SlqGkIVRf6lyj7y8M/u+PC9E6k5Kr08HL6t3Mmf1fpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UAJIqv3Wwc6RIq82FSg2xcr2By+yW18jgDPKLAMWvoqgYnSxPC8dWfc8kbmdcrPXRXy65XBGFFaaYzOpCWl+hecMlOjD68veI8aWlH9oIt7BU8ObDj14dw24y94WEJ1U5VUvX0PV/0oZ9knz5VX9EpMmr6FDoWY1uU/Ddl0zN5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44H7wonQ72161464, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44H7wonQ72161464
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 15:58:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 17 May 2024 15:58:49 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 17 May
 2024 15:58:49 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net-next v19 11/13] rtase: Add a Makefile in the rtase folder
Date: Fri, 17 May 2024 15:53:00 +0800
Message-ID: <20240517075302.7653-12-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517075302.7653-1-justinlai0215@realtek.com>
References: <20240517075302.7653-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Add a Makefile in the rtase folder to build rtase driver.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 drivers/net/ethernet/realtek/rtase/Makefile

diff --git a/drivers/net/ethernet/realtek/rtase/Makefile b/drivers/net/ethernet/realtek/rtase/Makefile
new file mode 100644
index 000000000000..ba3d8550f9e6
--- /dev/null
+++ b/drivers/net/ethernet/realtek/rtase/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+# Copyright(c) 2024 Realtek Semiconductor Corp. All rights reserved.
+
+#
+# Makefile for the Realtek PCIe driver
+#
+
+obj-$(CONFIG_RTASE) += rtase.o
+
+rtase-objs := rtase_main.o
-- 
2.34.1


