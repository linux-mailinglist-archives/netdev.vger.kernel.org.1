Return-Path: <netdev+bounces-253531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LUfMu6Td2n0iwEAu9opvQ
	(envelope-from <netdev+bounces-253531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:18:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4098A96C
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70EFE300B449
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 16:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C32F3009D2;
	Mon, 26 Jan 2026 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W1YU4JX6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFDC29E0E7;
	Mon, 26 Jan 2026 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444288; cv=none; b=oacaY8ExGLdKuvS8oag6SxnkkOfBJVq3V9y+VlF7AoGZ5TceGicv9qEU/vDIGUmF8sCtAY/YzcgNkFIeek5mdEEPxB1pGZX6mgtaWzTzas10WGWe4rmkaRQBUGWSF0mez4mKvTi+NeDGT3livaLMpv821bGKpkTNKUPkrKs4ES8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444288; c=relaxed/simple;
	bh=hnqy/N5+pWpjE1SM8iewLUfj/+2iBeZ2LQx4ikPe6sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7MPImd34mtdHIUAEpVAk25cuogX5Xio89Jnr7F0l0xiu2xOjhvLIeJ6ffFL0LG7kQ7qHu/yQmTjuvE4I6xBWr4XZi3CL6Ebmr3f3jdp9pRBgX1lBQCr3nn8moOZdFwDL9d4AweVq04dTK09UcmnBBo1PNk9oBpnZHo/J8Dc5m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W1YU4JX6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9GmR4U/6sjLZ6b4mP0qhVrXUe9sv8qZlxLz11xmTSMI=; b=W1YU4JX6USsiOCe6sebt6DfqKV
	35oiUK67jY8GYTFhaQHQnJr7jygPAsCtrIu5rnCvug/xXLZroQ0DSeAfCpfjfTVkrq/K7Xoeo+q0Q
	L0dqUFWsLX1sJC4HMsEqu1rVFuXOAvC2s3nooFLuqXT8ljvjzLMl5zveu3qUBIJ2bTDA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vkPHf-004oR8-T2; Mon, 26 Jan 2026 17:17:47 +0100
Date: Mon, 26 Jan 2026 17:17:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joey Lu <a0987203069@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, ychuang3@nuvoton.com, schung@nuvoton.com,
	yclu4@nuvoton.com, peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v9 2/3] arm64: dts: nuvoton: Add Ethernet nodes
Message-ID: <ea3a1f85-0f27-498c-b03b-110456a751da@lunn.ch>
References: <20260126102257.2619862-1-a0987203069@gmail.com>
 <20260126102257.2619862-3-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126102257.2619862-3-a0987203069@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253531-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,synopsys.com,nuvoton.com,st.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,st-md-mailman.stormreply.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[2.100.46.192:email,2.111.199.128:email,0.0.0.1:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.0:email,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 2A4098A96C
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 06:22:56PM +0800, Joey Lu wrote:
> Add GMAC nodes for our MA35D1 development boards:
> two RGMII interfaces for SOM board, and one RGMII
> and one RMII interface for IoT board.
> 
> Signed-off-by: Joey Lu <a0987203069@gmail.com>
> ---
>  .../boot/dts/nuvoton/ma35d1-iot-512m.dts      | 33 +++++++++++++++++++
>  .../boot/dts/nuvoton/ma35d1-som-256m.dts      | 32 ++++++++++++++++++
>  arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 32 ++++++++++++++++++

Did you answer my question about what these represent?

I _think_ your .dts{i} files are all messed up and need
re-architecturing.

arch/arm64/boot/dts/nuvoton/ma35d1.dtsi should represent the SoC.

There should be a .dtsi file which represents everything on the SOM.
This includes the SoC .dtsi file.

There should be a .dts file for the carrier board. It should include
the SOM .dtsi file.

You said one of the boards does not use the SOM, so it can directly
import the SoC .dtsi file.

>  3 files changed, 97 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
> index 9482bec1aa57..ee32cedf3d9b 100644
> --- a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
> @@ -18,6 +18,8 @@ aliases {
>  		serial12 = &uart12;
>  		serial13 = &uart13;
>  		serial14 = &uart14;
> +		ethernet0 = &gmac0;
> +		ethernet1 = &gmac1;
>  	};
>  
>  	chosen {
> @@ -126,3 +128,34 @@ &uart14 {
>  	pinctrl-0 = <&pinctrl_uart14>;
>  	status = "okay";
>  };
> +
> +&gmac0 {
> +	phy-handle = <&eth_phy0>;

This is a .dts file, so represents a board. You said the PHYs are on
the board, not the SOM. So this is correct.


> +	status = "okay";
> +
> +	mdio0: mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;

The MDIO bus is a property of the SoC. It always exists, even if it is
not used. So the mdio node should be in the SoC .dtsi file.

> +		eth_phy0: ethernet-phy@0 {
> +			reg = <0>;
> +		};

The PHY is a property of the board, so should be in the board .dts
file. 

> +	};
> +};
> +
> +&gmac1 {
> +	phy-mode = "rmii";
> +	phy-handle = <&eth_phy1>;
> +	status = "okay";

Correct.

> +
> +	mdio1: mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;

Wrong.

> +
> +		eth_phy1: ethernet-phy@1 {
> +			reg = <1>;
> +		};

Correct.

> +	};
> +};
> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
> index f6f20a17e501..b1b3e45280d5 100644
> --- a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
> @@ -18,6 +18,8 @@ aliases {
>  		serial12 = &uart12;
>  		serial14 = &uart14;
>  		serial16 = &uart16;
> +		ethernet0 = &gmac0;
> +		ethernet1 = &gmac1;
>  	};
>  
>  	chosen {
> @@ -129,3 +131,33 @@ &uart16 {
>  	pinctrl-0 = <&pinctrl_uart16>;
>  	status = "okay";
>  };
> +
> +&gmac0 {
> +	phy-handle = <&eth_phy0>;
> +	status = "okay";
> +
> +	mdio0: mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		eth_phy0: ethernet-phy@0 {
> +			reg = <0>;
> +		};
> +	};
> +};
> +
> +&gmac1 {
> +	phy-handle = <&eth_phy1>;
> +	status = "okay";
> +
> +	mdio1: mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		eth_phy1: ethernet-phy@1 {
> +			reg = <1>;
> +		};
> +	};
> +};

Same problem as above.

> --- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi

This represents the SoC.

> @@ -379,5 +379,37 @@ uart16: serial@40880000 {
>  			clocks = <&clk UART16_GATE>;
>  			status = "disabled";
>  		};
> +
> +		gmac0: ethernet@40120000 {
> +			compatible = "nuvoton,ma35d1-dwmac";
> +			reg = <0x0 0x40120000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			clocks = <&clk EMAC0_GATE>, <&clk EPLL_DIV8>;
> +			clock-names = "stmmaceth", "ptp_ref";
> +
> +			nuvoton,sys = <&sys 0>;
> +			resets = <&sys MA35D1_RESET_GMAC0>;
> +			reset-names = "stmmaceth";
> +
> +			phy-mode = "rgmii-id";

PHY mode is a property of the board. The board might have extra long
clock lines, so needs 'rgmii'. The board might use MII?

Please think about the hierarchy.  SoC -> SoM -> board. Put the
properties at the correct level.

    Andrew

---
pw-bot: cr

