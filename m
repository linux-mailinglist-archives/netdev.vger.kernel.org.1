Return-Path: <netdev+bounces-186718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A816AA0833
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 12:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77EFF3BEF8B
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 10:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC242BE7C5;
	Tue, 29 Apr 2025 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="wjZ5zazZ"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859DA1E231E;
	Tue, 29 Apr 2025 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921497; cv=none; b=grai+Od52QbdfVSrX/3cnIRuHJpiDq8zkAsvMCT4Fm6mRCQrb0PSDHdab7E451BrBHnvfxKi1ACgpuDXIL5sYK5Fsj0D/EG5PMogri4bfXfAwHC/rDAxN4TiE7TmrniAtTmZ3MXKpGJuUch5IO3ZeQvDgcBUzDCeKzCs9FFDtsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921497; c=relaxed/simple;
	bh=d12lqzGjZasx/q66H0ex7hVpuqevqT17S2SAdGZObxg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=WzjQYKlIsidDpzm5m5mn26gEr+bMdQWoZ8Xx+uE4fV4ZxzcAYQefLROz2KAKqkYLburJ1xNynTYI0MzPW6H/eXlfMpc23DsVrwgPYokY1aGcCBeGEAaInxtCjWHwsN+xb49BIgwcBo6eWAiaGxbyvuZe7MMllTDDN0TzJHII9nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=wjZ5zazZ; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3UDd06txb+/xeu/BfC+Pa3v55WuHurcb16m6fPOYJ9Q=; b=wjZ5zazZHtQ73Ic/178/MPQ3vt
	rZFy2guKV49cHLW8ThOADUVzttA/sFn1pZcGqEN9xRWuC7nkQiP1eUPH//JzKIfHje6FkO2rga9Fq
	4jKR0q5tf5cLAryvn9b689VXW+yuZ2lmfLR70VEIS/N3cVCNlIIl8keep/XUWPXMOyJ97Au9u/QMV
	CHhre13AqptO7hNMgiz8mGc4darOyAadIMZ/ipmAuBlycMw8qr3g8s5gR5SlY/CfPKTGCsOCqroBv
	davST+QFBu+xUQXndwrpwvM1O9hD40jcjjzM//OLQJh13h98aAV/j9dw1FY5VIi0BUdSY2O6yXpmb
	sUOE8FGA==;
Received: from [122.175.9.182] (port=8491 helo=zimbra.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1u9hw1-000000000B6-0FbL;
	Tue, 29 Apr 2025 15:41:29 +0530
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 30D75178245B;
	Tue, 29 Apr 2025 15:41:23 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 10A1517823E0;
	Tue, 29 Apr 2025 15:41:23 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gEAh5QuY-F_Z; Tue, 29 Apr 2025 15:41:22 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id BD358178245B;
	Tue, 29 Apr 2025 15:41:22 +0530 (IST)
Date: Tue, 29 Apr 2025 15:41:22 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: robh <robh@kernel.org>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>, 
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>, 
	nm <nm@ti.com>, ssantosh <ssantosh@kernel.org>, 
	tony <tony@atomide.com>, richardcochran <richardcochran@gmail.com>, 
	glaroque <glaroque@baylibre.com>, schnelle <schnelle@linux.ibm.com>, 
	m-karicheri2 <m-karicheri2@ti.com>, s hauer <s.hauer@pengutronix.de>, 
	rdunlap <rdunlap@infradead.org>, diogo ivo <diogo.ivo@siemens.com>, 
	basharath <basharath@couthit.com>, horms <horms@kernel.org>, 
	jacob e keller <jacob.e.keller@intel.com>, 
	m-malladi <m-malladi@ti.com>, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, 
	afd <afd@ti.com>, s-anna <s-anna@ti.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <794684867.1172961.1745921482649.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250425211917.GA3108205-robh@kernel.org>
References: <20250423060707.145166-1-parvathi@couthit.com> <20250423060707.145166-2-parvathi@couthit.com> <20250425211917.GA3108205-robh@kernel.org>
Subject: Re: [PATCH net-next v6 01/11] dt-bindings: net: ti: Adds DUAL-EMAC
 mode support on PRU-ICSS2 for AM57xx, AM43xx and AM33xx SOCs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF113 (Linux)/8.8.15_GA_3968)
