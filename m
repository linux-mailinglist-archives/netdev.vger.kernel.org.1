Return-Path: <netdev+bounces-24245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD1176F6EA
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 03:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B45F1C21543
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 01:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30B3EA8;
	Fri,  4 Aug 2023 01:25:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E1FA4E
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 01:25:45 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA7C423E;
	Thu,  3 Aug 2023 18:25:41 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RH7Kv0nW8z1KCCn;
	Fri,  4 Aug 2023 09:24:35 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 09:25:38 +0800
Message-ID: <cd9cef17-7d59-6779-80d5-8322055163fd@huawei.com>
Date: Fri, 4 Aug 2023 09:25:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next] net/mlx5: remove many unnecessary NULL values
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: <borisp@nvidia.com>, <saeedm@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20230801123854.375155-1-ruanjinjie@huawei.com>
 <20230803181730.GG53714@unreal>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230803181730.GG53714@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/4 2:17, Leon Romanovsky wrote:
> On Tue, Aug 01, 2023 at 08:38:54PM +0800, Ruan Jinjie wrote:
>> Ther are many pointers assigned first, which need not to be initialized, so
> 
> Ther -> There
> 
>> remove the NULL assignment.
> 
> assignment -> assignments.

Thank you! I'll fix the issues sooner.

> 
>>
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
>> ---
>>  drivers/net/ethernet/mellanox/mlx5/core/fpga/core.c   | 4 ++--
>>  drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c | 2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
> 
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

