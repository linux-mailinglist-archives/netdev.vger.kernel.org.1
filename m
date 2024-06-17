Return-Path: <netdev+bounces-103940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 727E190A6B7
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 09:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AEBA1C24AFC
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 07:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2552187548;
	Mon, 17 Jun 2024 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNOPXzD9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A273C187323;
	Mon, 17 Jun 2024 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608452; cv=none; b=uPQVspn/Kc1iNdtGFmQi4cpmiJNe5ZqdKYR9FHh2ehoZdfy4pja+U9YAMdC2sibt82MrdS7nqW4NUwrlbhrlB/VWV+MZvrz6mv1TyFrOE6VkZReyAkKHoX1JScYnxsnP4TUXmyrBMFHOMWK22NF/5oKwpIxs8Vpv8zpU+mBkZo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608452; c=relaxed/simple;
	bh=Ae70p2sXlx6ci2KzZWwD32nBpBJFBokZOQZpnUOCWCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuHUKKKodN6SQ8cbHV3pB01YY1p46UimT6vWoJlC/4Ie27ifMyf6uZTSgEjf2UJ7UFp9ZEt08kfT++6bV4IyQklPHs3qmLXOAeEuYia9RFoqh86AxE4S21c5PSpwLYQKHlSeZSD6tvul/F/so4ezARBeTJAtpyB2ROqh2rEFM9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNOPXzD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2228C2BD10;
	Mon, 17 Jun 2024 07:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718608452;
	bh=Ae70p2sXlx6ci2KzZWwD32nBpBJFBokZOQZpnUOCWCU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tNOPXzD9Wh+YJyvCSalSmouf/Gz6bkWk7Kuywt3gSi1ypgW5lzo2VVK17F/7vJv0+
	 JKjYJK1V7FdUlu1tQARGH7+1eUwVqDbn6J4hG3CnrxHC+ahOVB/FsCj43aMpYr9PGg
	 8DfdY0mLm2fyiZaj2VbgfrMVarE5+VJeavFOW9+AZzZ37ZmD4Ct7JfbB8TqBW0FgD9
	 nu2poJr7f2mYjVaPITBGS1wm+mdim+7qD0nqeAFQJLnx429lPwxcm8HVRco7Tfm0FK
	 DOnrRZVeAjJuNqaNoyaoRNlhDHU7vot4Fodie069MWTVTutbQH2QK8C8NT+/9Ke3k8
	 PlIQzlDejJx7g==
Message-ID: <a71bf75f-8c2c-44cc-baeb-3feabd1757b9@kernel.org>
Date: Mon, 17 Jun 2024 09:14:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: net: Convert fsl-fman to yaml
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
 <20240614-ls_fman-v1-2-cb33c96dc799@nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240614-ls_fman-v1-2-cb33c96dc799@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/06/2024 22:33, Frank Li wrote:
> Convert fsl-fman from txt to yaml format and split it fsl,fman.yam,
> fsl,fman-port.yaml, fsl-muram.yaml, fsl-mdio.yaml.


> +  clocks:
> +    items:
> +      - description: A reference to the input clock of the controller
> +          from which the MDC frequency is derived.
> +
> +  clock-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Specifies the external MDC frequency, in Hertz, to
> +      be used. Requires that the input clock is specified in the
> +      "clocks" property. See also: mdio.yaml.

Drop entire property. Comes from mdio.yaml.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  fsl,fman-internal-mdio:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Fman has internal MDIO for internal PCS(Physical
> +      Coding Sublayer) PHYs and external MDIO for external PHYs.
> +      The settings and programming routines for internal/external
> +      MDIO are different. Must be included for internal MDIO.
> +

...

> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description: |
> +  FMan Internal memory - shared between all the FMan modules.
> +  It contains data structures that are common and written to or read by
> +  the modules.
> +
> +  FMan internal memory is split into the following parts:
> +    Packet buffering (Tx/Rx FIFOs)
> +    Frames internal context
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,fman-muram
> +
> +  reg:
> +    maxItems: 1
> +
> +  ranges: true

That's odd. Why do you need ranges without children?

> +
> +required:
> +  - compatible
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    muram@0 {
> +        compatible = "fsl,fman-muram";
> +        ranges = <0 0x000000 0x0 0x28000>;
> +    };


> diff --git a/Documentation/devicetree/bindings/net/fsl,fman-port.yaml b/Documentation/devicetree/bindings/net/fsl,fman-port.yaml
> new file mode 100644
> index 0000000000000..7e69cf02bd024
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/fsl,fman-port.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/fsl,fman-port.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Frame Manager Port Device
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description: |
> +  The Frame Manager (FMan) supports several types of hardware ports:
> +    Ethernet receiver (RX)
> +    Ethernet transmitter (TX)
> +    Offline/Host command (O/H)
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,fman-v2-port-oh
> +      - fsl,fman-v2-port-rx
> +      - fsl,fman-v2-port-tx
> +      - fsl,fman-v3-port-oh
> +      - fsl,fman-v3-port-rx
> +      - fsl,fman-v3-port-tx
> +
> +  cell-index:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Specifies the hardware port id.
> +      Each hardware port on the FMan has its own hardware PortID.
> +      Super set of all hardware Port IDs available at FMan Reference
> +      Manual under "FMan Hardware Ports in Freescale Devices" table.
> +
> +      Each hardware port is assigned a 4KB, port-specific page in
> +      the FMan hardware port memory region (which is part of the
> +      FMan memory map). The first 4 KB in the FMan hardware ports
> +      memory region is used for what are called common registers.
> +      The subsequent 63 4KB pages are allocated to the hardware
> +      ports.
> +      The page of a specific port is determined by the cell-index.
> +
> +  reg:
> +    items:
> +      - description: There is one reg region describing the port
> +          configuration registers.
> +
> +  fsl,fman-10g-port:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: The default port rate is 1G.
> +      If this property exists, the port is s 10G port.
> +
> +  fsl,fman-best-effort-port:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: The default port rate is 1G.
> +      Can be defined only if 10G-support is set.
> +      This property marks a best-effort 10G port (10G port that
> +      may not be capable of line rate).
> +
> +required:
> +  - compatible
> +  - reg
> +  - cell-index
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    port@a8000 {
> +        compatible = "fsl,fman-v2-port-tx";
> +        reg = <0xa8000 0x1000>;
> +        cell-index = <0x28>;
> +    };

