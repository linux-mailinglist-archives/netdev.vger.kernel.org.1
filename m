Return-Path: <netdev+bounces-282095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFcQFxAw8WnzeQEAu9opvQ
	(envelope-from <netdev+bounces-282095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:09:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1508C48C796
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC61C3050401
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95143750CC;
	Tue, 28 Apr 2026 22:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cHll92QE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409993793D3
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777414148; cv=none; b=G2NUzrAvJGsq5MT3Rhuzm4KmhUcQo9bEeOK/OiGdiC1w7IZc3czVCLhw7GHeaTFiR1HJ7bDac6IGB3cX4iluCNBuYrlIfulvsKnKjM2auTmk+A7I9uWekMVVGuxkGCEk+sUyDwZ1YMaOa7OWjbA2Lu7GPBKiyxZU8l+k4OOUCOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777414148; c=relaxed/simple;
	bh=UmfbFvpVXPgqHg8s1GxBMTSPNsKgkPS9RC0zgsykaZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bEhHtlM4SXs5vnFT2Myt52Z8HPlaSRpRR50Y8OOH4SzhOFYJi27Xy1Ch8NAMRkSrOaTZGqqnxbZlCxavBTI/mwtqpc+r7hpMr5ooEMYkpll/7wBZDSrMK8OQCl2Pbj7Yn+D94vSPwTQ5QiWxpGn8B4J9hPKzi/HBFQEVJngI3cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cHll92QE; arc=none smtp.client-ip=209.85.160.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-50e97863425so91908561cf.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777414146; x=1778018946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sm5M+JZxUuETqNCuJsvwGbA66LBiS296GYDkNwkvlW0=;
        b=rxfOiQvF3zze7v0JeIoO7u0JU85OPnXn9I3kfGCjGGvPQ3e9bCRp0PaTpLOYwnn1h1
         H3lr5r/AkKYO7a12keU7J/wKLTPCg1zjCZn1SjbdeSFr5s60fDCwkV+ZiYc9vZzBNJH0
         upa7y47ANX9jAgezdVwCLvhXFEel+N1oHYLiv/O2/bsit7Pb7cHwiLQS5YJp6+28QJUj
         buuzcirsHkVPS9BTmJfL6c1sjNTJU3BBoa1KfAiBDH9wv64nIlB659++JjuiVyjytbrb
         Lv13Q+7ieoJu37hAGQbiFRlToY7M1DPJFgpU/pgyn8pZDQiewFt9g39Ie6a69k9q0JDH
         xCSQ==
X-Gm-Message-State: AOJu0YwuA2dKd6EEpjAs4ms4LJvdn2sEP0NCMb6YJUe0hPdAsHEbwBgu
	n21pmaWUqloQRgO2DK2HShy8u8GcbD0GqJ35cUW8o+XuyEGnGNb0QjIs17776K5U9dpjifv/1HY
	sXQWHpZclhNQ3XM2fO8rMMOCk8a6qujGbyAEgWEnKTGr1bdj4k8h2thfX35/rlTBmlvEi9io/FV
	Jo55PX0ROR6wKoGckYYEKgRkk3SH0sGGB/5rcAOPaAkSK8KQlhaXBchOmfhj+paZeCEUtSmXD6Z
	nCsaJAjXg==
X-Gm-Gg: AeBDieuiigpmmfmEe/SnoQ/G/F2dGIsWItRVGP8PpMiWq76LRXDr/yDkm8Qjqyc15mc
	etXq87A9XOD3pDFSvT4iVNTD512TqLJUtZ5BQ7fRK3X7No24SpplTRwCM4Ztj262Uhwik44H4nB
	qnNw7JmtCREb4uDtN2mOnbB/apI9tXEemEacpsc4V3Wfu5k8pPn+FGKpTiqBB6rloujw6Nya9gt
	Of1gN3p8mlMby0S1iNvmY8K2dVNhqfAE1hjE3MCRT1eb5l8ypegwjztjlQXuWuk5BYYUnra+bd9
	6PR2ZjoPDq4uXNhCo26lVuSDP1So6LXq6jDCEqTLY0b3/v9BNobSOCVX3WOdUSepeKOHDT07GkM
	JaHWmWWUWXgAR1xjmKfH0M4mXR8TkDg5ApWhLsv73BwrsuDBeIU2O4RlYmJR81BGB3GBWwLgoXj
	4+Y69tUErQkgiHv5Y7Si5zsLFI5zx8KeK27Bj2b/e7U3FsOuasxQMTnEsV+7RzeemeqgBc
X-Received: by 2002:ac8:5891:0:b0:50d:5f34:9a with SMTP id d75a77b69052e-51018a357f5mr21800211cf.28.1777414146101;
        Tue, 28 Apr 2026 15:09:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-5101ae47df6sm90391cf.26.2026.04.28.15.09.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2026 15:09:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50e136aff17so217386941cf.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777414144; x=1778018944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sm5M+JZxUuETqNCuJsvwGbA66LBiS296GYDkNwkvlW0=;
        b=cHll92QEE4eD1YGRuN8lCUnfqDDqZDb5sSeo2zvq+74cm8rKL+e4vcH0QHT2znhS3c
         wBygynBPWAo9evGmXEr+7vCAnWF6CL+4WGIuSL02FbEO/RC3p0NmQUatycMmIi3YDii2
         3BOKAW0lz3UhtlzNoBl55HALWYpCpoeZtDCNA=
X-Received: by 2002:a05:622a:986:b0:50f:b17d:7e4a with SMTP id d75a77b69052e-51018ac4c6dmr24003751cf.57.1777414144480;
        Tue, 28 Apr 2026 15:09:04 -0700 (PDT)
X-Received: by 2002:a05:622a:986:b0:50f:b17d:7e4a with SMTP id d75a77b69052e-51018ac4c6dmr24003071cf.57.1777414143871;
        Tue, 28 Apr 2026 15:09:03 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5101ae3ced9sm1410181cf.14.2026.04.28.15.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:09:03 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next 1/2] net: bcmasp: Divide init to allow partial bring up
