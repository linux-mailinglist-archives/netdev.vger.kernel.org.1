Return-Path: <netdev+bounces-28445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971BF77F788
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC88281EE5
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77571426F;
	Thu, 17 Aug 2023 13:20:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1B914005
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 13:20:33 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0981FF3
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 06:20:32 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RRQXW2z3GzFqYm;
	Thu, 17 Aug 2023 21:17:31 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 21:20:29 +0800
Message-ID: <d9b2e230-b5d4-312a-eb38-18300762a61c@huawei.com>
Date: Thu, 17 Aug 2023 21:20:28 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next v2 4/4] net: lan743x: Fix return value check for
 fixed_phy_register()
Content-Language: en-US
To: Heiner Kallweit <hkallweit1@gmail.com>, <rafal@milecki.pl>,
	<bcm-kernel-feedback-list@broadcom.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<opendmb@gmail.com>, <florian.fainelli@broadcom.com>,
	<bryan.whitehead@microchip.com>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<mdf@kernel.org>, <pgynther@google.com>,
	<Pavithra.Sathyanarayanan@microchip.com>, <netdev@vger.kernel.org>
References: <20230817121631.1878897-1-ruanjinjie@huawei.com>
 <20230817121631.1878897-5-ruanjinjie@huawei.com>
 <db0fd284-0b5b-3290-6661-f159908e9918@gmail.com>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <db0fd284-0b5b-3290-6661-f159908e9918@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/17 20:43, Heiner Kallweit wrote:
> On 17.08.2023 14:16, Ruan Jinjie wrote:
>> fixed_phy_register() function returns -EPROBE_DEFER, -EINVAL and -EBUSY,
>> etc, but not return -EIO. use PTR_ERR to fix the issue.
>>
>> Fixes: 624864fbff92 ("net: lan743x: add fixed phy support for LAN7431 device")
> 
> This isn't a fix. Returning -EIO isn't wrong. Returning the original errno values
> may be better, but that's an improvement.

Sorry! I'll remove this fix tag in the next version.

> Also combining "net-next" with a Fixes tag is wrong, except the functionality
> was added very recently.

Thank you! I'll keep an eye on these in the future.

> 
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
>> ---
>>  drivers/net/ethernet/microchip/lan743x_main.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
>> index a36f6369f132..c81cdeb4d4e7 100644
>> --- a/drivers/net/ethernet/microchip/lan743x_main.c
>> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
>> @@ -1515,7 +1515,7 @@ static int lan743x_phy_open(struct lan743x_adapter *adapter)
>>  							    &fphy_status, NULL);
>>  				if (IS_ERR(phydev)) {
>>  					netdev_err(netdev, "No PHY/fixed_PHY found\n");
>> -					return -EIO;
>> +					return PTR_ERR(phydev);
>>  				}
>>  			} else {
>>  				goto return_error;
> 

