Return-Path: <netdev+bounces-84872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3430289881D
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BC01F21CA7
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AB73D962;
	Thu,  4 Apr 2024 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1V4wskUx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2982B1272BA
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234497; cv=none; b=uYx0eAH8SuoCfPHXYZ0m9PXoX6pVRiGjHXghTx6hnqSVV3f2LnV9AEINs27aVt5bABcG9p+cKyc7W523cvOOLZBH7GtCjZ3H9uBG9AucTYHnb3uKaL0Fws3K83iNlPbUVHqWVW5yFscxbGYaITuHVcPsmxL/nu33Z3eEy/VpouI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234497; c=relaxed/simple;
	bh=EDpuG8zGKbGLMmh6lVrhr2xZIj/iNFM+udrjNrot1Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXr7R7bqZr0clpW9LtsTcQm9SJ7m2SDleA7pvDkAjKu51w0ZuNUxnKjSGJu3zUzpqGSAYYQAP2YWRfTdM+uIXnBlpJpFHJd03cRW6M7qnx8bUqLqpQLkuowQpLrunkj3NIje/X6AtC9qNvVp1olkdy6unoN+tmZhk9l5oZ0jhHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1V4wskUx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0GWXF19l2v2KdKHnirquaOjP6gMk5YsmJFnThI4qqTA=; b=1V4wskUxJLGAU0JhXkyAktcsob
	bCHDzGVeowFzuQHCnfF81rMafY989GcqqnekWrB1Dkw7ttjTiM+GmCFOdUHRAWTPyF3C5kbQeq9K7
	CU4Eixm4uBKuXsE3lP3CLqIt7PpUslipovhG9K0XUckV+XuezmywNB8b6Lao0JWGSwn4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rsMPK-00CBOa-6W; Thu, 04 Apr 2024 14:41:30 +0200
Date: Thu, 4 Apr 2024 14:41:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: Re: [PATCH 2/3] net: dsa: microchip: lan937x: force RGMII interface
 into PHY mode
Message-ID: <595d9272-6add-44a6-874c-5b5878049e3a@lunn.ch>
References: <20240403180226.1641383-1-l.stach@pengutronix.de>
 <20240403180226.1641383-2-l.stach@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403180226.1641383-2-l.stach@pengutronix.de>

On Wed, Apr 03, 2024 at 08:02:25PM +0200, Lucas Stach wrote:
> The register manual and datasheet documentation for the LAN937x series
> disagree about the polarity of the MII mode strap. As a consequence
> there are hardware designs that have the RGMII interface strapped into
> MAC mode, which is a invalid configuration and will prevent the internal
> clock from being fed into the port TX interface.
> 
> Force the MII mode to PHY for RGMII interfaces where this is the only
> valid mode, to override the inproper strapping.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/net/dsa/microchip/lan937x_main.c | 11 +++++++++++
>  drivers/net/dsa/microchip/lan937x_reg.h  |  3 +++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
> index 6a20cbacc513..04fa74c7dcbe 100644
> --- a/drivers/net/dsa/microchip/lan937x_main.c
> +++ b/drivers/net/dsa/microchip/lan937x_main.c
> @@ -217,6 +217,17 @@ void lan937x_config_cpu_port(struct dsa_switch *ds)
>  		if (dev->info->cpu_ports & (1 << dp->index)) {
>  			dev->cpu_port = dp->index;
>  
> +			/*
> +			 * Force RGMII interface into PHY mode, as that's the
> +			 * only valid mode, but it may be in MAC mode due to
> +			 * incorrect strapping.
> +			 */
> +			if (phy_interface_mode_is_rgmii(dev->ports[dp->index].interface)) {
> +				lan937x_port_cfg(dev, dp->index,
> +						 REG_PORT_XMII_CTRL_1,
> +						 PORT_MII_MODE_MAC, false);
> +			}
> +

This is for the CPU port only? That makes sense, the CPU side should
be using MAC mode.

What about when the port is not being used as a CPU port, but a user
port and has a PHY connected to it. I assume the documentation is
equally confusing in that case, and boards have it wrongly
strapped. So should there be similar code to force it into MAC mode?

	  Andrew

