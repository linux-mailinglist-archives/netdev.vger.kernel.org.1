Return-Path: <netdev+bounces-43338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9417D2922
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 05:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0DE4B20CA1
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 03:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FCE1867;
	Mon, 23 Oct 2023 03:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="C4JHesz0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EE81847
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 03:35:49 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C431EA3
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 20:35:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27d0a173e61so1684709a91.0
        for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 20:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1698032147; x=1698636947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWCegtYp8nwfQoYjg8i2/ArRcZBT2vDQSf62c++I3vQ=;
        b=C4JHesz0fbK86A5M9SivEMJH/odsJYZFxXVKw01SMXeIBMp3lCX8c5voio8WESN2Ue
         +1Flt3Kzt9SqNmTDIQSWa42Dugc8Aooi4pmigaVMDbUfdTYmS2pJbApyhyry921+NVpW
         YttytDQLVNcXVzDzrx9El+LeEmM3BEeqdYMczqH4g+3/TYnCgXX6A7iT1xDIIz/TVkxw
         DWC9LE39dYIjDOsoVp7ecHa4bplFPk/rw5YQH6f7WJ2W0v/09QoknsanEvh3OzMhJlNn
         6JgQUALru2jeIPBcp+mkubz7rXiOl+wHBPN2/ov8nq+QdILPRzB1R7OTmb/KouVADPTZ
         nKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698032147; x=1698636947;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWCegtYp8nwfQoYjg8i2/ArRcZBT2vDQSf62c++I3vQ=;
        b=HSKteQUaVcixyzYZ29HhKvh3q38eEBj0hDISMYAtHdDCSfWm1DlN3XFj62ExDbIHg2
         QoPouCuRQwRZAZ/7Uu2LPKRXju4I6GA3gLmDObY7chWOsPZ7Y9A/YT7YoZDym/tng32B
         UvSHB5UM/eSpTtke7lyQ2mgDVbn5biWKLPsXf/4mrMf8EBDiUB/FvjKVc+WQTMwTjRrX
         QoCr5W1E8CsvtzMX8/h8phHsanonFh4km7CwNc2OGEGv96XujtjRtC2xfYDWcrkbm1Hd
         ln6ptFuxsI9i6hTaVcbKE5HOJIt4cB4ch2mbrDHaENrRZIZ5XJ09GZ1x2XyCpbK+5SUc
         u6eg==
X-Gm-Message-State: AOJu0YwgRDLCRY8kKFiNvnm1ZcKQoCWyre7SX4YC3xuef7uW30DiAEj7
	KKNUqdzFC0lEbVrrztLQc0Gt81VwnuHUaj0mQ5lhxe2v
X-Google-Smtp-Source: AGHT+IGj30MoOaVHQFRMT35CFQ5h4aVbtCV+b2A8ofQa/0Atnc2ZnTJtoqCHbtoFEmZO4yaIxgx42Q==
X-Received: by 2002:a17:90a:202:b0:273:ec96:b6f9 with SMTP id c2-20020a17090a020200b00273ec96b6f9mr5688112pjc.25.1698032147161;
        Sun, 22 Oct 2023 20:35:47 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21c8::1237? ([2620:10d:c090:400::4:c4c8])
        by smtp.gmail.com with ESMTPSA id ip1-20020a17090b314100b00262e485156esm6415514pjb.57.2023.10.22.20.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 20:35:46 -0700 (PDT)
Message-ID: <afcb3c40-0148-46ef-b2be-fa4adc57b88a@davidwei.uk>
Date: Sun, 22 Oct 2023 20:35:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND 00/11] Zero copy network RX using io_uring
Content-Language: en-GB
To: Gal Pressman <gal@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>
References: <20230826011954.1801099-1-dw@davidwei.uk>
 <1673427d-b449-4f9e-b344-027c0dc2ec9f@nvidia.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <1673427d-b449-4f9e-b344-027c0dc2ec9f@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-10-22 12:06, Gal Pressman wrote:
> On 26/08/2023 4:19, David Wei wrote:
>> From: David Wei <davidhwei@meta.com>
>>
>> This patchset is a proposal that adds zero copy network RX to io_uring.
>> With it, userspace can register a region of host memory for receiving
>> data directly from a NIC using DMA, without needing a kernel to user
>> copy.
>>
>> Software support is added to the Broadcom BNXT driver. Hardware support
>> for receive flow steering and header splitting is required.
>>
>> On the userspace side, a sample server is added in this branch of
>> liburing:
>> https://github.com/spikeh/liburing/tree/zcrx2
>>
>> Build liburing as normal, and run examples/zcrx. Then, set flow steering
>> rules using ethtool. A sample shell script is included in
>> examples/zcrx_flow.sh, but you need to change the source IP. Finally,
>> connect a client using e.g. netcat and send data.
>>
>> This patchset + userspace code was tested on an Intel Xeon Platinum
>> 8321HC CPU and Broadcom BCM57504 NIC.
>>
>> Early benchmarks using this prototype, with iperf3 as a load generator,
>> showed a ~50% reduction in overall system memory bandwidth as measured
>> using perf counters. Note that DDIO must be disabled on Intel systems.
>>
>> Mina et al. from Google and Kuba are collaborating on a similar proposal
>> to ZC from NIC to devmem. There are many shared functionality in netdev
>> that we can collaborate on e.g.:
>> * Page pool memory provider backend and resource registration
>> * Page pool refcounted iov/buf representation and lifecycle
>> * Setting receive flow steering
>>
>> As mentioned earlier, this is an early prototype. It is brittle, some
>> functionality is missing and there's little optimisation. We're looking
>> for feedback on the overall approach and points of collaboration in
>> netdev.
>> * No copy fallback, if payload ends up in linear part of skb then the
>>   code will not work
>> * No way to pin an RX queue to a specific CPU
>> * Only one ifq, one pool region, on RX queue...
>>
>> This patchset is based on the work by Jonathan Lemon
>> <jonathan.lemon@gmail.com>:
>> https://lore.kernel.org/io-uring/20221108050521.3198458-1-jonathan.lemon@gmail.com/
> 
> Hello David,
> 
> This work looks interesting, is there anywhere I can read about it some
> more? Maybe it was presented (and hopefully recorded) in a recent
> conference?
> Maybe something geared towards adding more drivers support?
> 

Hi Gal,

Thank you for your interest in our work! We will be publishing a paper
and presenting this work at NetDev conference on 1 Nov.

Support for more drivers (e.g. mlx5) is definitely on our radar. We are
collaborating with Mina and others from Google who are working on a
similar proposal but targetting NIC -> ZC RX into GPU memory. We both
require shared bits of infra e.g. page pool memory providers that will
replace the use of a one-off data_pool in this patchset. This would
minimise driver changes needed to support this feature.

> I took a brief look at the bnxt patch and saw you converted the page
> pool allocation to data pool allocation, I assume this is done for data
> pages only, right? Headers are still allocated on page pool pages?
> 
> Thanks

Yes, that's right.

David

