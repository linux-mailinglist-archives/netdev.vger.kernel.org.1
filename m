Return-Path: <netdev+bounces-102591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3D7903DE6
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3C12B203CA
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EE217D358;
	Tue, 11 Jun 2024 13:48:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F16017D34A;
	Tue, 11 Jun 2024 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718113695; cv=none; b=mazWHyyid9TafYr6liN61IsCPX6Mx21XBEzVzf30ZFA2cOlgZ79ISCfcfNb25vSO5r+lad+Wx+95eLnuV+h8nBDJRPadBD/UU9d8i5z3qNdQmTfz1HOHWd6LsqsF/t9E8ksD+Qay3Q2ceMvTTVi+hx3sNjnY3LQWMUunNGfyZD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718113695; c=relaxed/simple;
	bh=5OH2VUSWHdHfbk+E0E/gtdS5XtLsKAfAOAuqUYVEUXk=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=ZQoggJBEeEm5PK7TA6wSdblPXolfHIBUhRGiwXA4UMxM7zTqGMAHWVGXe+YDt3F9Uxb/6E8q//p09Ct6928F15hQH/iWIxB4XYf1VycFV8cIEoZnpr4ymbzqSeZpIlZTAVszEUGBsD7VxiOXdc5VRpDmed5BKsJjmMK0HHVT8Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9906f4c1d5=ms@dev.tdt.de>)
	id 1sH1r8-000ya6-Kt; Tue, 11 Jun 2024 15:48:10 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sH1r7-00FFzX-TY; Tue, 11 Jun 2024 15:48:09 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 75A5C240053;
	Tue, 11 Jun 2024 15:48:09 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 04B7F240050;
	Tue, 11 Jun 2024 15:48:09 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 6DD0D30F70;
	Tue, 11 Jun 2024 15:48:08 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jun 2024 15:48:08 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Rob Herring <robh@kernel.org>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 01/13] dt-bindings: net: dsa: lantiq,gswip:
 convert to YAML schema
Organization: TDT AG
In-Reply-To: <20240611132730.GA1683993-robh@kernel.org>
References: <20240611114027.3136405-1-ms@dev.tdt.de>
 <20240611114027.3136405-2-ms@dev.tdt.de>
 <20240611132730.GA1683993-robh@kernel.org>
Message-ID: <e0eea99badf86544b7d45a5eec7feee3@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1718113690-1ECDD522-8C2CEC4A/0/0

