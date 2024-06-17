Return-Path: <netdev+bounces-103931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BCC90A644
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 09:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94D65B25E87
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 07:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7D518735A;
	Mon, 17 Jun 2024 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmaNH9hZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067BD13B28A;
	Mon, 17 Jun 2024 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607604; cv=none; b=KAm9eH9dzt2MegscAABVLpQuvvCw4WZgqZHRdOLb79+Rx+vA/iq58D6mJkp09je7eTwidLTelsJjoqEirZqa5K7Y5K3WPKaat3quHyNB/q3WSc+Jzx1UVBeAnpTBVepLLe42slYX3fnzVkxZxO++AmMyYxYEeD2SbojQXJHKBEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607604; c=relaxed/simple;
	bh=/hbaAgyGIPPhVG4P0OCPoMtvi95I8xCPbHS9u7/7aeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yrj1krC9ufh94QPVyPzXlR8ErhHEvgWfLm9inshmmFV15yp2R6sTbjwOyIWDch4vy8vOuzKUCC9JSbE4r60ynryNgdbd8GH+IY7CBKjgY2Tao6ByZw6dQR+JhJ1xXso/aEsI4w06Tsmr4KFRQA7mVMV4+EPetDvvTq5LJPpEHxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmaNH9hZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE53C2BD10;
	Mon, 17 Jun 2024 06:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718607603;
	bh=/hbaAgyGIPPhVG4P0OCPoMtvi95I8xCPbHS9u7/7aeQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CmaNH9hZhKG/+3f3KwCFC104mRHj15+nwXX5vTPeeUU0o6VcftZ9Uarc1FVkYyHRH
	 FtklDNE1f2EjQu8odsTakFzuUCu+23LRwAdR/BpggkMa0jJ1or1STdRpMAhdD5nfPp
	 euLIU7bUHubUzSXcNehJS5SHLM42cdCvV4O27SKMBnMuoLujjXnQMIpD6DUvNAu0iN
	 jHMN3Kp0nTDdUxHGgd8OKq8HXnjg9CG3hA7ZHwrzx88/Mj7Odl2dQtP0CPM8DvlKzo
	 Npc55b5YI+7pQfuhLhib0oCKivNSRjXwEDjuUX1RwG7Iu/v+2VYYlO6uCV4tojTLHs
	 rZUOguS8pEfNw==
Message-ID: <28a6ff46-ad12-45c6-9ccb-f99fd08f3265@kernel.org>
Date: Mon, 17 Jun 2024 08:59:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: ptp: Convert ptp-qoirq to yaml format
To: Frank Li <Frank.Li@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Madalin Bucur <madalin.bucur@nxp.com>, Sean Anderson <sean.anderson@seco.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
References: <20240614-ls_fman-v1-0-cb33c96dc799@nxp.com>
 <20240614-ls_fman-v1-1-cb33c96dc799@nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240614-ls_fman-v1-1-cb33c96dc799@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/06/2024 22:33, Frank Li wrote:
> diff --git a/Documentation/devicetree/bindings/ptp/ptp-qoriq.yaml b/Documentation/devicetree/bindings/ptp/ptp-qoriq.yaml
> new file mode 100644
> index 0000000000000..585e8bffd90c9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ptp/ptp-qoriq.yaml

Filename based on compatible. Can be fsl,ptp.yaml

> @@ -0,0 +1,148 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ptp/ptp-qoriq.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale QorIQ 1588 timer based PTP clock
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,etsec-ptp
> +      - fsl,fman-ptp-timer
> +      - fsl,dpaa2-ptp
> +      - fsl,enetc-ptp
> +    description: |
> +      Should be "fsl,etsec-ptp" for eTSEC
> +      Should be "fsl,fman-ptp-timer" for DPAA FMan
> +      Should be "fsl,dpaa2-ptp" for DPAA2
> +      Should be "fsl,enetc-ptp" for ENETC

