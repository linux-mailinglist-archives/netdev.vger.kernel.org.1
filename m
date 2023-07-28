Return-Path: <netdev+bounces-22194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B26876668C
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5201C2182E
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 08:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D17DD2F3;
	Fri, 28 Jul 2023 08:12:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61955C2C0
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:12:02 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA61448A
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 01:11:57 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RC0dM0qWMztRZw;
	Fri, 28 Jul 2023 16:08:39 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 16:11:55 +0800
Message-ID: <48ecd30c-fdb8-c987-7369-78664ea4f799@huawei.com>
Date: Fri, 28 Jul 2023 16:11:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next] net: bcmasp: Clean up redundant dev_err_probe()
Content-Language: en-US
To: Simon Horman <simon.horman@corigine.com>
CC: <justin.chen@broadcom.com>, <florian.fainelli@broadcom.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<netdev@vger.kernel.org>
References: <20230727115551.2655840-1-chenjiahao16@huawei.com>
 <ZMJx8JnLPBbsR1Up@corigine.com>
From: "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <ZMJx8JnLPBbsR1Up@corigine.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 2023/7/27 21:32, Simon Horman wrote:
> On Thu, Jul 27, 2023 at 07:55:51PM +0800, Chen Jiahao wrote:
>> Refering to platform_get_irq()'s definition, the return value has
> nit: Refering -> Referring

Thanks, I will fix this typo in v2 patch if needed.

Jiahao

>
>> already been checked, error message also been printed via
>> dev_err_probe() if ret < 0. Calling dev_err_probe() one more time
>> outside platform_get_irq() is obviously redundant.
>>
>> Removing dev_err_probe() outside platform_get_irq() to clean up
>> above problem.
>>
>> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
>

