Return-Path: <netdev+bounces-120413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA1895937A
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 06:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5531F21F4F
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 04:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB49132105;
	Wed, 21 Aug 2024 04:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="K47NG8/K"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885EC1581FC;
	Wed, 21 Aug 2024 04:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724212809; cv=none; b=MMzUub8tgVOW//xNZhe0yG9VlnQP61vNCNUmv0UzvJc+yLNwEVN/CWmiQ71iZElwkYkn0rJtXRdd2bFJYksiPH44hPg4h1GmPWtSSMcAARiqDXhhzluZIoMNAiL5YIhIKNDGH/Y27a3SSpAVKFcPbj6fzaln6pQJMYtkjrV13WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724212809; c=relaxed/simple;
	bh=tlYDBmVUvdtKpGCCQ0l3EL1ZJkNIEMsSlJFVtsEgWeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSGEVUkRTY52R+2vYiW6H4hD2huokRiLXSpHuIQ3WXqrId20BbtySxaMQ0nPVxcN50c8wbuUGlaRefEhyystNu3jItIxlgl2zZSxJpG8DsZ3Uetpa52/xTWFAF4eKRiQ8MJOj8U8J+iiX0DTx/m90PJq8zyl0TmkGHgcyTqKkLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=K47NG8/K; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 090B388100;
	Wed, 21 Aug 2024 05:59:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724212800;
	bh=neL7Th0r4qrYSD1+ULhiVt7E9UU4mmUUNjx81Zq3YxQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K47NG8/KV0IwiUEQ84X/o+7RTqn78eLI7fxVyUXQ8oK7VVRbKQNZbNPEEaJ3eVayu
	 3tZ9rkh9eMHjZkapM2z5XM/yLeiTmOjFvm/Mheb898T0FyWbqo6Hy37Sf4Fto6RueO
	 K/Hyq8slWItI+UOZEptKOko1tQq+H3aVHIy2++87wgkLPcm16TMC77l6GMaGiUPQjl
	 5XhGVjRHSJMkf0o6t6nOBuV9PsuThH7LhBAD2RM73hn/YUSIUnyzJB63TlCORILHk/
	 lL8ntXG+hgaZTfq8zOOKiVuPTmO/dUc87X1uL8Tf9kwDaxUbtMWhdx5HLA1IlTGPjv
	 F0EEcyuX+ZoWg==
Message-ID: <95f514f6-7445-41ee-a18b-ce558ee15849@denx.de>
Date: Wed, 21 Aug 2024 05:54:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: realtek: Fix setting of PHY LEDs Mode B bit on
 RTL8211F
To: Sava Jakovljev <sjakovljev@outlook.com>
Cc: savaj@meyersound.com, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <PAWP192MB21287372F30C4E55B6DF6158C38E2@PAWP192MB2128.EURP192.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAWP192MB21287372F30C4E55B6DF6158C38E2@PAWP192MB2128.EURP192.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/21/24 4:16 AM, Sava Jakovljev wrote:
> From: Sava Jakovljev <savaj@meyersound.com>
> 
> The current implementation incorrectly sets the mode bit of the PHY chip.
> Bit 15 (RTL8211F_LEDCR_MODE) should not be shifted together with the
> configuration nibble of a LED- it should be set independently of the
> index of the LED being configured.
> As a consequence, the RTL8211F LED control is actually operating in Mode A.
> Fix the error by or-ing final register value to write with a const-value of
> RTL8211F_LEDCR_MODE, thus setting Mode bit explicitly.
> 
> Fixes: 17784801d888 ("net: phy: realtek: Add support for PHY LEDs on RTL8211F")
> 
> Signed-off-by: Sava Jakovljev <savaj@meyersound.com>
> ---
>   drivers/net/phy/realtek.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index 87865918dab6..25e5bfbb6f89 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -555,7 +555,7 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
>   				       unsigned long rules)
>   {
>   	const u16 mask = RTL8211F_LEDCR_MASK << (RTL8211F_LEDCR_SHIFT * index);
> -	u16 reg = RTL8211F_LEDCR_MODE;	/* Mode B */
> +	u16 reg = 0;
>   
>   	if (index >= RTL8211F_LED_COUNT)
>   		return -EINVAL;
> @@ -575,6 +575,7 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
>   	}
>   
>   	reg <<= RTL8211F_LEDCR_SHIFT * index;
> +	reg |= RTL8211F_LEDCR_MODE;	 /* Mode B */

Nice find, thanks !

Reviewed-by: Marek Vasut <marex@denx.de>

