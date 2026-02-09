Return-Path: <netdev+bounces-257962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIKWAWkKimnKFwAAu9opvQ
	(envelope-from <netdev+bounces-257962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 17:25:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9051127AF
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 17:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0510F301113E
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 16:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC6F3806BE;
	Mon,  9 Feb 2026 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYsaIaY9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C8723D291;
	Mon,  9 Feb 2026 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770654310; cv=none; b=OLB02WbfJzKnd90P469g7FTS/7tGerVtHvI3+JhS9K0MuIrnAC7/pOOSR7+kZGsohjA0bgfJSZ8gZoGOedn+UMOzPyFAz/nY9a3yA7Wp35jGShItH97knCaXgAWJ5inGg9KTAvqVQxSo2RPkZFRWJk+z9z5vuE9G3XD1YWlAalg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770654310; c=relaxed/simple;
	bh=YiyUpq4yLFMnusX9o9WUFew3CYw+pNregIbvTpT83M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLc4Fg1jMoqRKrdSUE9zhlnq6uScYAN5HTSlaDarH1VyVgrCtcsyNXpQn+nELgzeSuf9BkdsyekkSMUGPvHlFhjQxg8ngBS5Rr3bQISyJ3bZCj4hBi1wB2gZPJRM6T35QwstLJYCr/WECava52FqSddgMgU573nSxZi5DH3Pl80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYsaIaY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907FDC19423;
	Mon,  9 Feb 2026 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770654309;
	bh=YiyUpq4yLFMnusX9o9WUFew3CYw+pNregIbvTpT83M0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYsaIaY9LUNkTbpZ47L62Dcxp3Ykz3vn0n+/tyYH7/m6gPKmCKODwefqlR6gSRiZ4
	 QNH71InDZQOYUkH9aAkqvL4A0AJI7qKkqcBqAJ1SQrG6adeUY720ScVOek9e5nl8zk
	 W/FnNIvvdmZZ/ie6NBxWvHWZdvIgLUErNE2dneRRqmal584UEHphuD2c4Q84d/qB/N
	 +bMwAgzyC/IjoXfqFZn/ZTluu3AxtHvgWevNxvqU9qxbhteDuf6BnWey/xsPPT/sCM
	 1N1mwRlFcwNUg9nPrHUMobTGi6cb9z2N5PCWasZy5y3iMXxJo22a/TW9+E0yywpV6Y
	 408PkZHn0GlOw==
Date: Mon, 9 Feb 2026 16:25:03 +0000
From: Simon Horman <horms@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?utf-8?Q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>,
	mwojtas@chromium.org, Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH net-next v3 05/11] net: phy: Create SFP phy_port before
 registering usptream
Message-ID: <20260209162503.GA2478520@horms.kernel.org>
References: <20260201151249.642015-1-maxime.chevallier@bootlin.com>
 <20260201151249.642015-6-maxime.chevallier@bootlin.com>
 <aYI1zd6Iddcdt6xc@horms.kernel.org>
 <7150d811-df6a-488d-a7d8-96aec01365db@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7150d811-df6a-488d-a7d8-96aec01365db@bootlin.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257962-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 4A9051127AF
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 07:09:23PM +0100, Maxime Chevallier wrote:
> Hi Simon,
> 
> On 03/02/2026 18:52, Simon Horman wrote:
> 
> >> -	if (!ret && phydev->sfp_bus)
> >> -		ret = phy_setup_sfp_port(phydev);
> >> +	ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);
> >> +	sfp_bus_put(bus);
> >> +
> >> +	if (ret && port) {
> > 
> > Hi Maxime,
> > 
> > If bus is NULL then port will not be set here.
> 
> Arg... I though smatch was running in the NIPA ingst-mdir script, but I
> was wrong :(

FWWIW, I think it would be nice if it did.
But I'm also not sure how well it works when applied to a full
allmodconfig build. Which, AFAIK, is how NIPA tends to run.

> 
> I'll address that in V5 as the problme is still in V4, thank you for the
> report
> 
> Maxime
> 
> 
> 

