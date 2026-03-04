Return-Path: <netdev+bounces-263664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPO3HyLzp2nImwAAu9opvQ
	(envelope-from <netdev+bounces-263664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:53:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAB31FCF94
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF01630EBF8D
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 08:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE6F388381;
	Wed,  4 Mar 2026 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QaFVmwJ0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCDB386C09;
	Wed,  4 Mar 2026 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614160; cv=none; b=V0/z/qa437Jy+735KXYuHMxNWAsRmKRl4aMlU+XRmy0dn1/h0McULaQvSQF63KfxZCKwOeImQ5d5LXyAScPd7m/C0yER1p8nqZaOScBIrItqs+jbDR8Q+Iyt9RKLvianCHGdVCAgDo2HQ8iXUDiJHdUlyWVYmkuBXUydAmkpuOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614160; c=relaxed/simple;
	bh=7YvOXmRPgCjucVGXE7lfff+GhC1gwEcdOrTqU0tff10=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=OGzn/2R6ojodQYM8wQWj2fWhjt99KUyXUoY0C2hQfA2Kz/nc6cw5J3FRhmt5vov5kUSTamNV2CKYO1nS6Y+tdDDVXINZBJhhI1wud8c7aaZEQYAIH1ZmCG7cW4Wt1t/Hlj+P5mg4q/k5iD+kpS2pKZnR8AUZDI838T+Nd8VY8N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QaFVmwJ0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mPNv9hhcPGysoUKhGKWvi6/JR95HuApgj93NiwVLo30=; b=QaFVmwJ0rLKZWeJISBupUy+xzq
	NqV45JCahkOeY0O8iRBuqVXKMBSCmSuz4Z0RCVPy+Mx9ZC/2KCy6MVlPjnUbs246m11qhCUR3jQro
	ELifSD9WB5IciVSxBDhLtCCsrmH7xwZySL4NXa035TyJjl8k8filS5dIX/ZerjvMfPpT1+nXoW8cH
	7peD/9ANzDqiF8NhvFwVN0RxVk8RNaO7ZBkZL3J2FiO7cyq3V7w71k+yc9YyzmqpJfkuTiPq1lBuV
	GkV22q7Px0imB3GFm5257RqU8ZQOjhklKjXKJ8yYe+e7ryGUc2ZB0kASK/3INo4rsW+G1luonIzFC
	hbwiZ9ig==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41158 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vxhuo-0000000069S-3qNv;
	Wed, 04 Mar 2026 08:49:10 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vxhuo-0000000BqGW-0YDF;
	Wed, 04 Mar 2026 08:49:10 +0000
In-Reply-To: <aafxqCvJ_XY4YbWw@shell.armlinux.org.uk>
References: <aafxqCvJ_XY4YbWw@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next v2 3/7] net: stmmac: use integrated PCS for
 BASE-X modes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vxhuo-0000000BqGW-0YDF@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 04 Mar 2026 08:49:10 +0000
X-Rspamd-Queue-Id: EAAB31FCF94
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263664-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.312];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Action: no action

dwmac-qcom-ethqos supports SGMII and 2500BASE-X using the integrated
PCS, so we need to expand the PCS support to include support for
BASE-X modes.

Add support to the prereset configuration to detect 2500BASE-X, and
arrange for stmmac_mac_select_pcs() to return the integrated PCS if
its supported_interfaces bitmap reports support for the interface mode.

This results in priv->hw->pcs now being write-only, so remove it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/common.h      | 4 ----
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 42a48f655849..91116acf3273 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -277,9 +277,6 @@ struct stmmac_safety_stats {
 #define FLOW_TX		2
 #define FLOW_AUTO	(FLOW_TX | FLOW_RX)
 
-/* PCS defines */
-#define STMMAC_PCS_SGMII	(1 << 1)
-
 #define SF_DMA_MODE 1		/* DMA STORE-AND-FORWARD Operation Mode */
 
 /* DMA HW feature register fields */
@@ -634,7 +631,6 @@ struct mac_device_info {
 	unsigned int unicast_filter_entries;
 	unsigned int mcast_bits_log2;
 	unsigned int rx_csum;
-	unsigned int pcs;
 	unsigned int num_vlan;
 	u32 vlan_filter[32];
 	bool vlan_fail_q_en;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 029e9b518160..2e7edc3e82f2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -945,11 +945,8 @@ static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
 			return pcs;
 	}
 
-	/* The PCS control register is only relevant for SGMII, TBI and RTBI
-	 * modes. We no longer support TBI or RTBI, so only configure this
-	 * register when operating in SGMII mode with the integrated PCS.
-	 */
-	if (priv->hw->pcs & STMMAC_PCS_SGMII && priv->integrated_pcs)
+	if (priv->integrated_pcs &&
+	    test_bit(interface, priv->integrated_pcs->pcs.supported_interfaces))
 		return &priv->integrated_pcs->pcs;
 
 	return NULL;
@@ -1208,7 +1205,6 @@ static void stmmac_check_pcs_mode(struct stmmac_priv *priv)
 
 	if (priv->dma_cap.pcs && interface == PHY_INTERFACE_MODE_SGMII) {
 		netdev_dbg(priv->dev, "PCS SGMII support enabled\n");
-		priv->hw->pcs = STMMAC_PCS_SGMII;
 
 		switch (speed) {
 		case SPEED_10:
-- 
2.47.3


