Return-Path: <netdev+bounces-265118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHRmI60DrGkFjAEAu9opvQ
	(envelope-from <netdev+bounces-265118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 11:53:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 385BD22B342
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 11:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40B32301287F
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 10:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0172EFDAF;
	Sat,  7 Mar 2026 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PAJGbZzB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D219C2F0C79
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772880809; cv=none; b=aJ4IG2AjeDHCaAr9K5iT+eZ6LKo/6PISpSJtZiyuVdWl0PtZQowwnkV5sb5W2jSzETSyWPqcIYsbsGFlBr2UrRvJ9mtkUQm9RHkINnxJyVit/3pG4DrHzMrmYVJ2ZGovgaOS4SegtA3+8HkGz024gHV1EtprlsE0ABxckAn/ObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772880809; c=relaxed/simple;
	bh=9w9cwcPMOgEFDGejGbrp1T0JFPNYcy6kp4TZLoyys9Y=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=PUPBKeMoy2SdvBFCeS9XwgfZzxi7dtHKzaPSMaV7LgXLHUdBAaRkA0w6eMbXVSNysmD7+mRBhlyG928s33H1yPb4PAuWJeuSw0pWchAuXR256lNCYdL6vxP/9rMZC0iBZ6NDW5B0qoFn4XcZPktElD9bq/RfNDHA5DkpInprLm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PAJGbZzB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eZByVWOPK5ttZJFgRSm0Ifxd/gEF6TSQDdAxyvu8aiQ=; b=PAJGbZzB0YYtWulTCT7vwtolYD
	qGVLnWWhzgd+uf5R92VO5h/SSIC1q1wYcIw7Yy7zbYlwJZEZrXdNN3sulnyUJA78NqrOSKKT+wJxt
	S/6dA0MEqaLnDp0BcpmOpFcIfaZRr35dK51eZ1WZ8UnTt2Wy0PDhBrsxa8ojuEviAOF8B8IpydRGM
	nXww/9+GiZVg/aJKw5sCQeuUvIfHFJ6yv9+H57Jeax/9nNXEzTck6FppJ3+AfKW/4mb6pd6wUZ5qH
	7x0xzFEKFFDiDZFeph0SVzpZe1RzLGZqnjHcmrdwb5ztPpMZ5XcAJOuaiPw5cEgPeWe/aefvdDJqP
	HNBDKC9Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34482 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vypHd-00000000258-0hEc;
	Sat, 07 Mar 2026 10:53:21 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vypHc-0000000CSbl-1X6v;
	Sat, 07 Mar 2026 10:53:20 +0000
In-Reply-To: <aawDiK7DjcSXSs1X@shell.armlinux.org.uk>
References: <aawDiK7DjcSXSs1X@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 2/2] net: stmmac: ptp: remove redundant
 priv->pps[].available
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vypHc-0000000CSbl-1X6v@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 07 Mar 2026 10:53:20 +0000
X-Rspamd-Queue-Id: 385BD22B342
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265118-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.264];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Action: no action

priv->pps[].available is set in stmmac_ptp_register() for all PPS
outputs reported by hardware up to STMMAC_PPS_MAX.

Since we now set priv->ptp_clock_ops.n_per_out to the number of PPS
outputs that both the hardware and driver can support to prevent
array overflow in stmmac_enable(), this makes priv->pps[].available
redundant. Remove this struct member.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c        | 2 --
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 2 --
 drivers/net/ethernet/stmicro/stmmac/stmmac.h        | 1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c    | 4 ----
 4 files changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index 1c431b918719..f1bb981cab7c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -525,8 +525,6 @@ int dwmac5_flex_pps_config(void __iomem *ioaddr, int index,
 	u32 val = readl(ioaddr + MAC_PPS_CONTROL);
 	u64 period;
 
-	if (!cfg->available)
-		return -EINVAL;
 	if (tnsec & TRGTBUSY0)
 		return -EBUSY;
 	if (!sub_second_inc || !systime_flags)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 915e7c2ab11f..efa76b147f9e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1162,8 +1162,6 @@ static int dwxgmac2_flex_pps_config(void __iomem *ioaddr, int index,
 	u32 val = readl(ioaddr + XGMAC_PPS_CONTROL);
 	u64 period;
 
-	if (!cfg->available)
-		return -EINVAL;
 	if (tnsec & XGMAC_TRGTBUSY0)
 		return -EBUSY;
 	if (!sub_second_inc || !systime_flags)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 1fe96cd24b4f..335e60439b42 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -181,7 +181,6 @@ struct stmmac_tc_entry {
 
 #define STMMAC_PPS_MAX		4
 struct stmmac_pps_cfg {
-	bool available;
 	struct timespec64 start;
 	struct timespec64 period;
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 654d04f8c373..960249960004 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -336,7 +336,6 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 {
 	unsigned int pps_out_num = priv->dma_cap.pps_out_num;
 	unsigned int n_ext_ts;
-	int i;
 
 	if (pps_out_num > STMMAC_PPS_MAX) {
 		dev_warn(priv->device,
@@ -345,9 +344,6 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 		pps_out_num = STMMAC_PPS_MAX;
 	}
 
-	for (i = 0; i < pps_out_num; i++)
-		priv->pps[i].available = true;
-
 	/* Calculate the clock domain crossing (CDC) error if necessary */
 	priv->plat->cdc_error_adj = 0;
 	if (priv->plat->core_type == DWMAC_CORE_GMAC4)
-- 
2.47.3


