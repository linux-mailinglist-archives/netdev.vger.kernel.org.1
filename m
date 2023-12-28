Return-Path: <netdev+bounces-60496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0E781F901
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 15:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF32284672
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 14:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7563E8831;
	Thu, 28 Dec 2023 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="bJhOcTC8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6C6881E
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28c934be96fso788640a91.0
        for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 06:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703772788; x=1704377588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=anZ4HtPp1NShGWPtRHzX2zGO46dyP0CC9Jy6axlS18M=;
        b=bJhOcTC8088ucDv17hwg3QkWwjEkM8mhXcH6JFxTUA8P31WhBna5EIKV9MHW/HYlhW
         1benYJF9Y17zHPkxXsUf5KbkYuhUY9yDa7k8q0Oq5e3rSscn0r+7kX6o4nIvyPz50Ph7
         9b0mea+67nq42hXX6dVUH4BBWaYbLn/hPhhubsPjfHhFG0gV3rW4Qy5rLoEDtm4Bu7wq
         CpXxr+ooraIDOMSTSNdrwrc0zPSlTWyX9HUNFOfnARF3pb1VZkBZO+ha/WMHxeuOL0BZ
         kC/QvHVspcWqsf2bBpSk8GPliNqRVe9s4mdN20azkphZ27zlcgf+Q/Wg1NIMirYgmX+/
         m+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703772788; x=1704377588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anZ4HtPp1NShGWPtRHzX2zGO46dyP0CC9Jy6axlS18M=;
        b=nHbvyS6YC1Lc1iEgFc5b7eUtCf/ldEmm0Baq0La6vIhVCxIbxQgYsRKpNn95j7HCds
         Rydg9AmGbwqtbqyieMHkI2Si1BSQaStP62pPGgMNTyhqEzy1dEAEms6/pb9nZQouQBUn
         q+4ncoQF+EJI5GT779Qoy3Ljl37G8wWejVbIdsn1NM2h6TUS/aVnJ8Pn+vp3oRWO5wfD
         Xdu1U2mZJ9XA2l19N8rRxYgQlrZJQ9PhgfN2iWZLqENbV7XUcqTsEf1g6/7IM37Vqt9y
         LRqC8K6pwrlB4PmucbwfQMw0CuYR5utNXA4P34gPJs3mvI7mjZkVBNPJ5wGdM72Qpb9A
         hazA==
X-Gm-Message-State: AOJu0Yw4j7vs69kyjcbn8BhpQSGzpJY8zHksjsgYkiu/wYEfo4cmbm60
	lHCWM7D37n+n8UWdvIUMTNI0y+lecm8/
X-Google-Smtp-Source: AGHT+IG7kNMxxkYAmQn76IDeOC2mXIVt0z42H9aI/jBWISjQh9E7hRtfIlh+RVt0mQvtUqbZtXZ5tA==
X-Received: by 2002:a17:90b:1e46:b0:28b:f18f:1bff with SMTP id pi6-20020a17090b1e4600b0028bf18f1bffmr2980634pjb.57.1703772788315;
        Thu, 28 Dec 2023 06:13:08 -0800 (PST)
Received: from ?IPV6:2804:7f1:e2c0:89e9:266f:d30e:b731:7f4f? ([2804:7f1:e2c0:89e9:266f:d30e:b731:7f4f])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b001d05fb4cf3csm14015544plb.62.2023.12.28.06.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Dec 2023 06:13:08 -0800 (PST)
Message-ID: <bc188893-3d49-4d02-84ad-a85ea399cc92@mojatatu.com>
Date: Thu, 28 Dec 2023 11:13:03 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 1/5] net/sched: Introduce tc block netdev
 tracking infra
Content-Language: en-US
To: Jamal Hadi Salim <jhs@mojatatu.com>, Ido Schimmel <idosch@idosch.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com,
 pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
References: <20231219181623.3845083-1-victor@mojatatu.com>
 <20231219181623.3845083-2-victor@mojatatu.com> <ZY1hBb8GFwycfgvd@shredder>
 <CAM0EoMkx6JAUdUdxsMe1hRxBVOQX-R0T+CVT=a3jAdKAxEd7GA@mail.gmail.com>
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <CAM0EoMkx6JAUdUdxsMe1hRxBVOQX-R0T+CVT=a3jAdKAxEd7GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/12/2023 09:35, Jamal Hadi Salim wrote:
> On Thu, Dec 28, 2023 at 6:50 AM Ido Schimmel <idosch@idosch.org> wrote:
>>
>> On Tue, Dec 19, 2023 at 03:16:19PM -0300, Victor Nogueira wrote:
>>> +static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *dev,
>>> +                            struct netlink_ext_ack *extack)
>>> +{
>>> +     const struct Qdisc_class_ops *cl_ops = sch->ops->cl_ops;
>>> +     struct tcf_block *block;
>>> +     int err;
>>> +
>>> +     block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>>
>> Another problem, shouldn't there be a check that these operations are
>> actually implemented? The following now crashes with a NULL pointer
>> dereference:
>>
>> # tc qdisc replace dev swp1 root handle 1: tbf rate 1Mbit burst 256k limit 1M
> 
> 
> I think this broke from v7->v8. Thanks for catching this. We'll send a
> fix shortly.

Just sent a fix to net-next because the original patch hasn't been
propagated to net yet.

cheers,
Victor



