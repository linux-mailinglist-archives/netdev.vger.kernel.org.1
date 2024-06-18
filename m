Return-Path: <netdev+bounces-104592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B5F90D74E
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 17:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D295B1F22510
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7923346521;
	Tue, 18 Jun 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="nw99PiWW"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0564A35;
	Tue, 18 Jun 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724628; cv=none; b=ijWeVF+mdIkv8juoBZMb5DJMg7zXeJ2FlqEuo9uysBf3SZy6Vge0/v7Nd15J5lhSn+5zN1qsT+4akd+BdrM5qUGsaporq6MvnR+MwKTTgMyKJmY/1k9gtTjdw1iQejCJAn45GP4bxk7oDfhdWaPJGu/8//GziCenjaZ5FNWlk9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724628; c=relaxed/simple;
	bh=1TjQk7p2/XGh31cXbZfQzwUrlVhXrN9/pUZMmSVbZm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BI1Vt7zzxy2abFD884PNLkVeaW/9w3d34/vAvUf6HhoFqbcbPYPxaTBrzFAw+VElzYZISp8rXaqXldj8Q1KomALZIywI28SS4eGc36uslGt+ETmSrhZc9fszBcWIIm3ArZFdcWTVQAXA4Drb1ODTVsg+OthmDx+Gx4giE0yTs9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=nw99PiWW; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0C62E88365;
	Tue, 18 Jun 2024 17:30:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718724620;
	bh=0+tHVtPjS+usxhPkQGdFYgz79OPBV4S+QswV7CWb6Ew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nw99PiWWGbqLM4jY6qhcmnH/wH6U3fUbxe10dzidJ+7q3kVWQOvDdHj3hJibV3lLm
	 kR//Esyklgh6HDqyXLhovV1O6c61PMp2+HEaRKYr4Ov93NFgPGaOYb1RnAslRnAAB1
	 qP60D2jgyRfUoX+5gUkn4JrJBKemgUyluV/wItf02lnXzSorv0pDq5ngyeuC7osvcb
	 8SLZXUz5m/b1x7L60tdQbPblaXHYkPpfLpARA64x/A3mJS0a7u/cqQfGPYXi74vKct
	 Jx5AG/hBEH2y/edxHZnykEnI/ah/2ekN0x+i3DRxeV0vbL6RceyxQFRXxfQa5nShpT
	 2DdXYprIiDwig==
Message-ID: <986f2cd3-2440-4579-a4f9-749a6fff61f5@denx.de>
Date: Tue, 18 Jun 2024 17:02:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: st: enable Ethernet2 on stm32mp257f-ev1
 board
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
References: <20240618093527.318239-1-christophe.roullier@foss.st.com>
 <20240618093527.318239-4-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240618093527.318239-4-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/18/24 11:35 AM, Christophe Roullier wrote:
> ETHERNET2 instance is connected to Realtek PHY in RGMII mode
> Ethernet is SNSP IP with GMAC5 version.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>   arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 24 ++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
> index 27b7360e5dba..6d8bf1342e23 100644
> --- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
> +++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
> @@ -17,6 +17,7 @@ / {
>   	compatible = "st,stm32mp257f-ev1", "st,stm32mp257";
>   
>   	aliases {
> +		ethernet0 = &ethernet2;
>   		serial0 = &usart2;
>   	};
>   
> @@ -55,6 +56,29 @@ &arm_wdt {
>   	status = "okay";
>   };
>   
> +&ethernet2 {
> +	status = "okay";
> +	pinctrl-0 = <&eth2_rgmii_pins_a>;
> +	pinctrl-1 = <&eth2_rgmii_sleep_pins_a>;
> +	pinctrl-names = "default", "sleep";
> +	phy-mode = "rgmii-id";
> +	max-speed = <1000>;

Keep the list sorted.

