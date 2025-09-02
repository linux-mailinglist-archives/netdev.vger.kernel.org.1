Return-Path: <netdev+bounces-219172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0DEB402B2
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9260216DC5A
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 13:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C98A30E0D8;
	Tue,  2 Sep 2025 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZ8f6yx+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C4A30DEC4;
	Tue,  2 Sep 2025 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819112; cv=none; b=f5nw334ypBoTQ3fD4NRMySTuonceD7gSMzFKWfHDrRVcJGfOXA3v7nT2ZgENKD+t8GXKVWLM/594DpKkgdFMgZ8SwpmjM79UNdaK5SN2ZMAKICh2s2+tuwWLsO78pq/xlJDPOm5zAU/P4WZk1cW1kI6KUQCVigscKzp/4VNLGZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819112; c=relaxed/simple;
	bh=nQUVR7QuD0wO5Rmr1nt0LUWraj/tUYvMI5niL2joU/o=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=JNNZPJQn3poSc6iq1D1JdO6hkKA85lr20BnQLVwA/L5JjiwOvCwMe8pH/w0hAvWyeZWHZh3Eu0NrB9kIg5XGl01d33tHJroXndFyrd8d5Kv93lfRmOYXzL7Q8FFAdlAkl3/YBZ/qBKGR6xfQi6QiwwvEyD7Eh7ZWcAcEVI68ASk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZ8f6yx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A072BC4CEFA;
	Tue,  2 Sep 2025 13:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756819111;
	bh=nQUVR7QuD0wO5Rmr1nt0LUWraj/tUYvMI5niL2joU/o=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=RZ8f6yx+IGqsgI9sgMl2O96dV0/sWGFZrJ3FAu8l1KC5NFP5BBaatI7gV6eW1xcoS
	 4ehJ+GTF+Zf/Qk3uIdPTSch89U2fxk3jsNALl4c7RRfVfnRs4RMxaw5hGRdtBsCetb
	 8lhU8mOSu9/zcWkML8ioB13IWGyJXeC/Ortl0PfXTRyLNvGtgInNvskYec3lcjUScj
	 PF+zTIlT9oMSPRcHkp7D9eDEGrEXFpA+x7vpMYNpN45h2qKs6pov2CxlVhqU00yuz6
	 Ff4UFAe07D7E9l1KfEInQS7/ajpTHyRsL72nPfShxaTw1AeW19i7z+irUNs+NXpO2m
	 t6Ebn6071UFMw==
Date: Tue, 02 Sep 2025 08:18:29 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 wens@csie.org, kuba@kernel.org, mripard@kernel.org, davem@davemloft.net, 
 netdev@vger.kernel.org
To: Conley Lee <conleylee@foxmail.com>
In-Reply-To: <tencent_C4014DA405A96C2E1E7FEFCC050BA56D5B08@qq.com>
References: <tencent_C4014DA405A96C2E1E7FEFCC050BA56D5B08@qq.com>
Message-Id: <175678731505.878234.8586954068434331429.robh@kernel.org>
Subject: Re: [PATCH 2/2] net: ethernet: sun4i-emac: enable dma rx in sun4i


On Sat, 30 Aug 2025 15:50:00 +0800, Conley Lee wrote:
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

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/allwinner/' for tencent_C4014DA405A96C2E1E7FEFCC050BA56D5B08@qq.com:

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






