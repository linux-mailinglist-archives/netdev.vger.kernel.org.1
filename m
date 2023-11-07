Return-Path: <netdev+bounces-46440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87B67E3EB0
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 13:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D7AB207C2
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 12:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9F91426A;
	Tue,  7 Nov 2023 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521CD30CEF
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 12:40:38 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99B222883;
	Tue,  7 Nov 2023 04:40:24 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SPnm82S4TzrT4R;
	Tue,  7 Nov 2023 20:37:12 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 7 Nov
 2023 20:40:22 +0800
Subject: Re: [PATCH net] page_pool: Add myself as page pool reviewer in
 MAINTAINERS
To: Jesper Dangaard Brouer <hawk@kernel.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>
References: <20231107113440.59794-1-linyunsheng@huawei.com>
 <973bcee0-a382-4a8d-8a2c-1be9b6d9d7ad@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <05ae3fef-69d4-2505-872a-89df9f668545@huawei.com>
Date: Tue, 7 Nov 2023 20:40:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <973bcee0-a382-4a8d-8a2c-1be9b6d9d7ad@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/7 20:28, Jesper Dangaard Brouer wrote:

>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 14e1194faa4b..5d20efb9021a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -16242,6 +16242,7 @@ F:    mm/truncate.c
>>   PAGE POOL
>>   M:    Jesper Dangaard Brouer <hawk@kernel.org>
>>   M:    Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> +R    Yunsheng Lin <linyunsheng@huawei.com>
> 
> I think there is missing a colon ":" after "R".

Yes, thanks for pointing out.
Fixed and sent.

> 
>>   L:    netdev@vger.kernel.org
>>   S:    Supported
>>   F:    Documentation/networking/page_pool.rst
> 
> .
> 

