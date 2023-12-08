Return-Path: <netdev+bounces-55486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847FE80B07F
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 00:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50F31C20A03
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 23:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0EA5AB9A;
	Fri,  8 Dec 2023 23:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGforaeO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EF61703
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 15:19:30 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-db549f869a3so2964144276.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 15:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702077570; x=1702682370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nAyGGJqFh1KsK7YTr3+Ta9gGXVNBP2LzoXFuP7QOOj0=;
        b=XGforaeOeHmp3IQzM9tybAR3Be3LT4Ywm/aZoYg22qhiMwubMN6mXp5KsGoKJACDdm
         5x9aQRPLg5vw11Owgwjsj60p7Wx9/FAYQLenrHGAyV/jBaJPz/yPZpVDYPAH2Vo8KX1h
         nZnCvYmCUTTAaLh/A2kE1xKoR998D45bPY6zD7T3mc+CEW81xp6qUava5EkfuD0tMSFG
         zyqThQ1BdVVpSCH00GztyCSfDFP0WYM9y+Qzu6cCdLEMHcvLZZtuIKDLUSCf8ebGzwXE
         8nxNsnCTIbwX217IlzC1ZqDuhy33VdQiG3aUMS8um2TFi7vBTLnjdvyg/TkbENUdWeG5
         CdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702077570; x=1702682370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAyGGJqFh1KsK7YTr3+Ta9gGXVNBP2LzoXFuP7QOOj0=;
        b=HnXYPRv3PrrspeCumKh8+RPDgEgRp3OXsAOir79ZNBLZTA7Npv5jfkyIPTykEpAyyG
         Rg86vFNZYdwQTdZ0ErFaNshnQFUG5ViE1wKRqsCOrPRkkMC5hMdCy77/gR+Zih/VZdul
         3dl+e+i9yHYdkUkcrPy32c2fVMsXKbpdbOqhfwSetTmYVdXW/MLwMG67Gs5IUMCMkdBu
         rZN9C8ZL8Mmos1mgY0Erdjdl1tIOFWdmGXAxnsXRjdYCW9XDmvIlAmQE4Ra8X/5P4peQ
         gGfRz763x/b8GDVHUxaPpM4+Spt/zcoYmTG9+B0vXl9AF0gL5hvcDq83ZjTBMCdlCP2O
         OVEg==
X-Gm-Message-State: AOJu0YxRp/wWZTQHcLr8zDfNJiop4+TroeeLQsMMh5cIiJlJjileztg/
	5AkDzzqRxrgcnmAXuU4J0TGeAI0ZcSU=
X-Google-Smtp-Source: AGHT+IEchs4prqf2Z+jROTn5/lOrwfEeCEC7BQcxPHzd8vYKqibGvmz1y9kGcQdTqJrRO8CbS3yCng==
X-Received: by 2002:a5b:cc1:0:b0:db5:3e6a:e436 with SMTP id e1-20020a5b0cc1000000b00db53e6ae436mr645703ybr.55.1702077569865;
        Fri, 08 Dec 2023 15:19:29 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:65fe:fe26:c15:a05c? ([2600:1700:6cf8:1240:65fe:fe26:c15:a05c])
        by smtp.gmail.com with ESMTPSA id g13-20020a258a0d000000b00d8674371317sm909058ybl.36.2023.12.08.15.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 15:19:29 -0800 (PST)
Message-ID: <92dcf735-6e9c-48dc-a020-d4e2658dff19@gmail.com>
Date: Fri, 8 Dec 2023 15:19:28 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net/ipv6: insert a f6i to a GC list only
 if the f6i is in a fib6_table tree.
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, thinker.li@gmail.com,
 netdev@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: kuifeng@meta.com, syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
References: <20231208194523.312416-1-thinker.li@gmail.com>
 <20231208194523.312416-2-thinker.li@gmail.com>
 <353fc304-389b-4c16-b78f-20128d688370@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <353fc304-389b-4c16-b78f-20128d688370@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/8/23 14:43, David Ahern wrote:
> On 12/8/23 12:45 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Check f6i->fib6_node and hlist_unhashed(&f6i->gc_link) before inserting a
>> f6i (fib6_info) to tb6_gc_hlist.
>>
>> The current implementation checks if f6i->fib6_table is not NULL to
>> determines if a f6i is on a tree, however it is not enough. When a f6i is
>> removed from a fib6_table, f6i->fib6_table is not reset. However, fib6_node
>> is always reset when a f6i is removed from a fib6_table and is set when a
>> f6i is added to a fib6_table. So, f6i->fib6_node is a reliable way to
>> determine if a f6i is on a tree.
> 
> Which is an indication that the table is not the right check but neither
> is the fib6_node. If expires is set on a route entry, add it to the
> gc_list; if expires is reset on a route entry, remove it from the
> gc_list. If the value of expires is changed while on the gc_list list,
> just update the expires value.
> 

I don't quite follow you.
If an entry is not on a tree, why do we still add the entry to the gc 
list? (This is the reason to check f6i->fib6_node.)

The changes in this patch rely on two indications, 1. if a f6i is on a 
tree, 2. if a f6i is on a gc list (described in the 3rd paragraph of
the comment log.)
An entry is added to a gc list only if it has expires and is not on the 
list yet. An entry is removed from a gc list only if it is on a gc list.
And, just like what you said earlier, it just updates the expires value
while an entry is already on a gc list.

