Return-Path: <netdev+bounces-102688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D23904532
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 21:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2BC282367
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 19:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C46384E18;
	Tue, 11 Jun 2024 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="PGt6yIav"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E9B1CD06;
	Tue, 11 Jun 2024 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718135457; cv=none; b=MPZ0l7SOw0IOav9rXxX3um7wBF2cq439/Rtg4HFRaGa5VaiHQcU8X56s4zmUz5WICJJE67Qe2XznWQudYDNXpFHtsQ7TEkePNkXXrZ9iMPWsc5gOL9l6iNJZ0nHqhaxF3oYW/EcALy0THD+sAF1FjN8bF2WWQf436SpY0fb+TU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718135457; c=relaxed/simple;
	bh=bBcXJRMWXXxKsR9BQ8+HwxQJVJqVPsLxdGAD6l/y1zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBOzzx5N9DBSb6xV8aO2JBX1vrxmgrounOBUVEFBTA/NjDXu8U7UGhXxJJXoBJJqHAftvJ+LcxWPJE9MAEvlEPnlZiI4o53lyY/LAjJbKCnwNkTPf8dc66EAsGkHCoGpBi08vI4ayC/SL3TmM7bfSB6koc9AYfl48AD0RayDxXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=PGt6yIav; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3A504883CF;
	Tue, 11 Jun 2024 21:50:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718135452;
	bh=npnYqV9J2WoKJ9LDtrzlpjRBywAdFkb0PaBEMohzQpg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PGt6yIavQt96y3TUxCeFwwWxA9EbReZ4eHCEu4QB66aznmJItlmSV+FKjI9y6rLmr
	 qgXJlbHxmbCN/zefXX7dVlBtv4XySbs3gxd52feZikASCbD55TJmg1Oq1SjQjR/DtF
	 30arv7jOgCGQooNWJ+Bxezm0f9PyYP0bRJ4UvAKsLCTDT0RGkl1S33QBPB7vuwEvaC
	 nmAzH3rLw8Tfnb4d/qyj1BSujK4MyUBkbqjm6lVvQExC9fOPbXFodcy4vOa9DpTjOp
	 u+2wfT3EwXfyGytHZ/2TS/79XyrjgVgP+CPyNhMBVaBM5jtRun07nw4gM2qnj0msTd
	 wCf73U/Gxq96Q==
Message-ID: <e0b9b074-3aad-4b2d-9f4e-99ad2eebbb6b@denx.de>
Date: Tue, 11 Jun 2024 18:16:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v7 7/8] net: stmmac: dwmac-stm32: Mask support
 for PMCR configuration
To: Christophe ROULLIER <christophe.roullier@foss.st.com>,
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
 <ee101ca5-4444-4610-9473-1a725a542c91@denx.de>
 <7999f3df-da1e-4902-b58a-6bb58546a634@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <7999f3df-da1e-4902-b58a-6bb58546a634@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/11/24 3:32 PM, Christophe ROULLIER wrote:
> 
> On 6/11/24 15:07, Marek Vasut wrote:
>> On 6/11/24 10:36 AM, Christophe Roullier wrote:
>>
>> [...]
>>
>>>   static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac, bool 
>>> suspend)
>>> @@ -348,8 +352,15 @@ static int stm32_dwmac_parse_data(struct 
>>> stm32_dwmac *dwmac,
>>>           return PTR_ERR(dwmac->regmap);
>>>         err = of_property_read_u32_index(np, "st,syscon", 1, 
>>> &dwmac->mode_reg);
>>> -    if (err)
>>> +    if (err) {
>>>           dev_err(dev, "Can't get sysconfig mode offset (%d)\n", err);
>>> +        return err;
>>> +    }
>>> +
>>> +    dwmac->mode_mask = SYSCFG_MP1_ETH_MASK;
>>> +    err = of_property_read_u32_index(np, "st,syscon", 2, 
>>> &dwmac->mode_mask);
>>> +    if (err)
>>> +        dev_dbg(dev, "Warning sysconfig register mask not set\n");
>>
>> My comment on V6 was not addressed I think ?
> 
> Hi Marek,
> 
> I put the modification in patch which introduce MP13 (V7 8/8) ;-)
> 
>       err = of_property_read_u32_index(np, "st,syscon", 2, 
> &dwmac->mode_mask);
> -    if (err)
> -        dev_dbg(dev, "Warning sysconfig register mask not set\n");
> +    if (err) {
> +        if (dwmac->ops->is_mp13)
> +            dev_err(dev, "Sysconfig register mask must be set (%d)\n", 
> err);
> +        else
> +            dev_dbg(dev, "Warning sysconfig register mask not set\n");
> +    }

That isn't right, is it ?

For MP2 , this still checks the presence of syscon , which shouldn't be 
checked at all for MP2 as far as I understand it ?

