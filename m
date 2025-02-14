Return-Path: <netdev+bounces-166269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B420A35496
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 03:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C08188CB2F
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 02:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B391313212A;
	Fri, 14 Feb 2025 02:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EjtcrC+L"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47448634A
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 02:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739499261; cv=none; b=VFSF5WK7RSNZQOPXbRVnOdJj3l+d7ZgqYojVoLJ/4PzKxPxSpmZGlmuyMVHz2IgLpOO+aKeJb4hCtv2cD5hQ8zaMkhcDmVRzsPZLsZRf6UBpp6YC90/YEdtMldLH7t3QolvM6xyCsh2I1vxPPT4Jk/0SvaT8NihZ+v2ypUvm6BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739499261; c=relaxed/simple;
	bh=87pZ5rFe8MHrMwq7rkNVMdR/BnR+HLoPdg3Wde6NOSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crXy+Fw67y6tfW7gJ8qh7KbKObiMvDBcQuQ+5ALqQaORvWTQceE93p6SqBjYAPvOLzOZl8QIyP3MloVGRvX/s0kKSnb8rEiJLJwIbkYLLq2dDo1Hk4hLfclFgSAFkWtWFRTWxkGO55J50BdF6XQ/SKBWOkKi5+JMKffqux/w8GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EjtcrC+L; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <039bfa0d-3d61-488e-9205-bef39499db6e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739499254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kUI9Bv66f7rqMNMsUao4OmvHx74KK1NJdkGJyf1O3zQ=;
	b=EjtcrC+LxW+broS+TEqETetEfgnwuNcmZWVIaBbf+Ixj7eXqpY0SpAYO1cXn/K4vSVL2i2
	VE5nzB6CmemwC3oGsyxv/qLXrk6jVv2iNowjcdEQ2/g0mf+gzUXRB1WTErxKcFezxVCfYG
	fdzKKvlvtTi7kXLL/Qs8F7tLEv2zqag=
Date: Thu, 13 Feb 2025 18:14:06 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/3] bpf: add TCP_BPF_RTO_MAX for bpf_setsockopt
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 horms@kernel.org, ncardwell@google.com, kuniyu@amazon.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250213004355.38918-1-kerneljasonxing@gmail.com>
 <20250213004355.38918-3-kerneljasonxing@gmail.com>
 <Z66DL7uda3fwNQfH@mini-arch>
 <CAL+tcoATv6HX5G6wOrquGyyj8C7bFgRZNnWBwnPTKD1gb4ZD=g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoATv6HX5G6wOrquGyyj8C7bFgRZNnWBwnPTKD1gb4ZD=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/13/25 3:57 PM, Jason Xing wrote:
> On Fri, Feb 14, 2025 at 7:41 AM Stanislav Fomichev<stfomichev@gmail.com> wrote:
>> On 02/13, Jason Xing wrote:
>>> Support bpf_setsockopt() to set the maximum value of RTO for
>>> BPF program.
>>>
>>> Signed-off-by: Jason Xing<kerneljasonxing@gmail.com>
>>> ---
>>>   Documentation/networking/ip-sysctl.rst | 3 ++-
>>>   include/uapi/linux/bpf.h               | 2 ++
>>>   net/core/filter.c                      | 6 ++++++
>>>   tools/include/uapi/linux/bpf.h         | 2 ++
>>>   4 files changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
>>> index 054561f8dcae..78eb0959438a 100644
>>> --- a/Documentation/networking/ip-sysctl.rst
>>> +++ b/Documentation/networking/ip-sysctl.rst
>>> @@ -1241,7 +1241,8 @@ tcp_rto_min_us - INTEGER
>>>
>>>   tcp_rto_max_ms - INTEGER
>>>        Maximal TCP retransmission timeout (in ms).
>>> -     Note that TCP_RTO_MAX_MS socket option has higher precedence.
>>> +     Note that TCP_BPF_RTO_MAX and TCP_RTO_MAX_MS socket option have the
>>> +     higher precedence for configuring this setting.
>> The cover letter needs more explanation about the motivation.

+1

I haven't looked at the patches. The cover letter has no word on the use case. 
Using test_tcp_hdr_options.c as the test is unnecessarily complicated just for 
adding a new optname support. setget_sockopt.c is the right test to reuse.


> I am targeting the net-next tree because of recent changes[1] made by
> Eric. It probably hasn't merged into the bpf-next tree.

There is the bpf-next/net tree. It should have the needed changes.

pw-bot: cr

