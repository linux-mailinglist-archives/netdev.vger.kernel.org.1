Return-Path: <netdev+bounces-136592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B54B59A242B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 15:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66451C21587
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BD81DE2C8;
	Thu, 17 Oct 2024 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow256nwb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E5A1DDA24
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172657; cv=none; b=c9Up0h6hWZ2yKXKYlWm5OiD4wGtzOzWIQ0CF2UXXbaNUevByyn0weqjLAix11uzhEK2v/84BbHhjTDVV48gWcPfbpXuxxUYl5A+9H1qGWhez9PY4IvALiPqIqNT5Tk3EyR2Ibt67CC4TrMdZ5SSuBAfae3/J5S1C/AdrAVek4eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172657; c=relaxed/simple;
	bh=sWUI0oKfv1YMt4PUlxHu4PInud4QtPGF/24Y65Qnp18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peSeV0YHXFkuMgpZuGJ8O+poW6DEZoYkcKveoE34dPi88q2p9/Nj+7uhBSGIEcav97C8k2frAEVx4UC1rsWq7cg1DPkr7mL5RwSLxhB/qCHykVROZsbYbrQw6tj17GJWhRG0IdFiKTFFzrj/hkroBnswvAzGuB168RUot2ksSJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow256nwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3715FC4CEC7;
	Thu, 17 Oct 2024 13:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729172656;
	bh=sWUI0oKfv1YMt4PUlxHu4PInud4QtPGF/24Y65Qnp18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ow256nwbD27yzO4sb/P6MikHRm3HEAiZUPsxbnUCC8Nja/5bkvz7LQJx4MNqG/8+V
	 9vnq+bcleGVe1HpDhbDEWI0VPDeCEx6xKs8Gu/odApzAfxFJ4ghpr6hU3YM96UorwR
	 1GuxNjAHqalVO04q7xfYMMd0vYi2rWbeCbyn2hXKmgp7AA3rwn3L4cX0BksHVnYecX
	 sD63+Np+PBOl5YtSkEAXlC+OxtZ4GUHWLq/+FMPYEZ/mPqFKcn0uUzch4l/6dwh9EQ
	 NLfucExVCF5y9Ai6eCphvq2hDpynSf5uc8RxK3yk9SDEnh0LO5zbOpahKnUDxWDBnx
	 QKraxLD3GheBg==
Date: Thu, 17 Oct 2024 14:44:13 +0100
From: Simon Horman <horms@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Greg Thelen <gthelen@google.com>,
	John Sperbeck <jsperbeck@google.com>
Subject: Re: [RFC] net: usb: usbnet: fix name regression
Message-ID: <20241017134413.GL1697@kernel.org>
References: <20241015140442.247752-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015140442.247752-1-oneukum@suse.com>

On Tue, Oct 15, 2024 at 04:03:32PM +0200, Oliver Neukum wrote:
> The fix for MAC addresses broke detection of the naming convention
> because it gave network devices no random MAC before bind()
> was called. This means that the check for the local assignment bit
> was always negative as the address was zeroed from allocation,
> instead of from overwriting the MAC with a unique hardware address.
> 
> The correct check for whether bind() has altered the MAC is
> done with is_zero_ether_addr
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> Reported-by: Greg Thelen <gthelen@google.com>
> Diagnosed-by: John Sperbeck <jsperbeck@google.com>
> Fixes: bab8eb0dd4cb9 ("usbnet: modern method to get random MAC")
> ---
>  drivers/net/usb/usbnet.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index ee1b5fd7b491..44179f4e807f 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -1767,7 +1767,8 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
>  		// can rename the link if it knows better.
>  		if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
>  		    ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
> -		     (net->dev_addr [0] & 0x02) == 0))
> +		     /* somebody touched it*/
> +		     !is_zero_ether_addr(net->dev_addr)))

Hi Oliver,

I think works for the case where a random address will be assigned
as per the cited commit. But I'm unsure that is correct wrt
to the case where ->bind assigns an address with 0x2 set in the 0th octet.

Can that occur in practice? Perhaps not because the driver would
rely on usbnet_probe() to set a random address. But if so then
it would previously have hit the "eth%d" logic, but does not anymore.

>  			strscpy(net->name, "eth%d", sizeof(net->name));
>  		/* WLAN devices should always be named "wlan%d" */
>  		if ((dev->driver_info->flags & FLAG_WLAN) != 0)
> -- 
> 2.47.0
> 
> 

