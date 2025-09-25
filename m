Return-Path: <netdev+bounces-226147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B194B9CFE1
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 03:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220624A1053
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1452DF122;
	Thu, 25 Sep 2025 01:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fisDoom0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494EC2DECD6;
	Thu, 25 Sep 2025 01:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758763098; cv=none; b=QgqobTucZzp+4y9n5PpTuIPltVFL3HEz4LB+q6Wk+rb3t4qxW+BzjKiE8uwOxd23iV7Nk/V+7Bm9ztnO7UfP5RFGuk1E0GH9EkikCzUwIXuA+SN9+IIS8QSAWvR7m44QV5hhQt8RIC+kBxztZkPMr9SN04SzwS0Eb5YC+91/ruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758763098; c=relaxed/simple;
	bh=dcMGML8nIKL54kbpLGP4hmfYVS3GxsNhXjY7EifHJFg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=AX37ajeDeNyvcpG4vAnm6Y4K+P9IksUzuEc03eMtnG010mkAFg1f8kiSCrXKAptKG0B2cNxo/Up7tVPBKsFJ5+7cntKfvv70MEuKTj7R82b1vGKiav9dGOs21Pi35FZOUAvGs3Nksuu8qCDUO1WfC7RVuQYoAOK8dkCZl2G39Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fisDoom0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA6DC4CEF7;
	Thu, 25 Sep 2025 01:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758763096;
	bh=dcMGML8nIKL54kbpLGP4hmfYVS3GxsNhXjY7EifHJFg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=fisDoom0bp0IExYdpwTaduh4U29KIGvkrVXZJJBbQL/s3v9w79ct8Rqfpi8+DJC2w
	 5UB42mGvCQK3RVSyKfmzKHGfbI8VRDHM9DIk1MSS4v5IhM+/FW63Nr7rhIAAPDa3fD
	 0Lk5cZMmkRsxO1S52+2APJykTmJvuhFayfBJ/exSJBtppK7xVgVFtwUBfAoWJvnstp
	 k7t5SudwkTbJNpObMvwZI+C70Fu/RAn/45nNM5TGFhPqTA1S61QkpeezbfXAQaztGV
	 it4G1s6T3+6Q1UxD5jvfSq/OhEKm45DxqGaoKfkmLLtlbjUy4iQ85AS3ByyG30p2tS
	 Tibh2gKvR9U0g==
Date: Wed, 24 Sep 2025 20:18:15 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 linux-sound@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 imx@lists.linux.dev, Vladimir Oltean <olteanv@gmail.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 David Jander <david@protonic.nl>, Lucas Stach <l.stach@pengutronix.de>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>
To: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <20250924-imx8mp-prt8ml-v3-0-f498d7f71a94@pengutronix.de>
References: <20250924-imx8mp-prt8ml-v3-0-f498d7f71a94@pengutronix.de>
Message-Id: <175876283065.3268812.10851892974485151512.robh@kernel.org>
Subject: Re: [PATCH v3 0/3] Mainline Protonic PRT8ML board


On Wed, 24 Sep 2025 10:34:11 +0200, Jonas Rebmann wrote:
> This series adds the Protonic PRT8ML device tree as well as some minor
> corrections to the devicetree bindings used.
> 
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> ---
> Changes in v3:
> - Add comment on the intentional limitation to 100Mbps RGMII
> - Link to v2: https://lore.kernel.org/r/20250918-imx8mp-prt8ml-v2-0-3d84b4fe53de@pengutronix.de
> 
> Changes in v2:
> - Dropped "ASoC: dt-bindings: asahi-kasei,ak4458: Reference common DAI
>   properties", applied to broonie/sound for-next (Thanks, Mark)
> - Updated description of the reset-gpios property in sja1105 binding to
>   address the issues of connecting this pin to GPIO (Thanks, Vladimir)
> - Added the fec, switch and phy for RJ45 onboard ethernet after
>   successful testing
> - Consistently use interrupts-extended
> - Link to v1: https://lore.kernel.org/r/20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de
> 
> ---
> Jonas Rebmann (3):
>       dt-bindings: net: dsa: nxp,sja1105: Add reset-gpios property
>       dt-bindings: arm: fsl: Add Protonic PRT8ML
>       arm64: dts: add Protonic PRT8ML board
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml     |   1 +
>  .../devicetree/bindings/net/dsa/nxp,sja1105.yaml   |   9 +
>  arch/arm64/boot/dts/freescale/Makefile             |   1 +
>  arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dts    | 501 +++++++++++++++++++++
>  4 files changed, 512 insertions(+)
> ---
> base-commit: ea21fa34164c9ea0a2a5b8714c7e36f54c7fb46e
> change-id: 20250701-imx8mp-prt8ml-01be34684659
> 
> Best regards,
> --
> Jonas Rebmann <jre@pengutronix.de>
> 
> 
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
 Base: using specified base-commit ea21fa34164c9ea0a2a5b8714c7e36f54c7fb46e

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/freescale/' for 20250924-imx8mp-prt8ml-v3-0-f498d7f71a94@pengutronix.de:

arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: codec@11 (asahi-kasei,ak4458): '#sound-dai-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/sound/asahi-kasei,ak4458.yaml#
arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: isp@32e10000 (fsl,imx8mp-isp): 'power-domain-names' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/media/rockchip-isp1.yaml#
arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: isp@32e10000 (fsl,imx8mp-isp): power-domains: [[77, 6], [77, 1]] is too long
	from schema $id: http://devicetree.org/schemas/media/rockchip-isp1.yaml#
arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: isp@32e20000 (fsl,imx8mp-isp): 'power-domain-names' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/media/rockchip-isp1.yaml#
arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: isp@32e20000 (fsl,imx8mp-isp): power-domains: [[77, 6], [77, 4]] is too long
	from schema $id: http://devicetree.org/schemas/media/rockchip-isp1.yaml#






