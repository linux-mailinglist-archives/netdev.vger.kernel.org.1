Return-Path: <netdev+bounces-165870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF636A33948
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4F6162C1B
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E47E20ADF8;
	Thu, 13 Feb 2025 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkKfm+0z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9BC20A5CE;
	Thu, 13 Feb 2025 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433253; cv=none; b=eM9pJOQPifsdzbS+d9/0MPz8hQQZbYOxo6NEpYwlq38mznekautfx5x8KarDHpS+IG1z1vVpGLFD3JdAmqhRcwJ9MO/lKhqXn6ASl8o/KrMBs7Ci2CsvNJ6W1r2QarXqBOi/RQ311zGyCAHr/7t6u7bIUh5PP4H7xB32p9TmdAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433253; c=relaxed/simple;
	bh=56Ta27lSOpZW6WT1dfipytAfcqD14QNHO7m6Mo7UhBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkR8O0OD+T6WjWf8ryu9hFVWN7ZyTd1r4aZh5dRWB+dT+qXotBqmugEITdSX6aswjRfEjSvZsuXTsoDFvEfN/wuliG5qaF7tTgB94SPBnrGhSsi5FwPkTlcYZ14WdW49nnaAVLvdK7l92i+1pRAbiibeAp/QquO1MzF4qnJr3Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkKfm+0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B991C4CED1;
	Thu, 13 Feb 2025 07:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739433252;
	bh=56Ta27lSOpZW6WT1dfipytAfcqD14QNHO7m6Mo7UhBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GkKfm+0z1/NQtvj5DekG7tlgJXv7KvTYjV7uBiZCErsGUfI88dj0z4vErZav2EL04
	 H9SIpabXaoUXbWxWg/s9f/pJaJW/ux2aWLSHp/Ud3SkJGU5QW91S2oY052y1q57ohM
	 TFw0DXIBakxQmtCdF4c/xrs3SGT0kHWTIl5NT1CaV9ycuzmTyO+WZVuHFD6BDLDHF7
	 DWnCV9GdRsg13axmldqBa1yZ5sx0bTnDw5syFgZYGB4/k71TZChpkQc2ieAJfaBfBZ
	 T5APTSqFiLrYNV4UFPgdPGmN8utVYIWp++nRPuYHcmeH1iTwpZn/E/YOFXWguOcKUj
	 RGy9TQHVMsG2Q==
Date: Thu, 13 Feb 2025 08:54:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Swathi K S <swathi.ks@samsung.com>
Cc: krzk+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, 
	conor+dt@kernel.org, richardcochran@gmail.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: net: Add FSD EQoS device tree
 bindings
Message-ID: <20250213-adorable-arboreal-degu-6bdcb8@krzk-bin>
References: <20250213044624.37334-1-swathi.ks@samsung.com>
 <CGME20250213044955epcas5p110d1e582c8ee02579ead73f9686819ff@epcas5p1.samsung.com>
 <20250213044624.37334-2-swathi.ks@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213044624.37334-2-swathi.ks@samsung.com>

On Thu, Feb 13, 2025 at 10:16:23AM +0530, Swathi K S wrote:
> +  clock-names:
> +    minItems: 5
> +    maxItems: 10
> +    contains:
> +      enum:
> +        - ptp_ref
> +        - master_bus
> +        - slave_bus
> +        - tx
> +        - rx
> +        - master2_bus
> +        - slave2_bus
> +        - eqos_rxclk_mux
> +        - eqos_phyrxclk
> +        - dout_peric_rgmii_clk

This does not match the previous entry. It should be strictly ordered
with minItems: 5.


> +
> +  iommus:
> +    maxItems: 1
> +
> +  phy-mode:
> +    enum:
> +      - rgmii-id
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - iommus
> +  - phy-mode
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/fsd-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        ethernet1: ethernet@14300000 {
> +            compatible = "tesla,fsd-ethqos";
> +            reg = <0x0 0x14300000 0x0 0x10000>;
> +            interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "macirq";
> +            clocks = <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_CLK_PTP_REF_I>,
> +                     <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_ACLK_I>,
> +                     <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_HCLK_I>,
> +                     <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_RGMII_CLK_I>,
> +                     <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_CLK_RX_I>,
> +                     <&clock_peric PERIC_BUS_D_PERIC_IPCLKPORT_EQOSCLK>,
> +                     <&clock_peric PERIC_BUS_P_PERIC_IPCLKPORT_EQOSCLK>,
> +                     <&clock_peric PERIC_EQOS_PHYRXCLK_MUX>,
> +                     <&clock_peric PERIC_EQOS_PHYRXCLK>,
> +                     <&clock_peric PERIC_DOUT_RGMII_CLK>;
> +            clock-names = "ptp_ref", "master_bus", "slave_bus","tx",
> +                          "rx", "master2_bus", "slave2_bus", "eqos_rxclk_mux",
> +                          "eqos_phyrxclk","dout_peric_rgmii_clk";
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&eth1_tx_clk>, <&eth1_tx_data>, <&eth1_tx_ctrl>,
> +                        <&eth1_phy_intr>, <&eth1_rx_clk>, <&eth1_rx_data>,
> +                        <&eth1_rx_ctrl>, <&eth1_mdio>;
> +            iommus = <&smmu_peric 0x0 0x1>;
> +            phy-mode = "rgmii-id";
> +       };

Misaligned/misindented.

Best regards,
Krzysztof


