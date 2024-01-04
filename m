Return-Path: <netdev+bounces-61643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24557824764
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 18:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A122CB25064
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4583C25572;
	Thu,  4 Jan 2024 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONCkK2Va"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87952557B
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbdb124491cso542618276.1
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 09:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704389072; x=1704993872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZATCJuCne5vU4JjCyQYXye/YLLWUyPQA304QZqyKIw=;
        b=ONCkK2VaTjy7eSOyZ1ePTovzhkWkLc1GbUAx7Zy2j2LWXBbVSViPLJ4xOpHdSnJgXC
         tgEuZjwFVDm7m9arvx/gyqt/eL9kCxrYGOvaFL9thMB8i9b5HSeRLUv4AW/6dHrZ38gN
         p5NY6aBLnf+fFg6QQ2lu/e2sGtvUSA1KOsnI1f5cj/pbdsDxfbcLMdDA9y38u/ELpw0Y
         mtR2h01cBlmL4zY6Z0Jiws0QG0n6wOpiWGjpTa1lMPsoNCvQz1WWTsCZ/bxrW4PkmWzL
         lUWm3CBiD3X0qYCUamHxrDomM22ilEtDGH1MDFQ/AdQCbS+e7L9KRgc3Uu+S3ObMK8z7
         IBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704389072; x=1704993872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZATCJuCne5vU4JjCyQYXye/YLLWUyPQA304QZqyKIw=;
        b=PaBkIeQGIVTvdAc+DochmM/Ls0hI3YHysCYBn5GOJczJKJNw4XfdpXV3HHNjVsS66t
         wHEnxUtsrUP2eXCio/qzrIgleVfc+SVm0x0wCjk9TSUAaMeyDJ0izss5DWCKpQDypiie
         U8Y0FLnI2lTWz31ZHOQoslEqmTFgUT1kdnh0hV/huco18nwkyQVM6rRhnqq4+zjTon8b
         XKXIpVBV8boNyn8O0vF8R/mgsW7osXJCMD45jH3uBzO59VAH5d7hQc7IDcqHhQgfWWqx
         lnEfZKfNPuxb7BRP6Iiw5SV1RnpvRCSjF9/YjySG58DxCT36Ha1EwqXMCPzTJfKbE8BV
         JjfA==
X-Gm-Message-State: AOJu0Yw3vOaD1pPLXrRfh+HeI3dX+qF9wTLUAxrc48QObShnl61dj8Hv
	4HmtLrFGHYdNrVNsuKVnsD4=
X-Google-Smtp-Source: AGHT+IH3zIaNR83TuwNIboNm3WwQc0qv8rVw/JgZVENSrnKCwGAA3eFN2Zal1hRtvdvF681BGqC7Tw==
X-Received: by 2002:a25:fe0d:0:b0:dbe:30f2:48c1 with SMTP id k13-20020a25fe0d000000b00dbe30f248c1mr609506ybe.1.1704389071582;
        Thu, 04 Jan 2024 09:24:31 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:bc3f:8a99:d840:9c38? ([2600:1700:6cf8:1240:bc3f:8a99:d840:9c38])
        by smtp.gmail.com with ESMTPSA id e81-20020a25d354000000b00db41482d349sm11774577ybf.57.2024.01.04.09.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 09:24:31 -0800 (PST)
Message-ID: <19913177-e83a-4900-8404-b7aa61421173@gmail.com>
Date: Thu, 4 Jan 2024 09:24:29 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net/sched - kernel crashes when replacing a qdisc node.
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, pctammela@mojatatu.com,
 "David S. Miller" <davem@davemloft.net>, Andrii Nakryiko
 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@meta.com>
References: <ce8d3e55-b8bc-409c-ace9-5cf1c4f7c88e@gmail.com>
 <20240103180426.2db116ea@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240103180426.2db116ea@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/3/24 18:04, Jakub Kicinski wrote:
> On Wed, 3 Jan 2024 17:41:54 -0800 Kui-Feng Lee wrote:
>> The kernel crashes when running selftests/bpf/prog_tests/lwt_reroute.c.
>> We got the error message at end of this post.
>>
>> It happens when lwt_reroute.c running the shell command
>>
>>     tc qdisc replace dev tun0 root fq limit 5 flow_limit 5
>>
>> The kernel crashes at the line
>>
>>     block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
> 
> This is the same as
> https://lore.kernel.org/all/20231231172320.245375-1-victor@mojatatu.com/#r
> right?

Yes, it is! Thanks for the information.

