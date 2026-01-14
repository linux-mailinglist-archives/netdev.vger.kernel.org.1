Return-Path: <netdev+bounces-249972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 973C8D21C24
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 00:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E51BD300DD9E
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 23:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BEC37F8C4;
	Wed, 14 Jan 2026 23:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="YUg1qGLJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4B738B98A;
	Wed, 14 Jan 2026 23:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768433248; cv=none; b=oQQcB1yNIiw/RwBez30YQUfrjWwzsNeX6f17QI+YHc/DOT4R3W0y1dTi8JDy3F1r8Ww4k6nPyHpfFV4FxWlonJxiZMZMN2OwE62Sdbcj60YVJvHcXRLfzW3ZK5UVacqpAZ3Ek3KAFBR87G98JDrV53Ujc+YZ8bsz7No6d2viE8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768433248; c=relaxed/simple;
	bh=9L24GhxzhICNQ2dvNcp/Jkprwsjom4G4qj4MPdGw7j4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ET+Tc5lSIcIxDCfrcJrfTJ7ZjUhnw6knT35d/enp+YoOj57bEb+ynFilzdkuQc11hC9EbTUqkCnA0JAa2Jf7A2HgXty14paJdkzz4hAZAkHRQTSEYzJ7SXKhno38gl/YIIJj9UVzlPe4IOloet3GUhX+69VLWEddC3NqgAmCrXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=YUg1qGLJ; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2988210BED7;
	Thu, 15 Jan 2026 00:27:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768433233;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=IiEt5tJdQlHAgpu2iagQYFNv192gre7oSLS/ZJhMtzE=;
	b=YUg1qGLJSITou0JJmJWYIydNnCKQ1FkTkndzOlAplCVJORItwbrLJGylBFPxYUvrzwguKA
	88r+FXMfkjMQZyWds34VpeotYk0TorwZZ/wOWAJvlrLntLf9r423sH6R5u3kF6bFI5fTi6
	t/zJ7TqUpNjZI1gU2qzNc9IYc5yH5daf2Ax6np8YLkc/xkoHgxu5zL2yZcJu7KCF3yXm+Y
	Eq2MbN0RVOHKU4JX9BUTSYsM0SsKibe71KoAogQVM2Wdsqwx/dgZlQrdPgU6lFB8a0Sx7J
	PndaRF57SYoIC4rvW18yVEfDNt82vOkMitOcqIGTq5HFtE9srI9um8AO6BMPfA==
Message-ID: <6c9cadc2-67b7-4bfe-9cf7-2b102a0a3c21@nabladev.com>
Date: Thu, 15 Jan 2026 00:27:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH] net: stmmac: stm32: Do not suspend downed
 interface
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Christophe Roullier <christophe.roullier@st.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 kernel@dh-electronics.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20260114081809.12758-1-marex@nabladev.com>
 <aWfEXX1iMHy3V5sK@shell.armlinux.org.uk>
 <aWfOYf_YmJFUakvP@shell.armlinux.org.uk>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <aWfOYf_YmJFUakvP@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 1/14/26 6:12 PM, Russell King (Oracle) wrote:
> On Wed, Jan 14, 2026 at 04:29:17PM +0000, Russell King (Oracle) wrote:
>> On Wed, Jan 14, 2026 at 09:17:54AM +0100, Marek Vasut wrote:
>>> If an interface is down, the ETHnSTP clock are not running. Suspending
>>> such an interface will attempt to stop already stopped ETHnSTP clock,
>>> and produce a warning in the kernel log about this.
>>>
>>> STM32MP25xx that is booted from NFS root via its first ethernet MAC
>>> (also the consumer of ck_ker_eth1stp) and with its second ethernet
>>> MAC downed produces the following warnings during suspend resume
>>> cycle. This can be provoked even using pm_test:
>>>
>>> "
>>> $ echo devices > /sys/power/pm_test
>>> $ echo mem > /sys/power/state
>>> ...
>>> ck_ker_eth2stp already disabled
>>> ...
>>> ck_ker_eth2stp already unprepared
>>> ...
>>> "
>>>
>>> Fix this by not manipulating with the clock during suspend resume
>>> of interfaces which are downed.
>>
>> I don't think this is the correct fix. Looking back at my commits:
>> b51f34bc85e3 net: stmmac: platform: legacy hooks for suspend()/resume() methods
>> 07bbbfe7addf net: stmmac: add suspend()/resume() platform ops
>>
>> I think I changed the behaviour of the suspend/resume callbacks
>> unintentionally. Sorry, I don't have time to complete this email
>> (meeting.)
> 
> I think I'm going to start over, trying to figure out what happened.
> 
> c7308b2f3d0d net: stmmac: stm32: convert to suspend()/resume() methods
> 
> Did the conversion, and it always called stm32_dwmac_clk_disable() and
> where it exists, dwmac->ops->suspend() on suspend, provided
> stmmac_suspend() returns zero (which it will do, even if the interface
> is down. On resume, it always calls dwmac->ops->resume() and
> stm32_dwmac_init() before calling stmmac_resume().
> 
> The conversion added hooks into ny new ->suspend() and ->resume()
> methods to handle the stm32_dwmac_clk_disable(), dwmac->ops->suspend(),
> dwmac->ops->resume() and stm32_dwmac_init() steps.
> 
> However, in 07bbbfe7addf I failed to realise that, in order to keep
> things compatible with how stuff works, we need to call
> priv->plat->suspend() even if the interface is down. This is where
> the bug is, not in your glue driver.
> 
> Please try this:
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index a8a78fe7d01f..2acbb0107cd3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -8066,7 +8066,7 @@ int stmmac_suspend(struct device *dev)
>   	u32 chan;
>   
>   	if (!ndev || !netif_running(ndev))
> -		return 0;
> +		goto suspend_bsp;
>   
>   	mutex_lock(&priv->lock);
>   
> @@ -8106,6 +8106,7 @@ int stmmac_suspend(struct device *dev)
>   	if (stmmac_fpe_supported(priv))
>   		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
>   
> +suspend_bsp:
>   	if (priv->plat->suspend)
>   		return priv->plat->suspend(dev, priv->plat->bsp_priv);
>   
This works too, thank you.

Will you send this fix ?

