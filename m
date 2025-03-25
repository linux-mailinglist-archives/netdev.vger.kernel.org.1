Return-Path: <netdev+bounces-177465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A40D6A7044D
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7DB17124A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4F525B678;
	Tue, 25 Mar 2025 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2WW+D94"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA2A25A652;
	Tue, 25 Mar 2025 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914315; cv=none; b=P8g3an/oC8AG8DLuikwJ/2KT49SJ7uAWrwRZaFu8ac7XNI3ZDns7lS+5zGJbc7Stfjt4fQU2iig39eo+Rk5cUn5DO1Xo4RAvcN0Oa7V7qUzhve/9Ojh1kU9/jw1ZvC0z1qr6p6+c8zLBlDXRzmGsrUKr6NjESt0AU4xTV+A9IoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914315; c=relaxed/simple;
	bh=uV5hAcmXTUSxUEdJgxlWrpYerwxW5ZbmqsbDspBaLIc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=iti8XWGZH6xXGBgr4GPwmva/i9+DoomcUqUmW8h/xdMvhTDRlRomiayRe6w3Hu7cXeV3cPEXkAu2AF494Uxsn9rkuJwb+Jg55oboeHsL8TjCN0zakGsNwHdyy/HCXKgQ+MLq9q2/38TT0/yK/saxcc4ijeX/2Y9mfLMsJRmY1hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2WW+D94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420B5C4CEED;
	Tue, 25 Mar 2025 14:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742914314;
	bh=uV5hAcmXTUSxUEdJgxlWrpYerwxW5ZbmqsbDspBaLIc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=m2WW+D94wxEdAWc0gFzDLPt8BALX5kyVA+IU9Cy/HUA8Alvr4FQYmyqE7C1GeNczu
	 HpT3a50TMFkG5Z2epJD2aaaIXa3HeOewj7Lw91u6cWXr/GJx8lH+GdYNo4lE0ho/5F
	 CyIUQwGvwzP30vC1amrugbuqg1SbVN3y80fkJuXI137o7J1HCdweruWvtUTkb8DwkX
	 H+So3XnWqP9+OGfT149ajYphzZkDqxhDDb8wRAYFgst8qtjrpCpUuTHJy98M1jUfl1
	 kc6dtC/IdRggoSGYVDFcARMyk5Fa0PHZwnQbSRa6zJIKWlctYqNc9oHyc3ym3wCjYl
	 DEOkhDPtQHhuQ==
Date: Tue, 25 Mar 2025 09:51:53 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 davem@davemloft.net, imx@lists.linux.dev, 
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-arm-kernel@lists.infradead.org, 
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
 linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
To: Lukasz Majewski <lukma@denx.de>
In-Reply-To: <20250325115736.1732721-1-lukma@denx.de>
References: <20250325115736.1732721-1-lukma@denx.de>
Message-Id: <174291413928.2015590.6304239007146936808.robh@kernel.org>
Subject: Re: [PATCH 0/5] net: mtip: Add support for MTIP imx287 L2 switch
 driver


