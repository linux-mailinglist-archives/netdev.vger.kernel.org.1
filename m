Return-Path: <netdev+bounces-46792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C8A7E66F9
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 10:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA80EB20C9B
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 09:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFC912B99;
	Thu,  9 Nov 2023 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BA612E48
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 09:44:02 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C0B272C;
	Thu,  9 Nov 2023 01:44:02 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SQxqB44W1zfb6H;
	Thu,  9 Nov 2023 17:43:50 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 9 Nov
 2023 17:43:34 +0800
Subject: Re: [PATCH net v2] page_pool: Add myself as page pool reviewer in
 MAINTAINERS
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20231107123825.61051-1-linyunsheng@huawei.com>
 <20231107094959.556ffe53@kernel.org>
 <0098508e-59ab-5633-3725-86f1febc1480@huawei.com>
 <20231108084739.59adead6@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <bcf61cb5-1203-7de5-4db1-85a96bd84130@huawei.com>
Date: Thu, 9 Nov 2023 17:43:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231108084739.59adead6@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/9 0:47, Jakub Kicinski wrote:
> On Wed, 8 Nov 2023 11:31:45 +0800 Yunsheng Lin wrote:
>> For 2, yes, maybe I should stick to the rule even if it is a simple
>> patch and obivous format error.
> 
> Yes, maybe you should.

Thanks for clarifying.
Maybe I should be targetting the net-next branch for the repost
after merge window open, in order not to cause any confusion.

> .
> 

