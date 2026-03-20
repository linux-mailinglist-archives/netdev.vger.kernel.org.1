Return-Path: <netdev+bounces-269861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHQ/B+0OvWkz6QIAu9opvQ
	(envelope-from <netdev+bounces-269861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:10:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 712ED2D7C68
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CF5C303661B
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006203783A2;
	Fri, 20 Mar 2026 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEEEVi4u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6378D377EC1;
	Fri, 20 Mar 2026 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773997633; cv=none; b=qnuJ1GnzeFcWIUEP8S6gGDHiDhuIaJlHd87Q11xOSH/eQcBIyXKUOkxDbbfILjJp/i57SXXyljUW2QdtvRhXgPFdUvtyQD1NZ5qGuUYdptD0MWtKsQ5Q6U+QP4y0C4sog6ykuV8pamRaweaE41UQuEJ0FupD7DH4f0xIliv9KIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773997633; c=relaxed/simple;
	bh=xIcEabRzmhWG1ztGOxh6GMzv3CTVJVuSsogqTI/knbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLxsM1/lHXTsQUXp030HBeOGXW+vjo0AEHi2BQ2NFj7dlds7LL16aIRyYEQAYxQJ6BJKmdnVhWiHrk1M2nj9J/GpFozwO5qSOfEP/Iy41xSHf9XNN4f7DdjyQJ6WoqzKQmEmKn1sr4bBVRAnqIaWKeRq0Q0q+Dbe8JYJfNTWo74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEEEVi4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E640C2BCAF;
	Fri, 20 Mar 2026 09:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773997632;
	bh=xIcEabRzmhWG1ztGOxh6GMzv3CTVJVuSsogqTI/knbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iEEEVi4uTjV4CwO5qP33wWt537tMrtwsC6ec6foPUKbrzW5+xOIwBOFNlnfTriGph
	 uw6YKprvuE9tMwIoNzyVHL4fMYcySjGZNCm7Cf4TDh5yKeCjfrp6sZIGSeCBoTpbRO
	 Oy818KobMyveN9O3hMlqPh4n7W5ko8JJDf6KrPd+3n2OpN14+FyTNXYZ22PZvNF529
	 YVepZnBRmKpdfcx7P9ZckF7k5dr8yzRXgmITG+ziruMag0Raddw92+WGh1BwV3aVFS
	 aH3E8vp7sGmAm0hDWeLmQ07sNbmCCdX5E8qllAJ05ZPnHU/SOAjb3/I7SAGqv6kfFi
	 lXIYv3+p1uImw==
Date: Fri, 20 Mar 2026 17:07:10 +0800
From: Yixun Lan <dlan@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v3] riscv: dts: spacemit: Add ethernet device for K3
Message-ID: <20260320090710-GKA525649@kernel.org>
References: <20260318035542.517554-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318035542.517554-1-inochiama@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269861-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,gentoo.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.923];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlan@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[16];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 712ED2D7C68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Inochi,

