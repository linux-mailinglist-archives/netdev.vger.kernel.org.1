Return-Path: <netdev+bounces-233043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59098C0B83F
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 01:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F593BA120
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 00:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3880078F59;
	Mon, 27 Oct 2025 00:08:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930201388;
	Mon, 27 Oct 2025 00:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761523714; cv=none; b=uv56OKpuOjT7E1C9MJKlxqlFJVlll8bHAjFFmRyX9WSHAD0EbKIIihxISwUfl0wce1QXZkd9Br/+Un6+Z84JzVtBN74myOUjAosd2fOf/7rtVPTwloH9IYkBs0WN3IR3HWdY22e1msJRvmlXIh53GRiQBk5u0eMurvq1LOaMKZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761523714; c=relaxed/simple;
	bh=98yruYel77rmM913pXEoK+w2NRx8Q3hzcTD9iLuIYTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMj/TEvd7XwSq93/FP7OABSjVXOwjc9Mt/EdcbNFTnqQAjbgjkb5zatOmAW83j8WIxJOmcoOdeq/jd2mqR4YCUWubnHBV3LtQUxlTmhP9GzQVcCTkHCuZBDx26Ph17qFVJHtu4hbrWP4wJkKOh/a+z0jEiQhMLctqR0w1WvdhBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vDAmg-000000007mw-3V9M;
	Mon, 27 Oct 2025 00:08:26 +0000
Date: Mon, 27 Oct 2025 00:08:23 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v2 13/13] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Message-ID: <aP6395j1lbzld4U6@makrotopia.org>
References: <cover.1761402873.git.daniel@makrotopia.org>
 <5a586b0441a18a1e0eca9ebe77668d6ebde79d1c.1761402873.git.daniel@makrotopia.org>
 <aP0ae1rxKnaJUO-_@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP0ae1rxKnaJUO-_@shell.armlinux.org.uk>

Hi Russell,

thank you for the review and for not getting tired to teach me ;)

On Sat, Oct 25, 2025 at 07:44:11PM +0100, Russell King (Oracle) wrote:
> On Sat, Oct 25, 2025 at 03:51:23PM +0100, Daniel Golle wrote:
> > [...]
> > +	/* Assert and deassert SGMII shell reset */
> > +	ret = regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
> > +			      GSW1XX_RST_REQ_SGMII_SHELL);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = regmap_clear_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
> > +				GSW1XX_RST_REQ_SGMII_SHELL);
> > +	if (ret < 0)
> > +		return ret;
> 
> So this is disruptive. Overall, at this point, having added every other
> comment below, this code has me wondering whether you are aware of the
> documentation I have written in phylink.h for pcs_config(). This code
> goes against this paragraph in that documentation:
> 
> "
>  * pcs_config() will be called when configuration of the PCS is required
>  * or when the advertisement is possibly updated. It must not unnecessarily
>  * disrupt an established link.
> "
> 
> Low quality implementations lead to poor user experiences.

I've improved this in v3 which I have just sent, unless the TBI block came
out of reset or the interface mode had changed since the previous call to
.pcs_config() I'm now avoiding any disruptive operations.

> > [...]
> > +	if (interface == PHY_INTERFACE_MODE_SGMII) {
> > +		txaneg = ADVERTISE_SGMII;
> > +		if (sgmii_mac_mode) {
> > +			txaneg |= BIT(14); /* MAC should always send BIT 14 */
> 
> Bit 14 is ADVERTISE_LPACK.

Thanks for that, always learning ;)

> 
> I think I'd prefer:
> 
> 			txaneg = ADVERTISE_SGMII | ADVERTISE_LPACK;
> 
> and...
> 
> > +			anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_ANMODE,
> > +					      GSW1XX_SGMII_TBI_ANEGCTL_ANMODE_SGMII_MAC);
> > +		} else {
> > +			txaneg |= LPA_SGMII_1000FULL;
> 
> 			txaneg = LPA_SGMII | LPA_SGMII_1000FULL;
> 
> here.

Ack.

> 
> > +			anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_ANMODE,
> > +					      GSW1XX_SGMII_TBI_ANEGCTL_ANMODE_SGMII_PHY);
> 
> So this seems to be yet another case of reverse SGMII. Andrew, please
> can we get to a conclusion on PHY_INTERFACE_MODE_REVSGMII before we
> end up with a crapshow of drivers doing their own stuff *exactly*
> like we see here?

I agree that PHY_INTERFACE_MODE_REVSGMII would make sense, and I have
now at least added a comment indicating that.
As on DSA switches it is very common for the same SerDes interface
being potentially used to connect a PHY or SFP cage, but be used as CPU
port, it will be important to clearly state which end of such links
is described as SGMII or REVSGMII, as one side is always MAC side and
the other side is PHY side, so its a bit ambigous to use the 'foward'
(aka. 'normal') vs. 'reverse' language...

> > [...] (regarding GSW1XX_SGMII_TBI_ANEGCTL_OVRANEG and
> >        GSW1XX_SGMII_TBI_ANEGCTL_OVRABL bits)
> Please add a comment describing what is going on here. What does this
> register bit do...

I've added a comment describing the override bits in detail and it
also turned out that it makes most sense to always set both override
bits.

> 
> > +	} else if (interface == PHY_INTERFACE_MODE_1000BASEX ||
> > +		   interface == PHY_INTERFACE_MODE_2500BASEX) {
> > +		txaneg = BIT(5) | BIT(7);
> 
> ADVERTISE_1000XFULL | ADVERTISE_1000XPAUSE ?

Actually phylink_mii_c22_pcs_encode_advertisement() seemed like a good
match here and I've used that for the Base-X modes.

> > [...]
> > +
> > +static const struct phylink_pcs_ops gsw1xx_sgmii_pcs_ops = {
> > +	.pcs_an_restart = gsw1xx_sgmii_pcs_an_restart,
> > +	.pcs_config = gsw1xx_sgmii_pcs_config,
> > +	.pcs_disable = gsw1xx_sgmii_pcs_disable,
> > +	.pcs_enable = gsw1xx_sgmii_pcs_enable,
> > +	.pcs_get_state = gsw1xx_sgmii_pcs_get_state,
> > +	.pcs_link_up = gsw1xx_sgmii_pcs_link_up,
> 
> Please order these in the same order as they appear in the struct, and
> please order your functions above in the same order. This makes it
> easier in future if new methods need to be added.

Ack, done.

> 
> Also, please add the .pcs_inband_caps method to describe the
> capabilities of the PCS.

Ack.

> 
> It seems to me that this is not just a Cisco SGMII PCS, but also
> supports IEEE 802.3 1000BASE-X. "SGMII" is an ambiguous term. Please
> avoid propagating this ambigutiy to the kernel. I think in this case
> merely "gsw1xx_pcs_xyz" will do.

I've renamed all functions according to your suggestions, but kept
register names as-is to still match how they are called in the (btw
public) datasheet.

> > [...]
> > +static struct phylink_pcs *gsw1xx_phylink_mac_select_pcs(struct phylink_config *config,
> > +							 phy_interface_t interface)
> > +{
> > +	struct dsa_port *dp = dsa_phylink_to_port(config);
> > +	struct gswip_priv *gswip_priv = dp->ds->priv;
> > +	struct gsw1xx_priv *gsw1xx_priv = container_of(gswip_priv,
> > +						       struct gsw1xx_priv,
> > +						       gswip);
> 
> Reverse christmas tree?

Not possible as each declaration uses the previously declared
variable in its initializer.


Cheers


Daniel

