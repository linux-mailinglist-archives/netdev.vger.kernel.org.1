Return-Path: <netdev+bounces-144846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B122F9C8939
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62969B30E38
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF081F8F0B;
	Thu, 14 Nov 2024 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="XQCBkYDO"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFA31F8F03;
	Thu, 14 Nov 2024 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582941; cv=none; b=iHptqjJqk5VAO6gbyAobAG3X10H8OfAu38NBVUETOodtx2e2uVaPxOAIR+ePXcnD1FBZqijG83/RxWZNC8fNCSGfzkhcDt+fmrZu2NWEoOmgAj3/lA/+MdoeXBPPlOvPeF3X1juHFgWu2sh3sNeUUJo60wV2Gh7GA6qE0l97T/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582941; c=relaxed/simple;
	bh=fyku/vJ50FoqSKdBGedLID31SZxrS+6VAFPp/5YrgOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWN6jSLn8AgSfaPrLOeZnxFYmaW2RWFiKKT0zlI20LXMt6Tvud3EDDbccf8+/iitoMF/C5cMAmqfcGnVRpkpgCq0vzR5Ew62nvUFv3vx8uI0ep38KG6czFRohvY1adgYpgo9c1PAelZK7acxN0aXZ9frCFN9akt/QqfkmlDbYNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=XQCBkYDO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AEBFOBQ02903561, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731582924; bh=fyku/vJ50FoqSKdBGedLID31SZxrS+6VAFPp/5YrgOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=XQCBkYDOhDUFmGaGHBZpmPyGtST0Ki5p4Gltk9xd2NAhpHUlprvZE7RB0fK+iYcfa
	 qVslflrKcbFyESisf12N65zWxFv+FZ/kDtNUgfikpHf0Y5AgK9MSW16GGaw+VCUkgp
	 FBCWo65tOFV3nmW8hItJvDNZfMjTuTpAib+Fe7y8BWfV3eLQ7du62cBN0XTGfk7ROV
	 s7rN8DW8yoq7npmOOxYpo/Yx4+AcHLUfGjLTbLP4SVqJeJmzR0c2zSkt0xLZUCNz4a
	 V+B8bY+oYFfm5jnIV7CcNFbro2QmCsXdcKS/B/NAkC3Dkfjaehu9HUzG0yAIO4tHpm
	 SKuSS+rXQirqw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AEBFOBQ02903561
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 19:15:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 19:15:24 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 14 Nov
 2024 19:15:24 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net 2/4] rtase: Correct the speed for RTL907XD-V1
Date: Thu, 14 Nov 2024 19:14:41 +0800
Message-ID: <20241114111443.375649-3-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114111443.375649-1-justinlai0215@realtek.com>
References: <20241114111443.375649-1-justinlai0215@realtek.com>
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

Correct the speed for RTL907XD-V1.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 33808afd588d..10697e4055b6 100644
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