On Tue, 25 Mar 2025 12:57:31 +0100, Lukasz Majewski wrote:
> This patch series adds support for More Than IP's L2 switch driver embedded
> in some NXP's SoCs. This one has been tested on imx287, but is also available
> in the vf610.
> 
> In the past there has been performed some attempts to upstream this driver:
> 1. The 4.19-cip based one [1]
> 2. DSA based one for 5.12 [2] - i.e. the switch itself was treat as a DSA switch
>    with NO tag appended.
> 3. The extension for FEC driver for 5.12 [3] - the trick here was to fully reuse
>    FEC when the in-HW switching is disabled. When bridge offloading is enabled,
>    the driver uses already configured MAC and PHY to also configure PHY.
> 
> All three approaches were not accepted as eligible for upstreaming.
> 
> The driver from this series has floowing features:
> 
> 1. It is fully separated from fec_main - i.e. can be used interchangeable
>    with it. To be more specific - one can build them as modules and
>    if required switch between them when e.g. bridge offloading is required.
> 
>    To be more specific:
> 	- Use FEC_MAIN: When one needs support for two ETH ports with separate
> 	  uDMAs used for both and bridging can be realized in SW.
> 
> 	- Use MTIPL2SW: When it is enough to support two ports with only uDMA0
> 	  attached to switch and bridging shall be offloaded to HW.
> 
> 2. This driver uses MTIP's L2 switch internal VLAN feature to provide port
>    separation at boot time. Port separation is disabled when bridging is
>    required.
> 
> 3. Example usage:
> 	Configuration:
> 	ip link set lan0 up; sleep 1;
> 	ip link set lan1 up; sleep 1;
> 	ip link add name br0 type bridge;
> 	ip link set br0 up; sleep 1;
> 	ip link set lan0 master br0;
> 	ip link set lan1 master br0;
> 	bridge link;
> 	ip addr add 192.168.2.17/24 dev br0;
> 	ping -c 5 192.168.2.222
> 
> 	Removal:
> 	ip link set br0 down;
> 	ip link delete br0 type bridge;
> 	ip link set dev lan1 down
> 	ip link set dev lan0 down
> 
> 4. Limitations:
> 	- Driver enables and disables switch operation with learning and ageing.
> 	- Missing is the advanced configuration (e.g. adding entries to FBD). This is
> 	  on purpose, as up till now we didn't had consensus about how the driver
> 	  shall be added to Linux.
> 
> Links:
> [1] - https://github.com/lmajewski/linux-imx28-l2switch/commits/master
> [2] - https://github.com/lmajewski/linux-imx28-l2switch/tree/imx28-v5.12-L2-upstream-RFC_v1
> [3] - https://source.denx.de/linux/linux-imx28-l2switch/-/tree/imx28-v5.12-L2-upstream-switchdev-RFC_v1?ref_type=heads
> 
> 
> 
> Lukasz Majewski (5):
>   MAINTAINERS: Add myself as the MTIP L2 switch maintainer (IMX SoCs:
>     imx287)
>   dt-bindings: net: Add MTIP L2 switch description
>     (fec,mtip-switch.yaml)
>   arm: dts: Adjust the 'reg' range for imx287 L2 switch description
>   arm: dts: imx287: Provide description for MTIP L2 switch
>   net: mtip: The L2 switch driver for imx287
> 
>  .../bindings/net/fec,mtip-switch.yaml         |  160 ++
>  MAINTAINERS                                   |    7 +
>  arch/arm/boot/dts/nxp/mxs/imx28-xea.dts       |   56 +
>  arch/arm/boot/dts/nxp/mxs/imx28.dtsi          |    4 +-
>  drivers/net/ethernet/freescale/Kconfig        |    1 +
>  drivers/net/ethernet/freescale/Makefile       |    1 +
>  drivers/net/ethernet/freescale/mtipsw/Kconfig |   10 +
>  .../net/ethernet/freescale/mtipsw/Makefile    |    6 +
>  .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 2108 +++++++++++++++++
>  .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |  784 ++++++
>  .../ethernet/freescale/mtipsw/mtipl2sw_br.c   |  113 +
>  .../ethernet/freescale/mtipsw/mtipl2sw_mgnt.c |  434 ++++
>  12 files changed, 3682 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/fec,mtip-switch.yaml
>  create mode 100644 drivers/net/ethernet/freescale/mtipsw/Kconfig
>  create mode 100644 drivers/net/ethernet/freescale/mtipsw/Makefile
>  create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
>  create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
>  create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
>  create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c
> 
> --
> 2.39.5
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


New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/nxp/' for 20250325115736.1732721-1-lukma@denx.de:

arch/arm/boot/dts/nxp/mxs/imx28-xea.dtb: /ahb@80080000/switch@800f0000: failed to match any schema with compatible: ['fsl,imx287-mtip-switch']
arch/arm/boot/dts/nxp/imx/imx6q-tx6q-1110.dtb: /lvds1-panel: failed to match any schema with compatible: ['nlt,nl12880bc20-spwg-24']






