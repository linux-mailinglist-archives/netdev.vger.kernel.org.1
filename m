Return-Path: <netdev+bounces-232516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 285C8C06240
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AD644ECCAA
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C07B3128DC;
	Fri, 24 Oct 2025 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GA6beHVk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2144F30E0D9;
	Fri, 24 Oct 2025 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761307239; cv=none; b=PlC2vR7dgGb0C6+MxrHbOZWGYlwUpKXTgyV8xBKeyYoJ6jYcnopFDaFDH8ewgTKhidzG25JIN8KjhAKhMZWU+mUz6tqXEaFt9JMtM4aUsAupEfA11OIdqY8oHvZdYH8m5r2X3UuN27Gh4xGKo/fHT9yhqvMIjvklYFkf6fWkptg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761307239; c=relaxed/simple;
	bh=mY0NKPFfmhr1T63HdffWMpcsFE4SlVTte2OxJPJe5q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOtnwqfkkY5kiOKe4dOUbPzfjjQVEXLGg0bAQ1Uw3AsfmUUzdWY8Mhj0E3k8ZSd0VBhwqqLLdnwQSqTpZrIdVmvjtuNbjGW1zjpxCsPiQ5w0+w8q0u2ufUuQ0LPCqi9gVe7WfxgHBL91Ne6K7RzajZfiycmakzxCb1ydp51Kf58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GA6beHVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551EAC4CEF1;
	Fri, 24 Oct 2025 12:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761307238;
	bh=mY0NKPFfmhr1T63HdffWMpcsFE4SlVTte2OxJPJe5q0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GA6beHVk0T7eqma9TD1yfynJIZUzmhZWrQSGs2EbMYvTG0m96tG7jC1m+Z5Ic+igt
	 29PmR2o/pGmZVtNu9HPB6Ye8/TIOIVlUq69IzYMuAOnOYK+YS4b4MKqlqMf37byeTh
	 etMlzJbKT4JMLQN/4UCOOX+FpomsE8Sqpyf5/b4hIbPph51zoQc7tJ72o/dNRKvuUw
	 d4SEjXTs9sB6ct0+ynRY0O/vMa26IBbUAUzzdmrsOPm8v1+9mhjyA/b+/OCH1tPqeg
	 4aASNTRFCdlPi6DdWTdbxv4LbxaaRnI51ukDWFbj5KzDebv7Yk8PxrpM437HHEbHCk
	 jnt3Lz5egnOmw==
Message-ID: <b486bb52-7e95-44d3-ac65-1c28d4d0e40e@kernel.org>
Date: Fri, 24 Oct 2025 07:00:36 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/10] arm64: dts: socfpga: agilex5: add dwxgmac
 compatible
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Matthew Gerlach <matthew.gerlach@altera.com>
Cc: kernel@pengutronix.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
 <20251024-v6-12-topic-socfpga-agilex5-v5-6-4c4a51159eeb@pengutronix.de>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20251024-v6-12-topic-socfpga-agilex5-v5-6-4c4a51159eeb@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steffen,

On 10/24/25 06:49, Steffen Trumtrar wrote:
> The gmac0/1/2 are also compatible to the more generic "snps,dwxgmac"
> compatible. The platform code checks this to decide if it is a GMAC or
> GMAC4 compatible IP core.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>   arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> index 4ccfebfd9d322..d0c139f03541e 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> @@ -536,7 +536,8 @@ qspi: spi@108d2000 {
>   
>   		gmac0: ethernet@10810000 {
>   			compatible = "altr,socfpga-stmmac-agilex5",
> -				     "snps,dwxgmac-2.10";
> +				     "snps,dwxgmac-2.10",
> +				     "snps,dwxgmac";
>   			reg = <0x10810000 0x3500>;
>   			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
>   			interrupt-names = "macirq";
> @@ -649,7 +650,8 @@ queue7 {
>   
>   		gmac1: ethernet@10820000 {
>   			compatible = "altr,socfpga-stmmac-agilex5",
> -				     "snps,dwxgmac-2.10";
> +				     "snps,dwxgmac-2.10",
> +				     "snps,dwxgmac";
>   			reg = <0x10820000 0x3500>;
>   			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
>   			interrupt-names = "macirq";
> @@ -762,7 +764,8 @@ queue7 {
>   
>   		gmac2: ethernet@10830000 {
>   			compatible = "altr,socfpga-stmmac-agilex5",
> -				     "snps,dwxgmac-2.10";
> +				     "snps,dwxgmac-2.10",
> +				     "snps,dwxgmac";
>   			reg = <0x10830000 0x3500>;
>   			interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
>   			interrupt-names = "macirq";
> 

I just sent a patch for this yesterday:

https://lore.kernel.org/all/20251023214012.283600-1-dinguyen@kernel.org/

I'll make sure to include you on future submissions.

I didn't add it to the bindings document though.

Dinh

