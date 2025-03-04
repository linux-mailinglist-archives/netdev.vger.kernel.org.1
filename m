Return-Path: <netdev+bounces-171675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 008D8A4E1C4
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CF1174CB3
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3695D262D1E;
	Tue,  4 Mar 2025 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OjlSumgP"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A005B209F33;
	Tue,  4 Mar 2025 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099425; cv=none; b=FHRVoDGQtXSePJiaPbn3pyPS0Na65a9GuaGr+ec2KgYLIWUdGcHufZyo0QwVDJ8/RJvtPB5V+cZv/W/OC6HXUMMuw8rC/T0mA0AX7yqLTzxa+jMDDeo112UYKsAxfElFm2uQmTKeV86TSUKZVTrkmEgV4bm7XlR+4UBKx+YQnis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099425; c=relaxed/simple;
	bh=ZJX8wjGzix2xk7xk08CSns6KEJr/SMpC4Cca0Yiw5Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKlGZA7Pfn69Tvu0JVLW0uXZLqbFmt3Wdwbz9/cvsNHBOIAQ6VxQhLXiNmN2y/kakxeXNZIVhoL8tntbVBsTgD5N4NGCHss9kphg4mxJrebEG9YqBQpl1lnyelFx3NnkfXztxfbskOD+YPvyYYHYqxyl/FVJwCB6gI1ankIfUK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OjlSumgP; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E11F544283;
	Tue,  4 Mar 2025 14:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741099415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRe8bA5fq5Dnerb6IrVuapdeqPHeVXv9pFZzkEkJmRo=;
	b=OjlSumgPR+Di0+R/SqIfwlocmtXNUmeGujQ9eyffd0YzGCom6RZHDLNRLH3fVl+T3moCWQ
	x1FdbSetA4zu0h48UeLxbePp0CAVyEd/3nW55E6OyfiNkqLm1KDucpqXd/4J+0kFmbSoDG
	SqJuGnZb8WOarIlXMEbCPWxqeyDpj2+VKmoK3mmEv5rAliUA2/cjRp5U3CY+086H8YNC4i
	ANWB9ISfQYUa9hITU4YO345eDP7GXn+mkG8pD1NrUerrOpCRZYc6ygkuNW8mLqaIBADplB
	xSp9wanjT23HIIF8glPrOBPJ1bxOKdqbVLBqsYDNeIwX1zVwMIUXe7T/8eXDjg==
Date: Tue, 4 Mar 2025 15:43:30 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v4 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
Message-ID: <20250304154330.6e00961b@fedora.home>
In-Reply-To: <20250303090321.805785-10-maxime.chevallier@bootlin.com>
References: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
	<20250303090321.805785-10-maxime.chevallier@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudelpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhin
 hhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Mon,  3 Mar 2025 10:03:15 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> When phylink creates a fixed-link configuration, it finds a matching
> linkmode to set as the advertised, lp_advertising and supported modes
> based on the speed and duplex of the fixed link.
> 
> Use the newly introduced phy_caps_lookup to get these modes instead of
> phy_lookup_settings(). This has the side effect that the matched
> settings and configured linkmodes may now contain several linkmodes (the
> intersection of supported linkmodes from the phylink settings and the
> linkmodes that match speed/duplex) instead of the one from
> phy_lookup_settings().
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---

Maybe before anything goes further with this patch, I'd like to get
some feedback from it on a particular point. This changes the linkmodes
that are reported on fixed-link interfaces. Instead of reporting one
single mode, we report all modes supported by the fixed-link' speed and
duplex settings.

The following example is a before/after of the "ethtool ethX" output on
a 1G fixed link :

Before this patch :

	Settings for eth0:
	Supported ports: [ MII ]
	Supported link modes:   1000baseT/Full 
	Supported pause frame use: Symmetric
	Supports auto-negotiation: Yes
	Supported FEC modes: Not reported
	Advertised link modes:  Not reported
	Advertised pause frame use: No
	Advertised auto-negotiation: No
	Advertised FEC modes: Not reported
	Speed: Unknown!
	Duplex: Half
	Port: MII
	PHYAD: 0
	Transceiver: internal
	Auto-negotiation: off
	Supports Wake-on: d
	Wake-on: d
	Link detected: no

