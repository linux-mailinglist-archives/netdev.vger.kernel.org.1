Return-Path: <netdev+bounces-101843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C29900427
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1EA0B22868
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C7C1946DC;
	Fri,  7 Jun 2024 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="tmPNDRqv"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C70A1946D8;
	Fri,  7 Jun 2024 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764906; cv=none; b=sbwA2R20q4i6rk1ni33OisNFpGwZuq86jPUyOcrBigK3Grom97ftaNvYy4I1NZpsQLnTLYGNuAcCktkCAxSwqkDyRfTOxaMTktG3htgtQqkOs/BzrJQq2nj2mahzJ7XZ+PHUKok94k5gpOzapo8TQOtwlmZlVSxxgqd/ib1XAy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764906; c=relaxed/simple;
	bh=3oXDE2Vyg8R6gW+3lkHuJvbxtTQYA5vb4hqqRgdmp9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utAJmVrZGMPorCMBHu1fWKqAzhfuduI5LhAxLaFHH4feON0fgu8fFGaANMH1zY12WvZDE0+lKvpwSg8BnCBZ00K5DJuAbrrsswYFy6Ce5PYiykhCkZulN/0PLUTz5wcYEHpJkP+swsXIgEp8GvPe3VCHGXwtBwz4zkwF46ZnKNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=tmPNDRqv; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 42FDB8843F;
	Fri,  7 Jun 2024 14:54:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717764897;
	bh=VEyICVXVOAE0B8ItgEDxm4sokZMsD0t+tJNKgZw1T7U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tmPNDRqv1m8He/GCNsJTfLL8b/vWW3CAJYfWCcNkXFXyx39Cq6rZSpK9BWlGz8ftC
	 LDkSewO6Go/u2jwTgAfZPbjoRyx/rCZF16Ij9ZEXpFQ94+klINMEAbAY1I6oStWIXN
	 YXryOyHPARwPQVuuEXkaulnVi2ZRcsBk3ymk2TuKvUhSYl6XIs4ZNuMsYvtzr1TZwz
	 lQjR36+FK/MBh9fBuZ8+/5F6RHjIm4eiZPXjXQBngeG9+Y9PHn/mf5pe4meLTHmO/3
	 RisnqkYCJuCuwxQmMP2Cev9iK6KYqCrZcPqz4iXnc1fDPBgkG61YzYhXgWPkBOF0gB
	 VbD6N/1d2GM9w==
Message-ID: <379a013a-5385-4b74-ad68-12e73253a8b5@denx.de>
Date: Fri, 7 Jun 2024 14:45:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/12] net: stmmac: dwmac-stm32: Mask support for PMCR
 configuration
To: Christophe Roullier <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240607095754.265105-1-christophe.roullier@foss.st.com>
 <20240607095754.265105-8-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240607095754.265105-8-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/7/24 11:57 AM, Christophe Roullier wrote:

[...]

> @@ -348,8 +352,15 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
>   		return PTR_ERR(dwmac->regmap);
>   
>   	err = of_property_read_u32_index(np, "st,syscon", 1, &dwmac->mode_reg);
> -	if (err)
> +	if (err) {
>   		dev_err(dev, "Can't get sysconfig mode offset (%d)\n", err);
> +		return err;
> +	}
> +
> +	dwmac->mode_mask = SYSCFG_MP1_ETH_MASK;
> +	err = of_property_read_u32_index(np, "st,syscon", 2, &dwmac->mode_mask);
> +	if (err)
> +		pr_debug("Warning sysconfig register mask not set\n");

Isn't this ^ an error ? If so, use dev_err(), else use dev_dbg()

>   	return err;
>   }

[...]

