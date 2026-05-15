Return-Path: <netdev+bounces-288314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id chU/KS0dB2omsAIAu9opvQ
	(envelope-from <netdev+bounces-288314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:18:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6FE55056B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41344300EA86
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7C5318B96;
	Fri, 15 May 2026 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p+j2BJgh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99D530B50F;
	Fri, 15 May 2026 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850753; cv=none; b=r5s0/FmkhU/yNXt+mGP2O8l4hHucpSknQJz22tJYYNjxio9oeX8tk6jYglN6pVjsH63VBOlJ8/Ct5o8mlfCxw8ORmSZdjh4yiAEhvZK1f6Xj1oQyEs3PiFUuQJdjSnbbnNfUSbWW3IPoyWSuUQqUtEQal914iNrUF9LXVnV64pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850753; c=relaxed/simple;
	bh=q30lxFmDv4dNqul36sBtoF14JZ2WcFMM69V4BB/vstk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9UXeMHnMiQ9h8i0mNqbCbpJUotwQFmTw1mZAbBBBmW0CdYcv7fwNvjSx3YABmk7PPpRhoJS1jvvSnl+ka1jnpyWV0L6irRkq4QuSEq66sJ6msKzn1NCVyZUxMAjOlGbg9LMxilqtab5oH+sdG/j/VDhKLIz3ME0yXydNFCkQfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p+j2BJgh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Q85THMGJzjLyW44YEGjlAlMDf7fpPuKF9ngHPGJsQPQ=; b=p+j2BJghM/qNsf62mTDKoYjDeA
	oCt0vR04TXhe5qhtwSmzCbTufeRvjWfAD3yyjq4Ng73I5ZTRJW/8qnvgEahNND2K++pw3Rcyaa6JZ
	o7gD6FY8ksWS0cxq9r6QHVAEAcvR65aKzDkef0vdBgnoCZlb5gOxxZrmBRgVd3zviRkU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNsKy-003499-Fn; Fri, 15 May 2026 15:12:20 +0200
Date: Fri, 15 May 2026 15:12:20 +0200
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
Message-ID: <d7086094-9f8b-4d18-92ae-e278b4e67658@lunn.ch>
References: <20260513130521.1064094-1-maxime.chevallier@bootlin.com>
 <20260513130521.1064094-7-maxime.chevallier@bootlin.com>
 <97cd33a0-ee74-4f64-b11a-bb5b88bce79a@lunn.ch>
 <c68f3abd-7a3d-4d37-9589-02433bbd5c5c@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c68f3abd-7a3d-4d37-9589-02433bbd5c5c@bootlin.com>
X-Rspamd-Queue-Id: EC6FE55056B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288314-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 09:22:29AM +0200, Maxime Chevallier wrote:
> Hi Andrew,
> 
> On 5/14/26 15:58, Andrew Lunn wrote:
> > > We have information about what MII they can handle, however we don't
> > > store anything about whether they are currently connected to an SFP
> > > module or not. As phy_port aims at listing the front-facing ports, let's
> > > store an "vacant" bit to know whether or not a MII port is currently
> > > vacant (i.e. there's no module in the SFP cage), or not (i.e.
> > > there's an SFP module).
> > 
> > vacant == False actually means a bit more than there is a module in
> > the cage. It also means that, so far, we have not had any errors
> > trying to use the module. If there is an error, we might have a module
> > physically in the cage, but vacant == True.
> 
> This is a good point. Even with an error, we should have vacant = false.
> 
> TBH I'm unsure how to name this, vacant may not be the best word there, but
> I'm struggling to find a better term.
> 
> maybe "empty" ?

My comment is really about, what do we mean by vacant/empty?

Is it simply about there physically being a module in the cage, or is
it also about being able to drive that module? If it is just about
there being a module in the cage, then vacant/empty is good. If we
also want to say that we have been able to read out the EEPROM and
determined the module will work in combination with the PCS and MAC,
then i would probably use a different name. "usable", "compatible"?

Either way, i think the code either needs simplifying, or made more
complex.

	Andrew

