Return-Path: <netdev+bounces-145720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B2A9D0851
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 05:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391A5281C9E
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 04:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF5213C69E;
	Mon, 18 Nov 2024 04:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="tr0M0H1o"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064FE13C816;
	Mon, 18 Nov 2024 04:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731902958; cv=none; b=UBwzmOaAO67BlE2Ut4rwi9Ir9K+weCkhMuJzuSp8iB48YMdfiW756NJeYI01gFDisKW+v2wnA4uZ6v/wikSTlUAGzy9MyxDtTBLMBbl1n+LFHprt9tTjYRdcEdE4G68Kv65gpoBK6BQ5zCkcz0UHk2vaxvQPD8Y8rtliuRqNrHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731902958; c=relaxed/simple;
	bh=QfVWlreJZg/l0pgy+fenk87ylKvpPC5vFMVGj7hj1Pk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHGwWv9EOgxUPhnVfzlQ9KdK9tkNlCRA5JMzSz+v+jNVW422UhgdSbWedRO0qL6vh7NQ7UPSVIQ0nT9pdTKXMf43oM14qlz3o2UtlS9+5F0/4sKgyjZbW0NnIlaN/IMimIfKpFcrzC+IvsyzB+xO7+4bCFQx30fZ/QvazMEnptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=tr0M0H1o; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI490rY4108245, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731902940; bh=QfVWlreJZg/l0pgy+fenk87ylKvpPC5vFMVGj7hj1Pk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=tr0M0H1oAXupwZgiVVIEgnb6IAbrPa8jt9X1+GheCDpUBH++RDlZswAZj1WpIH/w4
	 qCVI82bLNbyVxAba7N9nPipkIADM+xA6UkPqQND8V570FsqWTFwcQYM/dCSTcTvJXx
	 EqOqgVJ8iXAujV33lhIoYqYayypWEgev5g/ehqVdEEMGCJ+gnG0FJEdzmAA7zbz/xS
	 OsR0looYb2OkGSUtNS/VzxNbpOY6Thr3IGVSLt5icPUfMICaexB2xXNk0qLp89eezF
	 VKPOwB0aLybwOXn/8lt5ZasBMXvMBtS9vHqKmQyjzu69fvwe01ccgJ+yvg7YSUWgMN
	 1vDJw3UIv4TLQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI490rY4108245
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 12:09:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 12:09:01 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Nov
 2024 12:09:00 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v3 1/4] rtase: Refactor the rtase_check_mac_version_valid() function
Date: Mon, 18 Nov 2024 12:08:25 +0800
Message-ID: <20241118040828.454861-2-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118040828.454861-1-justinlai0215@realtek.com>
References: <20241118040828.454861-1-justinlai0215@realtek.com>
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

1. Sets tp->hw_ver.
2. Changes the return type from bool to int.
3. Modify the error message for an invalid hardware version id.

Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase.h    |  2 ++
 .../net/ethernet/realtek/rtase/rtase_main.c   | 22 +++++++++++--------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index 583c33930f88..547c71937b01 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -327,6 +327,8 @@ struct rtase_private {
 	u16 int_nums;
 	u16 tx_int_mit;
 	u16 rx_int_mit;
+
+	u32 hw_ver;
 };
 
 #define RTASE_LSO_64K 64000
diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index f8777b7663d3..0c19c5645d53 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1972,20 +1972,21 @@ static void rtase_init_software_variable(struct pci_dev *pdev,
 	tp->dev->max_mtu = RTASE_MAX_JUMBO_SIZE;
 }
 
-static bool rtase_check_mac_version_valid(struct rtase_private *tp)
+static int rtase_check_mac_version_valid(struct rtase_private *tp)
 {
-	u32 hw_ver = rtase_r32(tp, RTASE_TX_CONFIG_0) & RTASE_HW_VER_MASK;
-	bool known_ver = false;
+	int ret = -ENODEV;
 
-	switch (hw_ver) {
+	tp->hw_ver = rtase_r32(tp, RTASE_TX_CONFIG_0) & RTASE_HW_VER_MASK;
+
+	switch (tp->hw_ver) {
 	case 0x00800000:
 	case 0x04000000:
 	case 0x04800000:
-		known_ver = true;
+		ret = 0;
 		break;
 	}
 
-	return known_ver;
+	return ret;
 }
 
 static int rtase_init_board(struct pci_dev *pdev, struct net_device **dev_out,
@@ -2105,9 +2106,12 @@ static int rtase_init_one(struct pci_dev *pdev,
 	tp->pdev = pdev;
 
 	/* identify chip attached to board */
-	if (!rtase_check_mac_version_valid(tp))
-		return dev_err_probe(&pdev->dev, -ENODEV,
-				     "unknown chip version, contact rtase maintainers (see MAINTAINERS file)\n");
+	ret = rtase_check_mac_version_valid(tp);
+	if (ret != 0) {
+		dev_err(&pdev->dev,
+			"unknown chip version: 0x%08x, contact rtase maintainers (see MAINTAINERS file)\n",
+			tp->hw_ver);
+	}
 
 	rtase_init_software_variable(pdev, tp);
 	rtase_init_hardware(tp);
-- 
2.34.1


