Return-Path: <netdev+bounces-196145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9F5AD3B72
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A661BA0BD5
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C00E2367CF;
	Tue, 10 Jun 2025 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyEVtH4D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B28221FB2;
	Tue, 10 Jun 2025 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566360; cv=none; b=TCIxxzaESYemZY2GFtK2PrerzOvLTABCZoWoANcji6ahnN9lQEVXpHoBny17TUNYL6CCRcfl2G+v3zI/DYs9GeANK0Yy4+8yBMwdc/fv1UBjgalB6I4z42omK+E84+UwVLoB+smiWKhquu323azS7RvyHXSST/3fYF8P14TKC7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566360; c=relaxed/simple;
	bh=NCUWuCdR+i+AqSI5AiUCl5RBbmPmX8XOLT9C8aAZ8ZA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=TBPvsd0TOWYT2qNSWokoKL+/yQOFvkni6S5jAL16/G3jIUupksj2iSA8uOlggUTqav9/oxqZdfMfdvXDLqxIIhLFbgrX5droOsYKSZKQjOe/l514oqGWennuHkmngdBoZZaextnqw/ShpTdZLoFsXv61ExEfRbWRhLinTOOlyHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyEVtH4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FEEC4CEED;
	Tue, 10 Jun 2025 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749566359;
	bh=NCUWuCdR+i+AqSI5AiUCl5RBbmPmX8XOLT9C8aAZ8ZA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=NyEVtH4DssdpsNDhUQbAY09lANFHt9M+dNMBF0iY0fUX3nQUwUChxWjC1ExiVKCaA
	 Ya3lIM8hHCoPL5GhDVLsEYs4+A8Vb1c+B9ljAY5XdM+pu3meNQ5wTboMQnOVVmtYT3
	 ApilqsoWXvyu4cRsB63Vjwq85ttoT69hWtChnPwefIYoCSB4w7Wxv6u3GNX6U4wVsJ
	 PPIvdid66h2sZlFsXhJJ50ZRqToXddWb2P6uCAdnyFzdU1MnVBevG2VwfmjUqu+zdQ
	 eKhuY4hBX4Hygv6igLZoYToTtPK4OnPAz1ZDMsRLgOE4Ougn7LFpxy29NnykeDHXVl
	 zIp6EFR9I/5tQ==
Date: Tue, 10 Jun 2025 09:39:18 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, sboyd@kernel.org, 
 netdev@vger.kernel.org, joel@jms.id.au, p.zabel@pengutronix.de, 
 edumazet@google.com, pabeni@redhat.com, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, krzk+dt@kernel.org, linux-clk@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org, 
 davem@davemloft.net, BMC-SW@aspeedtech.com, 
 linux-arm-kernel@lists.infradead.org, andrew@codeconstruct.com.au, 
 mturquette@baylibre.com
To: Jacky Chou <jacky_chou@aspeedtech.com>
In-Reply-To: <20250610012406.3703769-1-jacky_chou@aspeedtech.com>
References: <20250610012406.3703769-1-jacky_chou@aspeedtech.com>
Message-Id: <174956612600.1562300.48579876569491246.robh@kernel.org>
Subject: Re: [net-next v2 0/4] net: ftgmac100: Add SoC reset support for
 RMII mode


On Tue, 10 Jun 2025 09:24:02 +0800, Jacky Chou wrote:
> This patch series adds support for an optional reset line to the
> ftgmac100 ethernet controller, as used on Aspeed SoCs. On these SoCs,
> the internal MAC reset is not sufficient to reset the RMII interface.
> By providing a SoC-level reset via the device tree "resets" property,
> the driver can properly reset both the MAC and RMII logic, ensuring
> correct operation in RMII mode.
> 
> The series includes:
> - Device tree binding update to document the new "resets" property.
> - Addition of MAC1 and MAC2 reset definitions for AST2600.
> - Device tree changes for AST2600 to use the new reset properties.
> - Driver changes to assert/deassert the reset line as needed.
> 
> This improves reliability and initialization of the MAC in RMII mode
> on Aspeed platforms.
> 
> Jacky Chou (4):
>   dt-bindings: net: ftgmac100: Add resets property
>   dt-bindings: clock: ast2600: Add reset definitions for MAC1 and MAC2
>   ARM: dts: aspeed-g6: Add resets property for MAC controllers
>   net: ftgmac100: Add optional reset control for RMII mode on Aspeed
>     SoCs
> 
>  .../bindings/net/faraday,ftgmac100.yaml       | 19 ++++++++++++++
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |  4 +++
>  drivers/net/ethernet/faraday/ftgmac100.c      | 26 +++++++++++++++++++
>  include/dt-bindings/clock/ast2600-clock.h     |  2 ++
>  4 files changed, 51 insertions(+)
> 
> ---
> v2:
>   - Added restriction on resets property in faraday,ftgmac100.yaml.
> ---
> 
> --
> 2.34.1
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


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/v6.15-rc6-1244-g3f1716ee0f6c (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250610012406.3703769-1-jacky_chou@aspeedtech.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-microsoft-olympus.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-microsoft-olympus.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-ast2500-evb.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-ast2500-evb.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-microsoft-olympus.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-microsoft-olympus.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-ast2500-evb.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-ast2500-evb.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minipack.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minipack.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minipack.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minipack.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dtb: kcs@114 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-sx20.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-sx20.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-sx20.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-sx20.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-rx20.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-rx20.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-rx20.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-rx20.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cmm.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cmm.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cmm.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cmm.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-bytedance-g220a.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-bytedance-g220a.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-bytedance-g220a.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-bytedance-g220a.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-n110.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-n110.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-n110.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-n110.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-vesnin.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-vesnin.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-vesnin.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-vesnin.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-tyan-s8036.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-tyan-s8036.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-tyan-s8036.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-tyan-s8036.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-tyan-s8036.dtb: /ahb/apb/bus@1e78a000/i2c@100/power-supply@58: failed to match any schema with compatible: ['pmbus']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yamp.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yamp.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yamp.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yamp.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-ethanolx.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-ethanolx.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-ethanolx.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-ethanolx.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-on5263m5.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-on5263m5.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-on5263m5.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-on5263m5.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: /ahb/apb/syscon@1e6e2000/interrupt-controller@570: failed to match any schema with compatible: ['aspeed,ast2600-scu-ic1']
arch/arm/boot/dts/aspeed/aspeed-bmc-intel-s2600wf.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-intel-s2600wf.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-intel-s2600wf.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-intel-s2600wf.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge40.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge40.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge40.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge40.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr630.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr630.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr630.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr630.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-q71l.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-q71l.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-q71l.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-q71l.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dtb: pin_gpio_f3: $nodename:0: 'pin_gpio_f3' does not match '-hog(-[0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-hog.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-tyan-s7106.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-tyan-s7106.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-tyan-s7106.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-tyan-s7106.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-daytonax.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-daytonax.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-daytonax.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-daytonax.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge100.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge100.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge100.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge100.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-portwell-neptune.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-portwell-neptune.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-portwell-neptune.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-portwell-neptune.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2400-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-nf5280m6.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-nf5280m6.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-nf5280m6.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-nf5280m6.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/ethernet@1e670000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/ethernet@1e690000: failed to match any schema with compatible: ['aspeed,ast2600-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-tiogapass.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-tiogapass.dtb: /ahb/ethernet@1e660000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-tiogapass.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-tiogapass.dtb: /ahb/ethernet@1e680000: failed to match any schema with compatible: ['aspeed,ast2500-mac', 'faraday,ftgmac100']






