Return-Path: <netdev+bounces-25702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C427775361
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 09:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC8A1C2111E
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 07:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B728FECD;
	Wed,  9 Aug 2023 07:00:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C0F7F3
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 07:00:10 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FD91BCF;
	Wed,  9 Aug 2023 00:00:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RLLXf3n62z4f3jYq;
	Wed,  9 Aug 2023 15:00:02 +0800 (CST)
Received: from [10.67.110.48] (unknown [10.67.110.48])
	by APP4 (Coremail) with SMTP id gCh0CgBHI6ZxOdNkG+kkAQ--.22186S2;
	Wed, 09 Aug 2023 15:00:02 +0800 (CST)
Message-ID: <dc5efa8d-ce1b-2dc0-1e4b-bfc9993206bf@huaweicloud.com>
Date: Wed, 9 Aug 2023 15:00:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] netfilter: ebtables: fix fortify warnings
Content-Language: en-US
To: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 Kees Cook <keescook@chromium.org>, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 Wang Weiyang <wangweiyang2@huawei.com>, Xiu Jianfeng
 <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
References: <20230808133038.771316-1-gongruiqi@huaweicloud.com>
 <ZNJuMoe37L02TP20@work> <5E8E0F9C-EE3F-4B0D-B827-DC47397E2A4A@kernel.org>
From: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
In-Reply-To: <5E8E0F9C-EE3F-4B0D-B827-DC47397E2A4A@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHI6ZxOdNkG+kkAQ--.22186S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4xCw18tw1fArW5ury7Awb_yoW8KrWUpF
	1vya4akr4UJ3WYqw1xXwnYyr4F93sFgF13JrW3G34rGryvqF17Ga9YkryY9a4kJwn5uF4x
	AF4YgrWSgFWDJFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 2023/08/09 6:53, Kees Cook wrote:
> 
> [...]
>>>
>>> diff --git a/include/uapi/linux/netfilter_bridge/ebtables.h b/include/uapi/linux/netfilter_bridge/ebtables.h
>>> index a494cf43a755..b0caad82b693 100644
>>> --- a/include/uapi/linux/netfilter_bridge/ebtables.h
>>> +++ b/include/uapi/linux/netfilter_bridge/ebtables.h
>>> @@ -182,12 +182,14 @@ struct ebt_entry {
>>>  	unsigned char sourcemsk[ETH_ALEN];
>>>  	unsigned char destmac[ETH_ALEN];
>>>  	unsigned char destmsk[ETH_ALEN];
>>> -	/* sizeof ebt_entry + matches */
>>> -	unsigned int watchers_offset;
>>> -	/* sizeof ebt_entry + matches + watchers */
>>> -	unsigned int target_offset;
>>> -	/* sizeof ebt_entry + matches + watchers + target */
>>> -	unsigned int next_offset;
>>> +	__struct_group(/* no tag */, offsets, /* no attrs */,
>>> +		/* sizeof ebt_entry + matches */
>>> +		unsigned int watchers_offset;
>>> +		/* sizeof ebt_entry + matches + watchers */
>>> +		unsigned int target_offset;
>>> +		/* sizeof ebt_entry + matches + watchers + target */
>>> +		unsigned int next_offset;
>>> +	);
>>>  	unsigned char elems[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
> 
> While we're here, can we drop this [0] in favor of []?
> 
> -Kees
> 

Look like it could be done. Will do in v3. Thanks!

>>>  };
>>>  
>>> diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
>>> index 757ec46fc45a..5ec66b1ebb64 100644
>>> --- a/net/bridge/netfilter/ebtables.c
>>> +++ b/net/bridge/netfilter/ebtables.c
>>> @@ -2115,8 +2115,7 @@ static int size_entry_mwt(const struct ebt_entry *entry, const unsigned char *ba
>>>  		return ret;
>>>  
>>>  	offsets[0] = sizeof(struct ebt_entry); /* matches come first */
>>> -	memcpy(&offsets[1], &entry->watchers_offset,
>>> -			sizeof(offsets) - sizeof(offsets[0]));
>>> +	memcpy(&offsets[1], &entry->offsets, sizeof(offsets) - sizeof(offsets[0]));
>> 							^^^^^^^^^^^^
>> You now can replace this ____________________________________|
>> with just `sizeof(entry->offsets)`
>>
>> With that change you can add my
>> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>
>> Thank you
>> --
>> Gustavo
>>
>>>  
>>>  	if (state->buf_kern_start) {
>>>  		buf_start = state->buf_kern_start + state->buf_kern_offset;
>>> -- 
>>> 2.41.0
>>>
> 
> 


