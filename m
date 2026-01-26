Return-Path: <netdev+bounces-253453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HqcCSlVd2nMeAEAu9opvQ
	(envelope-from <netdev+bounces-253453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:51:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAD787D77
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 768D0300F9CA
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEAA332EBE;
	Mon, 26 Jan 2026 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="D5tWiv8N"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2CE1DEFE9
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769428010; cv=none; b=mYSpvNQWoypCG/z9lON0A/YkDBl4V7AlPBHw4TLHKTZ5RS4SGpjjv6Us4Ti3uZe+kg/jKd5zjkrDf18lVAsyZiDmyVbqwzNY3Qn3hHhOW346egqINLDwo7NVvjMkTIXUbW1BwffZQwmJRW9IVjqvmOAe+jwdbVVOJSdGh0I6l4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769428010; c=relaxed/simple;
	bh=9s9/ClqlLC6FF5gawPtaJXko6R8TldRiiozJdmA+G0k=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=pRp4u9ZOlgMgJVg2waCqokR1w4O/ORsIi+eW7i7i+Tsh1WJOx6Me2vVjbsoV8yGKeDPwbiJZ+Zjp1vRs0lHxB6v0bRuZXcHMp61qhfd50OwVAo8Z4f7zrrlgGl9ZMAJZuKf886xroGeR8gC/yqawMeweewHSdHU4B8JDyA0sm3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=D5tWiv8N; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DWSu8t1grXWZnE44t3iliOt1I5glo/3cWtFBkyNFJo8=; b=D5tWiv8NGW6ODyKZICJ1J0JzF/
	jQmoouKbhJfGnpeTP0TOq90zJ9F2+Ep+vqPjvlPLP+7Yxc7X+Uz4QfzhCSqMddH8otg8zVkB+3Wlz
	fZ2xSc0YItmsvXGsdSXl/pQfcmoJZb1OJo/kFCTISWaOl1jNcBGQMJqL+qfSGU/hbRQPcpApjQuGW
	o1N17Suy9mbGWqL+Z3Wxo3ZUiHUQAF4+8AbxYzHHe8lkMIaGcs7mnIc32vRe1+t7II/p38b6EDUvb
	9UKyq04VUXm1Q9foNXwSwfVYt5H2s+YySA0Wi8pZiaOrUWwOaxIrarZZfT4ttuhHsW/aMK1KE1N7c
	/d7QUUXw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55412 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vkL3F-000000004j2-2tHH;
	Mon, 26 Jan 2026 11:46:37 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vkL3D-00000005uty-1GZM;
	Mon, 26 Jan 2026 11:46:35 +0000
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
Subject: [PATCH net-next v2 19/22] net: stmmac: rk: rk3328: gmac2phy only
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
Message-Id: <E1vkL3D-00000005uty-1GZM@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 26 Jan 2026 11:46:35 +0000
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
	TAGGED_FROM(0.00)[bounces-253453-lists,netdev=lfdr.de,kernel];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 9BAD787D77
X-Rspamd-Action: no action

As detailed in a previous commit ("net: stmmac: rk: convert rk3328 to
use bsp_priv->id") rk3328 gmac2phy only supports RMII, whereas gmac2io
supports both RMII and RGMII. Clear supports_rgmii for gmac2phy.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 4f9b3705d264..ae9df91a018d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -465,6 +465,7 @@ static int rk3328_init(struct rk_priv_data *bsp_priv)
 	case 1: /* gmac2phy */
 		bsp_priv->gmac_grf_reg = RK3328_GRF_MAC_CON2;
 		bsp_priv->clock_grf_reg = RK3328_GRF_MAC_CON2;
+		bsp_priv->supports_rgmii = false;
 		return 0;
 
 	default:
-- 
2.47.3


