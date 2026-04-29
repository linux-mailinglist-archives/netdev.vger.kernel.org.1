Return-Path: <netdev+bounces-282253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMNSJZuu8WmwjgEAu9opvQ
	(envelope-from <netdev+bounces-282253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:09:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 185844903CC
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EAB4302AD1D
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 07:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C253C3A3E63;
	Wed, 29 Apr 2026 07:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="dWESrV2G"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3586C3A3807;
	Wed, 29 Apr 2026 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446503; cv=none; b=RL8zX663S2Eq+M//iG4u+uO97t9wqy7cRT0+e4WiE5JrnpF+YnQPotFLbMtQmcWMSGOLe/IosoSe+ErP/dQOTtZwkxokZ53BbzBReCSn762Bhansb4DY4e47kdPuQYfEwnwbkiKJgddWrtVRRTCDfTwzAu4mHIJAojl/dZ6sM1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446503; c=relaxed/simple;
	bh=i1F2HJMXsOOmW3UU7uBAekl52eaXtcLHpKsxW2KCO+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBzrFK+qhmcOewTTFtp8VICJ2mwocsGXwLRUJosjRl7Nse9NH2H4rIKCjdDs5Y9AEWRO9E0MXXHNAElde314AuVl1yn2IYuYDcE1ALJXqiuWQm3afqSv9RFZ4AXB1gb1BoOfqeoV2PFLqQPowt3ofqm6jo2XcbHdqTEqNBuP6Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=dWESrV2G; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63T77svcE1069969, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1777446474;
	bh=HrWA/siejn1QMpQmplbJs9oeeT+jaFwFW7urPCWx+u0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=dWESrV2GQBlh1HCJ4SFhLKjOHDIWF+3b1ofym99uCNjJT715IhfBniFq9YnRa/YUt
	 ydqKyGumaSHw5n71UoiEHz1e1bxcF4qeh6g79kqy0Fo2YV9U4zj4WpCYZSINCjpmTv
	 PvhRqbjvkBo/sNS7zQMDXy5J696Ze4NTaHp1SL4tepC0WJV3Qf40oskOy0a+neyQe5
	 88TkJbd5Eg/0AoWXeRLO9Qe7iXNqtsArcJnaoSf+zlI416CY8YUOXTbXZvFD/ItrLb
	 YlkDNY0XHRTaypRvG9TeXfK2t/m9AkTiyinj7L1sye37WpCSDgWDU75gnEeqOijw48
	 WHlTcuqCBVB3A==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63T77svcE1069969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 Apr 2026 15:07:54 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Apr 2026 15:07:54 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 29 Apr 2026 15:07:54 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [RFC Patch net-next v2 7/8] r8169: move struct ethtool_ops
Date: Wed, 29 Apr 2026 15:07:49 +0800
Message-ID: <20260429070750.1477-8-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260429070750.1477-1-javen_xu@realsil.com.cn>
References: <20260429070750.1477-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Rspamd-Queue-Id: 185844903CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-282253-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,realsil.com.cn:dkim,realsil.com.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Javen Xu <javen_xu@realsil.com.cn>

The next patch will add support for changing rx queues by ethtool, which=0D
introduces new functions rtl8169_get_channels and rtl8169_set_channels.=0D
Moving the ethtool_ops structure down ensures that we can register these=0D
new functions in the ops structure without needing to add forward=0D
declarations for them.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
changes in v2:
 - modify commit message.
---
 drivers/net/ethernet/realtek/r8169_main.c | 56 +++++++++++------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethern=
et/realtek/r8169_main.c
index 238386d29b2c..ea91cedc3100 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2557,34 +2557,6 @@ static int rtl8169_set_link_ksettings(struct net_dev=
ice *ndev,
 	return 0;
 }
=20
-static const struct ethtool_ops rtl8169_ethtool_ops =3D {
-	.supported_coalesce_params =3D ETHTOOL_COALESCE_USECS |
-				     ETHTOOL_COALESCE_MAX_FRAMES,
-	.get_drvinfo		=3D rtl8169_get_drvinfo,
-	.get_regs_len		=3D rtl8169_get_regs_len,
-	.get_link		=3D ethtool_op_get_link,
-	.get_coalesce		=3D rtl_get_coalesce,
-	.set_coalesce		=3D rtl_set_coalesce,
-	.get_regs		=3D rtl8169_get_regs,
-	.get_wol		=3D rtl8169_get_wol,
-	.set_wol		=3D rtl8169_set_wol,
-	.get_strings		=3D rtl8169_get_strings,
-	.get_sset_count		=3D rtl8169_get_sset_count,
-	.get_ethtool_stats	=3D rtl8169_get_ethtool_stats,
-	.get_ts_info		=3D ethtool_op_get_ts_info,
-	.nway_reset		=3D phy_ethtool_nway_reset,
-	.get_eee		=3D rtl8169_get_eee,
-	.set_eee		=3D rtl8169_set_eee,
-	.get_link_ksettings	=3D phy_ethtool_get_link_ksettings,
-	.set_link_ksettings	=3D rtl8169_set_link_ksettings,
-	.get_ringparam		=3D rtl8169_get_ringparam,
-	.get_pause_stats	=3D rtl8169_get_pause_stats,
-	.get_pauseparam		=3D rtl8169_get_pauseparam,
-	.set_pauseparam		=3D rtl8169_set_pauseparam,
-	.get_eth_mac_stats	=3D rtl8169_get_eth_mac_stats,
-	.get_eth_ctrl_stats	=3D rtl8169_get_eth_ctrl_stats,
-};
-
 static const struct rtl_chip_info *rtl8169_get_chip_version(u32 xid, bool =
gmii)
 {
 	/* Chips combining a 1Gbps MAC with a 100Mbps PHY */
@@ -6403,6 +6375,34 @@ static void r8169_init_napi(struct rtl8169_private *=
tp)
 	}
 }
