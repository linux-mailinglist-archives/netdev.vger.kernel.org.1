Return-Path: <netdev+bounces-253437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIJbDedTd2nMeAEAu9opvQ
	(envelope-from <netdev+bounces-253437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:45:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7205987C25
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E43C43019F3D
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96004295D90;
	Mon, 26 Jan 2026 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hHpaLz43"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223A21DDA18
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769427922; cv=none; b=DmEeZhG/D+ZaDCeRieUDgB2MdQnyfrhTiKxTqrLYYhlDEs251b0KvryzdeXaua9Z7sQiZLbRRiBe+GkepYV26uF/hpPjvM92S+RzwjPjlXxVXzP5k7c9U2Ygi8TanVTpMjQpLXKP82pcXfVilthaOvT26zoqSIsb9CAsZgROyLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769427922; c=relaxed/simple;
	bh=ykNzGLOnsXlcVOtlA1FBTtnGIm7CDCU7K8UlXBFaLf8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=LrjYxDPCBGlv1E4I8jIsCEQ03xEsane8AKazOHYoTD9O3errP29oYt20nHNK8Jo+HBezOiX6Az8P95A+vpxJW2Cwooxjr/mqswXEtsMLao+TxrdkhI6a8GuFr4WsH3eZB0jeKH92wirnR9RUiJDC79uJ3qtzRcKeQgCBhZ6mIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hHpaLz43; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0qGx8UYOulSnUg11qGU4L409UfzsYItsrQ97nAr/FR8=; b=hHpaLz43MGySpdGbuqLG8yse+9
	TEbi0kl4ewILB0Ej8AJj1w8zjDshHtoEl9a8T0gBDvD+FKIDLewIZKg0s/pq5/E4/QJiJOAAFdrRu
	E8mVl1F6VaLq9UcUB+p1855s2E6+sZ/hJOMwTdVCGbWpvwfNjyJErOoBBB+4tUnrRQq1EIAar1MwT
	w2OE0HpUoNe3jgVP1/eG5z1mt5rKGMo9QfTjXVbxVv9T03a64+GHYAJDJqH/WSrH4v3P076ZhAJOQ
	vxAjwSvuLaZyRO+sD0vlyb2rkAslkpQgbn3wavH4L1WwM6XJQ9yFCqPy4BRJT7RKetiSM6OryJydd
	IRKgbLVw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41130 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vkL1u-000000004e2-0T9G;
	Mon, 26 Jan 2026 11:45:14 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vkL1t-00000005usQ-0vjt;
	Mon, 26 Jan 2026 11:45:13 +0000
In-Reply-To: <aXdTi4ViCkhhXvFI@shell.armlinux.org.uk>
References: <aXdTi4ViCkhhXvFI@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 03/22] net: stmmac: rk: convert rk3328 to use
 bsp_priv->id
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vkL1t-00000005usQ-0vjt@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 26 Jan 2026 11:45:13 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253437-lists,netdev=lfdr.de,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email,0.0.0.0:email,ff550000:email]
X-Rspamd-Queue-Id: 7205987C25
X-Rspamd-Action: no action

rk3328 contains two GMAC instances - gmac2io and gmac2phy. While the
gmac2io instance may be connected to an external PHY, the gmac2phy
instance is permanently connected via RMII to an on-SoC integrated PHY.

The driver currently tests for the gmac2phy instance by checking
bsp_priv->integrated_phy (determined from the PHY's phy-is-integrated
property) and sometimes that the interface mode is RMII. This works
because the rk3328.dtsi has:

	gmac2phy: ethernet@ff550000 {
		compatible = "rockchip,rk3328-gmac";
		phy-mode = "rmii";
		phy-handle = <&phy>;

		mdio {
			phy: ethernet-phy@0 {
				phy-is-integrated;
			};
		};
	};

The driver contains a mechanism to look up the MMIO address in a table
to determine bsp_priv->id, which is used for every other Rockchip
device. Switch rk3328 to use this mechanism to determine bsp_priv->id
and use that to select which GRF register is used for configuration,
similarly to how the other Rockchip SoCs handle such differences.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 0e66252eb5ae..c8b49ed2064a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -570,8 +570,7 @@ static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 	unsigned int reg;
 
-	reg = bsp_priv->integrated_phy ? RK3328_GRF_MAC_CON2 :
-		  RK3328_GRF_MAC_CON1;
+	reg = bsp_priv->id ? RK3328_GRF_MAC_CON2 : RK3328_GRF_MAC_CON1;
 
 	regmap_write(bsp_priv->grf, reg,
 		     RK3328_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
@@ -591,10 +590,7 @@ static int rk3328_set_speed(struct rk_priv_data *bsp_priv,
 {
 	unsigned int reg;
 
-	if (interface == PHY_INTERFACE_MODE_RMII && bsp_priv->integrated_phy)
-		reg = RK3328_GRF_MAC_CON2;
-	else
-		reg = RK3328_GRF_MAC_CON1;
+	reg = bsp_priv->id ? RK3328_GRF_MAC_CON2 : RK3328_GRF_MAC_CON1;
 
 	return rk_set_reg_speed(bsp_priv, &rk3328_reg_speed_data, reg,
 				interface, speed);
@@ -614,6 +610,13 @@ static const struct rk_gmac_ops rk3328_ops = {
 	.set_speed = rk3328_set_speed,
 	.integrated_phy_powerup = rk3328_integrated_phy_powerup,
 	.integrated_phy_powerdown = rk_gmac_integrated_ephy_powerdown,
+
+	.regs_valid = true,
+	.regs = {
+		0xff540000, /* gmac2io */
+		0xff550000, /* gmac2phy */
+		0, /* sentinel */
+	},
 };
 
 #define RK3366_GRF_SOC_CON6	0x0418
-- 
2.47.3


