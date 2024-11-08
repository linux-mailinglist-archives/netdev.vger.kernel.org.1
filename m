Return-Path: <netdev+bounces-143440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2F09C2722
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 22:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67F33B2298C
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F74E1C1F34;
	Fri,  8 Nov 2024 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f0clrftO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C9D29CF4;
	Fri,  8 Nov 2024 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731102195; cv=none; b=tL59/H324cUK0Fg8OCy6rqEwGMykOqE0UFak3g/HtA9uYPJ52wSjVpkPzZUgjGKq1CxU8luVF8wCTwQGAOrkfDJdUkL8LogsSyuLcifAd2Dwrik/WymUsVTRhIsiUHvN7x6zkSJ82jLwlxzkShWlxAcOJLFJiROEUmvXZyC5Nj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731102195; c=relaxed/simple;
	bh=7ai3EhDD8kivSiHjwakaxR65JIFCmPtHFjyNVoxcZRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQ1hOcxyUE5nGS14QmYooeIafVDP41c8zmAdZpyUXwDj3VILa1EYH351YGAqbgNnSbF+1LGLrbMF3mlF0RLVN8tiI3y3HQB0vXHkyf+xcweHZ0ACfVSEWVWVTed8d/w3WqN7/+eKhpcQZtXePt6q9VPRWEigjTTqLIbfN5yAfuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f0clrftO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=a3sPOVQXRa4B3JPzvGMyA57zRKiA5BOrPR46D7NL24U=; b=f0clrftORSp8KdyrJxGYM6ROVz
	c1kNeDAlvnMt5V6JFgaOaHYe0zVOIfJv8Guw3MPRPH6lMcsE2vxhjhR5ued0GEhBrY5By1j2p0h0+
	NkSSZGjlNmPMb2OaHK9CnjxVA3cQINikQ+C8Atk0PonLIJCPtfBD+6j7zGYJKHe0FcIc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t9Wky-00CeZe-23; Fri, 08 Nov 2024 22:43:04 +0100
Date: Fri, 8 Nov 2024 22:43:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [net-next PATCH] net: dsa: add devm_dsa_register_switch()
Message-ID: <9cf08624-cd84-41bf-beef-ca3b3573303e@lunn.ch>
References: <20241108200217.2761-1-ansuelsmth@gmail.com>
 <af968377-d4c4-4561-8dc6-6f92ff1ebbf4@lunn.ch>
 <672e7a61.050a0220.1d1399.6d31@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <672e7a61.050a0220.1d1399.6d31@mx.google.com>

On Fri, Nov 08, 2024 at 09:53:48PM +0100, Christian Marangi wrote:
> On Fri, Nov 08, 2024 at 09:35:32PM +0100, Andrew Lunn wrote:
> > > +int devm_dsa_register_switch(struct device *dev, struct dsa_switch *ds)
> > > +{
> > > +	int err;
> > > +
> > > +	err = dsa_register_switch(ds);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	return devm_add_action_or_reset(dev, devm_dsa_unregister_switch, ds);
> > > +}
> > > +EXPORT_SYMBOL_GPL(dsa_register_switch);
> > 
> > This looks to be the wrong function name.
> >
> 
> Ah... Anyway aside from this, is the feature OK? Questioning why it
> wasn't proposed early...

Some people blindly make use of devm_ without thinking about
ordering. These helpers can introduce bugs. So they are not always
liked.

It would be best if you added the helper at the same time as its user.

	Andrew

