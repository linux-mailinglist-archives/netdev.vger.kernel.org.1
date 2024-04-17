Return-Path: <netdev+bounces-88582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 496758A7C6C
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E662852F9
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 06:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E71657C3;
	Wed, 17 Apr 2024 06:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IKtwJjLn"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0D953805
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336054; cv=none; b=FNht5BfPBFwfZg3NVd5VElnkAwNTnt8zQZxyggbPbMV8KPKwyocDs/ya+nVOmUNlfiGt7lKpcBlXtMHduJDRETA5X3MQxKQ+IF8At5kcIhe0WiEyn0yaTkhdSFzsOyoKziUs6lOU2j8G0QoU6HzsjKlZ7oq6fed+q46QeWuF+jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336054; c=relaxed/simple;
	bh=+KPudZsvUcRknBY0RJHjbD5x9QfsLHcjWD1esneFTto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8RCg65Uc3yZDFJjfE1zRFn3FEsNnpShKRogKmxQpgXlJu4n0XTa6K4L0v6pOx0lxBWCTgSW3cReb8wSDDB977pMAR2EUhrkfnWmmd/DNpNplmIWFRQ5JXnX1NPnAW+nkYlKc9Oog963rSnOzUePNNObB7bLWZ5DpRlsqyzyoMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IKtwJjLn; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713336044; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=r1e9pyZqa9zk/GQ+SQMODsRVTFOnn65R1EEUTEuilB8=;
	b=IKtwJjLnh7nVr2G/HFnXsTYIl5v1UMC6WgAx0XDJ/gWGDzg8D95J91aqWgTwPAPlJ0NRFep+qDidNR7XEvtmsZSuW+Il4CLJZhNaWki59A7oPa2KtFYWXqUa2728MU/xu+zHF9ZlnC/eoHZc5sya8BdYECFmxRMIg8RHzZVu7z4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W4kb3mg_1713335724;
Received: from 30.221.148.177(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4kb3mg_1713335724)
          by smtp.aliyun-inc.com;
          Wed, 17 Apr 2024 14:35:26 +0800
Message-ID: <26755c1e-566b-402c-a709-eeebe11352aa@linux.alibaba.com>
Date: Wed, 17 Apr 2024 14:35:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 0/4] ethtool: provide the dim profile
 fine-tuning channel
To: Jason Xing <kerneljasonxing@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CAL+tcoDj11Y7o2f0Eh8-FMk0BxjtAwCupWaW7n7bOXTUVgAWSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/17 上午10:53, Jason Xing 写道:
> Hello Jakub,
>
> On Wed, Apr 17, 2024 at 10:30 AM Jakub Kicinski <kuba@kernel.org> wrote:
>> On Wed, 17 Apr 2024 10:22:52 +0800 Heng Qi wrote:
>>> Have you encountered compilation problems in v8?
>> Yes, please try building allmodconfig:
>>
>> make allmodconfig
>> make ..
>>
>> there's many drivers using this API, you gotta build the full kernel..
>>
> About compiling the kernel, I would like to ask one question: what
> parameters of 'make' do you recommend just like the netdev/build_32bit
> [1] does?

Hi Jason,

I founded and checked the use of nipa[1] made from Kuba today. I used 
run.sh in the ./nipa/docker
directory locally to run full compilation.
If there are additional errors or warnings after applying our own 
patches than before, we will be given
information in the results directory.

[1] https://github.com/linux-netdev/nipa/tree/main

Thanks.

>
> If I run the normal 'make' command without parameters, there is no
> warning even if the file is not compiled. If running with '-Oline -j
> 16 W=1 C=1', it will print lots of warnings which makes it very hard
> to see the useful information related to the commits I just wrote.
>
> I want to build and then print all the warnings which are only related
> to my patches locally, but I cannot find a good way :(
>
> [1]: https://netdev.bots.linux.dev/static/nipa/845020/13631720/build_32bit/stderr
>
> Thanks,
> Jason


