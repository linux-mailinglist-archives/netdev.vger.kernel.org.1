Return-Path: <netdev+bounces-174284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3A7A5E235
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE47F189E31E
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0774325484F;
	Wed, 12 Mar 2025 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYkX+FtI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6A3253B73;
	Wed, 12 Mar 2025 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741799157; cv=none; b=QCW/54Li2xTfay5ck6Ptg2C8O8kYHzvIrvCkTNQPe49AFZP84gT+UcBV4u0hHPMW9aPQPvwQAkAJfTateoRZhSmOagNAgbCw9ps+nClweBi7EpmCTuHcR9Yink5nUd/qYjxtXW41CZkC39XsnU7qu2pJBK5hheygx6vgTndUtZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741799157; c=relaxed/simple;
	bh=LXPq0F1Kt1oAn1lVx3bxrsOmLi3993rgPxkGU16ki0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnVVg4HOCBuVd52tThfDqOzEGpRulBPreGaM7oNcSaOgV2gtN3TqYs6QvB/p9fJa1mKQieUguP7uW2ortO+wN6KYedsbLKKO4USM6njrTctQ804O7W89+F3f97JuAYx34VeJEkzegiwi2tokB5YIrnGSYe1oViLENUwvLUS4MsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYkX+FtI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F06C4CEEA;
	Wed, 12 Mar 2025 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741799157;
	bh=LXPq0F1Kt1oAn1lVx3bxrsOmLi3993rgPxkGU16ki0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYkX+FtI4zXx9OYvx6/6TXS1gT+jC3X9UMrjTPd9qnkI3uCojU/8bMqoFrzg3meR2
	 u2FDelRmenI4gOTbTw6KZRZTNt2DRPdMgH+Tent7RobTby5y9gQBuw2pxMtJXZTYYL
	 61p8o7+MxZEnzKhkV3BNLEe7Zkehwlnt6v98mYsaE5P1AwJarBvHtvvm9Xbkv5kXs2
	 6RNjrreGEv43FbpW6c3N9QvYTZ6esFpQirMa1ZN+GVOkwRtX2cYneROT3mezs7wlbM
	 Xh5H3mCIf7s5FwnkpEUe6iQUb+NLIC1FgDF7ftqnF+PX1uKH/VeuthWVFlHLir8biP
	 nvw/1E05hVTEA==
Date: Wed, 12 Mar 2025 18:05:45 +0100
From: Simon Horman <horms@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 2/3] net: stmmac: dwmac-rk: Validate GRF and
 peripheral GRF during probe
Message-ID: <20250312170545.GV4159220@kernel.org>
References: <20250308213720.2517944-1-jonas@kwiboo.se>
 <20250308213720.2517944-3-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308213720.2517944-3-jonas@kwiboo.se>

On Sat, Mar 08, 2025 at 09:37:14PM +0000, Jonas Karlman wrote:
> All Rockchip GMAC variants typically write to GRF regs to control e.g.
> interface mode, speed and MAC rx/tx delay. Newer SoCs such as RK3576 and
> RK3588 use a mix of GRF and peripheral GRF regs. These syscon regmaps is
> located with help of a rockchip,grf and rockchip,php-grf phandle.
> 
> However, validating the rockchip,grf and rockchip,php-grf syscon regmap
> is deferred until e.g. interface mode or speed is configured, inside the
> individual SoC specific operations.
> 
> Change to validate the rockchip,grf and rockchip,php-grf syscon regmap
> at probe time to simplify all SoC specific operations.
> 
> This should not introduce any backward compatibility issues as all
> GMAC nodes have been added together with a rockchip,grf phandle (and
> rockchip,php-grf where required) in their initial commit.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Simon Horman <horms@kernel.org>

