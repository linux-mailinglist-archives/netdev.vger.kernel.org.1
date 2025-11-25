Return-Path: <netdev+bounces-241541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C36AC8571C
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 15:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB043A8B4A
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FDF32572F;
	Tue, 25 Nov 2025 14:37:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC918FDBE;
	Tue, 25 Nov 2025 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081426; cv=none; b=PvXhGDWSxVrJyM27m396i+VxxD2LleO2DB/7LVSNhtuiZHP3OwTeUHcdy2e95ygLoZUerEE3fVvE8nv3SWjEGv2rrdO0kQQgF4qAO7sxN7LG7FVkAqzfzrBi7d93LwVciNTLbTww5DGeaipQBQGXV/aQM0+12xtaJJw7X7i+PwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081426; c=relaxed/simple;
	bh=YEjq5frnZSrm+C4fWb6Fqm0K59Py4BtM4uY6AlP45Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1B3dM0A0fv+s4omU328YpuYQzuldvxT89vc/H2+jtn0RtL5fhoOWQKSAssqP3gqkRTTzIzFpq4xsJC0ZH3BRgSlc+phljs8Fhs45F2W+Bm6tbgffj6UdMmq3mW9QLCc/oNejsoHTaIWOthXBXkX3r8gbomGM+Au8u3NAlte1fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vNu9y-000000003cW-1OUO;
	Tue, 25 Nov 2025 14:36:50 +0000
Date: Tue, 25 Nov 2025 14:36:42 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH net-next 0/9] XPCS polarity inversion via generic device
 tree properties
Message-ID: <aSW--slbJWpXK0nv@makrotopia.org>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122193341.332324-1-vladimir.oltean@nxp.com>

On Sat, Nov 22, 2025 at 09:33:32PM +0200, Vladimir Oltean wrote:
> Polarity inversion (described in patch 3/6) is a feature with at least 3
> potential new users waiting for a generic description:
> - Horatiu Vultur with the lan966x SerDes
> - Daniel Golle with the MaxLinear GSW1xx switches
> - Me with a custom SJA1105 board, switch which uses the DesignWare XPCS
> 
> I became interested in exploring the problem space because I was averse
> to the idea of adding vendor-specific device tree properties to describe
> a common need.

Thank you for coming up with a good solution, and even generalizing
this beyond networking scope :)

> 
> This set contains an implementation of a generic feature that should
> cater to all known needs that were identified during my documentation
> phase. I've added a new user - the XPCS - and I've converted an existing
> user - the EN8811H Ethernet PHY.
> 
> I haven't converted the rest due to various reasons:
> - "mediatek,pnswap" is defined bidirectionally and the underlying
>   SGMII_PN_SWAP_TX_RX register field doesn't make it clear which bit is
>   RX and which is TX. Needs more work and expert knowledge from maintainer.

Just to quickly answer to that one from MediaTek's SDK[1]:
#define SGMII_PN_SWAP_RX               BIT(1)
#define SGMII_PN_SWAP_TX               BIT(0)

So MediaTek LynxI is ready to be supported via the standard properties
you are suggesting.

[1]: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/5cecec123e1ab4c7f4eabd5630e8e8b2e89b9cf0/autobuild/unified/filogic/master/files/target/linux/mediatek/patches-6.6/999-2607-net-pcs-mtk-lynxi-add-individual-polarity-control.patch


> - "st,px_rx_pol_inv" - its binding is a .txt file and I don't have time
>   for such a large detour to convert it to dtschema.
> - "st,pcie-tx-pol-inv" and "st,sata-tx-pol-inv" - these are defined in a
>   .txt schema but are not implemented in any driver. My verdict would be
>   "delete the properties" but again, I would prefer not introducing such
>   dependency to this series.
> 
> Vladimir Oltean (9):
>   dt-bindings: phy: rename transmit-amplitude.yaml to
>     phy-common-props.yaml
>   dt-bindings: phy-common-props: create a reusable "protocol-names"
>     definition
>   dt-bindings: phy-common-props: RX and TX lane polarity inversion
>   dt-bindings: net: xpcs: allow properties from phy-common-props.yaml
>   phy: add phy_get_rx_polarity() and phy_get_tx_polarity()
>   net: pcs: xpcs: promote SJA1105 TX polarity inversion to core
>   net: pcs: xpcs: allow lane polarity inversion
>   net: phy: air_en8811h: deprecate "airoha,pnswap-rx" and
>     "airoha,pnswap-tx"
>   dt-bindings: net: airoha,en8811h: deprecate "airoha,pnswap-rx" and
>     "airoha,pnswap-tx"
> 
>  .../bindings/net/airoha,en8811h.yaml          |  11 +-
>  .../bindings/net/pcs/snps,dw-xpcs.yaml        |   5 +-
>  .../bindings/phy/phy-common-props.yaml        | 152 ++++++++++++++++++
>  .../bindings/phy/transmit-amplitude.yaml      | 103 ------------
>  MAINTAINERS                                   |  21 +++
>  drivers/net/pcs/Kconfig                       |   1 +
>  drivers/net/pcs/pcs-xpcs-nxp.c                |  11 --
>  drivers/net/pcs/pcs-xpcs.c                    |  58 ++++++-
>  drivers/net/pcs/pcs-xpcs.h                    |   2 +-
>  drivers/net/phy/Kconfig                       |   1 +
>  drivers/net/phy/air_en8811h.c                 |  50 ++++--
>  drivers/phy/Kconfig                           |   9 ++
>  drivers/phy/Makefile                          |   1 +
>  drivers/phy/phy-common-props.c                | 117 ++++++++++++++
>  include/dt-bindings/phy/phy.h                 |   4 +
>  include/linux/phy/phy-common-props.h          |  20 +++
>  16 files changed, 426 insertions(+), 140 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-common-props.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/transmit-amplitude.yaml
>  create mode 100644 drivers/phy/phy-common-props.c
>  create mode 100644 include/linux/phy/phy-common-props.h
> 
> -- 
> 2.34.1
> 