On 11:55 Wed 18 Mar     , Inochi Amaoto wrote:
> Add all ethernet device nodes for K3 SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
> Require the following patch series:
> 1. Basic DT device patch
> https://lore.kernel.org/spacemit/20260304-01-dts-uart-full-v1-0-50a0aa53a245@kernel.org
> 2. Ethernet driver patch
> https://lore.kernel.org/spacemit/20260316010041.164360-1-inochiama@gmail.com
> 
> Changed from v2:
> 1. keep aliases in alphabetical order.
> 
> Changed from v1:
> 1. remove interrupt-parents property
> 2. add aliases for ethernet node
> ---
>  arch/riscv/boot/dts/spacemit/k3-pico-itx.dts |  25 +++++
>  arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi |  48 +++++++++
>  arch/riscv/boot/dts/spacemit/k3.dtsi         | 104 +++++++++++++++++++
>  3 files changed, 177 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> index b691304d4b74..28e86e8df4d3 100644
> --- a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> +++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> @@ -4,13 +4,19 @@
>   * Copyright (c) 2026 Guodong Xu <guodong@riscstar.com>
>   */
> 
> +#include <dt-bindings/gpio/gpio.h>
> +
>  #include "k3.dtsi"
> +#include "k3-pinctrl.dtsi"
> 
>  / {
>  	model = "SpacemiT K3 Pico-ITX";
>  	compatible = "spacemit,k3-pico-itx", "spacemit,k3";
> 
>  	aliases {
> +		ethernet0 = &eth0;
> +		ethernet1 = &eth1;
> +		ethernet2 = &eth2;
>  		serial0 = &uart0;
>  	};
> 
> @@ -24,6 +30,25 @@ memory@100000000 {
>  	};
>  };
> 
> +&eth0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac0_cfg>;
> +
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&phy0>;
> +	status = "okay";
> +
> +	mdio {
> +		phy0: phy@1 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <1>;
> +			reset-gpios = <&gpio 0 15 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <10000>;
> +			reset-deassert-us = <10000>;
> +		};
> +	};
> +};
> +
>  &uart0 {
>  	status = "okay";
>  };
> diff --git a/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
> new file mode 100644
> index 000000000000..414ee221d3d7
> --- /dev/null
> +++ b/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2026 SpacemiT (Hangzhou) Technology Co. Ltd
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +#define K3_PADCONF(pin, func) (((pin) << 16) | (func))
> +
> +&pinctrl {
> +	gmac0_cfg: gmac0-cfg {
> +		gmac0_base_pins: gmac0-0-pins {
is this a RMII mode? I have not checked, but it's rare to see boards
use RMII only.. I mean it's probably not that much valuable..

if it's valid, suggest name it more explicitly: gmac0_rmii_pins?

> +			pinmux = <K3_PADCONF(0, 1)>,
suggest to add a comment at the end, something like
			pinmux = <K3_PADCONF(0, 1)>, /* gmac0_rxdv */

> +				 <K3_PADCONF(1, 1)>,
> +				 <K3_PADCONF(2, 1)>,
> +				 <K3_PADCONF(3, 1)>,
> +				 <K3_PADCONF(6, 1)>,
> +				 <K3_PADCONF(7, 1)>,
> +				 <K3_PADCONF(11, 1)>,
> +				 <K3_PADCONF(12, 1)>,
> +				 <K3_PADCONF(13, 1)>;
> +
> +			bias-disable;
> +			drive-strength = <25>;
> +			power-source = <1800>;
> +		};
> +
> +		gmac0_rgmii_add_pins: gmac0-1-pins {
> +			pinmux = <K3_PADCONF(4, 1)>,
> +				 <K3_PADCONF(5, 1)>,
> +				 <K3_PADCONF(8, 1)>,
> +				 <K3_PADCONF(9, 1)>,
> +				 <K3_PADCONF(10, 1)>;
> +
> +			bias-disable;
> +			drive-strength = <25>;
> +			power-source = <1800>;
> +		};
> +
> +		gmac0_int_pins: gmac0-3-pins {
> +			pinmux = <K3_PADCONF(14, 1)>;
> +
> +			bias-disable;
> +			drive-strength = <25>;
> +			power-source = <1800>;
> +		};
You've divided pins into different groups, but how can we reuse them?
I can think one case at the device level in boards dts, request different
combination for different use cases..
	pinctrl = <&gmac0_base_pins>, <&gmac0_rgmii_add_pins>;

btw, the pin GMAC0_REF0_CLK_25M is missing, it probably depend on final
schematics, to use 25M clock from SoC (need to request this pin), or use
external 25M crytal (no need to request)

also it would be great to list pins for gmac1, 2, but I'm fine without
them.. can do it when there is board really use them..

> +	};
> +};
> diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
> index 6cc31e94c13a..4c0cc135dc09 100644
> --- a/arch/riscv/boot/dts/spacemit/k3.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
> @@ -5,6 +5,7 @@
>   */
> 
>  #include <dt-bindings/clock/spacemit,k3-clocks.h>
> +#include <dt-bindings/reset/spacemit,k3-resets.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> 
>  /dts-v1/;
> @@ -437,6 +438,109 @@ soc: soc {
>  		dma-noncoherent;
>  		ranges;
> 
> +		gmac_axi_setup: stmmac-axi-config {
> +			snps,wr_osr_lmt = <0xf>;
> +			snps,rd_osr_lmt = <0xf>;
> +			/* max axi burst len is 256 */
> +			snps,blen = <256 128 64 32 16 0 0>;
> +		};
> +
> +		eth0: ethernet@cac80000 {
> +			compatible = "spacemit,k3-dwmac", "snps,dwmac-5.40a";
> +			reg = <0x0 0xcac80000 0x0 0x2000>;
> +			clocks = <&syscon_apmu CLK_APMU_EMAC0_BUS>,
> +				 <&syscon_apmu CLK_APMU_EMAC0_1588>,
> +				 <&syscon_apmu CLK_APMU_EMAC0_RGMII_TX>;
> +			clock-names = "stmmaceth", "ptp_ref", "tx";
> +			interrupts = <131 IRQ_TYPE_LEVEL_HIGH>,
> +				     <276 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq", "eth_wake_irq";
> +			resets = <&syscon_apmu RESET_APMU_EMAC0>;
> +			reset-names = "stmmaceth";
> +			rx-fifo-depth = <8192>;
> +			tx-fifo-depth = <8192>;
> +			snps,multicast-filter-bins = <64>;
> +			snps,perfect-filter-entries = <32>;
> +			snps,aal;
> +			snps,tso;
> +			snps,txpbl = <8>;
> +			snps,rxpbl = <8>;
> +			snps,force_sf_dma_mode;
> +			snps,axi-config = <&gmac_axi_setup>;
> +			spacemit,apmu = <&syscon_apmu 0x3e4 0x3e8>;
> +			status = "disabled";
> +
> +			mdio {
> +				compatible = "snps,dwmac-mdio";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
> +		eth1: ethernet@cac82000 {
> +			compatible = "spacemit,k3-dwmac", "snps,dwmac-5.40a";
> +			reg = <0x0 0xcac82000 0x0 0x2000>;
> +			clocks = <&syscon_apmu CLK_APMU_EMAC1_BUS>,
> +				 <&syscon_apmu CLK_APMU_EMAC1_1588>,
> +				 <&syscon_apmu CLK_APMU_EMAC1_RGMII_TX>;
> +			clock-names = "stmmaceth", "ptp_ref", "tx";
> +			interrupts = <133 IRQ_TYPE_LEVEL_HIGH>,
> +				     <277 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq", "eth_wake_irq";
> +			resets = <&syscon_apmu RESET_APMU_EMAC1>;
> +			reset-names = "stmmaceth";
> +			rx-fifo-depth = <8192>;
> +			tx-fifo-depth = <8192>;
> +			snps,multicast-filter-bins = <64>;
> +			snps,perfect-filter-entries = <32>;
> +			snps,aal;
> +			snps,tso;
> +			snps,txpbl = <8>;
> +			snps,rxpbl = <8>;
> +			snps,force_sf_dma_mode;
> +			snps,axi-config = <&gmac_axi_setup>;
> +			spacemit,apmu = <&syscon_apmu 0x3ec 0x3f0>;
> +			status = "disabled";
> +
> +			mdio {
> +				compatible = "snps,dwmac-mdio";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
> +		eth2: ethernet@cac8e000 {
> +			compatible = "spacemit,k3-dwmac", "snps,dwmac-5.40a";
> +			reg = <0x0 0xcac8e000 0x0 0x2000>;
> +			clocks = <&syscon_apmu CLK_APMU_EMAC2_BUS>,
> +				 <&syscon_apmu CLK_APMU_EMAC2_1588>,
> +				 <&syscon_apmu CLK_APMU_EMAC2_RGMII_TX>;
> +			clock-names = "stmmaceth", "ptp_ref", "tx";
> +			interrupts = <130 IRQ_TYPE_LEVEL_HIGH>,
> +				     <278 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq", "eth_wake_irq";
> +			resets = <&syscon_apmu RESET_APMU_EMAC2>;
> +			reset-names = "stmmaceth";
> +			rx-fifo-depth = <4096>;
> +			tx-fifo-depth = <4096>;
> +			snps,multicast-filter-bins = <64>;
> +			snps,perfect-filter-entries = <32>;
> +			snps,aal;
> +			snps,tso;
> +			snps,txpbl = <8>;
> +			snps,rxpbl = <8>;
> +			snps,force_sf_dma_mode;
> +			snps,axi-config = <&gmac_axi_setup>;
> +			spacemit,apmu = <&syscon_apmu 0x248 0x24c>;
> +			status = "disabled";
> +
> +			mdio {
> +				compatible = "snps,dwmac-mdio";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
>  		syscon_apbc: system-controller@d4015000 {
>  			compatible = "spacemit,k3-syscon-apbc";
>  			reg = <0x0 0xd4015000 0x0 0x1000>;
> --
> 2.53.0
> 

-- 
Yixun Lan (dlan)

