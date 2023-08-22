Return-Path: <netdev+bounces-29576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CD7783D6F
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 11:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621001C20A85
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C889444;
	Tue, 22 Aug 2023 09:59:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96378F55
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 09:59:42 +0000 (UTC)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0151A1;
	Tue, 22 Aug 2023 02:59:40 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37M9xDx5043179;
	Tue, 22 Aug 2023 04:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1692698353;
	bh=QRzPf/FcKrblgEfblvA0zxjSS4jdhnqJtDgCZxVhdvc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=wPy3RnLWPKDtwlY+KLT5zzVfDudmgJ6MFHlbSly0sSKlvy6Aeipht47cq/Hn+aZFW
	 px1CyPldEfOnYBtVJkELFW2K+yrZ4l4NdP9yYOxbXjtPGiEfZVgmP7MfOHKP9WH+j4
	 4Qip8UMiIKahiqL5keGrucQSQqkQpnaaurtgW1n8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37M9xDSZ112183
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Aug 2023 04:59:13 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 04:59:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 04:59:13 -0500
Received: from [172.24.227.217] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37M9x6j8038709;
	Tue, 22 Aug 2023 04:59:07 -0500
Message-ID: <81330882-e8bc-558c-f1bf-9a10108973af@ti.com>
Date: Tue, 22 Aug 2023 15:29:06 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [EXTERNAL] Re: [PATCH v2 2/5] dt-bindings: net: Add iep property
 in ICSSG dt binding
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, MD Danish Anwar <danishanwar@ti.com>
CC: Randy Dunlap <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230807110048.2611456-1-danishanwar@ti.com>
 <20230807110048.2611456-3-danishanwar@ti.com>
 <20230821160120.GA1734560-robh@kernel.org>
From: Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <20230821160120.GA1734560-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Rob,

On 21/08/23 9:31 pm, Rob Herring wrote:
> On Mon, Aug 07, 2023 at 04:30:45PM +0530, MD Danish Anwar wrote:
>> Add iep node in ICSSG driver dt binding document.
> 
> Why?
> 
> Bindings are for h/w, not drivers. You are adding a property, not a 

I will change the above to "Add IEP property in ICSSG hardware DT binding
document."

> node. Would be nice to know what 'iep' is without having to look at the 
> diff (e.g. when running 'git log').
> 

Sure, I will provide description of IEP in the commit message.

>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>> index 8ec30b3eb760..36870238f92f 100644
>> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>> @@ -52,6 +52,12 @@ properties:
>>      description:
>>        phandle to MII_RT module's syscon regmap
>>  
>> +  ti,iep:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> phandle-array really means matrix, so you need to fully describe the 
> items constraints.
> 
>> +    maxItems: 2
> 
> 2 phandles or 1 phandle and 1 arg? Looks like the former from the 

It's 2 phandles.

> example, so:
> 
> maxItems: 2
> items:
>   maxItems: 1
> 

Sure, I will change the item constraints to above.

>> +    description:
>> +      phandle to IEP (Industrial Ethernet Peripheral) for ICSSG driver
>> +
>>    interrupts:
>>      maxItems: 2
>>      description:
>> @@ -155,6 +161,7 @@ examples:
>>                      "tx1-0", "tx1-1", "tx1-2", "tx1-3",
>>                      "rx0", "rx1";
>>          ti,mii-g-rt = <&icssg2_mii_g_rt>;
>> +        ti,iep = <&icssg2_iep0>, <&icssg2_iep1>;
>>          interrupt-parent = <&icssg2_intc>;
>>          interrupts = <24 0 2>, <25 1 3>;
>>          interrupt-names = "tx_ts0", "tx_ts1";
>> -- 
>> 2.34.1
>>

-- 
Thanks and Regards,
Danish.

