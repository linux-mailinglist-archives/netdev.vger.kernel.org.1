Return-Path: <netdev+bounces-276378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNWQE4wf1mklBQgAu9opvQ
	(envelope-from <netdev+bounces-276378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:27:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF23B3B9E00
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA2E6300E271
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A183AE715;
	Wed,  8 Apr 2026 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lSwyiH4l"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6D2396B8B
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775640435; cv=none; b=uBJfTlC9xS1Mc5K5kCz7kgtqX2Kesf8CElal858bMDCFrwhkZtXt+P/LSCYYMkqkB1V6Q3cH+p5qjglCDeyiT8EY3t0ptAmbOINL7EyUMMyn2t6h2mekIWuJb4SOv+P0b5mKZRwGE/D2fvtlE/KBHbR3gX9aMZAdCMYbCz7y2fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775640435; c=relaxed/simple;
	bh=QD1hmmO1cyoUsUck2QKM+8wErs8ZaoXgtPVgG8mgXv4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=pJCIDQCEvzSB1kLkpEGR8cz84/b84nXOT96jDNCZsjxz6AvMgnkvwkmBEb1cUcMQPsMoCCZ2weuOYeU6eQwe4GUlFX5Ztb8dTZRhpM3qG1+STL62OYoFpSVgkEJQ2zqsbOpIxjrJtZMOKecNoyotRQbvpld/qburejuDIpxCMdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lSwyiH4l; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MVPIQsgXNzDIVzZb7L4g65zcVReNq7T7sAr8ZW6erb4=; b=lSwyiH4lcPtm2ZaH5eI5HlAO4j
	8x582wyp8D0+XiaTrgjbVdhKPS+I/aI+ellLhqKBMuvKPmvbc3c6hM1NhY24L6yar8Pt+dRR8zHl6
	DaP4FdBByBXZIeCuNvJrt42X/X7xnJ+WVslyhAPHWFn8F3KSJLoSY+pu8WsREw2koXVAVHpZSghyh
	ukm5CKPeWhfpMelT7osVZEuTeImtypXKdaQ4BYtJ/qnc/wR21WAFR9QqisQU20CUDd6dcjBb2liJ6
	TfLo3byg3vwDEkDR+A9P/TrHsxtOxfJmr3m7zqld2YjCnkL/eXG3uXvTg0jOGBaYV02YDgfxsbN3J
	d6R3eC9Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39662 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1wAPBN-0000000022o-13aq;
	Wed, 08 Apr 2026 10:26:45 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1wAPBM-0000000F7jo-1DIY;
	Wed, 08 Apr 2026 10:26:44 +0100
In-Reply-To: <adYfPBHsXxQUsMyr@shell.armlinux.org.uk>
References: <adYfPBHsXxQUsMyr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen-Yu Tsai <wens@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH RFC net-next 01/10] net: stmmac: rename min_id to min_snpsver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1wAPBM-0000000F7jo-1DIY@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 08 Apr 2026 10:26:44 +0100
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276378-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.247];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: BF23B3B9E00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

min_id is the minimum Synopsys IP version that the hwif entry will
match. Name it min_snpsver so that it's clear which part of the
version ID it is related to.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 511b0fd5e834..3774af66db48 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -110,7 +110,7 @@ int stmmac_reset(struct stmmac_priv *priv)
 
 static const struct stmmac_hwif_entry {
 	enum dwmac_core_type core_type;
-	u32 min_id;
+	u32 min_snpsver;
 	u32 dev_id;
 	const struct stmmac_regs_off regs;
 	const void *desc;
@@ -129,7 +129,7 @@ static const struct stmmac_hwif_entry {
 	/* NOTE: New HW versions shall go to the end of this table */
 	{
 		.core_type = DWMAC_CORE_MAC100,
-		.min_id = 0,
+		.min_snpsver = 0,
 		.regs = {
 			.ptp_off = PTP_GMAC3_X_OFFSET,
 			.mmc_off = MMC_GMAC3_X_OFFSET,
@@ -146,7 +146,7 @@ static const struct stmmac_hwif_entry {
 		.quirks = stmmac_dwmac1_quirks,
 	}, {
 		.core_type = DWMAC_CORE_GMAC,
-		.min_id = 0,
+		.min_snpsver = 0,
 		.regs = {
 			.ptp_off = PTP_GMAC3_X_OFFSET,
 			.mmc_off = MMC_GMAC3_X_OFFSET,
@@ -163,7 +163,7 @@ static const struct stmmac_hwif_entry {
 		.quirks = stmmac_dwmac1_quirks,
 	}, {
 		.core_type = DWMAC_CORE_GMAC4,
-		.min_id = 0,
+		.min_snpsver = 0,
 		.regs = {
 			.ptp_off = PTP_GMAC4_OFFSET,
 			.mmc_off = MMC_GMAC4_OFFSET,
@@ -183,7 +183,7 @@ static const struct stmmac_hwif_entry {
 		.quirks = stmmac_dwmac4_quirks,
 	}, {
 		.core_type = DWMAC_CORE_GMAC4,
-		.min_id = DWMAC_CORE_4_00,
+		.min_snpsver = DWMAC_CORE_4_00,
 		.regs = {
 			.ptp_off = PTP_GMAC4_OFFSET,
 			.mmc_off = MMC_GMAC4_OFFSET,
@@ -204,7 +204,7 @@ static const struct stmmac_hwif_entry {
 		.quirks = NULL,
 	}, {
 		.core_type = DWMAC_CORE_GMAC4,
-		.min_id = DWMAC_CORE_4_10,
+		.min_snpsver = DWMAC_CORE_4_10,
 		.regs = {
 			.ptp_off = PTP_GMAC4_OFFSET,
 			.mmc_off = MMC_GMAC4_OFFSET,
@@ -225,7 +225,7 @@ static const struct stmmac_hwif_entry {
 		.quirks = NULL,
 	}, {
 		.core_type = DWMAC_CORE_GMAC4,
-		.min_id = DWMAC_CORE_5_10,
+		.min_snpsver = DWMAC_CORE_5_10,
 		.regs = {
 			.ptp_off = PTP_GMAC4_OFFSET,
 			.mmc_off = MMC_GMAC4_OFFSET,
@@ -246,7 +246,7 @@ static const struct stmmac_hwif_entry {
 		.quirks = NULL,
 	}, {
 		.core_type = DWMAC_CORE_XGMAC,
-		.min_id = DWXGMAC_CORE_2_10,
+		.min_snpsver = DWXGMAC_CORE_2_10,
 		.dev_id = DWXGMAC_ID,
 		.regs = {
 			.ptp_off = PTP_XGMAC_OFFSET,
@@ -268,7 +268,7 @@ static const struct stmmac_hwif_entry {
 		.quirks = NULL,
 	}, {
 		.core_type = DWMAC_CORE_XGMAC,
-		.min_id = DWXLGMAC_CORE_2_00,
+		.min_snpsver = DWXLGMAC_CORE_2_00,
 		.dev_id = DWXLGMAC_ID,
 		.regs = {
 			.ptp_off = PTP_XGMAC_OFFSET,
@@ -302,7 +302,7 @@ stmmac_hwif_find(enum dwmac_core_type core_type, u8 snpsver, u8 dev_id)
 		if (core_type != entry->core_type)
 			continue;
 		/* Use synopsys_id var because some setups can override this */
-		if (snpsver < entry->min_id)
+		if (snpsver < entry->min_snpsver)
 			continue;
 		if (core_type == DWMAC_CORE_XGMAC &&
 		    dev_id != entry->dev_id)
-- 
2.47.3


