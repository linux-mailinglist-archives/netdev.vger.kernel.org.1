Return-Path: <netdev+bounces-28434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B48377F6E3
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 14:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC24C1C213C3
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 12:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF8B13FF6;
	Thu, 17 Aug 2023 12:54:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B8B13FF5
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 12:54:28 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E095F30C6
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 05:54:26 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RRPyP5PHHzFqZx;
	Thu, 17 Aug 2023 20:51:25 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 20:54:23 +0800
Message-ID: <8bf301db-83ff-ba93-f69e-092789e7177b@huawei.com>
Date: Thu, 17 Aug 2023 20:54:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next 2/3] amd-xgbe: Return proper error code for
 get_phy_device()
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: <Shyam-sundar.S-k@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <iyappan@os.amperecomputing.com>,
	<keyur@os.amperecomputing.com>, <quan@os.amperecomputing.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <yankejian@huawei.com>,
	<netdev@vger.kernel.org>
References: <20230817074000.355564-1-ruanjinjie@huawei.com>
 <20230817074000.355564-3-ruanjinjie@huawei.com>
 <b1887aa8-3327-497a-bd23-680b533f6356@lunn.ch>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <b1887aa8-3327-497a-bd23-680b533f6356@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/17 20:28, Andrew Lunn wrote:
> On Thu, Aug 17, 2023 at 03:39:59PM +0800, Ruan Jinjie wrote:
>> get_phy_device() returns -EIO on bus access error and -ENOMEM
>> on kzalloc failure in addition to -ENODEV, just return -ENODEV is not
>> sensible, use PTR_ERR(phydev) to fix the issue.
> 
> Rather than say 'not sensible', it would be better to say 'Best
> practice is to return these error codes'.

Thank you! I'll watch the wording next time.

> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> 
>     Andrew
> 
> ---
> pw-bot: cr

