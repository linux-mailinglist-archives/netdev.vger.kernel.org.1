Return-Path: <netdev+bounces-240413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA04C7494B
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D55874E58B6
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 14:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF35C33B6ED;
	Thu, 20 Nov 2025 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PH83Dq1Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB43A33FE2B
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763648825; cv=none; b=RfftYNmhVtNA++6CV7QgFS2HQLujXuPa3dZ5C2XYGw7hhNTn0oL+WMUANNvwEIO25g5OeLphY2sltLlm901LFQ7XTy7qYo3l/vv8UafyB/whxOgtGfLYiAlQR3KtqffJWDQZW2DG6zRqXW0QA3Q2o6QbPzBA0S3SBB+6HqUxrRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763648825; c=relaxed/simple;
	bh=oJbE4whOASdh+8bRk/HsytKHkKG+HmcYnxmUcrLLYSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HCK8mQL9aSZ09C001Bqth8TJ4cgFnYGGMIp1ZN+3K9oW31ppIsG+eKCk8E/H0EvwBbZZNCjq6FW28w0G3LfZEK14eJFBcx30KjLp0Cp1YzaAEoGUalEI7nwl+O1HPL5mfChK0Z4h41KryPT7OWLROv+OjkY6pemY8jo78VCEfMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PH83Dq1Y; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 48BC5C111A1;
	Thu, 20 Nov 2025 14:26:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 834836068C;
	Thu, 20 Nov 2025 14:26:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7E37710371C50;
	Thu, 20 Nov 2025 15:26:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763648814; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=qhSEdyzC1I4mVfbpR7tEIxNfN51B9bJ3G/OVA1ZGy+4=;
	b=PH83Dq1Yzq50xd6WxvKIUx/T+7l9TX9VbHg9dLb6Oz5nvKlKdlC47SGOS/KILeMgYDDPCz
	meHwIgd1x0mEAlKica8tu+Dq2EAVLtxRajW8Jd/UlQm8jdY/pkxEB0ABELh3+Z2cxO3WGB
	SwIXJ5J/5hzGVe8vxUatZek1GiWULQtWJyYychK4sw9iaIsJt02dOR24b8mB0NtyrMlHZU
	7xVujetb0Z/JY67iMHWEvoIUBGznPemGymcGSgstWC8ZMFvL+zJY4dOP7hSzAqGVl1L3fd
	uRMFAtDHScg3efLvHeOPy6O+lsJX1F7Whg2CkAzRUaivrKQk4nCpT/n0Q/Hr8w==
Message-ID: <0123aef5-9d85-4794-b868-831544d2d63c@bootlin.com>
Date: Thu, 20 Nov 2025 15:26:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: mxl-gpy: fix bogus error on USXGMII and
 integrated PHY
To: Daniel Golle <daniel@makrotopia.org>, Xu Liang <lxu@maxlinear.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <f744f721a1fcc5e2e936428c62ff2c7d94d2a293.1763648168.git.daniel@makrotopia.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <f744f721a1fcc5e2e936428c62ff2c7d94d2a293.1763648168.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 20/11/2025 15:17, Daniel Golle wrote:
> As the interface mode doesn't need to be updated on PHYs connected with
> USXGMII and integrated PHYs, gpy_update_interface() should just return 0
> in these cases rather than -EINVAL which has wrongly been introduced by
> commit 7a495dde27ebc ("net: phy: mxl-gpy: Change gpy_update_interface()
> function return type"), as this breaks support for those PHYs.
> 
> Fixes: 7a495dde27ebc ("net: phy: mxl-gpy: Change gpy_update_interface() function return type")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

That looks correct indeed :)

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/phy/mxl-gpy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> index 0daf0e86844a0..0058284b08f3b 100644
> --- a/drivers/net/phy/mxl-gpy.c
> +++ b/drivers/net/phy/mxl-gpy.c
> @@ -541,7 +541,7 @@ static int gpy_update_interface(struct phy_device *phydev)
>  	/* Interface mode is fixed for USXGMII and integrated PHY */
>  	if (phydev->interface == PHY_INTERFACE_MODE_USXGMII ||
>  	    phydev->interface == PHY_INTERFACE_MODE_INTERNAL)
> -		return -EINVAL;
> +		return 0;
>  
>  	/* Automatically switch SERDES interface between SGMII and 2500-BaseX
>  	 * according to speed. Disable ANEG in 2500-BaseX mode.


