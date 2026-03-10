Return-Path: <netdev+bounces-266254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHiLCLZSsGmBiAIAu9opvQ
	(envelope-from <netdev+bounces-266254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:19:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AEA2556A3
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1671316A272
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470E13CF05A;
	Tue, 10 Mar 2026 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX8Qge1b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C393CF04C;
	Tue, 10 Mar 2026 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163131; cv=none; b=l6if3B+F90SlD3aTqK9ksjUD64TDsuSXJ3+3SCHQhqBFWKQeLJRxCWpd6rEe736JwmvzbkrL3c/0v/CLqNcjTrjBwK6ctoACdLG6MrvpH5VV8OIV4mh+78L8n0BnSXXdlzE3MKu+NtfoF0KZPi8K7gB8ZhSv58gHtFyqpZN0Nr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163131; c=relaxed/simple;
	bh=qXfofFT/trjhnPdhGlUBXmgmmTY9bSQeDk+832YPFio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psw88ZyK46yTT/9oypZRwAprCHuokB4U6nCmo7qC87zoH8/WG0CK6/hVZUAZAZrfK+ESKFLoPVU0D3It65MLcPWUhSTVnYi6oIoHvEo9WsPmUEEjgM6TXj5az8Ugh4WwhlI2YPcviFQJZ4WEb2dvjOvuIJECJb/aK0tUQ0D1bv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX8Qge1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701EAC19425;
	Tue, 10 Mar 2026 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773163130;
	bh=qXfofFT/trjhnPdhGlUBXmgmmTY9bSQeDk+832YPFio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PX8Qge1beJjFZZhJXX9r/RSuw2aszipZq/ZWwNu6D+XAYhHg3p1nWsHvYLky84HXH
	 yLx3kbsPRmdARnQqTfjnxuvHeoyd+kdL/ny2humwv1mpOjcIo2gxs1YKaBav0Vv757
	 Jsnvxrp9tvuF325WgLj6fa+r07/b1nVMZ4gvhYp6bds93Gfa46JuYv0SBwDHukiW8s
	 CN2VFVjNy6zz+6qLUI/+bNrDt0Opu8cuIf8qmtfm29GFw9UMd61XKgJlA7YvjdMycX
	 INboE/33ZuXKN+7TO8fFLCdPaE9wJw+8FVce802X2sBrZgnjZIIVANwnzm2qnF+9GF
	 Ictm9HdGF6HjQ==
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Ryan.Wanner@microchip.com
Subject: [PATCH net-next v3 01/10] net: macb: rename macb_default_usrio to at91_default_usrio as not all platforms have mii mode control in usrio
Date: Tue, 10 Mar 2026 17:17:08 +0000
Message-ID: <20260310-upwind-reborn-ff32b74ff6c3@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310-moneyless-dispense-7bce14b16388@spud>
References: <20260310-moneyless-dispense-7bce14b16388@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10810; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=EKLjoCWb4dd6fnjRibapsUL7p5viCWSXvbtWmX4ncIU=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkbgnRMjxVk3wlsjfp89Yf2hlkS8nf2yi4OP7S+gFXlu dXP3o6UjlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExkej3DX7EX3y6t2SeZd7qb Y4VMZvrRm49znS+zr5mxJ/En0K7fMgz/FD60Cdi9C9q1e/vUpYGKvNy7ZExMq4yWLAt/LrUoJuo RDwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 97AEA2556A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-266254-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,vger.kernel.org,lists.infradead.org,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:email]
X-Rspamd-Action: no action

From: Conor Dooley <conor.dooley@microchip.com>

Calling this structure macb_default_usrio is misleading, I believe, as
it implies that it should be used if your platform has nothing special
to do in usrio. Since usrio is platform dependent, the default here is
probably for each usrio to do nothing, with the macb documentation I
have access to prescribing no standard behaviour here. We noticed that
this was problematic because on mpfs, a bit that macb_default_usrio
sets to deal with the MII mode actually changes the source for the
tsu_clk to something with how the majority of mpfs devices are actually
configured!

Rename it to at91_default_usrio, since that's where the values actually
come from for these. I have no idea if any of the other platforms that
use the default actually copied at91's usrio configuration or if they
have usrio configurations where what the driver does has no impact.

Gate touching these bits behind a capability, like the clken refclock
usrio knob, so that platforms without the MII mode stuff can avoid
running this code.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb.h      |   1 +
 drivers/net/ethernet/cadence/macb_main.c | 108 +++++++++++++----------
 2 files changed, 63 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 87414a2ddf6e3..8cb0b3778ee9e 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -779,6 +779,7 @@
 #define MACB_CAPS_DMA_PTP			BIT(22)
 #define MACB_CAPS_RSC				BIT(23)
 #define MACB_CAPS_NO_LSO			BIT(24)
