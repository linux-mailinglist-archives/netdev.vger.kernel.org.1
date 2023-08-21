Return-Path: <netdev+bounces-29195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898FC78210B
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 03:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD8D1C20403
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 01:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EB364B;
	Mon, 21 Aug 2023 01:15:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E51A627
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 01:15:54 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161CA99
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 18:15:53 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RTZFs50G6zNn0V;
	Mon, 21 Aug 2023 09:12:17 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 09:15:50 +0800
Message-ID: <2d12cdb3-e6ef-46d2-3bfb-58b5c54f6ab3@huawei.com>
Date: Mon, 21 Aug 2023 09:15:50 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next v3 2/3] net: bcmgenet: Return PTR_ERR() for
 fixed_phy_register()
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: <rafal@milecki.pl>, <bcm-kernel-feedback-list@broadcom.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <opendmb@gmail.com>, <florian.fainelli@broadcom.com>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>
References: <20230818070707.3670245-1-ruanjinjie@huawei.com>
 <20230818070707.3670245-3-ruanjinjie@huawei.com>
 <ZOD2hylmo1/HgaYO@vergenet.net> <ZOD3nl+dOA39cVg5@vergenet.net>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <ZOD3nl+dOA39cVg5@vergenet.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/20 1:10, Simon Horman wrote:
> On Sat, Aug 19, 2023 at 07:06:15PM +0200, Simon Horman wrote:
>> On Fri, Aug 18, 2023 at 03:07:06PM +0800, Ruan Jinjie wrote:
>>> fixed_phy_register() returns -EPROBE_DEFER, -EINVAL and -EBUSY,
>>> etc, in addition to -ENODEV. The Best practice is to return these
>>> error codes with PTR_ERR().
>>>
>>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
>>> ---
>>> v3:
>>> - Split the return value check into another patch set.
>>> - Update the commit title and message.
>>> ---
>>>  drivers/net/ethernet/broadcom/genet/bcmmii.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
>>> index 0092e46c46f8..4012a141a229 100644
>>> --- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
>>> +++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
>>> @@ -619,7 +619,7 @@ static int bcmgenet_mii_pd_init(struct bcmgenet_priv *priv)
>>>  		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
>>>  		if (!phydev || IS_ERR(phydev)) {
>>>  			dev_err(kdev, "failed to register fixed PHY device\n");
>>> -			return -ENODEV;
>>> +			return PTR_ERR(phydev);
>>
>> Hi Ruan,
>>
>> thanks for your patch.
>>
>> Perhaps I am missing something, but this doesn't seem right to me.
>> In the case where phydev is NULL will return 0.
>> But bcmgenet_mii_pd_init() also returns 0 on success.
>>
>> Perhaps this is better?
>>
>> 		if (!phydev || IS_ERR(phydev)) {
>> 			dev_err(kdev, "failed to register fixed PHY device\n");
>> 			return physdev ? PTR_ERR(phydev) : -ENODEV;
>> 		}
>>
>> I have a similar concern for patch 1/3 of this series.
>> Patch 3/3 seems fine in this regard.
> 
> Sorry for the noise.
> 
> I now see that fixed_phy_register() never returns NULL,
> and that condition is being removed by another patchset [1].
> 
> I'm fine with this, other than that I suspect your two series
> conflict with each other.

Thank you! I'll resend this patch to be consistent.

> 
> [1] https://lore.kernel.org/all/20230818051221.3634844-1-ruanjinjie@huawei.com/
> 

