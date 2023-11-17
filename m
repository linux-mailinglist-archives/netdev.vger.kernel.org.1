Return-Path: <netdev+bounces-48657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551FA7EF23D
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 13:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCBF280FC7
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2129C2CCBB;
	Fri, 17 Nov 2023 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="DK7B9YQC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FD8B9
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 04:06:17 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso1444891b3a.1
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 04:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700222777; x=1700827577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YFm5Pu0agEK9a7iJvBBpcsBGBSXE9+wDQ7nErPyNqnY=;
        b=DK7B9YQCnRFzzbVXiVgUtLE/+04ba5a3V5C82TqZBvy4PsvGMJ5Yr4ltCKuEZk70+F
         RDqeUHsNhTLNVm/31HmdohcpnozZ8lrQJqLdSi9EL6MVLm2YalV/CnaTBFDP0EbakqoH
         SeuVlNbY4FDuNZnD8fQ81vg4EWc0A+pvb0kGuA3n5/U65PUz3hV1rALtHX6xk1K3lhZs
         sakspbE8p8BI8hcj7GRuXrD5dkYE3df0DpyaroI8qTicnhAf2MOjAqV/gQ+p+mALbh5V
         tqrVlzRQFZSd72KN3Q1R1oseWIgH+vEr8v27/8BJqUT+q7JyIicHjJ+5oOBhV3uWX0PW
         hODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700222777; x=1700827577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFm5Pu0agEK9a7iJvBBpcsBGBSXE9+wDQ7nErPyNqnY=;
        b=rSfDKVJjreck+pHHiEZIxpDJs469lN+niVAadLFI18lro5IdjsnncDbf97Re4Jpfy6
         jrSodp2jU6C0bD3+XE4uJRrXmrjrfIkBXfD03fkePQDQVVkk9JV0WB23R94+o+15efBD
         TtGBKt5ujjUF/BxS1z0JRH8ZB/wAiqVkALxAiQhy3qWn2qWPUneII0/fy7SteLZNjzQf
         qzwFYU5crxAq1VIScD/ldqIRmCA8RvDQLoSqWNG+acvIp5X1wq9fGLWbv2/lx40bqACB
         09uvYfZx/gcnaTH+ILPNY5QgVuV+oClu7fHccY7W4T0CENht8C+ZfWKnT/LeuM+PH3Um
         A9Ow==
X-Gm-Message-State: AOJu0YwA2L6AxZeAD9IfV1uOqF/FZUv78dws0DWeVHwf/hVPWKn8nAjG
	eY3Tivs1gDmGSaRGm3j4hwGo5w==
X-Google-Smtp-Source: AGHT+IG5/JAITrdtmzXFF8GueoT0ZXmJ4X6D5BBH37fSr59QAckV81gP7OL0XDyQTobtzutUDO6rgQ==
X-Received: by 2002:a05:6a00:310f:b0:6c4:d6fa:ee9d with SMTP id bi15-20020a056a00310f00b006c4d6faee9dmr6293709pfb.1.1700222776972;
        Fri, 17 Nov 2023 04:06:16 -0800 (PST)
Received: from ?IPV6:2804:14d:5c5e:44fb:7741:c354:44be:5c3f? ([2804:14d:5c5e:44fb:7741:c354:44be:5c3f])
        by smtp.gmail.com with ESMTPSA id g31-20020a63565f000000b005891f3af36asm1262704pgm.87.2023.11.17.04.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 04:06:16 -0800 (PST)
Message-ID: <b9a9aaef-a306-4fcf-83df-28140d9311bf@mojatatu.com>
Date: Fri, 17 Nov 2023 09:06:11 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: sched: Fix restricted __be16 degrades to integer
Content-Language: en-US
To: Kunwu Chan <chentao@kylinos.cn>, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: kunwu.chan@hotmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231117101815.1867175-1-chentao@kylinos.cn>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20231117101815.1867175-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/11/2023 07:18, Kunwu Chan wrote:
> net/sched/cls_api.c:2010:25: warning: restricted __be16 degrades to integer
> net/sched/cls_api.c:2695:50: warning: restricted __be16 degrades to integer
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>   net/sched/cls_api.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index f73f39f61f66..4c47490eb0c1 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -2007,7 +2007,7 @@ static int tcf_fill_node(struct net *net, struct sk_buff *skb,
>   		tcm->tcm_ifindex = TCM_IFINDEX_MAGIC_BLOCK;
>   		tcm->tcm_block_index = block->index;
>   	}
> -	tcm->tcm_info = TC_H_MAKE(tp->prio, tp->protocol);
> +	tcm->tcm_info = TC_H_MAKE(tp->prio, be16_to_cpu(tp->protocol));
>   	if (nla_put_string(skb, TCA_KIND, tp->ops->kind))
>   		goto nla_put_failure;
>   	if (nla_put_u32(skb, TCA_CHAIN, tp->chain->index))
> @@ -2692,7 +2692,7 @@ static bool tcf_chain_dump(struct tcf_chain *chain, struct Qdisc *q, u32 parent,
>   		    TC_H_MAJ(tcm->tcm_info) != tp->prio)
>   			continue;
>   		if (TC_H_MIN(tcm->tcm_info) &&
> -		    TC_H_MIN(tcm->tcm_info) != tp->protocol)
> +		    TC_H_MIN(tcm->tcm_info) != be16_to_cpu(tp->protocol))
>   			continue;
>   		if (*p_index > index_start)
>   			memset(&cb->args[1], 0,

I don't believe there's something to fix here