+#define MACB_CAPS_USRIO_HAS_MII			BIT(25)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5bc35f651ebd2..778d2115f66fc 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4613,13 +4613,15 @@ static int macb_init(struct platform_device *pdev)
 
 	if (!(bp->caps & MACB_CAPS_USRIO_DISABLED)) {
 		val = 0;
-		if (phy_interface_mode_is_rgmii(bp->phy_interface))
-			val = bp->usrio->rgmii;
-		else if (bp->phy_interface == PHY_INTERFACE_MODE_RMII &&
-			 (bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
-			val = bp->usrio->rmii;
-		else if (!(bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
-			val = bp->usrio->mii;
+		if (bp->caps & MACB_CAPS_USRIO_HAS_MII) {
+			if (phy_interface_mode_is_rgmii(bp->phy_interface))
+				val = bp->usrio->rgmii;
+			else if (bp->phy_interface == PHY_INTERFACE_MODE_RMII &&
+				 (bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
+				val = bp->usrio->rmii;
+			else if (!(bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
+				val = bp->usrio->mii;
+		}
 
 		if (bp->caps & MACB_CAPS_USRIO_HAS_CLKEN)
 			val |= bp->usrio->refclk;
@@ -4637,13 +4639,6 @@ static int macb_init(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct macb_usrio_config macb_default_usrio = {
-	.mii = MACB_BIT(MII),
-	.rmii = MACB_BIT(RMII),
-	.rgmii = GEM_BIT(RGMII),
-	.refclk = MACB_BIT(CLKEN),
-};
-
 #if defined(CONFIG_OF)
 /* 1518 rounded up */
 #define AT91ETHER_MAX_RBUFF_SZ	0x600
@@ -5218,6 +5213,13 @@ static int eyeq5_init(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct macb_usrio_config at91_default_usrio = {
+	.mii = MACB_BIT(MII),
+	.rmii = MACB_BIT(RMII),
+	.rgmii = GEM_BIT(RGMII),
+	.refclk = MACB_BIT(CLKEN),
+};
+
 static const struct macb_usrio_config sama7g5_usrio = {
 	.mii = 0,
 	.rmii = 1,
@@ -5228,104 +5230,114 @@ static const struct macb_usrio_config sama7g5_usrio = {
 
 static const struct macb_config fu540_c000_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
-		MACB_CAPS_GEM_HAS_PTP,
+		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.clk_init = fu540_c000_clk_init,
 	.init = fu540_c000_init,
 	.jumbo_max_len = 10240,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config at91sam9260_config = {
-	.caps = MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
+	.caps = MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
+		MACB_CAPS_USRIO_HAS_MII,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config sama5d3macb_config = {
 	.caps = MACB_CAPS_SG_DISABLED |
-		MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
+		MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
+		MACB_CAPS_USRIO_HAS_MII,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config pc302gem_config = {
-	.caps = MACB_CAPS_SG_DISABLED | MACB_CAPS_GIGABIT_MODE_AVAILABLE,
+	.caps = MACB_CAPS_SG_DISABLED | MACB_CAPS_GIGABIT_MODE_AVAILABLE |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config sama5d2_config = {
-	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_JUMBO,
+	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_JUMBO |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
 	.jumbo_max_len = 10240,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config sama5d29_config = {
-	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_GEM_HAS_PTP,
+	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_GEM_HAS_PTP |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config sama5d3_config = {
 	.caps = MACB_CAPS_SG_DISABLED | MACB_CAPS_GIGABIT_MODE_AVAILABLE |
-		MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_JUMBO,
+		MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_JUMBO |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
 	.jumbo_max_len = 10240,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config sama5d4_config = {
-	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
+	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 4,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config emac_config = {
-	.caps = MACB_CAPS_NEEDS_RSTONUBR | MACB_CAPS_MACB_IS_EMAC,
+	.caps = MACB_CAPS_NEEDS_RSTONUBR | MACB_CAPS_MACB_IS_EMAC |
+		MACB_CAPS_USRIO_HAS_MII,
 	.clk_init = at91ether_clk_init,
 	.init = at91ether_init,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config np4_config = {
 	.caps = MACB_CAPS_USRIO_DISABLED,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config zynqmp_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
 		MACB_CAPS_JUMBO |
-		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH,
+		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = init_reset_optional,
 	.jumbo_max_len = 10240,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config zynq_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_NO_GIGABIT_HALF |
-		MACB_CAPS_NEEDS_RSTONUBR,
+		MACB_CAPS_NEEDS_RSTONUBR |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config mpfs_config = {
@@ -5335,7 +5347,7 @@ static const struct macb_config mpfs_config = {
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = init_reset_optional,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 	.max_tx_length = 4040, /* Cadence Erratum 1686 */
 	.jumbo_max_len = 4040,
 };
@@ -5343,7 +5355,8 @@ static const struct macb_config mpfs_config = {
 static const struct macb_config sama7g5_gem_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_CLK_HW_CHG |
 		MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
-		MACB_CAPS_MIIONRGMII | MACB_CAPS_GEM_HAS_PTP,
+		MACB_CAPS_MIIONRGMII | MACB_CAPS_GEM_HAS_PTP |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
@@ -5353,7 +5366,8 @@ static const struct macb_config sama7g5_gem_config = {
 static const struct macb_config sama7g5_emac_config = {
 	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
 		MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_MIIONRGMII |
-		MACB_CAPS_GEM_HAS_PTP,
+		MACB_CAPS_GEM_HAS_PTP |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
@@ -5364,12 +5378,13 @@ static const struct macb_config versal_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
 		MACB_CAPS_NEED_TSUCLK | MACB_CAPS_QUEUE_DISABLE |
-		MACB_CAPS_QBV,
+		MACB_CAPS_QBV |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = init_reset_optional,
 	.jumbo_max_len = 10240,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config eyeq5_config = {
@@ -5380,17 +5395,18 @@ static const struct macb_config eyeq5_config = {
 	.clk_init = macb_clk_init,
 	.init = eyeq5_init,
 	.jumbo_max_len = 10240,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config raspberrypi_rp1_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_CLK_HW_CHG |
 		MACB_CAPS_JUMBO |
-		MACB_CAPS_GEM_HAS_PTP,
+		MACB_CAPS_GEM_HAS_PTP |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 	.jumbo_max_len = 10240,
 };
 
@@ -5431,7 +5447,7 @@ static const struct macb_config default_gem_config = {
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-	.usrio = &macb_default_usrio,
+	.usrio = NULL,
 	.jumbo_max_len = 10240,
 };
 
-- 
2.51.0


