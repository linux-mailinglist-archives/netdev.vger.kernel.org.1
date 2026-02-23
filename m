Return-Path: <netdev+bounces-260014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFSfGE1GnGk7CgQAu9opvQ
	(envelope-from <netdev+bounces-260014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:21:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C03EB1760D3
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 305D930F95F1
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF59366048;
	Mon, 23 Feb 2026 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PS2f02Iz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E98365A10
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849041; cv=none; b=qoArpyqaGDPYbI5qP2z9dKpsERfD9CyII6hSb3ALP4fp/4UyeRmo5TgyQo2yK50Vn78ADcv2PwERsG80hGXujtE4i0PLijZd2QX56Odi3BrKMDnC+pz+7RCOsvicL660z2miNpCWtUTVfOiXjFEXqD43K2h8YWyc3K8/mzAGdLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849041; c=relaxed/simple;
	bh=ErtAMzne6vE+BQpgEy/OrbeqgfnSI4kMRA8dFkQrLCk=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=OHUU8GoCukb7Fli1H70zDEGt/iMrPmXdX8nx3pYibtbrTyWTobE9Zkhq5wrQIPFKEI6OAlWzUS038nWCYdkrFwe/AE5M874SqGytpLHuwqHPpDuhD3gszyJK1A+pUDUUIg6xKhTjeGj8mVJWhvN4+dKur8VVilGBw03hUjIzwqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PS2f02Iz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MSVGaTn7XmA6GkXd/fmaGcbAWdaT3/cac6c7RkoSv1I=; b=PS2f02IzwG5dDzXEj90R/sRgwZ
	JligdCvKe18fAPWGEwMAVCVlYYqNrMR7OKqNT/CsyLDqD4n868fofXSMgvLaneVl8JE/Tt3lTnwIm
	YABgQmK6SgXbcU/u3tFOGiKjoloi2qsQE8rQ52kNjtz63rP9+HUd5OTQCwalDiVjoE4oVqakgz5Qp
	iRaxoMUm1vkEcKMxm9w+HkQ/hKh82G9DMbfePDGK5Ipfxu5n06kTuB8mmUBNT+wjbqZF7ix8wuitr
	dJpkt7FQ8QLDobjgNNd2RWuMAWGQF9hDu04LCTDJQ3pURXZLP2lfLzQ208csrRSxIoGdc+MhlcV49
	UUAW/4pw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40614 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vuUsD-0000000042a-3Uz5;
	Mon, 23 Feb 2026 12:17:13 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vuUsD-0000000Afci-0XxO;
	Mon, 23 Feb 2026 12:17:13 +0000
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
Subject: [PATCH net-next] net: stmmac: fix EEE supportable interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vuUsD-0000000Afci-0XxO@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 23 Feb 2026 12:17:13 +0000
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
	TAGGED_FROM(0.00)[bounces-260014-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.961];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: C03EB1760D3
X-Rspamd-Action: no action

According to the dwmac v3.74a databook, only MII, GMII and RGMII dwmac
interface modes are supported for EEE. Restrict EEE to these modes, or
the modules supported by a PCS other than the GMAC's integrated PCS.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 82375d34ad57..89ded359a9fe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1374,9 +1374,21 @@ static int stmmac_phylink_setup(struct stmmac_priv *priv)
 				 pcs->supported_interfaces);
 
 	if (priv->dma_cap.eee) {
-		/* Assume all supported interfaces also support LPI */
-		memcpy(config->lpi_interfaces, config->supported_interfaces,
-		       sizeof(config->lpi_interfaces));
+		/* The GMAC 3.74a databook states that EEE is only supported
+		 * in MII, GMII, and RGMII interfaces.
+		 */
+		__set_bit(PHY_INTERFACE_MODE_MII, config->lpi_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_GMII, config->lpi_interfaces);
+		phy_interface_set_rgmii(config->lpi_interfaces);
+
+		/* If we have a non-integrated PCS, assume that it is connected
+		 * to the GMAC using GMII or another EEE compatible interface,
+		 * and thus all PCS-supported interfaces support LPI.
+		 */
+		if (pcs)
+			phy_interface_or(config->lpi_interfaces,
+					 config->lpi_interfaces,
+					 pcs->supported_interfaces);
 
 		/* All full duplex speeds above 100Mbps are supported */
 		config->lpi_capabilities = ~(MAC_1000FD - 1) | MAC_100FD;
-- 
2.47.3


