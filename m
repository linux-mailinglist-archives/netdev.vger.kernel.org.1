Return-Path: <netdev+bounces-39639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110227C039E
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 20:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D942819EF
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 18:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ACC27707;
	Tue, 10 Oct 2023 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqzM4D1M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A630565A;
	Tue, 10 Oct 2023 18:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754C9C433CC;
	Tue, 10 Oct 2023 18:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696963337;
	bh=ldKKDLNL5IeRM0a07A6s6AJub50EGR8AJO6LTn0Obwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LqzM4D1MlLdeXjle0S/VafEl40lMghLhLKm+9gJtf+ozhX1rdh7dMp9TxumYlErj6
	 hfFl58cakIJNbknsQMdeOerVRiHoWTUZimBOIaMG2Er7wDuh+ofNCrIildBOEkgcyF
	 iHst+Szlw1LPgbq0idM4X1NB53u3zx2lyIXz6XM9scQtjG/o0kAoQJz5cALTiLeS4h
	 P6O/43fv9eqa2gfm+cl9uXuK8WPOBWHa+gVOYYWs0n9289SeXGnWrjjm8Uyv2M2J41
	 MyzucIxozLIO/j0LhciFjLR46qrcTuYTics1mybYkX073932KlLSdDEBL0ov4kHqG8
	 2tXMZTrLHMb7w==
Received: (nullmailer pid 1358279 invoked by uid 1000);
	Tue, 10 Oct 2023 18:42:12 -0000
Date: Tue, 10 Oct 2023 13:42:12 -0500
From: Rob Herring <robh@kernel.org>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Oleksii_Moisieiev@epam.com, gregkh@linuxfoundation.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	alexandre.torgue@foss.st.com, vkoul@kernel.org, jic23@kernel.org,
	olivier.moysan@foss.st.com, arnaud.pouliquen@foss.st.com,
	mchehab@kernel.org, fabrice.gasnier@foss.st.com,
	andi.shyti@kernel.org, ulf.hansson@linaro.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, hugues.fruchet@foss.st.com,
	lee@kernel.org, will@kernel.org, catalin.marinas@arm.com,
	arnd@kernel.org, richardcochran@gmail.com,
	Frank Rowand <frowand.list@gmail.com>, peng.fan@oss.nxp.com,
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, linux-p@web.codeaurora.org,
	hy@lists.infradead.org, linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v6 10/11] ARM: dts: stm32: add ETZPC as a system bus for
 STM32MP15x boards
Message-ID: <20231010184212.GA1221641-robh@kernel.org>
References: <20231010125719.784627-1-gatien.chevallier@foss.st.com>
 <20231010125719.784627-11-gatien.chevallier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010125719.784627-11-gatien.chevallier@foss.st.com>

On Tue, Oct 10, 2023 at 02:57:18PM +0200, Gatien Chevallier wrote:
> ETZPC is a firewall controller. Put all peripherals filtered by the
> ETZPC as ETZPC subnodes and reference ETZPC as an
> access-control-provider.
> 
> For more information on which peripheral is securable or supports MCU
> isolation, please read the STM32MP15 reference manual.
> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
> 
> Changes in V6:
>     	- Renamed access-controller to access-controllers
>     	- Removal of access-control-provider property
> 
> Changes in V5:
>     	- Renamed feature-domain* to access-control*
> 
>  arch/arm/boot/dts/st/stm32mp151.dtsi  | 2756 +++++++++++++------------
>  arch/arm/boot/dts/st/stm32mp153.dtsi  |   52 +-
>  arch/arm/boot/dts/st/stm32mp15xc.dtsi |   19 +-
>  3 files changed, 1450 insertions(+), 1377 deletions(-)

This is not reviewable. Change the indentation and any non-functional 
change in one patch and then actual changes in another.

This is also an ABI break. Though I'm not sure it's avoidable. All the 
devices below the ETZPC node won't probe on existing kernel. A 
simple-bus fallback for ETZPC node should solve that. 

Rob

