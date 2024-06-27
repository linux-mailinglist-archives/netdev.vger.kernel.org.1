Return-Path: <netdev+bounces-107391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF2791AC47
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B73D9B21328
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22141991C3;
	Thu, 27 Jun 2024 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfgjuZut"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911AB1CF8B;
	Thu, 27 Jun 2024 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719504529; cv=none; b=hP00OR/RH2i6JD9WQxvUHb/O1QjsJB4wmT1bJctY8HZnMEfzAlsvb4hX3Kav37bHJnPQnu0LychL+91hWK2mDGOlkLMwSkjHREco3mX9Fvcfj+oVc03CJsPCi5p4Pieg2VilGVCfKLaPd9Qen/OUzfO78NUdoq2hR+EsveH/3bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719504529; c=relaxed/simple;
	bh=UvvB9I+OgH/8xfj7J4ex+IlmHc9nIRL5By2AyR5g2VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DShBxruoGHd6H50J5EI33QS9hH483+fn7HmcXcLnkehXXp/WoYWJGKGbHNkKrWZEYLBs/zREAAbPTCInjXYJTRbfB7TIKzxQGDHR368yjr29WGNr9buBcbaYN3ws7QaNMaaBNnlw6f6979pq/a0NReyQOkuc7az2vbg/Hwrs3iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfgjuZut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC65C2BBFC;
	Thu, 27 Jun 2024 16:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719504529;
	bh=UvvB9I+OgH/8xfj7J4ex+IlmHc9nIRL5By2AyR5g2VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AfgjuZutP9Yi9KF01fUc7C9CHJgbKTj4/fWIOi34dC2+/URSxG4dJFccgjTM4KpaV
	 8RHbnWodxabvZm7+PdCJ2PbuO9VG5DIVcfLxQYfDWU3w59BVv5onIwKs9ypB1Ib5iL
	 Xerul6ojTt6wqbH4lURYwXNAq018hhTqB4/Tx4xH2D5d2/rt+J9/LnRebWAmR4Sil2
	 Sy4aA7fGruCbDbhB3ZcxhV3JKbRi6aLhhKq8M+u1feh+JXnzDyQ26Of6RXsULOBMIT
	 TJHQvi1dnWVn9sAsYeJ0kGlgif84MC1/oXcwFE/zc/1YGzsIdh67Cht5qay1GaBWFW
	 md+ZzpwAbFHTQ==
Date: Thu, 27 Jun 2024 10:08:47 -0600
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: net: bluetooth: convert MT7622 Bluetooth to
 the json-schema
Message-ID: <20240627160847.GA3506035-robh@kernel.org>
References: <20240627054011.26621-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240627054011.26621-1-zajec5@gmail.com>

On Thu, Jun 27, 2024 at 07:40:11AM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../bluetooth/mediatek,mt7622-bluetooth.yaml  | 61 +++++++++++++++++++
>  .../bindings/net/mediatek-bluetooth.txt       | 36 -----------
>  2 files changed, 61 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.yaml
> new file mode 100644
> index 000000000000..cb8ff93c93eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/bluetooth/mediatek,mt7622-bluetooth.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek SoC built-in Bluetooth
> +
> +description:
> +  This device is a serial attached device to BTIF device and thus it must be a
> +  child node of the serial node with BTIF. The dt-bindings details for BTIF
> +  device can be known via Documentation/devicetree/bindings/serial/8250.yaml.
> +
> +maintainers:
> +  - Sean Wang <sean.wang@mediatek.com>
> +
> +allOf:
> +  - $ref: bluetooth-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt7622-bluetooth
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: ref
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - clocks
> +  - clock-names
> +  - power-domains
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt7622-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/mt7622-power.h>
> +
> +    serial@1100c000 {
> +        compatible = "mediatek,mt7622-btif", "mediatek,mtk-btif";
> +        reg = <0 0x1100c000 0 0x1000>;
> +        interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_LOW>;
> +        clocks = <&pericfg CLK_PERI_BTIF_PD>;
> +        clock-names = "main";
> +        reg-shift = <2>;
> +        reg-io-width = <4>;

Just drop all this. Not relevant to *this* example.

You just need:

serial {

> +
> +        bluetooth {
> +            compatible = "mediatek,mt7622-bluetooth";
> +            power-domains = <&scpsys MT7622_POWER_DOMAIN_WB>;
> +            clocks = <&clk25m>;
> +            clock-names = "ref";
> +        };
> +    };

