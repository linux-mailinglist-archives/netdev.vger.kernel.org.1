Return-Path: <netdev+bounces-42582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFA87CF696
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7C11C2098E
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 11:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ABB1944E;
	Thu, 19 Oct 2023 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ALrZW5e+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5543F19442
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 11:22:03 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FEA12F
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 04:21:58 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c77449a6daso64073115ad.0
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 04:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697714517; x=1698319317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+pZUkJVQsJVYjHJbhfYRUL1BGoXYIgN45kZzTiGXTQQ=;
        b=ALrZW5e+yyjg56xjvaR0sJ3nlXARIc9t4B44KPzrtq2Gn954xVVw8D4QbvSX2mqqXw
         Gf1v9zk0LHlPpN/yI9NyIGGt13ArQO6it9Er11JZKB7peHF2XQOq+13mfhum3z7vt0OV
         uW8K+7GPkSTmQVeiPE28ZQut6fdfHrWq5zjkxRfgx+SxZkLBjWeUHIIyZiuLbTIstZGA
         MIAepzUh766Re4ClvvvHFTPsobvW7jkpCEmi6y59L4Z9ZPTFbg3raizKprP0OmOs8oL3
         y/XFJj6iOfuR+K29ErJuguE6iQDB9wcN7HwQcfuyicFIJ8ibrl5s6ebizv4x7R2yCnxO
         q0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697714517; x=1698319317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pZUkJVQsJVYjHJbhfYRUL1BGoXYIgN45kZzTiGXTQQ=;
        b=NatMDAto1sIo/HnL38Ozjkg1X3wQ75K9OFqkLoD8wYcRHABYZPILJjj/snMgQYPnJ7
         9snXNNw9jd30oJU9JJZd27H9K71/uxDOAvBRdiEFyMe0x0jfPMJXA3FEXYYZk9b7fQv2
         FwM7wQtnJrEvSsaSn4SliH3Ke1AowzwCaXul8p/Cd7ZATj6A/6mU22Zj6ANu2HsC55Kd
         IBPHrBpJRnExXVzVLF/cpqekvYtabpwM+gNKwbMl6JzUsJvT3rB6hhFI9C3OwSJDxNmZ
         IIVTx3/Ry3M1ZF0MnUKZ1yyeA4ZcM6iFQZ2Q8ZJk+yMOSm+D8C+XnMEUovYaE+/8w58W
         gWVg==
X-Gm-Message-State: AOJu0YyeAlebj5Tfg6kkSGiWrjSBqMraYO92sxzMpkC7ZOd9SHDEAg3l
	29v7bHyp9qanQtZi6RsY0q0A4kifJRN0x59D+d0=
X-Google-Smtp-Source: AGHT+IEQcz6xBFwuBkQxgnbo3UVJhoruTv5UOA95CIsVn1e3IC4x0Scxa9t7KIKwkdhiTCtOuiCwPw==
X-Received: by 2002:a17:902:ec88:b0:1c7:733b:27c7 with SMTP id x8-20020a170902ec8800b001c7733b27c7mr2029569plg.56.1697714516999;
        Thu, 19 Oct 2023 04:21:56 -0700 (PDT)
Received: from [10.84.154.4] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id jb11-20020a170903258b00b001c9c6a78a56sm1708399plb.97.2023.10.19.04.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 04:21:56 -0700 (PDT)
Message-ID: <5283655b-b8c6-43da-939e-5a0d088caad6@bytedance.com>
Date: Thu, 19 Oct 2023 19:21:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH net-next v2 3/3] sock: Fix improper heuristic on
 raising memory
To: Shakeel Butt <shakeelb@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231016132812.63703-1-wuyun.abel@bytedance.com>
 <20231016132812.63703-3-wuyun.abel@bytedance.com>
 <CALvZod6FRH2cp2D2uECeAesGY575+mE_iyFwaXVJMbfk1jvcgQ@mail.gmail.com>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CALvZod6FRH2cp2D2uECeAesGY575+mE_iyFwaXVJMbfk1jvcgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/16/23 11:52 PM, Shakeel Butt Wrote:
> On Mon, Oct 16, 2023 at 6:28 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> Before sockets became aware of net-memcg's memory pressure since
>> commit e1aab161e013 ("socket: initial cgroup code."), the memory
>> usage would be granted to raise if below average even when under
>> protocol's pressure. This provides fairness among the sockets of
>> same protocol.
>>
>> That commit changes this because the heuristic will also be
>> effective when only memcg is under pressure which makes no sense.
>> Fix this by reverting to the behavior before that commit.
>>
>> After this fix, __sk_mem_raise_allocated() no longer considers
>> memcg's pressure. As memcgs are isolated from each other w.r.t.
>> memory accounting, consuming one's budget won't affect others.
>> So except the places where buffer sizes are needed to be tuned,
>> allow workloads to use the memory they are provisioned.
>>
>> Fixes: e1aab161e013 ("socket: initial cgroup code.")
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> 
> Acked-by: Shakeel Butt <shakeelb@google.com>

Thanks!