You can write it simpler, e.g.
- fsl,etsec-ptp   # eTSEC

and then you see that this does not bring any new information - your
comment duplicates the compatible. Just drop.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 2
> +    maxItems: 4

Items should be described.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  fsl,cksel:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Timer reference clock source.
> +
> +      Reference clock source is determined by the value, which is holded
> +      in CKSEL bits in TMR_CTRL register. "fsl,cksel" property keeps the
> +      value, which will be directly written in those bits, that is why,
> +      according to reference manual, the next clock sources can be used:
> +
> +      For eTSEC,
> +      <0> - external high precision timer reference clock (TSEC_TMR_CLK
> +            input is used for this purpose);
> +      <1> - eTSEC system clock;
> +      <2> - eTSEC1 transmit clock;
> +      <3> - RTC clock input.
> +
> +      For DPAA FMan,
> +      <0> - external high precision timer reference clock (TMR_1588_CLK)
> +      <1> - MAC system clock (1/2 FMan clock)
> +      <2> - reserved
> +      <3> - RTC clock oscillator
> +
> +  fsl,tclk-period:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Timer reference clock period in nanoseconds.
> +
> +  fsl,tmr-prsc:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Prescaler, divides the output clock.
> +
> +  fsl,tmr-add:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Frequency compensation value.
> +
> +  fsl,tmr-fiper1:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Fixed interval period pulse generator.
> +
> +  fsl,tmr-fiper2:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Fixed interval period pulse generator.
> +
> +  fsl,tmr-fiper3:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Fixed interval period pulse generator.
> +      Supported only on DPAA2 and ENETC hardware.
> +
> +  fsl,max-adj:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Maximum frequency adjustment in parts per billion.
> +
> +      These properties set the operational parameters for the PTP
> +      clock. You must choose these carefully for the clock to work right.
> +      Here is how to figure good values:
> +
> +      TimerOsc     = selected reference clock   MHz
> +      tclk_period  = desired clock period       nanoseconds
> +      NominalFreq  = 1000 / tclk_period         MHz
> +      FreqDivRatio = TimerOsc / NominalFreq     (must be greater that 1.0)
> +      tmr_add      = ceil(2^32 / FreqDivRatio)
> +      OutputClock  = NominalFreq / tmr_prsc     MHz
> +      PulseWidth   = 1 / OutputClock            microseconds
> +      FiperFreq1   = desired frequency in Hz
> +      FiperDiv1    = 1000000 * OutputClock / FiperFreq1
> +      tmr_fiper1   = tmr_prsc * tclk_period * FiperDiv1 - tclk_period
> +      max_adj      = 1000000000 * (FreqDivRatio - 1.0) - 1
> +
> +      The calculation for tmr_fiper2 is the same as for tmr_fiper1. The
> +      driver expects that tmr_fiper1 will be correctly set to produce a 1
> +      Pulse Per Second (PPS) signal, since this will be offered to the PPS
> +      subsystem to synchronize the Linux clock.
> +
> +      When this attribute is not used, the IEEE 1588 timer reference clock
> +      will use the eTSEC system clock (for Gianfar) or the MAC system
> +      clock (for DPAA).
> +
> +  fsl,extts-fifo:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      The presence of this property indicates hardware
> +      support for the external trigger stamp FIFO
> +
> +  little-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      The presence of this property indicates the 1588 timer
> +      support for the external trigger stamp FIFO.
> +      IP block is little-endian mode. The default endian mode
> +      is big-endian.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ptp_clock@24e00 {

phc@

> +        compatible = "fsl,etsec-ptp";
> +        reg = <0x24E00 0xB0>;

Lowercase hex, in other places as well.


> +        interrupts = <12 0x8>, <13 0x8>;

Use proper defines for interrupt flags.

> +        interrupt-parent = <&ipic>;
> +        fsl,cksel       = <1>;


Best regards,
Krzysztof


