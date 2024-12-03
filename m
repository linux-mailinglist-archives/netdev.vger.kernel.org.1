Return-Path: <netdev+bounces-148331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E569E1222
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC795B21782
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F231816BE3A;
	Tue,  3 Dec 2024 03:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HhEgEOnw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A642AE68;
	Tue,  3 Dec 2024 03:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733198336; cv=none; b=uo3HGr3gUt70lcBSfw4JbnWS6R8bRncc0ucgB+k00t/58mqZ24/7lJFv45wJcKTc+jmrFuHw1QMi8EQ+QC42FRQhAl31rhYhb9qjE+fgAfp1eU36lECo3rOgAgrhT/xm7v/I7U3+DMmf4cD40Kq6o6WV37kWHRhirxK1D89Nltk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733198336; c=relaxed/simple;
	bh=AY2x933YZ4xG7PEmVaFKOs9Rak/pe/StSGnoy0PXKsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9f7qb1IY1cOb6hkdiElRvSE5EL8PGYHajvbFu+Kpk6I2CYI1wCZzsw+iXIwOJgQzagfBni3bbGF+rip0Nx65yVGXF21YrSiUBRHMWuFIuNn7wLM+A8z/8a4nKKGdb0pLPpS64OPDORau5mr0PmcIMibJaJYGRcju/7Uael9BeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HhEgEOnw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gn0agin/VwGWhvzp4v8FAhnRW+LE/8Yexk6/NYBn/nA=; b=HhEgEOnw1j0jWo3nZkTeTP26IC
	Rfd5Svdn9FGDHGH4kK2lLM7/iTYBL7GnHLpHTq7AAkTUtELMZTRLUzPk7cUnWt++kU2vEoXvIuFkz
	DIZbuCssXDLNb4MY2Boq+AikJDBqAIeFukfbIqUznR16L1sGgXoG6zgD313cOI30wrxU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIK3n-00F2tI-Ig; Tue, 03 Dec 2024 04:58:51 +0100
Date: Tue, 3 Dec 2024 04:58:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Zhiyuan Wan <kmlinuxm@gmail.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy.liu@realtek.com, Yuki Lee <febrieac@outlook.com>
Subject: Re: [PATCH v2 1/2] net: phy: realtek: disable broadcast address
 feature of rtl8211f
Message-ID: <cb8b5a36-fe5c-4b10-ac28-5f31f95262ab@lunn.ch>
References: <bc8c7c6a-5d5f-4f7c-a1e2-e10a6a82d50e@lunn.ch>
 <20241203034635.2060272-1-kmlinuxm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203034635.2060272-1-kmlinuxm@gmail.com>

On Tue, Dec 03, 2024 at 11:46:35AM +0800, Zhiyuan Wan wrote:
> This feature is enabled defaultly after a reset of this transceiver.
> When this feature is enabled, the phy not only responds to the
> configuration PHY address by pin states on board, but also responds
> to address 0, the optional broadcast address of the MDIO bus.
> 
> But some MDIO device like mt7530 switch chip (integrated in mt7621
> SoC), also use address 0 to configure a specific port, when use
> mt7530 and rtl8211f together, it usually causes address conflict,
> leads to the port of RTL8211FS stops working.
> 
> This patch disables broadcast address feature of rtl8211f when
> phy_addr is not 0. Solved address conflict with other devices
> on MDIO bus.
> 
> Reviewed-by: Yuki Lee <febrieac@outlook.com>
> Signed-off-by: Zhiyuan Wan <kmlinuxm@gmail.com>
> ---
>  drivers/net/phy/realtek.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index f65d7f1f3..9824718af 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -31,6 +31,7 @@
>  #define RTL8211F_PHYCR1				0x18
>  #define RTL8211F_PHYCR2				0x19
>  #define RTL8211F_INSR				0x1d
> +#define RTL8211F_PHYAD0_EN			BIT(13)
>  
>  #define RTL8211F_LEDCR				0x10
>  #define RTL8211F_LEDCR_MODE			BIT(15)
> @@ -377,12 +378,18 @@ static int rtl8211f_config_init(struct phy_device *phydev)

config_init is too late. You should be doing it in probe. It could be
the scan of the bus has found the PHY on the broadcast address, as
well as its proper address. When probe is called on the broadcast
address you want to return -ENODEV and disable broadcast. It will then
get probed again on its proper address.

	Andrew

