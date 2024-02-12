Return-Path: <netdev+bounces-70985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B438E85178B
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43672B24005
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38B13BB31;
	Mon, 12 Feb 2024 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MalMCpQl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A063C470
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750285; cv=none; b=Ii5mn0uh3LhfKXmQOKqhG5Z2Pz/YLy9sGtiWWOyo0eHY3iaiD9PW+iEDr2rvs1iARHD8OjA65NgYNApqUwfs3QtoR5DZ4egZ22urYm28JGv7tosf/SkZxPTujgfKSlPbvfg5oFBBuyCj/97cI7EfFClgiH/OyTFfXjEjFGNGXOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750285; c=relaxed/simple;
	bh=yh6ZKlSX1r20omH75kMUlbMfzXzyWo2wbq6VxdkvgZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNnxzID1Yr2LhnzfTmjLjktxM5EMAN1wxzABNkZ5YfhHv6ZgllMK0TwnycpIOAS/Fbuv4tnCYpNIFJOI1xgIX3xldGtN5C+e/qm80BHKyeIF4gsLwqAydk3vZjIQPyZ6b+uRZ833a9HwedOP4/iViqJzrBZt6DO7R3ZGQXsEoJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MalMCpQl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=P0foI5vy8BrIAPazg0/dV3T9wLi9D9nhZun+gyYj8+4=; b=Ma
	lMCpQlLTiAcestcp84AoqiV3h7+TmQi9Fizao+dV+3t+UfMWeCjvyAGrV/NrNl3nvLtSCQP62+8J9
	NzO85ApMf1lXRyzTdHWSuwBOD6DrR5SJVGejbD+YjKD/nQovUlZaEUZClxLYAhas2xxKa3aOiehVn
	LYsz2nPXw9+VilI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZXrW-007aJD-0E; Mon, 12 Feb 2024 16:04:50 +0100
Date: Mon, 12 Feb 2024 16:04:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] net: fec: Refactor: #define magic constants
Message-ID: <cfc31be3-935d-432f-aa7a-38976c7ca954@lunn.ch>
References: <20240209091100.5341-1-csokas.bence@prolan.hu>
 <2f855efe-e16f-4fcb-8992-b9f287d4bc22@lunn.ch>
 <a7b8df0b-fc24-441e-b735-7bf319608e99@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7b8df0b-fc24-441e-b735-7bf319608e99@prolan.hu>

On Mon, Feb 12, 2024 at 03:49:42PM +0100, Csókás Bence wrote:
> Hi!
> 
> 2024. 02. 09. 14:53 keltezéssel, Andrew Lunn írta:
> > > @@ -1181,7 +1194,7 @@ fec_restart(struct net_device *ndev)
> > >   	if ((fep->pause_flag & FEC_PAUSE_FLAG_ENABLE) ||
> > >   	    ((fep->pause_flag & FEC_PAUSE_FLAG_AUTONEG) &&
> > >   	     ndev->phydev && ndev->phydev->pause)) {
> > > -		rcntl |= FEC_ENET_FCE;
> > > +		rcntl |= FEC_RCR_FLOWCTL;
> > 
> > This immediately stood out to me while looking at the diff. Its not
> > obvious why this is correct. Looking back, i see you removed
> > FEC_ENET_FCE, not renamed it.
> 
> What do you mean? I replaced FEC_ENET_FCE with FEC_RCR_FLOWCTL, to make it
> obvious that it represents a bit in RCR (or `rcntl` as it is called on this
> line). How is that not "renaming" it?

Going from FEC_NET_ to FEC_RCR_ in itself makes me ask questions. Was
it wrong before? Is this actually a fix? Is it correct now, or is this
a cut/paste typo? Looking at the rest of the patch there is no obvious
answer. As i said, you deleted FEC_ENET_FCE, but there is no
explanation why.

So what i'm asking for is obviously correct patches. You can add the
#defines, and replace (1 << X) with one of the new macros, and it
should be obvious.

However, the change above is not obviously correct, so some
explanation is required. And it is easier to do that in a patch
dedicated to this change, with a good explanation.

	Andrew

