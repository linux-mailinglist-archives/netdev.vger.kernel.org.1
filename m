Return-Path: <netdev+bounces-97620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67AF8CC698
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 20:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5051F21E38
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 18:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD5714659C;
	Wed, 22 May 2024 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITzirOcR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF0814658A;
	Wed, 22 May 2024 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716404068; cv=none; b=T33ioNX7A3b6t/nghDNeFeCaJw6Z6u8F1HWQfOMQHE+Xco67Y+E2lIBynbkCpNxB6f/ob+4SiBWUfuuC1nu+3azKBka3JbxtH1bbyfCXzIlhojodXw3jfznwcnXSvgVMiofDpyanMDsfaEbzf6Oh1RoE5rLvm8T0oTlRa2mYhmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716404068; c=relaxed/simple;
	bh=DMRvf07peoglRNpptOpy9FxHymXTYhNp+h97lqVJS6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B24O3T/bFIlbYUFtbaLZ99hvL2755G7CjmXuBQnNCMfWEtasT7R+aeRcmk7BNIfaoivKS01LdHQ+b4RL1b6gZRejtmKUyF7C5HAXJZUbHaNj5i2i1/00azz5DlzSndJ4LNKwJhgdcIieIZpk71KScu5aTmb/QNV4irHcNE/Bu2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITzirOcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E3EC2BBFC;
	Wed, 22 May 2024 18:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716404067;
	bh=DMRvf07peoglRNpptOpy9FxHymXTYhNp+h97lqVJS6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ITzirOcR3vPpMjOihnD85nEB6qjNj0LyGkiC3ctz/sm6kRqyILGcgZY6wYaSz2VOL
	 gCLJTYZI07xOeNOmByYrR8e9W43tyeSoeUXkXO02W97oilFT3fdhHmCfBvMjysz+SU
	 6Ch1hoc5ezqFmnQ7sPf0vdek35wB+n1dZ7gj9KdEeEfEXLgoHdUqmK/x3C4y1EPtJg
	 hByMMAkSl26FKlyUCo47qqlGcRFCCh5AHbufrUFwrgVegVj54wYFwdNqSfVCDo2D8R
	 HovsY2XYjw40x7y74Pf/izyZ1Evib+57F1636U741gwc4Ied5S3N95EvR4CF6k9MeF
	 VI734pkgVbnYw==
Date: Wed, 22 May 2024 19:54:23 +0100
From: Simon Horman <horms@kernel.org>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: steve.glendinning@shawell.net, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: smsc95xx: configure external LEDs function for
 EVB-LAN8670-USB
Message-ID: <20240522185423.GC883722@kernel.org>
References: <20240522140817.409936-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522140817.409936-1-Parthiban.Veerasooran@microchip.com>

On Wed, May 22, 2024 at 07:38:17PM +0530, Parthiban Veerasooran wrote:
> By default, LAN9500A configures the external LEDs to the below function.
> nSPD_LED -> Speed Indicator
> nLNKA_LED -> Link and Activity Indicator
> nFDX_LED -> Full Duplex Link Indicator
> 
> But, EVB-LAN8670-USB uses the below external LEDs function which can be
> enabled by writing 1 to the LED Select (LED_SEL) bit in the LAN9500A.
> nSPD_LED -> Speed Indicator
> nLNKA_LED -> Link Indicator
> nFDX_LED -> Activity Indicator
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---
>  drivers/net/usb/smsc95xx.c | 12 ++++++++++++
>  drivers/net/usb/smsc95xx.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
> index cbea24666479..05975461bf10 100644
> --- a/drivers/net/usb/smsc95xx.c
> +++ b/drivers/net/usb/smsc95xx.c
> @@ -1006,6 +1006,18 @@ static int smsc95xx_reset(struct usbnet *dev)
>  	/* Configure GPIO pins as LED outputs */
>  	write_buf = LED_GPIO_CFG_SPD_LED | LED_GPIO_CFG_LNK_LED |
>  		LED_GPIO_CFG_FDX_LED;
> +
> +	/* Set LED Select (LED_SEL) bit for the external LED pins functionality
> +	 * in the Microchip's EVB-LAN8670-USB 10BASE-T1S Ethernet device which
> +	 * uses the below LED function.
> +	 * nSPD_LED -> Speed Indicator
> +	 * nLNKA_LED -> Link Indicator
> +	 * nFDX_LED -> Activity Indicator
> +	 */
> +	if (dev->udev->descriptor.idVendor == 0x184F &&
> +	    dev->udev->descriptor.idProduct == 0x0051)

Hi Parthiban,

There seems to be an endian missmatch here.
The type of .idVendor and .idProduct is __le16,
but here they are compared against host byte-order integers.

Flagged by Sparse.

> +		write_buf |= LED_GPIO_CFG_LED_SEL;
> +
>  	ret = smsc95xx_write_reg(dev, LED_GPIO_CFG, write_buf);
>  	if (ret < 0)
>  		return ret;

...

-- 
pw-bot: changes-requested

