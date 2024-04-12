Return-Path: <netdev+bounces-87232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3ED8A23AC
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 04:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C391C2017C
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 02:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D51ED2FE;
	Fri, 12 Apr 2024 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qlfqLzM0"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4536733E1
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 02:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712887668; cv=none; b=UHhyvXNY006WDjpcSWOhP+Z+iLOgq4QtpdaQL6IIkbZAj+8vuIuueGRSkKo4XODlfJ9UJzKgd5Tjjf48+v8dNadPSmFbgBkO5dJrpjKfKNdpKtzH2NTh5C7yfkkfXyOW1/Rzc7zkVQQhKHJ5EW/y5WZVHqvV/NWGgqj/vGut5+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712887668; c=relaxed/simple;
	bh=BkDfFNA7J1ByNtzpfLSJf+/U9tIx97cssYvo7N9moX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2MgEZkKcL3mYY+83dabxdBRFHOjG2wiyOqj7ff3o0zcDXsZrS5YPPsM6QiXs/3buSw5SSo06t+czUsQwfuseIZvqWecCzwtiPrPJKDH9LaoXm43ijz7fa9CmuGkYJG3rXxnie6aQBQBocVh/niJYLE1p0yE/xgA0l1AuPkH6Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qlfqLzM0; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712887657; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1HXYgCRPnY66EoAYDKR7u7jnZJr1ayx55VURbxfmf04=;
	b=qlfqLzM0oECLlOKapdfJwgua+PBiY+YlqriXZnxwprXpQ9TdVUgwQSifHx99pIO84txAYc6ps0YIc2uiQVN7lYIsJqCLNO0ba+dEcKnNHmOs+5xB7y7YwX2v2LTxbf8l6jwE1fPhgpx5BZ/yeKb7kReFpG6KQDzzsfm3Y9mF9mo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W4MeNlx_1712887656;
Received: from 30.221.148.182(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4MeNlx_1712887656)
          by smtp.aliyun-inc.com;
          Fri, 12 Apr 2024 10:07:37 +0800
Message-ID: <99bc7a22-6fa4-49e1-b98b-4b6a46f1b9b8@linux.alibaba.com>
Date: Fri, 12 Apr 2024 10:07:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/4] ethtool: provide customized dim profile
 management
To: Brett Creeley <bcreeley@amd.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1712844751-53514-1-git-send-email-hengqi@linux.alibaba.com>
 <1712844751-53514-3-git-send-email-hengqi@linux.alibaba.com>
 <b0c8d0a2-d6e5-4138-96c0-e9dbbc1c8b20@amd.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <b0c8d0a2-d6e5-4138-96c0-e9dbbc1c8b20@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/11 下午11:19, Brett Creeley 写道:
>
>
> On 4/11/2024 7:12 AM, Heng Qi wrote:
>> Caution: This message originated from an External Source. Use proper 
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> The NetDIM library, currently leveraged by an array of NICs, delivers
>> excellent acceleration benefits. Nevertheless, NICs vary significantly
>> in their dim profile list prerequisites.
>>
>> Specifically, virtio-net backends may present diverse sw or hw device
>> implementation, making a one-size-fits-all parameter list impractical.
>> On Alibaba Cloud, the virtio DPU's performance under the default DIM
>> profile falls short of expectations, partly due to a mismatch in
>> parameter configuration.
>>
>> I also noticed that ice/idpf/ena and other NICs have customized
>> profilelist or placed some restrictions on dim capabilities.
>>
>> Motivated by this, I tried adding new params for "ethtool -C" that 
>> provides
>> a per-device control to modify and access a device's interrupt 
>> parameters.
>>
>> Usage
>> ========
>> 1. Query the currently customized list of the device
>>
>> $ ethtool -c ethx
>> ...
>> rx-eqe-profile:
>> {.usec =   1, .pkts = 256, .comps =   0,},
>> {.usec =   8, .pkts = 256, .comps =   0,},
>> {.usec =  64, .pkts = 256, .comps =   0,},
>> {.usec = 128, .pkts = 256, .comps =   0,},
>> {.usec = 256, .pkts = 256, .comps =   0,}
>> rx-cqe-profile:   n/a
>> tx-eqe-profile:   n/a
>> tx-cqe-profile:   n/a
>>
>> 2. Tune
>> $ ethtool -C ethx rx-eqe-profile 1,1,0_2,2,0_3,3,0_4,4,0_5,5,0
>> $ ethtool -c ethx
>> ...
>> rx-eqe-profile:
>> {.usec =   1, .pkts =   1, .comps =   0,},
>> {.usec =   2, .pkts =   2, .comps =   0,},
>> {.usec =   3, .pkts =   3, .comps =   0,},
>> {.usec =   4, .pkts =   4, .comps =   0,},
>> {.usec =   5, .pkts =   5, .comps =   0,}
>> rx-cqe-profile:   n/a
>> tx-eqe-profile:   n/a
>> tx-cqe-profile:   n/a
>>
>> 3. Hint
>> If the device does not support some type of customized dim
>> profiles, the corresponding "n/a" will display.
>
> What if the user specifies a *-eqe-profile and *-cqe-profile for rx 
> and/or tx? Is that supported? If so, which one is the active profile?


I think you mean GET? GET currently does not support any parameters, the 
working profile will be displayed.

>
> Maybe I missed this, but it doesn't seem like the output from "ethtool 
> -c ethX" shows the active profile it just dumps the profile 
> configurations.

Now it is required that dev->priv_flags is set to one of 
IFF_PROFILE_{USEC, PKTS, COMPS} (which means that the
driver supports configurable profiles) before the profile can be queried 
or do you want to query without this restriction?

Thanks!

>
> Thanks,
>
> Brett
>
> [snip]