Date: Tue, 28 Apr 2026 15:08:57 -0700
Message-Id: <20260428220858.2076469-2-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428220858.2076469-1-justin.chen@broadcom.com>
References: <20260428220858.2076469-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 1508C48C796
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-282095-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

To prepare for a partial bring up of the interface during resume,
we break apart the bcmasp_netif_init() function into smaller chunks
that can be called as necessary. Also consolidate some functions that
do not need to be standalone.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 208 ++++++++----------
 1 file changed, 96 insertions(+), 112 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index ec63f50a849e..aff0a6d84126 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -344,40 +344,35 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static void bcmasp_netif_start(struct net_device *dev)
+static void umac_reset_and_init(struct bcmasp_intf *intf,
+				const unsigned char *addr)
 {
-	struct bcmasp_intf *intf = netdev_priv(dev);
-
-	bcmasp_set_rx_mode(dev);
-	napi_enable(&intf->tx_napi);
-	napi_enable(&intf->rx_napi);
+	struct phy_device *phydev = intf->ndev->phydev;
+	u32 mac0, mac1;
 
-	bcmasp_enable_rx_irq(intf, 1);
-	bcmasp_enable_tx_irq(intf, 1);
-	bcmasp_enable_phy_irq(intf, 1);
-
-	phy_start(dev->phydev);
-}
-
-static void umac_reset(struct bcmasp_intf *intf)
-{
 	umac_wl(intf, 0x0, UMC_CMD);
 	umac_wl(intf, UMC_CMD_SW_RESET, UMC_CMD);
 	usleep_range(10, 100);
 	/* We hold the umac in reset and bring it out of
 	 * reset when phy link is up.
 	 */
-}
 
