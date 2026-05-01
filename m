Return-Path: <netdev+bounces-283270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPmsJXf39GklGQIAu9opvQ
	(envelope-from <netdev+bounces-283270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 20:56:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BC94AEF87
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 20:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BB0F301A425
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 18:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0682E41B35F;
	Fri,  1 May 2026 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VVTaPZe8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356AF3CBE9E
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777661799; cv=none; b=meYY7Ng2R5BdreLhZM3dvbd0rBjwu3WuyjuGJpN3Z/D10KF3mLAldzobG24YXPpu6ZO/7LUrLSiBlUrju7GLrfZvgApNX34szs8Y8xZCA/bOtEa7g0CbCIXv99unzg1aU/3tNOn72FmPyVBC8LDfW96crO8tKHcYmjtEy2Squjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777661799; c=relaxed/simple;
	bh=I3STEwDfMyWR+/lGo042zxbHPop9o92eU0VKV/Xj5Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mMLqEFoOsdwAL+DRypfgBqVVPKsBoJbVBejoJHWyYBJFJMbDgFFENm/yQK/QjvY6f8Pz2YFrHvm1syIrf6wvi5myQnG6tmjV3nYcJifwHRBtZ5z4ohBAP2HlmWH0Jah81w3b4U41K9NDM5hhcR74B+7ZKLgp/Z8g5WbsTy+GP6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VVTaPZe8; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-7982c3b7dfcso23613677b3.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 11:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777661797; x=1778266597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qctsdg421XPxtLDsvaUGNpdlbgCSeE8SF/wS5f8RAys=;
        b=j+Aq65vYpf+S4p6MaTADSrzEn3eF6VJqCprv3pZnCQgh9/G8dykyKaimvANiiHf2st
         c2vVbGQG+6B1eyzXW2/tarn9tczqCqqnhguWFqPCvxKjUZP+TMluat5KZE368nEnK5pq
         QM7+bCDD9IlBJR4Ru6H8tqwQZzCLEFGeC3nl1G1Y6kU+ET4gV2bmwy2dqdyadczzxtiY
         SIvGE7/AA8GTH4eoCZl9qLYdtpL0ygDCI9fqhn/mgsE/BBZRlK5h+rPDjD4MpL/7QDjk
         lEiY/JFeK0iHQc/akrJA87pVc457eqd/tQblktespO7gEZxY0+tTTCtfM/LDZnXpAf6E
         DJcw==
X-Gm-Message-State: AOJu0Yw266sgULB9yzcuPnIcBFWGvgK4folDygeoLPFttsLQFk/g1ZUh
	TfKGn/uGd000ewuQbEfVYu5XYj1vdxHmZ84g4je5MflegP8FSpyEKNqDQKOq1FyrKM7gUZwltLg
	uJ6uOD80FwG4gOl9M0NFYgN9vA6wcQxkCuNGuh0ZKp7PE2Pj2BNlZHbdof0cdQhYP3GyQOwzPq1
	lUSdrwC++T/Lk4l6V3gXxdUCtoREjaglUFGfhHSY77fWoV2WljdN1XDNawl5xhS8J0OMafAW/8W
	Bhxtd1CMw==
X-Gm-Gg: AeBDievElPM4wIXAG2bmHAv8ndNQMtaRAk6EcmqsjwUdR7p5zS5ClsKKrbYV4Q3yb+E
	czguJumxKSt5cDYDp2OQQVNtGE3bM4OJK4bw8UtfgUSCxpYrOYi75f+2tCsXNbWGPqxcQk1Gz1Z
	ey8i3+azp3/2AMMaM8xrO63gAeI04pwiDin0OGau8rO8W9POy2+cpmvDm7RI7yxOJq2iyGKDO3f
	GLzMFoFBEBcri0dLw8W4G8ZCwCLEu1JWjzW4JZhFzA/A3IkfqsQHNiHebUXYRBCqiex/7E15ULG
	orT/WIAkeab/+qY6viJhmle6qXi1eWSe+xNxITIYLQT/jlb6OkzBrwul6kUku/8NtXwKqF2XAZN
	Ai5urbkym1tc2cgknSXi2Yxs0BzoqNjOqtMpjKDedzkKTHhMvuzBVGRvgIv3IizscXpu+PZ9OaS
	yuuUVE+FnZrsgiiA8hIrmnMK3cIBT0nLIK+0cI/HX1X82ZET9SxFldDivOFkhabMagreBa
X-Received: by 2002:a05:690c:9410:b0:7b8:88c0:198b with SMTP id 00721157ae682-7bd7726c077mr5169747b3.47.1777661797163;
        Fri, 01 May 2026 11:56:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7bd66528b7esm2049347b3.9.2026.05.01.11.56.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2026 11:56:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8eaaf673eb4so476386385a.2
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777661796; x=1778266596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qctsdg421XPxtLDsvaUGNpdlbgCSeE8SF/wS5f8RAys=;
        b=VVTaPZe8rjDi1rwVDr/d8fgd5VcN3Sj9beaSSjpBfjDeD5LOYaFMNpHN9Wl3fsDSsS
         CooRX7KZ1cnYgfBPJmFk7YRiWfpnWtGJOMum0pFc9oprE09d9DKH21iZVF6v5GDKrZTz
         lbMV2qBTUBmb/sgUKdwFwc7AYg5v50nNRD8+U=
X-Received: by 2002:a05:620a:2697:b0:8cd:c01f:fd25 with SMTP id af79cd13be357-8fd15bd9f4bmr95288385a.14.1777661795963;
        Fri, 01 May 2026 11:56:35 -0700 (PDT)
X-Received: by 2002:a05:620a:2697:b0:8cd:c01f:fd25 with SMTP id af79cd13be357-8fd15bd9f4bmr95281185a.14.1777661795272;
        Fri, 01 May 2026 11:56:35 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2938d20fsm238003185a.1.2026.05.01.11.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 11:56:34 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/2] net: bcmasp: Divide init to allow partial bring up
