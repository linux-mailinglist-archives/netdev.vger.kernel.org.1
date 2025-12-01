Return-Path: <netdev+bounces-243048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ADEC98CD7
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 20:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CE1B4E320D
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 19:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FED922ACEB;
	Mon,  1 Dec 2025 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfEFJfVW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4069B21883E;
	Mon,  1 Dec 2025 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764615841; cv=none; b=bfdFaH9NvUOp3syju4MfCGDMwdJh6wGtPbX1UJjz/Z3NTliFe4j7ZjYbHvM4rRm832ZMWueDCjCMnDjmLnxh3evDh6DAuqyME/LWI1IGowBfy84Mf0y1Tn7k9AhHOcGnTXPvHv1lKJLdgMFFyYPUEavxMDe0dN+rPx5snFmLMuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764615841; c=relaxed/simple;
	bh=o+FCanS35An+MiDwhjJ8w/zhkp0tC/kZk0IrIBLdhJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkI6CQLd5emcntFiSEwvDDGPkOrzw+hPdVVKbjVewxOT/gRhiFIzj8R0v9hkoGqAxzS3KphT6BOgjGxPfWvP6+Xt30amU2VmW5/Ji4AYrTPCmxzdt/1G4puy3W3ltKsSKxmxMwNU9LcUoiyF9+59Rfs5sZNtb3vW5WQIRA1blxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfEFJfVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2750C113D0;
	Mon,  1 Dec 2025 19:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764615840;
	bh=o+FCanS35An+MiDwhjJ8w/zhkp0tC/kZk0IrIBLdhJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZfEFJfVWww3xEELw2OmQMyV36tKdSwDRtdofxmKQfb+ILyEXpPhPrUNkl5MMnvqdk
	 MeHgecGP2EhHmfAgvv4cg3ASh6ilA8h5W5ooFuflZZi0/2Tle/0ibXxbnDItRhMwBf
	 DyiYWSDS+Z74LDiwCXVOZE4rbj4OZxE9c9IQprfUrnef8s0TdGKK+7J61DS0IwlNy/
	 gneE8GMMGdaj/GSHF4HUhsFhpFBITU5tvY/NPYYgqw+RUhepWKj/qtMUshYwc2/avJ
	 z4/v4E+SwVV/7np/kW8g/FiFhIR+l/Qoonk0nHp4I+hBfxNx56o36KwMo5F6mIaYeI
	 NLv4o7cfZK56A==
Date: Mon, 1 Dec 2025 11:03:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Eric Woudstra
 <ericwouds@gmail.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Lee
 Jones <lee@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH net-next 5/9] phy: add phy_get_rx_polarity() and
 phy_get_tx_polarity()
Message-ID: <20251201110358.7618fee2@kernel.org>
In-Reply-To: <aS1T5i3pCHsNVql6@vaman>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
	<20251122193341.332324-6-vladimir.oltean@nxp.com>
	<20251124200121.5b82f09e@kernel.org>
	<aS1T5i3pCHsNVql6@vaman>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Dec 2025 14:07:58 +0530 Vinod Koul wrote:
> > > Push the supported mask of polarities to these helpers, to simplify
> > > drivers such that they don't need to validate what's in the device tree
> > > (or other firmware description).
> > > 
> > > The proposed maintainership model is joint custody between netdev and
> > > linux-phy, because of the fact that these properties can be applied to
> > > Ethernet PCS blocks just as well as Generic PHY devices. I've added as
> > > maintainers those from "ETHERNET PHY LIBRARY", "NETWORKING DRIVERS" and
> > > "GENERIC PHY FRAMEWORK".  
> > 
> > I dunno.. ain't no such thing as "joint custody" maintainership.
> > We have to pick one tree. Given the set of Ms here, I suspect 
> > the best course of action may be to bubble this up to its own tree.
> > Ask Konstantin for a tree in k.org, then you can "co-post" the patches
> > for review + PR link in the cover letter (e.g. how Tony from Intel
> > submits their patches). This way not networking and PHY can pull
> > the shared changes with stable commit IDs.  
> 
> How much is the volume of the changes that we are talking about, we can
> always ack and pull into each other trees..?

We have such ad-hoc situations with multiple subsystems. Letting
Vladimir and co create their own tree is basically shifting the 
work of managing the stable branches from netdev maintainers
downstream. I'd strongly prefer that we lean on git in this way, 
rather than reenact the 3 spiderman meme multiple times in each
release.

