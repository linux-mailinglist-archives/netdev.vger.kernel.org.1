Return-Path: <netdev+bounces-62908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71084829C03
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 15:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C4A1C20F53
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 14:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211464A989;
	Wed, 10 Jan 2024 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cGn5hySv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387004A988
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2a360dbc11so425305266b.2
        for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 06:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704895724; x=1705500524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N3rrOmqcG+xVfylnePeJUvWyZpyPNkcgzwM5vr3t9Xk=;
        b=cGn5hySvf0+Nqh6MPe6va24G5aaaUIXak8WH2QVjkg/kiLoOv+whOIGe5vRjlzyD0S
         8cNqv4ZSCRY5n94EiKaXJY6mpbXiFTEJxkNkiRh6S3JmDT1zpufsneZMex+3Emn8MRB8
         d778U89ZV8J5XTWICBizvT3hjV9xGfl+wSduMedGq3T0YourDJnXNEYUoH8lD7dEnxrw
         Id6MrOs1Cyj2qkUCVacPTHpVZPpJ/oO/BpT/GCoFVFldSGoOA/ZWF7igwn97unTMurVS
         LaAFgZ1JgLy4FoUJBJEDcA65aldlxnj47DVY4xUIWO9vh5/sNsuwUYCnphY1Ukl6q4Kh
         KLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704895724; x=1705500524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3rrOmqcG+xVfylnePeJUvWyZpyPNkcgzwM5vr3t9Xk=;
        b=T69oNY4SKtKB0kjo/I5+0EvTlfHRZNi8rRaSZvkHj86I7lWRZKWu7RmBOaBYmZfHIu
         0lLLgi03D9r5chcNcDoSysglnxCQIWJuwuib+2DOUDsWHSDWT0BEQnI/Okcgoo0AqlXo
         cNWD8g2ilqhJpPzTaT+IGY8quEHDD6O/QjvgVaCRThXKjNeGlAIdhDkaXjSgXaoSl2+3
         z5EFI8CW2+pIhWv9nD+8pMbHTOk/hBH7Y/Cupx0T/yeFTDkStXk8hVJsSsTuGSYH0F0z
         /fQHzwLyF9rxPZFl3Py4WP8o39qg7qryMMoOF6DhkZSwFGsNNN95pWgxr0tGxJU7qUUl
         smeA==
X-Gm-Message-State: AOJu0YxXhEQgLhUvWQjOBNW3IGhJOm6wsJ9415SjlDQB8y868sG9W60O
	PP6+y4t4Bv30JQCHTzQhVTHr4B4RcxeUqw==
X-Google-Smtp-Source: AGHT+IE7omyZ3rLPXQmUqE8tYSKgT+5FGUusKqsz5iTBa7Rab9KZGR5mFI6tZs6GElb16RVNSBjXyg==
X-Received: by 2002:a17:906:7d07:b0:a28:fab0:9004 with SMTP id u7-20020a1709067d0700b00a28fab09004mr633229ejo.86.1704895723919;
        Wed, 10 Jan 2024 06:08:43 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906430b00b00a2b3bb73b83sm1930276ejm.94.2024.01.10.06.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 06:08:43 -0800 (PST)
Date: Wed, 10 Jan 2024 15:08:41 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, victor@mojatatu.com,
	pctammela@mojatatu.com, mleitner@redhat.com, vladbu@nvidia.com,
	paulb@nvidia.com
Subject: Re: [patch net-next] net: sched: move block device tracking into
 tcf_block_get/put_ext()
Message-ID: <ZZ6k6ZJBwDluOo0-@nanopsycho>
References: <20240104125844.1522062-1-jiri@resnulli.us>
 <ZZ6JE0odnu1lLPtu@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ6JE0odnu1lLPtu@shredder>

Wed, Jan 10, 2024 at 01:09:55PM CET, idosch@idosch.org wrote:
>On Thu, Jan 04, 2024 at 01:58:44PM +0100, Jiri Pirko wrote:
>> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
>> index adf5de1ff773..253b26f2eddd 100644
>> --- a/net/sched/cls_api.c
>> +++ b/net/sched/cls_api.c
>> @@ -1428,6 +1428,7 @@ int tcf_block_get_ext(struct tcf_block **p_block, struct Qdisc *q,
>>  		      struct tcf_block_ext_info *ei,
>>  		      struct netlink_ext_ack *extack)
>>  {
>> +	struct net_device *dev = qdisc_dev(q);
>>  	struct net *net = qdisc_net(q);
>>  	struct tcf_block *block = NULL;
>>  	int err;
>> @@ -1461,9 +1462,18 @@ int tcf_block_get_ext(struct tcf_block **p_block, struct Qdisc *q,
>>  	if (err)
>>  		goto err_block_offload_bind;
>>  
>> +	if (tcf_block_shared(block)) {
>> +		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>> +		if (err) {
>> +			NL_SET_ERR_MSG(extack, "block dev insert failed");
>> +			goto err_dev_insert;
>> +		}
>> +	}
>
>While this patch fixes the original issue, it creates another one:
>
># ip link add name swp1 type dummy
># tc qdisc replace dev swp1 root handle 10: prio bands 8 priomap 7 6 5 4 3 2 1
># tc qdisc add dev swp1 parent 10:8 handle 108: red limit 1000000 min 200000 max 200001 probability 1.0 avpkt 8000 burst 38 qevent early_drop block 10
>RED: set bandwidth to 10Mbit
># tc qdisc add dev swp1 parent 10:7 handle 107: red limit 1000000 min 500000 max 500001 probability 1.0 avpkt 8000 burst 63 qevent early_drop block 10
>RED: set bandwidth to 10Mbit
>Error: block dev insert failed.
>
>The reproducer does not fail if I revert this patch and apply Victor's
>[1] instead.
>
>[1] https://lore.kernel.org/netdev/20231231172320.245375-1-victor@mojatatu.com/

Will fix. Thanks!

>
>> +
>>  	*p_block = block;
>>  	return 0;
>>  
>> +err_dev_insert:
>>  err_block_offload_bind:
>>  	tcf_chain0_head_change_cb_del(block, ei);
>>  err_chain0_head_change_cb_add:

