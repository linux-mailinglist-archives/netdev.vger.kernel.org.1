Return-Path: <netdev+bounces-272553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBXcEbd+xmlTLAUAu9opvQ
	(envelope-from <netdev+bounces-272553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:57:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3103344A00
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40050305F245
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61883BA24F;
	Fri, 27 Mar 2026 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="q7qAf+oB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71AC3B7766
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774616181; cv=none; b=toXMLiy34dAWbqhfDzzPPATdFW7LIX5QZzL9je5h5P5NW4w/GuYgwov0lpPt6OwkslwQY7PVKvQZ4xD3079YEqM5m+V6mMMTAWeBV7S7YKaNqZgH6USF3W/vOry5bz4Gde+WOjW0vAJCEmYhu/iUkeu54LbE9pXCUtxUJ7fLwms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774616181; c=relaxed/simple;
	bh=t/t1NB4s1aNPF49AeHn8MCNFeL0GfjuuTy7FfXV0rV0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=BfMwinZQqZfJei5btqmM10cpFuEEUy07sazxLXUVB664Jyw8+9QyQFhIRhpaVvTS8P9dd6MOLREaw6ZhCw1BgYefzMBl43Zei6+KqYM1bsxXd6HCc11PgC5flDHiEO3FmMfJOgUjmsa9qDxCLk3bRqzu2iAB1ih90QCMurrNON8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=q7qAf+oB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XKTwEBToZ20zvxNTMjXB90qLtMye7qL+XoIGzZlzjpc=; b=q7qAf+oBf4FaoJRqeTe33P7fyL
	TX3CTjCboE2NwenorItskjIpWKYYUCOLEQZeQuH8vtvEuvjOHByl83SgLGr4Yeev246TTUlXvbfpi
	Vvu2mNKEETOyd3AvFZv8p09R2AjYcC0vIf5AtrTNnyArSc+p3c8FThHla1XH13Q1iRR4MyRPJGtN1
	+yKBgYKVeSOqdafcDxGCBmBf7eV4fk5ByP2ArUGZF3gptLgKzpbS3tTo3cUzzYi7V1P6uLvAD791a
	omYlHm6ctafKVHfs4Ytvrof9gTaMkTob4HLwT2Sl11eFeQtUseQGtT5CkQwdji1JJ/ctFUObC9Si8
	8AsroyQA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51248 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w66jX-000000006AZ-0oXS;
	Fri, 27 Mar 2026 12:56:15 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w66jW-0000000E3qS-23fW;
	Fri, 27 Mar 2026 12:56:14 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: phylink: allow PHYs to be attached in
 802.3z inband mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w66jW-0000000E3qS-23fW@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 27 Mar 2026 12:56:14 +0000
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272553-lists,netdev=lfdr.de,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: E3103344A00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that we have proper decision making for inband mode support which
makes it a "best efforts" feature based on the capabilities of the PHY
and PCS, we can relax whether we expect and permit a PHY to be
attached. This is especially true for the 2500BASE-X case which some
PHYs use without inband on their host side interface for 2.5G speeds,
but use inband for slower speeds switching to SGMII on their host side
interface.

We already have such a case for some qcom-ethqos setups, although
qcom-ethqos overrides phylink's inband settings by accessing the PCS
directly at the moment. This should allow qcom-ethqos to transition to
defaulting to inband when 2500BASE-X or SGMII is specified in its DTS.

Allow PHYs to be attached when inband mode has been specified, which
will be necessary to allow inband mode to be used on qcom-ethqos.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 087ac63f9193..1c178038e6f1 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1965,9 +1965,7 @@ EXPORT_SYMBOL_GPL(phylink_destroy);
  */
 bool phylink_expects_phy(struct phylink *pl)
 {
-	if (pl->cfg_link_an_mode == MLO_AN_FIXED ||
-	    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
-	     phy_interface_mode_is_8023z(pl->link_interface)))
+	if (pl->cfg_link_an_mode == MLO_AN_FIXED)
 		return false;
 	return true;
 }
@@ -2206,9 +2204,7 @@ static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
 {
 	u32 flags = 0;
 
-	if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED ||
-		    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
-		     phy_interface_mode_is_8023z(interface) && !pl->sfp_bus)))
+	if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED))
 		return -EINVAL;
 
 	if (pl->phydev)
-- 
2.47.3


