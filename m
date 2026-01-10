Return-Path: <netdev+bounces-248727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C405D0DAA1
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 20:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF59130090F4
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 19:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3648850276;
	Sat, 10 Jan 2026 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/5rCS30"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136B1500955
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768071654; cv=none; b=IbhO0IsGBVZj34BDcmeAc8/RyTI1lPpsPRKclSlJWvzMGwlngLU6yo7kQvih+RukLOzcqjtYSkAN8EKu5NrjlznjOFZgEcniiIh7e9ZuE0gILG6fzF+KdC6HO1wefeo313ML1SNgAnDBsQVUS7BL14YAZzBaWW10Xt6UF6uzlkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768071654; c=relaxed/simple;
	bh=VD3guD1KU+N6pRQuDUlT6DEsq+CnrW4ILj320ZBPmNo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7QHQ/i/ooqWk33yC2ywKSD3SivmHRa9oKRGZIBu5KFBANTRgvb6hfKD5gv+O/XmQXEtj/SyfsKjVe4QiIm8t+W71y64q1t+b2puMSUyStiKzKJKaP9MNxe2NXrbZYGqojarPZr6Cj68T06Q7dSl3C+Keq9HA2L3+31rb5uxIdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/5rCS30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E38C4CEF1;
	Sat, 10 Jan 2026 19:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768071653;
	bh=VD3guD1KU+N6pRQuDUlT6DEsq+CnrW4ILj320ZBPmNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K/5rCS30fzLrIvib+j1oN9w7TcNkmivJgXna3XockMICKnekw8MdeiaZqMsaF0qr1
	 eWWzfmdvfqBFN16yTMkYblTdCCa9noOXB74q0x32LuM/sI84SiFwf3nQ6Mp0XEWVEe
	 uiruJyalc4i3p/RkpkZD89kFQS9amQqtdbr6y8tlX3V2rULpW7MMAuHvZOp8f4LXrU
	 w2zGkQd94cpdwghDFPNNrs0/H1/3mL+rYS+8TI6OpwiMqZ36GY+bCEB++4C2RZ84YY
	 3GRlZbxF6HdPFb4WH1ptU30pyR7JeOSvxU005oE3cQmenN/mgzKe04NtOwciq1H3u4
	 nxOCYtdxhMyAA==
Date: Sat, 10 Jan 2026 11:00:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, David Miller
 <davem@davemloft.net>, Vladimir Oltean <vladimir.oltean@nxp.com>, Michael
 Klein <michael@fossekall.de>, Daniel Golle <daniel@makrotopia.org>, Realtek
 linux nic maintainers <nic_swsd@realtek.com>, Aleksander Jan Bajkowski
 <olek2@wp.pl>, Fabio Baltieri <fabio.baltieri@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: phy: realtek: add PHY driver for
 RTL8127ATF
Message-ID: <20260110110052.5d986893@kernel.org>
In-Reply-To: <20260110105740.53bca2cb@kernel.org>
References: <52011433-79d3-4097-a2d3-d1cca1f66acb@gmail.com>
	<492763d9-9ece-41a1-a542-d09d9b77ab4a@gmail.com>
	<20260108172814.5d98954f@kernel.org>
	<6b1377b6-9664-4ba7-8297-6c0d4ce3d521@gmail.com>
	<20260110105740.53bca2cb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Jan 2026 10:57:40 -0800 Jakub Kicinski wrote:
> On Sat, 10 Jan 2026 18:23:06 +0100 Heiner Kallweit wrote:
> > On 1/9/2026 2:28 AM, Jakub Kicinski wrote:  
> > > How would you feel about putting this in include/net ?
> > > Easy to miss things in linux/, harder to grep, not to
> > > mention that some of our automation (patchwork etc) has
> > > its own delegation rules, not using MAINTAINERS.    
> > 
> > Just sent a v2 with the new header moved to new include/net/phy/.
> > patchwork is showing a warning rgd a missing new MAINTAINERS entry.
> > However this new entry is added with the patch:
> > 
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9416,6 +9416,7 @@ F:	include/linux/phy_link_topology.h
> >  F:	include/linux/phylib_stubs.h
> >  F:	include/linux/platform_data/mdio-bcm-unimac.h
> >  F:	include/linux/platform_data/mdio-gpio.h
> > +F:	include/net/phy/
> >  F:	include/trace/events/mdio.h
> >  F:	include/uapi/linux/mdio.h
> >  F:	include/uapi/linux/mii.h
> > 
> > Bug in the check?  
> 
> My reading of it was basically that it's upset that realtek PHYs don't
> have a dedicated maintainer. The check considers the PHY subsystem as
> too large for the same people to cover core and all the drivers.
> If that's the case then the check is working as expected.
> It's just flagging the sub-optimal situation to the maintainers.
> 
> I wasn't sure if you'd be willing to create a dedicated MAINTAINERS
> entry for Realtek PHYs. The check itself is safe to ignore in this case.

PS FWIW the check is our replacement for the utterly useless checkpatch
check that asks for a MAINTAINERS entry every time a new file is added.
I wanted to mute that without feeling guilty for ignoring a potentially
useful suggestion so I coded up a more intelligent check which asks for
MAINTAINERS entry only if the file doesn't fall under any reasonably
sized entry already.

