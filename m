Return-Path: <netdev+bounces-249837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B90E8D1F010
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 14:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A111730963F0
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D7E39A7E3;
	Wed, 14 Jan 2026 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVt/ptqz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C253D13777E;
	Wed, 14 Jan 2026 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768396248; cv=none; b=MLkSWdJLGVv6otZIHpJMfrDzNdYYemB1gC2ggUGHse3BcJ5vUPwhI4Kretst2tbz1z8L9I0w4DglIztCc6gfaNa2OOvJ40cDORBShr/B9N8s7BNC0f3cQE/8jy0NpBfKwp8YdZQg8T+Rd6InOtC1UXKWl66cwJItx1c3hNkJ284=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768396248; c=relaxed/simple;
	bh=Lbi2dkKS+CDo0VctVbxA1brjkGK2rdj50pCjLj4bluA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8a5vjYqFTKjWXw16xZcKPo7BsDMe0JF1gN7iv/wqmTPHz/Owf+tw1Sqf4ZkTgrzYBYeM7t9dpMvCw0oxdE5t8P8kiUTRmoZ5FuczWWi+X5wQYgGW7Mn/Zor7w94ZD6HQHTcycdjOrlj1JpbpVO+WiqFtM9a3LGz4nJ5BF+A7mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVt/ptqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C188C4CEF7;
	Wed, 14 Jan 2026 13:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768396248;
	bh=Lbi2dkKS+CDo0VctVbxA1brjkGK2rdj50pCjLj4bluA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NVt/ptqz34aItSGZgocy9xdXCuD9dKmJxuyqSDXO0AMFnuI8NtXYLrQc5A9pu+SvU
	 gwBab5cCLYokIDGMQ5GOhl7HJHIbDXYxl8VKQem28J4zWopWXNeUmxNj6hhVhBbSls
	 Ybct1F1sWabl1HKOgTK1Hqve/iiqVkOzWCEkB+WjbruQ53Pw8Ti0eKOGnHfHajqo4X
	 upzATJnxuH8rICv9R+HRYJNRJ9FK0PSLf3HG+Y3ujcvrCCAyLaX41XFk+yGvFaaD37
	 qQIXCBmThqq9b4q/4dMcOUVJZZGjXc0AjrEIixMXjZaeeLKUuemzZmyoXDn2TPUu49
	 mCE86yrnxtdBw==
Date: Wed, 14 Jan 2026 18:40:44 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH v3 net-next 05/10] phy: add phy_get_rx_polarity() and
 phy_get_tx_polarity()
Message-ID: <aWeV1CEaEMvImS-9@vaman>
References: <20260111093940.975359-1-vladimir.oltean@nxp.com>
 <20260111093940.975359-6-vladimir.oltean@nxp.com>
 <87o6n04b84.fsf@miraculix.mork.no>
 <20260111141549.xtl5bpjtru6rv6ys@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260111141549.xtl5bpjtru6rv6ys@skbuf>

On 11-01-26, 16:15, Vladimir Oltean wrote:
> On Sun, Jan 11, 2026 at 12:53:15PM +0100, Bjørn Mork wrote:
> > Vladimir Oltean <vladimir.oltean@nxp.com> writes:
> > 
> > > Add helpers in the generic PHY folder which can be used using 'select
> > > GENERIC_PHY_COMMON_PROPS' from Kconfig
> > 
> > The code looks good to me now.
> > 
> > But renaming stuff is hard. Leftover old config symbol in the commit
> > description here. Could be fixed up on merge, maybe?
> > 
> > 
> > Bjørn
> 
> This is unfortunate. I'll let Vinot comment on the preferred approach,
> although I also wouldn't prefer resending to fix a minor commit message
> mistake. Thanks for spotting and for the review in general.

Yes fixed that while applying

-- 
~Vinod

