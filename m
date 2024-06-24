Return-Path: <netdev+bounces-106001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D419142DA
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 08:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BE78B2465A
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 06:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D232E636;
	Mon, 24 Jun 2024 06:35:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C975029CE3;
	Mon, 24 Jun 2024 06:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719210935; cv=none; b=s8X2T33nes0yZmCVaC6ya2mCLMutUESv+5FF9BTOEE3RmhmsnXc64+f8ug8TQQa+Sgud4xADDApGtg90Y3OswKET7/2Xi7JRlmN1pfZdISd9UJf2+DlWPlFkjlKBHTy+bG1u6fvMo2F8y7bIWy3F1aJNKvyHIZKlbEiAmlbz9ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719210935; c=relaxed/simple;
	bh=SlqGkIVRf6lyj7y8M/u+PC9E6k5Kr08HL6t3Mmf1fpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZECGwkgR9JBD1TkPaBn9es8kjApEGPnecWmAo4yYWx23Vyliit9R+1u7B8418jQIgi9G4ziueBAFtcN70yDSW5hP0jdn3zh1REnQC1mSCqeoVkqzUPuKOBGet64rPmRHdJagcvbwjgpwlWYkKkkIV5fVT61nMgYDfKMOYJOAv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45O6ZDe942853238, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45O6ZDe942853238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 14:35:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 14:35:13 +0800
Received: from RTDOMAIN (172.21.210.106) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 24 Jun
 2024 14:35:13 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net-next v21 11/13] rtase: Add a Makefile in the rtase folder
Date: Mon, 24 Jun 2024 14:28:19 +0800
Message-ID: <20240624062821.6840-12-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624062821.6840-1-justinlai0215@realtek.com>
References: <20240624062821.6840-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
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


