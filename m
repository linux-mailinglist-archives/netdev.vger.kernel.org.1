Return-Path: <netdev+bounces-27346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A08DD77B891
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 14:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB6E28117E
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 12:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A06DBE5B;
	Mon, 14 Aug 2023 12:23:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC1CAD58
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:23:42 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B059F5
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 05:23:40 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RPYSC5DxpzrS3g;
	Mon, 14 Aug 2023 20:22:19 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 14 Aug 2023 20:23:37 +0800
Subject: Re: [PATCH net-next] tun: add __exit annotations to module exit func
 tun_cleanup()
To: Leon Romanovsky <leon@kernel.org>
CC: <willemdebruijn.kernel@gmail.com>, <jasowang@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20230814083000.3893589-1-william.xuanziyang@huawei.com>
 <20230814101707.GG3921@unreal>
 <0b8a2c5f-0d53-f5e5-f148-b333c0c89a14@huawei.com>
 <20230814120515.GH3921@unreal>
From: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <b0cbdac5-9518-225f-a607-90431f36fa2d@huawei.com>
Date: Mon, 14 Aug 2023 20:23:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230814120515.GH3921@unreal>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On Mon, Aug 14, 2023 at 07:27:59PM +0800, Ziyang Xuan (William) wrote:
>>> On Mon, Aug 14, 2023 at 04:30:00PM +0800, Ziyang Xuan wrote:
>>>> Add missing __exit annotations to module exit func tun_cleanup().
>>>>
>>>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
>>>> ---
>>>>  drivers/net/tun.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>>>> index 973b2fc74de3..291c118579a9 100644
>>>> --- a/drivers/net/tun.c
>>>> +++ b/drivers/net/tun.c
>>>> @@ -3740,7 +3740,7 @@ static int __init tun_init(void)
>>>>  	return ret;
>>>>  }
>>>>  
>>>> -static void tun_cleanup(void)
>>>> +static void __exit tun_cleanup(void)
>>>
>>> Why __exit and not __net_exit?
>>
>> tun_cleanup() is a module exit function. it corresponds to tun_init().
>> tun_init() uses __init, so tun_cleanup() uses __exit.
> 
> __net_init is equal to __init.

That is not. They are equal when CONFIG_NET_NS is not enabled.
Refer to the definition of __net_init and __net_eixt in include/net/net_namespace.h.

> 
>>
>> Thank you!
>> William Xuan
>>>
>>> Thanks
>>>
>>>>  {
>>>>  	misc_deregister(&tun_miscdev);
>>>>  	rtnl_link_unregister(&tun_link_ops);
>>>> -- 
>>>> 2.25.1
>>>>
>>>>
>>> .
>>>
> .
> 

