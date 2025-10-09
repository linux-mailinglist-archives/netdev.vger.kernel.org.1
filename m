Return-Path: <netdev+bounces-228363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97020BC8EE9
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 14:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1DF9634FE43
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 12:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA4125A659;
	Thu,  9 Oct 2025 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MHbU5HmK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AAB34BA39;
	Thu,  9 Oct 2025 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760011310; cv=none; b=XHZ2uWbnnDfOdTvnU2uwVYJ5BvGn6PuDibKnir1krw3Upjj7QU/f32Ph3cef25xCu8yhpkZhkqZN2F4nSnobMf7hJAQ/+/6nhfu1mu8E2yCvIXPrzwzfSFK1gGwYJFtJ3sygz+JvjM6P/433miTOA72jgWbQErBCxKVcdazxqLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760011310; c=relaxed/simple;
	bh=CH7kTHiDmOyxzRgbYOb9hmVWbEegeVJr1JmbiiNi5Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRMcctnCxe5jHolfTkYnFAXnhNIpgxJ/Qm+8wYGBrhgXC4egVrlFmXF9sHSJ/pwIDvvch3OiYUaNbOLwlQEsbDHZjHIMHINsnTJ17RvBlxPwRV49Rq5zXZ042F2RwV5rCcX58BEDvGJ7fpN2xiGnyd863Xh8Ewm9FT9cDAd7wHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MHbU5HmK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8LlCU7W/cV0oKcG/ryWNVdKjyAKHr5Ymu+LCbkU/UFk=; b=MHbU5HmKOR3mIBkwbL1bijWl+x
	N1IkT38vvlP03bHnZFSDmRZKnZtIbTlfp+Pw0AS5cgTm21GtKrDLl3F7gL5B0qzHC7TA/cBf8x0os
	lXtc0D3mHFGvv/lS8BZPGL3koM3TumwnjFtYjfXxT17CEhvH6CTPH0cmNqUz/SG5XTFY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v6pL2-00AWby-HD; Thu, 09 Oct 2025 14:01:40 +0200
Date: Thu, 9 Oct 2025 14:01:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: yicongsrfy@163.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	oneukum@suse.com, kuba@kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, yicong@kylinos.cn
Subject: Re: [PATCH] net: usb: r8152: add error handling in
 rtl8152_driver_init
Message-ID: <d108e379-da94-42a6-a60d-eba2f9531c1d@lunn.ch>
References: <20251009075833.103523-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009075833.103523-1-yicongsrfy@163.com>

On Thu, Oct 09, 2025 at 03:58:33PM +0800, yicongsrfy@163.com wrote:
> From: Yi Cong <yicong@kylinos.cn>
> 
> rtl8152_driver_init missing error handling.
> If cannot register rtl8152_driver, rtl8152_cfgselector_driver
> should be deregistered.
> 
> Fixes: ec51fbd1b8a2 ("r8152: add USB device driver for config selection")
> Signed-off-by: Yi Cong <yicong@kylinos.cn>
> ---
>  drivers/net/usb/r8152.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 44cba7acfe7d..a64bcb744fad 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -10122,7 +10122,14 @@ static int __init rtl8152_driver_init(void)
>  	ret = usb_register_device_driver(&rtl8152_cfgselector_driver, THIS_MODULE);
>  	if (ret)
>  		return ret;
> -	return usb_register(&rtl8152_driver);
> +
> +	ret = usb_register(&rtl8152_driver);
> +	if (ret) {
> +		usb_deregister_device_driver(&rtl8152_cfgselector_driver);
> +		return ret;
> +	}
> +
> +	return 0;
>  }

You can make this slightly simpler by replacing return 0; with
return ret;

    Andrew

---
pw-bot: cr

