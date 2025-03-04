Return-Path: <netdev+bounces-171540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A89FDA4D716
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 09:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E60B1899DC2
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 08:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C66200BBD;
	Tue,  4 Mar 2025 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XqUkLWDq"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE581FCFFE;
	Tue,  4 Mar 2025 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078406; cv=none; b=LThfFR+8qXE+4FucQd9fRmz8iNOwb2fPLhNw6tirWUX2Qwr9/bWu0Pedw+N1WsGDzBqdzLBbAE5ewQz7UXKNCxr2ajbmcuS6Q/XQzjLHPXz8Kk5+WDXaTRVS98P+CHfpYjbmmD23FkcOy72W20ezuXNBL4Nued8vSUEH3i14VaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078406; c=relaxed/simple;
	bh=rcNEMBRj7Zs8wkKgz90Xq7Las4XsD7eKUE2I/Wq/kD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2WF4zI/jzba2odwUXCsfVRAnOGhUtPdxjWPpB9/1VrCQtwT/tN/S0ESlgOKV5BETHfHDloX4ddbPG6JIHB1pbmlNd65bhm0qNK6thFplupUzyms7COTK2WXAQJena2X0uDvdT++4CUN1StCAONBs1PAU1u4rRMI026fPa94dp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XqUkLWDq; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8DBD9443D9;
	Tue,  4 Mar 2025 08:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741078401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7OS0LOkCHZYOvTzYUlUPDCBu1mJHvnSntjZBz82JaU=;
	b=XqUkLWDqe84uXl7cJWzGct2BwfVaESHXhXtPCBQJl84dwiPJA/bM785kb44C+jbPsnMWcw
	Cw+IL7XbITW4xWvVgSobe+4dOCUpaC2cHzfHQT1y4bp0KCRglUPZA4t47OQMam5eqU4Uxg
	y41tOs2ftiuCYXy6VcgobrVjVzP72cSxLLp5PXVyyQS+Ui4PeWL7tfe2FOV0FtsQn3yLkG
	JGLuHgo30+38mC0yFcESR/ssloLzppVnosNbrtHjNn2P1VQvFMglV+qgOEEnYxZQzrcclp
	cwwz7epKs+n7jlBKFwCRW4RJ1nx5Rp8emGPZBFL5LHLFh/N+9KU+usTezrPXew==
Date: Tue, 4 Mar 2025 10:52:39 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Parthiban Veerasooran
 <parthiban.veerasooran@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net v2] net: ethtool: netlink: Allow NULL nlattrs when
 getting a phy_device
Message-ID: <20250304105239.747500be@fedora.home>
In-Reply-To: <20250303161024.43969294@kernel.org>
References: <20250301141114.97204-1-maxime.chevallier@bootlin.com>
	<20250303161024.43969294@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdduheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkr
 ghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgrrhhthhhisggrnhdrvhgvvghrrghsohhorhgrnhesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Mon, 3 Mar 2025 16:10:24 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Sat,  1 Mar 2025 15:11:13 +0100 Maxime Chevallier wrote:
> > ethnl_req_get_phydev() is used to lookup a phy_device, in the case an
> > ethtool netlink command targets a specific phydev within a netdev's
> > topology.
> > 
> > It takes as a parameter a const struct nlattr *header that's used for
> > error handling :
> > 
> >        if (!phydev) {
> >                NL_SET_ERR_MSG_ATTR(extack, header,
> >                                    "no phy matching phyindex");
> >                return ERR_PTR(-ENODEV);
> >        }
> > 
> > In the notify path after a ->set operation however, there's no request
> > attributes available.
> > 
> > The typical callsite for the above function looks like:
> > 
> > 	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_XXX_HEADER],
> > 				      info->extack);
> > 
> > So, when tb is NULL (such as in the ethnl notify path), we have a nice
> > crash.
> > 
> > It turns out that there's only the PLCA command that is in that case, as
> > the other phydev-specific commands don't have a notification.
> > 
> > This commit fixes the crash by passing the cmd index and the nlattr
> > array separately, allowing NULL-checking it directly inside the helper.
> > 
> > Fixes: c15e065b46dc ("net: ethtool: Allow passing a phy index for some commands")
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>  
> 
> Well, this alone doesn't look too bad.. :) Hopefully we can address
> adding more suitable handlers for phy ops in net-next.

Yeah I'm cooking something to improve on that, and I have also dusted
off a netdevsim patch I had written back when working on the
phy_link_topology that adds very very basic PHY support so that we can
start covering all these commands with proper tests. I'll hopefully send
something in the coming week or so.

> Didn't someone report this, tho? I vaguely remember seeing an email,
> unless they said they don't want to be credited maybe we should add
> a Reported-by tag? You can post it in reply, no need to repost 
> the patch.

Parthiban reported this without CC: netdev, but I think it's fair to
add :

Reported-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>

I didn't include it in the first place because checkpatch complained
about a reported-by tag without a "Closes:", which we don't have
because of the private reporting :)

Thanks Jakub,

Maxime

