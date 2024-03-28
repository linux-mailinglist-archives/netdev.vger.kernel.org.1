Return-Path: <netdev+bounces-82709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D59E788F55A
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 03:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F36A29874C
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 02:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FF9F513;
	Thu, 28 Mar 2024 02:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Dn17sc3e"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8996D2599
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 02:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592791; cv=none; b=Fd8EjH7tbUwFWVoXxXeFj0XI8FhWQgZsI9PdQZ5yP7gSotxVA7X40kRVmBI08bWtvYTciZN+/c8hi5LdJo66UHP+L78XoabM/G1htwL3Go/RE2/AfqXB1k6M3187/11NFx0JIegdhAQXu0ZB+sPbg4YFZDignEKa/92pv1m8huY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592791; c=relaxed/simple;
	bh=rPJHUU8D1GksjG1QFEQXmcYv5lxhv8iHvUj4guXE8Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bVqVhkjGOvDYSYlxYFaKZlfwYdd389fEMaXM4XghiUvVBVIVCsuaV7ODGYpD0Awpcxms0XqaIV1LmuiwgScLW76bEKtiYwD8Nb6X6lT2wBurethHk/4q8wTZFFxnwMa1iCjiheTuOl+JOZqrXVpcAe1Y5420Pa9WMnQeH73+Crc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Dn17sc3e; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711592786; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=h7Efqa5U1w854uuMyvMUXImLQ6eZ4awmcIDJ8psKwA8=;
	b=Dn17sc3eSJfX+vna8zK40g0kAM3Ll3LnPOg+HVKklZ0BmCBNf7CwLNt0RRLID90y0VlNZuUXq05XzUAvDaruhcViDHBmGWbYiH22nj95ffzT1Ulrp1zvvgc7iIf5jHNlj8u0yss0FW2ICGahYG97F3biJXuUv8DYvh6FLh/jnL8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W3QHOBc_1711592783;
Received: from 30.221.148.146(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3QHOBc_1711592783)
          by smtp.aliyun-inc.com;
          Thu, 28 Mar 2024 10:26:25 +0800
Message-ID: <7a73eac4-5b28-49eb-9709-6c7e404257f8@linux.alibaba.com>
Date: Thu, 28 Mar 2024 10:26:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] virtio-net: support dim profile
 fine-tuning
To: Jakub Kicinski <kuba@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, vadim.fedorenko@linux.dev,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
References: <1711531146-91920-1-git-send-email-hengqi@linux.alibaba.com>
 <1711531146-91920-3-git-send-email-hengqi@linux.alibaba.com>
 <556ec006-6157-458d-b9c8-86436cb3199d@intel.com>
 <20240327173258.21c031a8@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240327173258.21c031a8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/28 上午8:32, Jakub Kicinski 写道:
> On Wed, 27 Mar 2024 15:45:50 +0100 Alexander Lobakin wrote:
>>> +/* This is copied from NET_DIM_RX_EQE_PROFILES in DIM library */
>>> +#define VIRTNET_DIM_RX_PKTS 256
>>> +static struct dim_cq_moder rx_eqe_conf[] = {
>>> +	{.usec = 1,   .pkts = VIRTNET_DIM_RX_PKTS,},
>>> +	{.usec = 8,   .pkts = VIRTNET_DIM_RX_PKTS,},
>>> +	{.usec = 64,  .pkts = VIRTNET_DIM_RX_PKTS,},
>>> +	{.usec = 128, .pkts = VIRTNET_DIM_RX_PKTS,},
>>> +	{.usec = 256, .pkts = VIRTNET_DIM_RX_PKTS,}
>>> +};
>> This is wrong.
>> This way you will have one global table for ALL the virtio devices in
>> the system, while Ethtool performs configuration on a per-netdevice basis.
>> What you need is to have 1 dim_cq_moder per each virtio netdevice,
>> embedded somewhere into its netdev_priv(). Then
>> virtio_dim_{rx,tx}_work() will take profiles from there, not the global
>> struct. The global struct can stay here as const to initialize default
>> per-netdevice params.
> I've been wondering lately if adaptive IRQ moderation isn't exactly
> the kind of heuristic we would be best off deferring to BPF.
> I have done 0 experiments -- are the thresholds enough
> or do more interesting algos come to mind for anyone?

Hi Jakub.

I totally agree with your idea. In order to get the best practices for 
virtio DIM on our DPUs,
I actually spent a lot of energy on tuning, similar to the current 
custom profile list and virtio
ctrlq asynchronousization. There are some other tuning methods that may 
not be applicable to
other manufacturers, so they are cannot be released for the time being.

But anyway, adding a dim_bpf interface similar to native XDP (located at 
the beginning
of net_dim()) I think would be good, if you and BPF maintainers (Cc'd) 
are willing for a new bpf type
to be introduced. dim_bpf allows devices that want to implement best 
practices for adaptive
IRQ moderation to implement custom logic.

Also, I think the existing patches are still necessary, and this 
provides the simplest and most
direct way to tune.

Thanks!




