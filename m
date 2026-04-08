Return-Path: <netdev+bounces-276379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL8eDqEf1mklBQgAu9opvQ
	(envelope-from <netdev+bounces-276379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:28:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB2E3B9E25
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2719F301AF7E
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 09:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B212033F370;
	Wed,  8 Apr 2026 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CYoTgO5+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0BB2DCF74
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775640447; cv=none; b=Rso3NmFM+HN3TMUD9mbg1LfnzpEm4f88qMcYCPHZtQ1WfulFrYZVgHwOxP7Wb4fFuWul18LqDBcTir0BdN+x9ZpXITxjm+u3kX+yaYgloIBCvHEfZSoDIUibwP431hMRnepnQ8olTCu+ptSu3OfWj5RK2SSDgYSQOXSVZYV0Yzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775640447; c=relaxed/simple;
	bh=uTvfl5q8mXcuy4HH0QC8P2V3S6wd/UywonY2WnHQf/A=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Sl7kaO45Zs2wh6903JuNnCaa6SPWbV4zYQKI9PAzQWymA0/raNyoiIw7r4Eanz2vkGO8iQSLohz1tljFy58WHn0p0XYY3GMaL3PDL+vEZPLKvXqDLDybm2uV4QxffmkCEQJvELzc3o1JLCBYDdCBJ4lo+lY+WYVPsXrPHr3UFYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CYoTgO5+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KZiSegeFsbX6rV73Xt8FKnLevjwV0lgeOtK47cPkIg0=; b=CYoTgO5+QDOiagpHtFAWN1UPNi
	NMGcLgOokDZZJAwfqyECQs8M0fChSr1K9zLmqyrw+rdqBH2nS3bU4FfoPmO9d2NqovuwGEqdfFtL3
	SZ7yT3LzdMEq7U/JYRa+zfD5B4n3NT/dS/V4+OjOfNjEPdxpWO8X80slDWvzmkyRh6DmkU79zgn/u
	eWZc2lYVOaxP/js+TdShgmRdlTXfYlutJsKi3cmZptASLiEkHw/28RLM6yGVsGQU+U4ST5POBzc30
	jP31Vu0ZPj+jh9ebjJq6Vks9q17RgabXWYVHBDmZap4QmrG6QLE7HwqMYkc4kkCQtkYPBySUQbB1M
	noF8szBw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35130 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1wAPBV-0000000022y-1HGJ;
	Wed, 08 Apr 2026 10:26:53 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1wAPBR-0000000F7ju-1fD9;
	Wed, 08 Apr 2026 10:26:49 +0100
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
Subject: [PATCH RFC net-next 02/10] net: stmmac: rename dev_id to userver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1wAPBR-0000000F7ju-1fD9@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 08 Apr 2026 10:26:49 +0100
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276379-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.153];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 9BB2E3B9E25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Synopsys Databook and several implementation TRMs identify bits
15:8 of the version register in dwmac v3.xx and v4.xx as "userver".
We even print its value with "User ID". Rather than using "dev_id",
use "userver" instead.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 3774af66db48..830ff816ab4f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -15,7 +15,7 @@
 
 struct stmmac_version {
 	u8 snpsver;
-	u8 dev_id;
+	u8 userver;
 };
 
 static void stmmac_get_version(struct stmmac_priv *priv,
@@ -26,7 +26,7 @@ static void stmmac_get_version(struct stmmac_priv *priv,
 	u32 version;
 
 	ver->snpsver = 0;
-	ver->dev_id = 0;
+	ver->userver = 0;
 
 	if (core_type == DWMAC_CORE_MAC100)
 		return;
@@ -48,7 +48,7 @@ static void stmmac_get_version(struct stmmac_priv *priv,
 
 	ver->snpsver = FIELD_GET(DWMAC_SNPSVER, version);
 	if (core_type == DWMAC_CORE_XGMAC)
-		ver->dev_id = FIELD_GET(DWMAC_USERVER, version);
+		ver->userver = FIELD_GET(DWMAC_USERVER, version);
 }
 
 static void stmmac_dwmac_mode_quirk(struct stmmac_priv *priv)
@@ -111,7 +111,7 @@ int stmmac_reset(struct stmmac_priv *priv)
 static const struct stmmac_hwif_entry {
 	enum dwmac_core_type core_type;
 	u32 min_snpsver;
-	u32 dev_id;
+	u32 userver;
 	const struct stmmac_regs_off regs;
 	const void *desc;
 	const void *dma;
@@ -247,7 +247,7 @@ static const struct stmmac_hwif_entry {
 	}, {
 		.core_type = DWMAC_CORE_XGMAC,
 		.min_snpsver = DWXGMAC_CORE_2_10,
-		.dev_id = DWXGMAC_ID,
+		.userver = DWXGMAC_ID,
 		.regs = {
 			.ptp_off = PTP_XGMAC_OFFSET,
 			.mmc_off = MMC_XGMAC_OFFSET,
@@ -269,7 +269,7 @@ static const struct stmmac_hwif_entry {
 	}, {
 		.core_type = DWMAC_CORE_XGMAC,
 		.min_snpsver = DWXLGMAC_CORE_2_00,
-		.dev_id = DWXLGMAC_ID,
+		.userver = DWXLGMAC_ID,
 		.regs = {
 			.ptp_off = PTP_XGMAC_OFFSET,
 			.mmc_off = MMC_XGMAC_OFFSET,
@@ -291,7 +291,7 @@ static const struct stmmac_hwif_entry {
 };
 
 static const struct stmmac_hwif_entry *
-stmmac_hwif_find(enum dwmac_core_type core_type, u8 snpsver, u8 dev_id)
+stmmac_hwif_find(enum dwmac_core_type core_type, u8 snpsver, u8 userver)
 {
 	const struct stmmac_hwif_entry *entry;
 	int i;
@@ -305,7 +305,7 @@ stmmac_hwif_find(enum dwmac_core_type core_type, u8 snpsver, u8 dev_id)
 		if (snpsver < entry->min_snpsver)
 			continue;
 		if (core_type == DWMAC_CORE_XGMAC &&
-		    dev_id != entry->dev_id)
+		    userver != entry->userver)
 			continue;
 
 		return entry;
@@ -358,7 +358,7 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 	/* Fallback to generic HW */
 
 	/* Use synopsys_id var because some setups can override this */
-	entry = stmmac_hwif_find(core_type, priv->synopsys_id, version.dev_id);
+	entry = stmmac_hwif_find(core_type, priv->synopsys_id, version.userver);
 	if (!entry) {
 		dev_err(priv->device,
 			"Failed to find HW IF (id=0x%x, gmac=%d/%d)\n",
-- 
2.47.3


