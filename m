Return-Path: <netdev+bounces-258006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HlAHnF+imnVLAAAu9opvQ
	(envelope-from <netdev+bounces-258006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 01:40:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 277C9115B4E
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 01:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 257C1301C956
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 00:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23701244685;
	Tue, 10 Feb 2026 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjLsI8v3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F339223507B;
	Tue, 10 Feb 2026 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684013; cv=none; b=J8ZjSaVG3nYPN98wyvfP24JwLpHEQnu6YYokDKEyPSCPGsCPhjkJItP+9C7KDiV1QRGyoRGsF8afHiCqqMe8o4ejLuPU2N7KIClqeDGP8It3rcxz8nA2uD5l3y+TM1+EtLj4ixmOya0ImiGa+v43Ye0N5MzWnNANefeXujeTsqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684013; c=relaxed/simple;
	bh=okG7UjQjG+NhkvALP4XREVKya0FPqfH1FHODxx8wyTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EinUOXA1gZCW/EdX/wEvmLeKH+rN1lT323/6w7FfJHtHmsFM80Nzpzb94EfCG7VvIjg4Ut/NKYzHaYUNf/yaKiAfAxDkrTOVZDIkTi3/LHdyOqMwhmIygAnyOrYwVSCYWhuZPfjEuBACD9b+znPnZfLMIV52IC18Fuus59htYls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjLsI8v3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65425C19422;
	Tue, 10 Feb 2026 00:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684012;
	bh=okG7UjQjG+NhkvALP4XREVKya0FPqfH1FHODxx8wyTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RjLsI8v3e2pMavrZlMuLaQ6rPrgulHjdzXeEk3+UIUQj256jPEPqCsUsrNkxhJUIG
	 KPmH6dxedINMg7ek2+SMmDBIBY8lsaGptkWi5i1n+OAsjJPM220O0+J+Tm2lUipNLV
	 I6q20eXmWQPh1IFvijn7+23kQKiIF/Q0gTj6RlDb2gXIyUlFe0Djc+PykXjaoILObs
	 3z7mVU1FRVYtyOUeCdiwx0a3Fzrgm4j5a8zF6pFdBU1CrVZkZsPjOKdchu0AxWF1iv
	 14vF66+jTGxt9hryK+MNdGoLshhTRblMo7vFBLkMbM98OTF19VjY5vPGC+ieHYFyGk
	 l3d3U8XwuoNuQ==
Date: Mon, 9 Feb 2026 18:40:11 -0600
From: Rob Herring <robh@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com,
	p.zabel@pengutronix.de, linux@armlinux.org.uk,
	ghennadi.procopciuc@nxp.com, Ionut.Vicovan@nxp.com,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, horms@kernel.org, Frank.li@nxp.com
Subject: Re: [PATCH 1/4 v2] dt-bindings: serdes: s32g: Add NXP serdes
 subsystem
Message-ID: <20260210004011.GA2188625-robh@kernel.org>
References: <20260203161917.1666696-1-vincent.guittot@linaro.org>
 <20260203161917.1666696-2-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203161917.1666696-2-vincent.guittot@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258006-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.0:email,0.0.0.1:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,2.105.173.0:email,linaro.org:email]
