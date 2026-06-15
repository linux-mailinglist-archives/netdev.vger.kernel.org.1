Return-Path: <netdev+bounces-299299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qA6YGEZuL2pQAQUAu9opvQ
	(envelope-from <netdev+bounces-299299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:15:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E98682FD4
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:15:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=fGcNpy6T;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299299-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299299-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2A5730131C9
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 03:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5B42857EE;
	Mon, 15 Jun 2026 03:14:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3349318DB2A;
	Mon, 15 Jun 2026 03:14:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781493269; cv=none; b=Ec/2gs/sB0G2E6KAuOlurS4HMMs7BQasYSPVH4ID+y1rthLRLvVwFmKiykymUNues/0OBi33smzflLXwyNfcAKx1Wc103JTN+amO8XzltjKS5pfxESb4N+obDpesFEeShFONKLG66ohDVfP3HKylOm17T9NxiBB9xxslYPZWK90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781493269; c=relaxed/simple;
	bh=3Skoc4Fi+OxPFKvo+5ylRn5EXcC9MzJ2GF36WXRPvHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QckbjrE0SFBUiM9v5u+g35dftCFp453zDl48jCYK+RcTUYtWjRcHQ1Fvf9n4/q/3vJOi7E5LwUif1HPcR4ewSbwZ6HYPUnGyRicrrAinAcxyWU/wUyz1awJqBGRDQzpNuFf613WR0SBNmlfmCjdg9yFEwchPFLhRNFWyVM2I1gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=fGcNpy6T; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65F3DoQxA457249, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1781493231;
	bh=35Bpd4wg1zPixZQwnSXymqC6YZ3JH2JJM2QAPZf7GXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=fGcNpy6Ttu7bLUFccUxzuPZrpSEZ3i2QU7vk+NA34j6J+FEa/JNgGewUtzhnPoA9h
	 RzhWp5EDTSK9Z8/IMQYgy3ymwRtHr4uXV2uP2HHBY9egygOEfQQYxNx3skU4B2W9UG
	 7As//KGrc4rkLrnnUANXumx3keXGL6yJiMUW4yfL5wSj/kfswEPUE31n8T80DhUJxU
	 HWfU19OKyDgk0ll3DhZpA9Bhq+Fx0F5a7TIFO5z5BKGnWebxoTaedDsXYCbGp0PWkG
	 me9fN3l98FCm5zJrjKWuGz7TikMPLyQb7/9mMpJZsGwbNCzYfThqftqzJLzFBRZv9J
	 fIJ9/2nyeuW7w==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65F3DoQxA457249
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jun 2026 11:13:51 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Jun 2026 11:13:49 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 15 Jun 2026 11:13:49 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v8 6/7] r8169: move struct ethtool_ops
Date: Mon, 15 Jun 2026 11:13:44 +0800
Message-ID: <20260615031345.548-7-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260615031345.548-1-javen_xu@realsil.com.cn>
References: <20260615031345.548-1-javen_xu@realsil.com.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299299-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,realsil.com.cn:dkim,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5E98682FD4

From: Javen Xu <javen_xu@realsil.com.cn>

The patch moves the rtl8169_ethtool_ops definition further down in
r8169_main.c so that subsequent additions of rtl8169_get_channels and
rtl8169_set_channels can be referenced from the ops struct without
needing forward declarations.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - no changes

Changes in v3:
 - no changes

Changes in v4:
 - no changes

Changes in v5:
 - no changes

Changes in v6:
 - modify commit message

Changes in v7:
 - no changes
 
Changes in v8:
 - no changes
---
 drivers/net/ethernet/realtek/r8169_main.c | 56 +++++++++++------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 29bfac489ca7..e43366468101 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2536,34 +2536,6 @@ static int rtl8169_set_link_ksettings(struct net_device *ndev,
 	return 0;
 }
 
-static const struct ethtool_ops rtl8169_ethtool_ops = {
-	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
-				     ETHTOOL_COALESCE_MAX_FRAMES,
-	.get_drvinfo		= rtl8169_get_drvinfo,
-	.get_regs_len		= rtl8169_get_regs_len,
-	.get_link		= ethtool_op_get_link,
-	.get_coalesce		= rtl_get_coalesce,
-	.set_coalesce		= rtl_set_coalesce,
-	.get_regs		= rtl8169_get_regs,
-	.get_wol		= rtl8169_get_wol,
-	.set_wol		= rtl8169_set_wol,
-	.get_strings		= rtl8169_get_strings,
-	.get_sset_count		= rtl8169_get_sset_count,
-	.get_ethtool_stats	= rtl8169_get_ethtool_stats,
-	.get_ts_info		= ethtool_op_get_ts_info,
-	.nway_reset		= phy_ethtool_nway_reset,
-	.get_eee		= rtl8169_get_eee,
-	.set_eee		= rtl8169_set_eee,
-	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
-	.set_link_ksettings	= rtl8169_set_link_ksettings,
-	.get_ringparam		= rtl8169_get_ringparam,
-	.get_pause_stats	= rtl8169_get_pause_stats,
-	.get_pauseparam		= rtl8169_get_pauseparam,
-	.set_pauseparam		= rtl8169_set_pauseparam,
-	.get_eth_mac_stats	= rtl8169_get_eth_mac_stats,
-	.get_eth_ctrl_stats	= rtl8169_get_eth_ctrl_stats,
-};
-
 static const struct rtl_chip_info *rtl8169_get_chip_version(u32 xid, bool gmii)
 {
 	/* Chips combining a 1Gbps MAC with a 100Mbps PHY */
@@ -6256,6 +6228,34 @@ static void r8169_init_napi(struct rtl8169_private *tp)
 	}
 }
 
+static const struct ethtool_ops rtl8169_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
+				     ETHTOOL_COALESCE_MAX_FRAMES,
+	.get_drvinfo		= rtl8169_get_drvinfo,
+	.get_regs_len		= rtl8169_get_regs_len,
+	.get_link		= ethtool_op_get_link,
+	.get_coalesce		= rtl_get_coalesce,
+	.set_coalesce		= rtl_set_coalesce,
+	.get_regs		= rtl8169_get_regs,
+	.get_wol		= rtl8169_get_wol,
+	.set_wol		= rtl8169_set_wol,
+	.get_strings		= rtl8169_get_strings,
+	.get_sset_count		= rtl8169_get_sset_count,
+	.get_ethtool_stats	= rtl8169_get_ethtool_stats,
+	.get_ts_info		= ethtool_op_get_ts_info,
+	.nway_reset		= phy_ethtool_nway_reset,
+	.get_eee		= rtl8169_get_eee,
+	.set_eee		= rtl8169_set_eee,
+	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
+	.set_link_ksettings	= rtl8169_set_link_ksettings,
+	.get_ringparam		= rtl8169_get_ringparam,
+	.get_pause_stats	= rtl8169_get_pause_stats,
+	.get_pauseparam		= rtl8169_get_pauseparam,
+	.set_pauseparam		= rtl8169_set_pauseparam,
+	.get_eth_mac_stats	= rtl8169_get_eth_mac_stats,
+	.get_eth_ctrl_stats	= rtl8169_get_eth_ctrl_stats,
+};
+
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct rtl_chip_info *chip;
-- 
2.43.0


