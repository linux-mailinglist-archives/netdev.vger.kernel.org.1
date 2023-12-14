Return-Path: <netdev+bounces-57691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F21C813E5E
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 00:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412E61C209B4
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 23:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048E66C6F1;
	Thu, 14 Dec 2023 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9gL077s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899636C6C0
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 23:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5e3338663b2so803297b3.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 15:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702597382; x=1703202182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ApDdsgZZXWyPkAVYc3DDzDyj84wM5OJ47AftUTJOkc=;
        b=D9gL077six8tFxlxjkvzO3V4idzj8IEKt2+i/MqYOdXoKwXE9Np9vbj+mj7Lzwp6qw
         RRPf0SJ+V5RxSz9fmEZPKdQbF0JhF27pjwlGTKZK0VThuZiMDV7Q6RAxk0TRWKB2LAZr
         cDie2sP3SMs8bAF21PjCQgKXKclNhd++1GQB8sa7zydMmkx8ijffLQfdCvUB9MUIHrNr
         ytwxWSnSwfh43k+I2DK3IhtVoqaGlrMwzG8gPdgQQ0PxBJVsu29wMZLUVAKzELzEsVYk
         lV3TrRPn9ZGx8SVW6FWDSrilkZe4BATZWHOTr4AlflVIC6KE8s0Ulv5AS+WFbg39c34c
         uYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702597382; x=1703202182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ApDdsgZZXWyPkAVYc3DDzDyj84wM5OJ47AftUTJOkc=;
        b=r+cAfDXMN4roqWCte7qyAxUf2+eYCGL2Kl071rAEeYZ4zCNF5mEmDaXcDBNkJZfhK5
         IkSTK4YieEY76It1e1q75FNp/Hc8Aq/eZ30T6YYt2H+pppq1JK6sNc7VA3r5lJGwVVJK
         c6aeFYlHWV1CcFkG4jiFxQTmPDngq3okATqyAFJuH951ybcnK5P4AsP30DkAlBxBl8ja
         WipcmASh2LkmzA1RwB6OtHLZiqN7c3Cc5Y+uHM0r2RoBGDCR6jxChXB6zIwLBv1qssg5
         k/dqLrX1hpLzemg2NloBVxEaToA/GRxAhsgcf1hXlBty1ozvVCoPWlv47LWPWCtdEHjX
         kIdw==
X-Gm-Message-State: AOJu0YzVHxenKwQFp7z+SgW+FrLaop14R1c/nd7PxwMlBFGLmIfZ3GXj
	u4KpNifRHAKIFaOOfnXLOko=
X-Google-Smtp-Source: AGHT+IHHot8CDWuCO5auRT6C92A1spi0EXSQEDusa2wfaqGwz+I12E41pMit2glc5eqJaADA+Ny8pA==
X-Received: by 2002:a0d:e212:0:b0:5e4:564a:997e with SMTP id l18-20020a0de212000000b005e4564a997emr95729ywe.54.1702597382390;
        Thu, 14 Dec 2023 15:43:02 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:fedc:17f9:23d3:6ac8? ([2600:1700:6cf8:1240:fedc:17f9:23d3:6ac8])
        by smtp.gmail.com with ESMTPSA id i130-20020a815488000000b005ce3c9dddc3sm5838869ywb.25.2023.12.14.15.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 15:43:02 -0800 (PST)
Message-ID: <b0c7a660-aece-4c5f-84b8-622d424d7118@gmail.com>
Date: Thu, 14 Dec 2023 15:43:00 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net/ipv6: insert a f6i to a GC list only
 if the f6i is in a fib6_table tree.
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, thinker.li@gmail.com,
 netdev@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: kuifeng@meta.com, syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
References: <20231213213735.434249-1-thinker.li@gmail.com>
 <20231213213735.434249-2-thinker.li@gmail.com>
 <28f016bc-3514-444f-82df-719aeb2d013a@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <28f016bc-3514-444f-82df-719aeb2d013a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/23 22:11, David Ahern wrote:
> On 12/13/23 2:37 PM, thinker.li@gmail.com wrote:
>> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
>> index b132feae3393..dcaeb88d73aa 100644
>> --- a/net/ipv6/route.c
>> +++ b/net/ipv6/route.c
>> @@ -3763,10 +3763,10 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
>>   		rt->dst_nocount = true;
>>   
>>   	if (cfg->fc_flags & RTF_EXPIRES)
>> -		fib6_set_expires_locked(rt, jiffies +
>> -					clock_t_to_jiffies(cfg->fc_expires));
>> +		__fib6_set_expires(rt, jiffies +
>> +				   clock_t_to_jiffies(cfg->fc_expires));
>>   	else
>> -		fib6_clean_expires_locked(rt);
>> +		__fib6_clean_expires(rt);
> 
> as Eric noted in a past comment, the clean is not needed in this
> function since memory is initialized to 0 (expires is never set).
> 
> Also, this patch set does not fundamentally change the logic, so it
> cannot fix the bug reported in
> 
> https://lore.kernel.org/all/20231205173250.2982846-1-edumazet@google.com/
> 
> please hold off future versions of this set until the problem in that
> stack traced is fixed. I have tried a few things using RA's, but have
> not been able to recreate UAF.
Sure