X-Rspamd-Queue-Id: 277C9115B4E
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 05:19:14PM +0100, Vincent Guittot wrote:
> Describe the serdes subsystem available on the S32G platforms.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  .../bindings/phy/nxp,s32g-serdes.yaml         | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml b/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
> new file mode 100644
> index 000000000000..fad34bee2a4f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/nxp,s32g-serdes.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP S32G2xxx/S32G3xxx SerDes PHY subsystem
> +
> +maintainers:
> +  - Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> +
> +description: |
> +  The SerDes subsystem on S32G SoC Family includes two types of PHYs:
> +    - One PCIe PHY: Supports various PCIe operation modes
> +    - Two Ethernet Physical Coding Sublayer (XPCS) controllers
> +
> +  SerDes operation mode selects the enabled PHYs and speeds. Clock frequency
> +  must be adapted accordingly. Below table describes all possible operation
> +  modes.
> +
> +  Mode  PCIe	XPCS0		XPCS1		PHY clock	Description
> +                SGMII		SGMII		  (MHz)
> +  -------------------------------------------------------------------------
> +  0	Gen3	N/A		N/A		100		Single PCIe
> +  1	Gen2	1.25Gbps	N/A		100		PCIe/SGMII
> +  2	Gen2	N/A		1.25Gbps	100		PCIe/SGMII
> +  3	N/A	1.25Gbps	1.25Gbps	100,125		SGMII
> +  4	N/A	3.125/1.25Gbps	3.125/1.25Gbps 	125		SGMII
> +  5	Gen2	N/A	        3.125Gbps     	100		PCIe/SGMII

Mixed tabs and spaces. Drop the tabs.

What's not clear to me is do you have 2 or 4 lanes?

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - nxp,s32g2-serdes
> +      - items:
> +          - const: nxp,s32g3-serdes
> +          - const: nxp,s32g2-serdes
> +
> +  reg:
> +    maxItems: 4
> +
> +  reg-names:
> +    items:
> +      - const: ss_pcie
> +      - const: pcie_phy
> +      - const: xpcs0
> +      - const: xpcs1
> +
> +  clocks:
> +    minItems: 4
> +    maxItems: 5
> +
> +  clock-names:
> +    items:
> +      - const: axi
> +      - const: aux
> +      - const: apb
> +      - const: ref
> +      - const: ext
> +    minItems: 4
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: serdes
> +      - const: pcie
> +
> +  nxp,sys-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32

       maximum: 5

Though isn't this redundant with the child nodes? You could use the 
standard 'phy-mode' property in each child.

> +    description: |
> +      SerDes operational mode. See above table for possible values.
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  '^serdes[0,1]_lane@[0,1]$':

Do you need to support serdes0_lane@0 and serdes1_lane@0 (or similar 
with "@1")? That's illegal as you have 2 nodes with the same address.

> +    description:
> +      Describe a serdes lane.
> +    type: object
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - nxp,s32g2-serdes-pcie-phy
> +          - nxp,s32g2-serdes-xpcs

Seems like phy-mode would be sufficient. Are these separate blocks from 
the parent?

> +
> +      reg:
> +        maxItems: 1

Just 'maximum: 1' instead.

> +
> +      '#phy-cells':
> +        const: 0
> +
> +    required:
> +      - reg
> +      - compatible
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - nxp,sys-mode
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        serdes0: serdes@40480000 {
> +          compatible = "nxp,s32g3-serdes", "nxp,s32g2-serdes";
> +            reg = <0x0 0x40480000 0x0 0x108>,
> +                  <0x0 0x40483008 0x0 0x10>,
> +                  <0x0 0x40482000 0x0 0x800>,
> +                  <0x0 0x40482800 0x0 0x800>;
> +            reg-names = "ss_pcie", "pcie_phy", "xpcs0", "xpcs1";
> +            clocks = <&clks 1>,
> +                     <&clks 2>,
> +                     <&clks 3>,
> +                     <&clks 4>,
> +                     <&serdes_100_ext>;
> +            clock-names = "axi", "aux", "apb", "ref", "ext";
> +            resets = <&reset 9>,
> +                     <&reset 8>;
> +            reset-names = "serdes", "pcie";
> +            nxp,sys-mode = <1>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            phy_pcie0: serdes0_lane@0 {
> +              compatible = "nxp,s32g2-serdes-pcie-phy";
> +              #phy-cells = <0>;
> +              reg = <0>;
> +            };
> +            phy_xpcs0_0: serdes0_lane@1 {
> +              compatible = "nxp,s32g2-serdes-xpcs";
> +              reg = <0>;
> +            };
> +        };
> +    };
> -- 
> 2.43.0
> 

