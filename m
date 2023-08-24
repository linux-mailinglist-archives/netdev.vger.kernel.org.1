Return-Path: <netdev+bounces-30226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8557867D0
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 08:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068F628145A
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 06:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1844C24549;
	Thu, 24 Aug 2023 06:51:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA1124547
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:51:47 +0000 (UTC)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2B819AD;
	Wed, 23 Aug 2023 23:51:40 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37O6pNSE037502;
	Thu, 24 Aug 2023 01:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1692859883;
	bh=OE525KZQt1ky538U0HtwV700QFN+74ZjsJBYgXA/OXM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=jcr2RpaoeXlX4pnLa0eM7b2AIUDxvK4Rq5BTiHePF70tpYWsRgbdXg3zrq5uVL/ms
	 fiv6psc4B5d6GU1j/eej+ytDpP3RgrnhpK8g2dhXQn661+PebzoJBg9edUGdiibWP5
	 AaVqQTIItAkSKOeC38fTeFGqpy2W7V9zoJ/JVoqk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37O6pN6G068087
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 24 Aug 2023 01:51:23 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 01:51:22 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 01:51:22 -0500
Received: from [172.24.227.35] (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37O6pFcQ092382;
	Thu, 24 Aug 2023 01:51:16 -0500
Message-ID: <78d315b9-f8b1-0012-ceb9-5c3c5034c7dc@ti.com>
Date: Thu, 24 Aug 2023 12:21:14 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [EXTERNAL] Re: [PATCH v6 2/5] dt-bindings: net: Add IEP property
 in ICSSG
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        MD Danish Anwar
	<danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros
	<rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>,
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
	<davem@davemloft.net>
CC: <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20230823113254.292603-1-danishanwar@ti.com>
 <20230823113254.292603-3-danishanwar@ti.com>
 <1326776f-2592-f231-2056-a231729da50a@linaro.org>
From: Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <1326776f-2592-f231-2056-a231729da50a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 24/08/23 12:15 pm, Krzysztof Kozlowski wrote:
> On 23/08/2023 13:32, MD Danish Anwar wrote:
>> Add IEP property in ICSSG hardware DT binding document.
>> ICSSG uses IEP (Industrial Ethernet Peripheral) to support timestamping
>> of ethernet packets, PTP and PPS.
>>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Where? Please provide link.
> 

https://lore.kernel.org/all/20230814-quarters-cahoots-1fbd583baad9@spud/

>> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> 
> Where? Please provide link.

https://lore.kernel.org/all/5d077342-435f-2829-ba2a-cdf763b6b8e1@kernel.org/

> 
>> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Where? Please provide link.

https://lore.kernel.org/all/ZN9aSTUOT+SKESQS@vergenet.net/

> 
> Otherwise all of them look like fake ways to sneak patches into the
> kernel. Our work here depends a lot on the trust. Trust once lost, is
> tricky to get back.
> 

It's not fake. They provided they RB tags, after that while preparing next
revision I use b4 to get all the tags and apply to applicable patches. I know
trust is important and I won't do such things like faking tags. They gave their
tags in v4 and v5, you must have missed those probably.

>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
> 
> 
> Best regards,
> Krzysztof
> 

-- 
Thanks and Regards,
Danish.

