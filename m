Return-Path: <netdev+bounces-28058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B916E77E174
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26BDD2819E2
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 12:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F007107BF;
	Wed, 16 Aug 2023 12:25:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FD7DF57
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 12:24:59 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8E9E56;
	Wed, 16 Aug 2023 05:24:57 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RQnNk3X8vz1GDcX;
	Wed, 16 Aug 2023 20:23:34 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 20:24:54 +0800
Message-ID: <e5624b47-52f1-e01c-6e5c-e8192132edf9@huawei.com>
Date: Wed, 16 Aug 2023 20:24:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next v2] netfilter: ebtables: replace zero-length
 array members
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
CC: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik
	<kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Roopa Prabhu
	<roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kees Cook
	<keescook@chromium.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <coreteam@netfilter.org>,
	<bridge@lists.linux-foundation.org>
References: <20230816093443.1460204-1-gongruiqi@huaweicloud.com>
 <ZNywHiWhaL6pRZsd@vergenet.net>
From: Gong Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <ZNywHiWhaL6pRZsd@vergenet.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.48]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/08/16 19:16, Simon Horman wrote:
> On Wed, Aug 16, 2023 at 05:34:43PM +0800, GONG, Ruiqi wrote:
>> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
>>
>> As suggested by Kees[1], replace the old-style 0-element array members
>> of multiple structs in ebtables.h with modern C99 flexible array.
>>
>> [1]: https://lore.kernel.org/all/5E8E0F9C-EE3F-4B0D-B827-DC47397E2A4A@kernel.org/
>>
>> Link: https://github.com/KSPP/linux/issues/21
>> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> ---
>>
>> v2: designate to net-next; cc more netdev maintainers
> 
> It's slightly unclear to me if this should be targeting
> net-next or nf-next. But regardless, it doesn't seem
> to apply cleanly to the main branch of either tree.

I find out that it's because this patch depends on a previous patch I've
just sent:

[v4] netfilter: ebtables: fix fortify warnings in size_entry_mwt()

Maybe I should make them two into a patch set? Otherwise if I adapt this
patch to net-next, it won't be applied either if the above patch is
applied ...

> 
> Please consider resolving that and posting again,
> being sure to allow 24h before postings.
> 
> Link: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
>

