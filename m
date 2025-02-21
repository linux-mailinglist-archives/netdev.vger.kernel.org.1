Return-Path: <netdev+bounces-168542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD91A3F46C
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 13:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD02A189FA9B
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452A020ADC9;
	Fri, 21 Feb 2025 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="q8Fu59eo"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD0E1FFC5E;
	Fri, 21 Feb 2025 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740141175; cv=none; b=gG4CmYOO8eyYZffnoh/srr+vDLlB0FvLgOLBsBLQc0+ys0q94qlcbHYZDTxnOyVGERch3TOscD78lvwLE2vWAdgnhRT2YVlhuOAzdL1+0xNag9j6+uD2xVnZ6PlR8sqXO1vZwDPieHUTvYmoROWe/wtSCKdRCfPTGH+qL/5bvJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740141175; c=relaxed/simple;
	bh=UvuNzrjWzUCNXqNxslrELogG9BuyJy742ODapOuk9M8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=srN9LOuptak/3jKtHNQJ7wGWLOcArmJE0nyykua/gnCJeVqk1G/E4N2bO6P8tMA3Bzs+h7KIN6y0m4XOXgY1y6c4/Nxb6gHqfj+1u0UqdhOa1Ak2PJu/WEHSSLVqm2ZDlDNFN+rA7gnyo1hFLkxJ3IbbivQvZIk2qD6c4ZKgxNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=q8Fu59eo; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EePyCqMIhGKqIC1G3UvKUVRy6wdzao/mm6Xcy0Z4PeM=; b=q8Fu59eoITJ4uwVAHCv+k4jSk+
	2uQj7IaWVfvVk5alcCSqyuvyE1eXqZifmZKnMomhSIMwj0w0jUeNztLwllN2z8mxbPSMeaQeisSNG
	DnSYr3hqgQaRw1xSilPXAxPXZKSalyO7zeb3O71lzfZN0UjStGCp9vdhCPera5rF11P1zIDfuzwfR
	qTYKMIRPJTIA5TtNXT2jXD4nXmmkRdqOtjCTE7BX+3YHchuMm1XGzVoFUu0N57YIrjXHEhS8t/Zao
	9e7NG7xRF3YIZhNpJEVwgxvxhWgD4v1MwjKTPrFa7bdRDm5kCSUkoA80WloMkplmvjkzSRMTLXGvl
	gtGqpCyg==;
Received: from [122.175.9.182] (port=49585 helo=zimbra.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parvathi@couthit.com>)
	id 1tlSCu-0002Su-1z;
	Fri, 21 Feb 2025 18:02:41 +0530
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 2EA9B178215A;
	Fri, 21 Feb 2025 18:02:33 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 0A48A178247D;
	Fri, 21 Feb 2025 18:02:33 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id M0wu_t15pFmA; Fri, 21 Feb 2025 18:02:32 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id C198D178215A;
	Fri, 21 Feb 2025 18:02:32 +0530 (IST)
Date: Fri, 21 Feb 2025 18:02:32 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: robh <robh@kernel.org>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>, 
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>, 
	nm <nm@ti.com>, ssantosh <ssantosh@kernel.org>, 
	richardcochran <richardcochran@gmail.com>, 
	basharath <basharath@couthit.com>, schnelle <schnelle@linux.ibm.com>, 
	diogo ivo <diogo.ivo@siemens.com>, 
	m-karicheri2 <m-karicheri2@ti.com>, horms <horms@kernel.org>, 
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
Message-ID: <1240320242.634119.1740141152414.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250219225130.GA3107198-robh@kernel.org>
References: <20250214054702.1073139-1-parvathi@couthit.com> <20250214054702.1073139-2-parvathi@couthit.com> <20250219225130.GA3107198-robh@kernel.org>
Subject: Re: [PATCH net-next v3 01/10] dt-bindings: net: ti: Adds DUAL-EMAC
 mode support on PRU-ICSS2 for AM57xx SOCs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF113 (Linux)/8.8.15_GA_3968)
Thread-Topic: dt-bindings: net: ti: Adds DUAL-EMAC mode support on PRU-ICSS2 for AM57xx SOCs
Thread-Index: /oo/U1rbh8omFI7E9oVZggUetPMfQw==
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

> On Fri, Feb 14, 2025 at 11:16:53AM +0530, parvathi wrote:
>> From: Parvathi Pudi <parvathi@couthit.com>
>> 
>> Documentation update for the newly added "pruss2_eth" device tree
>> node and its dependencies along with compatibility for PRU-ICSS
>> Industrial Ethernet Peripheral (IEP), PRU-ICSS Enhanced Capture
>> (eCAP) peripheral and using YAML binding document for AM57xx SoCs.
>> 
>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
>> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
> 
> The sender of the patch S-o-b goes last. And maybe you want a
> Co-developed-by tag here too?
> 

Yes, you are correct. We will address this in the next version.

>> ---
>>  .../devicetree/bindings/net/ti,icss-iep.yaml  |   4 +-
>>  .../bindings/net/ti,icssm-prueth.yaml         | 147 ++++++++++++++++++
>>  .../bindings/net/ti,pruss-ecap.yaml           |  32 ++++
>>  .../devicetree/bindings/soc/ti/ti,pruss.yaml  |   9 ++
>>  4 files changed, 191 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
>>  create mode 100644 Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>> b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>> index e36e3a622904..858d74638167 100644
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
>> @@ -19,7 +21,7 @@ properties:
>>            - const: ti,am654-icss-iep
>>  
>>        - const: ti,am654-icss-iep
>> -
>> +      - const: ti,am5728-icss-iep
> 
> Use enum adding to the prior entry.
> 

We will check whether we can use "enum" for 2 consts and address
this in the next version.

>>  
>>    reg:
>>      maxItems: 1
>> diff --git a/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
>> b/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
>> new file mode 100644
>> index 000000000000..1dffa6bd7a88
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
>> @@ -0,0 +1,147 @@
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

We did verified and all the labels were appropriately used,
could you point us to the exact label you are referring to.


Thanks and Regards,
Parvathi.



