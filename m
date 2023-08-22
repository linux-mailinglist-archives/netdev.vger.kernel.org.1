Return-Path: <netdev+bounces-29726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 891EE7847EB
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F94628113C
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 16:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD33B2B555;
	Tue, 22 Aug 2023 16:45:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3FE2B544
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 16:45:44 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1576C184;
	Tue, 22 Aug 2023 09:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1692722727; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=C/EOb3BvhZaR8rIgythUShYp/C2vltmAlAkymEaxVRk9du7Qwyu0xTy/2BYVBfkDus
    I3geGY9BBGt9cSYODCmWLC6VqKGSG09Cu9oDAwZrRFBo6K+UIksJmR9Q5STVntWhEfEs
    Wq97lLTK3+C1f6Fwh1usonjfq9bJ/rLSn7WxmQN6hZd4QOYY9SH1aDgJIe9En/SZZRYH
    FH55uKlJLtIndV5r/vRwy1k2/9Js4YJDvzoVUpVrz81p8ARGAp+Shhoj8Wo7oh7B2By8
    Uw+T54BhM53aPZE9ARR9MYJ0bKBH/0oL6YD8fl8QnrNyPw0TAbZgWebPtP3uZSdRQdHT
    ajBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1692722727;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zPWRPzzQQLhLpRvtyEFFFMqggB8Lc5tzgqANi1wEOV8=;
    b=Z0rsQKx7ah1BApHMhaA30EbWWUa3duXUMMZmf0+XV9fa5xKwxA9HLAEMtCnEM2aaq4
    W1pxZ7h9WyYpbPdsgGRyvf8cCpT08xNJujhpEZeDjAiy9ARgxocUdom1bcgdZ1RvqJCa
    l4h5UzaRadL2DNlq3rkuXNvsPxY1BwngEfFgcpCtwoNdlmHmafrrIvmtpZSoWzXWJEK9
    vF3CBwJqUU4eMOM7hPmZReu6QM7YL4GYhekIgLNi0TrvrrPdbXNeQIfn+BSvAVig0b/U
    +MKB03Ppx1QRh25Xrx84C7GiYqxbhiZGWAZw6wprYAbKctqxVSzsrC63Xp0cu0Qjbm5L
    UcUg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1692722727;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zPWRPzzQQLhLpRvtyEFFFMqggB8Lc5tzgqANi1wEOV8=;
    b=OmV2fY0JF83Y9q60tMR88gYLqH8U7cyxEnIWq32KuL7V8ryBBeXoeJ3WsdRuFUn9SW
    3me4aWUFIn/T9D9BJwxSkQ/p5EMSbF0h4VqgmvTWdrnoxK11c2Sc/Zdanhpddof5FLt/
    Il2046ghSG0RrnQaJK2/rtYj32sVFt6/XqV2iIcdouB7OTDWNTw0PdoKBLC1PAKGg5Ms
    4o2ovqy3OcZWm9y93eD3ccqNrB4e2Z6WdGPtwx7yUlXsjHpNk1bWypFr9CyTonQEQn8k
    GgGGFTabrKM8G7UOwXGLSktZwJDnX9DrDPXqIV0zCphdtiI8cGqurmPTdJBQTaoy8uqY
    nocw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1692722727;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zPWRPzzQQLhLpRvtyEFFFMqggB8Lc5tzgqANi1wEOV8=;
    b=VH9HgBxzNADeNDUdgCSZ4xydmOyxcB8ipkv4sQSZ3Le6UOOpnpE5T8GhGXWkSoQPiG
    D/M46lTrmt+H4/ZgAyDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq1USEbMhpqw=="
Received: from [IPV6:2a00:6020:4a8e:5004::923]
    by smtp.strato.de (RZmta 49.8.1 AUTH)
    with ESMTPSA id K723f1z7MGjQ3hg
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 22 Aug 2023 18:45:26 +0200 (CEST)
Message-ID: <03a97ce3-ee82-5cc0-52cd-2501eeebb240@hartkopp.net>
Date: Tue, 22 Aug 2023 18:45:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [NET 2/2] can: raw: add missing refcount for memory leak fix
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, mkl@pengutronix.de,
 Ziyang Xuan <william.xuanziyang@huawei.com>
