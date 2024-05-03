Return-Path: <netdev+bounces-93190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFF38BA7D5
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 09:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94BB31F21C1F
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 07:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF6B146D4D;
	Fri,  3 May 2024 07:31:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6F9139CF1
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714721519; cv=none; b=rQ/JVt91ZX5rcb7/jG6DuMg0pOf4oSDAfh8yk/uv1dJlGxJ4HpaOJw1CNjIi7VO4z8PiYUEJmODGpDbe5jFKXB5VPAB6UVsC2Nvcqp/ECNSX7+JVc0JncdRfGh6OH9TN96/XJM5IjTZEoiHAVWztBXmlLluQBACE89s1bdiJaQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714721519; c=relaxed/simple;
	bh=hdNk2tAeOcskB24GgAyRK6QxNDUEzF2JkjsDIaLQ0Lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSWn+h5hNL8rA5u0/YlwpRP/z41uRpJw3OhkwPWqnI09ymZv2hcvv4hbpo5e8KWtLrq3T3kYh2UoNtRve5YAxVpP971yiNC1zZwgTBwZEsutErE46srE2TOf0cFYNQMLho4zmPv7po3UDXSDfrxmnp3OG1BA0tbnWazZq2rIC08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e1e8c880ffso3763261fa.2
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 00:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714721516; x=1715326316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLjZ4XBNoYrG2AfbHtnwrbcCvSNKrmnJot9LbQr1gQA=;
        b=WHaX8E+S64+rxE9SO4k2bGVSGGqcvq2k5X5LOWHUmbRlCqPMvjckPrvCPTKGpwK+1z
         M+nS4/vjpkIqbdINXFvNzzLHYRSw07kwBqKlANxA0BXHZ0OA/djpsXg659huo2BozVga
         E5hXK852VecwQUDDtI7b7FVGHXirP16KDCA7c4JwJQvmcV1ljvvG2z0SscVdyWfVadE6
         ldSrPSn5I53vRp7VmvKfyBkOFUSnkcEoU6p9NPp2/9QvzLS11ZJzadJCZCM7DvhTObG3
         W+uqkJZcV6JEoR4LyswefCtwfjv+xuSml4WG0tHtf3S+UITFhSxCMAcUtGGbtciO8qn6
         tZfA==
X-Forwarded-Encrypted: i=1; AJvYcCUiFCiYLEFx/UC7uW/GXrj8f9wfcCg/Y8g1F/b1SLP0cvIEEj1oJ6jj1FehYRjH1+XWzu/KbvAkmAGQdxJFu5uYnaSLvZ8p
X-Gm-Message-State: AOJu0YxKj3ZxSIyViRwK/UBaO0LJM0pp6EifCzkSOP3uPe1E4Pu6YyjQ
	pX2TNdXvzzMngJS105ICp3U0YJmi1LJX3TZ2fq73tkxAabDKdi06
X-Google-Smtp-Source: AGHT+IEEbbGP4318UVGteGjHsF5YUKEwa1jSIC9b8Ajd7I4cQyPZMFhGIFgNLu7U70PFB+9PBRW1JA==
X-Received: by 2002:a19:ca4d:0:b0:513:ec32:aa89 with SMTP id h13-20020a19ca4d000000b00513ec32aa89mr1323536lfj.2.1714721515704;
        Fri, 03 May 2024 00:31:55 -0700 (PDT)
Received: from [10.100.102.67] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id k7-20020a7bc407000000b0041674bf7d4csm8285498wmi.48.2024.05.03.00.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 00:31:55 -0700 (PDT)
Message-ID: <29655a73-5d4c-4773-a425-e16628b8ba7a@grimberg.me>
Date: Fri, 3 May 2024 10:31:50 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 01/20] net: Introduce direct data placement tcp
 offload
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 jacob.e.keller@intel.com
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-2-aaptel@nvidia.com>
 <3ab22e14-35eb-473e-a821-6dbddea96254@grimberg.me>
 <253o79wr3lh.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
 <9a38f4db-bff5-4f0f-ac54-6ac23f748441@grimberg.me>
 <253le4wqu4a.fsf@nvidia.com>
 <2d4f4468-343a-4706-8469-56990c287dba@grimberg.me>
 <253frv0r8yc.fsf@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253frv0r8yc.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/2/24 10:04, Aurelien Aptel wrote:
> Sagi Grimberg <sagi@grimberg.me> writes:
>> Well, you cannot rely on the fact that the application will be pinned to a
>> specific cpu core. That may be the case by accident, but you must not and
>> cannot assume it.
> Just to be clear, any CPU can read from the socket and benefit from the
> offload but there will be an extra cost if the queue CPU is different
> from the offload CPU. We use cfg->io_cpu as a hint.

Understood. It is usually the case as io threads are not aligned to the 
rss steering rules (unless
arfs is used).

>
>> Even today, nvme-tcp has an option to run from an unbound wq context,
>> where queue->io_cpu is set to WORK_CPU_UNBOUND. What are you going to
>> do there?
> When the CPU is not bound to a specific core, we will most likely always
> have CPU misalignment and the extra cost that goes with it.

Yes, as done today.

>
> But when it is bound, which is still the default common case, we will
> benefit from the alignment. To not lose that benefit for the default
> most common case, we would like to keep cfg->io_cpu.

Well, this explanation is much more reasonable. Setting .affinity_hint 
argument
seems like a proper argument to the interface and nvme-tcp can set it to 
queue->io_cpu.

>
> Could you clarify what are the advantages of running unbounded queues,
> or to handle RX on a different cpu than the current io_cpu?

See the discussion related to the patch from Li Feng:
https://lore.kernel.org/lkml/20230413062339.2454616-1-fengli@smartx.com/

>
>> nvme-tcp may handle rx side directly from .data_ready() in the future, what
>> will the offload do in that case?
> It is not clear to us what the benefit of handling rx in .data_ready()
> will achieve. From our experiment, ->sk_data_ready() is called either
> from queue->io_cpu, or sk->sk_incoming_cpu. Unless you enable aRFS,
> sk_incoming_cpu will be constant for the whole connection. Can you
> clarify would handling RX from data_ready() provide?

Save the context switching to a kthread from softirq, can reduce latency 
substantially
for some workloads.