On 2024-06-11 15:27, Rob Herring wrote:
> On Tue, Jun 11, 2024 at 01:40:15PM +0200, Martin Schiller wrote:
>> Convert the lantiq,gswip bindings to YAML format.
>> 
>> Also add this new file to the MAINTAINERS file.
>> 
>> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
>> ---
>>  .../bindings/net/dsa/lantiq,gswip.yaml        | 195 
>> ++++++++++++++++++
>>  .../bindings/net/dsa/lantiq-gswip.txt         | 146 -------------
>>  MAINTAINERS                                   |   1 +
>>  3 files changed, 196 insertions(+), 146 deletions(-)
>>  create mode 100644 
>> Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
>>  delete mode 100644 
>> Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml 
>> b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
>> new file mode 100644
>> index 000000000000..14ef48d6a0ee
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
>> @@ -0,0 +1,195 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/dsa/lantiq,gswip.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Lantiq GSWIP Ethernet switches
>> +
>> +allOf:
>> +  - $ref: dsa.yaml#/$defs/ethernet-ports
>> +
>> +maintainers:
>> +  - Hauke Mehrtens <hauke@hauke-m.de>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - lantiq,xrx200-gswip
>> +      - lantiq,xrx300-gswip
>> +      - lantiq,xrx330-gswip
>> +
>> +  reg:
>> +    minItems: 3
>> +    maxItems: 3
> 
> blank line
> 
>> +  reg-names:
>> +    items:
>> +      - const: switch
>> +      - const: mdio
>> +      - const: mii
>> +
>> +  mdio:
>> +    $ref: /schemas/net/mdio.yaml#
>> +    unevaluatedProperties: false
>> +
>> +    properties:
>> +      compatible:
>> +        const: lantiq,xrx200-mdio
>> +
>> +    required:
>> +      - compatible
>> +
>> +  gphy-fw:
>> +    type: object
>> +    properties:
>> +      '#address-cells':
>> +        const: 1
> 
> blank line
> 
>> +      '#size-cells':
>> +        const: 0
>> +
>> +      compatible:
>> +        allOf:
> 
> Don't need allOf.
> 
>> +          - items:
>> +              - enum:
>> +                  - lantiq,xrx200-gphy-fw
>> +                  - lantiq,xrx300-gphy-fw
>> +                  - lantiq,xrx330-gphy-fw
>> +              - const: lantiq,gphy-fw
>> +
>> +      lantiq,rcu:
>> +        $ref: /schemas/types.yaml#/definitions/phandle
>> +        description: phandle to the RCU syscon
>> +
>> +    patternProperties:
>> +      "^gphy@[0-9a-f]+$":
> 
> "^gphy@[0-9a-f]{1,2]$"
> 
>> +        type: object
>> +
>> +        properties:
>> +          reg:
>> +            minimum: 0
>> +            maximum: 255
>> +            description:
>> +              Offset of the GPHY firmware register in the RCU 
>> register range
>> +
>> +          resets:
>> +            items:
>> +              - description: GPHY reset line
>> +
>> +          reset-names:
>> +            items:
>> +              - const: gphy
>> +
>> +        required:
>> +          - reg
>> +
>> +        additionalProperties: false
> 
> For indented cases, it is preferred to put this before 'properties'.
> 
>> +
>> +    required:
>> +      - compatible
>> +      - lantiq,rcu
>> +
>> +    additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    switch@e108000 {
>> +            compatible = "lantiq,xrx200-gswip";
>> +            reg = <0xe108000 0x3100>,  /* switch */
>> +                  <0xe10b100 0xd8>,    /* mdio */
>> +                  <0xe10b1d8 0x130>;   /* mii */
>> +            dsa,member = <0 0>;
>> +
>> +            ports {
>> +                    #address-cells = <1>;
>> +                    #size-cells = <0>;
>> +
>> +                    port@0 {
>> +                            reg = <0>;
>> +                            label = "lan3";
>> +                            phy-mode = "rgmii";
>> +                            phy-handle = <&phy0>;
>> +                    };
>> +
>> +                    port@1 {
>> +                            reg = <1>;
>> +                            label = "lan4";
>> +                            phy-mode = "rgmii";
>> +                            phy-handle = <&phy1>;
>> +                    };
>> +
>> +                    port@2 {
>> +                            reg = <2>;
>> +                            label = "lan2";
>> +                            phy-mode = "internal";
>> +                            phy-handle = <&phy11>;
>> +                    };
>> +
>> +                    port@4 {
>> +                            reg = <4>;
>> +                            label = "lan1";
>> +                            phy-mode = "internal";
>> +                            phy-handle = <&phy13>;
>> +                    };
>> +
>> +                    port@5 {
>> +                            reg = <5>;
>> +                            label = "wan";
>> +                            phy-mode = "rgmii";
>> +                            phy-handle = <&phy5>;
>> +                    };
>> +
>> +                    port@6 {
>> +                            reg = <0x6>;
>> +                            ethernet = <&eth0>;
>> +                    };
>> +            };
>> +
>> +            mdio {
>> +                    #address-cells = <1>;
>> +                    #size-cells = <0>;
>> +                    compatible = "lantiq,xrx200-mdio";
>> +
>> +                    phy0: ethernet-phy@0 {
>> +                            reg = <0x0>;
>> +                    };
>> +                    phy1: ethernet-phy@1 {
>> +                            reg = <0x1>;
>> +                    };
>> +                    phy5: ethernet-phy@5 {
>> +                            reg = <0x5>;
>> +                    };
>> +                    phy11: ethernet-phy@11 {
>> +                            reg = <0x11>;
>> +                    };
>> +                    phy13: ethernet-phy@13 {
>> +                            reg = <0x13>;
>> +                    };
>> +            };
>> +
>> +            gphy-fw {
>> +                    #address-cells = <1>;
>> +                    #size-cells = <0>;
>> +                    compatible = "lantiq,xrx200-gphy-fw", 
>> "lantiq,gphy-fw";
>> +                    lantiq,rcu = <&rcu0>;
>> +
>> +                    gphy@20 {
>> +                            reg = <0x20>;
>> +
>> +                            resets = <&reset0 31 30>;
>> +                            reset-names = "gphy";
>> +                    };
>> +
>> +                    gphy@68 {
>> +                            reg = <0x68>;
>> +
>> +                            resets = <&reset0 29 28>;
>> +                            reset-names = "gphy";
>> +                    };
>> +            };
>> +    };

OK, thanks for the review. I will send a v5 with these improvements
included and the two dt-bindings patches merged to satisfy the
'make dt_binding_check'.

