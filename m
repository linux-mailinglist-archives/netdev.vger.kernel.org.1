Return-Path: <netdev+bounces-84412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC4A896D50
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021AB1F2925C
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 10:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D1C139585;
	Wed,  3 Apr 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HR4EShQ0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F9E136989;
	Wed,  3 Apr 2024 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141614; cv=none; b=bYNwmp3mUKf1J++azYE0+YIhyvBdGdGeZ1XXIcBsuJbBTeLuhjmftAVsnHNvQ6jxGHtE2OS3KTKA7dkPdCfa+CtjEsUa3Ne3oYsKiK405C79yT9dEMM1cWgpM/xv8C+NYNy9dkalwCAqYPOOXkNQCz+W5jZes+l1LyI4wJF4FBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141614; c=relaxed/simple;
	bh=XNkWOejlRvAWF/q7Y6PYYLar1zGH/eI6IrEyzeOd7FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEzCjqrEQgErMVE6NnTXZmJFhvfe3TYHZMiHQXO0o9Mbh3Cx2r7XZPZ6h7FZIvyImtbfFLeBH2hAQiJeabIrdJanEbuloIbyYwoddike9R/36//EdgEMoIKYoOAwcRygqD2v7ao4jIq5KtD1nYzyS8KpznP9D/Td8EWZavqHeJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HR4EShQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F24EC433C7;
	Wed,  3 Apr 2024 10:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712141613;
	bh=XNkWOejlRvAWF/q7Y6PYYLar1zGH/eI6IrEyzeOd7FA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HR4EShQ0qslBmYvKmyDNwZAUhom9DkwwLZEjPqSOI4fGbC6JrmcArAHS3tcKtC98X
	 UcdJZ/rb1fYgS3YFBLni6FiQKw8Lgf9blU6Y1tWBKgMnqU2XJsZA5kdcAxnBwpkgLJ
	 SCCBA1WOUdBbtk+JBXi/o5G3NGWLvSWJMscFBOE82OGwTlcp5OJPLRliWngjrTqfsH
	 D/Z5R+bO6bWndop3x1R+dUt6ozrv2yWEOZ0dvNdsiC4bFzf/rWyTVX1ZOpET5uPJV0
	 yU039ZDDeLSG31GTgbNThnyUGwlXHErZF+EA1YG7VmvUtNRJD7xNXYE20jNH+JC93D
	 9u+ssRRfC7xsw==
Date: Wed, 3 Apr 2024 11:53:29 +0100
From: Simon Horman <horms@kernel.org>
To: Yi Yang <yiyang13@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, wangweiyang2@huawei.com
Subject: Re: [PATCH -next] net: usb: asix: Add check for usbnet_get_endpoints
Message-ID: <20240403105329.GV26556@kernel.org>
References: <20240402113048.873130-1-yiyang13@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402113048.873130-1-yiyang13@huawei.com>

On Tue, Apr 02, 2024 at 11:30:48AM +0000, Yi Yang wrote:
> Add check for usbnet_get_endpoints() and return the error if it fails
> in order to transfer the error.
> 
> Signed-off-by: Yi Yang <yiyang13@huawei.com>

Hi,

I am wondering if this is a fix for a user-visible problem and as such
should:
1. Be targeted at net
2. Have a Fixes tag
3. CC stable

See: https://docs.kernel.org/process/maintainer-netdev.html

> ---
>  drivers/net/usb/asix_devices.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
> index f7cff58fe044..11417ed86d9e 100644
> --- a/drivers/net/usb/asix_devices.c
> +++ b/drivers/net/usb/asix_devices.c
> @@ -230,7 +230,9 @@ static int ax88172_bind(struct usbnet *dev, struct usb_interface *intf)
>  	int i;
>  	unsigned long gpio_bits = dev->driver_info->data;
>  
> -	usbnet_get_endpoints(dev,intf);
> +	ret = usbnet_get_endpoints(dev, intf);
> +	if (ret)
> +		goto out;
>  
>  	/* Toggle the GPIOs in a manufacturer/model specific way */
>  	for (i = 2; i >= 0; i--) {
> @@ -834,7 +836,9 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
>  
>  	dev->driver_priv = priv;
>  
> -	usbnet_get_endpoints(dev, intf);
> +	ret = usbnet_get_endpoints(dev, intf);
> +	if (ret)
> +		goto mdio_err;
>  
>  	/* Maybe the boot loader passed the MAC address via device tree */
>  	if (!eth_platform_get_mac_address(&dev->udev->dev, buf)) {
> @@ -858,7 +862,7 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
>  		if (ret < 0) {
>  			netdev_dbg(dev->net, "Failed to read MAC address: %d\n",
>  				   ret);
> -			return ret;
> +			goto mdio_err;
>  		}
>  	}
>  

The two hunks above do not seem related to the subject of the patch, but
rather separate cleanups. So I think they should not be part of this patch.
Instead they could be a separate patch, targeted at net-next.  (FWIIW, I
would go the other way and drop the mdio_err label from this function.)

> @@ -871,7 +875,7 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
>  
>  	ret = asix_read_phy_addr(dev, true);
>  	if (ret < 0)
> -		return ret;
> +		goto mdio_err;
>  
>  	priv->phy_addr = ret;
>  	priv->embd_phy = ((priv->phy_addr & 0x1f) == AX_EMBD_PHY_ADDR);
> @@ -880,7 +884,7 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
>  			    &priv->chipcode, 0);
>  	if (ret < 0) {
>  		netdev_dbg(dev->net, "Failed to read STATMNGSTS_REG: %d\n", ret);
> -		return ret;
> +		goto mdio_err;
>  	}
>  
>  	priv->chipcode &= AX_CHIPCODE_MASK;
> @@ -895,7 +899,7 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
>  	ret = priv->reset(dev, 0);
>  	if (ret < 0) {
>  		netdev_dbg(dev->net, "Failed to reset AX88772: %d\n", ret);
> -		return ret;
> +		goto mdio_err;
>  	}
>  
>  	/* Asix framing packs multiple eth frames into a 2K usb bulk transfer */
> @@ -1258,7 +1262,9 @@ static int ax88178_bind(struct usbnet *dev, struct usb_interface *intf)
>  	int ret;
>  	u8 buf[ETH_ALEN] = {0};
>  
> -	usbnet_get_endpoints(dev,intf);
> +	ret = usbnet_get_endpoints(dev, intf);
> +	if (ret)
> +		return ret;
>  
>  	/* Get the MAC address */
>  	ret = asix_read_cmd(dev, AX_CMD_READ_NODE_ID, 0, 0, ETH_ALEN, buf, 0);
> -- 
> 2.25.1
> 
> 

