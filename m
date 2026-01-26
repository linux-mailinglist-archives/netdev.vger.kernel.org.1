Return-Path: <netdev+bounces-253454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCXyJDhVd2nMeAEAu9opvQ
	(envelope-from <netdev+bounces-253454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:51:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA97D87D7E
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 211D7301D05A
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F04331239;
	Mon, 26 Jan 2026 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="G9K9NzpC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647FE333452
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769428012; cv=none; b=WoYrHwof9L3fIQKl9fyb7ffq+YbLWzaQgMhPCM6GmDnhMcRFq+lM1VVuce93sfOaQQUlYrCC8nq+BG46N3xjTa3HHKuH95bc1fVObylrEh8oizqbDJ7Tu31TB6qKEYJC6eldvqskqNc9N8Mgvwd1lrJrKQf2fPbsmQekotoXEC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769428012; c=relaxed/simple;
	bh=8wIrPTRRZBVaPXUYJR2CMVnM06OMJVwH7vK3OX+S2M0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=VhJCsFBPWDHTIJdbEofYxer/iH1dd9y8V6RhVCNyjnJSBbpiGvBHQw2Ke68LpyEjnRgfW84ukO791dBz5vwLbJ4DTyQPD36lVrEHQWAAVZyfIs6Y0PCycZ4TuCzhx4yyGWpdx8FuCfrnl2+yJWuPXZfbRTw4A88Zw+XACoYqiOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=G9K9NzpC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5eDo/t9bIKMtTAaZO5ytczGAZFxRhOK77rokq94b9fQ=; b=G9K9NzpCyrjWBJHnJGemXb93As
	YzvGQ3pmbFEyD7NzBzTBzTxqewgwN6vfhEGqa8RSHFD2GwM8wHTrvCaAyxvmIz6jtuDpwJMd0Hvkx
	Kdp/eN0Hxwd46KEltn1AbidxBInjag/iolughbIOerIW6ZaFRuiZPTVeTjzSM4tofe4At+560hFu/
	ZMENy9TOYYuwH5KOmH2Kk3Zf0HVw+bdxPVpNZinB6AbPKo5+ThTFqlwchBm6BlVoTM8pPk7jnFkS+
	bLSIE375bHaVXjpQKt0dhgydiRq6g93rVW60j7JzhszCJwRG/31XTLGka+pCGwR/CAV7tGrMtKOiW
	iLIZ1A/Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38870 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vkL3K-000000004jM-0hGS;
	Mon, 26 Jan 2026 11:46:42 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vkL3I-00000005uu4-1n24;
	Mon, 26 Jan 2026 11:46:40 +0000
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
Subject: [PATCH net-next v2 20/22] net: stmmac: rk: rk3528: gmac0 only
 supports RMII
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vkL3I-00000005uu4-1n24@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 26 Jan 2026 11:46:40 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253454-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid,0.0.0.2:email]
X-Rspamd-Queue-Id: EA97D87D7E
X-Rspamd-Action: no action

RK3528 gmac0 dtsi contains:

                gmac0: ethernet@ffbd0000 {
                        phy-handle = <&rmii0_phy>;
                        phy-mode = "rmii";

                        mdio0: mdio {
                                rmii0_phy: ethernet-phy@2 {
                                        phy-is-integrated;
                                };
                        };
                };

This follows the same pattern as rk3328, where this gmac instance
only supports RMII. Disable RGMII in phylink's supported_interfaces
mask for this gmac instance.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index ae9df91a018d..26fc93854cb0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -728,6 +728,7 @@ static int rk3528_init(struct rk_priv_data *bsp_priv)
 	case 0:
 		bsp_priv->clock_grf_reg = RK3528_VO_GRF_GMAC_CON;
 		bsp_priv->clock.rmii_clk_sel_mask = BIT_U16(3);
+		bsp_priv->supports_rgmii = false;
 		return 0;
 
 	case 1:
-- 
2.47.3


