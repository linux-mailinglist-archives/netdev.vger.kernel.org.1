Return-Path: <netdev+bounces-102221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971A2901F89
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D5628301F
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 10:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A4C79DD4;
	Mon, 10 Jun 2024 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="HdUxmK4v"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6666E78289;
	Mon, 10 Jun 2024 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718016255; cv=none; b=OLmzEP7xR0b8CLbzttjxoPzPgsLz5a9/DWZU121EWEC5q3sZ3HRi3GefW0V+h2I+lA31mK+E3TTwffKKs8rGOUNCW5RY9MQHxoXsP53wbkat21mwHMWn32Ze2lXlAWAaHx/VBubG7/GRDTX+mGfHxovqdAxbZJo+E0AFX0sPpDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718016255; c=relaxed/simple;
	bh=Xgifc3RZYOrbnKpU3WRdjJpZwdhk0dGafsLtNHkcmIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XchEuvbLKWWV6KhqDCVF6GzTKravi4Bq8JwP5N2bp4E07J/Khi+ZHP6SBocA+WtRAmOClwV81h5M0VLR27Obs0FIzqhkuVUHW++qG1XD9trPHYoPgvVlxMPsLKvEBddqXiDrIh1oHSHV2dDPOc+aw5mwuXMagZRle+S60pq7vzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=HdUxmK4v; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id D39AB883F2;
	Mon, 10 Jun 2024 12:44:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718016247;
	bh=DYg6tL7HTuHnmwDK8wj/mmR4QXzEn5dAlWnruAHXPi8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HdUxmK4v1UYivallEA9IKBrXygjcQS3ygkoyqmVx291CNwAXywRP9eCnB7J+T8BQk
	 4uE+ZV65FzEgxmpg8HE34onFYJEfnNa5Nms6TLUrzt8sS1xqroVSwVdJqk6zQK1gEb
	 P7NVyj4n7EWt1V8HFSYxsYusJuSiVBRvpGTN3++sAn764fl9sp+Yf5Gp3RIXGqFkXp
	 V2uj1ZdqGYIC4WWZGB7YDAO8niXjJVInmPEiixUXzvfUxJtPcymddHZauqDvXjuqxB
	 1qD94BLQR/PPaDU8rdWkn0Ah9FTU7pUjCwuFbhe8WMbzX4E65TbxQJG9xeE/M6p7Z4
	 w09oYPDyzc1qg==
Message-ID: <20139233-4e95-4fe5-84ca-734ee866afca@denx.de>
Date: Mon, 10 Jun 2024 12:39:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v6 7/8] net: stmmac: dwmac-stm32: Mask support
 for PMCR configuration
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
References: <20240610071459.287500-1-christophe.roullier@foss.st.com>
 <20240610071459.287500-8-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240610071459.287500-8-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/10/24 9:14 AM, Christophe Roullier wrote:

[...]

>   static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
> @@ -303,7 +307,7 @@ static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
>   	dev_dbg(dwmac->dev, "Mode %s", phy_modes(plat_dat->mac_interface));
>   
>   	return regmap_update_bits(dwmac->regmap, reg,
> -				 dwmac->ops->syscfg_eth_mask, val << 23);
> +				 SYSCFG_MCU_ETH_MASK, val << 23);
>   }
>   
>   static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac, bool suspend)
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
> +		dev_dbg(dev, "Warning sysconfig register mask not set\n");

Isn't this an error , so dev_err() ?

Include the err variable in the error message, see the dev_err() above 
for an example. That way the log already contains useful information 
(the error code) that can be used to narrow down the problem.