Thread-Topic: dt-bindings: net: ti: Adds DUAL-EMAC mode support on PRU-ICSS2 for AM57xx, AM43xx and AM33xx SOCs
Thread-Index: An4q1m7fJHj9pZZt7n8TlHRhxmy9yw==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.wki.vra.mybluehostin.me
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.wki.vra.mybluehostin.me: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.wki.vra.mybluehostin.me: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

> On Wed, Apr 23, 2025 at 11:36:57AM +0530, Parvathi Pudi wrote:
>> Documentation update for the newly added "pruss2_eth" device tree
>> node and its dependencies along with compatibility for PRU-ICSS
>> Industrial Ethernet Peripheral (IEP), PRU-ICSS Enhanced Capture
>> (eCAP) peripheral and using YAML binding document for AM57xx SoCs.
>> 
>> Co-developed-by: Basharath Hussain Khaja <basharath@couthit.com>
>> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
>> ---
>>  .../devicetree/bindings/net/ti,icss-iep.yaml  |  10 +-
>>  .../bindings/net/ti,icssm-prueth.yaml         | 233 ++++++++++++++++++
>>  .../bindings/net/ti,pruss-ecap.yaml           |  32 +++
>>  .../devicetree/bindings/soc/ti/ti,pruss.yaml  |   9 +
>>  4 files changed, 281 insertions(+), 3 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
>>  create mode 100644 Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>> b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>> index e36e3a622904..ea2659d90a52 100644
>> --- a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>> +++ b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>> @@ -8,6 +8,8 @@ title: Texas Instruments ICSS Industrial Ethernet Peripheral
>> (IEP) module
>>  
>>  maintainers:
>>    - Md Danish Anwar <danishanwar@ti.com>
>> +  - Parvathi Pudi <parvathi@couthit.com>
>> +  - Basharath Hussain Khaja <basharath@couthit.com>
>>  
>>  properties:
>>    compatible:
>> @@ -17,9 +19,11 @@ properties:
>>                - ti,am642-icss-iep
>>                - ti,j721e-icss-iep
>>            - const: ti,am654-icss-iep
>> -
>> -      - const: ti,am654-icss-iep
>> -
>> +      - enum:
>> +          - ti,am654-icss-iep
>> +          - ti,am5728-icss-iep
>> +          - ti,am4376-icss-iep
>> +          - ti,am3356-icss-iep
>>  
>>    reg:
>>      maxItems: 1
>> diff --git a/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
>> b/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
>> new file mode 100644
>> index 000000000000..d42aea70eb76
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
>> @@ -0,0 +1,233 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/ti,icssm-prueth.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments ICSSM PRUSS Ethernet
>> +
>> +maintainers:
>> +  - Roger Quadros <rogerq@ti.com>
>> +  - Andrew F. Davis <afd@ti.com>
>> +  - Parvathi Pudi <parvathi@couthit.com>
>> +  - Basharath Hussain Khaja <basharath@couthit.com>
>> +
>> +description:
>> +  Ethernet based on the Programmable Real-Time Unit and Industrial
>> +  Communication Subsystem.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,am57-prueth     # for AM57x SoC family
>> +      - ti,am4376-prueth   # for AM43x SoC family
>> +      - ti,am3359-prueth   # for AM33x SoC family
>> +
>> +  sram:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      phandle to OCMC SRAM node
>> +
>> +  ti,mii-rt:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      phandle to MII_RT module's syscon regmap
> 
> regmap is a Linuxism. Say what functionality you need from this block.
> 

Sure, we will update the documentation in the next version.

