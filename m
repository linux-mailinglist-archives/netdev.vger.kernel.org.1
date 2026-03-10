Return-Path: <netdev+bounces-266255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFxXGrNSsGmBiAIAu9opvQ
	(envelope-from <netdev+bounces-266255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:19:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CC7255695
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16CDE3091C90
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1EB3D0901;
	Tue, 10 Mar 2026 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPnAXDVd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E6E2D877A;
	Tue, 10 Mar 2026 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163136; cv=none; b=GCsYr78hK2MKBuTspfNr8E4z9gxm7tpHhPASqGjTiyv0kZJDvmpSdsgDNQjlz25kWNJdiowuTRQGaZs62XYPVbpss5HS6X5z0+dQXuE7B5Mq4N9bc0xA23A1lloiBSCBWkr8NOu1QmtmBYBK6pJBO/7dZlKbgniQsQ91lDKe+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163136; c=relaxed/simple;
	bh=5Jkuep/vLlDigVeWmTs/DhOngIlPtkb5pESGRVTgEIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kqh4MB61xibk9S723GM5/mzd4753gICu6xI/JYPM7dehfDo/AgaXMbfQeTwqRd7E9BUxovqzCgiHMWohb1oTnxrAbDshNhNLMyRzW/fTT5/mgslkwsQN/C2vg1327CyZdvbUlLlo8bsIftsX4EpETJQqV2XpTxu+P+z1n5n4kuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPnAXDVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D13C19423;
	Tue, 10 Mar 2026 17:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773163136;
	bh=5Jkuep/vLlDigVeWmTs/DhOngIlPtkb5pESGRVTgEIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pPnAXDVdJoTPpBTkapU2A3TIBE2FUFpy0bw/IRWPFMvV9/XT+e6GPf/agr63hluW5
	 11Bcyy2WRQZOBhLFOFL6ZbUdXTZDtlh9BlKMVv70nFXhasoSvmfruYKvA1aC5fvXcy
	 EWJPVxMBgle+4eN7RvgLGLuW7y5juM/of87hIYRjlvXnzaT0spIyQSySTaByU6co/7
	 Cdgx1Q8fHUpPzYc1QOCkfx6/ksIuucwkjGYICvFHYQlbQDbi0kTesjuzbVL/npJd8O
	 NpNrF4qo9GJmSTVPrWcDj/VkZlC2AvA+ax/9G82JOEAdBa4fw3G+If9MbYzYCs+aFf
	 fmn6nWZdUa3yA==
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
Subject: [PATCH net-next v3 02/10] net: macb: split USRIO_HAS_CLKEN capability in two
Date: Tue, 10 Mar 2026 17:17:09 +0000
Message-ID: <20260310-pushiness-twentieth-8b6ba59bf8c9@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310-moneyless-dispense-7bce14b16388@spud>
References: <20260310-moneyless-dispense-7bce14b16388@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3502; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=TDcEt4gO7nw+FrU/aV4qA0N2hA+cJ3rWCHECrYVPXVw=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkbgnT3mFyeb1rdtnTi+8fcsepllveShO3a/z9nWrfkQ dD8mos2HaUsDGJcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZgIUxcjQ7duoMZzgRm3Hxmn 9G+SFJrZxqx9Xl1y0qq9qq9yqo+Jf2b4nyoSPO++YjHrWq6u49pBveYmS2SelG9cbnjq8Hn+GJ0 1fAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 02CC7255695
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-266255-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Conor Dooley <conor.dooley@microchip.com>

While trying to rework the internal/external refclk selection on
sama7g5, Ryan and I noticed that the sama7g5 was "overloading" the
meaning of MACB_CAPS_USRIO_HAS_CLKEN, using it differently to how it was
originally intended.
Originally, on the macb hardware on sam9620 et al,
MACB_CAPS_USRIO_HAS_CLKEN represented the hardware having a bit that
needed to be set to turn on the input clock to the transceivers. The
sama7g5 doesn't have this bit, so for some reason the decision was made
to reuse this capability flag to control selection of internal/external
references.

Split the caps in two, so that capabilities do what they say on the tin,
and allow reworking the refclk selection handling without impacting the
older devices that use MACB_CAPS_USRIO_CLKEN for its original purpose.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb.h      |  2 ++
 drivers/net/ethernet/cadence/macb_main.c | 11 ++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 8cb0b3778ee9e..baf48f02d7e27 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -780,6 +780,7 @@
 #define MACB_CAPS_RSC				BIT(23)
 #define MACB_CAPS_NO_LSO			BIT(24)
 #define MACB_CAPS_USRIO_HAS_MII			BIT(25)
+#define MACB_CAPS_USRIO_HAS_REFCLK_SOURCE	BIT(26)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
@@ -1211,6 +1212,7 @@ struct macb_usrio_config {
 	u32 rmii;
 	u32 rgmii;
 	u32 refclk;
+	u32 clken;
 	u32 hdfctlen;
 };
 
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 778d2115f66fc..d908850c59498 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4357,7 +4357,7 @@ static void macb_configure_caps(struct macb *bp,
 	}
 
 	if (refclk_ext)
-		bp->caps |= MACB_CAPS_USRIO_HAS_CLKEN;
+		bp->caps |= MACB_CAPS_USRIO_HAS_REFCLK_SOURCE;
 
 	dev_dbg(&bp->pdev->dev, "Cadence caps 0x%08x\n", bp->caps);
 }
@@ -4624,6 +4624,9 @@ static int macb_init(struct platform_device *pdev)
 		}
 
 		if (bp->caps & MACB_CAPS_USRIO_HAS_CLKEN)
+			val |= bp->usrio->clken;
+
+		if (bp->caps & MACB_CAPS_USRIO_HAS_REFCLK_SOURCE)
 			val |= bp->usrio->refclk;
 
 		macb_or_gem_writel(bp, USRIO, val);
@@ -5217,7 +5220,7 @@ static const struct macb_usrio_config at91_default_usrio = {
 	.mii = MACB_BIT(MII),
 	.rmii = MACB_BIT(RMII),
 	.rgmii = GEM_BIT(RGMII),
-	.refclk = MACB_BIT(CLKEN),
+	.clken = MACB_BIT(CLKEN),
 };
 
 static const struct macb_usrio_config sama7g5_usrio = {
@@ -5355,6 +5358,7 @@ static const struct macb_config mpfs_config = {
 static const struct macb_config sama7g5_gem_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_CLK_HW_CHG |
 		MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
+		MACB_CAPS_USRIO_HAS_REFCLK_SOURCE |
 		MACB_CAPS_MIIONRGMII | MACB_CAPS_GEM_HAS_PTP |
 		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
@@ -5365,7 +5369,8 @@ static const struct macb_config sama7g5_gem_config = {
 
 static const struct macb_config sama7g5_emac_config = {
 	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
-		MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_MIIONRGMII |
+		MACB_CAPS_MIIONRGMII |
+		MACB_CAPS_USRIO_HAS_REFCLK_SOURCE |
 		MACB_CAPS_GEM_HAS_PTP |
 		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
-- 
2.51.0


