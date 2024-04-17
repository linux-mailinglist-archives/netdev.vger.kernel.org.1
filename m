Return-Path: <netdev+bounces-88601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA478A7DAD
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 10:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64968B21D19
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643AD7C6C0;
	Wed, 17 Apr 2024 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NrCNmZCG"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E9C7C6C1
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341067; cv=none; b=JhBFuoJkTDuiiKP7027seSWUPgSYzeLW4bWAJ74XSiEA4sjN6KPDsKbKQuyAONLjtJ9rjlxHE+uv5PXeaHm3KUUf65d4BbbMBBL47FYvmuohYcCKeWjI3nFzf92rNP9z/q1ae/F99J9rUCpgDb0O/HIZChnpmNCbGoGw2XzeJmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341067; c=relaxed/simple;
	bh=OP/OKFQgQXSFhzk6tuYsbkhWUFquoztiZgjoCeKsBcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UeHCaMkRimm6rF2f1g4ntle5l+6t9c8UEEv3pCECtufH51Iqi46Rr4vdL43Tt0A4/FrzuBbL5vwyFidL3QgCpNNtlyPHCSd/rIAqrnkfFg0dxXDHGBza2Yu5aAi9akTTInoaRiiBSN0Ym7zgJ3fNDdVYa3YffwH9GsKW2DJNGrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NrCNmZCG; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713341060; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zZZMoIYCZzum0CbFS+uoL0WalJhrJ++b9N2kNAwtdSg=;
	b=NrCNmZCGuENYNXenn/kl1/kT8lHhsE4fk3MB1TMecF1Gu5rUfJnJ1Irl4HZPde4wi9jVcrBgS1V1e6B9EK3bqRLeDcnCCVs5m70yAmYYsbUvARdMORyAeZc6xGhJTEr1u0VL8SLaMM6IWlP43ABp47W/GjoYm/adTuFDozYcMU8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W4kiYj._1713341057;
Received: from 30.221.148.177(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4kiYj._1713341057)
          by smtp.aliyun-inc.com;
          Wed, 17 Apr 2024 16:04:18 +0800
Message-ID: <29266e64-5810-417d-9a01-ad01e86a70d3@linux.alibaba.com>
Date: Wed, 17 Apr 2024 16:04:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 0/4] ethtool: provide the dim profile
 fine-tuning channel
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Simon Horman <horms@kernel.org>, Brett Creeley <bcreeley@amd.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20240416122950.39046-1-hengqi@linux.alibaba.com>
 <20240416173836.307a3246@kernel.org>
 <1abdb66a-a080-424e-847d-1d2f5837bbc4@linux.alibaba.com>
 <20240416192952.1e740891@kernel.org>
 <CAL+tcoDj11Y7o2f0Eh8-FMk0BxjtAwCupWaW7n7bOXTUVgAWSQ@mail.gmail.com>
 <26755c1e-566b-402c-a709-eeebe11352aa@linux.alibaba.com>
 <CAL+tcoAS81uW_aikoWrDhO-qF-aFD5rU4GsEAy2hHbC9ex2q5w@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CAL+tcoAS81uW_aikoWrDhO-qF-aFD5rU4GsEAy2hHbC9ex2q5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/17 下午2:52, Jason Xing 写道:
> On Wed, Apr 17, 2024 at 2:35 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>
>>
>> 在 2024/4/17 上午10:53, Jason Xing 写道:
>>> Hello Jakub,
>>>
>>> On Wed, Apr 17, 2024 at 10:30 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>>> On Wed, 17 Apr 2024 10:22:52 +0800 Heng Qi wrote:
>>>>> Have you encountered compilation problems in v8?
>>>> Yes, please try building allmodconfig:
>>>>
>>>> make allmodconfig
>>>> make ..
>>>>
>>>> there's many drivers using this API, you gotta build the full kernel..
>>>>
>>> About compiling the kernel, I would like to ask one question: what
>>> parameters of 'make' do you recommend just like the netdev/build_32bit
>>> [1] does?
>> Hi Jason,
>>
>> I founded and checked the use of nipa[1] made from Kuba today. I used
>> run.sh in the ./nipa/docker
>> directory locally to run full compilation.
>> If there are additional errors or warnings after applying our own
>> patches than before, we will be given
>> information in the results directory.
>>
>> [1] https://github.com/linux-netdev/nipa/tree/main
> Great! Thanks for the information:) I'll try it locally.

To update more information, I checked the source code of nipa.
All its test items are located at:

   1. nipa/tests/patch, such as build_32bit, build_allmodconfig_war
   2. nipa/tests/series, such as fixes_present

We can edit the "include" and "exclude" items of [tests] section
in the nipa/docker/nipa.config file to specify the specific items we 
want to test.

Regards,
Heng

>
> Thanks,
> Jason
>
>> Thanks.
>>
>>> If I run the normal 'make' command without parameters, there is no
>>> warning even if the file is not compiled. If running with '-Oline -j
>>> 16 W=1 C=1', it will print lots of warnings which makes it very hard
>>> to see the useful information related to the commits I just wrote.
>>>
>>> I want to build and then print all the warnings which are only related
>>> to my patches locally, but I cannot find a good way :(
>>>
>>> [1]: https://netdev.bots.linux.dev/static/nipa/845020/13631720/build_32bit/stderr
>>>
>>> Thanks,
>>> Jason


