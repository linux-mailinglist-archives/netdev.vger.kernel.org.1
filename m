Return-Path: <netdev+bounces-158334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 167D0A116B5
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E4F16179C
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513DC38FAD;
	Wed, 15 Jan 2025 01:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uas6dGNi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FA635976;
	Wed, 15 Jan 2025 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736905202; cv=none; b=N/w1tPhq0zS4xCyCdI95dMvv21zfGeXF8Rsv1PVlmYPQiPGvrqU5JQR+qH2lQOmT3LE6YkYCF7hUDz7nB3tDAEnFEZNcaIyB3QX6ZCP2OqmwSdgh0kaSCtQ9dNW2FPCufSa2UV6bUWlzArFg/uXVABxRn019sqykwUExiAxTdCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736905202; c=relaxed/simple;
	bh=/K1CIcKnQKuZL6lCyuCE9f8Owon49DpZzh2xTlkMCuA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Q5UwBA1sTsRsqc02DnISMRILKXYsyKUb7yzBjLUK4YDwR058ImTXJ4tRQ+tHD9vQGv2bX5N+0G21q0myMg7j+R7vpMboZ3PxxMnMDJ3oePRvwUHxcKF0I6uQuzTtWNMNef9VJBEXJqR3NLTxIsnvrQfrwJxen0FIfFIhOGt0UK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uas6dGNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579DBC4CEDD;
	Wed, 15 Jan 2025 01:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736905201;
	bh=/K1CIcKnQKuZL6lCyuCE9f8Owon49DpZzh2xTlkMCuA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=uas6dGNi0YZD+pkEZQSyV5hHDDz3vVmnXl3rRD+2uIf0WWRr7QIL0bCycjYuzsDnW
	 ao+nEPKm0G2Q2EaRzD+vQpSTgjZDq1mgr/6qqqOKzdL96ybqJEVJP2ALfd6li4Ouno
	 drpA3YPw6AeqakCkaASQtQIxz5Bc2OUge0aHJyNCb4p+kp5GZP0wgRikFsOOkzY4Nu
	 OvNn1sznveAgFrHU4JfK8nZ7DOqZ9dhossNMrqD2flNIaLbHtF8xHoHCjU8TjoXSRT
	 8J07eGyeHu+qLnL55nnfx+U4kOl99mqurrnqew4Nq8DoxTl6QP5dxAcOG93NfHeLn0
	 1iWdsP6534qqw==
Date: Tue, 14 Jan 2025 19:40:00 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
 pabeni@redhat.com, krzk+dt@kernel.org, kuba@kernel.org, joel@jms.id.au, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 davem@davemloft.net, eajames@linux.ibm.com, andrew@codeconstruct.com.au, 
 andrew+netdev@lunn.ch, minyard@acm.org, edumazet@google.com, 
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org
To: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250114220147.757075-1-ninad@linux.ibm.com>
References: <20250114220147.757075-1-ninad@linux.ibm.com>
Message-Id: <173690506198.2128017.15705512689029125898.robh@kernel.org>
Subject: Re: [PATCH v5 00/10] DTS updates for system1 BMC


On Tue, 14 Jan 2025 16:01:34 -0600, Ninad Palsule wrote:
> Hello,
> 
> Please review the patch set version 5.
> 
> V5:
> ---
>   - Improved IPBM device documentation.
>   - Added the hog parsing in ast2400-gpio
> 
> V4:
> ---
>   - Removed "Add RGMII support" patch as it needs some work from the
>     driver side.
>   - Improved IPBM device documentation.
>   - There is a new warning in CHECK_DTBS which are false positive so
>     ignored them.
>     arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: gpio@1e780000: 'hog-0', 'hog-1', 'hog-2', 'hog-3' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> V3:
> ---
>   - Fixed dt_binding_check warnings in ipmb-dev.yaml
>   - Updated title and description in ipmb-dev.yaml file.
>   - Updated i2c-protocol description in ipmb-dev.yaml file.
> 
> V2:
> ---
>   Fixed CHECK_DTBS errors by
>     - Using generic node names
>     - Documenting phy-mode rgmii-rxid in ftgmac100.yaml
>     - Adding binding documentation for IPMB device interface
> 
> NINAD PALSULE (6):
>   ARM: dts: aspeed: system1: Add IPMB device
>   ARM: dts: aspeed: system1: Add GPIO line name
>   ARM: dts: aspeed: system1: Reduce sgpio speed
>   ARM: dts: aspeed: system1: Update LED gpio name
>   ARM: dts: aspeed: system1: Remove VRs max8952
>   ARM: dts: aspeed: system1: Mark GPIO line high/low
> 
> Ninad Palsule (4):
>   dt-bindings: net: faraday,ftgmac100: Add phys mode
>   bindings: ipmi: Add binding for IPMB device intf
>   dt-bindings: gpio: ast2400-gpio: Add hogs parsing
>   ARM: dts: aspeed: system1: Disable gpio pull down
> 
>  .../bindings/gpio/aspeed,ast2400-gpio.yaml    |   6 +
>  .../devicetree/bindings/ipmi/ipmb-dev.yaml    |  55 +++++++
>  .../bindings/net/faraday,ftgmac100.yaml       |   3 +
>  .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 139 +++++++++++-------
>  4 files changed, 149 insertions(+), 54 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> 
> --
> 2.43.0
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


