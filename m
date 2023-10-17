Return-Path: <netdev+bounces-41923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BE07CC3AA
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 14:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA211C20A93
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9528F41E45;
	Tue, 17 Oct 2023 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495E04121C
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 12:53:12 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C7883;
	Tue, 17 Oct 2023 05:53:08 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S8v345kbDz15Nct;
	Tue, 17 Oct 2023 20:50:24 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 17 Oct
 2023 20:53:06 +0800
Subject: Re: [PATCH net-next v11 1/6] page_pool: fragment API support for
 32-bit arch with 64-bit DMA
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Duyck <alexander.duyck@gmail.com>, Liang Chen
	<liangchen.linux@gmail.com>, Guillaume Tucker
	<guillaume.tucker@collabora.com>, Matthew Wilcox <willy@infradead.org>,
	Linux-MM <linux-mm@kvack.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Eric
 Dumazet <edumazet@google.com>
References: <20231013064827.61135-1-linyunsheng@huawei.com>
 <20231013064827.61135-2-linyunsheng@huawei.com>
 <CAC_iWj+FR+ojP7akSY0azc0hVnrhsPhyFTejNit0sVR742KgEw@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <e738b0b9-6c60-b971-7fd9-0ec1b14dda3c@huawei.com>
Date: Tue, 17 Oct 2023 20:53:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAC_iWj+FR+ojP7akSY0azc0hVnrhsPhyFTejNit0sVR742KgEw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/10/17 20:17, Ilias Apalodimas wrote:
>>
> 
> That looks fine wrt what we discussed with Jakub,
> 
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks. What about other patches in this series? Could you take
some time to review them too?

> 
> .
> 

