Return-Path: <netdev+bounces-184105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C5EA93583
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849D3465FE8
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 09:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F10A20C037;
	Fri, 18 Apr 2025 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XploiAhZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434591EE7BE;
	Fri, 18 Apr 2025 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744969661; cv=none; b=BTonbPF98QFwwlfpvMCtE7FGJwRh8Yf3BbmWrAZM5aIkezhEEXnb84HQQ5fRIsKjiFecpqh+tU21MFsnSCRSDKpukT5SA4A/NwlDXikXY7uTCeV3u1lp0FLSbHTUIZp3sWp8LfzVVqRHwHc4usijR64b7aBG4X/VGglShqF+a9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744969661; c=relaxed/simple;
	bh=8jwykI53JCNbaSypwuG+RWUMk7PeGrgRcv18YEGTuFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/JCenbUYEkub8XdJKGoHgms66Tg4EuayP2kpZ4eUUSqmNeULcep/Ry/6coc2DCdSCJTkL6zMxI94fmf28SKnK3LAWDj5e08O1Upf3IJvT4rZiNY9/nYwYQmWk+JsEbnq6V+auk0amIg8T7cREJffuHZUU74M92sJSjcBOVXR3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XploiAhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07008C4CEE2;
	Fri, 18 Apr 2025 09:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744969660;
	bh=8jwykI53JCNbaSypwuG+RWUMk7PeGrgRcv18YEGTuFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XploiAhZxHhhESDDOzs6niwDsMekhlSF0KLhLxU2wLsTxoVAeV58dtipiIl03XwBi
	 pJwtAevjn8/bzF+azjXZhGxhvKuzNr1Ty1KpSfbgpIxK2ze8HwsrUHTltTbuIjiW6a
	 TF0YAZnAiL+OWrOZv9wJvP5WDFT0Hj4hdcEbgQ9mGy2gMW0ige/oE/b/EoZLL562Mh
	 Bn84R7NUJ95LnA3tdArAj/agRtmkw/0m3EaIsSF4o8Y1OEAglxES+nLywxxXi54cME
	 YZQJfSaaTe3kAqnaVi0qUqngAEReZcwyFYxyBDM+Tg9k82vuV2E4pHMh9bUl1XCUz2
	 4qz8CTkM+tw3g==
Date: Fri, 18 Apr 2025 10:47:35 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, upstream@airoha.com,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [net-next PATCH v3 03/11] net: pcs: Add subsystem
Message-ID: <20250418094735.GA2676982@horms.kernel.org>
References: <20250415193323.2794214-1-sean.anderson@linux.dev>
 <20250415193323.2794214-4-sean.anderson@linux.dev>
 <20250417091936.GB2430521@horms.kernel.org>
 <0bd8a9c0-4824-4c1f-bf32-ac1e57e2bea0@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bd8a9c0-4824-4c1f-bf32-ac1e57e2bea0@linux.dev>

On Thu, Apr 17, 2025 at 11:05:24AM -0400, Sean Anderson wrote:
> On 4/17/25 05:19, Simon Horman wrote:
> > On Tue, Apr 15, 2025 at 03:33:15PM -0400, Sean Anderson wrote:
> >> This adds support for getting PCS devices from the device tree. PCS
> >> drivers must first register with phylink_register_pcs. After that, MAC
> >> drivers may look up their PCS using phylink_get_pcs.
> >> 
> >> We wrap registered PCSs in another PCS. This wrapper PCS is refcounted
> >> and can outlive the wrapped PCS (such as if the wrapped PCS's driver is
> >> unbound). The wrapper forwards all PCS callbacks to the wrapped PCS,
> >> first checking to make sure the wrapped PCS still exists. This design
> >> was inspired by Bartosz Golaszewski's talk at LPC [1].
> >> 
> >> pcs_get_by_fwnode_compat is a bit hairy, but it's necessary for
> >> compatibility with existing drivers, which often attach to (devicetree)
> >> nodes directly. We use the devicetree changeset system instead of
> >> adding a (secondary) software node because mdio_bus_match calls
> >> of_driver_match_device to match devices, and that function only works on
> >> devicetree nodes.
> >> 
> >> [1] https://lpc.events/event/17/contributions/1627/
> >> 
> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> > 
> > Hi Sean,
> > 
> > I noticed a few build problems after sending my previous email.
> > 
> > I was able to exercise them using variants of the following to
> > generate small configs. I include this here in case it is useful to you.
> > 
> > make tinyconfig
> > 
> > cat >> .config << __EOF__
> > CONFIG_MODULES=y
> > CONFIG_NET=y
> > CONFIG_NETDEVICES=y
> > CONFIG_PCS=y
> > CONFIG_PHYLIB=m
> > __EOF__
> > 
> > cat >> .config << __EOF__
> > CONFIG_OF=y
> > CONFIG_OF_UNITTEST=y
> > CONFIG_OF_DYNAMIC=y
> > __EOF__
> > 
> > yes "" | make oldconfig
> > 
> > ...
> > 
> >> diff --git a/drivers/net/pcs/core.c b/drivers/net/pcs/core.c
> > 
> > ...
> 
> Thanks, I was able to reproduce/fix these issues.
> 
> How did you find these? By inspection?
> 
> I often end up missing build issues like this because I mostly
> test with everything enabled.

Hi Sean,

The issue regarding fwnode_mdio_find_device and PHYLIB as a module
came up with an automated allmodconfig W=1 build.

I came across the other issue, regarding CONFIG_OF_DYNAMIC, while
investigating the PHYLIB issue.  Basically running allmodconfig takes ages
on my development machine.  So I wanted to try coming up with a small
config, based on tinyconfig, that would reproduce the PHYLIB issue. And on
the way there - as you can see artifacts of in the configuration commands
above - I hit the CONFIG_OF_DYNAMIC issue.

My take on this is that it's good to test allmodconfig, although the build
can take ages. Especially if there is any risk of link failures. And, as
for other cases, perhaps there are standard ones that are worth exercising,
like with/without IPv6 support (probably not relevant to this patchset).
But otherwise I think we get down to waiting for the bots (or someone on
the ML) to happen to come across a broken (random?) configuration.

...