References: <20230821144547.6658-1-socketcan@hartkopp.net>
 <20230821144547.6658-3-socketcan@hartkopp.net>
 <20230822075938.GV2711035@kernel.org>
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230822075938.GV2711035@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 22.08.23 09:59, Simon Horman wrote:
> On Mon, Aug 21, 2023 at 04:45:47PM +0200, Oliver Hartkopp wrote:
>> Commit ee8b94c8510c ("can: raw: fix receiver memory leak") introduced
>> a new reference to the CAN netdevice that has assigned CAN filters.
>> But this new ro->dev reference did not maintain its own refcount which
>> lead to another KASAN use-after-free splat found by Eric Dumazet.
>>
>> This patch ensures a proper refcount for the CAN nedevice.
>>
>> Fixes: ee8b94c8510c ("can: raw: fix receiver memory leak")
>> Reported-by: Eric Dumazet <edumazet@google.com>
>> Cc: Ziyang Xuan <william.xuanziyang@huawei.com>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> ...
> 
>> @@ -443,44 +448,56 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>>   		if (!dev) {
>>   			err = -ENODEV;
>>   			goto out;
>>   		}
>>   		if (dev->type != ARPHRD_CAN) {
>> -			dev_put(dev);
>>   			err = -ENODEV;
>> -			goto out;
>> +			goto out_put_dev;
>>   		}
>> +
>>   		if (!(dev->flags & IFF_UP))
>>   			notify_enetdown = 1;
>>   
>>   		ifindex = dev->ifindex;
>>   
>>   		/* filters set by default/setsockopt */
>>   		err = raw_enable_allfilters(sock_net(sk), dev, sk);
>> -		dev_put(dev);
>> +		if (err)
>> +			goto out_put_dev;
>> +
>>   	} else {
>>   		ifindex = 0;
>>   
>>   		/* filters set by default/setsockopt */
>>   		err = raw_enable_allfilters(sock_net(sk), NULL, sk);
>>   	}
>>   
>>   	if (!err) {
>>   		if (ro->bound) {
>>   			/* unregister old filters */
>> -			if (ro->dev)
>> +			if (ro->dev) {
>>   				raw_disable_allfilters(dev_net(ro->dev),
>>   						       ro->dev, sk);
>> -			else
>> +				/* drop reference to old ro->dev */
>> +				netdev_put(ro->dev, &ro->dev_tracker);
>> +			} else {
>>   				raw_disable_allfilters(sock_net(sk), NULL, sk);
>> +			}
>>   		}
>>   		ro->ifindex = ifindex;
>>   		ro->bound = 1;
>> +		/* bind() ok -> hold a reference for new ro->dev */
>>   		ro->dev = dev;
>> +		if (ro->dev)
>> +			netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
>>   	}
>>   
>> - out:
>> +out_put_dev:
>> +	/* remove potential reference from dev_get_by_index() */
>> +	if (dev)
>> +		dev_put(dev);
> 
> Hi Oliver,
> 
> this is possibly not worth a respin, but there is no need to check if dev
> is NULL before calling dev_put(), dev_put() will effectively be a no-op
> with a NULL argument.
> 

Hi Simon,

thanks for your feedback.

In fact I had in mind that someone recently removed some of these "if 
(dev)" statements before "dev_put(dev)" in the netdev subtree.

The reason why I still wanted to point out this check is because of dev 
== NULL is also a valid value for CAN_RAW sockets that are not bound to 
a specific netdev but to 'ALL' CAN netdevs.

So it was more like a documentation purpose than a programming need.

As you don't see a need for a respin too, I can send a patch to can-next 
to remove it, if that fits for you.

Best regards,
Oliver



>> +out:
>>   	release_sock(sk);
>>   	rtnl_unlock();
>>   
>>   	if (notify_enetdown) {
>>   		sk->sk_err = ENETDOWN;
>> -- 
>> 2.39.2
>>
>>
> 

