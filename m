Return-Path: <netdev+bounces-193088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B6FAC2787
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 18:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BBDE7BF04D
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E80296FAF;
	Fri, 23 May 2025 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rRtwtHAX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97BE296FAB;
	Fri, 23 May 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748017240; cv=none; b=C3N7ddmaVMvTNt2GPudbvlTEcfMZ8E1BOgy7B66Ws7nbzSKCBjTCFZjf7tI9JVTfWe+xYY7CDiKqjomnHmpHzR0aekMpmCuWF9TO4fYdjXQ/EoL7goNAf5FCcDKNkigJraH/5Vltu4axCkDIXArhjVGlBMCwugqB6Hg2va1PzZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748017240; c=relaxed/simple;
	bh=tesbHGkgXzuhnilgDGJ+QGtIb0twyTj+Ptw048NOGEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8iLMPaZAMQ5dQ0WzIeNjvU+oLQjcNq/+e5njCrzxHGBXXfALBcqW0mo3c3BwwLeht4T8PNaJNPV5KOO/Ypf/fOILukACqA/M+jZ7OuTo44PaRlxLkLT1BUj0kiJZ/RMnpxqxs1eWZHRm6acCgJptNuxM3gM8nMIXa7f05UZkQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rRtwtHAX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=FKSYcBDrAVeosFiXivZE6eLg3M7cJpM8m8qO+mm0CJw=; b=rR
	twtHAXcENvE9yW6v25dXUilX104IemQqVM7uHNhpLnfEdMBnz+GV0+AaooNJhCNj9WkBK/30N89v/
	zfdNuPB+qxeGf9ymvJWF5UGU9erpoRCQB+bxaE7CHJCeRq/EyzIArpOxfR7bdcI9JJtbTCTyQiqeW
	ekCkuM3pfbt1Liw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uIV81-00Dd47-36; Fri, 23 May 2025 18:20:13 +0200
Date: Fri, 23 May 2025 18:20:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?5p2O5ZOy?= <sensor1010@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, jonas@kwiboo.se,
	rmk+kernel@armlinux.org.uk, david.wu@rock-chips.com, wens@csie.org,
	u.kleine-koenig@baylibre.com, an.petrous@oss.nxp.com,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dwmac-rk: MAC clock should be truned off
Message-ID: <d5325aba-507e-47b6-83fb-b9156c1f351e@lunn.ch>
References: <20250523151521.3503-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250523151521.3503-1-sensor1010@163.com>

On Fri, May 23, 2025 at 08:15:21AM -0700, 李哲 wrote:
> if PHY power-on fails, clockassociated the MAC should
> be disabled during the MAC initialization process

The Subject: line has a typo.

> Signed-off-by: 李哲 <sensor1010@163.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 700858ff6f7c..036e45be5828 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1648,7 +1648,7 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
>  static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
>  {
>  	struct regulator *ldo = bsp_priv->regulator;
> -	int ret;
> +	int ret = 0;
>  	struct device *dev = &bsp_priv->pdev->dev;
>  
>  	if (enable) {
> @@ -1661,7 +1661,7 @@ static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
>  			dev_err(dev, "fail to disable phy-supply\n");
>  	}
>  
> -	return 0;
> +	return ret;

This does not make much sense to me. How do you get here with ret not
being 0?

    Andrew

---
pw-bot: cr