-static void umac_set_hw_addr(struct bcmasp_intf *intf,
-			     const unsigned char *addr)
-{
-	u32 mac0 = (addr[0] << 24) | (addr[1] << 16) | (addr[2] << 8) |
-		    addr[3];
-	u32 mac1 = (addr[4] << 8) | addr[5];
+	umac_wl(intf, 0x800, UMC_FRM_LEN);
+	umac_wl(intf, 0xffff, UMC_PAUSE_CNTRL);
+	umac_wl(intf, 0x800, UMC_RX_MAX_PKT_SZ);
+
+	mac0 = (addr[0] << 24) | (addr[1] << 16) | (addr[2] << 8) |
+		addr[3];
+	mac1 = (addr[4] << 8) | addr[5];
 
 	umac_wl(intf, mac0, UMC_MAC0);
 	umac_wl(intf, mac1, UMC_MAC1);
+
+	/* Reset shadow values since we reset the umac */
+	intf->old_duplex = -1;
+	intf->old_link = -1;
+	intf->old_pause = -1;
+	phydev->eee_cfg.tx_lpi_timer = umac_rl(intf, UMC_EEE_LPI_TIMER);
 }
 
 static void umac_enable_set(struct bcmasp_intf *intf, u32 mask,
@@ -401,13 +396,6 @@ static void umac_enable_set(struct bcmasp_intf *intf, u32 mask,
 		usleep_range(1000, 2000);
 }
 
-static void umac_init(struct bcmasp_intf *intf)
-{
-	umac_wl(intf, 0x800, UMC_FRM_LEN);
-	umac_wl(intf, 0xffff, UMC_PAUSE_CNTRL);
-	umac_wl(intf, 0x800, UMC_RX_MAX_PKT_SZ);
-}
-
 static int bcmasp_tx_reclaim(struct bcmasp_intf *intf)
 {
 	struct bcmasp_intf_stats64 *stats = &intf->stats64;
@@ -927,6 +915,14 @@ static void bcmasp_rgmii_mode_en_set(struct bcmasp_intf *intf, bool enable)
 	rgmii_wl(intf, reg, RGMII_OOB_CNTRL);
 }
 
+static void bcmasp_phy_hw_unprepare(struct bcmasp_intf *intf)
+{
+	if (intf->internal_phy)
+		bcmasp_ephy_enable_set(intf, false);
+	else
+		bcmasp_rgmii_mode_en_set(intf, false);
+}
+
 static void bcmasp_netif_deinit(struct net_device *dev)
 {
 	struct bcmasp_intf *intf = netdev_priv(dev);
@@ -984,11 +980,7 @@ static int bcmasp_stop(struct net_device *dev)
 
 	phy_disconnect(dev->phydev);
 
-	/* Disable internal EPHY or external PHY */
-	if (intf->internal_phy)
-		bcmasp_ephy_enable_set(intf, false);
-	else
-		bcmasp_rgmii_mode_en_set(intf, false);
+	bcmasp_phy_hw_unprepare(intf);
 
 	/* Disable the interface clocks */
 	bcmasp_core_clock_set_intf(intf, false);
@@ -998,10 +990,15 @@ static int bcmasp_stop(struct net_device *dev)
 	return 0;
 }
 
-static void bcmasp_configure_port(struct bcmasp_intf *intf)
+static void bcmasp_phy_hw_prepare(struct bcmasp_intf *intf)
 {
 	u32 reg, id_mode_dis = 0;
 
+	if (intf->internal_phy)
+		bcmasp_ephy_enable_set(intf, true);
+	else
+		bcmasp_rgmii_mode_en_set(intf, true);
+
 	reg = rgmii_rl(intf, RGMII_PORT_CNTRL);
 	reg &= ~RGMII_PORT_MODE_MASK;
 
@@ -1036,26 +1033,8 @@ static void bcmasp_configure_port(struct bcmasp_intf *intf)
 	rgmii_wl(intf, reg, RGMII_OOB_CNTRL);
 }
 
-static int bcmasp_netif_init(struct net_device *dev, bool phy_connect)
+static phy_interface_t bcmasp_phy_iface_for_connect(phy_interface_t mode)
 {
-	struct bcmasp_intf *intf = netdev_priv(dev);
-	phy_interface_t phy_iface = intf->phy_interface;
-	u32 phy_flags = PHY_BRCM_AUTO_PWRDWN_ENABLE |
-			PHY_BRCM_DIS_TXCRXC_NOENRGY |
-			PHY_BRCM_IDDQ_SUSPEND;
-	struct phy_device *phydev = NULL;
-	int ret;
-
-	/* Always enable interface clocks */
-	bcmasp_core_clock_set_intf(intf, true);
-
-	/* Enable internal PHY or external PHY before any MAC activity */
-	if (intf->internal_phy)
-		bcmasp_ephy_enable_set(intf, true);
-	else
-		bcmasp_rgmii_mode_en_set(intf, true);
-	bcmasp_configure_port(intf);
-
 	/* This is an ugly quirk but we have not been correctly
 	 * interpreting the phy_interface values and we have done that
 	 * across different drivers, so at least we are consistent in
@@ -1081,46 +1060,43 @@ static int bcmasp_netif_init(struct net_device *dev, bool phy_connect)
 	 * affected because they use different phy_interface_t values
 	 * or the Generic PHY driver.
 	 */
-	switch (phy_iface) {
+	switch (mode) {
 	case PHY_INTERFACE_MODE_RGMII:
-		phy_iface = PHY_INTERFACE_MODE_RGMII_ID;
-		break;
+		return PHY_INTERFACE_MODE_RGMII_ID;
 	case PHY_INTERFACE_MODE_RGMII_TXID:
-		phy_iface = PHY_INTERFACE_MODE_RGMII_RXID;
-		break;
+		return PHY_INTERFACE_MODE_RGMII_RXID;
 	default:
-		break;
+		return mode;
 	}
+}
 
-	if (phy_connect) {
-		phydev = of_phy_connect(dev, intf->phy_dn,
-					bcmasp_adj_link, phy_flags,
-					phy_iface);
-		if (!phydev) {
-			ret = -ENODEV;
-			netdev_err(dev, "could not attach to PHY\n");
-			goto err_phy_disable;
-		}
-
-		if (intf->internal_phy)
-			dev->phydev->irq = PHY_MAC_INTERRUPT;
-
-		/* Indicate that the MAC is responsible for PHY PM */
-		phydev->mac_managed_pm = true;
-
-		/* Set phylib's copy of the LPI timer */
-		phydev->eee_cfg.tx_lpi_timer = umac_rl(intf, UMC_EEE_LPI_TIMER);
+static int bcmasp_phy_attach(struct bcmasp_intf *intf)
+{
+	u32 phy_flags = PHY_BRCM_AUTO_PWRDWN_ENABLE |
+			PHY_BRCM_DIS_TXCRXC_NOENRGY |
+			PHY_BRCM_IDDQ_SUSPEND;
+	struct phy_device *phydev;
+	phy_interface_t phy_iface;
+
+	phy_iface = bcmasp_phy_iface_for_connect(intf->phy_interface);
+	phydev = of_phy_connect(intf->ndev, intf->phy_dn,
+				bcmasp_adj_link, phy_flags,
+				phy_iface);
+	if (!phydev) {
+		netdev_err(intf->ndev, "could not attach to PHY\n");
+		return -ENODEV;
 	}
+	if (intf->internal_phy)
+		intf->ndev->phydev->irq = PHY_MAC_INTERRUPT;
 
-	umac_reset(intf);
-
-	umac_init(intf);
+	phydev->mac_managed_pm = true;
 
-	umac_set_hw_addr(intf, dev->dev_addr);
+	return 0;
+}
 
-	intf->old_duplex = -1;
-	intf->old_link = -1;
-	intf->old_pause = -1;
+static void bcmasp_netif_init(struct net_device *dev)
+{
+	struct bcmasp_intf *intf = netdev_priv(dev);
 
 	bcmasp_init_tx(intf);
 	netif_napi_add_tx(intf->ndev, &intf->tx_napi, bcmasp_tx_poll);
@@ -1132,18 +1108,13 @@ static int bcmasp_netif_init(struct net_device *dev, bool phy_connect)
 
 	intf->crc_fwd = !!(umac_rl(intf, UMC_CMD) & UMC_CMD_CRC_FWD);
 
-	bcmasp_netif_start(dev);
-
-	netif_start_queue(dev);
-
-	return 0;
+	bcmasp_set_rx_mode(dev);
+	napi_enable(&intf->tx_napi);
+	napi_enable(&intf->rx_napi);
 
-err_phy_disable:
-	if (intf->internal_phy)
-		bcmasp_ephy_enable_set(intf, false);
-	else
-		bcmasp_rgmii_mode_en_set(intf, false);
-	return ret;
+	bcmasp_enable_rx_irq(intf, 1);
+	bcmasp_enable_tx_irq(intf, 1);
+	bcmasp_enable_phy_irq(intf, 1);
 }
 
 static int bcmasp_open(struct net_device *dev)
@@ -1161,14 +1132,28 @@ static int bcmasp_open(struct net_device *dev)
 	if (ret)
 		goto err_free_mem;
 
-	ret = bcmasp_netif_init(dev, true);
-	if (ret) {
-		clk_disable_unprepare(intf->parent->clk);
-		goto err_free_mem;
-	}
+	bcmasp_core_clock_set_intf(intf, true);
+
+	bcmasp_phy_hw_prepare(intf);
+
+	ret = bcmasp_phy_attach(intf);
+	if (ret)
+		goto err_phy_attach;
+
+	umac_reset_and_init(intf, dev->dev_addr);
+
+	bcmasp_netif_init(dev);
+
+	phy_start(dev->phydev);
+
+	netif_start_queue(dev);
 
 	return ret;
 
+err_phy_attach:
+	bcmasp_phy_hw_unprepare(intf);
+	bcmasp_core_clock_set_intf(intf, false);
+	clk_disable_unprepare(intf->parent->clk);
 err_free_mem:
 	bcmasp_reclaim_free_buffers(intf);
 
@@ -1407,10 +1392,7 @@ int bcmasp_interface_suspend(struct bcmasp_intf *intf)
 	bcmasp_netif_deinit(dev);
 
 	if (!intf->wolopts) {
-		if (intf->internal_phy)
-			bcmasp_ephy_enable_set(intf, false);
-		else
-			bcmasp_rgmii_mode_en_set(intf, false);
+		bcmasp_phy_hw_unprepare(intf);
 
 		/* If Wake-on-LAN is disabled, we can safely
 		 * disable the network interface clocks.
@@ -1454,17 +1436,19 @@ int bcmasp_interface_resume(struct bcmasp_intf *intf)
 	if (ret)
 		return ret;
 
-	ret = bcmasp_netif_init(dev, false);
-	if (ret)
-		goto out;
+	bcmasp_core_clock_set_intf(intf, true);
 
 	bcmasp_resume_from_wol(intf);
 
+	bcmasp_phy_hw_prepare(intf);
+
+	umac_reset_and_init(intf, dev->dev_addr);
+
+	bcmasp_netif_init(dev);
+
+	phy_start(dev->phydev);
+
 	netif_device_attach(dev);
 
 	return 0;
-
-out:
-	clk_disable_unprepare(intf->parent->clk);
-	return ret;
 }
-- 
2.34.1


