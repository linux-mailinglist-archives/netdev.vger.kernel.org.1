Return-Path: <netdev+bounces-96511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E72628C6467
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08FE1F22880
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 10:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B3D5A0E0;
	Wed, 15 May 2024 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOw6kXVG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0BC54645
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715767257; cv=none; b=UQ6K/J5kQ/AeO6LSP1XO2KW2yNWI3gJIWf+exbBckamXSeUlT6bokmLotcudYryGynIS2rFbMoPmwYIDt03+GJQ1TDnbHztEW51e+3Js4v0jXEBCNxSv3b0dMnJAGtPnjTYOlNOA1idNg9l/mpZxdWqmSkZ7IMmYFWGOMedSK8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715767257; c=relaxed/simple;
	bh=OQt5BKbrhIH2ZgBoRGnN+3jz5lpNpLmyz2UVS9A5AvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaoD1Rs3/jhiMoMg8j4K4YtlStSUZqdguUDgSGUAkc0/SHq1Hj0dtv6umiXmHeub3Ds0Y6fe3AxcxiCv6m/yAGbBPoQuozu5JOGoBomC5+t587UiUCYEP89J4VFPmzs5ySffXczMN4+3VGegGxyf8t5uRa1x4aHJZiTzTMk3vQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOw6kXVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39159C116B1;
	Wed, 15 May 2024 10:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715767257;
	bh=OQt5BKbrhIH2ZgBoRGnN+3jz5lpNpLmyz2UVS9A5AvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sOw6kXVGPVln4zeWGLhId4LvRN9y+2UwUPTVFg82FdHYuxr2VRUSdW0JnWWFbjU2Y
	 W1rEc/o6tQhnRlCXJOfqQwaNURcQBmvtoJqzM3AcXxsz86kpn70WAvGYwbLrTx/Qfw
	 7J6UsMK7i54W7/VlkGOS9yeIgs70ejbGAZmEXK96zAwybVzkIHFW1nP0Ph4VZhw/+1
	 SON8mJwoMahWc0kb518mNdYseV75pq4ExtQvobsVOETG+xuE+VbEX5c2B6hWpYZN9c
	 luGhwi1xjRKzYx7Z7bwohfzMT+xJeAzYvKLhgKNdfz7sI+UT03k/sxLOBWj+6LG2Dr
	 qB8/XFFf69EVA==
Date: Wed, 15 May 2024 11:00:54 +0100
From: Simon Horman <horms@kernel.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH] net: dsa: lan9303: imply SMSC_PHY
Message-ID: <20240515100054.GC154012@kernel.org>
References: <20240514122605.662767-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514122605.662767-1-alexander.sverdlin@siemens.com>

On Tue, May 14, 2024 at 02:26:03PM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Both LAN9303 and LAN9354 have internal PHYs on both external ports.
> Therefore a configuration without SMSC PHY support is non-practical at
> least and leads to:
> 
> LAN9303_MDIO 8000f00.mdio:00: Found LAN9303 rev. 1
> mdio_bus 8000f00.mdio:00: deferred probe pending: (reason unknown)
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Hi Alexander,

Thanks for your patch.

As an enhancement - as opposed to a fix - this patch should be
targeted at the net-next kernel. And it's best to explicitly note that
in the subject.

	Subject: [PATCH net-next] ...

As it happens, net-next is currently closed for the v6.10 merge window.
Please consider reposting as a PATCH once net-next re-opens, after 27th May.

In the meantime, feel free to post new versions as you get feedback,
but please switch to posting as RFC during that time.

Link: https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: defer