=20
+static const struct ethtool_ops rtl8169_ethtool_ops =3D {
+	.supported_coalesce_params =3D ETHTOOL_COALESCE_USECS |
+				     ETHTOOL_COALESCE_MAX_FRAMES,
+	.get_drvinfo		=3D rtl8169_get_drvinfo,
+	.get_regs_len		=3D rtl8169_get_regs_len,
+	.get_link		=3D ethtool_op_get_link,
+	.get_coalesce		=3D rtl_get_coalesce,
+	.set_coalesce		=3D rtl_set_coalesce,
+	.get_regs		=3D rtl8169_get_regs,
+	.get_wol		=3D rtl8169_get_wol,
+	.set_wol		=3D rtl8169_set_wol,
+	.get_strings		=3D rtl8169_get_strings,
+	.get_sset_count		=3D rtl8169_get_sset_count,
+	.get_ethtool_stats	=3D rtl8169_get_ethtool_stats,
+	.get_ts_info		=3D ethtool_op_get_ts_info,
+	.nway_reset		=3D phy_ethtool_nway_reset,
+	.get_eee		=3D rtl8169_get_eee,
+	.set_eee		=3D rtl8169_set_eee,
+	.get_link_ksettings	=3D phy_ethtool_get_link_ksettings,
+	.set_link_ksettings	=3D rtl8169_set_link_ksettings,
+	.get_ringparam		=3D rtl8169_get_ringparam,
+	.get_pause_stats	=3D rtl8169_get_pause_stats,
+	.get_pauseparam		=3D rtl8169_get_pauseparam,
+	.set_pauseparam		=3D rtl8169_set_pauseparam,
+	.get_eth_mac_stats	=3D rtl8169_get_eth_mac_stats,
+	.get_eth_ctrl_stats	=3D rtl8169_get_eth_ctrl_stats,
+};
+
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *=
ent)
 {
 	const struct rtl_chip_info *chip;
--=20
2.43.0


