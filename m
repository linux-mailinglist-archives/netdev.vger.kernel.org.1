Return-Path: <netdev+bounces-260015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBxdMsdFnGk7CgQAu9opvQ
	(envelope-from <netdev+bounces-260015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:19:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 742EC176066
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EECE301CFC9
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4999734D4DE;
	Mon, 23 Feb 2026 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WrtQiZJN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EA735CB88
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849156; cv=none; b=TxIwXFqoUFfn/C0GHbcswuXkkD2z0XOBX90SZUtgpRLRtYbhkPJ2D9s0u46yPQE1fdnH9odA6MOD9Uo3A7sf1ucgop0iqMbSy0UyrZ3gQzz4w+0836TMBCyTl3ZqdA/Nfmx5CNw/fnzwN2r+9nmqZ2iWcusIzhdfdw7G+dgtTrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849156; c=relaxed/simple;
	bh=nJglFK05RLXV/jod4Jm6pswEmNetB55TExNSkpySwg4=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=AL3xbWX/EGq73QkI7Q1wIcwytJNl0vA2BBebacJwi2H2WuqOsyP+hSBmrOsW7A/rTv/1OBAsTftH5FUfJqxN9+7zP045ez/BAhVrMaCaVGHVAu3C1LzaURqcS675q5/ZmEJGNnJU2D2BrnbEsCVnlAHoPpIAsWD12x4X+q0ZQNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WrtQiZJN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Jo6I6WwhvxOZ29kCdHIrgJPNm4E+2rgwkQRfpR0gnvU=; b=WrtQiZJN9joI1IjQewKQKQQ/1j
	2pcxRHyu5YClzXL6OxklaedthoWE6mR/KepGP3Rh09xcwvaVze75d9/qOfBoGha53kIaB/2eEeZLB
	JRGaqvS80uWPoaBF7z2U5O1z3OoqXVd/dZAlds10StCPBH5oK4uMfN7+0J7ybXuEwX4cTXeCXte8n
	mO2JNmzSSx8FbItgZXUYrAIeb3ktk4jKHYXFg4mxy1QCZoBR6WzgH4soKlpkyPaWsl56YSwoK4VxQ
	06Av/LnOwqiMRbRN06r5ij+FHHWChj2p9hvxBmvYwAQ2ZL9zP5XlW3GEcYbbhqAGvNbDlFXJUBP6c
	6nHIqdRQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55526 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vuUu4-00000000430-3vJd;
	Mon, 23 Feb 2026 12:19:09 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vuUu4-0000000Afea-0j9B;
	Mon, 23 Feb 2026 12:19:08 +0000
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
Subject: [PATCH net-next] net: stmmac: fix timestamping configuration after
 suspend/resume
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vuUu4-0000000Afea-0j9B@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 23 Feb 2026 12:19:08 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260015-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.961];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 742EC176066
X-Rspamd-Action: no action

When stmmac_init_timestamping() is called, it clears the receive and
transmit path booleans that allow timestamps to be read. These are
never re-initialised until after userspace requests timestamping
features to be enabled.

However, our copy of the timestamp configuration is not cleared, which
means we return the old configuration to userspace when requested.
This is inconsistent. Fix this by clearing the timestamp configuration.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---

I'm in two minds whether this should go via net or net-next - no one
has noticed that getting the timestamp configuration after resume
doesn't reflect the hardware state. Here's the commit that introduced
the problem:

Fixes: d6228b7cdd6e ("net: stmmac: implement the SIOCGHWTSTAMP ioctl")

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 89ded359a9fe..4c127b6b8c08 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -853,6 +853,7 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
 		netdev_info(priv->dev,
 			    "IEEE 1588-2008 Advanced Timestamp supported\n");
 
+	memset(&priv->tstamp_config, 0, sizeof(priv->tstamp_config));
 	priv->hwts_tx_en = 0;
 	priv->hwts_rx_en = 0;
 
-- 
2.47.3


