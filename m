Return-Path: <netdev+bounces-55291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F2380A22A
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 12:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 809AEB20A59
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 11:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EC51B26C;
	Fri,  8 Dec 2023 11:28:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8F610D8;
	Fri,  8 Dec 2023 03:28:50 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Smpmv2xLRz1Q6FZ;
	Fri,  8 Dec 2023 19:28:47 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 8 Dec
 2023 19:28:48 +0800
Subject: Re: [PATCH net-next v6 08/12] libie: add Rx buffer management (via
 Page Pool)
From: Yunsheng Lin <linyunsheng@huawei.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Michal Kubiak
	<michal.kubiak@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>, David Christensen
	<drc@linux.vnet.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Paul Menzel
	<pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20231207172010.1441468-1-aleksander.lobakin@intel.com>
 <20231207172010.1441468-9-aleksander.lobakin@intel.com>
 <1103fe8f-04c8-8cc4-8f1b-ff45cea22b54@huawei.com>
Message-ID: <687ac9bb-c7ca-fc71-9e61-d9247198224a@huawei.com>
Date: Fri, 8 Dec 2023 19:28:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1103fe8f-04c8-8cc4-8f1b-ff45cea22b54@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/12/8 17:28, Yunsheng Lin wrote:

>> +
>> +	page_pool_dma_sync_for_cpu(page->pp, page, buf->offset, len);
> 
> Is there a reason why page_pool_dma_sync_for_cpu() is still used when
> page_pool_create() is called with PP_FLAG_DMA_SYNC_DEV flag? Isn't syncing
> already handled in page_pool core when when PP_FLAG_DMA_SYNC_DEV flag is
> set?

Ah, it is a sync_for_cpu.
Ignore this one.

