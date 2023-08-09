Return-Path: <netdev+bounces-25654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F42775046
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 03:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C12281981
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146EE38F;
	Wed,  9 Aug 2023 01:21:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FD4376
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 01:21:47 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C369173F
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:21:46 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RLC0x4wXMz1GDfS;
	Wed,  9 Aug 2023 09:20:33 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 09:21:43 +0800
Message-ID: <d00008aa-9783-cf6e-1d30-51deb22c8bf7@huawei.com>
Date: Wed, 9 Aug 2023 09:21:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] mlxsw: spectrum_switchdev: Use is_zero_ether_addr()
 instead of ether_addr_equal()
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>
CC: <netdev@vger.kernel.org>, Petr Machata <petrm@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20230808133528.4083501-1-ruanjinjie@huawei.com>
 <ZNJUvRsToJvMFVDW@shredder>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <ZNJUvRsToJvMFVDW@shredder>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/8 22:44, Ido Schimmel wrote:
> In the future, please use the correct patch prefix for netdev
> submissions. See:
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#tl-dr

Thank you! I'll keep an eye on these issues.

> 
> On Tue, Aug 08, 2023 at 09:35:28PM +0800, Ruan Jinjie wrote:
>> Use is_zero_ether_addr() instead of ether_addr_equal()
>> to check if the ethernet address is all zeros.
>>
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 
> Thanks

