Return-Path: <netdev+bounces-266409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHS0NmnAsGn9mgIAu9opvQ
	(envelope-from <netdev+bounces-266409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 02:07:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4317925A3F4
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 02:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22C9C3018769
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6F91A6817;
	Wed, 11 Mar 2026 01:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UUZ7Fj6t"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A4113FEE
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 01:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773191227; cv=none; b=ES2Jcoz5dBnTr+dyRz0o56ILB9v7MeMe0d5xPsKxgzD53IR/nDpLVKVtDMRpIaVBrYeFu2/4+D+JXPbur2S6B6wNFTjYSZ3xuH9elRVqzP7cTO5dPOMRe733CUQyKsescVrYRq6EDv2cx0LqVMpOUZpGhBDO+iyNMd1btK/etiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773191227; c=relaxed/simple;
	bh=FvcoCUzBxdGf5SAtHPwW0zfePJ4ZjIi3iSEEUEY68RY=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=tgqbufKpN37X/VU4U4ot4cFHJ721QXYS0ccGv1IVsVNzroCMupmT+nN0FT45adtY5fD08yTp7Rnad1NW0wmMicAV5bBcUAu71XAr9jVCabQUbdtgOr8emzq576/erH2tkFtynmut46Zt8mORuQrAqt1guomqEh3qcuhMAOgTSoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UUZ7Fj6t; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gx41xOBjt0DixVI2WdPI+lK6vX/WGjfhPcx8g6Ep4k0=; b=UUZ7Fj6tiRQ+Ij0WjL9AOlE9h/
	05VKv10oBDRPck2CbNw5vYDuqdRpmuxKFanRKcx0+PzjALsNwC/wx647nsZX+H0cpU1Me089Pmtql
	4pG2tKYoxSdZRigHRgFfjvthwJeDZkRDGx9TeaJVAgr3W+61Ufrn8ssxLS6Njteg+53dorx4mGtfx
	2Vf1sRmX8ZvfvZUFmVYz+oPa0PEVavRpunPNEz5Az0e5egdtB6JZzRg1u4XsEMIhayUVST2JZp6uX
	gqJmwKCJJ4zRafW/+igMxS4SjJaPGhX7K6eNKzgC3rmEMji749zbcO7mJfD6lPy3a3vjToPkLMJm2
	LL90e5hg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38794 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w082P-000000005hS-0jwg;
	Wed, 11 Mar 2026 01:07:01 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w082O-0000000ChNc-1wDz;
	Wed, 11 Mar 2026 01:07:00 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: phy: vitesse: add inband caps and configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w082O-0000000ChNc-1wDz@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 11 Mar 2026 01:07:00 +0000
X-Rspamd-Queue-Id: 4317925A3F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266409-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.981];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Action: no action

Add support for VSC8662 reporting its inband capabilities, and also
hook to configure the PHY's inband mode.

This fixes a regression in the macb driver caused by commit
1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled")

Reported-by: Conor Dooley <conor@kernel.org>
Link: https://lore.kernel.org/r/20260304-nebulizer-rounding-40fbc81a2ba1@spud
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/vitesse.c | 41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
index b1b7bbba284e..1a430e832f66 100644
--- a/drivers/net/phy/vitesse.c
+++ b/drivers/net/phy/vitesse.c
@@ -62,6 +62,13 @@
 /* Vitesse Extended Page Access Register */
 #define MII_VSC82X4_EXT_PAGE_ACCESS	0x1f
 
+/* Vitesse VSC8662 extended control register */
+#define VSC8662_EXT_CON1		0x17
+#define VSC8662_EXT_CON_MAC_AN		BIT(13)
+
+#define VSC8662_MAC_AN			0x1b
+#define VSC8662_MAC_AN_BYPASS		BIT(13)
+
 /* Vitesse VSC73XX Extended Control Register */
 #define MII_VSC73XX_PHY_CTRL_EXT3		0x14
 
@@ -140,6 +147,38 @@ static int vsc824x_config_init(struct phy_device *phydev)
 	return err;
 }
 
+static unsigned int vsc8662_inband_caps(struct phy_device *phydev,
+					phy_interface_t interface)
+{
+	if (interface == PHY_INTERFACE_MODE_SGMII)
+		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE |
+		       LINK_INBAND_BYPASS;
+
+	return 0;
+}
+
+static int vsc8662_config_inband(struct phy_device *phydev, unsigned int modes)
+{
+	u16 mask, set;
+	int ret;
+
+	mask = VSC8662_MAC_AN_BYPASS;
+	set = modes & LINK_INBAND_BYPASS ? mask : 0;
+	ret = phy_modify(phydev, VSC8662_MAC_AN, mask, set);
+	if (ret < 0)
+		return ret;
+
+	mask = VSC8662_EXT_CON_MAC_AN;
+	set = modes & (LINK_INBAND_ENABLE | LINK_INBAND_BYPASS) ? mask : 0;
+
+	ret = phy_modify_changed(phydev, VSC8662_EXT_CON1, mask, set);
+	if (ret <= 0)
+		return ret;
+
+	/* We need to soft-reset the PHY when changing VSC8662_EXT_CON_MAC_AN */
+	return genphy_soft_reset(phydev);
+}
+
 #define VSC73XX_EXT_PAGE_ACCESS 0x1f
 
 static int vsc73xx_read_page(struct phy_device *phydev)
@@ -649,6 +688,8 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = &vsc824x_config_init,
+	.inband_caps	= vsc8662_inband_caps,
+	.config_inband	= vsc8662_config_inband,
 	.config_aneg    = &vsc82x4_config_aneg,
 	.config_intr    = &vsc82xx_config_intr,
 	.handle_interrupt = &vsc82xx_handle_interrupt,
-- 
2.47.3


