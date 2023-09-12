Return-Path: <netdev+bounces-33032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E811579C659
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 07:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4206F2815B2
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 05:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B520171A0;
	Tue, 12 Sep 2023 05:56:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF6D17D0
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 05:56:07 +0000 (UTC)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397F3E77;
	Mon, 11 Sep 2023 22:56:07 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38C5tkio071489;
	Tue, 12 Sep 2023 00:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1694498146;
	bh=a+Uh22X5lshfRUaqi9CFJ7sDjLZJjZj20IOqWEOPmeI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=C+esGrfuxGJhhluJjzdnrdRH8Q2tJy4/A7QhCOEkJdl537f9DQKylRDKkIFlUrbo1
	 WAKAnIK7fv3XLwoU6fupqFqGnhWWL1w6QQr01m5cjZvEScMisSbEfkSX7TYwZeN/MD
	 c0Si4DsA+yggAk+KXLaueS3hPnrxG1iBwOX020a8=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38C5tkXL110912
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 Sep 2023 00:55:46 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 00:55:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 00:55:46 -0500
Received: from [10.24.69.199] (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38C5tegb012983;
	Tue, 12 Sep 2023 00:55:41 -0500
Message-ID: <0c23d883-0a79-ee7c-332c-c6580f8691df@ti.com>
Date: Tue, 12 Sep 2023 11:25:40 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: Add documentation for
 Half duplex support.
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@ti.com>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Simon
 Horman <horms@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20230911060200.2164771-1-danishanwar@ti.com>
 <20230911060200.2164771-2-danishanwar@ti.com>
 <20230911164628.GA1295856-robh@kernel.org>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20230911164628.GA1295856-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 11/09/23 22:16, Rob Herring wrote:
> On Mon, Sep 11, 2023 at 11:31:59AM +0530, MD Danish Anwar wrote:
>> In order to support half-duplex operation at 10M and 100M link speeds, the
>> PHY collision detection signal (COL) should be routed to ICSSG
>> GPIO pin (PRGx_PRU0/1_GPI10) so that firmware can detect collision signal
>> and apply the CSMA/CD algorithm applicable for half duplex operation. A DT
>> property, "ti,half-duplex-capable" is introduced for this purpose. If
>> board has PHY COL pin conencted to PRGx_PRU1_GPIO10, this DT property can
>> be added to eth node of ICSSG, MII port to support half duplex operation at
>> that port.
>>
>> Reviewed-by: Roger Quadros <rogerq@kernel.org>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>> index 311c570165f9..bba17d4d5874 100644
>> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>> @@ -106,6 +106,13 @@ properties:
>>                phandle to system controller node and register offset
>>                to ICSSG control register for RGMII transmit delay
>>  
>> +          ti,half-duplex-capable:
>> +            type: boolean
>> +            description:
>> +              Enable half duplex operation on ICSSG MII port. This requires
> 
> Still have capable vs. enable confusion. Please reword the description.
> 

Sure Rob, I will change the description to below.

    description:
      Indicates that the PHY output pin (COL) is routed to ICSSG GPIO
      pin (PRGx_PRU0/1_GPIO10) as input and ICSSG MII port is capable
      of half duplex operations.

Please let me know if this looks OK or if any other change is required.

>> +              PHY output pin (COL) to be routed to ICSSG GPIO pin
>> +              (PRGx_PRU0/1_GPIO10) as input.
>> +
>>          required:
>>            - reg
>>      anyOf:
>> -- 
>> 2.34.1
>>

-- 
Thanks and Regards,
Danish