After :

	Supported ports: [ MII ]
	Supported link modes:   1000baseT/Full 
	                        1000baseKX/Full 
	                        1000baseX/Full 
	                        1000baseT1/Full 
	Supported pause frame use: Symmetric
	Supports auto-negotiation: Yes
	Supported FEC modes: Not reported
	Advertised link modes:  Not reported
	Advertised pause frame use: No
	Advertised auto-negotiation: No
	Advertised FEC modes: Not reported
	Speed: Unknown!
	Duplex: Half
	Port: MII
	PHYAD: 0
	Transceiver: internal
	Auto-negotiation: off
	Supports Wake-on: d
	Wake-on: d
	Link detected: no

The fixed-link in question is for the CPU port of a DSA switch.

In my opinion, this is OK as the linkmodes expressed here don't match
physical linkmodes on an actual wire, but as this is a user visible
change, I'd like to make sure this is OK. Any comment here is more than
welcome.

Maxime

> V4: Remove unnecessary linklmode_zero in phylink_set_fixed_link(),
> follwing Russell's comment
> 
>  drivers/net/phy/phylink.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 6c67d5c9b787..0b9585cb508e 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -805,9 +805,10 @@ static int phylink_validate(struct phylink *pl, unsigned long *supported,
>  static int phylink_parse_fixedlink(struct phylink *pl,
>  				   const struct fwnode_handle *fwnode)
>  {
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(match) = { 0, };
>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
> +	const struct link_capabilities *c;
>  	struct fwnode_handle *fixed_node;
> -	const struct phy_setting *s;
>  	struct gpio_desc *desc;
>  	u32 speed;
>  	int ret;
> @@ -879,8 +880,10 @@ static int phylink_parse_fixedlink(struct phylink *pl,
>  	linkmode_copy(pl->link_config.advertising, pl->supported);
>  	phylink_validate(pl, pl->supported, &pl->link_config);
>  
> -	s = phy_lookup_setting(pl->link_config.speed, pl->link_config.duplex,
> -			       pl->supported, true);
> +	c = phy_caps_lookup(pl->link_config.speed, pl->link_config.duplex,
> +			    pl->supported, true);
> +	if (c)
> +		linkmode_and(match, pl->supported, c->linkmodes);
>  
>  	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, mask);
>  	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, mask);
> @@ -889,9 +892,10 @@ static int phylink_parse_fixedlink(struct phylink *pl,
>  
>  	phylink_set(pl->supported, MII);
>  
> -	if (s) {
> -		__set_bit(s->bit, pl->supported);
> -		__set_bit(s->bit, pl->link_config.lp_advertising);
> +	if (c) {
> +		linkmode_or(pl->supported, pl->supported, match);
> +		linkmode_or(pl->link_config.lp_advertising,
> +			    pl->link_config.lp_advertising, match);
>  	} else {
>  		phylink_warn(pl, "fixed link %s duplex %dMbps not recognised\n",
>  			     pl->link_config.duplex == DUPLEX_FULL ? "full" : "half",
> @@ -1879,21 +1883,20 @@ static int phylink_register_sfp(struct phylink *pl,
>  int phylink_set_fixed_link(struct phylink *pl,
>  			   const struct phylink_link_state *state)
>  {
> -	const struct phy_setting *s;
> +	const struct link_capabilities *c;
>  	unsigned long *adv;
>  
>  	if (pl->cfg_link_an_mode != MLO_AN_PHY || !state ||
>  	    !test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state))
>  		return -EINVAL;
>  
> -	s = phy_lookup_setting(state->speed, state->duplex,
> -			       pl->supported, true);
> -	if (!s)
> +	c = phy_caps_lookup(state->speed, state->duplex,
> +			    pl->supported, true);
> +	if (!c)
>  		return -EINVAL;
>  
>  	adv = pl->link_config.advertising;
> -	linkmode_zero(adv);
> -	linkmode_set_bit(s->bit, adv);
> +	linkmode_and(adv, pl->supported, c->linkmodes);
>  	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, adv);
>  
>  	pl->link_config.speed = state->speed;


