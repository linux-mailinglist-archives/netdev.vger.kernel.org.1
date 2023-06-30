Return-Path: <netdev+bounces-14689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5169D7431FD
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 02:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830BD1C20B2E
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 00:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6269DED5;
	Fri, 30 Jun 2023 00:55:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D6F15A6
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 00:55:30 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BE52705
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 17:55:28 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QscKM6MQWzTlYL;
	Fri, 30 Jun 2023 08:54:31 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 08:55:25 +0800
Message-ID: <44c82013-c91a-d7ac-28d0-2f5785c3f942@huawei.com>
Date: Fri, 30 Jun 2023 08:55:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net,v2] mlxsw: minimal: fix potential memory leak in
 mlxsw_m_linecards_init
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <idosch@nvidia.com>, <petrm@nvidia.com>,
	<jiri@resnulli.us>, <vadimp@nvidia.com>, <yuehaibing@huawei.com>
References: <20230628100116.2199367-1-shaozhengchao@huawei.com>
 <20230629110846.17a4c23d@kernel.org>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <20230629110846.17a4c23d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/6/30 2:08, Jakub Kicinski wrote:
> On Wed, 28 Jun 2023 18:01:16 +0800 Zhengchao Shao wrote:
>> The line cards array is not freed in the error path of
>> mlxsw_m_linecards_init(), which can lead to a memory leak. Fix by
>> freeing the array in the error path, thereby making the error path
>> identical to mlxsw_m_linecards_fini().
>>
>> Fixes: 01328e23a476 ("mlxsw: minimal: Extend module to port mapping with slot index")
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> Reviewed-by: Petr Machata <petrm@nvidia.com>
> 
> Could you please resend with Ido's review tag included?
> 
  OK，I will resend this patch. Thank you.

Zhengchao Shao
> Due to unforeseen mail server issues (it wouldn't be a merge window
> without vger imploding, eh?) the patch did not make it to patchwork
> or email archives.

