Return-Path: <netdev+bounces-42272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8A47CE006
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382FB281D23
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 14:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97B837C8D;
	Wed, 18 Oct 2023 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zL42P2ZK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DB037C91
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 14:35:48 +0000 (UTC)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E65E211C;
	Wed, 18 Oct 2023 07:35:45 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39IEZXD0061599;
	Wed, 18 Oct 2023 09:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1697639733;
	bh=ECB/V74fiNhXNNHP1fR3P6TDHR1qoK55G/ZoAJHPOL4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=zL42P2ZKsACaRKdwpl1RTqSRAJDgzwjp35HJWNKq7Mdc+UxrjqsBemSVJfjqZ6Qu+
	 tmlbuKMLvDmLNu0hZ7dlS7YUpwH0R8xWIMRgRTPMH4Y55pxQkm0sDlcHEZ/5Yw1EQ3
	 LKFaw4dRva3cQqGZOl9q4oBMijdcz44YIvBzQFhM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39IEZXLU109134
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Oct 2023 09:35:33 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 09:35:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 09:35:33 -0500
Received: from [10.249.135.225] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39IEZSMM005472;
	Wed, 18 Oct 2023 09:35:29 -0500
Message-ID: <80240b87-4257-9ff4-e24c-5b9211f2dc2b@ti.com>
Date: Wed, 18 Oct 2023 20:05:28 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [EXTERNAL] Re: [PATCH net v2] net: ti: icssg-prueth: Fix r30 CMDs
 bitmasks
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: MD Danish Anwar <danishanwar@ti.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20231016161525.1695795-1-danishanwar@ti.com>
 <11109e7d-139b-4c8c-beaa-e1e89e355b1b@lunn.ch>
 <d7e56794-8061-bf18-bb6f-7525588546fc@ti.com>
 <a322d1c2-d79a-4b55-92f6-2b98c1f2266e@lunn.ch>
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <a322d1c2-d79a-4b55-92f6-2b98c1f2266e@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/17/2023 12:09 AM, Andrew Lunn wrote:
>>> How many different versions of REL.PRU-ICSS-ETHERNET-SWITCH have been
>>> released? They don't appear to be part of linux-firmware.git :-(
>>>
>>
>> The firmwares are currently not posted to linux-firmware.git. They are
>> maintained internally as of now. Different version of firmware is
>> released for every SDK release (3-4 times a year)
> 
> Clearly, mainline works differently. Ideally you do want to get the
> firmware in linux-firmware.git. The kernel and firmware are then more
> likely to by upgraded at the same time. However, you should not assume

Definitely, we are having discussions on this and soon we'll start
pushing the ICSSG firmware to  linux-firmware.git. Till then, we will
maintain firmware internally only.

> so. Maybe in mainline you can then support the last 4 firmware
> versions, and issue an error if a version older than that is found.
> 
> However, until the firmware is easily available via linux-firmware,
> you probably should be backwards compatible for a longer period.
> 

I understand that. I had discussion with the firmware team and this is
actually not breaking backwards compatibility.

The commands EMAC_PORT_DISABLE and EMAC_PORT_FORWARDING are actually
wrong in the driver.

Firmware is using below bitmasks since the beginning and they were wrong
in the driver. This patch actually fixes this.
{{0xffff0004, 0xffff0100, 0xffff0004, EMAC_NONE}},/* EMAC_PORT_DISABLE */

{{0xffbb0000, 0xfcff0000, 0xdcfb0000, EMAC_NONE}},/* EMAC_PORT_FORWARD */

I tested this patch with older firmware (Version
REL.PRU-ICSS-ETHERNET-SWITCH_02.02.12.04) as well as newer firmware
(Version REL.PRU-ICSS-ETHERNET-SWITCH_02.02.12.05). With this patch both
EMAC_PORT_DISABLE and EMAC_PORT_FORWARD commands are working with both
older and newer firmwares.

Apologies for wrong commit message. I will send next version with proper
commit message mentioning that this patch is backwards compatible

> 	Andrew

-- 
Thanks and Regards,
Md Danish Anwar

