Return-Path: <netdev+bounces-112763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C39B93B0B6
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 13:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B86F1C203B9
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 11:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6472156886;
	Wed, 24 Jul 2024 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o6i4Ba7o"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6395695;
	Wed, 24 Jul 2024 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721821774; cv=none; b=hasTGAOg2nQ8k0uKzvx1RbhZfom5h3sqf/l4kS2OLiya0CitYAjs9VFeu05gzedz1ripKP0FZuY8luFNKIw2jBvojCm9nP0x3PKj/OKZ3IhwmOQrLjEXO7eDFMvvEtwes1RZdoOSM8S2ainD6XYIaYhshLGnacRh16x4KH5XYdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721821774; c=relaxed/simple;
	bh=yDlumJKmEzhAKRjnL1qUjXcaVNhaH0K7mVcLUeQqiWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQmQ+F8wFzlekGoWt5KwREh3ENeWrjnGM4kmLNug+AApCwEz0ZNgFnPReucCID4Jmc/fgJ2z7Y3kvHIzQfcpfjoIVmU3UNQZGE3fx7auzBz8n5WcUNQedMGnZ3HGb9tNxb5G5CdEcPtxcFSjK6rbxoGV5GH+s6cla501GYdwk0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=o6i4Ba7o; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XnfSfb75bly186ZIDAtRd0JeKb7NNesu8aYFDkUskvA=; b=o6i4Ba7oXWczgyVPeJeCBG15IT
	c2988/t1yHGmz/cToeoN6L4NN/q+7m0q0ABG3WjGwUAp07o0xwz+gQjuHDowPa7pA5InNuBZ2ldIk
	pOp7wxJ3gW3pFdtbvu9Pi+IQ2A80/IAXQDGLQIRrMzI1dH18n0YZZZto+gSLRzDXavqE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sWaUc-00381H-OR; Wed, 24 Jul 2024 13:49:14 +0200
Date: Wed, 24 Jul 2024 13:49:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: lan78xx: add weak dependency with micrel phy
 module
Message-ID: <8a85af94-8911-44b8-9516-2f532cee607d@lunn.ch>
References: <20240724102349.430078-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724102349.430078-1-jtornosm@redhat.com>

On Wed, Jul 24, 2024 at 12:23:44PM +0200, Jose Ignacio Tornos Martinez wrote:
> The related module for the phy is loaded dynamically depending on the
> current hardware. In order to keep this behavior and have the phy modules
> available from initramfs, add a 'weak' dependency with the phy modules to
> allow user tools, like dracut, get this information.
> 
> Include micrel phy module because it is the hardware that I have. Other
> possible phy modules can be added later.
> 
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>  drivers/net/usb/lan78xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 8adf77e3557e..c3945aebf94e 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -5074,3 +5074,4 @@ module_usb_driver(lan78xx_driver);
>  MODULE_AUTHOR(DRIVER_AUTHOR);
>  MODULE_DESCRIPTION(DRIVER_DESC);
>  MODULE_LICENSE("GPL");
> +MODULE_WEAKDEP("micrel");

~/linux$ grep -r MODULE_WEAKDEP *
~/linux$ 

Is MODULE_WEAKDEP new?

It seems like a "Wack a Mole" solution, which is not going to
scale. Does dracut not have a set of configuration files indicating
what modules should be included, using wildcards? If you want to have
NFS root, you need all the network drivers, and so you need all the
PHY drivers?

    Andrew

