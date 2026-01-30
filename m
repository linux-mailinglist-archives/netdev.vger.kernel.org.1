Return-Path: <netdev+bounces-255114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Lw8HniSfGkQNwIAu9opvQ
	(envelope-from <netdev+bounces-255114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:14:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC21AB9EFB
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B71583029AEC
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D5C36AB5E;
	Fri, 30 Jan 2026 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XLn2PMdi"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA4A369997
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771440; cv=none; b=Ldwd+/IBYMdEclPSyjz3bW3tp1lXNVtyP6grdMQrukxlIyxN4p0u91HxUMNS2PE8YvQuD16A9YiddpOm8FUjCmzxHh7a/idwCGHyP0DG9TOcehM2c6Vgz1+2fJ/9hgMMavYi/pwABS1YUdbWV2Ecz3sv8lUF5kxCoREW9plnY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771440; c=relaxed/simple;
	bh=tClQ+ZwLWYLdF1dhuCopmoEHlTTnmemumWhu3GjzPVU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=tH/qzuTj/7CxuFvLbEBDFRfjusnDjzli3pe3V9fxkMIMPChh/pqZpP7eOE8+AWLx3tiuSWgouYGnbLHQJYkspm323polRMqXD1NTPQm8tFNlbCDbKSka3qaYUWczTtWrMIMi2BhoNg0TYMs92/wlVTemr3NYaTALXofGg2CIaGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XLn2PMdi; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v4gi2YgD2w94MRgiQaWAq9XvwH7eqEb9XXWGlDoe1as=; b=XLn2PMdiR32/63oMTm0s5r6+ae
	KG1HMhaHk3Ps1S4IDpICcVEfJqiVfbOt5tr4R5Nb7ynS8u5lv75WtwXBXNLPzCjcsPo4+wNWMhFKl
	DWfAtFxdAfIiYnA7+rN7Q23kCvtQ2Fd3TDOT2p7rLyoIpCEFRqm8J0gnfU6sQaXtqExYa2aj0C6fR
	6FmJBkxVXmxaDijfVjl/4BoGzppR/NYMKceIF+lHcQ6Epw1UUyzPG1KlyUtczS9R7dwuccwS+29Dk
	SDlnht/aE0l3qvD0WGbjtfX8KLtKnInRTfFXI25kCSW2cKAdTnkH6SqycZsy04bGoeSWww6T5++9X
	ptr2iJ5A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41182 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vlmOW-00000000138-0FDf;
	Fri, 30 Jan 2026 11:10:32 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vlmOV-00000006zv5-1CwO;
	Fri, 30 Jan 2026 11:10:31 +0000
In-Reply-To: <aXyRlFw7ZuhRPiKo@shell.armlinux.org.uk>
References: <aXyRlFw7ZuhRPiKo@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/3] net: stmmac: move most PCS register definitions
 to stmmac_pcs.c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vlmOV-00000006zv5-1CwO@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 30 Jan 2026 11:10:31 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255114-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC21AB9EFB
X-Rspamd-Action: no action

Move most of the PCS register offset definitions to stmmac_pcs.c.
Since stmmac_pcs.c only ever passes zero into the register offset
macros, remove that ability, making them simple constant integer
definitions.

Add appropriate descriptions of the registers, pointing out their
similarity with their IEEE 802.3 counterparts. Make use of the
BMSR definitions for the GMAC_AN_STATUS register and remove the
driver private versions.

Note that BMSR_LSTATUS is non-low-latching, unlike it's 802.3z
counterpart.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.c  | 22 +++++++++++++++----
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.h  | 22 -------------------
 2 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
index 2f826fe7229b..e827c03ae932 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
@@ -2,6 +2,20 @@
 #include "stmmac.h"
 #include "stmmac_pcs.h"
 
