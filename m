Return-Path: <netdev+bounces-163395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EF4A2A1C9
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711661887198
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 07:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58BF1FECBD;
	Thu,  6 Feb 2025 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0MK8jrjn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BB81FDA7E;
	Thu,  6 Feb 2025 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738825698; cv=none; b=k3lHWFfALerc6PHrlLBf58GLMF77zO47+XFt0eeQWD2f+214N8/RHqv0Uv6r+NFmWM+MoxFToHOvNEcowJoiosb027AcpbqenYIijGkaCnrzJyhUprSMhQrWfIMJ1G3+XO5OXlHLWoAf7sH8SsySRt8Odj0PbXFf8jbUQKXg93g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738825698; c=relaxed/simple;
	bh=HeWXmU4VCIrpiGA3pbenOLw3kZZeb/1o9MznZPgjZqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVoYGBZNidWa/iPU29afDyhacg9lHNmWnt5yljDuDgUaZLR6SHue5oduy3GIa774qEADLALXAU3aJ+wxedTz9RXerdQRpDh4wd5N0Lr7o1EMYI//uGKTFX+VGLR+HilPiCXOIT/zbRNh/QkslytnEZUTEA7aT4/CI4ONOgb2154=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0MK8jrjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79580C4CEE0;
	Thu,  6 Feb 2025 07:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738825698;
	bh=HeWXmU4VCIrpiGA3pbenOLw3kZZeb/1o9MznZPgjZqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0MK8jrjnKE0UC5T1+tipxAJnfcvKoRb1M/CJ51cV0dSii9K7gYBVQrkyOjBzqKX4J
	 CXvUVeqVu1cM10d2fbGO1S/eNMPWD5lsRRvbji4qWT5P0U5KiDdQzeEmcnvSl1YoJx
	 HhDDJnZmR6dllMk2dMP6IoSx0XB4frDgqmuyRKgM=
Date: Thu, 6 Feb 2025 08:07:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Santosh Puranik <spuranik@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net: mctp: Add MCTP USB transport driver
Message-ID: <2025020657-unsubtly-imbecile-faf4@gregkh>
References: <20250206-dev-mctp-usb-v1-0-81453fe26a61@codeconstruct.com.au>
 <20250206-dev-mctp-usb-v1-2-81453fe26a61@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206-dev-mctp-usb-v1-2-81453fe26a61@codeconstruct.com.au>

On Thu, Feb 06, 2025 at 02:48:24PM +0800, Jeremy Kerr wrote:
> Add an implementation for DMTF DSP0283, which defines a MCTP-over-USB
> transport. As per that spec, we're restricted to full speed mode,
> requiring 512-byte transfers.
> 
> Each MCTP-over-USB interface is a peer-to-peer link to a single MCTP
> endpoint, so no physical addressing is required (of course, that MCTP
> endpoint may then bridge to further MCTP endpoints). Consequently,
> interfaces will report with no lladdr data:
> 
>     # mctp link
>     dev lo index 1 address 00:00:00:00:00:00 net 1 mtu 65536 up
>     dev mctpusb0 index 6 address none net 1 mtu 68 up
> 
> This is a simple initial implementation, with single rx & tx urbs, and
> no multi-packet tx transfers - although we do accept multi-packet rx
> from the device.
> 
> Includes suggested fixes from Santosh Puranik <spuranik@nvidia.com>.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> Cc: Santosh Puranik <spuranik@nvidia.com>
> ---
>  drivers/net/mctp/Kconfig    |  10 ++
>  drivers/net/mctp/Makefile   |   1 +
>  drivers/net/mctp/mctp-usb.c | 367 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 378 insertions(+)
> 
> diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
> index 15860d6ac39fef62847d7186f1f0d81c1d3cd619..cf325ab0b1ef555e21983ace1b838e10c7f34570 100644
> --- a/drivers/net/mctp/Kconfig
> +++ b/drivers/net/mctp/Kconfig
> @@ -47,6 +47,16 @@ config MCTP_TRANSPORT_I3C
>  	  A MCTP protocol network device is created for each I3C bus
>  	  having a "mctp-controller" devicetree property.
>  
> +config MCTP_TRANSPORT_USB
> +	tristate "MCTP USB transport"
> +	depends on USB
> +	help
> +	  Provides a driver to access MCTP devices over USB transport,
> +	  defined by DMTF specification DSP0283.
> +
> +	  MCTP-over-USB interfaces are peer-to-peer, so each interface
> +	  represents a physical connection to one remote MCTP endpoint.
> +
>  endmenu
>  
>  endif
> diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
> index e1cb99ced54ac136db0347a9ee0435a5ed938955..c36006849a1e7d04f2cafafb8931329fc0992b63 100644
> --- a/drivers/net/mctp/Makefile
> +++ b/drivers/net/mctp/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
>  obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
>  obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
> +obj-$(CONFIG_MCTP_TRANSPORT_USB) += mctp-usb.o
> diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..f44e3d418d9544b45cc0369c3c3fa4d6ca11cc29
> --- /dev/null
> +++ b/drivers/net/mctp/mctp-usb.c
> @@ -0,0 +1,367 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * mctp-usb.c - MCTP-over-USB (DMTF DSP0283) transport binding driver.
> + *
> + * DSP0283 is available at:
> + * https://www.dmtf.org/sites/default/files/standards/documents/DSP0283_1.0.1.pdf
> + *
> + * Copyright (C) 2024 Code Construct Pty Ltd

It's 2025 :)

> +static void mctp_usb_out_complete(struct urb *urb)
> +{
> +	struct sk_buff *skb = urb->context;
> +	struct net_device *netdev = skb->dev;
> +	struct mctp_usb *mctp_usb = netdev_priv(netdev);
> +	int status;
> +
> +	status = urb->status;
> +
> +	switch (status) {
> +	case -ENOENT:
> +	case -ECONNRESET:
> +	case -ESHUTDOWN:
> +	case -EPROTO:
> +		mctp_usb_stat_tx_dropped(netdev);
> +		break;
> +	case 0:
> +		mctp_usb_stat_tx_done(netdev, skb->len);
> +		netif_wake_queue(netdev);
> +		consume_skb(skb);
> +		return;
> +	default:
> +		dev_err(&mctp_usb->usbdev->dev, "%s: urb status: %d\n",
> +			__func__, status);

This could flood the logs, are you sure you need it at dev_err() level?

And __func__ is redundant, it's present in dev_*() calls already.

> +static int mctp_usb_rx_queue(struct mctp_usb *mctp_usb)
> +{
> +	struct sk_buff *skb;
> +	int rc;
> +
> +	skb = netdev_alloc_skb(mctp_usb->netdev, MCTP_USB_XFER_SIZE);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	usb_fill_bulk_urb(mctp_usb->rx_urb, mctp_usb->usbdev,
> +			  usb_rcvbulkpipe(mctp_usb->usbdev, mctp_usb->ep_in),
> +			  skb->data, MCTP_USB_XFER_SIZE,
> +			  mctp_usb_in_complete, skb);
> +
> +	rc = usb_submit_urb(mctp_usb->rx_urb, GFP_ATOMIC);
> +	if (rc) {
> +		dev_err(&mctp_usb->usbdev->dev, "%s: usb_submit_urb: %d\n",
> +			__func__, rc);

Again, __func__ is redundant.  Same everywhere else in this file.

thanks,

greg k-h

