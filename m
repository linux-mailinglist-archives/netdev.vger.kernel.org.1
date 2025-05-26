Return-Path: <netdev+bounces-193485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3824AC433B
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 19:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7F31898031
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 17:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E64A1DE4E1;
	Mon, 26 May 2025 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XoUVqXbD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADEE3595E;
	Mon, 26 May 2025 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748279138; cv=none; b=jjS7Ktct5r6M5x/N2+MIOQNVpztIbDPpIxxDptCSGZAqN4zaTaK6TYzb8ctruXtat2ZI4oL3UGGoPwJIe89nNqZpLB5DA2+ihnxoT2hVe3e6J2j5QIKzrw7dN27Ui55LuecQNRk3whioOMCuBRZKUV7IEQ+86Kf3/42pSoPsL9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748279138; c=relaxed/simple;
	bh=2r09ZL1bCTQmL/cpFFMHd1f3HLc1NZRxd6L/oMrN2Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkCR5DNb9+m6043w4JuUHYTIADQECdhrnZUq7gPennYyjFlYOPzU31AwNVDeB+E3r80dx9cMQloWjewF4DFnN0z37V7zgsvH2AhJNmSSVG7u3bqNn2Dyaz6dpjMSspdsKYPddZPNxiyN6Plhpnn5fHwLauPpRCcNWotFMlvKZc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XoUVqXbD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ioFZifM8dRn5AWzFoATN3MruIDugkGoasnnViHSdO4U=; b=Xo
	UVqXbDL5alO3ZRLdDwEsTqGkuUqfngzF3nvIPtjcGk64MlCq1PrAgzorqFFgRmkQiKcYOWOq+F9v+
	ciFpZNU1tQJNrb87mAtHPoAgDUVNViOZiyJsZ1wzXvyKB5jZ9Gn4mOqigWuKnuzzpyxAfQtT7WzQM
	tjqlmt2Gnp+lw+0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uJbG8-00E117-QC; Mon, 26 May 2025 19:05:08 +0200
Date: Mon, 26 May 2025 19:05:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?5p2O5ZOy?= <sensor1010@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, jonas@kwiboo.se,
	rmk+kernel@armlinux.org.uk, david.wu@rock-chips.com, wens@csie.org,
	jan.petrous@oss.nxp.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dwmac-rk: No need to check the return value of the
 phy_power_on()
Message-ID: <e178677c-c8aa-462b-8d12-e0b4b8b6c7b7@lunn.ch>
References: <20250526161621.3549-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250526161621.3549-1-sensor1010@163.com>

On Mon, May 26, 2025 at 09:16:21AM -0700, 李哲 wrote:
> since the return value of the phy_power_on() function is always 0,
> checking its return value is redundant.
> 
> Signed-off-by: 李哲 <sensor1010@163.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 700858ff6f7c..6e8b10fda24d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1839,11 +1839,7 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>  		dev_err(dev, "NO interface defined!\n");
>  	}
>  
> -	ret = phy_power_on(bsp_priv, true);
> -	if (ret) {
> -		gmac_clk_enable(bsp_priv, false);
> -		return ret;
> -	}
> +	phy_power_on(bsp_priv, true);

I suggest you go one step further and turn phy_power_on() into a void
function.

net-next is closed for the next two week due to the merge window.

	Andrew