Date: Fri,  1 May 2026 11:56:24 -0700
Message-Id: <20260501185625.422361-2-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260501185625.422361-1-justin.chen@broadcom.com>
References: <20260501185625.422361-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 33BC94AEF87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283270-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

To prepare for a partial bring up of the interface during resume,
we break apart the bcmasp_netif_init() function into smaller chunks
that can be called as necessary. Also consolidate some functions that
do not need to be standalone.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
v2
- Moved tx_lpi_timer read to only bcmasp_open(). We don't want to overwrite
  the SW ctx with the HW default in the resume/suspend case.

 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 210 ++++++++----------
 1 file changed, 98 insertions(+), 112 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index ec63f50a849e..e2b51ec903af 100644
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
-
-	bcmasp_enable_rx_irq(intf, 1);
-	bcmasp_enable_tx_irq(intf, 1);
-	bcmasp_enable_phy_irq(intf, 1);
-
-	phy_start(dev->phydev);
-}
+	struct phy_device *phydev = intf->ndev->phydev;
+	u32 mac0, mac1;
 
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
@@ -1161,14 +1132,30 @@ static int bcmasp_open(struct net_device *dev)
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
+	dev->phydev->eee_cfg.tx_lpi_timer = umac_rl(intf, UMC_EEE_LPI_TIMER);
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
 
@@ -1407,10 +1394,7 @@ int bcmasp_interface_suspend(struct bcmasp_intf *intf)
 	bcmasp_netif_deinit(dev);
 
 	if (!intf->wolopts) {
-		if (intf->internal_phy)
-			bcmasp_ephy_enable_set(intf, false);
-		else
-			bcmasp_rgmii_mode_en_set(intf, false);
+		bcmasp_phy_hw_unprepare(intf);
 
 		/* If Wake-on-LAN is disabled, we can safely
 		 * disable the network interface clocks.
@@ -1454,17 +1438,19 @@ int bcmasp_interface_resume(struct bcmasp_intf *intf)
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


