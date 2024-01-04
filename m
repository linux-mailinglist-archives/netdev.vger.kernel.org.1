Return-Path: <netdev+bounces-61662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7649C82485F
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 19:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D2828780A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 18:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C06A28E14;
	Thu,  4 Jan 2024 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSDtw0kU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805B928E06
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbdc7ff087fso692536276.2
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 10:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704394173; x=1704998973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HH71ZCH6KCHkVZ4H9nEdATbQJHB8stBPikG/c3vCsDg=;
        b=cSDtw0kU3XixEHl3Q2J43wt9U1mImQuRmGLlcIOTXtgIcw/pzadPO6KhbiCeoX+gJv
         YvQgxfLO+SS8ybpVDoQj/UO+iD5eT6nc1oQfI6E5d8t25+D+V1jIdOt1/lkX/5uR+DTA
         xy/1Wgqd3uZtvllEApqNO7xu0ZLSWOu9nnEQL0Csjce7Mlwcd3ADpawXkAp/L9oZJAiA
         iYZmMGyD88aWaMBVWAH9RkwYtnNkrVjSS+HflY16Q1eGj9d4+/WlJ64KRNfj6lDcE8RS
         hLKhaZpBa/A77raK8AyqhzfR2Kj+Qsg/3CETXvYDks6IzmP4Uu5n+M3hO8g0h1pVKhiK
         LJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704394173; x=1704998973;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HH71ZCH6KCHkVZ4H9nEdATbQJHB8stBPikG/c3vCsDg=;
        b=TwfLOPtTuNULfptAhdWsdxD0WN33TrK/o//+CfIC0TC0Du7XJFpMuvXf60zeicx5EW
         Bmh0fQsYM5t7R62P8j2XwdEFpe63AeF/eBJ3vrIuMX7Ua4f4Mj2fllSz/OAklDowhMkx
         AKpYlvOGUnDXMx31pvSrWuAiv4XdDsHnBK0uTAFnuHaneE865pc8lL3F5alKwBbmSOWj
         IYpBYfcJxUzBs4CBG9uEs10l1BKs1M/d+C8eiovJG3rIr2cdTxMey90Ge+ynnMVMLEOy
         ohiMt/jldJNNB4/mpr7KxGfNcKtCK65bFAYegu8aeSSeox5tGcY0bqvM011QE5QroyFI
         LNLg==
X-Gm-Message-State: AOJu0YwAhbT0FieFrUuwS6Y5QxcrHZjm4BlFC0Ebk/jqYPVKu9clTX/o
	3PVoVoT5ZYo+8RznELZgoKg=
X-Google-Smtp-Source: AGHT+IE7E7wRoFRuyEozjXu6FqrBwzwHKjPRO0eYKpMffFT92G9pXmzTRqLjuJcTBbHD/rXKjo+MRg==
X-Received: by 2002:a25:db45:0:b0:dbe:9f1f:4261 with SMTP id g66-20020a25db45000000b00dbe9f1f4261mr991157ybf.62.1704394173384;
        Thu, 04 Jan 2024 10:49:33 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:bc3f:8a99:d840:9c38? ([2600:1700:6cf8:1240:bc3f:8a99:d840:9c38])
        by smtp.gmail.com with ESMTPSA id m14-20020a5b040e000000b00d7745e2bb19sm5406086ybp.29.2024.01.04.10.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 10:49:32 -0800 (PST)
Message-ID: <c5b1da91-924f-43f8-8fba-6295d4a77d13@gmail.com>
Date: Thu, 4 Jan 2024 10:49:31 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/1] net/sched: We should only add appropriate
 qdiscs blocks to ports' xarray
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Victor Nogueira <victor@mojatatu.com>, jhs@mojatatu.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Cc: idosch@idosch.org, mleitner@redhat.com, vladbu@nvidia.com,
 paulb@nvidia.com, pctammela@mojatatu.com, netdev@vger.kernel.org,
 kernel@mojatatu.com, syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com,
 syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com,
 syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
References: <20231231172320.245375-1-victor@mojatatu.com>
 <eb4261f0-a5b7-4438-87f2-21207d86185d@gmail.com>
In-Reply-To: <eb4261f0-a5b7-4438-87f2-21207d86185d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/4/24 10:06, Kui-Feng Lee wrote:
> 
> 
> On 12/31/23 09:23, Victor Nogueira wrote:
>> We should only add qdiscs to the blocks ports' xarray in ingress that
>> support ingress_block_set/get or in egress that support
>> egress_block_set/get.
>>
>> Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking 
>> infra")
>> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> Reported-by: Ido Schimmel <idosch@nvidia.com>
>> Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
>> Tested-by: Ido Schimmel <idosch@nvidia.com>
>> Reported-and-tested-by: 
>> syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com
>> Closes: 
>> https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@google.com/
>> Reported-and-tested-by: 
>> syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com
>> Closes: 
>> https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@google.com/
>> Reported-and-tested-by: 
>> syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
>> Closes: 
>> https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@google.com/
>> ---
>> v1 -> v2:
>>
>> - Remove newline between fixes tag and Signed-off-by tag
>> - Add Ido's Reported-by and Tested-by tags
>> - Add syzbot's Reported-and-tested-by tags
>>
>>   net/sched/sch_api.c | 34 ++++++++++++++++++++--------------
>>   1 file changed, 20 insertions(+), 14 deletions(-)
>>
>> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
>> index 299086bb6205..426be81276f1 100644
>> --- a/net/sched/sch_api.c
>> +++ b/net/sched/sch_api.c
>> @@ -1187,23 +1187,29 @@ static int qdisc_block_add_dev(struct Qdisc 
>> *sch, struct net_device *dev,
>>       struct tcf_block *block;
>>       int err;
>> -    block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>> -    if (block) {
>> -        err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>> -        if (err) {
>> -            NL_SET_ERR_MSG(extack,
>> -                       "ingress block dev insert failed");
>> -            return err;
>> +    if (sch->ops->ingress_block_get) {
>> +        block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>> +        if (block) {
>> +            err = xa_insert(&block->ports, dev->ifindex, dev,
>> +                    GFP_KERNEL);
>> +            if (err) {
>> +                NL_SET_ERR_MSG(extack,
>> +                           "ingress block dev insert failed");
>> +                return err;
>> +            }
>>           }
>>       }
>> -    block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>> -    if (block) {
>> -        err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>> -        if (err) {
>> -            NL_SET_ERR_MSG(extack,
>> -                       "Egress block dev insert failed");
>> -            goto err_out;
>> +    if (sch->ops->egress_block_get) {
>> +        block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>> +        if (block) {
>> +            err = xa_insert(&block->ports, dev->ifindex, dev,
>> +                    GFP_KERNEL);
>> +            if (err) {
>> +                NL_SET_ERR_MSG(extack,
>> +                           "Egress block dev insert failed");
>> +                goto err_out;
>> +            }
>>           }
>>       }
> 
> Hi Vector,
> 
> Thank you for fixing this issue!
> Could you also add a test case to avoid regression in future?
> We have BPF test cases that fails for this issue. However,
> not everyone run BPF selftest for netdev changes.
> It would be better to have a test case for net as well.
> 

The following links are about the errors of bpf selftest. FYI!

  - 
https://github.com/kernel-patches/bpf/actions/runs/7401181881/job/20136944224
  - 
https://lore.kernel.org/netdev/ce8d3e55-b8bc-409c-ace9-5cf1c4f7c88e@gmail.com/



