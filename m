Return-Path: <netdev+bounces-120890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 656F495B220
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7B61F252BF
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 09:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A783E185934;
	Thu, 22 Aug 2024 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZJ+SJSZN"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E988817BB14;
	Thu, 22 Aug 2024 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319742; cv=none; b=Vf8UeVfkP8ApDc271BRontj1Ayo01DS+T6sZGbihVb8dd1tFsVP53W9FwMVj2NCZkV0+soZDx4L96XEKXM0L1EOnViKSJmpldf/WCjtZqIt+JFj6TYITRrEtXM0nb2u3O6rgMjC8rgaz97jQUie7AVyhSBtr+u2UnZIT1lv0u70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319742; c=relaxed/simple;
	bh=EPwE7IJF5YBd5AFN9Y+2cjl3yY1krMVKlQ2hkIl5+1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLAHCYy/qd0TmsWuwEWtWIqGHDk6qFj2HAWafWhgKThgQEfzmuLzfuSccHXXDEqwppXq4S+t2AVA50ygyzl1gqiv8mbT9PgmpHjJgh8a/1pTa5hvJZGIdESn7D4P61KKNlS9NMj4ZY56KA/bI2jg/DbitQpJEYEfHoSrg9NeAlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZJ+SJSZN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47M9ffnqF3805136, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724319701; bh=EPwE7IJF5YBd5AFN9Y+2cjl3yY1krMVKlQ2hkIl5+1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ZJ+SJSZNmaeQ98iyzjxIfzEzcnMEcJ9ZkaDywGinCDHJIuNxmSCbZom1ssWbCMCHL
	 3Zuv9Eye0bvqnnNVDY33+zAWfj5YZsMivz5FCTpkCauLyICQa9UxcfgbBpQv3pUf5l
	 +JgPYpfG0p8vxm4v+nNkcDbQGN9cypxrn8XUOwfNR9sRwG1Wu54/KkU/m+0sqnWTBv
	 Z9OYOGu7165vijnaPyj7vt0rKZyN1XwKRTvVEeKv9VaKRMczuTf2ULfcHTIACI3LBd
	 BNWkrU+JnnbH8Ot9K5GdTutova3+I0JcM1q7r1gZh2vuSw/lxsxjQlCJ+Ie22tWiEt
	 7OPco7qS/oaJg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47M9ffnqF3805136
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 17:41:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 17:41:42 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 22 Aug
 2024 17:41:41 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v28 10/13] rtase: Implement ethtool function
Date: Thu, 22 Aug 2024 17:37:51 +0800
Message-ID: <20240822093754.17117-11-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822093754.17117-1-justinlai0215@realtek.com>
References: <20240822093754.17117-1-justinlai0215@realtek.com>
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

Implement the ethtool function to support users to obtain network card
information, including obtaining various device settings, Report whether
physical link is up, Report pause parameters, Set pause parameters,
Return extended statistics about the device.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 86aee36006a1..b1574fe67d10 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1712,9 +1712,83 @@ static void rtase_get_mac_address(struct net_device *dev)
 	rtase_rar_set(tp, dev->dev_addr);
 }
 
+static int rtase_get_settings(struct net_device *dev,
+			      struct ethtool_link_ksettings *cmd)
+{
+	u32 supported = SUPPORTED_MII | SUPPORTED_Pause | SUPPORTED_Asym_Pause;
+
+	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
+						supported);
+	cmd->base.speed = SPEED_5000;
+	cmd->base.duplex = DUPLEX_FULL;
+	cmd->base.port = PORT_MII;
+	cmd->base.autoneg = AUTONEG_DISABLE;
+
+	return 0;
+}
+
+static void rtase_get_pauseparam(struct net_device *dev,
+				 struct ethtool_pauseparam *pause)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u16 value = rtase_r16(tp, RTASE_CPLUS_CMD);
+
+	pause->autoneg = AUTONEG_DISABLE;
+	pause->tx_pause = !!(value & RTASE_FORCE_TXFLOW_EN);
+	pause->rx_pause = !!(value & RTASE_FORCE_RXFLOW_EN);
+}
+
+static int rtase_set_pauseparam(struct net_device *dev,
+				struct ethtool_pauseparam *pause)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u16 value = rtase_r16(tp, RTASE_CPLUS_CMD);
+
+	if (pause->autoneg)
+		return -EOPNOTSUPP;
+
+	value &= ~(RTASE_FORCE_TXFLOW_EN | RTASE_FORCE_RXFLOW_EN);
+
+	if (pause->tx_pause)
+		value |= RTASE_FORCE_TXFLOW_EN;
+
+	if (pause->rx_pause)
+		value |= RTASE_FORCE_RXFLOW_EN;
+
+	rtase_w16(tp, RTASE_CPLUS_CMD, value);
+	return 0;
+}
+
+static void rtase_get_eth_mac_stats(struct net_device *dev,
+				    struct ethtool_eth_mac_stats *stats)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	const struct rtase_counters *counters;
+
+	counters = tp->tally_vaddr;
+
+	rtase_dump_tally_counter(tp);
+
+	stats->FramesTransmittedOK = le64_to_cpu(counters->tx_packets);
+	stats->FramesReceivedOK = le64_to_cpu(counters->rx_packets);
+	stats->FramesLostDueToIntMACXmitError =
+		le64_to_cpu(counters->tx_errors);
+	stats->BroadcastFramesReceivedOK = le64_to_cpu(counters->rx_broadcast);
+}
+
+static const struct ethtool_ops rtase_ethtool_ops = {
+	.get_link = ethtool_op_get_link,
+	.get_link_ksettings = rtase_get_settings,
+	.get_pauseparam = rtase_get_pauseparam,
+	.set_pauseparam = rtase_set_pauseparam,
+	.get_eth_mac_stats = rtase_get_eth_mac_stats,
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static void rtase_init_netdev_ops(struct net_device *dev)
 {
 	dev->netdev_ops = &rtase_netdev_ops;
+	dev->ethtool_ops = &rtase_ethtool_ops;
 }
 
 static void rtase_reset_interrupt(struct pci_dev *pdev,
-- 
2.34.1


