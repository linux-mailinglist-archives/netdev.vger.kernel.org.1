Return-Path: <netdev+bounces-140508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EDF9B6A9B
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A20CB20E1A
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC8822CC41;
	Wed, 30 Oct 2024 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPnvIuuT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1EF22ADFD;
	Wed, 30 Oct 2024 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307891; cv=none; b=kdFoMWMWXUXMgZQMp1vAytyuUk8tLeAzzYed6lAl5bH/kAFQeGM+7k8rGa02pn5TMCuSTymeiJVq5iOtuCrS5wDscj6l4zuzCvjlEFoYolQKsWCTjxG/AUjeHMN9kWvodxOJ0d3+xu05P9EBi2Cqk4HkRwdKXEZ3mjJzaHhEWTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307891; c=relaxed/simple;
	bh=F9Pr/Oo+xoM6rBNWj4TUXotKSeXlLKjDZ0TcVUnAkZk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=I8/cSLdYqcjl+4JlxQi/mSglEOuYIfSF3UG+o3a2M4tO+AnwDXG1USCNaRmD6TyfQxtIigTE/xECMAdSPq8QH1cKEldsvZfmLYnrhkJI8NNGDu4WBi/TxoYqGOB2/dTHp/X52RpGfvOjtJMT8jsCQxqHmrLrRrA+I84R64am3mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPnvIuuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2707BC4CED2;
	Wed, 30 Oct 2024 17:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730307891;
	bh=F9Pr/Oo+xoM6rBNWj4TUXotKSeXlLKjDZ0TcVUnAkZk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QPnvIuuTQIPej4r3eeYpF52cq2e7H1rX9pCQNfZl+LOKTAqY2dqepCh0c22gWfmdf
	 8aDUkUZEwVMevTt2G2hab/ftEIBTN2XHMHprfXXgkQIEIrpy0DPUKNJK16QKNDdRCt
	 Zm0i0zCW4jCPBF8fwSdYFGDmS6xLPXLlzVhvsSdCcp0TpbM8C4X+pdAPIGKWI3mAff
	 RXdam7q2IsjC/YnOItE7WJJar9/4GRhdptKsqi0NxU8IcPVjkDwyL/7JoHIesy6lnm
	 w8nXiNTJ8QHhAFlMRhiW2s6ZNPrVPHLTJwcf5TE64yTp0rUVCEPDKMqFuQd6O742kR
	 OFEjZNKihxaiA==
Date: Wed, 30 Oct 2024 12:04:50 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, kernel@pengutronix.de, 
 devicetree@vger.kernel.org
In-Reply-To: <20241030-v6-12-topic-socfpga-agilex5-v1-0-b2b67780e60e@pengutronix.de>
References: <20241030-v6-12-topic-socfpga-agilex5-v1-0-b2b67780e60e@pengutronix.de>
Message-Id: <173030775265.1269185.10225063190371444924.robh@kernel.org>
Subject: Re: [PATCH 0/4] ARM64: dts: intel: agilex5: add nodes and new
 board


On Wed, 30 Oct 2024 13:10:11 +0100, Steffen Trumtrar wrote:
> This series adds the gpio0 and gmac nodes to the socfpga_agilex5.dtsi.
> 
> An initial devicetree for a new board (Arrow AXE5-Eagle) is also added.
> Currently only QSPI and network are functional as all other hardware
> currently lacks mainline support.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
> Steffen Trumtrar (4):
>       arm64: dts: agilex5: add gpio0
>       arm64: dts: agilex5: add gmac nodes
>       dt-bindings: intel: add agilex5-based Arrow AXE5-Eagle
>       arm64: dts: agilex5: initial support for Arrow AXE5-Eagle
> 
>  .../devicetree/bindings/arm/intel,socfpga.yaml     |   1 +
>  arch/arm64/boot/dts/intel/Makefile                 |   1 +
>  arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi     | 341 +++++++++++++++++++++
>  .../boot/dts/intel/socfpga_agilex5_axe5_eagle.dts  | 146 +++++++++
>  4 files changed, 489 insertions(+)
> ---
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> change-id: 20241030-v6-12-topic-socfpga-agilex5-90fd3d8f980c
> 
> Best regards,
> --
> Steffen Trumtrar <s.trumtrar@pengutronix.de>
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


New warnings running 'make CHECK_DTBS=y intel/socfpga_agilex5_axe5_eagle.dtb' for 20241030-v6-12-topic-socfpga-agilex5-v1-0-b2b67780e60e@pengutronix.de:

arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
	'arrow,socfpga-agilex5-axe5-eagle' is not one of ['intel,n5x-socdk', 'intel,socfpga-agilex-n6000', 'intel,socfpga-agilex-socdk']
	'intel,socfpga-agilex5' was expected
	from schema $id: http://devicetree.org/schemas/arm/intel,socfpga.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: ethernet@10810000: reset-names: 'oneOf' conditional failed, one must be fixed:
	['stmmaceth', 'stmmaceth-ocp'] is too long
	'ahb' was expected
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: ethernet@10810000: tx-queues-config:queue6: 'snps,tbs-enable' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: ethernet@10810000: tx-queues-config:queue7: 'snps,tbs-enable' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: /soc@0/ethernet@10810000: failed to match any schema with compatible: ['altr,socfpga-stmmac-a10-s10', 'snps,dwxgmac-2.10', 'snps,dwxgmac']
arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: ethernet@10820000: reset-names: 'oneOf' conditional failed, one must be fixed:
	['stmmaceth', 'stmmaceth-ocp'] is too long
	'ahb' was expected
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: ethernet@10820000: tx-queues-config:queue6: 'snps,tbs-enable' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: ethernet@10820000: tx-queues-config:queue7: 'snps,tbs-enable' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: /soc@0/ethernet@10820000: failed to match any schema with compatible: ['altr,socfpga-stmmac-a10-s10', 'snps,dwxgmac-2.10', 'snps,dwxgmac']
arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: ethernet@10830000: reset-names: 'oneOf' conditional failed, one must be fixed:
	['stmmaceth', 'stmmaceth-ocp'] is too long
	'ahb' was expected
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: ethernet@10830000: tx-queues-config:queue6: 'snps,tbs-enable' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: ethernet@10830000: tx-queues-config:queue7: 'snps,tbs-enable' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: /soc@0/ethernet@10830000: failed to match any schema with compatible: ['altr,socfpga-stmmac-a10-s10', 'snps,dwxgmac-2.10', 'snps,dwxgmac']
arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: tca9544@70: $nodename:0: 'tca9544@70' does not match '^(i2c-?)?mux'
	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: tca9544@70: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: /soc@0/nand-controller@10b80000: failed to match any schema with compatible: ['cdns,hp-nfc']
arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: /soc@0/sysmgr@10d12000: failed to match any schema with compatible: ['altr,sys-mgr-s10', 'altr,sys-mgr']
arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: /soc@0/sysmgr@10d12000: failed to match any schema with compatible: ['altr,sys-mgr-s10', 'altr,sys-mgr']
arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: flash@0: Unevaluated properties are not allowed ('cdns,block-size', 'cdns,page-size' were unexpected)
	from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: leds: 'hps0', 'hps1' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dtb: gpio-keys: 'hps_pb0', 'hps_pb1', 'hps_sw0', 'hps_sw1' do not match any of the regexes: '^(button|event|key|switch|(button|event|key|switch)-[a-z0-9-]+|[a-z0-9-]+-(button|event|key|switch))$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/input/gpio-keys.yaml#






