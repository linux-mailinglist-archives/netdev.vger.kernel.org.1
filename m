Return-Path: <netdev+bounces-26244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D8B7774F1
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 11:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148A61C21446
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8EB1EA98;
	Thu, 10 Aug 2023 09:53:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0F1E52C
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:53:42 +0000 (UTC)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B33110CF;
	Thu, 10 Aug 2023 02:53:41 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37A9rIxN072696;
	Thu, 10 Aug 2023 04:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1691661198;
	bh=jKsz+QezJgKkJLCN1kbDV84OpiUUPkN/WbTbkJt1HdY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=xUm5EL9LUwZFMYXKAEvp6+dtJWq+cUyu58mA4Nzl7c0xNoKd0FwuXZ85/kXCag7I0
	 JP0bty0+TFU0DZhdLK0t6o1Pi5JLA+vqKea6mElYLh9Qp3Tb0ygQY7q0LWqBORc6av
	 syLGxXF+ZFJkiKm3XP9tg2KeATyTIGlw/wOnDKak=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37A9rIrZ028007
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Aug 2023 04:53:18 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 04:53:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 04:53:18 -0500
Received: from [172.24.227.217] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37A9rBvY110323;
	Thu, 10 Aug 2023 04:53:12 -0500
Message-ID: <0b619ec5-9a86-a449-e8db-b12cca115b93@ti.com>
Date: Thu, 10 Aug 2023 15:23:11 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [EXTERNAL] Re: [PATCH v3 1/5] dt-bindings: net: Add ICSS IEP
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, MD Danish Anwar <danishanwar@ti.com>
CC: Randy Dunlap <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230809114906.21866-1-danishanwar@ti.com>
 <20230809114906.21866-2-danishanwar@ti.com>
 <20230809-cardboard-falsify-6cc9c09d8577@spud>
From: Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <20230809-cardboard-falsify-6cc9c09d8577@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Conor,

On 10/08/23 3:07 am, Conor Dooley wrote:
> Hey,
> 
> On Wed, Aug 09, 2023 at 05:19:02PM +0530, MD Danish Anwar wrote:
>> Add DT binding documentation for ICSS IEP module.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  .../devicetree/bindings/net/ti,icss-iep.yaml  | 37 +++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>> new file mode 100644
>> index 000000000000..adae240cfd53
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>> @@ -0,0 +1,37 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/ti,icss-iep.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments ICSS Industrial Ethernet Peripheral (IEP) module
> 
> Does the module here refer to the hw component or to the linux kernel
> module?
> 

The module here refers to the hardware component.

>> +
>> +maintainers:
>> +  - Md Danish Anwar <danishanwar@ti.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,am654-icss-iep   # for all TI K3 SoCs
> 
> *sigh* Please at least give me a chance to reply to the conversation on
> the previous versions of the series before sending more, that's the
> second time with this series :/

My bad, I should have waited for your response. I will hold on posting next
version until your response is received.

> Right now this looks worse to me than what we started with given the
> comment is even broader. I have not changed my mind re: what I said on
> the previous version.
> 

OK, so in the previous version [1] your reply was to have specific compatibles
as bindings with "ti-am654-icss-iep" as a fall back. I will go with this only.

Does the below looks good to you? Here "ti,am642-icss-iep" and
"ti,j721e-icss-iep" are different compatibles for different SoCs where as
"ti,am654-icss-iep" is the fall back. Compatible "ti,am654-icss-iep" will go in
the driver.

properties:
  compatible:
    oneOf:
      - items:
          - enum:
              - ti,am642-icss-iep
              - ti,j721e-icss-iep
          - const: ti,am654-icss-iep

      - items:
          - const: ti,am654-icss-iep

examples:
  - |

    /* AM65x */
    icssg0_iep0: iep@2e000 {
        compatible = "ti,am654-icss-iep";
        reg = <0x2e000 0x1000>;
        clocks = <&icssg0_iepclk_mux>;
    };

    /* J721E */
    icssg0_iep0: iep@2f000 {
        compatible = "ti,j721e-icss-iep","ti,am654-icss-iep";
        reg = <0x2e000 0x1000>;
        clocks = <&icssg0_iepclk_mux>;
    };


    /* AM64x */
    icssg0_iep0: iep@2b000 {
        compatible = "ti,am642-icss-iep", "ti,am654-icss-iep";
        reg = <0x2e000 0x1000>;
        clocks = <&icssg0_iepclk_mux>;
    };


Please let me know if the compatible property and the example looks OK to you.
Also please let me know if some other change is required. I will send next
revision after your confirmation.

> Thanks,
> Conor.
> 
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description: phandle to the IEP source clock
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    icssg0_iep0: iep@2e000 {
>> +        compatible = "ti,am654-icss-iep";
>> +        reg = <0x2e000 0x1000>;
>> +        clocks = <&icssg0_iepclk_mux>;
>> +    };
>> -- 
>> 2.34.1
>>

[1] https://lore.kernel.org/all/20230808-nutmeg-mashing-543b41e56aa1@spud/

-- 
Thanks and Regards,
Danish.

