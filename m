Return-Path: <netdev+bounces-27207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D31B77AF3F
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 03:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBA6280EE8
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 01:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C6F15B2;
	Mon, 14 Aug 2023 01:56:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281B115A6
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 01:56:15 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AEFE54;
	Sun, 13 Aug 2023 18:56:14 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RPHXG1HjyzrSWm;
	Mon, 14 Aug 2023 09:54:54 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 14 Aug 2023 09:56:11 +0800
Message-ID: <d7a6c71a-98a6-64cd-8118-2b0f89189177@huawei.com>
Date: Mon, 14 Aug 2023 09:56:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] hv_netvsc: Remove duplicated include
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: <kys@microsoft.com>, <haiyangz@microsoft.com>, <wei.liu@kernel.org>,
	<decui@microsoft.com>, <linux-hyperv@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
	<pabeni@redhat.com>
References: <20230810115148.21332-1-guozihua@huawei.com>
 <ZNX8CyvnsP0zhmbA@vergenet.net>
From: "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <ZNX8CyvnsP0zhmbA@vergenet.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/11 17:14, Simon Horman wrote:
> On Thu, Aug 10, 2023 at 07:51:48PM +0800, GUO Zihua wrote:
>> Remove duplicated include of linux/slab.h.  Resolves checkincludes message.
>>
>> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> 
> The patch looks fine, but for reference, I do have some feedback
> from a process point of view. It's probably not necessary to
> repost because of these. But do keep them in mind if you have
> to post a v2 for some other reason, and for future patch submissions.
> 
> * As a non bugfix for Networking code this should likely be targeted
>   at the net-next tree - the net tree is used for bug fixes.
>   And the target tree should be noted in the subject.
> 
>   Subject: [PATCH net-next] ...
> 
> * Please use the following command to generate the
>   CC list for Networking patches
> 
>   ./scripts/get_maintainer.pl --git-min-percent 2 this.patch
> 
>   In this case, the following, now CCed, should be included:
> 
>   - Jakub Kicinski <kuba@kernel.org>
>   - Eric Dumazet <edumazet@google.com>
>   - "David S. Miller" <davem@davemloft.net>
>   - Paolo Abeni <pabeni@redhat.com>
> 
> * Please do read the process guide
> 
>   https://kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
> The above notwithstanding,
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Hi Simon,

Thanks for the info and the review-by! Will keep that in mind.

-- 
Best
GUO Zihua


