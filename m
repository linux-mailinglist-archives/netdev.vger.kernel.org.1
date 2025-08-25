Return-Path: <netdev+bounces-216709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FEAB34FB7
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6ED3B06BF
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 23:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C67289E36;
	Mon, 25 Aug 2025 23:33:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778AD72633;
	Mon, 25 Aug 2025 23:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756164800; cv=none; b=QMbbUdEkTAR4fTxDAVgRD1KA7nShEoAxk/b2n01AhzYMXgqcF07xna28bZoLyG075itiiZPTS0oQe5llj+J37JBtnX1ULd6iHZrHK+aOE9hEXUKKoDYHi8//+CyjhM0iEfoCBoQrbPAYIQYzahuRMavuv/cmHytB4F1KeUMSvNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756164800; c=relaxed/simple;
	bh=foO4lvUZTKeYu2PdsfhUHzSllm8vkz7yqAZEILC6Hjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyGcOkxp2CSE5S8S171Dp569S4u7L/ssUSQqSLeJCxX4Y738sDaEiLGimxszGTFfzafDaerK/deu2VUDg3lL02HcBvGMHU6zIvz5nUXAxHyiswrkkPlowxnRPe58iT+KFClKdtHNtQkut5hGgMnw5ZjQwPz0ou+PhNyiu5Jep9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 3C155340FEA;
	Mon, 25 Aug 2025 23:33:16 +0000 (UTC)
Date: Tue, 26 Aug 2025 07:33:12 +0800
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
	linux-kernel@vger.kernel.org,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Subject: Re: [PATCH net-next v6 4/5] riscv: dts: spacemit: Add Ethernet
 support for BPI-F3
Message-ID: <20250825233312-GYB1101079@gentoo.org>
References: <20250820-net-k1-emac-v6-0-c1e28f2b8be5@iscas.ac.cn>
 <20250820-net-k1-emac-v6-4-c1e28f2b8be5@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-net-k1-emac-v6-4-c1e28f2b8be5@iscas.ac.cn>

Hi Vivian,

On 14:47 Wed 20 Aug     , Vivian Wang wrote:
> Banana Pi BPI-F3 uses an RGMII PHY for each port and uses GPIO for PHY
> reset.
> 
> Tested-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

Reviewed-by: Yixun Lan <dlan@gentoo.org>
> ---
>  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 46 +++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> index fe22c747c5012fe56d42ac8a7efdbbdb694f31b6..15fa4a5ebd043f3fbb115d37e5a980c9b773a228 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> @@ -40,6 +40,52 @@ &emmc {
>  	status = "okay";
>  };
>  
> +&eth0 {
> +	phy-handle = <&rgmii0>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac0_cfg>;
> +	rx-internal-delay-ps = <0>;
> +	tx-internal-delay-ps = <0>;
> +	status = "okay";
> +
> +	mdio-bus {
> +		#address-cells = <0x1>;
> +		#size-cells = <0x0>;
> +
> +		reset-gpios = <&gpio K1_GPIO(110) GPIO_ACTIVE_LOW>;
> +		reset-delay-us = <10000>;
> +		reset-post-delay-us = <100000>;
> +
> +		rgmii0: phy@1 {
> +			reg = <0x1>;
> +		};
> +	};
> +};
> +
> +&eth1 {
> +	phy-handle = <&rgmii1>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac1_cfg>;
> +	rx-internal-delay-ps = <0>;
> +	tx-internal-delay-ps = <250>;
> +	status = "okay";
> +
> +	mdio-bus {
> +		#address-cells = <0x1>;
> +		#size-cells = <0x0>;
> +
> +		reset-gpios = <&gpio K1_GPIO(115) GPIO_ACTIVE_LOW>;
> +		reset-delay-us = <10000>;
> +		reset-post-delay-us = <100000>;
> +
> +		rgmii1: phy@1 {
> +			reg = <0x1>;
> +		};
> +	};
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_2_cfg>;
> 
> -- 
> 2.50.1
> 

-- 
Yixun Lan (dlan)

