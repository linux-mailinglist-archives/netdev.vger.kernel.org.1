Return-Path: <netdev+bounces-23494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C030576C2FA
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 04:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19781C210DD
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 02:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19397EC;
	Wed,  2 Aug 2023 02:35:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9594E7E6
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 02:35:14 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1802690;
	Tue,  1 Aug 2023 19:35:09 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RFwwL0cnWztRbS;
	Wed,  2 Aug 2023 10:31:46 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 10:35:07 +0800
Message-ID: <4f2336ed-7fb2-b720-b2f1-d65e4e2e46fc@huawei.com>
Date: Wed, 2 Aug 2023 10:35:06 +0800
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
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, <tariqt@nvidia.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20230801123422.374541-1-ruanjinjie@huawei.com>
 <4811ee1d-45d7-c484-f4f0-20228afc048b@intel.com>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <4811ee1d-45d7-c484-f4f0-20228afc048b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/2 1:55, Jesse Brandeburg wrote:
> On 8/1/2023 5:34 AM, Ruan Jinjie wrote:
>> Ther are many pointers assigned first, which need not to be initialized, so
>> remove the NULL assignment.
>>
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> 
> Thanks for your patch, make sure you're always explaining "why" you're
> making a change in your commit message.

Thank you for your sincere advice! I'll notice the issue in future patches.

> 
> but see below please.
> 
>> ---
>>  drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 10 +++++-----
>>  drivers/net/ethernet/mellanox/mlx4/en_netdev.c  |  4 ++--
>>  drivers/net/ethernet/mellanox/mlx4/main.c       | 12 ++++++------
>>  3 files changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
>> index 7d45f1d55f79..164a13272faa 100644
>> --- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
>> +++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
>> @@ -1467,8 +1467,8 @@ static int add_ip_rule(struct mlx4_en_priv *priv,
>>  		       struct list_head *list_h)
>>  {
>>  	int err;
>> -	struct mlx4_spec_list *spec_l2 = NULL;
>> -	struct mlx4_spec_list *spec_l3 = NULL;
>> +	struct mlx4_spec_list *spec_l2;
>> +	struct mlx4_spec_list *spec_l3;
> 
> What sequence of commands did you use to identify this set of things to
> change? That would be useful data for the commit message.
> 
> gcc with -Wunused-something?
> cppcheck?

Just code walk-through and some keyword match such as malloc and NULL
assignment.

> 
> I've sent these types of patches before, but they've been rejected as
> churn if they don't fix a clear W=1 or C=2 warning.
> 
> Did you run the above and see these issues?
> 
> 
>>  	struct ethtool_usrip4_spec *l3_mask = &cmd->fs.m_u.usr_ip4_spec;
>>  
>>  	spec_l3 = kzalloc(sizeof(*spec_l3), GFP_KERNEL);
>> @@ -1505,9 +1505,9 @@ static int add_tcp_udp_rule(struct mlx4_en_priv *priv,
>>  			     struct list_head *list_h, int proto)
>>  {
>>  	int err;
>> -	struct mlx4_spec_list *spec_l2 = NULL;
>> -	struct mlx4_spec_list *spec_l3 = NULL;
>> -	struct mlx4_spec_list *spec_l4 = NULL;
>> +	struct mlx4_spec_list *spec_l2;
>> +	struct mlx4_spec_list *spec_l3;
>> +	struct mlx4_spec_list *spec_l4;
>>  	struct ethtool_tcpip4_spec *l4_mask = &cmd->fs.m_u.tcp_ip4_spec;
>>  
>>  	spec_l2 = kzalloc(sizeof(*spec_l2), GFP_KERNEL);
> 
> I suggest if you want to have these kind of changes committed you spend
> more time to make a detailed commit message and explain what's going on
> for the change as otherwise it's not going to be accepted.

Thank you very much! I'll give more explain in future patches.

> 
> 
> 

