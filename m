Return-Path: <netdev+bounces-101845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8893C90042E
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B2D28783F
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6DB195FD7;
	Fri,  7 Jun 2024 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="kU8pnwoU"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66791194ACF;
	Fri,  7 Jun 2024 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764909; cv=none; b=uvjAPtoyMvrk5sdTTGJaNCic+sLtznA7dp6GsGxHDfZCasqaTKgA7zK/Fw9CewneyCffApVoSbolzaRUKmMgxytBEBvEfHw8pkXkKE+Twbfa/Lsm2IlDHyC0N47H5ZVYBI7vsyPDgiCJDf2ro6HJEFKLgPer16JS6Icadzp5Uxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764909; c=relaxed/simple;
	bh=E0hadf3fJY0MOE4oIWDIY6R1dLTOP4xPK5XeYlJoO1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQ+/GFI5Zbr95eG/lJIv3dP/6YKxG7Nm3QocVGQme/oFGgPSrXERxFyd92NUrLH5DmsTX1VpaFMVJ7U6BKDTDaDq5gy0LOSDh1EO1W1+CDhGkurg9jikkL3bev4N1rcFkUVBYLKRrx1IJgeb8uW48JFmWf/5Kzq3rJgsrDJ4z4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=kU8pnwoU; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 6ACDB8841D;
	Fri,  7 Jun 2024 14:54:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717764900;
	bh=xkJGBefc0fkNNjL/OHeRyUcUqgQcSbwLbav+7Ogt6gg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kU8pnwoU8Te7ZPY/7WMfjdbgzFhkALkAuOFGmXYvd70fzPFlYKwt1oh2rI4eoPD1y
	 QtivI5e6w4I51vudACZSaZljMpEYomnvFVv1+C58PztfyIs5elfP9MKtKr8YMruR1t
	 LbvOhIlFa2ts5VZbLcOk69JergipO2633FwNccyYRtwXDxbS2bLvpfvMJyL+NHR/n7
	 eTeZWmb2B2OJvbdosr9UkURv3s+mrxizPMPwbE5IE2/B5UQjoeiAwCIjpiP+p8dx7A
	 x18X/EuB0cueo0SOWcMYTHh89TvRyEAx3ZyiULStZj9FgsH5aIe3vSX3bEYP3hzRzs
	 6twdv8r/9hKKg==
Message-ID: <6d60bbc6-5ed3-4bb1-ad72-18a2be140b81@denx.de>
Date: Fri, 7 Jun 2024 14:48:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] ARM: dts: stm32: add ethernet1 and ethernet2
 support on stm32mp13
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
 <20240607095754.265105-10-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240607095754.265105-10-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/7/24 11:57 AM, Christophe Roullier wrote:

[...]

> @@ -1505,6 +1511,38 @@ sdmmc2: mmc@58007000 {
>   				status = "disabled";
>   			};
>   
> +			ethernet1: ethernet@5800a000 {
> +				compatible = "st,stm32mp13-dwmac", "snps,dwmac-4.20a";
> +				reg = <0x5800a000 0x2000>;
> +				reg-names = "stmmaceth";
> +				interrupts-extended = <&intc GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
> +						      <&exti 68 1>;
> +				interrupt-names = "macirq", "eth_wake_irq";
> +				clock-names = "stmmaceth",
> +					      "mac-clk-tx",
> +					      "mac-clk-rx",
> +					      "ethstp",
> +					      "eth-ck";
> +				clocks = <&rcc ETH1MAC>,
> +					 <&rcc ETH1TX>,
> +					 <&rcc ETH1RX>,
> +					 <&rcc ETH1STP>,
> +					 <&rcc ETH1CK_K>;
> +				st,syscon = <&syscfg 0x4 0xff0000>;
> +				snps,mixed-burst;
> +				snps,pbl = <2>;
> +				snps,axi-config = <&stmmac_axi_config_1>;
> +				snps,tso;
> +				access-controllers = <&etzpc 48>;

Keep the list sorted.

