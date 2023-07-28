Return-Path: <netdev+bounces-22260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 207FB766C3D
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 13:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4771C2189F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 11:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD0012B72;
	Fri, 28 Jul 2023 11:58:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F21125BE
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 11:58:07 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A14CC3;
	Fri, 28 Jul 2023 04:58:05 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RC5f62HY5zNmWP;
	Fri, 28 Jul 2023 19:54:38 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 19:58:01 +0800
Subject: Re: [PATCH net-next 1/9] page_pool: split types and declarations from
 page_pool.h
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Larysa Zaremba
	<larysa.zaremba@intel.com>, Alexander Duyck <alexanderduyck@fb.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Simon Horman <simon.horman@corigine.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
 <20230727144336.1646454-2-aleksander.lobakin@intel.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <fb6330ef-5e74-01a4-a418-0b33748932ff@huawei.com>
Date: Fri, 28 Jul 2023 19:58:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230727144336.1646454-2-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/27 22:43, Alexander Lobakin wrote:

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d0553ad37865..30037d39b82d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16015,8 +16015,7 @@ M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
>  L:	netdev@vger.kernel.org
>  S:	Supported
>  F:	Documentation/networking/page_pool.rst
> -F:	include/net/page_pool.h
> -F:	include/trace/events/page_pool.h

Is there any reason to remove the above?

> +F:	include/net/page_pool/*.h

It seems more common to use 'include/net/page_pool/' in
MAINTAINERS.

>  F:	net/core/page_pool.c
>  

