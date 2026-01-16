Return-Path: <netdev+bounces-250529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DE2D31C53
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E72473086348
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 13:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3A825FA3B;
	Fri, 16 Jan 2026 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mO1WBMx4"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11A2242D89;
	Fri, 16 Jan 2026 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569810; cv=none; b=NaOP5+TyOY6QNFnVEw7FvqiSiNSC+FqbMvjxExsIHPbMc278cw4xJxYI0jOxeqsCkv0rhEXH4jTDNCA0s+3H/ddpNpo3ddMlg+5IP4dlbnMVbHPIJ5Puewv/MIhK0RQxAFdsRPtmqTrQs1pCXItEWTJ6BMUVsxqAP9U3RMk7fQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569810; c=relaxed/simple;
	bh=cT/8NuzkzGrjwG1jMgB+JSPByhuBm8K6BAbyYFPTTJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3rV+DquvVE5RI9asMMVJVfXZew5+vrSVS7/yM7HECXuvtCV2fdKvdGqmmmZs1hGqZ6Tkd5qoyvdyui5KOqubYzfWmfuADHePJ06YIVdjND3ScI/OsrXeGsVvN9fY1lIhMB74B1od8MJ/X0Q/dusDVk0y5YljAF0kp0kdUklyXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mO1WBMx4; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2B829C1F1FA;
	Fri, 16 Jan 2026 13:22:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ED85660732;
	Fri, 16 Jan 2026 13:23:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DDDC010B68A9F;
	Fri, 16 Jan 2026 14:23:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768569805; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=3Zy3I3Z1lyQ5mxWhyHO58jSXgloubAzf4EepfVIFPcc=;
	b=mO1WBMx4dI07olS29FXnnlPYHidr/X44Z3YOgkPkiwckGE18SFdbwNi+0q/b0HHq6wSyGt
	3C0BpNRvqBy1RRIYZ9UxkZ83E5Nvpce/1asb5CmXTM1AzRVvnXgYJaSG2dmeVGVVGp9JEC
	xTashZJeBgjnAMX1Bgjh5BJbn07s5ZMMZ73VMmORgw9jBvwpjTARRYUXHpxXP/eCCyNqGw
	LdlM1hWzq4ADI1lWh4CYpNJf0fdCoYOTbLWUdyB7gW4pNTewY2PrvUbWNm3DRFYOZU//Gk
	shm0RMxGRQLCYIxELP/YXv2IZAd4ezsdYaPgDHHpFkO04ZLKT9MQTFp80XuDew==
Message-ID: <6a87648c-a1e8-49a2-a201-91108669ab44@bootlin.com>
Date: Fri, 16 Jan 2026 14:23:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] net: sfp: extend SMBus support
To: Jonas Jelonek <jelonek.jonas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
References: <20260116113105.244592-1-jelonek.jonas@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260116113105.244592-1-jelonek.jonas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jonas,

On 16/01/2026 12:31, Jonas Jelonek wrote:
> Commit 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
> added support for SMBus-only controllers for module access. However, this
> is restricted to single-byte accesses and has the implication that hwmon
> is disabled (due to missing atomicity of 16-bit accesses) and warnings
> are printed.
> 
> There are probably a lot of SMBus-only I2C controllers out in the wild
> which support more than just byte access. And it also seems that in
> several devices, SFP slots are attached to these SMBus controllers
> instead of full-featured I2C controllers. Right now, they don't work
> with SFP modules. This applies - amongst others - to I2C/SMBus-only
> controllers in Realtek longan and mango SoCs. They also support word
> access and I2C block reads.
> 
> Extend the current read/write SMBus operations to support SMBus I2C
> block and SMBus word access. To avoid having dedicated operations for
> each kind of transfer, provide generic read and write operations that
> covers all kinds of access depending on whats supported.
> 
> For block access, this requires I2C_FUNC_SMBUS_I2C_BLOCK to be
> supported as it relies on reading a pre-defined amount of bytes.
> This isn't intended by the official SMBus Block Read but supported by
> several I2C controllers/drivers.

First of all, thanks for this new version :)

[...]

> +static int sfp_smbus_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
> +			   size_t len)
>  {
>  	union i2c_smbus_data smbus_data;
>  	u8 bus_addr = a2 ? 0x51 : 0x50;
> +	size_t this_len, transferred;
> +	u32 functionality;
>  	u8 *data = buf;
>  	int ret;
>  
> +	functionality = i2c_get_functionality(sfp->i2c);
> +
>  	while (len) {
> -		smbus_data.byte = *data;
> -		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> -				     I2C_SMBUS_WRITE, dev_addr,
> -				     I2C_SMBUS_BYTE_DATA, &smbus_data);
> -		if (ret)
> +		this_len = min(len, sfp->i2c_max_block_size);
> +
> +		if (this_len > 2 &&
> +		    functionality & I2C_FUNC_SMBUS_WRITE_I2C_BLOCK) {
> +			smbus_data.block[0] = this_len;
> +			memcpy(&smbus_data.block[1], data, this_len);
> +
> +			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +					     I2C_SMBUS_WRITE, dev_addr,
> +					     I2C_SMBUS_WORD_DATA, &smbus_data);
> +			transferred = this_len;
> +		} else if (this_len >= 2 &&
> +			   functionality & I2C_FUNC_SMBUS_WRITE_WORD_DATA) {
> +			smbus_data.word = get_unaligned_le16(data);
> +			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +					     I2C_SMBUS_WRITE, dev_addr,
> +					     I2C_SMBUS_WORD_DATA, &smbus_data);
> +			transferred = 2;
> +		} else {
> +			smbus_data.byte = *data;
> +			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +					     I2C_SMBUS_WRITE, dev_addr,
> +					     I2C_SMBUS_BYTE_DATA, &smbus_data);
> +			transferred = 1;
> +		}
> +
> +		if (ret < 0)
>  			return ret;
>  
> -		len--;
> -		data++;
> -		dev_addr++;
> +		data += transferred;
> +		len -= transferred;
> +		dev_addr += transferred;
>  	}

I think Russell pointed it out, but I was also wondering the same.
How do we deal with controllers that cannot do neither block nor
single-byte, i.e. that can only do word access ?

We can't do transfers that have an odd length. And there are some,
see sfp_cotsworks_fixup_check() for example.

Maybe these smbus controller don't even exist, but I think we should
anyway have some log saying that this doesn't work, either at SFP
access time, or at init time.

Maxime




 

