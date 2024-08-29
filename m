Return-Path: <netdev+bounces-123028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3BF9637D9
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 03:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642821F24621
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5BC15AC4;
	Thu, 29 Aug 2024 01:34:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BAD1CA85
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 01:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724895296; cv=none; b=Uvo+LiGPyI4JRk9BsdK9v4IYuwyigOVTLqj20vF/GxU5wlcOijUA8rlU99euMFEWagyCYBHg3nJA8/r7eXLIIlNubrmW31HDYzXF6JnzJN1oS8VBfaf/k18CUfe5Gp9W0dAabnFyugUy+EuOhaOLFafVEHAOcTCtw5VemcDYb30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724895296; c=relaxed/simple;
	bh=eHwm+/XjMy0pnEXx4xXPCJA99CEvAHyQIM4lTPq3jKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FKI+PwG5d0t+BY1A1aKBdMuqj263wOEoEyiZWaom1P9GjA1ggyUQXSWQBNLDQQPNPoelVnBpC0NomeJqtjbWR8AEpWYRr08qktqfMJPvj8rv5QTOrizcvAtoVFKLUIPY8PW6cAcEZ+gsO+0lhf6Me9Aec7zGczuTqUsBDPBDpDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WvP0t1mGYzfbhF;
	Thu, 29 Aug 2024 09:32:46 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F62E1800D2;
	Thu, 29 Aug 2024 09:34:50 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 09:34:50 +0800
Message-ID: <873edfae-a174-4f3d-a9cb-bb9126fa461a@huawei.com>
Date: Thu, 29 Aug 2024 09:34:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: realtek: make use of
 dev_err_cast_probe()
Content-Language: en-US
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
CC: "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20240828121805.3696631-1-lihongbo22@huawei.com>
 <kluyezsiuntl635hlc2lgnbxytmhirt6ej5txcoleaakdw27nm@zami2pb2bmn5>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <kluyezsiuntl635hlc2lgnbxytmhirt6ej5txcoleaakdw27nm@zami2pb2bmn5>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/29 0:14, Alvin Šipraga wrote:
> On Wed, Aug 28, 2024 at 08:18:05PM GMT, Hongbo Li wrote:
>> Using dev_err_cast_probe() to simplify the code.
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   drivers/net/dsa/realtek/rtl83xx.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
>> index 35709a1756ae..3c5018d5e1f9 100644
>> --- a/drivers/net/dsa/realtek/rtl83xx.c
>> +++ b/drivers/net/dsa/realtek/rtl83xx.c
>> @@ -185,11 +185,9 @@ rtl83xx_probe(struct device *dev,
>>
>>          /* TODO: if power is software controlled, set up any regulators here */
>>          priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
>> -       if (IS_ERR(priv->reset_ctl)) {
>> -               ret = PTR_ERR(priv->reset_ctl);
>> -               dev_err_probe(dev, ret, "failed to get reset control\n");
>> -               return ERR_CAST(priv->reset_ctl);
>> -       }
>> +       if (IS_ERR(priv->reset_ctl))
>> +               return dev_err_cast_probe(dev, priv->reset_ctl,
>> +                                         "failed to get reset control\n");
> 
> The change is fine, but maybe it would be nice to fix up the other two
> similar cases as well? The errors would be stringified but that's OK.
> 
>     159          rc.lock_arg = priv;
>     160          priv->map = devm_regmap_init(dev, NULL, priv, &rc);
>     161          if (IS_ERR(priv->map)) {
>     162                  ret = PTR_ERR(priv->map);
>     163                  dev_err(dev, "regmap init failed: %d\n", ret);
>     164                  return ERR_PTR(ret);
It's similar, but not the same. Now we just have the dev_err_cast_probe 
which wraps the dev_err_probe. The dev_err_probe is not completely 
equivalent to dev_err.

Thanks,
Hongbo

>     165          }
>     166
>     167          rc.disable_locking = true;
>     168          priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc);
>     169          if (IS_ERR(priv->map_nolock)) {
>     170                  ret = PTR_ERR(priv->map_nolock);
>     171                  dev_err(dev, "regmap init failed: %d\n", ret);
>     172                  return ERR_PTR(ret);
>     173          }
> 
> Then you can remove the ret variable altogether.
> 
> Either way,
> 
> Reviewed-by: Alvin Šipraga <alsi@bang-olufsen.dk>

