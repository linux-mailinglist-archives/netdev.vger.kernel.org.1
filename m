Return-Path: <netdev+bounces-234663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 522D9C25875
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 15:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA3EE4F7617
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 14:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE2B330B36;
	Fri, 31 Oct 2025 14:12:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6B26ED55;
	Fri, 31 Oct 2025 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919922; cv=none; b=WHjeBlkCr1RZXOMPAjBziV4MIHTbvfXQsTngjb/IJS9Y+/ZkDo3tCdhXloQOcvI75XuI6jGtEysLOhUQG6YGvV+JvtRj+dQwLqLLndR6kumSD3sU8zviR6pKC/C+p1iXGIisrwAIrSEfvxxbNnAoMlF7XPw7o1Uy2uY2g6FzsFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919922; c=relaxed/simple;
	bh=+T4v+KUgJc/8+w8pb5xNmHcDFnylEKU+WWd2hPof9DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipIMFD4rrk2QYxgSGEHKOSNF/A6RX1HntaI1qd2Etjt3Nt/DKIJCGPMKpFdHTLNOkpVt+UzAdgpzTuKkPWFe3RQdd+XE4NZlU4CFfZEIpBVGnCQv1WICIj4vUGQH0eYkQbZuoWCIeA9a5WvXwybVX2f+XseHINutAg5jQcfpH70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D76C4202F7E;
	Fri, 31 Oct 2025 15:04:55 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CA781202F7C;
	Fri, 31 Oct 2025 15:04:55 +0100 (CET)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8372720259;
	Fri, 31 Oct 2025 15:04:55 +0100 (CET)
Date: Fri, 31 Oct 2025 15:04:55 +0100
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: freescale: Add GMAC Ethernet for S32G2 EVB
 and RDB2 and S32G3 RDB3
Message-ID: <aQTCBwLzhRDl+pH9@lsv051416.swis.nl-cdc01.nxp.com>
References: <20251006-nxp-s32g-boards-v1-1-f70a57b8087f@oss.nxp.com>
 <aP8Ezk_zjo-NZCD4@dragon>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP8Ezk_zjo-NZCD4@dragon>
X-Virus-Scanned: ClamAV using ClamSMTP

