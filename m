Return-Path: <netdev+bounces-145221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EFB9CDBEF
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 10:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A819D2838AB
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A44D192B94;
	Fri, 15 Nov 2024 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="IkVlDDof"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58178192D8B;
	Fri, 15 Nov 2024 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664537; cv=none; b=Aa9txyvjhpIAD+V94ljPRsyHXuVx7hMxwmw5Rymvq4htbaIbEsfS7vfMJQMwS6Ms5AtEYWy5q8awi2Fjv0G6b6vsz2mhMnEwCFuhbiHCbFrMSJQ+vJuzLpbCQvYkx+q12msJ20wZIy7f1dju2Tf4ipemsEXgV7tSi7W/sVz/vnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664537; c=relaxed/simple;
	bh=CykH9i7P9pZRTLcdwSphEWfFe4k6k8acMq71zcZ+/tU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nk1UEJXGdrAuWiIn47SQBRllqy0KWG7IOMIytiEbMhtjH32FAV0xoQUGIP+EPfAOo7YjIvxS8/ggPTnEH6BIhB8Lf6lC6SfoQZOUutYr+eksaGIpXBpAnRMIndBYwS6rKa9riT6uCfVqc2M3jtpWQVVFVuOoJiXe12UCGmP+vFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=IkVlDDof; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AF9tJvG5289966, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731664519; bh=CykH9i7P9pZRTLcdwSphEWfFe4k6k8acMq71zcZ+/tU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=IkVlDDoftYCBUcMDB7akrpHpEsxUqIHc621jkZK00djxkwwlsfwdox9qFtjD2nxE2
	 6vMlADkbGleo6RYZ7TjJ68w8+HAVNaGRLKUT8OtBl0kFs3ndeEYysdX/L0c0x9L/tu
	 gdnCTtsLwr+9FNrFzyLSZm2oOUbCLMbv4LZz4ANdUwl0Q3n2rttbA6DJgbuKMCqQdh
	 JUlsxMxNhtdHNz3UdRlnajvJP65hWS9XELr+RQQig1rNas1yThk2N6Xb049/CzSCEj
	 armsAFbZUjpkq7aPNQkmQ+Gt2Tt/6Ai9kEYi5kEJSuFEwVnilsuZqYltq/c2OVUBO5
	 XBaYS6uJNG8FQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AF9tJvG5289966
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 17:55:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 17:55:17 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 15 Nov
 2024 17:55:16 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v2 2/5] rtase: Correct the speed for RTL907XD-V1
Date: Fri, 15 Nov 2024 17:54:26 +0800
Message-ID: <20241115095429.399029-3-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115095429.399029-1-justinlai0215@realtek.com>
References: <20241115095429.399029-1-justinlai0215@realtek.com>
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


