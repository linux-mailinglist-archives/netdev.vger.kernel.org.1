Return-Path: <netdev+bounces-156493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27219A06866
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666D13A1E7A
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C91B2046A4;
	Wed,  8 Jan 2025 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVL5qOVZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32203204692;
	Wed,  8 Jan 2025 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736375695; cv=none; b=V0uCmGCVYkgA8VTiGnpjj6/No43ehnkESxHBtWbHbR6vRGv/UCiKHekFFlvYMkwmC5bO46ExFMljex85EhuUuttLGzqr+KG1O8cow+mmBwJoocXTGJtgz60LGK09rGITv+qKjbxRbPyq9qrb2OWckcutAAr21Qr8RkTcEJ+pb0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736375695; c=relaxed/simple;
	bh=bavaJ0imBpiVDIZhMho4cmKy8OAAsoDpvSMGWGk11xs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=hteHO8wTEIrV+K15XHqRBbmi+kZXguopbHmBiNYwtmmP6EwrWpoKRKptIz2GqNqy8lZrCkk9e3sKH4MBPhUn0+Npc4XbAIK3fVZdgptCJnsysep1xiboBead3YS0yl3wrLD+FsRKcw3O8TnWMBwGXRVu7onplfDyMW5KpZ/hhHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVL5qOVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909D3C4CED3;
	Wed,  8 Jan 2025 22:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736375694;
	bh=bavaJ0imBpiVDIZhMho4cmKy8OAAsoDpvSMGWGk11xs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=DVL5qOVZL39UAGjraeHcvN9+EiwMsO5uvCQZuIjivuCx/caoxptFKTqFqZA1Pnlu/
	 oOori9v01SKtm37Tb19Cl9o7owsTUFOSZPuF8lySZN2z4KYY5oAcFg0PeqZo7OjWOp
	 FF7kkNC0eydNPJwl144hT14MUHMyAQ8xzcxK3smzVgu7KiYBsJdty1vVqa9CVViK5P
	 9gAoDmSmuFzudGXdrIc7ip+xq8lP9pDOf07+bJxIj1ZoNQh524/xvpGewpLWCJDhtg
	 DtKVfm/pTNJx6Nrwud6IfixQwB31VRrfK++8NZMWEv4jHf1rGS9QTxvCXmPooB2LAu
	 HFqNdtYQFUB6g==
Date: Wed, 08 Jan 2025 16:34:53 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-aspeed@lists.ozlabs.org, davem@davemloft.net, edumazet@google.com, 
 andrew@codeconstruct.com.au, netdev@vger.kernel.org, kuba@kernel.org, 
 joel@jms.id.au, linux-arm-kernel@lists.infradead.org, 
 openipmi-developer@lists.sourceforge.net, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, pabeni@redhat.com, ratbert@faraday-tech.com, 
 eajames@linux.ibm.com, devicetree@vger.kernel.org, andrew+netdev@lunn.ch, 
 minyard@acm.org, krzk+dt@kernel.org
To: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250108163640.1374680-1-ninad@linux.ibm.com>
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
Message-Id: <173637565834.1164228.2385240280664730132.robh@kernel.org>
Subject: Re: [PATCH v3 00/10] DTS updates for system1 BMC


On Wed, 08 Jan 2025 10:36:28 -0600, Ninad Palsule wrote:
> Hello,
> 
> Please review the patch set.
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
> NINAD PALSULE (7):
>   ARM: dts: aspeed: system1: Add IPMB device
>   ARM: dts: aspeed: system1: Add GPIO line name
>   ARM: dts: aspeed: system1: Add RGMII support
>   ARM: dts: aspeed: system1: Reduce sgpio speed
>   ARM: dts: aspeed: system1: Update LED gpio name
>   ARM: dts: aspeed: system1: Remove VRs max8952
>   ARM: dts: aspeed: system1: Mark GPIO line high/low
> 
> Ninad Palsule (3):
>   dt-bindings: net: faraday,ftgmac100: Add phys mode
>   bindings: ipmi: Add binding for IPMB device intf
>   ARM: dts: aspeed: system1: Disable gpio pull down
> 
>  .../devicetree/bindings/ipmi/ipmb-dev.yaml    |  44 +++++
>  .../bindings/net/faraday,ftgmac100.yaml       |   3 +
>  .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 177 ++++++++++++------
>  3 files changed, 165 insertions(+), 59 deletions(-)
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


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-system1.dtb' for 20250108163640.1374680-1-ninad@linux.ibm.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: gpio@1e780000: 'hog-0', 'hog-1', 'hog-2', 'hog-3' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#






