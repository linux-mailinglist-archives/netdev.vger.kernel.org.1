Return-Path: <netdev+bounces-148750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609EB9E30D9
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 02:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCBF8B2269A
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 01:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EB5EADA;
	Wed,  4 Dec 2024 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dOXvOE5E"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193BF17C60;
	Wed,  4 Dec 2024 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733276409; cv=none; b=U/ZPTQIm6iwkQgzEfWki7PTtAD/RAkUUV6mktn7OBCTFvQaHsoNG8/4xGU5Kqt+RBTw/AJvseOmNjfnUp7gKXBAr7193nbw9vou14fXKWb9lAe6vjPoryOyBjUwyxQxwZBrmeQuNNRXrM7/1Hi4yq/6zJffF+PRS2a+eJPJnPhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733276409; c=relaxed/simple;
	bh=+fdGp0tfLKiul7gcilr3TCG47gTdfqjUtcz8Nhuezic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNhZGWlpXTRcolVZhd+WVVoPsEM3YJ6yOjmp7c1O4rOrjsD8LaGXoefpDf2Sy0qdZhIDdVob0fexnZQqXfbVCJSWoaLYfXw2F+LvGLkK86afvW+adYMG9d5hwajDwnUJOIaEv8eOhu/z2nOpK5Piiyq1XiJg12LlIUbnwSz/WeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dOXvOE5E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LtlNoXC2E/KYeWHUZCLBZfpMtcafZku+/XcAX0RRuoc=; b=dOXvOE5EXDDEC/nHFxtYakLK6l
	vGH32MrSj8hx/XnLkOFgYPknT4OwJFCkjdkcIR0D5rP+VZbfn46+eMXhrK+8wAijQ6Pi4BBI+g39Q
	lrByIWryrq+4pzY1GoDiXw9GiIWjeG8wmXDNL4qCNAlpovPmcp7lj9UxBk/4phHRimlY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIeMs-00F9Wd-VH; Wed, 04 Dec 2024 02:39:54 +0100
Date: Wed, 4 Dec 2024 02:39:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	richardcochran@gmail.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v5 3/5] net: phy: Kconfig: Add ptp library
 support and 1588 optional flag in Microchip phys
Message-ID: <67b0c8ac-5079-478c-9495-d255f063a828@lunn.ch>
References: <20241203085248.14575-1-divya.koppera@microchip.com>
 <20241203085248.14575-4-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203085248.14575-4-divya.koppera@microchip.com>

On Tue, Dec 03, 2024 at 02:22:46PM +0530, Divya Koppera wrote:
> Add ptp library support in Kconfig
> As some of Microchip T1 phys support ptp, add dependency
> of 1588 optional flag in Kconfig
> 
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
> ---
> v4 -> v5
> Addressed below review comments.
> - Indentation fix
> - Changed dependency check to if check for PTP_1588_CLOCK_OPTIONAL
> 
> v1 -> v2 -> v3 -> v4
> - No changes
> ---
>  drivers/net/phy/Kconfig | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 15828f4710a9..e97d389bb250 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -287,8 +287,15 @@ config MICROCHIP_PHY
>  
>  config MICROCHIP_T1_PHY
>  	tristate "Microchip T1 PHYs"
> +	select MICROCHIP_PHYPTP if NETWORK_PHY_TIMESTAMPING && \
> +				  PTP_1588_CLOCK_OPTIONAL
>  	help
> -	  Supports the LAN87XX PHYs.
> +	  Supports the LAN8XXX PHYs.
> +
> +config MICROCHIP_PHYPTP
> +	tristate "Microchip PHY PTP"
> +	help
> +	  Currently supports LAN887X T1 PHY

How many different PTP implementations does Microchip have?

I see mscc_ptp.c, lan743x_ptp.c, lan966x_ptp.c and sparx5_ptp.c. Plus
this one.

Does Microchip keep reinventing the wheel? Or can this library be used
in place of any of these? And how many more ptp implementations will
microchip have in the future? Maybe MICROCHIP_PHYPTP is too generic,
maybe you should leave space for the next PTP implementation?

	Andrew

