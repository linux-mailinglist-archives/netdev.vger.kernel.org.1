Return-Path: <netdev+bounces-263733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WH0HChsJqGnSnQAAu9opvQ
	(envelope-from <netdev+bounces-263733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:27:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F771FE53B
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 751C6313A38E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA813A254F;
	Wed,  4 Mar 2026 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ntz0aA9h"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A701F3A0EAB
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619791; cv=none; b=PxSKqS6krVj9AxQYGknS+AKGiquaXfOC3DBmmA90jg/CfjCs3nYMHU7vJyrGzp48EL/mr1dE62mTg9LRk596Onj4Wh7aK/f/Iye4L3iqkDfTk896dwZbnPaqJHICXZr/ghNjwPqhEDAZTxf39/p9EyOHDU0GeKGo/RlNIYYt41k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619791; c=relaxed/simple;
	bh=fzMT9a10aDVr4NgGA+zak+pM8uZrheT0J0ztMX8ClXo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=kzET8s2kSikHzSdx7NS4U45psiFsozqvHya9BMHrGCR7m+gWCUZs0++FVEUIYN72fXSh/LrrBce+5E/6HiC0lExBSEqvMRMnnw4orXuViKu1RBYIwNtOvPJqKgsjFYIxamU+NvGnNDgwQ77DV/SwvstCwclGCXH+vrzPNXFsa0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Ntz0aA9h; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nXZyqgN8dMCgcgZFM/zLAXjQCHFSgvYmx6oyb7xGPsI=; b=Ntz0aA9hDXehiUljdaE/FTV8eE
	ikTXukJMtrzmZT1NxS9mhUKJpYwyYWXAJyPMImBPI4lteP66Wk7jyfhaRBPsZEOBDz8tsMUn3O8XY
	zvj7dc/D3JZ9io5QxF+bp7RQnNpTftGG3vIx5LM+gJ7dMXkW5tbkjH7lRoDbwA6QNTHWIGxFz2NB6
	Xt5lJqFA1pUPAke6vm5uTuI0h1yg6C0sf2j32VyBb3yTotJoqZGK15giUfme/OXa6YF2IYbwfNSH5
	PQyrbmulnwnd80mhOEW/0NTUYLvdRn31hXzRnDsxeFHEkLZAJx5Nco3em7Uga2m5q/SydgfA/eDhC
	Uy3Uh+7A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37564 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vxjNa-000000006MO-311g;
	Wed, 04 Mar 2026 10:22:58 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vxjNZ-0000000Br1Q-1J2B;
	Wed, 04 Mar 2026 10:22:57 +0000
In-Reply-To: <aagH023pvswd0tlT@shell.armlinux.org.uk>
References: <aagH023pvswd0tlT@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen-Yu Tsai <wens@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH net-next 6/8] net: stmmac: use GENMASK_U32() for mdio
 bitfields
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vxjNZ-0000000Br1Q-1J2B@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 04 Mar 2026 10:22:57 +0000
X-Rspamd-Queue-Id: 95F771FE53B
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
	TAGGED_FROM(0.00)[bounces-263733-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.148];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Action: no action

Rather than using hex numbers, use GENMASK() for mdio bitfields.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index a6f8e78856aa..b913fe5af488 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -367,8 +367,8 @@ static int loongson_dwmac_setup(void *apriv, struct mac_device_info *mac)
 	mac->link.speed_mask = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
 	mac->mii.addr = GMAC_MII_ADDR;
 	mac->mii.data = GMAC_MII_DATA;
-	mac->mii.addr_mask = 0x0000F800;
-	mac->mii.reg_mask = 0x000007C0;
+	mac->mii.addr_mask = GENMASK_U32(15, 11);
+	mac->mii.reg_mask = GENMASK_U32(10, 6);
 	mac->mii.clk_csr_mask = GENMASK_U32(5, 2);
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 4ea55be04c5c..c7cb30672604 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -496,8 +496,8 @@ int dwmac1000_setup(struct stmmac_priv *priv)
 	mac->link.speed_mask = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
 	mac->mii.addr = GMAC_MII_ADDR;
 	mac->mii.data = GMAC_MII_DATA;
-	mac->mii.addr_mask = 0x0000F800;
-	mac->mii.reg_mask = 0x000007C0;
+	mac->mii.addr_mask = GENMASK_U32(15, 11);
+	mac->mii.reg_mask = GENMASK_U32(10, 6);
 	mac->mii.clk_csr_mask = GENMASK_U32(5, 2);
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
index 7c91ea2775d4..6b5cf3a0866a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
@@ -184,8 +184,8 @@ int dwmac100_setup(struct stmmac_priv *priv)
 	mac->link.speed_mask = MAC_CONTROL_PS;
 	mac->mii.addr = MAC_MII_ADDR;
 	mac->mii.data = MAC_MII_DATA;
-	mac->mii.addr_mask = 0x0000F800;
-	mac->mii.reg_mask = 0x000007C0;
+	mac->mii.addr_mask = GENMASK_U32(15, 11);
+	mac->mii.reg_mask = GENMASK_U32(10, 6);
 	mac->mii.clk_csr_mask = GENMASK_U32(5, 2);
 
 	return 0;
-- 
2.47.3


