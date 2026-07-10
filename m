Return-Path: <netdev+bounces-306634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w0vXOdYoUWrYAAMAu9opvQ
	(envelope-from <netdev+bounces-306634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:16:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A30973CF8E
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:16:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=5snnfmSh;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306634-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306634-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2D0A307CD11
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6DC431E69;
	Fri, 10 Jul 2026 17:02:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70A91EEE6;
	Fri, 10 Jul 2026 17:02:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702959; cv=none; b=n4qw/uY6exMFlIyPgaehctpiMUesgr9ZwPHScW6tYyI2iajBYbvzGQk0qMG61FHMUXuSLvDIzdiEk1/WyyQnt1QmL+HQvXJMLOUi+K8ymNV7xP6oNwgMxowHX8Fn52sn/fQ0TRwjO64D/aSlEENsnpCbs16d9A91ckSSNzTbP4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702959; c=relaxed/simple;
	bh=zGiXXq4Yf4plRnQu9j2O6oX8H7loOma7p8eno1B3G9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu7bo9IJNg8vi0vSTAl+HsVhKNahbhjk9lkxL18WQQB9fG0h12mWf8APKcrZowjfbfb05EsrFDhRVP8N00wgeqRaUeMvqF6cTdOM1D1f1bP33F3M7oy+0Z+j46l/cqlaSdkE9G+zbqvhlYKBe9l1eqFZrKAxCI7tbgLNUPPnXt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5snnfmSh; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=glOvNElGasX6aOmC5dGJ/6BRYjMaqIpiDdQwB3WSxFg=; b=5snnfmShbxUQv3dBHQGMw+KV7f
	2FBwepqncj++2y1HHyXJ38V0146vCquz+mItsA/4SwHvw2NoI9tH24d4KFVayf38ka4Y5nOZI16kZ
	xvFicqaM5LKEyGpDpgkGZxntGxfymFFSCA9v6mkRRwfC7swhAWoIdU7g7HHE99Oi7i78=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wiEcD-00Bfnp-U0; Fri, 10 Jul 2026 19:02:17 +0200
Date: Fri, 10 Jul 2026 19:02:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
	nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	linux@armlinux.org.uk, enelsonmoore@gmail.com, daniel@thingy.jp
Subject: Re: [PATCH net-next v6 2/7] net: phy: phylink: add helper to modify
 pause
Message-ID: <18a5cd81-49ab-4b97-ba68-121e22cba874@lunn.ch>
References: <20260709100237.541-1-javen_xu@realsil.com.cn>
 <20260709100237.541-3-javen_xu@realsil.com.cn>
 <0c188a7d-3637-4e08-9ac8-c1d824b461ed@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c188a7d-3637-4e08-9ac8-c1d824b461ed@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306634-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:javen_xu@realsil.com.cn,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:linux@armlinux.org.uk,m:enelsonmoore@gmail.com,m:daniel@thingy.jp,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[realsil.com.cn,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,makrotopia.org,armlinux.org.uk,thingy.jp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realsil.com.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A30973CF8E

On Fri, Jul 10, 2026 at 12:05:06PM +0200, Maxime Chevallier wrote:
> Hi,
> 
> On 7/9/26 12:02, javen wrote:
> > From: Javen Xu <javen_xu@realsil.com.cn>
> > 
> > For Realtek nics, when we enable jumbo, pause are not supported. So we
> > must check the pause capabilities from ourself and lp.
> > 
> > Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> > ---
> > Changes in v5:
> >  - no changes, new file
> > 
> > Changes in v6:
> >  - rename phylink_update_mac_pause_capabilities(), this function only
> >    changes mac pause capability
> >  - set asym pause and pause according to config->pause tx and rx
> >  - add phydev->lock when change pl->phydev->advertising
> > ---
> >  drivers/net/phy/phylink.c | 87 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/phylink.h   |  2 +
> >  2 files changed, 89 insertions(+)
> > 
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index 59dfe35afa54..9e9cd79301d6 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -1828,6 +1828,93 @@ int phylink_set_fixed_link(struct phylink *pl,
> >  }
> >  EXPORT_SYMBOL_GPL(phylink_set_fixed_link);
> >  
> > +/**
> > + * phylink_update_mac_pause_capabilities() - Dynamically update MAC pause
> > + * @pl: a pointer to a &struct phylink returned from phylink_create()
> > + * @mac_pause: the new MAC pause capabilities mask
> > + *
> > + * This function allows a MAC driver to dynamically change its pause state,
> > + * such as losing/gaining Pause frame support based on MTU size.
> > + * It recalculates supported link modes and triggers renegotiation if needed.
> > + */
> > +void phylink_update_mac_pause_capabilities(struct phylink *pl, unsigned long mac_pause)
> > +{
> > +	struct phylink_link_state *config = &pl->link_config;
> > +	unsigned long old_pause, caps_added, caps_removed;
> > +	bool pause_adv, asym_adv;
> > +
> > +	ASSERT_RTNL();
> > +
> > +	if (mac_pause & ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE)) {
> > +		phylink_err(pl, "Attempted to dynamically change non-pause MAC capabilities\n");
> > +		return;
> > +	}
> > +
> > +	old_pause = pl->config->mac_capabilities & (MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
> > +	caps_added = mac_pause & ~old_pause;
> > +	caps_removed = old_pause & ~mac_pause;
> > +
> > +	if (!caps_added && !caps_removed)
> > +		return;
> > +
> > +	mutex_lock(&pl->state_mutex);
> > +
> > +	pl->config->mac_capabilities &= ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
> > +	pl->config->mac_capabilities |= mac_pause;
> > +
> > +	if (caps_removed & MAC_SYM_PAUSE)
> > +		linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT, pl->supported);
> > +	if (caps_removed & MAC_ASYM_PAUSE)
> > +		linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, pl->supported);
> > +
> > +	linkmode_and(config->advertising, config->advertising, pl->supported);
> > +
> > +	if (caps_added & MAC_SYM_PAUSE) {
> > +		linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, pl->supported);
> > +		if (pl->phydev && !phylink_test(pl->phydev->supported, Pause))
> > +			linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT, pl->supported);
> 
> Why look at what the PHY can do here ? You shouldn't need to.

I question the whole idea here. Why is this so complex? phylink should
already have all the needed code, once you change
pl->config->mac_capabilities you just need to call that code. Yes, it
might need refactoring into a helper, but that would be a preparatory
patch.

Once you start reusing existing code, i then wounder if it is just as
simple to allow any of the mac_capabilities to be changed, not just
pause?

	Andrew

