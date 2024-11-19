Return-Path: <netdev+bounces-146173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD409D22E4
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750841F2294F
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5639A1BC073;
	Tue, 19 Nov 2024 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZxgRsGXh"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8386A1993B4;
	Tue, 19 Nov 2024 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732010320; cv=none; b=cR5g+ugmZcDZURE5zCtFH/szKk/UzYbt258sC/pOLvQbUFC0ejayf6q7TREa9B+y+ZGJ+Yc1ogpNMegHiHszcC8ElLxH/LLwLpblyVMKbSGlSHZ7j4jDRnSpdlRWbntz7+NZVvUNQQKeu9KBShW1p2kH4SIBDEguIc7xj83pyAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732010320; c=relaxed/simple;
	bh=h5HN7yMTNYeaiDPiA+x/V/XfsemP7gQrSc9C0y40TBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdYXSz8CpHu+8KfWbEkRRYy4grd4I/SvKtPDzLm36ySox9rRsl1qWrXgaTtvX2lGxOf3nvKaeIjfU006jofZmHUHzA5jOf/dddBUlioMYuay5S6K0o3IMEG2ApX0O5PaUtbhMe8EloAxY6RCmNFMTTa85N3C3gv0T1JBMo7ZaLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZxgRsGXh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AJ9wJ7412265682, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732010300; bh=h5HN7yMTNYeaiDPiA+x/V/XfsemP7gQrSc9C0y40TBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ZxgRsGXhEdivw+mCVAx7r7CXY2m/hCT8TvKHikP2FU0YuHfRUkMM7rwR0EGHxNfZx
	 32tLeQUjSwL7koeqUaZLS4heROQECjdNvRezoMgIGhOdZyjY1fQ71nKWgSAJQlO3W2
	 SI3E6l/8mMS5wTPB+Prl6OnCsI/EmoiNlVuqOwlZAZ8gNWJ0m4ETRMJvf/ae+E8v2y
	 6ujoQfa7WzymaoezwSIG2qsum29BfPG++5q4dbihF0nRgSWe9cP3a1pctJnJoz0qmx
	 RFDBhHOGRRBFXRVTSbvReND7J2dZjMTqBoZD2fivvxiz/SbVpLM4qOtwayJdU/9qku
	 C2fnGle9vbIHA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AJ9wJ7412265682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 17:58:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 17:58:20 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 19 Nov
 2024 17:58:19 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v4 2/4] rtase: Correct the speed for RTL907XD-V1
Date: Tue, 19 Nov 2024 17:57:04 +0800
Message-ID: <20241119095706.480752-3-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119095706.480752-1-justinlai0215@realtek.com>
References: <20241119095706.480752-1-justinlai0215@realtek.com>
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

Previously, the reported speed was uniformly set to SPEED_5000, but the
RTL907XD-V1 actually operates at a speed of SPEED_10000. Therefore, this
patch makes the necessary correction.

Fixes: dd7f17c40fd1 ("rtase: Implement ethtool function")
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 0c19c5645d53..5b8012987ea6 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1714,10 +1714,21 @@ static int rtase_get_settings(struct net_device *dev,
 			      struct ethtool_link_ksettings *cmd)
 {
 	u32 supported = SUPPORTED_MII | SUPPORTED_Pause | SUPPORTED_Asym_Pause;
+	const struct rtase_private *tp = netdev_priv(dev);
 
 	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
 						supported);
-	cmd->base.speed = SPEED_5000;
+
+	switch (tp->hw_ver) {
+	case 0x00800000:
+	case 0x04000000:
+		cmd->base.speed = SPEED_5000;
+		break;
+	case 0x04800000:
+		cmd->base.speed = SPEED_10000;
+		break;
+	}
+
 	cmd->base.duplex = DUPLEX_FULL;
 	cmd->base.port = PORT_MII;
 	cmd->base.autoneg = AUTONEG_DISABLE;
-- 
2.34.1


