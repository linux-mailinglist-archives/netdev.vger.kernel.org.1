Return-Path: <netdev+bounces-32014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111B3792113
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 10:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4221C208FA
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 08:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2163C46B0;
	Tue,  5 Sep 2023 08:38:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145101FA4
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 08:38:06 +0000 (UTC)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233FECC7;
	Tue,  5 Sep 2023 01:38:06 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3858btVg033569;
	Tue, 5 Sep 2023 03:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1693903076;
	bh=3WVgG6BMp/zwJvv4wo1Z0C7SZxs1AezUj/xUd/fKN/A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=WPd62J44Z+/CQLoig0RFiF9f3DHXTKQ1+PjYfmmfFsd4TYQJaw/ElX9D0Dx1NEYP8
	 VbEbdigxCP8zRurDOTKZ0I/dBTeQ3IfMH/oRn7+6JghdccRg9RcK6PjmYfOLTPtK7B
	 iBH59/BYLWx08qkjJuYX1P9AO4MDsSyFbwWJKAm4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3858bt6M114883
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 5 Sep 2023 03:37:55 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Sep 2023 03:37:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Sep 2023 03:37:55 -0500
Received: from [10.24.69.199] (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3858bnn7009695;
	Tue, 5 Sep 2023 03:37:50 -0500
Message-ID: <7d957d85-b32e-c2b9-11df-4f0f86a5dc8c@ti.com>
Date: Tue, 5 Sep 2023 14:07:49 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH net-next 4/4] net: ti: icssg_prueth: add TAPRIO
 offload support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Simon Horman <horms@kernel.org>, Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>
References: <20230830110847.1219515-1-danishanwar@ti.com>
 <20230830110847.1219515-5-danishanwar@ti.com>
 <cc1fcb9a-7337-4e78-bef7-c46c9bd383c4@lunn.ch>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <cc1fcb9a-7337-4e78-bef7-c46c9bd383c4@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 04/09/23 19:42, Andrew Lunn wrote:
>> +void icssg_qos_init(struct net_device *ndev)
>> +{
>> +	icssg_qos_tas_init(ndev);
>> +
>> +	/* IET init goes here */
>> +}
> 
> This sees like a TODO?
> 
>      Andrew

It's actually a TODO only. IET support will come in later patches. I
will drop this comment from here.

-- 
Thanks and Regards,
Danish

