Return-Path: <netdev+bounces-28355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03D477F2A3
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C01A281DF4
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395F7100A9;
	Thu, 17 Aug 2023 09:01:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D954E55B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:01:56 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E067EE7C
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 02:01:54 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRJq51tkbzVkvX;
	Thu, 17 Aug 2023 16:59:45 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 17:01:51 +0800
Message-ID: <dd7e3f9a-1348-1d13-3b0b-5165070dd342@huawei.com>
Date: Thu, 17 Aug 2023 17:01:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] net: broadcom: Use helper function IS_ERR_OR_NULL()
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: <netdev@vger.kernel.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
	<rafal@milecki.pl>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Doug Berger
	<opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>
References: <20230816095357.2896080-1-ruanjinjie@huawei.com>
 <20230817071923.GB22185@unreal>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230817071923.GB22185@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/17 15:19, Leon Romanovsky wrote:
> On Wed, Aug 16, 2023 at 05:53:56PM +0800, Ruan Jinjie wrote:
>> Use IS_ERR_OR_NULL() instead of open-coding it
>> to simplify the code.
>>
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
>> ---
>>  drivers/net/ethernet/broadcom/bgmac.c        | 2 +-
>>  drivers/net/ethernet/broadcom/genet/bcmmii.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
>> index 10c7c232cc4e..4cd7c6abb548 100644
>> --- a/drivers/net/ethernet/broadcom/bgmac.c
>> +++ b/drivers/net/ethernet/broadcom/bgmac.c
>> @@ -1448,7 +1448,7 @@ int bgmac_phy_connect_direct(struct bgmac *bgmac)
>>  	int err;
>>  
>>  	phy_dev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
> 
> When can fixed_phy_register() return NULL?
> It looks like it returns or valid phy_dev or ERR_PTR().

It seems the following code has a problem:

226 static struct phy_device *__fixed_phy_register(unsigned int irq,
227                            struct fixed_phy_status *status,
228                            struct device_node *np,
229                            struct gpio_desc *gpiod)
230 {
231     struct fixed_mdio_bus *fmb = &platform_fmb;
232     struct phy_device *phy;
233     int phy_addr;
234     int ret;
235
236     if (!fmb->mii_bus || fmb->mii_bus->state != MDIOBUS_REGISTERED)
237         return ERR_PTR(-EPROBE_DEFER);
238
239     /* Check if we have a GPIO associated with this fixed phy */
240     if (!gpiod) {
241         gpiod = fixed_phy_get_gpiod(np);
242         if (IS_ERR(gpiod))
243             return ERR_CAST(gpiod);
244     }

fixed_phy_get_gpiod() return valid gpio_desc or NULL.If
fixed_phy_get_gpiod(np) failed, the error can not be returned with
IS_ERR(gpiod) is true, so the 243 line code is a dead code.

> 
> Thanks
> 
> 
>> -	if (!phy_dev || IS_ERR(phy_dev)) {
>> +	if (IS_ERR_OR_NULL(phy_dev)) {
>>  		dev_err(bgmac->dev, "Failed to register fixed PHY device\n");
>>  		return -ENODEV;
>>  	}
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
>> index 0092e46c46f8..aa9a436fb3ce 100644
>> --- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
>> @@ -617,7 +617,7 @@ static int bcmgenet_mii_pd_init(struct bcmgenet_priv *priv)
>>  		};
>>  
>>  		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
>> -		if (!phydev || IS_ERR(phydev)) {
>> +		if (IS_ERR_OR_NULL(phydev)) {
>>  			dev_err(kdev, "failed to register fixed PHY device\n");
>>  			return -ENODEV;
>>  		}
>> -- 
>> 2.34.1
>>
>>

