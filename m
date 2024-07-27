Return-Path: <netdev+bounces-113350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C42293DE24
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 11:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3865282ED6
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 09:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663144AEF7;
	Sat, 27 Jul 2024 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHolPxWp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3694C487BF;
	Sat, 27 Jul 2024 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722072334; cv=none; b=eA/zG2aLuGv6aIP6e4VsIg4hDhFo3u0BVoN92Ph+hajUIcoLGa4+eVX1admCEXWbFaIlcsQWs2epYp8E/zXremnYQQsJyyGv+89HTlxDidaT5TIos9ajOtfzEndrTr7HAXq589OIOv998bfqa/WuLexNVUfco/7N6C1U6lQDqag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722072334; c=relaxed/simple;
	bh=FKWdEEfKwiHZEjR/g5jblQ0qk2xKb1tNXvjLXnAAvxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNN7rtWJ1AkRe5xZX7LSjXtt5mN4hmuDmfegVnfnTW5QrJrgwG8g+m5krDPTJwZaC42slQmy1BLGj+vJydYfbUcYORcWkQ/se+gI1JLzVq8K6LH4aOuW533EwXNb3MdtgCeb5HyJEJWrRyEqJ1kqQHMCclrHkv7HNwf5l+6PGuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHolPxWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0503DC32781;
	Sat, 27 Jul 2024 09:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722072333;
	bh=FKWdEEfKwiHZEjR/g5jblQ0qk2xKb1tNXvjLXnAAvxE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SHolPxWpFfdGBRgaFzCWl0NEKJCm1vmfY6RVdGBVTQRWrPu9cf3GlCsMQyGfCRbw8
	 fHrD8pyx/qnvX+KK4Q1upcyvuigGDDMXTNSqOna8/DE630LfJwB0r+t7q/243/v20C
	 N6/1siFd0TaN3SZLmFIdo0k6NJ/++ECX9Wew4I4zwmSlkJs2W+lT6Fusmet/GwSOuH
	 04RuWElp176qrtXkImkNmAJLReStBggKLLcTufAzw7G3N3ev3wakixmuvN3Wf/mbQ+
	 hHIDuMySzUplvKiPZ8rwbLJTK9Xl17IvSPOokebB/DRFUzKi+6KP6ENECfy64+kPo7
	 64hZJcmBkKDdw==
Message-ID: <ac84b12f-ae91-4a2f-a5f7-88febd13911c@kernel.org>
Date: Sat, 27 Jul 2024 11:25:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: motorcomm: Add chip mode cfg
To: "Frank.Sae" <Frank.Sae@motor-comm.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, yuanlai.cui@motor-comm.com,
 hua.sun@motor-comm.com, xiaoyong.li@motor-comm.com,
 suting.hu@motor-comm.com, jie.han@motor-comm.com
References: <20240727092009.1108640-1-Frank.Sae@motor-comm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240727092009.1108640-1-Frank.Sae@motor-comm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/07/2024 11:20, Frank.Sae wrote:
>  The motorcomm phy (yt8821) supports the ability to
>  config the chip mode of serdes.
>  The yt8821 serdes could be set to AUTO_BX2500_SGMII or
>  FORCE_BX2500.
>  In AUTO_BX2500_SGMII mode, SerDes
>  speed is determined by UTP, if UTP link up
>  at 2.5GBASE-T, SerDes will work as
>  2500BASE-X, if UTP link up at
>  1000BASE-T/100BASE-Tx/10BASE-T, SerDes will work
>  as SGMII.
>  In FORCE_BX2500, SerDes always works
>  as 2500BASE-X.

Very weird wrapping.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

> 
> Signed-off-by: Frank.Sae <Frank.Sae@motor-comm.com>

Didn't you copy user-name as you name?

> ---
>  .../bindings/net/motorcomm,yt8xxx.yaml          | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Also, your threading is completely broken. Use git send-email or b4.

> 
> diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
> index 26688e2302ea..ba34260f889d 100644
> --- a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
> +++ b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
> @@ -110,6 +110,23 @@ properties:
>        Transmit PHY Clock delay train configuration when speed is 1000Mbps.
>      type: boolean
>  
> +  motorcomm,chip-mode:
> +    description: |
> +      Only for yt8821 2.5G phy, it supports two chip working modes,

Then allOf:if:then disallowing it for the other variant?

> +      one is AUTO_BX2500_SGMII, the other is FORCE_BX2500.
> +      If this property is not set in device tree node then driver
> +      selects chip mode FORCE_BX2500 by default.

Don't repeat constraints in free form text.

> +      0: AUTO_BX2500_SGMII
> +      1: FORCE_BX2500
> +      In AUTO_BX2500_SGMII mode, serdes speed is determined by UTP,
> +      if UTP link up at 2.5GBASE-T, serdes will work as 2500BASE-X,
> +      if UTP link up at 1000BASE-T/100BASE-Tx/10BASE-T, serdes will
> +      work as SGMII.
> +      In FORCE_BX2500 mode, serdes always works as 2500BASE-X.


Explain why this is even needed and why "auto" is not correct in all
cases. In commit msg or property description.

> +    $ref: /schemas/types.yaml#/definitions/uint8

Make it a string, not uint8.


> +    enum: [ 0, 1 ]
> +    default: 1

Why 1 not 0? Auto seems more logical?

> +
>  unevaluatedProperties: false
>  
>  examples:

Best regards,
Krzysztof


