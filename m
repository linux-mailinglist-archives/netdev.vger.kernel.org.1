Return-Path: <netdev+bounces-26334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EF47778CF
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 14:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CBB41C21277
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2BE1E1B2;
	Thu, 10 Aug 2023 12:50:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E317C1E1A1
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 12:50:43 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FFB26AC;
	Thu, 10 Aug 2023 05:50:41 -0700 (PDT)
Received: from dggpemm100022.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RM6CS4SFjzqT26;
	Thu, 10 Aug 2023 20:47:48 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100022.china.huawei.com (7.185.36.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 20:50:39 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 20:50:39 +0800
Subject: Re: [PATCH 2/2] ethernet: atarilance: mark init function static
To: Arnd Bergmann <arnd@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Arnd Bergmann <arnd@arndb.de>, Haoyue Xu <xuhaoyue1@hisilicon.com>,
	Guofeng Yue <yueguofeng@hisilicon.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20230810122528.1220434-1-arnd@kernel.org>
 <20230810122528.1220434-2-arnd@kernel.org>
From: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <e531089e-793c-6813-42d0-dfd9fffe61b8@huawei.com>
Date: Thu, 10 Aug 2023 20:50:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230810122528.1220434-2-arnd@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 2023/8/10 20:25, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The init function is only referenced locally, so it should be static to
> avoid this warning:
>
> drivers/net/ethernet/amd/atarilance.c:370:28: error: no previous prototype for 'atarilance_probe' [-Werror=missing-prototypes]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Yang Yingliang <yangyingliang@huawei.com>

