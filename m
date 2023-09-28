Return-Path: <netdev+bounces-36732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9467B1823
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 12:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 4AAB71C20869
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 10:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963B1347D8;
	Thu, 28 Sep 2023 10:16:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DA98821
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 10:16:23 +0000 (UTC)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D2C122;
	Thu, 28 Sep 2023 03:16:21 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38SAG7dm118169;
	Thu, 28 Sep 2023 05:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1695896167;
	bh=oXfJqYkBnSRsMgAuu0wHSkWa8/uJ4JIwbOSV//aCu9g=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Cu0feTflp8Drj3oJXROZjWP1584/TVeydkttB1NgXtHsTjldVgp+MQZ4nc/O5Mryw
	 a7DsNwMf/JwoZGfC/Eg7q8uE1Q5piu7/ULbBKp68+DnpjWEmi3BqctFwcxR6vsYqWo
	 jqkjAVzfBdEn201kvKKIMC0v/zOm2fII9mhRKGa0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38SAG76f042215
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Sep 2023 05:16:07 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Sep 2023 05:16:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Sep 2023 05:16:06 -0500
Received: from [10.24.69.199] (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38SAG1nT065174;
	Thu, 28 Sep 2023 05:16:02 -0500
Message-ID: <5d27cf14-3df6-1771-9323-c54ede6db587@ti.com>
Date: Thu, 28 Sep 2023 15:46:01 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v2] net: ti: icssg_prueth: add TAPRIO offload
 support
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric
 Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <vladimir.oltean@nxp.com>,
        Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>, Roger Quadros <rogerq@ti.com>
References: <20230921070031.795788-1-danishanwar@ti.com>
 <b3248b40-38a1-47b0-a61d-e81a451fa0a7@kernel.org>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <b3248b40-38a1-47b0-a61d-e81a451fa0a7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 21/09/23 16:12, Roger Quadros wrote:
> Hi Danish,
> 
> On 21/09/2023 10:00, MD Danish Anwar wrote:
> 
> Can you please retain patch authorhsip?
> 
>> ICSSG dual-emac f/w supports Enhanced Scheduled Traffic (EST – defined
>> in P802.1Qbv/D2.2 that later got included in IEEE 802.1Q-2018)
>> configuration. EST allows express queue traffic to be scheduled
>> (placed) on the wire at specific repeatable time intervals. In
>> Linux kernel, EST configuration is done through tc command and
>> the taprio scheduler in the net core implements a software only
>> scheduler (SCH_TAPRIO). If the NIC is capable of EST configuration,
>> user indicate "flag 2" in the command which is then parsed by
>> taprio scheduler in net core and indicate that the command is to
>> be offloaded to h/w. taprio then offloads the command to the
>> driver by calling ndo_setup_tc() ndo ops. This patch implements
>> ndo_setup_tc() to offload EST configuration to ICSSG.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---

[ ... ]

>> +	if (!netif_running(ndev)) {
>> +		netdev_err(ndev, "interface is down, link speed unknown\n");
>> +		return -ENETDOWN;
>> +	}
> 
> Do we really need this?

I don't think this is needed. I will drop this and spin next revision.

-- 
Thanks and Regards,
Danish