>> +
>> +  ti,iep:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      phandle to IEP (Industrial Ethernet Peripheral) for ICSS
>> +
>> +  ti,ecap:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      phandle to Enhanced Capture (eCAP) event for ICSS
>> +
>> +  interrupts:
>> +    items:
>> +      - description: High priority Rx Interrupt specifier.
>> +      - description: Low priority Rx Interrupt specifier.
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: rx_hp
>> +      - const: rx_lp
>> +
>> +  ethernet-ports:
>> +    type: object
>> +    additionalProperties: false
>> +
>> +    properties:
>> +      '#address-cells':
>> +        const: 1
>> +      '#size-cells':
>> +        const: 0
>> +
>> +    patternProperties:
>> +      ^ethernet-port@[0-1]$:
>> +        type: object
>> +        description: ICSSM PRUETH external ports
>> +        $ref: ethernet-controller.yaml#
>> +        unevaluatedProperties: false
>> +
>> +        properties:
>> +          reg:
>> +            items:
>> +              - enum: [0, 1]
>> +            description: ICSSM PRUETH port number
>> +
>> +          interrupts:
>> +            maxItems: 3
>> +
>> +          interrupt-names:
>> +            items:
>> +              - const: rx
>> +              - const: emac_ptp_tx
>> +              - const: hsr_ptp_tx
>> +
>> +        required:
>> +          - reg
>> +
>> +    anyOf:
>> +      - required:
>> +          - ethernet-port@0
>> +      - required:
>> +          - ethernet-port@1
>> +
>> +required:
>> +  - compatible
>> +  - sram
>> +  - ti,mii-rt
>> +  - ti,iep
>> +  - ti,ecap
>> +  - ethernet-ports
>> +  - interrupts
>> +  - interrupt-names
>> +
>> +allOf:
>> +  - $ref: /schemas/remoteproc/ti,pru-consumer.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    /* Dual-MAC Ethernet application node on PRU-ICSS2 */
>> +    pruss2_eth: pruss2-eth {
> 
> Drop unused labels.
> 

"pruss2_eth" label is the primary node of the PRU-ICSS2 and
PRUETH driver is referring to this label. A name followed by a
label is required. Do we need to rename "pruss2-eth" to any
other? if we try to remove the name, we expected to see a
syntax error.

>> +      compatible = "ti,am57-prueth";
>> +      ti,prus = <&pru2_0>, <&pru2_1>;
>> +      sram = <&ocmcram1>;
>> +      ti,mii-rt = <&pruss2_mii_rt>;
>> +      ti,iep = <&pruss2_iep>;
>> +      ti,ecap = <&pruss2_ecap>;
>> +      interrupts = <20 2 2>, <21 3 3>;
>> +      interrupt-names = "rx_hp", "rx_lp";
>> +      interrupt-parent = <&pruss2_intc>;
>> +
>> +      ethernet-ports {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        pruss2_emac0: ethernet-port@0 {
>> +          reg = <0>;
>> +          phy-handle = <&pruss2_eth0_phy>;
>> +          phy-mode = "mii";
>> +          interrupts = <20 2 2>, <26 6 6>, <23 6 6>;
>> +          interrupt-names = "rx", "emac_ptp_tx", "hsr_ptp_tx";
>> +          /* Filled in by bootloader */
>> +          local-mac-address = [00 00 00 00 00 00];
>> +        };
>> +
>> +        pruss2_emac1: ethernet-port@1 {
>> +          reg = <1>;
>> +          phy-handle = <&pruss2_eth1_phy>;
>> +          phy-mode = "mii";
>> +          interrupts = <21 3 3>, <27 9 7>, <24 9 7>;
>> +          interrupt-names = "rx", "emac_ptp_tx", "hsr_ptp_tx";
>> +          /* Filled in by bootloader */
>> +          local-mac-address = [00 00 00 00 00 00];
>> +        };
>> +      };
>> +    };
>> +  - |
>> +    /* Dual-MAC Ethernet application node on PRU-ICSS1 */
>> +    pruss1_eth: pruss1-eth {
>> +      compatible = "ti,am4376-prueth";
>> +      ti,prus = <&pru1_0>, <&pru1_1>;
>> +      sram = <&ocmcram>;
>> +      ti,mii-rt = <&pruss1_mii_rt>;
>> +      ti,iep = <&pruss1_iep>;
>> +      ti,ecap = <&pruss1_ecap>;
>> +      interrupts = <20 2 2>, <21 3 3>;
>> +      interrupt-names = "rx_hp", "rx_lp";
>> +      interrupt-parent = <&pruss1_intc>;
>> +
>> +      pinctrl-0 = <&pruss1_eth_default>;
>> +      pinctrl-names = "default";
>> +
>> +      ethernet-ports {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        pruss1_emac0: ethernet-port@0 {
>> +          reg = <0>;
>> +          phy-handle = <&pruss1_eth0_phy>;
>> +          phy-mode = "mii";
>> +          interrupts = <20 2 2>, <26 6 6>, <23 6 6>;
>> +          interrupt-names = "rx", "emac_ptp_tx",
>> +                                          "hsr_ptp_tx";
>> +          /* Filled in by bootloader */
>> +          local-mac-address = [00 00 00 00 00 00];
>> +        };
>> +
>> +        pruss1_emac1: ethernet-port@1 {
>> +          reg = <1>;
>> +          phy-handle = <&pruss1_eth1_phy>;
>> +          phy-mode = "mii";
>> +          interrupts = <21 3 3>, <27 9 7>, <24 9 7>;
>> +          interrupt-names = "rx", "emac_ptp_tx",
>> +                                          "hsr_ptp_tx";
>> +          /* Filled in by bootloader */
>> +          local-mac-address = [00 00 00 00 00 00];
>> +        };
>> +      };
>> +    };
>> +  - |
>> +    /* Dual-MAC Ethernet application node on PRU-ICSS */
>> +    pruss_eth: pruss-eth {
> 
> Really need 3 examples?
> 

We included these examples to differentiate between three series
of devices (AM335x, AM437x and AM57xx) with same architecture
for PRU-ICSS but differences in number of instances, local
interrupt controller mapping, size, offset differences and etc. 

>> +      compatible = "ti,am3359-prueth";
>> +      ti,prus = <&pru0>, <&pru1>;
>> +      sram = <&ocmcram>;
>> +      ti,mii-rt = <&pruss_mii_rt>;
>> +      ti,iep = <&pruss_iep>;
>> +      ti,ecap = <&pruss_ecap>;
>> +      interrupts = <20 2 2>, <21 3 3>;
>> +      interrupt-names = "rx_hp", "rx_lp";
>> +      interrupt-parent = <&pruss_intc>;
>> +
>> +      pinctrl-0 = <&pruss_eth_default>;
>> +      pinctrl-names = "default";
>> +
>> +      ethernet-ports {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        pruss_emac0: ethernet-port@0 {
>> +          reg = <0>;
>> +          phy-handle = <&pruss_eth0_phy>;
>> +          phy-mode = "mii";
>> +          interrupts = <20 2 2>, <26 6 6>, <23 6 6>;
>> +          interrupt-names = "rx", "emac_ptp_tx",
>> +                                          "hsr_ptp_tx";
>> +          /* Filled in by bootloader */
>> +          local-mac-address = [00 00 00 00 00 00];
>> +        };
>> +
>> +        pruss_emac1: ethernet-port@1 {
>> +          reg = <1>;
>> +          phy-handle = <&pruss_eth1_phy>;
>> +          phy-mode = "mii";
>> +          interrupts = <21 3 3>, <27 9 7>, <24 9 7>;
>> +          interrupt-names = "rx", "emac_ptp_tx",
>> +                                          "hsr_ptp_tx";
>> +          /* Filled in by bootloader */
>> +          local-mac-address = [00 00 00 00 00 00];
>> +        };
>> +      };
>> +    };
>> diff --git a/Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml
>> b/Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml
>> new file mode 100644
>> index 000000000000..42f217099b2e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml
>> @@ -0,0 +1,32 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/ti,pruss-ecap.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments PRU-ICSS Enhanced Capture (eCAP) event module
>> +
>> +maintainers:
>> +  - Murali Karicheri <m-karicheri2@ti.com>
>> +  - Parvathi Pudi <parvathi@couthit.com>
>> +  - Basharath Hussain Khaja <basharath@couthit.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: ti,pruss-ecap
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    pruss2_ecap: ecap@30000 {
>> +        compatible = "ti,pruss-ecap";
>> +        reg = <0x30000 0x60>;
>> +    };
>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> index 927b3200e29e..594f54264a8c 100644
>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> @@ -251,6 +251,15 @@ patternProperties:
>>  
>>      type: object
>>  
>> +  ecap@[a-f0-9]+$:
>> +    description:
>> +      PRU-ICSS has a Enhanced Capture (eCAP) event module which can generate
>> +      and capture periodic timer based events which will be used for features
>> +      like RX Pacing to rise interrupt when the timer event has occurred.
>> +      Each PRU-ICSS instance has one eCAP modeule irrespective of SOCs.
>> +
>> +    type: object
> 
> This should either have a ref to ti,pruss-ecap.yaml or should just move
> reg and compatible here since it is only 2 properties.
> 

We will address this in the next version.

Thanks and Regards,
Parvathi.

