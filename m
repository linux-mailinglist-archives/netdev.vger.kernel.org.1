Return-Path: <netdev+bounces-290017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGy8HsrrDWrM4gUAu9opvQ
	(envelope-from <netdev+bounces-290017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:13:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1B35931D8
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BABC3077789
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4853CCFB0;
	Wed, 20 May 2026 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ECHfVLpR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC52C3EFD34;
	Wed, 20 May 2026 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296065; cv=none; b=CsNv7qs/1KGG4S+U0hPUUw2VWvSaiutwgRbtidM6UXl0vTBcoMlCqnh1JPr51PqN8ksOyCGIPbpgPa3STGxqZ6CQYJ+Nt42A4cucwQgzQTZiTkjMFuwAU+bNXhvPqM0hx9qGbSa++a/+9AHtNGdhT04AzvUg0U8TuR/T3X9F230=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296065; c=relaxed/simple;
	bh=ixckk90Vg8fZaqA4QlHyyWVrl0b6H3lCzSkzEaECSlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuqlxITgxsk2k32edNiIxcXK5BpZA2OUioDhpEvdecweGvottorO3mdGXUdhTaMkxM9iewOE5TMPrP3WjxNqd4myvU5BRS1tb82jzByntA44CG6rh3VFfAde77o9Dp07Nq7dvXdpP82/5zlfBGST4P1/Ioc3AhTtfkh5HVQqLeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ECHfVLpR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6Qj1CxIF4Evt4pS9q2l1ij6TzpWOuNV9UzxyE3LIEZg=; b=ECHfVLpRcSBUIbAQQRv9UxWsV5
	YoiV0Xgo4JhNxrBE7PcRrU2de/DfaoyLRmpSKEjAwFeZ2IMtUnW1Kh+9IIiHD/UQq8W6hXLpPBrQj
	1a52Vay9Mw9Evv8iTA+jP+8ZSQRqbhJVJiMGkKNwwaeyoDlbOJ7JR0PVEWXfQtlVa7nY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPkBN-003s82-RB; Wed, 20 May 2026 18:54:09 +0200
Date: Wed, 20 May 2026 18:54:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>
Subject: Re: [PATCH net-next v10 6/9] net: phy: phy_port: Store information
 about a MII port's vacant state
Message-ID: <9ff206d7-2214-4f80-96b2-b03db2ab8982@lunn.ch>
References: <20260513130521.1064094-1-maxime.chevallier@bootlin.com>
 <20260513130521.1064094-7-maxime.chevallier@bootlin.com>
 <97cd33a0-ee74-4f64-b11a-bb5b88bce79a@lunn.ch>
 <c68f3abd-7a3d-4d37-9589-02433bbd5c5c@bootlin.com>
 <d7086094-9f8b-4d18-92ae-e278b4e67658@lunn.ch>
 <b1eb4c18-7dd9-4c40-97c8-81e277332228@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1eb4c18-7dd9-4c40-97c8-81e277332228@bootlin.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290017-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,pengutronix.de,chromium.org,makrotopia.org,liebherr.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim,phy_port.id:url]
X-Rspamd-Queue-Id: 1F1B35931D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> I've given this a go, and now I remember why it's that way. In a nutshell,
> if something fails during .module_insert() (e.g. module isn't compatible
> with the MII modes ont the cage), then .module_remove() isn't called, so we
> can't track module presence unless we add that in the sfp code itself.

I did wounder about that, it is a pretty typically pattern.


> 
> However a better way to deal with this whole situation may just be to store
> the presence information in the module's port itself, as the parent port id
> :
>                    phy_port.id = 1
>                   /                   phy_port.id = 2;
>                  /                  / phy_port.upstream_port = 1
> +------+     +----------+     +------------+
> | MAC  | --- | SFP Cage | --- | SFP module |
> +------+     +----------+     +------------+
> 
> So, we lose one piece of information, that is "is there an SFP module
> present, even if the module doesn't work". It's now indirectly present
> as "there's another port that references the SFP cage port, hence it's
> not empty".

That is reasonable.

	Andrew

