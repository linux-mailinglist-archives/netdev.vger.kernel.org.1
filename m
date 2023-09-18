Return-Path: <netdev+bounces-34656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7528E7A51D1
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5CD1C20CE1
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A08D26E08;
	Mon, 18 Sep 2023 18:13:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7262628D;
	Mon, 18 Sep 2023 18:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9611C433C8;
	Mon, 18 Sep 2023 18:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695060808;
	bh=rQ7ojhg05dRv+DYjdzxtwP35g4EgY5jql6tHXuMTQJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A9MTYIWeX6qk/C2NyyQZJsGmkblO+CavtmKS3/LkcoyVDKlKm3UMpqXWtKQVjPSPh
	 P9SGB8nAeDA3/TdvpUYDo8iyArokxssFSU2zhYissgl4C3jsYBjoAIs2kNHyzI3uKJ
	 dLERPpgiGV576S3L9yGF0jfUINiS6a40lLYn5CdayIZk+07/4oE3a12w64ku9VKiO1
	 ndQ4U9jqJCHjN/krZ8vPEGLpkPVlYC/1fdSm6IF6h2Y5T+nWNrVLKjFRl5hn92NDW5
	 XipP+Vnp8GULgxTMvZHToE/3q0oSMZdoXAhA3FnqDgWD2crGb330IFlahMlm9BunKr
	 SxwrcGcWJz5ew==
Received: (nullmailer pid 1463138 invoked by uid 1000);
	Mon, 18 Sep 2023 18:13:19 -0000
Date: Mon, 18 Sep 2023 13:13:19 -0500
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, George McCollister <george.mccollister@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, Kurt Kanzenbach <kurt@linutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, Linus Walleij <linus.walleij@linaro.org>, Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, Marcin Wojtas <mw@semihalf.com>, "Russell King (Oracle)" <linux@armlinux.org.uk>, Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>
 , Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Daniel Golle <daniel@makrotopia.org>, Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@microchip.com>, Marek Vasut <marex@denx.de>, Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, John Crispin <john@phrozen.org>, Madalin Bucur <madalin.bucur@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, Horatiu Vultur <horatiu.vultur@microchip.com>, Oleksij Rempel <linux@rempel-privat.de>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Sekhar
  Nori <nsekhar@ti.com>, Shyam Pandey <radhey.shyam.pandey@xilinx.com>, mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v2 07/10] dt-bindings: net: enforce phylink
 bindings on certain ethernet controllers
Message-ID: <20230918181319.GA1445647-robh@kernel.org>
References: <20230916110902.234273-1-arinc.unal@arinc9.com>
 <20230916110902.234273-8-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230916110902.234273-8-arinc.unal@arinc9.com>

On Sat, Sep 16, 2023 at 02:08:59PM +0300, Arınç ÜNAL wrote:
> Phylink bindings are required for ethernet controllers that utilise
> phylink_fwnode_phy_connect() directly or through phylink_of_phy_connect(),
> and register OF-based only MDIO buses, if they register any.

What is phylink?

Don't describe/justify binding changes based on some Linux functions.

> All the drivers that utilise phylink_fwnode_phy_connect() directly or
> through phylink_of_phy_connect():
> 
> - DSA
> - drivers/net/ethernet/mscc/ocelot_net.c
>   - mscc,vsc7514-switch.yaml
> - drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
>   - microchip,sparx5-switch.yaml
> - drivers/net/ethernet/altera/altera_tse_main.c
>   - altr,tse.yaml
> - drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>   - xlnx,axi-ethernet.yaml
> - drivers/net/ethernet/mediatek/mtk_eth_soc.c
>   - mediatek,net.yaml
> - drivers/net/ethernet/ti/am65-cpsw-nuss.c
>   - ti,k3-am654-cpsw-nuss.yaml
> - drivers/net/ethernet/atheros/ag71xx.c
>   - qca,ar71xx.yaml
> - drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
>   - fsl,fman-dtsec.yaml
> - drivers/net/ethernet/microchip/lan966x/lan966x_main.c
>   - microchip,lan966x-switch.yaml
> - drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
>   - marvell,pp2.yaml
> - drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
>   - fsl,qoriq-mc-dpmac.yaml
> - drivers/net/ethernet/cadence/macb_main.c
>   - cdns,macb.yaml
>   - Can register non-OF-based bus.
> - drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>   - snps,dwmac.yaml
>   - Can register non-OF-based bus.
> - drivers/net/ethernet/marvell/mvneta.c
>   - marvell-armada-370-neta.txt
> - drivers/net/ethernet/freescale/enetc/enetc.c
>   - fsl-enetc.txt
> 
> RFC: The drivers marked with "can register non-OF-based bus" seem to search
> the MDIO bus to connect the PHY to the MAC using phylink_connect_phy()
> and/or phy_find_first() if phylink bindings don't exist. Should we enforce
> phylink bindings on their schemas regardless?

Generally, describing the MDIO bus in DT is optional because the devices 
on the bus can be discovered. But then sometimes a device can't be 
discovered or has additional properties which aren't discoverable. So in 
general, an MDIO bus in DT should always be optional, but always 
supported (and validated) if present. If the device has a separate node 
for the MDIO controller (i.e. one with a compatible and reg for the MDIO 
controller register), then that should always be there (because the h/w 
is always there).

Rob

