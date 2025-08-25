Return-Path: <netdev+bounces-216708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48588B34FB3
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031C53AF14A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 23:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6B123817D;
	Mon, 25 Aug 2025 23:32:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D6319D071;
	Mon, 25 Aug 2025 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756164751; cv=none; b=HemqBIPMCuzz4trYKPyszmT3TczwBNKB0nJmCjwllKkhAP9RdDY8VcCagJUPzIIg60At787+E4KbT7v/X9kumlJZ45Pw7l+G9xC/cKcP7NksYFOOoS2zSfg/jlnMJloh5nx1w9WV3ePjoiuVjKq1dGhAsIoKBDUSITi8KiVmaes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756164751; c=relaxed/simple;
	bh=oIxLa8n1RxCFr+HkEYUHjD9aNW4Zh2UPs6/F5vL3x6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWCKJ4FUeif0SSHFHShc+5XWTl348EZcOt0XUUyfUwOhJS+mIg6eh1Msfc1FXc1mqXZl/T/5p+3GcMFdYuaFEbLON1ZneBLlwyiOGCWlcbk7Tazt4jXkvWD1NXMFWb71Pion1W6ZtmH7O5ivdL/HRChf78jxdndBuaz/dhzF7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id CC847340EF8;
	Mon, 25 Aug 2025 23:32:28 +0000 (UTC)
Date: Tue, 26 Aug 2025 07:32:17 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <uwu@dram.page>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/5] riscv: dts: spacemit: Add Ethernet
 support for K1
Message-ID: <20250825233217-GYA1101079@gentoo.org>
References: <20250820-net-k1-emac-v6-0-c1e28f2b8be5@iscas.ac.cn>
 <20250820-net-k1-emac-v6-3-c1e28f2b8be5@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-net-k1-emac-v6-3-c1e28f2b8be5@iscas.ac.cn>

Hi Vivian,

On 14:47 Wed 20 Aug     , Vivian Wang wrote:
> Add nodes for each of the two Ethernet MACs on K1 with generic
> properties. Also add "gmac" pins to pinctrl config.
> 
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

Reviewed-by: Yixun Lan <dlan@gentoo.org>
> ---
>  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 48 ++++++++++++++++++++++++++++
>  arch/riscv/boot/dts/spacemit/k1.dtsi         | 22 +++++++++++++
>  2 files changed, 70 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> index 3810557374228100be7adab58cd785c72e6d4aed..aff19c86d5ff381881016eaa87fc4809da65b50e 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> @@ -11,6 +11,54 @@
>  #define K1_GPIO(x)	(x / 32) (x % 32)
>  
>  &pinctrl {
> +	gmac0_cfg: gmac0-cfg {
> +		gmac0-pins {
> +			pinmux = <K1_PADCONF(0, 1)>,	/* gmac0_rxdv */
> +				 <K1_PADCONF(1, 1)>,	/* gmac0_rx_d0 */
> +				 <K1_PADCONF(2, 1)>,	/* gmac0_rx_d1 */
> +				 <K1_PADCONF(3, 1)>,	/* gmac0_rx_clk */
> +				 <K1_PADCONF(4, 1)>,	/* gmac0_rx_d2 */
> +				 <K1_PADCONF(5, 1)>,	/* gmac0_rx_d3 */
> +				 <K1_PADCONF(6, 1)>,	/* gmac0_tx_d0 */
> +				 <K1_PADCONF(7, 1)>,	/* gmac0_tx_d1 */
> +				 <K1_PADCONF(8, 1)>,	/* gmac0_tx */
> +				 <K1_PADCONF(9, 1)>,	/* gmac0_tx_d2 */
> +				 <K1_PADCONF(10, 1)>,	/* gmac0_tx_d3 */
> +				 <K1_PADCONF(11, 1)>,	/* gmac0_tx_en */
> +				 <K1_PADCONF(12, 1)>,	/* gmac0_mdc */
> +				 <K1_PADCONF(13, 1)>,	/* gmac0_mdio */
> +				 <K1_PADCONF(14, 1)>,	/* gmac0_int_n */
> +				 <K1_PADCONF(45, 1)>;	/* gmac0_clk_ref */
> +
> +			bias-pull-up = <0>;
> +			drive-strength = <21>;
> +		};
> +	};
> +
> +	gmac1_cfg: gmac1-cfg {
> +		gmac1-pins {
> +			pinmux = <K1_PADCONF(29, 1)>,	/* gmac1_rxdv */
> +				 <K1_PADCONF(30, 1)>,	/* gmac1_rx_d0 */
> +				 <K1_PADCONF(31, 1)>,	/* gmac1_rx_d1 */
> +				 <K1_PADCONF(32, 1)>,	/* gmac1_rx_clk */
> +				 <K1_PADCONF(33, 1)>,	/* gmac1_rx_d2 */
> +				 <K1_PADCONF(34, 1)>,	/* gmac1_rx_d3 */
> +				 <K1_PADCONF(35, 1)>,	/* gmac1_tx_d0 */
> +				 <K1_PADCONF(36, 1)>,	/* gmac1_tx_d1 */
> +				 <K1_PADCONF(37, 1)>,	/* gmac1_tx */
> +				 <K1_PADCONF(38, 1)>,	/* gmac1_tx_d2 */
> +				 <K1_PADCONF(39, 1)>,	/* gmac1_tx_d3 */
> +				 <K1_PADCONF(40, 1)>,	/* gmac1_tx_en */
> +				 <K1_PADCONF(41, 1)>,	/* gmac1_mdc */
> +				 <K1_PADCONF(42, 1)>,	/* gmac1_mdio */
> +				 <K1_PADCONF(43, 1)>,	/* gmac1_int_n */
> +				 <K1_PADCONF(46, 1)>;	/* gmac1_clk_ref */
> +
> +			bias-pull-up = <0>;
> +			drive-strength = <21>;
> +		};
> +	};
> +
>  	uart0_2_cfg: uart0-2-cfg {
>  		uart0-2-pins {
>  			pinmux = <K1_PADCONF(68, 2)>,
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> index abde8bb07c95c5a745736a2dd6f0c0e0d7c696e4..7b2ac3637d6d9fa1929418cc68aa25c57850ac7f 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -805,6 +805,28 @@ network-bus {
>  			#size-cells = <2>;
>  			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
>  				     <0x0 0x80000000 0x1 0x00000000 0x0 0x80000000>;
> +
> +			eth0: ethernet@cac80000 {
> +				compatible = "spacemit,k1-emac";
> +				reg = <0x0 0xcac80000 0x0 0x420>;
> +				clocks = <&syscon_apmu CLK_EMAC0_BUS>;
> +				interrupts = <131>;
> +				mac-address = [ 00 00 00 00 00 00 ];
> +				resets = <&syscon_apmu RESET_EMAC0>;
> +				spacemit,apmu = <&syscon_apmu 0x3e4>;
> +				status = "disabled";
> +			};
> +
> +			eth1: ethernet@cac81000 {
> +				compatible = "spacemit,k1-emac";
> +				reg = <0x0 0xcac81000 0x0 0x420>;
> +				clocks = <&syscon_apmu CLK_EMAC1_BUS>;
> +				interrupts = <133>;
> +				mac-address = [ 00 00 00 00 00 00 ];
> +				resets = <&syscon_apmu RESET_EMAC1>;
> +				spacemit,apmu = <&syscon_apmu 0x3ec>;
> +				status = "disabled";
> +			};
>  		};
>  
>  		pcie-bus {
> 
> -- 
> 2.50.1
> 

-- 
Yixun Lan (dlan)

