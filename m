Return-Path: <netdev+bounces-104191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA7590B77D
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 19:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A661C226DF
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544B316A933;
	Mon, 17 Jun 2024 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="QoXrIrvn"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B611684BF;
	Mon, 17 Jun 2024 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718644124; cv=none; b=bo4Lxg5U/HMP/vrsVCKOeHRko75PiMxuzgqCduFxviyi+VC9+xAesAMwIjXEB9fwfM0WCn2wjPI2f2NWZrzq8WD6ZA3AT776CORFSRzoI9a6yjNAS66NwRpwUoCRiMSYEGSa1giZBvjiXaOgnjG5qItDjmy1s929Oy1e2ZQlHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718644124; c=relaxed/simple;
	bh=gx/vBZHRvUmIyCzLBrHv7A/uxP4nVY5Z8aEFxljAWec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKTpRm7VMHnzDUbx/ySspF7xk4eaVls0GeSAajAamrAcRTuEV9Wy/gIQmQ+Fpaudx8pKTXpYYcFLLc9Pnry3f3f92j8Tfeto8I6J59oW+ZdOWU4ree9JZQJkh05RAlhKdD1rU3DROXRLL8v/k+k3Q7ZLcnMQXT7Uz8eXkt+7pag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=QoXrIrvn; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9BABF8826E;
	Mon, 17 Jun 2024 19:08:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718644120;
	bh=1LdYSyTBSDGBxuQ70W3AP01Rdne8htwL8v2sMMNqG24=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QoXrIrvnzwtvEIa5aEXKzpiB/7KC8fX4ff4gWB4XiB6kASzmH7iWchHIaoCNVsSSI
	 a6Ed+fjXdLjMjOaGYHlBaEQzEGWC7yfboVKGuboE0TNt8bd5o1vr84Pl/bTttFqCVw
	 yOWIfODbtdURahcifJTTNFIgSjqH2M/VZ79+UpYO0Ek0H9tCN7HBuoTqEgPgFMzASM
	 tpfL35qrR4V/T7VievY9GSZttD7Ud+At6XtS7VgB6nPQM2mrTGq50fWV9tLrm+Kn2A
	 O8+MoG45HM+qRmm5tfmaogYFiUKMLC95kVM0xIMnDeGv6YPfaiJ8x2iCgi3n2T1anG
	 3GiBCrxdJxB0Q==
Message-ID: <39d35f6d-4f82-43af-883b-a574b8a67a1a@denx.de>
Date: Mon, 17 Jun 2024 17:57:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH 2/2] net: stmmac: dwmac-stm32: stm32: add
 management of stm32mp25 for stm32
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
References: <20240614130812.72425-1-christophe.roullier@foss.st.com>
 <20240614130812.72425-3-christophe.roullier@foss.st.com>
 <4c2f1bac-4957-4814-bf62-816340bd9ff6@denx.de>
 <09010b02-fb55-4c4b-9d0c-36bd0b370dc8@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <09010b02-fb55-4c4b-9d0c-36bd0b370dc8@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/17/24 1:23 PM, Christophe ROULLIER wrote:

Hi,

>>> +static int stm32mp2_configure_syscfg(struct plat_stmmacenet_data 
>>> *plat_dat)
>>> +{
>>> +    struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
>>> +    u32 reg = dwmac->mode_reg;
>>> +    int val = 0;
>>> +
>>> +    switch (plat_dat->mac_interface) {
>>> +    case PHY_INTERFACE_MODE_MII:
>>> +        break;
>>
>> dwmac->enable_eth_ck does not apply to MII mode ? Why ?
> 
> It is like MP1 and MP13, nothing to set in syscfg register for case MII 
> mode wo crystal.

Have a look at STM32MP15xx RM0436 Figure 83. Peripheral clock 
distribution for Ethernet.

If RCC (top-left corner of the figure) generates 25 MHz MII clock 
(yellow line) on eth_clk_fb (top-right corner), can I set 
ETH_REF_CLK_SEL to position '1' and ETH_SEL[2] to '0' and feed ETH 
(right side) clk_rx_i input with 25 MHz clock that way ?

I seems like this should be possible, at least theoretically. Can you 
check with the hardware/silicon people ?

As a result, the MII/RMII mode would behave in a very similar way, and 
so would GMII/RGMII mode behave in a very similar way. Effectively you 
would end up with this (notice the fallthrough statements):

+	case PHY_INTERFACE_MODE_RMII:
+		val = SYSCFG_ETHCR_ETH_SEL_RMII;
+		fallthrough;
+	case PHY_INTERFACE_MODE_MII:
+		if (dwmac->enable_eth_ck)
+			val |= SYSCFG_ETHCR_ETH_REF_CLK_SEL;
+		break;
+
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val = SYSCFG_ETHCR_ETH_SEL_RGMII;
+		fallthrough;
+	case PHY_INTERFACE_MODE_GMII:
+		if (dwmac->enable_eth_ck)
+			val |= SYSCFG_ETHCR_ETH_CLK_SEL;
+		break;

[...]

