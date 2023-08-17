Return-Path: <netdev+bounces-28438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E3577F740
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B371281FC0
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308E914015;
	Thu, 17 Aug 2023 13:02:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251A51400C
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 13:02:42 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E521D3A90
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 06:02:13 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRQ7J6pxMzVjv1;
	Thu, 17 Aug 2023 20:59:08 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 21:01:15 +0800
Message-ID: <8474ac51-9906-4b2a-6eb8-92fd19869bba@huawei.com>
Date: Thu, 17 Aug 2023 21:01:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next v2 2/4] net: bgmac: Fix return value check for
 fixed_phy_register()
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: <rafal@milecki.pl>, <bcm-kernel-feedback-list@broadcom.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <opendmb@gmail.com>, <florian.fainelli@broadcom.com>,
	<bryan.whitehead@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <mdf@kernel.org>, <pgynther@google.com>,
	<Pavithra.Sathyanarayanan@microchip.com>, <netdev@vger.kernel.org>
References: <20230817121631.1878897-1-ruanjinjie@huawei.com>
 <20230817121631.1878897-3-ruanjinjie@huawei.com>
 <039324dd-96ae-41df-974a-6519ff8f8983@lunn.ch>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <039324dd-96ae-41df-974a-6519ff8f8983@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/17 20:41, Andrew Lunn wrote:
> On Thu, Aug 17, 2023 at 08:16:29PM +0800, Ruan Jinjie wrote:
>> The fixed_phy_register() function returns error pointers and never
>> returns NULL. Update the checks accordingly.
>>
>> And it also returns -EPROBE_DEFER, -EINVAL and -EBUSY, etc, in addition to
>> -ENODEV, just return -ENODEV is not sensible, use
>> PTR_ERR to fix the issue.
> 
> I would recommend changing not sensible to best practice, as i
> suggested in one of your other patches.

Thank you again! I'll watch the wording next time.

> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> ---
> pw-bot: cr

