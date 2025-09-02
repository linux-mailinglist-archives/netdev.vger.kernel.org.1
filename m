Return-Path: <netdev+bounces-219171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DCEB402AA
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD5F1B26957
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 13:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758E730DD1A;
	Tue,  2 Sep 2025 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kjdeqm8s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0A9307AE9;
	Tue,  2 Sep 2025 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819110; cv=none; b=t4nmc2FwysPF/yN/UE9Guk9WIJrxElY98YW1yGog8VdL42tn7gI7h48X4TqveDPLa69NLuHc6Z7NA9Mplyx8fji2BlukZkm8hwYU19LwWF7lC5ynjucaMa0fiICuA2aJLCfDbzNed1lHsMN/NgWKcm90Fg0CiVZ6gLg1lttW8po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819110; c=relaxed/simple;
	bh=+8yfthSijc95vqMaDpPZVo/AICpcYNlVWfPmxU6cweM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=uCqva2OqNcFnaSAY+GTRlqhTj+fsG5o+r3TNqcWYT9ccwJhy2CbRGjL0305Y9eajBhQbN3hDY+H4bO9B3jK7/zA4HxXwsrJEl0asPa4UrKDoKNJG0c6gl+WjmB9oCSX8ATsbNq4N2lFy1s9y1ZPhck8ol6/VCE5b66jZguu8WJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kjdeqm8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CC6C4CEED;
	Tue,  2 Sep 2025 13:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756819108;
	bh=+8yfthSijc95vqMaDpPZVo/AICpcYNlVWfPmxU6cweM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Kjdeqm8sfAcIATBjGpEcCUsXSq477Sd8JSkPuk69/E5nUNFI/xPI7s2Gy150H/Ocp
	 c2VBYNzKeItKkLcM9EHmiHHBG8rUGkCzyZJkcRm7pNm+p05L+T/Sq9+ZlOgk+Ok0km
	 mVSOuzm9FRzkFeT7eb+F79CF6p4jJLlsUAFA0/0plHtgok3f5nr3zxk29wBxBMQKGe
	 f7pIJxwSb/3m2mrtbVev67Y0TuiU9eE3A4GjKsu41NyYd/vR0rHiTPASVMSK3DeItY
	 3oXYM/L39uRczk7leIDmbwGgqJPPWOML+jXZfI+bEz7IwQJEtxuLTeyaSZz61rqkhP
	 Wj8FXNUwmbNLg==
Date: Tue, 02 Sep 2025 08:18:26 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: kuba@kernel.org, mripard@kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 davem@davemloft.net, linux-sunxi@lists.linux.dev, wens@csie.org
To: Conley Lee <conleylee@foxmail.com>
In-Reply-To: <tencent_64909A540A8CD9063D28DEFD0A684AF9B709@qq.com>
References: <tencent_64909A540A8CD9063D28DEFD0A684AF9B709@qq.com>
Message-Id: <175678731491.878219.3817330096416761457.robh@kernel.org>
Subject: Re: [PATCH] arm: dts: sun4i-emac enable dma rx in sun4i


On Mon, 01 Sep 2025 17:04:03 +0800, Conley Lee wrote:
> The current sun4i-emac driver supports receiving data packets using DMA,
> but this feature is not enabled in the device tree (dts) configuration.
> This patch enables the DMA receive option in the dts file.
> 
> Signed-off-by: Conley Lee <conleylee@foxmail.com>
> ---
>  arch/arm/boot/dts/allwinner/sun4i-a10.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/next-20250829 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/allwinner/' for tencent_64909A540A8CD9063D28DEFD0A684AF9B709@qq.com:

arch/arm/boot/dts/allwinner/sun4i-a10-jesurun-q5.dtb: ethernet@1c0b000 (allwinner,sun4i-a10-emac): Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun4i-a10-emac.yaml#
arch/arm/boot/dts/allwinner/sun4i-a10-a1000.dtb: ethernet@1c0b000 (allwinner,sun4i-a10-emac): Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun4i-a10-emac.yaml#
arch/arm/boot/dts/allwinner/sun4i-a10-cubieboard.dtb: ethernet@1c0b000 (allwinner,sun4i-a10-emac): Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun4i-a10-emac.yaml#
arch/arm/boot/dts/allwinner/sun4i-a10-olinuxino-lime.dtb: ethernet@1c0b000 (allwinner,sun4i-a10-emac): Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun4i-a10-emac.yaml#
arch/arm/boot/dts/allwinner/sun4i-a10-itead-iteaduino-plus.dtb: ethernet@1c0b000 (allwinner,sun4i-a10-emac): Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun4i-a10-emac.yaml#
arch/arm/boot/dts/allwinner/sun4i-a10-pcduino.dtb: ethernet@1c0b000 (allwinner,sun4i-a10-emac): Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun4i-a10-emac.yaml#
arch/arm/boot/dts/allwinner/sun4i-a10-marsboard.dtb: ethernet@1c0b000 (allwinner,sun4i-a10-emac): Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun4i-a10-emac.yaml#
arch/arm/boot/dts/allwinner/sun4i-a10-hackberry.dtb: ethernet@1c0b000 (allwinner,sun4i-a10-emac): Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun4i-a10-emac.yaml#
arch/arm/boot/dts/allwinner/sun4i-a10-ba10-tvbox.dtb: ethernet@1c0b000 (allwinner,sun4i-a10-emac): Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun4i-a10-emac.yaml#
arch/arm/boot/dts/allwinner/sun4i-a10-pcduino2.dtb: ethernet@1c0b000 (allwinner,sun4i-a10-emac): Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun4i-a10-emac.yaml#






