Return-Path: <netdev+bounces-75470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA15986A0EB
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 21:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462C11F2467B
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 20:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E850814A08F;
	Tue, 27 Feb 2024 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KnR8IC0X"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F19B51C4C
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066271; cv=none; b=AlzxGxFyxP3iMK7viwJxDWoFQfZY9ZyWBkrpSbsEiHeSOMZuJht+5MadSfi6YFKcdV7OUzDsO/2zQoPl43t5FUdJ6rRjQj65DKeFDbNlabiKCGMB5V7eD9ZVqOxFdBrV7/3FBjuKALukxTVG1rDT87c1yqjT7whadQOgD2izj9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066271; c=relaxed/simple;
	bh=Gk4C2aybVhLI4mduFhzKKLedRl5m4UXJJTjkImqSNTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SghWCVDenvFg9qKh/k51732D0op83433NJSTX0mct8oRvqKxnPuMwwNX/9efM1/i3F9MgEH3JS5VS4OKRVGVIhwo3rPGgYBstiqguf9hZ92YFnkLgFrU6qVoLFpcu+uxPpUwVbkaIFw1K4bbUNp1l0gxTkSXegDPEWnKnRM38xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KnR8IC0X; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nZU6Ol1wj9X1WeOMwzgnegH/2vn+30hINy6icETe54Q=; b=KnR8IC0XW7SlsOOvg0CoSlICI9
	cRsQxPkNVtnUFMrpBPb8pSOClSpA6ZdJtUSquNYt+omsqKD+izwN/h480cwbFC/4TStIgZwThULvu
	yT8ejvfFpKKTu0Gj3QS+ag8ywq8lSeOiGlYag/CWJesJWiAHb5gIUhQCpHmrbIzLveDQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rf4DB-008t4N-V5; Tue, 27 Feb 2024 21:38:01 +0100
Date: Tue, 27 Feb 2024 21:38:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	horms@kernel.org, Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 4/5] ice: Add
 tx_scheduling_layers devlink param
Message-ID: <332882f9-f23c-4528-9582-51e9aea49a92@lunn.ch>
References: <df7b6859-ff8f-4489-97b2-6fd0b95fff58@intel.com>
 <20240222150717.627209a9@kernel.org>
 <ZdhpHSWIbcTE-LQh@nanopsycho>
 <20240223062757.788e686d@kernel.org>
 <ZdrpqCF3GWrMpt-t@nanopsycho>
 <20240226183700.226f887d@kernel.org>
 <Zd3S6EXCiiwOCTs8@nanopsycho>
 <10fbc4c8-7901-470b-8d72-678f000b260b@intel.com>
 <327ae9b5-6e7d-4f8b-90b3-ee6f8d164c0d@lunn.ch>
 <Zd4IH1XUhC92zaVP@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd4IH1XUhC92zaVP@nanopsycho>

On Tue, Feb 27, 2024 at 05:04:47PM +0100, Jiri Pirko wrote:
> Tue, Feb 27, 2024 at 04:41:52PM CET, andrew@lunn.ch wrote:
> >> What if it would not be unique, should they then proceed to add generic
> >> (other word would be "common") param, and make the other driver/s use
> >> it? Without deprecating the old method ofc.
> >
> >If it is useful, somebody else will copy it and it will become
> >common. If nobody copies it, its probably not useful :-)
> >
> >A lot of what we do in networking comes from standard. Its the
> >standards which gives us interoperability. Also, there is the saying,
> >form follows function. There are only so many ways you can implement
> >the same thing.
> >
> >Is anybody truly building unique hardware, whos form somehow does not
> >follow function and is yet still standards compliant? More likely,
> >they are just the first, and others will copy or re-invent it sooner
> >or later.
> 
> Wait, standard in protocol sense is completely parallel to the hw/fw
> implementations. They may be (and in reality they are) a lots of
> tunables to tweak specific hw/fw internals. So modern nics are very
> unique. Still providing the same inputs and outputs, protocol-wise.

I think there is a general trickle down of technologies. What is top
of the line now, because normal everyday in 5 - 10 years time. Think
of a top of the line 10G Ethernet from 10 years ago. Is its design
that different to what you get integrated into today's SoC?  Are the
same or similar tunables from 10 year old top the line NICs also in
todays everyday SoCs?

Every PC is going to be an AI PC, if you believe the market hype at
the moment. But don't you think every PC will also have a network
processor of some sort in 5 - 10 years, derived from today network
processor. It will just be another tile in the SoC, next to the AI
tile, the GPU tile, and the CPU tiles. My guess would be, those
tunables in todays hardware will trickle down into those tiles in 5-10
years because they have been shown to be useful, they work, lets
re-use what we have.

       Andrew




