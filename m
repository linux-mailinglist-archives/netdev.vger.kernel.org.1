Return-Path: <netdev+bounces-25679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 661F1775220
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 07:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801971C210B4
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 05:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEF1ED4;
	Wed,  9 Aug 2023 05:01:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19D263B
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 05:01:38 +0000 (UTC)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709451BCD;
	Tue,  8 Aug 2023 22:01:37 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37951JFO073982;
	Wed, 9 Aug 2023 00:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1691557279;
	bh=hq3RQZXLYmWWvDlDoVDQpmyKzIqAMwQGVTTQsrCV9Kk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=EyEv1viDgoZu1e0uXzSXjJ6OouhPW4+scy2s/x9DBDCb4hUbMmqteRtaAs/5A88vU
	 nYeTt2jZAKQQpQuvzvmfURDUg4Ut8mHxfQ34udJ4V9fTAlVnZTuBZAV7sOICHu0HeL
	 V0taD81L0FOsYSrFYUu+NBUojVRAqSWww3koXwg4=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37951JCn015515
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Aug 2023 00:01:19 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 00:01:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 00:01:19 -0500
Received: from [172.24.227.217] (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37951C7O015572;
	Wed, 9 Aug 2023 00:01:12 -0500
Message-ID: <1182349e-3531-c3b2-e457-4aad2595fa71@ti.com>
Date: Wed, 9 Aug 2023 10:31:11 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/5] Introduce IEP driver and packet timestamping
 support
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
CC: Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Simon Horman
	<simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Andrew
 Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230807110048.2611456-1-danishanwar@ti.com>
 <20230808-unnerving-press-7b61f9c521dc@spud>
 <1c8e5369-648e-98cb-cb14-08d700a38283@ti.com>
 <529218f6-2871-79a2-42bb-8f7886ae12c3@kernel.org>
 <8bb5a1eb-3912-c418-88fe-b3d8870e7157@ti.com>
 <20230808-nutmeg-mashing-543b41e56aa1@spud>
From: Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <20230808-nutmeg-mashing-543b41e56aa1@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/08/23 6:15 pm, Conor Dooley wrote:
> On Tue, Aug 08, 2023 at 06:06:11PM +0530, Md Danish Anwar wrote:
>> On 08/08/23 5:52 pm, Roger Quadros wrote:
>>>
>>>
>>> On 08/08/2023 15:18, Md Danish Anwar wrote:
>>>> On 08/08/23 5:38 pm, Conor Dooley wrote:
>>>>> On Mon, Aug 07, 2023 at 04:30:43PM +0530, MD Danish Anwar wrote:
>>>>>> This series introduces Industrial Ethernet Peripheral (IEP) driver to
>>>>>> support timestamping of ethernet packets and thus support PTP and PPS
>>>>>> for PRU ICSSG ethernet ports.
>>>>>>
>>>>>> This series also adds 10M full duplex support for ICSSG ethernet driver.
>>>>>>
>>>>>> There are two IEP instances. IEP0 is used for packet timestamping while IEP1
>>>>>> is used for 10M full duplex support.
>>>>>>
>>>>>> This is v2 of the series [v1]. It addresses comments made on [v1].
>>>>>> This series is based on linux-next(#next-20230807). 
>>>>>>
>>>>>> Changes from v1 to v2:
>>>>>> *) Addressed Simon's comment to fix reverse xmas tree declaration. Some APIs
>>>>>>    in patch 3 and 4 were not following reverse xmas tree variable declaration.
>>>>>>    Fixed it in this version.
>>>>>> *) Addressed Conor's comments and removed unsupported SoCs from compatible
>>>>>>    comment in patch 1. 
>>>>>
>>>>> I'm sorry I missed responding there before you sent v2, it was a bank
>>>>> holiday yesterday. I'm curious why you removed them, rather than just
>>>>> added them with a fallback to the ti,am654-icss-iep compatible, given
>>>>> your comment that "the same compatible currently works for all these
>>>>> 3 SoCs".
>>>>
>>>> I removed them as currently the driver is being upstreamed only for AM654x,
>>>> once I start up-streaming the ICSSG driver for AM64 and any other SoC. I will
>>>> add them here. If at that time we are still using same compatible, then I will
>>>> modify the comment otherwise add new compatible.
>>>>
>>>> As of now, I don't see the need of adding other SoCs in iep binding as IEP
>>>> driver up-streaming is only planned for AM654x as of now.
>>>
>>> But, is there any difference in IEP hardware/driver for the other SoCs?
>>> AFAIK the same IP is used on all SoCs.
>>>
>>> If there is no hardware/code change then we don't need to introduce a new compatible.
>>> The comment for all SoCs can already be there right from the start.
>>>
>>
>> There is no code change. The same compatible is used for other SoCs. Even if
>> the code is same I was thinking to keep the compatible as below now
>>
>> - ti,am654-icss-iep   # for K3 AM65x SoCs
>>
>> and once other SoCs are introduced, I will just modify the comment,
>>
>> - ti,am654-icss-iep   # for K3 AM65x, AM64x SoCs
>>
>> But we can also keep the all SoCs in comment right from start as well. I am
>> fine with both.
> 
>> Conor / Roger, Please let me know which approach should I go with in next revision?
> 
> IMO, "ti,am564-icss-iep" goes in the driver and the other SoCs get
> specific compatibles in the binding with "ti,am564-icss-iep" as a
> fallback.

Sure. Then as for now, "ti,am654-icss-iep" goes in the driver, I will keep the
dt binding compatible as below (as it was earlier in v1.)

- ti,am654-icss-iep   # for K3 AM65x, J721E and AM64x SoCs

When new SoCs are introduced I can add specific bindings for them with
"ti,am654-icss-iep" being the fallback.

-- 
Thanks and Regards,
Danish.

