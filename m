Return-Path: <netdev+bounces-27330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EC177B792
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 13:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6D428118B
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 11:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10ADBA3F;
	Mon, 14 Aug 2023 11:28:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DFD23D0
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 11:28:07 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF26127
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 04:28:02 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RPXD26wGDz1GDZL;
	Mon, 14 Aug 2023 19:26:42 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 14 Aug 2023 19:28:00 +0800
Subject: Re: [PATCH net-next] tun: add __exit annotations to module exit func
 tun_cleanup()
To: Leon Romanovsky <leon@kernel.org>
CC: <willemdebruijn.kernel@gmail.com>, <jasowang@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20230814083000.3893589-1-william.xuanziyang@huawei.com>
 <20230814101707.GG3921@unreal>
From: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <0b8a2c5f-0d53-f5e5-f148-b333c0c89a14@huawei.com>
Date: Mon, 14 Aug 2023 19:27:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230814101707.GG3921@unreal>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On Mon, Aug 14, 2023 at 04:30:00PM +0800, Ziyang Xuan wrote:
>> Add missing __exit annotations to module exit func tun_cleanup().
>>
>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
>> ---
>>  drivers/net/tun.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 973b2fc74de3..291c118579a9 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -3740,7 +3740,7 @@ static int __init tun_init(void)
>>  	return ret;
>>  }
>>  
>> -static void tun_cleanup(void)
>> +static void __exit tun_cleanup(void)
> 
> Why __exit and not __net_exit?

tun_cleanup() is a module exit function. it corresponds to tun_init().
tun_init() uses __init, so tun_cleanup() uses __exit.

Thank you!
William Xuan
> 
> Thanks
> 
>>  {
>>  	misc_deregister(&tun_miscdev);
>>  	rtnl_link_unregister(&tun_link_ops);
>> -- 
>> 2.25.1
>>
>>
> .
> 