Just keep one example.

> +
> +    port@88000 {
> +        cell-index = <0x8>;
> +        compatible = "fsl,fman-v2-port-rx";
> +        reg = <0x88000 0x1000>;
> +    };
> +
> +    port@81000 {
> +        cell-index = <0x1>;
> +        compatible = "fsl,fman-v2-port-oh";
> +        reg = <0x81000 0x1000>;
> +    };
> diff --git a/Documentation/devicetree/bindings/net/fsl,fman.yaml b/Documentation/devicetree/bindings/net/fsl,fman.yaml
> new file mode 100644
> index 0000000000000..dfd403f9a7c9d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/fsl,fman.yaml
> @@ -0,0 +1,335 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/fsl,fman.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Frame Manager Device
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description:
> +  Due to the fact that the FMan is an aggregation of sub-engines (ports, MACs,
> +  etc.) the FMan node will have child nodes for each of them.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,fman
> +    description:
> +      FMan version can be determined via FM_IP_REV_1 register in the
> +      FMan block. The offset is 0xc4 from the beginning of the
> +      Frame Processing Manager memory map (0xc3000 from the
> +      beginning of the FMan node).
> +
> +  cell-index:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Specifies the index of the FMan unit.
> +
> +      The cell-index value may be used by the SoC, to identify the
> +      FMan unit in the SoC memory map. In the table below,
> +      there's a description of the cell-index use in each SoC:
> +
> +      - P1023:
> +      register[bit]      FMan unit  cell-index
> +      ============================================================
> +      DEVDISR[1]      1    0
> +
> +      - P2041, P3041, P4080 P5020, P5040:
> +      register[bit]      FMan unit  cell-index
> +      ============================================================
> +      DCFG_DEVDISR2[6]    1    0
> +      DCFG_DEVDISR2[14]    2    1
> +        (Second FM available only in P4080 and P5040)
> +
> +      - B4860, T1040, T2080, T4240:
> +      register[bit]      FMan unit  cell-index
> +      ============================================================
> +      DCFG_CCSR_DEVDISR2[24]    1    0
> +      DCFG_CCSR_DEVDISR2[25]    2    1
> +        (Second FM available only in T4240)
> +
> +      DEVDISR, DCFG_DEVDISR2 and DCFG_CCSR_DEVDISR2 are located in
> +      the specific SoC "Device Configuration/Pin Control" Memory
> +      Map.
> +
> +  reg:
> +    items:
> +      - description: BMI configuration registers.
> +      - description: QMI configuration registers.
> +      - description: DMA configuration registers.
> +      - description: FPM configuration registers.
> +      - description: FMan controller configuration registers.
> +    minItems: 1
> +
> +  ranges: true
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: fmanclk
> +
> +  interrupts:
> +    items:
> +      - description: The first element is associated with the event interrupts.
> +      - description: the second element is associated with the error interrupts.
> +
> +  fsl,qman-channel-range:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Specifies the range of the available dedicated
> +      channels in the FMan. The first cell specifies the beginning
> +      of the range and the second cell specifies the number of
> +      channels
> +    items:
> +      - description: The first cell specifies the beginning of the range.
> +      - description: |
> +          The second cell specifies the number of channels.
> +          Further information available at:
> +          "Work Queue (WQ) Channel Assignments in the QMan" section
> +          in DPAA Reference Manual.
> +
> +  fsl,qman:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: See soc/fsl/qman.txt
> +
> +  fsl,bman:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: See soc/fsl/bman.txt
> +
> +  fsl,erratum-a050385:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: A boolean property. Indicates the presence of the
> +      erratum A050385 which indicates that DMA transactions that are
> +      split can result in a FMan lock.
> +
> +  "#address-cells": true
> +
> +  "#size-cells": true

Make both const.

> +
> +patternProperties:
> +  '^muram@[a-f0-9]+$':
> +    $ref: fsl,fman-muram.yaml
> +
> +  '^port@[a-f0-9]+$':
> +    $ref: fsl,fman-port.yaml
> +
> +  '^ethernet@[a-f0-9]+$':
> +    $ref: fsl,fman-dtsec.yaml
> +
> +  '^mdio@[a-f0-9]+$':
> +    $ref: fsl,fman-mdio.yaml
> +
> +  '^ptp\-timer@[a-f0-9]+$':
> +    $ref: /schemas/ptp/ptp-qoriq.yaml
> +
> +required:
> +  - compatible
> +  - cell-index
> +  - reg
> +  - ranges
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - fsl,qman-channel-range
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    fman@400000 {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        cell-index = <1>;
> +        compatible = "fsl,fman";

Compatible is always the first property. reg follows, third ranges.

> +        ranges = <0 0x400000 0x100000>;
> +        reg = <0x400000 0x100000>;
> +        clocks = <&fman_clk>;
> +        clock-names = "fmanclk";
> +        interrupts = <96 2>,
> +                     <16 2>;

Use proper defines for flags.



Best regards,
Krzysztof


