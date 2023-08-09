Return-Path: <netdev+bounces-25664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46B5775132
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 05:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5CD41C210EA
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 03:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B9F62C;
	Wed,  9 Aug 2023 03:05:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49811376
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 03:05:57 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774111BEF;
	Tue,  8 Aug 2023 20:05:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RLFLS22rVz4f3tpx;
	Wed,  9 Aug 2023 11:05:52 +0800 (CST)
Received: from [10.67.110.48] (unknown [10.67.110.48])
	by APP3 (Coremail) with SMTP id _Ch0CgC328ONAtNktWYIAQ--.34063S2;
	Wed, 09 Aug 2023 11:05:50 +0800 (CST)
Message-ID: <5095df45-c7bf-9040-1720-09a562b8714a@huaweicloud.com>
Date: Wed, 9 Aug 2023 11:05:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] netfilter: ebtables: fix fortify warnings
Content-Language: en-US
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Kees Cook
 <keescook@chromium.org>, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 Wang Weiyang <wangweiyang2@huawei.com>, Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20230808014821.241688-1-gongruiqi@huaweicloud.com>
 <20230808155430.GB9741@breakpoint.cc>
From: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
In-Reply-To: <20230808155430.GB9741@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgC328ONAtNktWYIAQ--.34063S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XrWDKF4kuFy7Cw4rKF1UAwb_yoWDuFg_Aw
	n2kryDGr129r95tF40qFy7Gry5Ww1rCFy8Wa40qrsYqrZ8Ar1FgaykJr9xZw47t39akr9r
	CFn0vr48u3Wj9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUrR6zUUUUU
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 2023/08/08 23:54, Florian Westphal wrote:
> 
> [...]
>>
>> diff --git a/include/uapi/linux/netfilter_bridge/ebtables.h b/include/uapi/linux/netfilter_bridge/ebtables.h
>> index a494cf43a755..e634da196d08 100644
>> --- a/include/uapi/linux/netfilter_bridge/ebtables.h
>> +++ b/include/uapi/linux/netfilter_bridge/ebtables.h
>> @@ -182,12 +182,14 @@ struct ebt_entry {
>>  	unsigned char sourcemsk[ETH_ALEN];
>>  	unsigned char destmac[ETH_ALEN];
>>  	unsigned char destmsk[ETH_ALEN];
>> -	/* sizeof ebt_entry + matches */
>> -	unsigned int watchers_offset;
>> -	/* sizeof ebt_entry + matches + watchers */
>> -	unsigned int target_offset;
>> -	/* sizeof ebt_entry + matches + watchers + target */
>> -	unsigned int next_offset;
>> +	struct_group(offsets,
>> +		/* sizeof ebt_entry + matches */
> 
> This is an UAPI header, I think you need to use __struct_group here.

Thanks for the reminder! I've fixed it in v2:

https://lore.kernel.org/all/20230808133038.771316-1-gongruiqi@huaweicloud.com/

Please review it :)


