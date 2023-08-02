Return-Path: <netdev+bounces-23492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3958676C2E0
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 04:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0AB11C2113F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 02:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F11A35;
	Wed,  2 Aug 2023 02:27:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BA27E
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 02:27:51 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FADF213E;
	Tue,  1 Aug 2023 19:27:50 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RFwlp5XB4zNmLN;
	Wed,  2 Aug 2023 10:24:22 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 10:27:47 +0800
Message-ID: <dc0cf96a-bd1d-6e00-a074-98029c5d8e3b@huawei.com>
Date: Wed, 2 Aug 2023 10:27:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next] net/mlx4: remove many unnecessary NULL values
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: <tariqt@nvidia.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20230801123422.374541-1-ruanjinjie@huawei.com>
 <ZMknUZudTKGwsEpG@kernel.org>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <ZMknUZudTKGwsEpG@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/1 23:40, Simon Horman wrote:
> On Tue, Aug 01, 2023 at 08:34:22PM +0800, Ruan Jinjie wrote:
>> Ther are many pointers assigned first, which need not to be initialized, so
>> remove the NULL assignment.
> 
> How about something like:
> 
> Don't initialise local variables to NULL which are always
> set to other values elsewhere in the same function.

I think these NULL assignments can also be removed.

> 
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
> 
> ...
> 
>> @@ -2294,8 +2294,8 @@ static int mlx4_init_fw(struct mlx4_dev *dev)
>>  static int mlx4_init_hca(struct mlx4_dev *dev)
>>  {
>>  	struct mlx4_priv	  *priv = mlx4_priv(dev);
>> -	struct mlx4_init_hca_param *init_hca = NULL;
>> -	struct mlx4_dev_cap	  *dev_cap = NULL;
>> +	struct mlx4_init_hca_param *init_hca;
>> +	struct mlx4_dev_cap	  *dev_cap;
>>  	struct mlx4_adapter	   adapter;
>>  	struct mlx4_profile	   profile;
>>  	u64 icm_size;
> 
> This last hunk doesn't seem correct, as it doesn't
> seem these aren't always initialised elsewhere in the function
> before being passed to kfree().

Yes, this kind of situation the NULL assignments should not be removed,I'll
reserch it more.

> 
>> -- 
>> 2.34.1
>>
>>

