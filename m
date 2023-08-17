Return-Path: <netdev+bounces-28378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ECD77F3DD
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06E51C2124A
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67EC12B71;
	Thu, 17 Aug 2023 09:50:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98827125B9
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:50:19 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1D030E5
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 02:50:16 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRKvm1pyTzrRgx;
	Thu, 17 Aug 2023 17:48:52 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 17:50:13 +0800
Message-ID: <5a885cda-4ee3-6c26-e6ea-5074427e974b@huawei.com>
Date: Thu, 17 Aug 2023 17:50:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next 0/2] net: Use helper function IS_ERR_OR_NULL()
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <lars.povlsen@microchip.com>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>,
	<mcoquelin.stm32@gmail.com>, <horatiu.vultur@microchip.com>,
	<simon.horman@corigine.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-stm32@st-md-mailman.stormreply.com>
References: <20230817071941.346590-1-ruanjinjie@huawei.com>
 <20230817080257.GD22185@unreal>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230817080257.GD22185@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/17 16:02, Leon Romanovsky wrote:
> On Thu, Aug 17, 2023 at 03:19:39PM +0800, Ruan Jinjie wrote:
>> Use IS_ERR_OR_NULL() instead of open-coding it
>> to simplify the code.
>>
>> Ruan Jinjie (2):
>>   net: microchip: sparx5: Use helper function IS_ERR_OR_NULL()
>>   net: stmmac: Use helper function IS_ERR_OR_NULL()
>>
>>  drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c | 2 +-
>>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c        | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
> 
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> 
> As a side note, grep of vcap_get_rule() shows that many callers don't
> properly check return value and expect it to be or valid or NULL.

Right! I will try to fix these problems together by the way. Thank you!

> 
> For example this code is not correct:
> drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
>     61         vrule = vcap_get_rule(lan966x->vcap_ctrl, rule_id);
>     62         if (vrule) {
>     63                 u32 value, mask;
>     64
>     65                 /* Just modify the ingress port mask and exit */
>     66                 vcap_rule_get_key_u32(vrule, VCAP_KF_IF_IGR_PORT_MASK,
>     67                                       &value, &mask);
>     68                 mask &= ~BIT(port->chip_port);
>     69                 vcap_rule_mod_key_u32(vrule, VCAP_KF_IF_IGR_PORT_MASK,
>     70                                       value, mask);
>     71
>     72                 err = vcap_mod_rule(vrule);
>     73                 goto free_rule;
>     74         }
> 

