Return-Path: <netdev+bounces-252794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEHhNvtUc2kDuwAAu9opvQ
	(envelope-from <netdev+bounces-252794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:01:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B1174B2A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EA2A300E71C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C281298CD7;
	Fri, 23 Jan 2026 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Nrhya/4S"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD5A285C91
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166049; cv=none; b=fqKowKBvKHh5ssGjpIZ44Wh42ECX9vebQVlLCLTWeoTclX+EDNUD02JB4uRQikVFseiHv7VdWsBeCJ4/wU+ovlMFaoNMIw/cJgFQISEACLdw+5KLjwThQ61Ck1YfbdMJiGikr9LETkMc/v9jy7b2taMV5nhFbo/1rWPPZ7Fkdtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166049; c=relaxed/simple;
	bh=AamgvmZl2fyvdSA5H19jjS2gHg3GwMaItqCTf4zqTMs=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=eY5Suk0GcQqzVjaYcoczmahQXFpISXFGyMsZjc4m3zsgdWbkLuY0bku8ZR2YolSZRU1jYDkOBHbfbfvXM5nRtwv45xYE46rbOyGI3++IUmYASgc2TYlEovySW5WeJqdiNr1fcy+szMMWRSkD5oQKtpYyFubMc0qpreEypOYgxqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Nrhya/4S; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jVLFfVd3X1JU5vZWQqTSvIV4WWcbPJ1JZLcb+HxFgbA=; b=Nrhya/4SaAjCO5DqTlff+X/rgN
	Vr4HtO7KKm7srX/nwv0mIOlsF6hzUoDrQCt7NK2txSTHBCSSaUtqUfrP0ys1Rvzi4vg09CNZhFz9A
	MUacWBSgXCtpSzNZlwuq5znFofF03Dc5TPjlfCrBVZBMbH5f8dRt1tuO6met/q4Cb7meAWtcT1uZt
	SSOAbEGaNqL0rHJoOMV+aC2zIW1ZsoVxWB+ohUEhpLjZtdVwFw+szp9sXc1v1IK8iD8aIep7j8tnK
	GHsjz1RJe1Oiq9DH2T53n7zhX7bt3EkTC6iHiLfgQNZVMp3OBNnTeuL90irHeIDChzMBts+icTF0z
	43Wrjw8A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49826 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vjEu7-000000001nG-1aCz;
	Fri, 23 Jan 2026 11:00:39 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vjEu6-00000005gfw-0Y88;
	Fri, 23 Jan 2026 11:00:38 +0000
In-Reply-To: <aXNUlVZilT-CTgph@shell.armlinux.org.uk>
References: <aXNUlVZilT-CTgph@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 04/21] net: stmmac: rk: group MACPHY register offset
 and fields together
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vjEu6-00000005gfw-0Y88@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 23 Jan 2026 11:00:38 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252794-lists,netdev=lfdr.de,kernel];
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
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 49B1174B2A
X-Rspamd-Action: no action

Group the MACPHY register offsets and associated bitfields together
to become self-documenting which definitions are associated with
which register.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index c8b49ed2064a..5f8d2031b97c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -162,15 +162,17 @@ static int rk_set_clk_mac_speed(struct rk_priv_data *bsp_priv,
 	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE : soc##_GMAC_RXCLK_DLY_DISABLE))
 
 #define RK_GRF_MACPHY_CON0		0xb00
-#define RK_GRF_MACPHY_CON1		0xb04
-#define RK_GRF_MACPHY_CON2		0xb08
-#define RK_GRF_MACPHY_CON3		0xb0c
-
 #define RK_MACPHY_ENABLE		GRF_BIT(0)
 #define RK_MACPHY_DISABLE		GRF_CLR_BIT(0)
 #define RK_MACPHY_CFG_CLK_50M		GRF_BIT(14)
 #define RK_GMAC2PHY_RMII_MODE		GRF_FIELD(7, 6, 1)
+
+#define RK_GRF_MACPHY_CON1		0xb04
+
+#define RK_GRF_MACPHY_CON2		0xb08
 #define RK_GRF_CON2_MACPHY_ID		GRF_FIELD(15, 0, 0x1234)
+
+#define RK_GRF_MACPHY_CON3		0xb0c
 #define RK_GRF_CON3_MACPHY_ID		GRF_FIELD(5, 0, 0x35)
 
 static void rk_gmac_integrated_ephy_powerup(struct rk_priv_data *priv)
-- 
2.47.3


