Return-Path: <netdev+bounces-272617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMxCAWqwxmmiNgUAu9opvQ
	(envelope-from <netdev+bounces-272617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 17:29:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EED8934770C
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 17:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3025D3054F7D
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C125347525;
	Fri, 27 Mar 2026 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BbtTUVri"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB798BA45
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628279; cv=none; b=fIZkgfraA18dW5hdif/LDQY8nCTGPAAQudUBOMjciQsyEIv7HpjCykmwPW4uFc9zEMlEDvfrs4zwbY0C4mO0R8x+XVnS1sGitiBO4Z5PlMVeX5CSoxUZ47u+kcINLpCKiDnzCzeG8TQh/KvxZAqETckcWHNnIWQpVBvnOuS1riQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628279; c=relaxed/simple;
	bh=Jvj0H0BNMwrqy0vdbAzVJC4giq+CsIV6NXI94MTEosc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EF3eHuwoEAI5+WkaskfUoP5C1ZXnn/C3M8DGkuY28cfaMGkoTGq3hEXKiVBR0zJY4UxAFfE3jTP+9U3Zoz2xTZl79AohN2HWP/qVu+s9gREDYHaA9EhOdLjlk0jW4RhlJ/c01e2mMw1AeLDZLrIGG3LwzGc9QSyCck9EBDQmrwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BbtTUVri; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fhSjZHFW8NlZLwfI5rvfaifkSdytoybhbBeCfm6NEvI=; b=BbtTUVriK08BrG+iemILYLe4Nb
	M8rdaLtX3hrXzPxtEkTYqRta3e63SWT34ts0EPCxYDzGJSUpoqJcYrMo7uzQcbBc/GinRZ+1Tb3dy
	L+aOH+yyNaDlaIfW7KxT3P85nKBBBTyREOXqHGpuoVRQOoYdl6w+lIhVlwPCEtQOsXk/rEfZNyODl
	H4Gw2FCJq018PP7Kfgh1HJ56bxc6qY+OYawdoQdprFYFhedJDOMglE9/np8+5G9CK2t8BnHWt20TL
	FFXz4Np91E+/Q4Lv43xwL/pLphby5NUy7iJQUHI+UU153aKKLS2sO6GKu9ql2YvYIZlDkhCEXMXfR
	YES1Y/iA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43574)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w69sd-000000006OK-0kIf;
	Fri, 27 Mar 2026 16:17:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w69sa-000000008Ah-3Fii;
	Fri, 27 Mar 2026 16:17:48 +0000
Date: Fri, 27 Mar 2026 16:17:48 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>
Subject: Re: [PATCH net-next] net: phylink: allow PHYs to be attached in
 802.3z inband mode
Message-ID: <acatrPb1DdHuyVoL@shell.armlinux.org.uk>
References: <E1w66jW-0000000E3qS-23fW@rmk-PC.armlinux.org.uk>
 <a5d7aedb-9770-492f-b528-0a28a652279b@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5d7aedb-9770-492f-b528-0a28a652279b@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272617-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,armlinux.org.uk:email,armlinux.org.uk:url]
X-Rspamd-Queue-Id: EED8934770C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 04:44:23PM +0100, Maxime Chevallier wrote:
> Hi Russell,
> 
> On 27/03/2026 13:56, Russell King (Oracle) wrote:
> > Now that we have proper decision making for inband mode support which
> > makes it a "best efforts" feature based on the capabilities of the PHY
> > and PCS, we can relax whether we expect and permit a PHY to be
> > attached. This is especially true for the 2500BASE-X case which some
> > PHYs use without inband on their host side interface for 2.5G speeds,
> > but use inband for slower speeds switching to SGMII on their host side
> > interface.
> > 
> > We already have such a case for some qcom-ethqos setups, although
> > qcom-ethqos overrides phylink's inband settings by accessing the PCS
> > directly at the moment. This should allow qcom-ethqos to transition to
> > defaulting to inband when 2500BASE-X or SGMII is specified in its DTS.
> > 
> > Allow PHYs to be attached when inband mode has been specified, which
> > will be necessary to allow inband mode to be used on qcom-ethqos.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/net/phy/phylink.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index 087ac63f9193..1c178038e6f1 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -1965,9 +1965,7 @@ EXPORT_SYMBOL_GPL(phylink_destroy);
> >   */
> >  bool phylink_expects_phy(struct phylink *pl)
> >  {
> > -	if (pl->cfg_link_an_mode == MLO_AN_FIXED ||
> > -	    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
> > -	     phy_interface_mode_is_8023z(pl->link_interface)))
> > +	if (pl->cfg_link_an_mode == MLO_AN_FIXED)
> >  		return false;
> >  	return true;
> >  }
> > @@ -2206,9 +2204,7 @@ static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
> >  {
> >  	u32 flags = 0;
> >  
> > -	if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED ||
> > -		    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
> > -		     phy_interface_mode_is_8023z(interface) && !pl->sfp_bus)))
> > +	if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED))
> >  		return -EINVAL;
> >  
> >  	if (pl->phydev)
> 
> So I've tested that on my socfpga setup, and I now get this when trying to
> bring an interface attached to an SFP up :
> 
>   socfpga-dwmac ff702000.ethernet eth1: no phy found
> 
> This wasn't showing before because our DT has :
> 
>   &gmac1 {
>     status = "okay";
>     phy-mode = "1000base-x";
>     managed = "in-band-status";
>     sfp = <&sfp>;
>   };
> 
> It used to kinda work because the problem was hidden with the use of "1000base-x"
> as the PHY mode.
> 
> Now with this patch, using "sgmii" or "1000base-x" as the phy-mode doesn't
> do any difference, as expected.
> 
> The real issue IMO is rather how stmmac_init_phy() behaves, it's guarded by:
> 
>   if (!phylink_expects_phy(priv->phylink))
>           return 0;
> 
> and then tries to find a PHY, failing if there's none. We should probably add
> an extra check there to say "if we have a PCS, then it's OK not to have a PHY" ?

I had a feeling that we'd run into this, because stmmac is somewhat
"special" (for all the wrong reasons.)

phylink has, for a long time, had "we must have a PHY" when it operates
in MLO_AN_PHY mode, "we must not have a PHY" when it operates in
MLO_AN_FIXED mode, and "we may or may not have a PHY" when operating in
inband depending on the PHY interface mode.

stmmac basically doesn't support the latter - it assumes that if a PHY
node is not present, then it needs to fall back to the PHY addressed
by priv->plat->phy_addr, and if that's not specified, then it errors
out. phylink_expects_phy() was added to try and workaround this.

I suspect that if you specify:

   &gmac1 {
     status = "okay";
     phy-mode = "sgmii";
     managed = "in-band-status";
     sfp = <&sfp>;
   };

without this patch, you'll run into the same problem - while phylink
would be perfectly happy, stmmac decides "we must have a PHY!" because
phylink_expects_phy() will return true for this.

As I've recently said, I think we're more or less boxed in between a
rock and a hard place because of the hacks that qcom-ethqos introduced
with its PCS support. At the moment, I am failing to see any path where
the stmmac PCS can be programmed for inband according to phylink's
wishes and qcom-ethqos can be made to work without its hacks.

This all ultimately comes back to the half-hearted phylink conversion
of stmmac that was done behind my back without my review. Had the
conversion been done fully, and kept up with the phylink changes for
PCS support, then we probably wouldn't be in this situation today.

Unfortunately, the driver is going to keep breaking all the time that
it abuses phylink, and at the moment I see no way to stop this sodding
driver abusing phylink.

Can we not just delete this bloody driver and be done with it? :D

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

