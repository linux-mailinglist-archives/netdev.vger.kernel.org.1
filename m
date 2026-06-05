Return-Path: <netdev+bounces-295779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YuOgGqqoImqObgEAu9opvQ
	(envelope-from <netdev+bounces-295779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 12:44:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C9A647760
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 12:44:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=R8IWegpw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295779-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295779-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 577C43048239
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 10:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809F34BCAAF;
	Fri,  5 Jun 2026 10:39:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6654183BE;
	Fri,  5 Jun 2026 10:39:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655973; cv=none; b=Bu1+1Ckw0+1K4Q90TjSv8WtGcQ3hMo7W/tgbphb16IGeFOryg1UzT1q/vIm7WuEHv5uSv47TiOwj8zzQ+uocEAayZrkQoyYyUd1QWEvmxzlZgmCII38IzzUs5KuHCUvYBzsDAUI8L3i6GmANbGEhjsCk4OsarJ7NoI+Yq6Zhls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655973; c=relaxed/simple;
	bh=FZyM4aI9IrXDDh/pxjTDWFt3k7Ku6S6cDnnXUo/Wo8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZNE4GCEykhEiVWPkAbuw1LCky30j+27avAYco4qHHFPlmvMUp0sqDPFwxad6a5e2hFT4sw1shpEcaWDwCYqnUtXGqVQdsNpzXHeFAZT1COErm/lFlRazGZcvCaKEEvHxsTrDjNHydSnSjamvorRkhtO8j3ZYHlcb3bvSMIg7is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=R8IWegpw; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 655Ad8eE51324199, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780655949;
	bh=kWcscj3TyaEVM4WJqLJLBNigkRUiU9RLRSvpWg1yyIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=R8IWegpwMcUWb9ckGkxWq2YDmaz4P7TFQ2N9hgt8xGxIwZF0kk45CeMfjHGvgf8QI
	 CteduwanFtn4yF3k3NreEqY5EGW7OFnIoyAP1DA6LwiB5gcfb1SCtTAjiEbyD3X/6q
	 /7Pq5YvbXRiJwPeC/khniAIk5ZvAglYVt6oPt4AdII3mMZrKF4LH225jhgwniE0SZ/
	 wsklucUr0Yb5pd+056cTWbdfuJdA/AoVda/CaaUDNzFUKgbbH9HNtwt3Y7r2/iPU7s
	 ddSjN3v/pK/6OCGSgWojSzWM3ELs7uAHEyI5hGw1k4u8lGDSlQTHSWMWsqqRLAwSSh
	 0WzO33TmKXk9Q==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 655Ad8eE51324199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jun 2026 18:39:08 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Jun 2026 18:39:08 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 5 Jun 2026 18:39:08 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 1/6] r8169: add current_speed in private struct
Date: Fri, 5 Jun 2026 18:39:00 +0800
Message-ID: <20260605103906.1445-2-javen_xu@realsil.com.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295779-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realsil.com.cn:mid,realsil.com.cn:dkim,realsil.com.cn:from_mime,realsil.com.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20C9A647760

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds current_speed in private strcut in order to decouple
from phydev in the following patch supporting for phylink.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ec4fc21fa21f..fdc8c84dd112 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -750,6 +750,7 @@ struct rtl8169_private {
 	u32 irq_mask;
 	int irq;
 	struct clk *clk;
+	int current_speed;
 
 	struct {
 		DECLARE_BITMAP(flags, RTL_FLAG_MAX);
@@ -1673,16 +1674,14 @@ static void rtl8169_irq_mask_and_ack(struct rtl8169_private *tp)
 	rtl_pci_commit(tp);
 }
 
-static void rtl_link_chg_patch(struct rtl8169_private *tp)
+static void rtl_link_chg_patch(struct rtl8169_private *tp, int speed)
 {
-	struct phy_device *phydev = tp->phydev;
-
 	if (tp->mac_version == RTL_GIGA_MAC_VER_34 ||
 	    tp->mac_version == RTL_GIGA_MAC_VER_38) {
-		if (phydev->speed == SPEED_1000) {
+		if (speed == SPEED_1000) {
 			rtl_eri_write(tp, 0x1bc, ERIAR_MASK_1111, 0x00000011);
 			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x00000005);
-		} else if (phydev->speed == SPEED_100) {
+		} else if (speed == SPEED_100) {
 			rtl_eri_write(tp, 0x1bc, ERIAR_MASK_1111, 0x0000001f);
 			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x00000005);
 		} else {
@@ -1692,7 +1691,7 @@ static void rtl_link_chg_patch(struct rtl8169_private *tp)
 		rtl_reset_packet_filter(tp);
 	} else if (tp->mac_version == RTL_GIGA_MAC_VER_35 ||
 		   tp->mac_version == RTL_GIGA_MAC_VER_36) {
-		if (phydev->speed == SPEED_1000) {
+		if (speed == SPEED_1000) {
 			rtl_eri_write(tp, 0x1bc, ERIAR_MASK_1111, 0x00000011);
 			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x00000005);
 		} else {
@@ -1700,7 +1699,7 @@ static void rtl_link_chg_patch(struct rtl8169_private *tp)
 			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x0000003f);
 		}
 	} else if (tp->mac_version == RTL_GIGA_MAC_VER_37) {
-		if (phydev->speed == SPEED_10) {
+		if (speed == SPEED_10) {
 			rtl_eri_write(tp, 0x1d0, ERIAR_MASK_0011, 0x4d02);
 			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_0011, 0x0060a);
 		} else {
@@ -2074,11 +2073,11 @@ rtl_coalesce_info(struct rtl8169_private *tp)
 		ci = rtl_coalesce_info_8168_8136;
 
 	/* if speed is unknown assume highest one */
-	if (tp->phydev->speed == SPEED_UNKNOWN)
+	if (tp->current_speed == SPEED_UNKNOWN)
 		return ci;
 
 	for (; ci->speed; ci++) {
-		if (tp->phydev->speed == ci->speed)
+		if (tp->current_speed == ci->speed)
 			return ci;
 	}
 
@@ -2236,7 +2235,7 @@ static void rtl_set_eee_txidle_timer(struct rtl8169_private *tp)
 
 static unsigned int r8169_get_tx_lpi_timer_us(struct rtl8169_private *tp)
 {
-	unsigned int speed = tp->phydev->speed;
+	unsigned int speed = tp->current_speed;
 	unsigned int timer = tp->tx_lpi_timer;
 
 	if (!timer || speed == SPEED_UNKNOWN)
@@ -4968,8 +4967,9 @@ static void r8169_phylink_handler(struct net_device *ndev)
 	struct rtl8169_private *tp = netdev_priv(ndev);
 	struct device *d = tp_to_dev(tp);
 
+	tp->current_speed = tp->phydev->speed;
 	if (netif_carrier_ok(ndev)) {
-		rtl_link_chg_patch(tp);
+		rtl_link_chg_patch(tp, tp->current_speed);
 		rtl_enable_tx_lpi(tp, tp->phydev->enable_tx_lpi);
 		pm_request_resume(d);
 	} else {
@@ -5667,6 +5667,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 				     ext_xid_str, xid);
 	tp->mac_version = chip->mac_version;
 	tp->fw_name = chip->fw_name;
+	tp->current_speed = SPEED_UNKNOWN;
 
 	/* Disable ASPM L1 as that cause random device stop working
 	 * problems as well as full system hangs for some PCIe devices users.
-- 
2.43.0