+/*
+ * GMAC_AN_STATUS is equivalent to MII_BMSR
+ * GMAC_ANE_ADV is equivalent to 802.3z MII_ADVERTISE
+ * GMAC_ANE_LPA is equivalent to 802.3z MII_LPA
+ * GMAC_ANE_EXP is equivalent to MII_EXPANSION
+ * GMAC_TBI is equivalent to MII_ESTATUS
+ *
+ * ADV, LPA and EXP are only available for the TBI and RTBI modes.
+ */
+#define GMAC_AN_STATUS	0x04	/* AN status */
+#define GMAC_ANE_ADV	0x08	/* ANE Advertisement */
+#define GMAC_ANE_LPA	0x0c	/* ANE link partener ability */
+#define GMAC_TBI	0x14	/* TBI extend status */
+
 static int dwmac_integrated_pcs_enable(struct phylink_pcs *pcs)
 {
 	struct stmmac_pcs *spcs = phylink_pcs_to_stmmac_pcs(pcs);
@@ -49,11 +63,11 @@ void stmmac_integrated_pcs_irq(struct stmmac_priv *priv, u32 status,
 			       struct stmmac_extra_stats *x)
 {
 	struct stmmac_pcs *spcs = priv->integrated_pcs;
-	u32 val = readl(spcs->base + GMAC_AN_STATUS(0));
+	u32 val = readl(spcs->base + GMAC_AN_STATUS);
 
 	if (status & PCS_ANE_IRQ) {
 		x->irq_pcs_ane_n++;
-		if (val & GMAC_AN_STATUS_ANC)
+		if (val & BMSR_ANEGCOMPLETE)
 			dev_info(priv->device,
 				 "PCS ANE process completed\n");
 	}
@@ -61,9 +75,9 @@ void stmmac_integrated_pcs_irq(struct stmmac_priv *priv, u32 status,
 	if (status & PCS_LINK_IRQ) {
 		x->irq_pcs_link_n++;
 		dev_info(priv->device, "PCS Link %s\n",
-			 val & GMAC_AN_STATUS_LS ? "Up" : "Down");
+			 val & BMSR_LSTATUS ? "Up" : "Down");
 
-		phylink_pcs_change(&spcs->pcs, val & GMAC_AN_STATUS_LS);
+		phylink_pcs_change(&spcs->pcs, val & BMSR_LSTATUS);
 	}
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index c4e6b242d390..13ee5bd6c788 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -16,13 +16,6 @@
 
 /* PCS registers (AN/TBI/SGMII/RGMII) offsets */
 #define GMAC_AN_CTRL(x)		(x)		/* AN control */
-#define GMAC_AN_STATUS(x)	(x + 0x4)	/* AN status */
-
-/* ADV, LPA and EXP are only available for the TBI and RTBI interfaces */
-#define GMAC_ANE_ADV(x)		(x + 0x8)	/* ANE Advertisement */
-#define GMAC_ANE_LPA(x)		(x + 0xc)	/* ANE link partener ability */
-#define GMAC_ANE_EXP(x)		(x + 0x10)	/* ANE expansion */
-#define GMAC_TBI(x)		(x + 0x14)	/* TBI extend status */
 
 /* AN Configuration defines */
 #define GMAC_AN_CTRL_RAN	BIT_U32(9)	/* Restart Auto-Negotiation */
@@ -32,21 +25,6 @@
 #define GMAC_AN_CTRL_LR		BIT_U32(17)	/* Lock to Reference */
 #define GMAC_AN_CTRL_SGMRAL	BIT_U32(18)	/* SGMII RAL Control */
 
-/* AN Status defines */
-#define GMAC_AN_STATUS_LS	BIT_U32(2)	/* Link Status 0:down 1:up */
-#define GMAC_AN_STATUS_ANA	BIT_U32(3)	/* Auto-Negotiation Ability */
-#define GMAC_AN_STATUS_ANC	BIT_U32(5)	/* Auto-Negotiation Complete */
-#define GMAC_AN_STATUS_ES	BIT_U32(8)	/* Extended Status */
-
-/* ADV and LPA defines */
-#define GMAC_ANE_FD		BIT_U32(5)
-#define GMAC_ANE_HD		BIT_U32(6)
-#define GMAC_ANE_PSE		GENMASK_U32(8, 7)
-#define GMAC_ANE_PSE_SHIFT	7
-#define GMAC_ANE_RFE		GENMASK_U32(13, 12)
-#define GMAC_ANE_RFE_SHIFT	12
-#define GMAC_ANE_ACK		BIT_U32(14)
-
 struct stmmac_priv;
 
 struct stmmac_pcs {
-- 
2.47.3


