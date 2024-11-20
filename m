Return-Path: <netdev+bounces-146420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5269D34EA
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 08:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5FC1F21ADE
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 07:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C42F15E5BB;
	Wed, 20 Nov 2024 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Rj5AtPnL"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1744015443D;
	Wed, 20 Nov 2024 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089487; cv=none; b=o+vf7K/zQXy7ns+SZjrORI4zKJJUXLyDtlgnYXqE83y/vgKvBWorHN08kVAU/l849ifmyhY3Ks2UbrOVILQCKwzOGJrT5nXe1nADHURwhQ0beBWdrVNCyKbuvPSE/FnIeLh9tE79kTBkZOusXwubMPv319NSkKaVGvIdXttOWzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089487; c=relaxed/simple;
	bh=mm7FzS9gPhW5aWv9K33rVKxnf7HrcfiG+2JMikIm6JQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SK9+oh4MYkf8noveErEUFjptxjK7tZmR8n3yBu0NIzUdS8NAXgHTdqU8KNlSpCPbkzeJ/fsaMdE62umBfB0sevUCeC8zkbAvVbjGgU3sVAYHRMQNUfcHPfVSo9hwuT0UB7AECJWg6vAXCRDuLWfr7ZKJG5zPai6IKYl7/F10gN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Rj5AtPnL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AK7vZKU13745829, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732089455; bh=mm7FzS9gPhW5aWv9K33rVKxnf7HrcfiG+2JMikIm6JQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Rj5AtPnLMcQ/Fusd9PewL4lgue2Ip8entqQVkkBpL8EGbLyZqqCF0s2YdW9muGEbU
	 m5ZpECM8rxWG2eChB39PoSANk2uY2YaDczHxV3QhJJgjVw7m3PblXDALSAoQoabLDx
	 q1jdjd8vzjWQ09SzPOm0zSuPkZqSgjqmF8xP+C6/PKSRR8mHNAp0CPnUtauPNrCB3b
	 JVOKHvYsPbZXgQ+tRqEmsEEOvJVtKXkBR3fb6WxNFb/sRAlsY316zQa7VPQJYrKQMz
	 txoYkVyRe3Ynxk1S8XJe6VUOQxEFiQ6j8Dt2gBiQHgcrFOEbnWRHndcDzP2krvRJLV
	 sewWlcqki4zuQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AK7vZKU13745829
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 15:57:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 15:57:35 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 20 Nov
 2024 15:57:35 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>,
        <michal.kubiak@intel.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net v5 2/3] rtase: Correct the speed for RTL907XD-V1
Date: Wed, 20 Nov 2024 15:56:23 +0800
Message-ID: <20241120075624.499464-3-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120075624.499464-1-justinlai0215@realtek.com>
References: <20241120075624.499464-1-justinlai0215@realtek.com>
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
index c2999e24904d..7b433b290a97 100644
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
+	case RTASE_HW_VER_906X_7XA:
+	case RTASE_HW_VER_906X_7XC:
+		cmd->base.speed = SPEED_5000;
+		break;
+	case RTASE_HW_VER_907XD_V1:
+		cmd->base.speed = SPEED_10000;
+		break;
+	}
+
 	cmd->base.duplex = DUPLEX_FULL;
 	cmd->base.port = PORT_MII;
 	cmd->base.autoneg = AUTONEG_DISABLE;
-- 
2.34.1


