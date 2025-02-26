Return-Path: <netdev+bounces-169917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89881A46762
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D487189384E
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D93221DA0;
	Wed, 26 Feb 2025 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R66MwYLJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A069621C9E8;
	Wed, 26 Feb 2025 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589032; cv=none; b=YQRKjKqfb8AA9LYQ/Q7AoMiKkCLxN3avUwazykfeTLsbctLW5OUlIx0n+mSFGJSOiqCQhrmz+cci6+WtFopuPlpsgN4xyerlmzlA/+bc1H6e/uWY7dHq4j+tDNemOCS2Cj8sGg1kNnsKoWUAIY5jK99izFPv67U2Va1CZMwRYSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589032; c=relaxed/simple;
	bh=3WAySbhme57idwUAMGNOyLnrc2/y3hBo3tmaf5OeDQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5OCRRu8DXZqPHuKt/7qgCroNeo8nC0OkIpezd4SjD1DLaeQk40g/BcP/EsHe8oTNyTSjyPkspu54cT0GhKBq79EoeWbX2zUPY3m3TMAi3mIJxH0D0dc0K6cJ2gQ1cCGYhCtKuCuiXVynY3ErqPTYKMZ0aY669PeJBxTRLXS37I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R66MwYLJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4DPt7QYp04Ry8rLHfov5JpGHMDqB3/VtlthfMAT+pZ4=; b=R66MwYLJidHJxRhnCf+eiGeZN5
	NuHhuLecYei0nkUnyQvusL+YSy2EIEie0vhOvFTGZQJj80P3nDErhnVUkaZByJeChLf2W5Jvl2GPX
	RoHDo9SkYGiz4rQa+f0OMvRT7ZECJt2d+dKbd8qfVH7a6vNT3Ag4LafQEdmEdfmfVQZA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tnKiR-000Jnk-0D; Wed, 26 Feb 2025 17:56:59 +0100
Date: Wed, 26 Feb 2025 17:56:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Martin Schiller <ms@dev.tdt.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for FS SFP-10GM-T copper
 SFP+ module
Message-ID: <3c4e6613-f7fc-4105-b4ce-d959769f2944@lunn.ch>
References: <20250226141002.1214000-1-ms@dev.tdt.de>
 <Z78neFoGNPC0PYjt@shell.armlinux.org.uk>
 <d03103b9cab4a1d2d779b3044f340c6d@dev.tdt.de>
 <20250226162649.641bba5d@kmaincent-XPS-13-7390>
 <b300404d2adf0df0199230d58ae83312@dev.tdt.de>
 <20250226172754.1c3b054b@kmaincent-XPS-13-7390>
 <daec1a6fe2a16988b0b0e59942a94ca9@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daec1a6fe2a16988b0b0e59942a94ca9@dev.tdt.de>

On Wed, Feb 26, 2025 at 05:51:42PM +0100, Martin Schiller wrote:
> On 2025-02-26 17:27, Kory Maincent wrote:
> > On Wed, 26 Feb 2025 16:55:38 +0100
> > Martin Schiller <ms@dev.tdt.de> wrote:
> > 
> > > On 2025-02-26 16:26, Kory Maincent wrote:
> > > > On Wed, 26 Feb 2025 15:50:46 +0100
> > > > Martin Schiller <ms@dev.tdt.de> wrote:
> > > >
> > > >> On 2025-02-26 15:38, Russell King (Oracle) wrote:
> > >  [...]
> > >  [...]
> > >  [...]
> > > >>
> > > >> OK, I'll rename it to sfp_fixup_rollball_wait.
> > > >
> > > > I would prefer sfp_fixup_fs_rollball_wait to keep the name of the
> > > > manufacturer.
> > > > It can't be a generic fixup as other FSP could have other waiting time
> > > > values
> > > > like the Turris RTSFP-10G which needs 25s.
> > > 
> > > I think you're getting two things mixed up.
> > > The phy still has 25 seconds to wake up. With sfp_fixup_rollball_wait
> > > there simply is an additional 4s wait at the beginning before we start
> > > searching for a phy.
> > 
> > Indeed you are right, I was looking in older Linux sources, sorry.
> > Still, the additional 4s wait seems relevant only for FS SFP, so it
> > should
> > be included in the function naming to avoid confusion.
> > 
> 
> You may be right for the moment. But perhaps there will soon be SFP
> modules from other manufacturers that also need this quirk.

Since these are all kernel internal implementation details, we can
rename them any time we want. There is no kernel ABI involved. So
please use a name based on what we know now. If such a module does
appear sometime in the future, we can change the name at that point.

       Andrew

