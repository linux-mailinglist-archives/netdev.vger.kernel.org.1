Return-Path: <netdev+bounces-23652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0324C76CED0
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20D2281B0E
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 13:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF13749A;
	Wed,  2 Aug 2023 13:33:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B279C0
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 13:33:29 +0000 (UTC)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560842711
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 06:33:26 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d1fb9107036so7257128276.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 06:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690983205; x=1691588005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=plUCH7IIomj9/sBQZlwwIIcnImU8ykx0MKZLprtjruM=;
        b=Vxn45ngM/S413fCFMYZExg0am5eXMRpgpd5yBTi6U5boGIK/m8Im5Y+p2eAlLUgTSH
         DPvOtpzzgvZj4i5GEm16v7bC/mv4l4rbCdNUIXwkc5rHzyYR1WvLiS4pbCbww7dcGMeY
         eM3qkt9zumgWm4mYJqnurmtx3Y5E9qRVks186WCTw3S/tj51CDEKDEM7y1EmZhn4qrCG
         qO2s3+nfz/F6A6Gpo7/paybZjV4jE7OYIHwyaKHmYvh9S2vVm8u3OyHIj86sjT9s5apj
         JI60kqi832iL1ovwPvXMjjidYGwrz5oyHs2nnvlDp3EyL2RqKl+knSSjkpLb02W5Z2fe
         PQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690983205; x=1691588005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plUCH7IIomj9/sBQZlwwIIcnImU8ykx0MKZLprtjruM=;
        b=JAUx7WMYS4VrqjpwT1KG1Gp5RllZYt9G01+t98dM2jDBGgQS0QWWBpK/SvI75tFzMV
         +rZYBzhts4yBTjtri2VbVDlzAL5jA4F71OPTX7P+vvCWusVzllCg6oxpDv3ygI2gzMcg
         nyMN48YFgKiZ68ih7KeYfoMHpQkcnGOUQAfeEq0CL6MsxSIjRDSC9RCQsMxH1yUcT+PB
         ER1PHQyuvsO6FiqObyNLTvrbdnIjRV6hlTsBOJ1lLqhravy1BNiiRiZqzFvIpooKvcEI
         84SQYF6gNXz6vOwC1oR6MshcO1bTLRcp557mif0RUS8MtBZXoXLDIlSw+clGJnf1kfi7
         NGoA==
X-Gm-Message-State: ABy/qLbfxNGlXr4An9XuK+1jflY//e0PAnUz2ELuvcSY27be8QDx8/66
	kn1MUEVIZ1W7jaE7pCu8s7vt/gT4ZZS9Aytg5l4=
X-Google-Smtp-Source: APBJJlHPmwi2cn6YGMSQPMVq8dyUENT67RU6/1OfLZ1u6PJlaAXE3JiqFZkkAp+jQhZTWhepF48Eiw==
X-Received: by 2002:a25:d2c3:0:b0:d05:6a14:6cbc with SMTP id j186-20020a25d2c3000000b00d056a146cbcmr15039172ybg.28.1690983205234;
        Wed, 02 Aug 2023 06:33:25 -0700 (PDT)
Received: from [172.22.22.28] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id x78-20020a25ce51000000b00d16445dc37fsm3857291ybe.12.2023.08.02.06.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 06:33:24 -0700 (PDT)
Message-ID: <f19933ef-346c-e777-4b1e-f53291d90feb@linaro.org>
Date: Wed, 2 Aug 2023 08:33:23 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] cirrus: cs89x0: fix the return value handle and
 remove redundant dev_warn() for platform_get_irq()
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, Ruan Jinjie <ruanjinjie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, wei.fang@nxp.com, robh@kernel.org,
 bhupesh.sharma@linaro.org, arnd@arndb.de, netdev@vger.kernel.org
References: <20230801133121.416319-1-ruanjinjie@huawei.com>
 <ZMoUjMGxhUZ9v2pT@kernel.org>
From: Alex Elder <elder@linaro.org>
In-Reply-To: <ZMoUjMGxhUZ9v2pT@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/2/23 3:32 AM, Simon Horman wrote:
> + Alex Elder
> 
> On Tue, Aug 01, 2023 at 09:31:21PM +0800, Ruan Jinjie wrote:
>> There is no possible for platform_get_irq() to return 0
>> and the return value of platform_get_irq() is more sensible
>> to show the error reason.
>>
>> And there is no need to call the dev_warn() function directly to print
>> a custom message when handling an error from platform_get_irq() function as
>> it is going to display an appropriate error message in case of a failure.
>>
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

First, I agree that the dev_warn() is unnecessary.

On the "<" versus "<=" issue is something I've commented on before.

It's true that 0 is not (or should not be) a valid IRQ number.  But
at one time a several years back I couldn't convince myself that it
100% could not happen.  I no longer remember the details, and it
might not have even been in this particular case (i.e., return
from platform_get_irq()).

I do see that a85a6c86c25be ("driver core: platform: Clarify that
IRQ 0 is invalid)" got added in 2020, and it added a WARN_ON()
in platform_get_irq_optional() before returning the IRQ number if
it's zero.  So in this case, if it *did* happen to return 0,
you'd at least get a warning.

So given that you'll get a warning on a bogus 0 IRQ number, I have
no problem with this part of the patch either.

					-Alex

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
>> ---
>>   drivers/net/ethernet/cirrus/cs89x0.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/cirrus/cs89x0.c b/drivers/net/ethernet/cirrus/cs89x0.c
>> index 7c51fd9fc9be..d323c5c23521 100644
>> --- a/drivers/net/ethernet/cirrus/cs89x0.c
>> +++ b/drivers/net/ethernet/cirrus/cs89x0.c
>> @@ -1854,9 +1854,8 @@ static int __init cs89x0_platform_probe(struct platform_device *pdev)
>>   		return -ENOMEM;
>>   
>>   	dev->irq = platform_get_irq(pdev, 0);
>> -	if (dev->irq <= 0) {
>> -		dev_warn(&dev->dev, "interrupt resource missing\n");
>> -		err = -ENXIO;
>> +	if (dev->irq < 0) {
>> +		err = dev->irq;
>>   		goto free;
>>   	}
>>   
>> -- 
>> 2.34.1
>>
>>


