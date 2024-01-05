Return-Path: <netdev+bounces-61913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C03D825322
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 12:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32DBB284A29
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 11:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A68E2C84F;
	Fri,  5 Jan 2024 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="iSZ/jk2l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96632CCBB
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9b050e88cso995240b3a.0
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 03:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704455470; x=1705060270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3459JhxVDLq3KXVZkQncbQwZnsnwpk8tw3457obXp+k=;
        b=iSZ/jk2lOWiWEQ8efgCEfRkLMLUSIc7zwZGYPGBEmiNBXsCFKDJAm2cqDnvijvuij5
         RQVZghKgAP2wo68HrqOgvuGhO8isiTBzQJn8d1gkaPKkachEpBd4JSDPlSI9hzqSsrMc
         bLabuQrX3Kt3BW0Dib3zrleaXRwn7nWjtwi4u8T2w+cDybtCyXaWX7hCd9jHl3a38qLx
         rhWQjQoB3lVsBt6btB7KrzemRRjGP+uxA31NFgA2Xv+U6vdfvgqiY0ZG6L1cNy29soVR
         5aVUYQrnkPnvCn4TclynEYSvjfBcb3tKHiAqj61K9idkd5r2QfK7eHOyCOh2ImmQkC/B
         w4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704455470; x=1705060270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3459JhxVDLq3KXVZkQncbQwZnsnwpk8tw3457obXp+k=;
        b=FqzJdTwVeXOGqJEb/DeqEVM1pS3eIHU3j+oPFgTZa9iAbR0U/6HFyHJX3q5Y6DRXdz
         iIeiMpDRUJZrWA1Y93UvfBpwzs0jksyqShqpF2jo9QwJqBVysM83xRXrLaZrGLnWA+ZP
         CY6HryXDxv+E+yNDAiUl+MGK7ut1Q5bKsV6ivmvu9b1nkc5DBj84ObA1zXiGVJJEPo2g
         iIWotTOpvEevjXWgX+Zz7uEgQujZNcp4g9C+7FqSrRNACWFoocja6zu9H3k6AMIXcvy+
         muu9Kya4kS/ynM/y1CFW7Sha8LHzG7SuaV1utaraaOHIAm5J0ahKaS3NAz8Eurusqqs9
         Yp+w==
X-Gm-Message-State: AOJu0Ywi8YN45sNI99rfLk40bCC0KpHwYAlOXkD9xB0YHvHoKWoaTgqi
	etYy5gCgW+pFJr3hT0Wzn+9QwSfdXjF9
X-Google-Smtp-Source: AGHT+IEVe6icnsLTplGGw+HGgM5K+/RWm6OseLF3J5xhN5GtQOX8rEQ5EIEZvLb3mhhfA5me66oXAQ==
X-Received: by 2002:a05:6a00:181a:b0:6d9:a07f:36a0 with SMTP id y26-20020a056a00181a00b006d9a07f36a0mr1945262pfa.43.1704455469909;
        Fri, 05 Jan 2024 03:51:09 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id u6-20020aa78386000000b006da6b404e7dsm1223730pfm.63.2024.01.05.03.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 03:51:09 -0800 (PST)
Message-ID: <828b8af7-8b4e-4820-bf78-41a8b7af16ce@mojatatu.com>
Date: Fri, 5 Jan 2024 08:51:04 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch net-next] net: sched: move block device tracking into
 tcf_block_get/put_ext()
To: Jiri Pirko <jiri@resnulli.us>, Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, xiyou.wangcong@gmail.com,
 victor@mojatatu.com, idosch@idosch.org, mleitner@redhat.com,
 vladbu@nvidia.com, paulb@nvidia.com
References: <20240104125844.1522062-1-jiri@resnulli.us>
 <CAM0EoMkDhnm0QPtZEQPbnQtkfW7tTjHdv3fQoXzRXARVdhbc0A@mail.gmail.com>
 <ZZby7xSkQpWHwPOA@nanopsycho>
 <CAM0EoMmCn8DpMzPCt9GMW16C08n8mfM8N==pfPJy6c=XgEqMSw@mail.gmail.com>
 <ZZfm3TbhyAfIMzDQ@nanopsycho>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <ZZfm3TbhyAfIMzDQ@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/01/2024 08:24, Jiri Pirko wrote:
> Thu, Jan 04, 2024 at 07:22:48PM CET, jhs@mojatatu.com wrote:
>> On Thu, Jan 4, 2024 at 1:03 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>>
>>> Thu, Jan 04, 2024 at 05:10:58PM CET, jhs@mojatatu.com wrote:
>>>> On Thu, Jan 4, 2024 at 7:58 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>>>>
>>>>> From: Jiri Pirko <jiri@nvidia.com>
>>>>>
>>>>> Inserting the device to block xarray in qdisc_create() is not suitable
>>>>> place to do this. As it requires use of tcf_block() callback, it causes
>>>>> multiple issues. It is called for all qdisc types, which is incorrect.
>>>>>
>>>>> So, instead, move it to more suitable place, which is tcf_block_get_ext()
>>>>> and make sure it is only done for qdiscs that use block infrastructure
>>>>> and also only for blocks which are shared.
>>>>>
>>>>> Symmetrically, alter the cleanup path, move the xarray entry removal
>>>>> into tcf_block_put_ext().
>>>>>
>>>>> Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking infra")
>>>>> Reported-by: Ido Schimmel <idosch@nvidia.com>
>>>>> Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
>>>>> Reported-by: Kui-Feng Lee <sinquersw@gmail.com>
>>>>> Closes: https://lore.kernel.org/all/ce8d3e55-b8bc-409c-ace9-5cf1c4f7c88e@gmail.com/
>>>>> Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com
>>>>> Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@google.com/
>>>>> Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com
>>>>> Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@google.com/
>>>>> Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
>>>>> Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@google.com/
>>>>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>>>
>>>> Did you get a chance to run the tdc tests?
>>>
>>> I ran the TC ones we have in the net/forwarding directory.
>>> I didn't manage to run the tdc. Readme didn't help me much.
>>> How do you run the suite?
>>
>> For next time:
>> make -C tools/testing/selftests TARGETS=tc-testing run_tests
> 
> Unrelated to this patch.
> 
> Running this, I'm getting lots of errors, some seem might be bugs in
> tests. Here's the output:
> 
> make: Entering directory '/mnt/share156/jiri/net-next/tools/testing/selftests'
> make[1]: Entering directory '/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing'
> make[1]: Nothing to be done for 'all'.
> make[1]: Leaving directory '/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing'
> make[1]: Entering directory '/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing'
> TAP version 13
> 1..1
> # timeout set to 900
> # selftests: tc-testing: tdc.sh
> # netdevsim
> # act_bpf
> # act_connmark
> # act_csum
> # act_ct
> # act_ctinfo
> # act_gact
> # act_gate
> # act_mirred
> # act_mpls
> # act_nat
> # act_pedit
> # act_police
> # act_sample
> # act_simple
> # act_skbedit
> # act_skbmod
> # act_tunnel_key
> # act_vlan
> # cls_basic
> # cls_bpf
> # cls_cgroup
> # cls_flow
> # cls_flower
> # cls_fw
> # cls_matchall
> # cls_route
> # cls_u32
> # Module em_canid not found... skipping.
> # em_cmp
> # em_ipset
> # em_ipt
> # em_meta
> # em_nbyte
> # em_text
> # em_u32
> # sch_cake
> # sch_cbs
> # sch_choke
> # sch_codel
> # sch_drr
> # sch_etf
> # sch_ets
> # sch_fq
> # sch_fq_codel
> # sch_fq_pie
> # sch_gred
> # sch_hfsc
> # sch_hhf
> # sch_htb
> # sch_teql
> # considering category actions
> # !!! Consider installing pyroute2 !!!
> #  -- ns/SubPlugin.__init__
> #  -- scapy/SubPlugin.__init__
> # Executing 528 tests in parallel and 15 in serial
> # Using 18 batches and 4 workers
> #

Hi Jiri,

Can you also try running after installing pyroute2?
`pip3 install pyroute2` or via your distro's package manager.

Seems like in your kernel config + (virtual?) machine you are running 
into issues like:
  - create netns
  - try to use netns (still "creating", not visible yet)
  - fail badly

Since pyroute2 is netlink based, these issues are more likely to not happen.

Yes I agree the error messages are cryptic, we have been wondering how 
to improve them.
If you are still running into issues after trying with pyroute2, can you 
also try running tdc with the following diff? It disables the parallel 
testing for kselftests.

Perhaps when pyroute2 is not detected on the system we should disable 
the parallel testing completely. tc/ip commands are too susceptible to 
these issues and parallel testing just amplifies them.

diff --git a/tools/testing/selftests/tc-testing/tdc.sh 
b/tools/testing/selftests/tc-testing/tdc.sh
index c53ede8b730d..89bb123db86b 100755
--- a/tools/testing/selftests/tc-testing/tdc.sh
+++ b/tools/testing/selftests/tc-testing/tdc.sh
@@ -63,5 +63,5 @@ try_modprobe sch_hfsc
  try_modprobe sch_hhf
  try_modprobe sch_htb
  try_modprobe sch_teql
-./tdc.py -J`nproc` -c actions
-./tdc.py -J`nproc` -c qdisc
+./tdc.py -J1 -c actions
+./tdc.py -J1 -c qdisc



