Return-Path: <netdev+bounces-19582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C0475B43A
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 18:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17EF1C2148D
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F9818B0A;
	Thu, 20 Jul 2023 16:31:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEA419BAC
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 16:31:18 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C1D11D
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 09:31:17 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1b055511b85so737614fac.2
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 09:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689870677; x=1690475477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=04TTTzXXJm1kjWU6dKrTzMW/tNU6aBvs6m187AegWPA=;
        b=K0GzR3ecZoB3gtOC9vC/QCm8RP+dcEfmKcagAyZOnR1nzr/GAEuz24TfZapQhYJA/e
         7OYXkUEyN3T1HKqciEqxSE0WhUYBtTRmtkxAhmHXUyW0lqDv4FvMoxwrGvGFmZpV/aZH
         b2Sd1HdHZen8K9+a8G5RwHTf0oPYJUe6N3MMrWlY+0dQIgeYJq3ksn2Ttfo8ARB9y32S
         wdvO9tcOpOhMXMG5I4ZU2muGflzuouhQNpBcrR7OMHtMF2plel4Skeyp8ZpCZdM7rmLV
         MB1bYI2/fkh+fomDHeKxNLOJtUnNSZA/0C3F4rsEPk839ZlNN/z0aFG9pywSJHHc38VR
         uiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689870677; x=1690475477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04TTTzXXJm1kjWU6dKrTzMW/tNU6aBvs6m187AegWPA=;
        b=G967WY+h8YyEIRoSCzO5YXgSLJDVOHTeMKFWr2euK9GGPI7dXmZL1Kcu0Ek6r9u7eh
         llvOX0GJUiRV+G7OjTFavLNbGWwuKBklMkWVLRuFKaOjJgPIdOQLfmREQPdRAYm6nocI
         ontDjR2tslGlK/YYC/AlgsUOhW0lVh7zO9fpI35HwyZ161QbAiqru76NvY0O/ALxk84N
         0kZtY4uIP3hd/nrKBLw1W/dIZ7JapIjCWOhd+lZT6pLq7ldZBuPvAu3t1lP88DWgwlO2
         GMn+Y6ou5hvLnqo0FMGJrFaU2ozkXeoEbpeVxOA8Kpkzmz75yf4yAatxjHdljPR1LLqF
         5aqA==
X-Gm-Message-State: ABy/qLb53wpK+U34EWsCDUGSnCO7y/X1gOKH9o9UCLixr+kZy++cWPLH
	6Psshmn/RaCahUMEqS2UTeY=
X-Google-Smtp-Source: APBJJlGTc1zug+GNj7Ku+Gx8UG8WSjO29uKWK5X1suJJ6fMOO4+HhUm3AMN/dDlS3uDwv/ENCA0ayw==
X-Received: by 2002:a05:6871:892:b0:1b0:2ded:bd7 with SMTP id r18-20020a056871089200b001b02ded0bd7mr10534oaq.26.1689870676885;
        Thu, 20 Jul 2023 09:31:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:4771:fc2f:6356:aa8e? ([2600:1700:6cf8:1240:4771:fc2f:6356:aa8e])
        by smtp.gmail.com with ESMTPSA id s124-20020a818282000000b005702bfb19bfsm294953ywf.130.2023.07.20.09.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 09:31:16 -0700 (PDT)
Message-ID: <8e169f8b-ce02-71ba-e562-696dc50c12dd@gmail.com>
Date: Thu, 20 Jul 2023 09:31:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v2 1/2] net/ipv6: Remove expired routes with a
 separated list of routes.
To: Paolo Abeni <pabeni@redhat.com>, Kui-Feng Lee <thinker.li@gmail.com>,
 dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, yhs@meta.com
Cc: Kui-Feng Lee <kuifeng@meta.com>
References: <20230718180321.294721-1-kuifeng@meta.com>
 <20230718180321.294721-2-kuifeng@meta.com>
 <32fa8af544b90be8c70ac52135fcb75aa7504f21.camel@redhat.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <32fa8af544b90be8c70ac52135fcb75aa7504f21.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/20/23 02:18, Paolo Abeni wrote:
> On Tue, 2023-07-18 at 11:03 -0700, Kui-Feng Lee wrote:
>> FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a tree
>> can be expensive if the number of routes in a table is big, even if most of
>> them are permanent. Checking routes in a separated list of routes having
>> expiration will avoid this potential issue.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> 
> There is a mismatch between the sender (Kui-Feng Lee
> <thinker.li@gmail.com>) and the SoB tag, please either change the sob
> or add a From: header tag to fix such mismatch.
> 
>> @@ -2312,6 +2323,40 @@ static int fib6_age(struct fib6_info *rt, void *arg)
>>   	return 0;
>>   }
>>   
>> +static void fib6_gc_table(struct net *net,
>> +			  struct fib6_table *tb6,
>> +			  void *arg)
> 
> Here 'arg' is actually 'struct fib6_gc_args *', you can/should update
> the type (and name) accordingly ...

Sure!

> 
>> +{
>> +	struct fib6_info *rt;
>> +	struct hlist_node *n;
>> +	struct nl_info info = {
>> +		.nl_net = net,
>> +		.skip_notify = false,
>> +	};
>> +
>> +	hlist_for_each_entry_safe(rt, n, &tb6->tb6_gc_hlist, gc_link)
>> +		if (fib6_age(rt, arg) == -1)
>> +			fib6_del(rt, &info);
>> +}
>> +
>> +static void fib6_gc_all(struct net *net, void *arg)
> 
> ... same here.
> 
> 
> Cheers,
> 
> Paolo
> 
> 

