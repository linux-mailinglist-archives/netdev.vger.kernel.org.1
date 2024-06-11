Return-Path: <netdev+bounces-102587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766AB903D56
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1793C289377
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B914F17D378;
	Tue, 11 Jun 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="l4M1o7OC"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF4617D34F;
	Tue, 11 Jun 2024 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112552; cv=none; b=O/Ru4NjVbBM9tvJkopGDFVJtRnv+3arDS/8BJ9UnXF78WXUnnRvVYEs8v4TwitgN37EvlSdnDLeljQlz9he/RKsaCRoOwDlQ87KvRJuxA/NAS/xkG9ldepnOGkXRSO7YjyyVUHumcxySWWsgAvaEiu+NC7X2Q/glstNC/hIko6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112552; c=relaxed/simple;
	bh=S8kq1YKPY2YCYXE468OBoSzyuhbV4hblKCD/W3a2KBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpBy1Py3X/JkQ7rglYTjTLcMsnB3aaJ0zrcmyoptbxnqWa+xszAb2hvBmEkzyQcs9SJSK6aVSwnvGBd9rGTfJ5lOC2mAE12RNk8IMDcuEVPoUEfhf8kUf30QV8+Nc7RR2bs14r6A441T0kIIglKSCCGVoXWAAojCq2mYxSr9ItI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=l4M1o7OC; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 4D6D188660;
	Tue, 11 Jun 2024 15:29:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718112542;
	bh=7LztJLOQjw+XAg+XEIr7kZCsERJxxOYihnXImFPkkvU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l4M1o7OCYl/dvkVYQ/gVTUxO5H8WmdwW6wYCO18/FhCWi6iOhr24pSYUn+k8qvQP8
	 fHesy9waWPJOAJPEAZWHRCr883+AT4Zj++F45dWOMtmtIAX2aITK76JXYrq/AHJaIy
	 2kOr5BPz3dIVZ2n88vorYGBcXlaaZX+vVTGJ5a1Nqvax4dEs1oNuymGg0bPuauQCbU
	 JSKIl4GVx7MEF7Z2B2tDyJfr07QITjIwMCTED7iiZJ8wo0IeafezCZ9nEPrj3AX68n
	 OLepqilR0f5rtmQDJ4Yaz7ZYFRm8i1w5V14xT/6z+lq/Fph9cQrrVLydPk3n/pWXWu
	 laQYJ2zEWl6Tw==
Message-ID: <ee101ca5-4444-4610-9473-1a725a542c91@denx.de>
Date: Tue, 11 Jun 2024 15:07:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v7 7/8] net: stmmac: dwmac-stm32: Mask support
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
References: <20240611083606.733453-1-christophe.roullier@foss.st.com>
 <20240611083606.733453-8-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240611083606.733453-8-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/11/24 10:36 AM, Christophe Roullier wrote:

[...]

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

My comment on V6 was not addressed I think ?

