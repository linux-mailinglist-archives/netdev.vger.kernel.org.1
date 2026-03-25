Return-Path: <netdev+bounces-271644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJa2IBYPxGk+vgQAu9opvQ
	(envelope-from <netdev+bounces-271644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:36:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C96FB329230
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6FCF330625E0
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C3E3F99D1;
	Wed, 25 Mar 2026 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvZ5jh0B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414DB3F7874;
	Wed, 25 Mar 2026 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456148; cv=none; b=QRJfPAA8o9fUtTCzJo8kT0/0c+nZlAboaE2y/iv9twGY2arohehRmhccRUzsVMz6k4AN+3+ghMNs9dzXlKs7y8mDVxwNABwTeTIA4wI6ryDQI9ONYXcuiljBaj4u8CjrV755VwJ/LcJ1bU5QEs28IAz9VVtdWhnC65l/MxHngkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456148; c=relaxed/simple;
	bh=jyd3EFZzWSq4QB4qpE3EwZc6Fw6cuxDBKBxVJfFLpk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDldmqoQxGrNUVBJu0WzMpa9eLiZFEmeEVu6BV1EMkNhVA/+mUtp2pwMNFelen+hbys4hKMNNRtB66e19mcdvlgWCVT7Ws397nrDnp0JHHQWzp63zQflcpHsLMd5hXy6JOgPwKZSqZPfT34feNiMngFWKlT0hwdiFcmNM3E0M78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvZ5jh0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCF8C2BCB0;
	Wed, 25 Mar 2026 16:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456147;
	bh=jyd3EFZzWSq4QB4qpE3EwZc6Fw6cuxDBKBxVJfFLpk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvZ5jh0BGnUEeFwkk64qIx3GOzxT0Br3un3UhzHl+r3XrNZeGvzgcprDDeTYjGOR7
	 KMDYJyEOPM7e/Ib2nQbtdUjhxNAzVNBf9Zg6+pIZl4irJT7uJFxCUQ+N72JheyOWjS
	 5bHdJZNnCWWiwOQUqKXJFDMVPulSjYKtS7XF3284u5Mn0AvIoWm6e4xLgZbV0vsF8/
	 JyhhGnO8YKrq6tfc47NzPV3ssVx2ESzuw9VosqKydA8wzrXXf+eYK2mfs4fEQ4cCIf
	 m1npXKp/dKWy/PsbllZ6WHhjEdbA3gabWWQzmROUt/ABORLKKQJ2Gx/+fmFuRKygqc
	 tvb0X2zhy/UUg==
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
	Ryan.Wanner@microchip.com,
	Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net-next v5 03/14] net: macb: split USRIO_HAS_CLKEN capability in two
Date: Wed, 25 Mar 2026 16:28:07 +0000
Message-ID: <20260325-gradient-grading-b23b9e6ef9ff@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325-unsterile-flail-4c7729750dc4@spud>
References: <20260325-unsterile-flail-4c7729750dc4@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3507; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=jDBDApYWtlPJyWp/8XUU5y95F7rynxZ3GbEw8hdT/gY=; b=kA0DAAoWeLQxh6CCYtIByyZiAGnEDTWjcD1cQB+gKRpx1v8lFcVSElEwiP5f9w7ghpL2Y9vtI oh1BAAWCgAdFiEEYduOhBqv/ES4Q4zteLQxh6CCYtIFAmnEDTUACgkQeLQxh6CCYtIR3gD+LNNo UTkPW2l91njGiMcn9mI4r3Qf4wA4qvUJQ5hRiToBAIotn7RZKqq67pLpyIM7GHwWTu+SOAwdu/x OexFpvkcP
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-271644-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: C96FB329230
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 32217de5e0730..35b7129d7c1ee 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -787,6 +787,7 @@
 #define MACB_CAPS_NO_LSO			BIT(24)
 #define MACB_CAPS_EEE				BIT(25)
 #define MACB_CAPS_USRIO_HAS_MII			BIT(26)
+#define MACB_CAPS_USRIO_HAS_REFCLK_SOURCE	BIT(27)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
@@ -1226,6 +1227,7 @@ struct macb_usrio_config {
 	u32 rmii;
 	u32 rgmii;
 	u32 refclk;
+	u32 clken;
 	u32 hdfctlen;
 };
 
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 05a2df6e3e41d..859d03502666a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4615,7 +4615,7 @@ static void macb_configure_caps(struct macb *bp,
 	}
 
 	if (refclk_ext)
-		bp->caps |= MACB_CAPS_USRIO_HAS_CLKEN;
+		bp->caps |= MACB_CAPS_USRIO_HAS_REFCLK_SOURCE;
 
 	dev_dbg(&bp->pdev->dev, "Cadence caps 0x%08x\n", bp->caps);
 }
@@ -4895,6 +4895,9 @@ static int macb_init_dflt(struct platform_device *pdev)
 		}
 
 		if (bp->caps & MACB_CAPS_USRIO_HAS_CLKEN)
+			val |= bp->usrio->clken;
+
+		if (bp->caps & MACB_CAPS_USRIO_HAS_REFCLK_SOURCE)
 			val |= bp->usrio->refclk;
 
 		macb_or_gem_writel(bp, USRIO, val);
@@ -5497,7 +5500,7 @@ static const struct macb_usrio_config at91_default_usrio = {
 	.mii = MACB_BIT(MII),
 	.rmii = MACB_BIT(RMII),
 	.rgmii = GEM_BIT(RGMII),
-	.refclk = MACB_BIT(CLKEN),
+	.clken = MACB_BIT(CLKEN),
 };
 
 static const struct macb_usrio_config sama7g5_usrio = {
@@ -5615,6 +5618,7 @@ static const struct macb_config mpfs_config = {
 static const struct macb_config sama7g5_gem_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_CLK_HW_CHG |
 		MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
+		MACB_CAPS_USRIO_HAS_REFCLK_SOURCE |
 		MACB_CAPS_MIIONRGMII | MACB_CAPS_GEM_HAS_PTP |
 		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
@@ -5623,7 +5627,8 @@ static const struct macb_config sama7g5_gem_config = {
 
 static const struct macb_config sama7g5_emac_config = {
 	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
-		MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_MIIONRGMII |
+		MACB_CAPS_MIIONRGMII |
+		MACB_CAPS_USRIO_HAS_REFCLK_SOURCE |
 		MACB_CAPS_GEM_HAS_PTP |
 		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
-- 
2.53.0


