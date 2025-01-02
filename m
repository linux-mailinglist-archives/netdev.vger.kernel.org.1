Return-Path: <netdev+bounces-154777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E289FFC68
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3324D3A1BF1
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 16:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8877171CD;
	Thu,  2 Jan 2025 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zwuE5a8m"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A812B15E96;
	Thu,  2 Jan 2025 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735837035; cv=none; b=FK+O5pP+RW+K407wFXhqdfH3yhCvvdQEvJZFCqmqNuy1dI+8QJT1vZc6QBA+LgEmnhuZJnoPABsrUrtsULoZN2xhox5hksgU5+6cQaUQ0O2hdqn/EYMvsKicdfTad3sfngzbYrPUj5d8emUXzzYJ4rekOKfcGBB88Wk2kIgfHv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735837035; c=relaxed/simple;
	bh=Ta41Xt9gyiKEXnBcphvdUvBLpH7VcUHVUvvH4fknd3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kh9lE98nKoY4E9PmZvZlIxxhGu7lDL3kdkf2f6gNSM/B4paNDKgH0EBomioRB1hSnz0ay6f8NDslsybnDFDMCd4pPATrFaeDQbAyYdn8ptmG00ftKWskWcbc6Mmz86/GkYn4cAo9IJrLyzx6YFpHKBojFgRWQckumXrIgR0AX/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zwuE5a8m; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JmgSw9mo0AYATQqQUZpHF4QS1tzMi7/3g9Di9T9wWlI=; b=zwuE5a8mi5KCXp9VhML0JSvZvo
	pxn0md/lHvaJ2xCgNIAeRB5gc2ItDJ9frtHwGV4T8iYwTmMdD5JJLO0hcuNTvsup93wqdZGH2HApQ
	Q0rKR7yvlV53jCh9Dvxss9UdkMRCBWznqnsGZE5+8rEz7HNUy0AroQ4VLUhifKM07xLm8D4DyNh7M
	chEEnPhXZs3MZ3xc9nOTYKzxxnb2uXQ7jgG+TKGRbXfVGrBvSg8d4F6St7+90+pYhag1JCsd8Vwt5
	hAbNIXxUTspQszBPWSxgPN6m1Xw64NPUlFkq8pLZqcHArk1/8U9ZMJtWKtdEE38Wncnvm4l7HT/Yb
	wt8KBN3A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57696)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tTOVK-0002CU-27;
	Thu, 02 Jan 2025 16:57:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tTOVE-0000R9-1v;
	Thu, 02 Jan 2025 16:56:56 +0000
Date: Thu, 2 Jan 2025 16:56:56 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: Move callback comments from
 struct to kernel-doc section
Message-ID: <Z3bFWDjtGNqSGfdD@shell.armlinux.org.uk>
References: <20241206113952.406311-1-o.rempel@pengutronix.de>
 <e6a812ba-b7ea-4f8a-8bdd-1306921c318f@redhat.com>
 <Z1hJ4Wopr_4BJzan@shell.armlinux.org.uk>
 <20241210063704.09c0ac8a@kernel.org>
 <Z2AbBilPf2JRXNzH@pengutronix.de>
 <20241216175316.6df45645@kernel.org>
 <Z2EO45xuUkzlw-Uy@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2EO45xuUkzlw-Uy@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 17, 2024 at 06:40:51AM +0100, Oleksij Rempel wrote:
> On Mon, Dec 16, 2024 at 05:53:16PM -0800, Jakub Kicinski wrote:
> > On Mon, 16 Dec 2024 13:20:22 +0100 Oleksij Rempel wrote:
> > > On Tue, Dec 10, 2024 at 06:37:04AM -0800, Jakub Kicinski wrote:
> > > > > I certainly can't help but write the "returns" statement in natural
> > > > > English, rather than kernel-doc "Returns:" style as can be seen from
> > > > > my recent patches that have been merged. "Returns" without a colon is
> > > > > just way more natural when writing documentation.
> > > > > 
> > > > > IMHO, kernel-doc has made a wrong decision by requiring the colon.  
> > > > 
> > > > For the patch under consideration, however, I think _some_ attempt 
> > > > to make fully documenting callbacks inline possible needs to be made :(  
> > > 
> > > Please rephrase, I do not understand.
> > > 
> > > Should I resend this patch with corrected "Return:" description, or
> > > continue with inlined comments withing the struct and drop this patch?
> > 
> > I'm not talking about Returns, I'm talking about the core idea of
> > the patch. The duplicate definitions seem odd, can we teach kernel-doc
> > to understand function args instead? Most obvious format which comes 
> > to mind:
> > 
> > 	* ...
> > 	* @config_init - Initialize the PHY, including after a reset.
> > 	* @config_init.phydev: The PHY device to initialize.
> > 	*
> > 	* Returns: 0 on success or a negative error code on failure.
> > 	* ...
> 
> It will be too many side quests to me for now. I can streamline comments
> if there is agreement how it should look like. But fixing kdoc - I would
> leave it to the experts.

This is the fundamental problem with kernel-doc, when it's missing
something that really should already be there. It's not like we're
the first to use function pointers in structs - that's a thing that
the kernel has been doing for decades.

I also have no desire to attempt to fix kernel-doc - I know absolutely
nothing about the formatting programs used by kernel-doc (I don't do
any of the "pretty" stuff - when writing stuff for OLS, I had to learn
whatever typesetting system AJH wanted and quickly forgot it
afterwards.) The amount of time that would need to be invested is
beyond what I'm willing to put in - and it would mean shelving
everything else that I'm working on while I did it. That includes me
stopping doing patch reviews while I'm trying to get that sorted.
Given that I've already had Christmas/New Year break from that and
now have a massive backlog. No. Just no. It's just unreasonable to
expect kernel-doc to be fixed in this regard by people who know
nothing about it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