New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250114220147.757075-1-ninad@linux.ibm.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dtb: gpio@1e780000: 'pin_func_mode0', 'pin_func_mode1', 'pin_func_mode2', 'pin_gpio_a0', 'pin_gpio_a1', 'pin_gpio_b1', 'pin_gpio_b2', 'pin_gpio_b7', 'pin_gpio_d1', 'pin_gpio_f1', 'pin_gpio_f4', 'pin_gpio_f5', 'pin_gpio_f7', 'pin_gpio_g3', 'pin_gpio_g4', 'pin_gpio_g5', 'pin_gpio_h0', 'pin_gpio_h1', 'pin_gpio_h2', 'pin_gpio_h7' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dtb: gpio@1e780000: 'doom-guardrail' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dtb: gpio@1e780000: 'nic_func_mode0', 'nic_func_mode1', 'seq_cont' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dtb: gpio@1e780000: 'pin_gpio_aa6', 'pin_gpio_aa7', 'pin_gpio_ab0', 'pin_gpio_b0', 'pin_gpio_b5', 'pin_gpio_h5', 'pin_gpio_z2' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-bytedance-g220a.dtb: gpio@1e780000: 'pin_gpio_b6', 'pin_gpio_i3' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: gpio@1e780000: 'usb_power' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dtb: gpio@1e780000: 'bmc-ready' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: gpio@1e780000: 'i2c3_mux_oe_n', 'usb_power' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dtb: gpio@1e780000: 'bmc-ready' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: gpio@1e780000: 'i2c3_mux_oe_n', 'usb_power' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: gpio@1e780000: 'i2c3_mux_oe_n', 'usb_power' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: gpio@1e780000: 'usb_power' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dtb: gpio@1e780000: 'func_mode0', 'func_mode1', 'func_mode2', 'ncsi_cfg', 'seq_cont' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dtb: gpio@1e780000: 'pin_gpio_a1', 'pin_gpio_a3', 'pin_gpio_aa0', 'pin_gpio_aa4', 'pin_gpio_ab3', 'pin_gpio_ac6', 'pin_gpio_b5', 'pin_gpio_b7', 'pin_gpio_e0', 'pin_gpio_e2', 'pin_gpio_e5', 'pin_gpio_e6', 'pin_gpio_f0', 'pin_gpio_f1', 'pin_gpio_f2', 'pin_gpio_f3', 'pin_gpio_f4', 'pin_gpio_f6', 'pin_gpio_g7', 'pin_gpio_h6', 'pin_gpio_i3', 'pin_gpio_j1', 'pin_gpio_j2', 'pin_gpio_j3', 'pin_gpio_l0', 'pin_gpio_l1', 'pin_gpio_l4', 'pin_gpio_l5', 'pin_gpio_r6', 'pin_gpio_r7', 'pin_gpio_s1', 'pin_gpio_s2', 'pin_gpio_s6', 'pin_gpio_z3' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr630.dtb: gpio@1e780000: 'pin_gpio_aa0', 'pin_gpio_aa5', 'pin_gpio_b5', 'pin_gpio_f0', 'pin_gpio_f3', 'pin_gpio_f4', 'pin_gpio_f5', 'pin_gpio_g4', 'pin_gpio_g7', 'pin_gpio_h2', 'pin_gpio_h3', 'pin_gpio_i3', 'pin_gpio_j2', 'pin_gpio_j3', 'pin_gpio_s2', 'pin_gpio_s4', 'pin_gpio_s6', 'pin_gpio_y0', 'pin_gpio_y1', 'pin_gpio_z0', 'pin_gpio_z2', 'pin_gpio_z3', 'pin_gpio_z7' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dtb: gpio@1e780000: 'line_bmc_i2c2_sw_rst_n', 'line_bmc_i2c5_sw_rst_n', 'line_iso_u146_en', 'ncsi_mux_en_n' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dtb: gpio@1e780000: 'pin_gpio_c7', 'pin_gpio_d1' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#