On Mon, Oct 27, 2025 at 01:36:14PM +0800, Shawn Guo wrote:
> On Mon, Oct 06, 2025 at 06:31:28PM +0200, Jan Petrous via B4 Relay wrote:
> > From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> > 
> > Add support for the Ethernet connection over GMAC controller connected to
> > the Micrel KSZ9031 Ethernet RGMII PHY located on the boards.
> > 
> > The mentioned GMAC controller is one of two network controllers
> > embedded on the NXP Automotive SoCs S32G2 and S32G3.
> > 
> > The supported boards:
> >  * EVB:  S32G-VNP-EVB with S32G2 SoC
> >  * RDB2: S32G-VNP-RDB2
> >  * RDB3: S32G-VNP-RDB3
> > 
> > Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/s32g2.dtsi        | 50 ++++++++++++++++++++++++-
> >  arch/arm64/boot/dts/freescale/s32g274a-evb.dts  | 21 ++++++++++-
> >  arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts | 19 ++++++++++
> >  arch/arm64/boot/dts/freescale/s32g3.dtsi        | 50 ++++++++++++++++++++++++-
> >  arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts | 21 ++++++++++-
> >  5 files changed, 157 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > index d167624d1f0c..d06103e9564e 100644
> > --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > @@ -3,7 +3,7 @@
> >   * NXP S32G2 SoC family
> >   *
> >   * Copyright (c) 2021 SUSE LLC
> > - * Copyright 2017-2021, 2024 NXP
> > + * Copyright 2017-2021, 2024-2025 NXP
> >   */
> >  
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > @@ -738,5 +738,53 @@ gic: interrupt-controller@50800000 {
> >  			interrupt-controller;
> >  			#interrupt-cells = <3>;
> >  		};
> > +
> > +		gmac0: ethernet@4033c000 {
> 
> Please sort devices in order of unit-address.
> 

Moved up.

> > +			compatible = "nxp,s32g2-dwmac";
> > +			reg = <0x4033c000 0x2000>, /* gmac IP */
> > +			      <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> > +			interrupt-parent = <&gic>;
> > +			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "macirq";
> > +			snps,mtl-rx-config = <&mtl_rx_setup>;
> > +			snps,mtl-tx-config = <&mtl_tx_setup>;
> > +			status = "disabled";
> > +
> > +			mtl_rx_setup: rx-queues-config {
> > +				snps,rx-queues-to-use = <5>;
> > +
> > +				queue0 {
> > +				};
> 
> We usually have newline between nodes.
> 

Added newline between queue subnodes.

> > +				queue1 {
> > +				};
> > +				queue2 {
> > +				};
> > +				queue3 {
> > +				};
> > +				queue4 {
> > +				};
> > +			};
> > +
> > +			mtl_tx_setup: tx-queues-config {
> > +				snps,tx-queues-to-use = <5>;
> > +
> > +				queue0 {
> > +				};
> > +				queue1 {
> > +				};
> > +				queue2 {
> > +				};
> > +				queue3 {
> > +				};
> > +				queue4 {
> > +				};
> > +			};
> > +
> > +			gmac0mdio: mdio {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "snps,dwmac-mdio";
> > +			};
> > +		};
> >  	};
> >  };
> > diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> > index c4a195dd67bf..f020da03979a 100644
> > --- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> > +++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> > @@ -1,7 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> >  /*
> >   * Copyright (c) 2021 SUSE LLC
> > - * Copyright 2019-2021, 2024 NXP
> > + * Copyright 2019-2021, 2024-2025 NXP
> >   */
> >  
> >  /dts-v1/;
> > @@ -15,6 +15,7 @@ / {
> >  
> >  	aliases {
> >  		serial0 = &uart0;
> > +		ethernet0 = &gmac0;
> 
> Sort aliases in alphabetical order.

Swapped.

> 
> Shawn
> 

Prepared v2.
Thanks for review.

/Jan

> >  	};
> >  
> >  	chosen {
> > @@ -43,3 +44,21 @@ &usdhc0 {
> >  	no-1-8-v;
> >  	status = "okay";
> >  };
> > +
> > +&gmac0 {
> > +	clocks = <&clks 24>, <&clks 19>, <&clks 18>, <&clks 15>;
> > +	clock-names = "stmmaceth", "tx", "rx", "ptp_ref";
> > +	phy-mode = "rgmii-id";
> > +	phy-handle = <&rgmiiaphy4>;
> > +	status = "okay";
> > +};
> > +
> > +&gmac0mdio {
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +
> > +	/* KSZ 9031 on RGMII */
> > +	rgmiiaphy4: ethernet-phy@4 {
> > +		reg = <4>;
> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> > index 4f58be68c818..b9c2f964b3f7 100644
> > --- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> > +++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> > @@ -16,6 +16,7 @@ / {
> >  	aliases {
> >  		serial0 = &uart0;
> >  		serial1 = &uart1;
> > +		ethernet0 = &gmac0;
> >  	};
> >  
> >  	chosen {
> > @@ -77,3 +78,21 @@ &usdhc0 {
> >  	no-1-8-v;
> >  	status = "okay";
> >  };
> > +
> > +&gmac0 {
> > +	clocks = <&clks 24>, <&clks 19>, <&clks 18>, <&clks 15>;
> > +	clock-names = "stmmaceth", "tx", "rx", "ptp_ref";
> > +	phy-mode = "rgmii-id";
> > +	phy-handle = <&rgmiiaphy1>;
> > +	status = "okay";
> > +};
> > +
> > +&gmac0mdio {
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +
> > +	/* KSZ 9031 on RGMII */
> > +	rgmiiaphy1: ethernet-phy@1 {
> > +		reg = <1>;
> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> > index be3a582ebc1b..e31184847371 100644
> > --- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> >  /*
> > - * Copyright 2021-2024 NXP
> > + * Copyright 2021-2025 NXP
> >   *
> >   * Authors: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> >   *          Ciprian Costea <ciprianmarian.costea@nxp.com>
> > @@ -883,6 +883,54 @@ gic: interrupt-controller@50800000 {
> >  			      <0x50420000 0x2000>;
> >  			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> >  		};
> > +
> > +		gmac0: ethernet@4033c000 {
> > +			compatible = "nxp,s32g2-dwmac";
> > +			reg = <0x4033c000 0x2000>, /* gmac IP */
> > +			      <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> > +			interrupt-parent = <&gic>;
> > +			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "macirq";
> > +			snps,mtl-rx-config = <&mtl_rx_setup>;
> > +			snps,mtl-tx-config = <&mtl_tx_setup>;
> > +			status = "disabled";
> > +
> > +			mtl_rx_setup: rx-queues-config {
> > +				snps,rx-queues-to-use = <5>;
> > +
> > +				queue0 {
> > +				};
> > +				queue1 {
> > +				};
> > +				queue2 {
> > +				};
> > +				queue3 {
> > +				};
> > +				queue4 {
> > +				};
> > +			};
> > +
> > +			mtl_tx_setup: tx-queues-config {
> > +				snps,tx-queues-to-use = <5>;
> > +
> > +				queue0 {
> > +				};
> > +				queue1 {
> > +				};
> > +				queue2 {
> > +				};
> > +				queue3 {
> > +				};
> > +				queue4 {
> > +				};
> > +			};
> > +
> > +			gmac0mdio: mdio {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "snps,dwmac-mdio";
> > +			};
> > +		};
> >  	};
> >  
> >  	timer {
> > diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> > index e94f70ad82d9..4a74923789ae 100644
> > --- a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> > +++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> >  /*
> > - * Copyright 2021-2024 NXP
> > + * Copyright 2021-2025 NXP
> >   *
> >   * NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)
> >   */
> > @@ -18,6 +18,7 @@ aliases {
> >  		mmc0 = &usdhc0;
> >  		serial0 = &uart0;
> >  		serial1 = &uart1;
> > +		ethernet0 = &gmac0;
> >  	};
> >  
> >  	chosen {
> > @@ -93,3 +94,21 @@ &usdhc0 {
> >  	disable-wp;
> >  	status = "okay";
> >  };
> > +
> > +&gmac0 {
> > +	clocks = <&clks 24>, <&clks 19>, <&clks 18>, <&clks 15>;
> > +	clock-names = "stmmaceth", "tx", "rx", "ptp_ref";
> > +	phy-mode = "rgmii-id";
> > +	phy-handle = <&rgmiiaphy1>;
> > +	status = "okay";
> > +};
> > +
> > +&gmac0mdio {
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +
> > +	/* KSZ 9031 on RGMII */
> > +	rgmiiaphy1: ethernet-phy@1 {
> > +		reg = <1>;
> > +	};
> > +};
> > 
> > ---
> > base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
> > change-id: 20251006-nxp-s32g-boards-2d156255b592
> > 
> > Best regards,
> > -- 
> > Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> > 
> > 
> 

