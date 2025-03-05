Return-Path: <netdev+bounces-172153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 777C8A505E0
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 18:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93CE318871F8
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C2119C542;
	Wed,  5 Mar 2025 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GQoWGHo/"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11B8151992;
	Wed,  5 Mar 2025 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194185; cv=none; b=nU1AGw5ojbk/2l8R4gjxlEoRBBjqrhrVlIKxymsVRUDOnMi6HQweTfhbtdLPuSaPZhiC4o1jUAp819eXzNkpkpmwxqIUfk5X9/gQqJgE4cY4pMq1ZG9h/xB3dG870HquhpdCefsNFbV2c2Mz02xKPpMLCNeCmj+H1vtfwRMhRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194185; c=relaxed/simple;
	bh=OcJoKzORqXVnDNepmErBN3tw8ndKhUmT6pwHugKrtRw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKXh5xD96t8enb+pmJq9GDvjnVI1kkyRLMELFxAdNT3doce6uuy9yI2XsKtdCg1e952YoPyheLVrsRW9vyTa3/qXC2vo2mJu0M1sgF/zgv+NWaR0tkF3epOTWYVSk00d18wXCnWb7Hs61i3ayvp1njRhseA/OcOmUdXfGUD0sVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GQoWGHo/; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A0845443F3;
	Wed,  5 Mar 2025 17:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741194175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TPyWHc+8KiHi21EkIlCnv3oAaCqNgg8vVnv8v5oHtoM=;
	b=GQoWGHo/UcXuWM5+M2p+ufkz2NxvtTKkX7cXWb9rICvOTm1tE0DFBFqym0cuD3G6YbSQ16
	iCwOa+FsBbPlIBYpNlJJzXTucmSoJxeBLxn97OiC/9rZfVoeBdhfkVVnQfTOby5xGMNLuS
	Gc0tU0Hqrz4xXQa0Yxqkdy91z6FBY5s60ckVmysNr+UxZqCfEVBYPyY5tCxc40eTRGGsI2
	puejnC5ToaRwTYbRqIwhvaVB0XQOD7aEhLMcxmixXcnur2OtwlgyyQ5bYynaYkmR7ow908
	bYwafXGx20/WcvxkXmrXEekb0CPkjgcQq9BnfSow+NJLiR8gb1SnFbCLZTA4qw==
Date: Wed, 5 Mar 2025 18:02:52 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next 0/7] net: ethtool: Introduce ethnl dump helpers
Message-ID: <20250305180252.5a0ceb86@fedora.home>
In-Reply-To: <20250305141938.319282-1-maxime.chevallier@bootlin.com>
References: <20250305141938.319282-1-maxime.chevallier@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehfeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepteefgeehvdeitdeihfeuvdejkeevkeekieefkedvjefhudfhheeiveeuveefhefhnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtp
 hhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

On Wed,  5 Mar 2025 15:19:30 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Hi everyone,
> 
> This series adds some scaffolding into ethnl to ease the support of
> DUMP operations.
> 
> As of today when using ethnl's default ops, the DUMP requests will
> simply perform a GET for each netdev.
> 
> That hits limitations for commands that may return multiple messages for
> a single netdev, such as :
> 
>  - RSS (listing contexts)
>  - All PHY-specific commands (PLCA, PSE-PD, phy)
>  - tsinfo (one item for the netdev +  one per phy)
> 
>  Commands that need a non-default DUMP support have to re-implement
>  ->dumpit() themselves, which prevents using most of ethnl's internal  
>  circuitry.
> 
> This series therefore introduces a better support for dump operations in
> ethnl.
> 
> The patches 1 and 2 introduce the support for filtered DUMPs, where an
> ifindex/ifname can be passed in the request header for the DUMP
> operation. This is for when we want to dump everything a netdev
> supports, but without doing so for every single netdev. ethtool's
> "--show-phys ethX" option for example performs a filtered dump.
> 
> Patch 3 introduces 3 new ethnl ops : 
>  ->dump_start() to initialize a dump context
>  ->dump_one_dev(), that can be implemented per-command to dump  
>  everything on a given netdev
>  ->dump_done() to release the context  
> 
> The default behaviour for dumps remains the same, calling the whole
> ->doit() path for each netdev.  
> 
> Patch 4 introduces a set of ->dump_start(), ->dump_one_dev() and
> ->dump_done() callback implementations that can simply be plugged into  
> the existing commands that list objects per-phy, making the 
> phy-targeting command behaviour more coherent.
> 
> Patch 5 uses that new set of helpers to rewrite the phy.c support, which
> now uses the regulat ethnl_ops instead of fully custom genl ops. This
> one is the hardest to review, sorry about that, I couldn't really manage
> to incrementally rework that file :(
> 
> Patches 6 and 7 are where the new dump infra shines, adding per-netdev
> per-phy dump support for PLCA and PSE-PD.
> 
> We could also consider converting tsinfo/tsconfig, rss and tunnels to
> these new ->dump_***() operations as well, but that's out of this
> series' scope.
> 
> I've tested that series with some netdevsim PHY patches that I plan to
> submit (they can be found here [1]), with the refcount tracker
> for net/netns enabled to make sure the lock usage is somewhat coherent.
> 
> Thanks,
> 
> Maxime
> 
> [1]: https://github.com/minimaxwell/linux/tree/mc/netdevsim-phy
> 

This series will very likely conflict with Stanislav's netdev lock
work [2], I'll of course be happy to rebase should it get merged :)

Thanks,

Maxime

[2]: https://lore.kernel.org/netdev/20250305163732.2766420-1-sdf@fomichev.me/T/#t

> 
> Maxime Chevallier (7):
>   net: ethtool: netlink: Allow per-netdevice DUMP operations
>   net: ethtool: netlink: Rename ethnl_default_dump_one
>   net: ethtool: netlink: Introduce command-specific dump_one_dev
>   net: ethtool: netlink: Introduce per-phy DUMP helpers
>   net: ethtool: phy: Convert the PHY_GET command to generic phy dump
>   net: ethtool: plca: Use per-PHY DUMP operations
>   net: ethtool: pse-pd: Use per-PHY DUMP operations
> 
>  net/ethtool/netlink.c | 161 ++++++++++++++------
>  net/ethtool/netlink.h |  46 +++++-
>  net/ethtool/phy.c     | 335 ++++++++++++------------------------------
>  net/ethtool/plca.c    |  12 ++
>  net/ethtool/pse-pd.c  |   6 +
>  5 files changed, 277 insertions(+), 283 deletions(-)
> 


