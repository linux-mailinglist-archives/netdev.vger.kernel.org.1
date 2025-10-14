Return-Path: <netdev+bounces-229052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8474BBD78D7
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE66403164
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 06:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCFC19D07E;
	Tue, 14 Oct 2025 06:19:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4843F15B0EC
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760422765; cv=none; b=eBsT/ZTTkmb0XxzRdroD92rmUUDWvjOS6wD677dD0LNSWis5xUAaFqGFKpTw4vX1PDva+2UeZb17MMI1+dRaqiyJlvVQLPkeBiD4pI5KSSPFEA9j7SZhZMSqmzYbzY6GQ4QvZJEPVtn5hPv/lwsnM9wtir3zwTOJgd688WpaPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760422765; c=relaxed/simple;
	bh=Egggm009o9ydsBPYkkTMiLNXjMsxR3MW0UWUMx0t3fE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IEvy2OXGbd2sv6EDSTL8x5MuDEex4AhlFvGDJO3zbrqC0fDfpGIikD4jJHMo3AQZxBgUYo7vi6xI78DswYMemOccxYBAMAylOcva2F1kGhkf8kJuj3y8MvbIQjliJMPdQZKtM8+2GIGjezb9MqbMyFq7PDn3ByCUEiyWIISN9YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz16t1760422660tdeea5d8d
X-QQ-Originating-IP: UHyDY2fCvo0xvl4bWNEOk96lqyco3/Xh1grFXEsoKd8=
Received: from lap-jiawenwu.trustnetic.com ( [36.27.111.193])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 Oct 2025 14:17:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 575422392541965307
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 3/3] net: txgbe: rename txgbe_get_phy_link()
Date: Tue, 14 Oct 2025 14:17:26 +0800
Message-Id: <20251014061726.36660-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251014061726.36660-1-jiawenwu@trustnetic.com>
References: <20251014061726.36660-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MrTVJ9obs/HI5XA+DCOXmCIuNSOGWUIY3mCZmqluZp3NFuJwfxqRdrif
	Pey3PbOwPCm4bXFA9dXYehhb5CJlBowFo3kgUmhef/1VkpTegmshBOQTNPVPAZyCf74qClw
	kEP48EEPb9Attm/okcAMmRv+9mplVnG43NbI1gQ2XSUYI3SznxYYzurmYgvSkiEd0pGSguK
	M9o/cZqro6/CW8/pWGV6EbJIY5UhG7UF1IputORUrImyC5ryGcvdaCDqTolxha+wUx4OIfR
	1hsyG162KJL5BUFKavE+lahcFj3qu+2pck97eKQ5N+oKHvZ45WsHn+GLsy24jwT+9bKjRqK
	477lhW7pBLH+xsIOrrOEU96VcNwjy8CuHwuR4NQPaCb/wFlZFMemOAJbITf9p+Hf60eT9Ld
	glPEcUntZcXcExgPJwEvofbBcJJ8/BdIcLca3tgDQIcDb9Uhmj6QzjSIM8h5iajn9PfDAan
	NcekSeuCgCYkHus3Npmh+uE/nagCNt7pBT/iJwb0A9gj5nLceREqBYAhtVpz1/iOAbLm+Vr
	WlHVdd7wfeNM8fSQftJZN/2BK7on6XKt1eDuRaLh75ORNlpyccFrpb/9ogLwbhnTlQuKaZ4
	rlA/OlleeXKhzjFbq9EhkWYnIBuFDFcn8Vo9wLVkp+2i9beY3A2TiLEcOIk7fU0uv+8D9aa
	zIWBW5xb6mNNPnWFfi6hL9MpawryINzirdcuPEgWV+nEROE72jxMLRVSDrxyDFGuS3ubNFV
	mVuBFZvBIlX/l0ZZRcY9u40huvOA+0eeioUCyfiNxjNcEhkuf5jWrrGhGDlAQmOu989rBeZ
	hqmJiwl/LiNyn5lObzdpe8eYwnDk35QCZATVhIu1iQMN1qE/lFuK2sb026jJ49K72NLw7Yx
	8YbLjJcvqysJ0kQQjCpIfs0kRvVSz00bC09AH8cxmUxK/CyNrwGuHtzFzTq5ZOvYdRsukr8
	KAlo+9KeJmQHK6bU6bSOAy+EACZ5duaCMS5IPKMqQVDP6ysKHKIB/rB1tFnmZ+cmUg0Mgxn
	dGGFI4+2f80yHTH8+Wt5GBotRCEhNiWSk059DbVEV3+jSgHU3dXpbaVFwP0Bm7XZiC7mvbC
	xQWU5t0zzgz
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

The function txgbe_get_phy_link() is more appropriately named
txgbe_get_mac_link(), since it reads the link status from the MAC
register.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index 1da92431c324..35eebdb07761 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -118,7 +118,7 @@ static void txgbe_get_link_capabilities(struct wx *wx, int *speed, int *duplex)
 	*duplex = *speed == SPEED_UNKNOWN ? DUPLEX_HALF : DUPLEX_FULL;
 }
 
-static void txgbe_get_phy_link(struct wx *wx, int *speed)
+static void txgbe_get_mac_link(struct wx *wx, int *speed)
 {
 	u32 status;
 
@@ -234,7 +234,7 @@ static void txgbe_get_link_state(struct phylink_config *config,
 	struct wx *wx = phylink_to_wx(config);
 	int speed;
 
-	txgbe_get_phy_link(wx, &speed);
+	txgbe_get_mac_link(wx, &speed);
 	state->link = speed != SPEED_UNKNOWN;
 	state->speed = speed;
 	state->duplex = state->link ? DUPLEX_FULL : DUPLEX_UNKNOWN;
-- 
2.48.1


