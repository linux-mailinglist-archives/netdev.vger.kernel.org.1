Return-Path: <netdev+bounces-117592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5153694E6EA
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 08:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D8DBB226E1
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 06:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE40A1547D7;
	Mon, 12 Aug 2024 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="mwMNybSn"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADAE433B3;
	Mon, 12 Aug 2024 06:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444886; cv=none; b=OcZDvhHXNAT7dNqO02vqvgg5BrzVULmB3c0oDPKsPmk8lIxa0O6koYdKR9tROu1g5g2QmhgEzMaXvKxUUCJatGE41aIj23+T5bCcUI+W4T6uNxjooKMsR4ZC/jDIaqblvPh0phtpzeJolkh5CQxRO08GtvjnigcqLRezlwkHVLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444886; c=relaxed/simple;
	bh=lDNM23p/svXDNpYBwpED69iozWNwezzkhGqHBJ2QshQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+cEkDHFS1lo9rxa5udyXE60MwO81ZfWU2zfx7aHd5zur1RTj06Eqzh0zyKEz2ZhYXTl0K/ux6AIpSbP/SFbDRt4unR6/SF6JcwO/pyC2/sgMqnczuqlPcJXeOEnApHIhBRzTRF/9hlzYWBJcJxwghEl7+QLarXvEedDQ5RG/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=mwMNybSn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47C6f1l753758609, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723444861; bh=lDNM23p/svXDNpYBwpED69iozWNwezzkhGqHBJ2QshQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=mwMNybSn+lzEZTTSW9+B9zUzGPYJucBNuYodjF9/MXI30+qt0kKV0baX3/ORnL2Bl
	 YWgoELDIir2dmkMz9GKhB96Pd+IEpl6QJwlZI7D1icges3xj2LKbl6XN6PeT8al+B/
	 Tt5JMxQF7rMsppbGr6WAjIu//Z7PDHYBK3sqQe8aFPMwtbtle6KOlWBgE3LSTorYne
	 72FTGAp3mX4IteooPpAwJzMysYj0oczSgyy71dSLSBQ0sGAJb3bVOk2xRtNGdyeFXk
	 w2fSUXQy5UtR6IyuHFgBvrZth+ckwOeKhXj0X/yGhFYSfwx+jlRcnDlFHYpbnL+jhO
	 COef18yxf+XWA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47C6f1l753758609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 14:41:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 14:41:02 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 12 Aug
 2024 14:41:01 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v27 10/13] rtase: Implement ethtool function
Date: Mon, 12 Aug 2024 14:35:36 +0800
Message-ID: <20240812063539.575865-11-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812063539.575865-1-justinlai0215@realtek.com>
References: <20240812063539.575865-1-justinlai0215@realtek.com>
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

Implement the ethtool function to support users to obtain network card
information, including obtaining various device settings, Report whether
physical link is up, Report pause parameters, Set pause parameters,
Return extended statistics about the device.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index bd2a05c96b1c..9a07252c3663 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1717,9 +1717,101 @@ static void rtase_get_mac_address(struct net_device *dev)
 	rtase_rar_set(tp, dev->dev_addr);
 }
 
+static void rtase_get_drvinfo(struct net_device *dev,
+			      struct ethtool_drvinfo *info)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+
+	strscpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
+	strscpy(info->bus_info, pci_name(tp->pdev), sizeof(info->bus_info));
+}
+
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
+
+	if ((value & (RTASE_FORCE_TXFLOW_EN | RTASE_FORCE_RXFLOW_EN)) ==
+	    (RTASE_FORCE_TXFLOW_EN | RTASE_FORCE_RXFLOW_EN)) {
+		pause->rx_pause = 1;
+		pause->tx_pause = 1;
+	} else if (value & RTASE_FORCE_TXFLOW_EN) {
+		pause->tx_pause = 1;
+	} else if (value & RTASE_FORCE_RXFLOW_EN) {
+		pause->rx_pause = 1;
+	}
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
+	.get_drvinfo = rtase_get_drvinfo,
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


