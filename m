Return-Path: <netdev+bounces-229657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0773EBDF7E9
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 17:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8D518905A9
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE0C33439E;
	Wed, 15 Oct 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRPbp5o6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4B033438C;
	Wed, 15 Oct 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543748; cv=none; b=jna/6/Sx3RZ4qRn5Vk6M0X9fTgmqxQ3w3b6Wx8r/NdW1IhBjtEYQjkUk6SzgI4uHiBj3Os6DE+krVVKg3hJDovSdAlKPFW9C4WEwmNtHutw5ODfGhDJi5mIoSWjpYWJgqX8UBo/ck45cLDmjQLptCsCGku0p/A8dTWyRkWJnOsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543748; c=relaxed/simple;
	bh=OtK5voWcAdL/bSIr5aJ2h3Z25CnusKZJ0G6Htr86Y9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZIW5Z5IxG3UTlgln6lgyNcZG4De4flMk1W45IKNpqB5TzhN8eFLraieExM7aEnpQ0PS31k/4JJqnma4yeXKYZGeVGQTcEtceThR6QdsrA2JA3P+GJtvylDGxXIKNES9UhJGAaUPa9+ORL6DJ3vtrWA0mo3M/kXQX0WkbtKOaHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRPbp5o6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EB0C4CEF9;
	Wed, 15 Oct 2025 15:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760543748;
	bh=OtK5voWcAdL/bSIr5aJ2h3Z25CnusKZJ0G6Htr86Y9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sRPbp5o6qVOk2SDQ8eJyn/b+ynWlGPdkQUcgTZuU+ri1ltCzPZfShZCJtXG+0PLaL
	 SX5cNafCF06SX13gwpENJ4gH6u6sC5NQCfWsfLTSQcLznc6wkM2Iuad6XqovvPF7nI
	 BxWoeP9W9mUoUfeD4N3Xf6GocKriWFp90EKF5vVnTvkkR7/8Ro8g4/A8CUYa7Uvn0J
	 S2gtyfHsEy+5O77izo7wl42JLbSpBfUFtoWhM2Kjdt+Rz3/PWvud3eqvUxmJeipIHJ
	 oxMWsxkLoH+5v/D2t+dTDuUgiBZBjO2jyulVeI9p50CpXeQGBbvj+TH9PIdiEYYdeB
	 igk7h69kmMlig==
Message-ID: <1adfe818-c74f-4eb1-b9f4-1271c6451786@kernel.org>
Date: Wed, 15 Oct 2025 09:55:47 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: usb: lan78xx: fix use of improperly
 initialized dev->chipid in lan78xx_reset
To: I Viswanath <viswanathiyyappan@gmail.com>, Thangaraj.S@microchip.com,
 Rengarajan.S@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com
References: <20251013181648.35153-1-viswanathiyyappan@gmail.com>
Content-Language: en-US
From: Khalid Aziz <khalid@kernel.org>
In-Reply-To: <20251013181648.35153-1-viswanathiyyappan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 12:16 PM, I Viswanath wrote:
> dev->chipid is used in lan78xx_init_mac_address before it's initialized:
> 
> lan78xx_reset() {
>      lan78xx_init_mac_address()
>          lan78xx_read_eeprom()
>              lan78xx_read_raw_eeprom() <- dev->chipid is used here
> 
>      dev->chipid = ... <- dev->chipid is initialized correctly here
> }
> 
> Reorder initialization so that dev->chipid is set before calling
> lan78xx_init_mac_address().
> 
> Fixes: a0db7d10b76e ("lan78xx: Add to handle mux control per chip id")

How did you determine this is the commit that introduced this bug?

 From what I can see, commit a0db7d10b76e does not touch lan78xx_reset() 
function. This bug was introduced when devid was replaced by chipid 
(commit 87177ba6e47e "lan78xx: replace devid to chipid & chiprev") or 
even earlier when the order of calls to lan78xx_init_mac_address() and 
lan78xx_read_reg() was introduced in lan78xx_reset() depending upon if 
lan78xx_init_mac_address() at that time used devid in its call sequence 
at the time.

--
Khalid

> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
> ---
> v1:
> Link: https://lore.kernel.org/netdev/20251001131409.155650-1-viswanathiyyappan@gmail.com/
> 
> v2:
> - Add Fixes tag
> 
>   drivers/net/usb/lan78xx.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 42d35cc6b421..b4b086f86ed8 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -3247,10 +3247,6 @@ static int lan78xx_reset(struct lan78xx_net *dev)
>   		}
>   	} while (buf & HW_CFG_LRST_);
>   
> -	ret = lan78xx_init_mac_address(dev);
> -	if (ret < 0)
> -		return ret;
> -
>   	/* save DEVID for later usage */
>   	ret = lan78xx_read_reg(dev, ID_REV, &buf);
>   	if (ret < 0)
> @@ -3259,6 +3255,10 @@ static int lan78xx_reset(struct lan78xx_net *dev)
>   	dev->chipid = (buf & ID_REV_CHIP_ID_MASK_) >> 16;
>   	dev->chiprev = buf & ID_REV_CHIP_REV_MASK_;
>   
> +	ret = lan78xx_init_mac_address(dev);
> +	if (ret < 0)
> +		return ret;
> +
>   	/* Respond to the IN token with a NAK */
>   	ret = lan78xx_read_reg(dev, USB_CFG0, &buf);
>   	if (ret < 0)


