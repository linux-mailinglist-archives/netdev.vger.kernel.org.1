Return-Path: <netdev+bounces-28669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D423E780383
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 03:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E0D281C65
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 01:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE47651;
	Fri, 18 Aug 2023 01:49:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8CB398
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:49:40 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9E42D58
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 18:49:36 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRkcL6K24ztRnv;
	Fri, 18 Aug 2023 09:21:54 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 18 Aug 2023 09:25:32 +0800
Message-ID: <9ed913e1-2e2a-cf8d-4382-d9799e11a072@huawei.com>
Date: Fri, 18 Aug 2023 09:25:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next] net: lan966x: Fix return value check for
 vcap_get_rule()
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux@armlinux.org.uk>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>
References: <20230817123726.1885512-1-ruanjinjie@huawei.com>
 <ZN5oUpbbRWie9676@vergenet.net>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <ZN5oUpbbRWie9676@vergenet.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/18 2:34, Simon Horman wrote:
> On Thu, Aug 17, 2023 at 08:37:26PM +0800, Ruan Jinjie wrote:
>> Since vcap_get_rule() return NULL or ERR_PTR(), just check NULL
>> is not correct. So use IS_ERR_OR_NULL() to fix the issue.
>>
>> Fixes: 72df3489fb10 ("net: lan966x: Add ptp trap rules")
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
>> ---
>>  drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Hi Ruan Jinjie,
> 
> Could we consider updating vcap_get_rule() to always return an ERR_PTR()
> and update the error detection conditions to use IS_ERR()?
> It seems to me that would be somewhat cleaner in this case.

Sure, I'll try to do it. Thank you!

