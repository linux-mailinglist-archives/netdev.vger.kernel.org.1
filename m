Return-Path: <netdev+bounces-295781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WWwvBPWoImqwbgEAu9opvQ
	(envelope-from <netdev+bounces-295781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 12:46:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB6D647798
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 12:46:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=GPpHfnC6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295781-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295781-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9284304FF7C
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 10:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A044C77D5;
	Fri,  5 Jun 2026 10:39:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC994183DC;
	Fri,  5 Jun 2026 10:39:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655974; cv=none; b=ox9gcxMok1PsoBJ3xr+dZ9yUaVHKOt2w9JArDc2EY7ZVuUcyqjdX5GHzgyRmtbcisMs0+SHe2gELpRQ/UQoAz/4K4/8JvOuuTG01ExrX33+m0ydA6IT39lh9gN10i5VHK5Be+uHaJXERtpc9A+xZ9Q96tgvgiAS3hrJIwXPd+OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655974; c=relaxed/simple;
	bh=1cf4mADOiYjVbPeIRgrpL3g1bIqVe9rVpdHI1zQDxqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u16hKPt3GH8s0Yyt4pAG3sQC+lqXvY/RGjy5VNWk93uhY2xsVXiuLsDGS0uxU/kPJELfZ4Y/HVLsCWdcA+o4GLnOmx6bz6VhBTjAqW3q0iAq2J6JyDao6aNLam4Mc9+cqfvg9IQVn+5wcUtHosJKsgrzJxHTAtpHYN3XyKfJmvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=GPpHfnC6; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 655Ad9eD51324199, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780655949;
	bh=Zz3g53fFuDbUxwgVzVuE4GNkjDo8TPW8WXYbaROB4QQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=GPpHfnC6bnMyrKIFroGSl6eyJ9bF/qVFCiiB+GH8iWOA/yfW00OHC/+wFFjC1DL4b
	 GOclIXjQ9FrEovUZD18YRugQG+1/C0DVDzbr2134pB9AxpjZcmWWKqJKWTQv/6efXn
	 K7ILiapc/sTqQU7SGrtSfwz09xUdjMd/wyz64dgtm/gpF70c7MKLvQpZEQThq4dqAW
	 GyonfAfQ39Bljggvwxvh9jfZ614LKRk7AXKQByININU8vptJtfNkcvfh9pho2pmV1M
	 bZfCud8XZmyvM60sXd2VRPxh5Qtu0w0YHJEpEHLnIVZw2HKGlH5itlj9X/8Vm1Y4MZ
	 t7dJJ83XdkEGQ==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 655Ad9eD51324199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jun 2026 18:39:09 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Jun 2026 18:39:09 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 5 Jun 2026 18:39:09 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 3/6] r8169: decoupling tp->phydev
Date: Fri, 5 Jun 2026 18:39:02 +0800
Message-ID: <20260605103906.1445-4-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260605103906.1445-1-javen_xu@realsil.com.cn>
References: <20260605103906.1445-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295781-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:mid,realsil.com.cn:dkim,realsil.com.cn:from_mime,realsil.com.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBB6D647798

From: Javen Xu <javen_xu@realsil.com.cn>

Some functions in ethtool are bound to tp->phydev. But in phylink, we
should replace it with functions which are bound to to->phylink.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 36 ++++++++++++++---------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 97bcd36efdbb..c46117e3a643 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2256,7 +2256,7 @@ static int rtl8169_get_eee(struct net_device *dev, struct ethtool_keee *data)
 	if (!rtl_supports_eee(tp))
 		return -EOPNOTSUPP;
 
-	ret = phy_ethtool_get_eee(tp->phydev, data);
+	ret = phylink_ethtool_get_eee(tp->phylink, data);
 	if (ret)
 		return ret;
 
@@ -2272,7 +2272,7 @@ static int rtl8169_set_eee(struct net_device *dev, struct ethtool_keee *data)
 	if (!rtl_supports_eee(tp))
 		return -EOPNOTSUPP;
 
-	return phy_ethtool_set_eee(tp->phydev, data);
+	return phylink_ethtool_set_eee(tp->phylink, data);
 }
 
 static void rtl8169_get_ringparam(struct net_device *dev,
@@ -2303,13 +2303,8 @@ static void rtl8169_get_pauseparam(struct net_device *dev,
 				   struct ethtool_pauseparam *data)
 {
 	struct rtl8169_private *tp = netdev_priv(dev);
-	bool tx_pause, rx_pause;
 
-	phy_get_pause(tp->phydev, &tx_pause, &rx_pause);
-
-	data->autoneg = tp->phydev->autoneg;
-	data->tx_pause = tx_pause ? 1 : 0;
-	data->rx_pause = rx_pause ? 1 : 0;
+	phylink_ethtool_get_pauseparam(tp->phylink, data);
 }
 
 static int rtl8169_set_pauseparam(struct net_device *dev,
@@ -2320,9 +2315,7 @@ static int rtl8169_set_pauseparam(struct net_device *dev,
 	if (dev->mtu > ETH_DATA_LEN)
 		return -EOPNOTSUPP;
 
-	phy_set_asym_pause(tp->phydev, data->rx_pause, data->tx_pause);
-
-	return 0;
+	return phylink_ethtool_set_pauseparam(tp->phylink, data);
 }
 
 static void rtl8169_get_eth_mac_stats(struct net_device *dev,
@@ -2388,6 +2381,14 @@ static void rtl8169_get_eth_ctrl_stats(struct net_device *dev,
 		le32_to_cpu(tp->counters->rx_unknown_opcode);
 }
 
+static int rtl8169_get_link_ksettings(struct net_device *ndev,
+				      struct ethtool_link_ksettings *cmd)
+{
+	struct rtl8169_private *tp = netdev_priv(ndev);
+
+	return phylink_ethtool_ksettings_get(tp->phylink, cmd);
+}
+
 static int rtl8169_set_link_ksettings(struct net_device *ndev,
 				      const struct ethtool_link_ksettings *cmd)
 {
@@ -2397,7 +2398,7 @@ static int rtl8169_set_link_ksettings(struct net_device *ndev,
 	int speed = cmd->base.speed;
 
 	if (!tp->sfp_mode)
-		return phy_ethtool_ksettings_set(phydev, cmd);
+		return phylink_ethtool_ksettings_set(tp->phylink, cmd);
 
 	if (cmd->base.autoneg != AUTONEG_DISABLE)
 		return -EINVAL;
@@ -2418,6 +2419,13 @@ static int rtl8169_set_link_ksettings(struct net_device *ndev,
 	return 0;
 }
 
+static int rtl8169_nway_reset(struct net_device *dev)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	return phylink_ethtool_nway_reset(tp->phylink);
+}
+
 static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
@@ -2433,10 +2441,10 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.get_sset_count		= rtl8169_get_sset_count,
 	.get_ethtool_stats	= rtl8169_get_ethtool_stats,
 	.get_ts_info		= ethtool_op_get_ts_info,
-	.nway_reset		= phy_ethtool_nway_reset,
+	.nway_reset		= rtl8169_nway_reset,
 	.get_eee		= rtl8169_get_eee,
 	.set_eee		= rtl8169_set_eee,
-	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
+	.get_link_ksettings	= rtl8169_get_link_ksettings,
 	.set_link_ksettings	= rtl8169_set_link_ksettings,
 	.get_ringparam		= rtl8169_get_ringparam,
 	.get_pause_stats	= rtl8169_get_pause_stats,
-- 
2.43.0


