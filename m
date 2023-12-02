Return-Path: <netdev+bounces-53203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FD98019ED
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 03:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAD0281EBA
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 02:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6967A5245;
	Sat,  2 Dec 2023 02:14:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844F51A4
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 18:14:05 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Shtkw4G8XzvR0y;
	Sat,  2 Dec 2023 10:13:28 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 2 Dec 2023 10:14:02 +0800
Message-ID: <61c80195-db33-fa38-6b1f-007f651eebe2@huawei.com>
Date: Sat, 2 Dec 2023 10:14:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net,v2] ipvlan: implement .parse_protocol hook function in
 ipvlan_header_ops
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	<netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <luwei32@huawei.com>, <fw@strlen.de>, <maheshb@google.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20231201025528.2216489-1-shaozhengchao@huawei.com>
 <81b8bca0-6c61-966a-bac8-fecb0ad60f57@huawei.com>
 <6569fa1a427c0_1396ec2945e@willemb.c.googlers.com.notmuch>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <6569fa1a427c0_1396ec2945e@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected



On 2023/12/1 23:22, Willem de Bruijn wrote:
> shaozhengchao wrote:
>>
>>
>> On 2023/12/1 10:55, Zhengchao Shao wrote:
>>> The .parse_protocol hook function in the ipvlan_header_ops structure is
>>> not implemented. As a result, when the AF_PACKET family is used to send
>>> packets, skb->protocol will be set to 0.
>>> Ipvlan is a device of type ARPHRD_ETHER (ether_setup). Therefore, use
>>> eth_header_parse_protocol function to obtain the protocol.
>>>
>>> Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
>>
>> Maybe Fixes should be: 75c65772c3d1 ("net/packet: Ask driver for
>> protocol if not provided by user")
> 
Hi Willem:
> Definitely not anything older than the introduction of
> header_ops.parse_protocol.
> 
    Yes, I think so.
> I gave my +1 when it targeted net-next, so imho this is not really
> stable material anyhow.
   But, if skb->protocol = 0, no matter what type of packet it is, it
will be discarded directly in ipvlan_process_outbound().
So net branch will be OK? What I missed?
Thanks.

Zhengchao Shao



