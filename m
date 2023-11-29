Return-Path: <netdev+bounces-51987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C277FCD81
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6271A283220
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CC3566F;
	Wed, 29 Nov 2023 03:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865511AD
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 19:30:48 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Sg4Zf6q6jzWhp7;
	Wed, 29 Nov 2023 11:30:02 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 Nov
 2023 11:30:46 +0800
Subject: Re: [PATCH net-next v4 1/4] page_pool: Rename pp_frag_count to
 pp_ref_count
To: Liang Chen <liangchen.linux@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>
CC: <netdev@vger.kernel.org>, <linux-mm@kvack.org>
References: <20231129031201.32014-1-liangchen.linux@gmail.com>
 <20231129031201.32014-2-liangchen.linux@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <ddc2133e-6244-8e15-bc41-5a349e617d3f@huawei.com>
Date: Wed, 29 Nov 2023 11:30:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231129031201.32014-2-liangchen.linux@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/29 11:11, Liang Chen wrote:
> To support multiple users referencing the same fragment, pp_frag_count is
> renamed to pp_ref_count to better reflect its actual meaning based on the
> suggestion from [1].

LGTM.
Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>

