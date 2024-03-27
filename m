Return-Path: <netdev+bounces-82682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D0488F1B1
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 23:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B231C28E18
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 22:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F47715359B;
	Wed, 27 Mar 2024 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N0J7uWQT"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8855E150982
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 22:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711577787; cv=none; b=e83/+u0xxG5juXA+X5AYcG9sG7iPVdwIPgoAKocAZ6paH/BZWqMBqCyy65rfw4XGLdw5hm2OynhDatVN9Uw3LVuNMfsZextv9U0sT4nE2o2lI1RQEg5puCriWyYzrZlCH1zXlW6u+Jd58IPbVKkqMiZwv5GVD2VNO1oUy5SWQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711577787; c=relaxed/simple;
	bh=TL38rdaM2fQ9Y+5FhIl1zc5uqD5U3p45jsJRIMDvQP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqSsKCSGLJsBquPWfZpnSadtdOATfAgSn7RZBBgCkFFm4bxOf+RCS7dzF+C17ujOLPTuoEpW6GedcOUUAGoCtYgB2DoHYEd2u/3DicvAXeAgD0Too/DR3jPBqptCrhZtv17C07BJUkmh06FJMkyGpErxRpbceRnGx/XIeaUp+jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N0J7uWQT; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <649dc1dc-ca80-4686-ae37-62d7c81dde8b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711577783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhS1cYr0b+J7i2oT4omrAU15v3XtnTOguzp54SXOCQI=;
	b=N0J7uWQTyZ6m2rCZR5vCqOCF8LFZ97B9Qh2zySkgqlOdPOAY/OStiAeTy+TXwJ3xUT71Nt
	kUCRYs0qRUSYamP3DS9vqNmf4wBPFm75cq6gJPoxBq0PIITrTH19ofRa4ivxSBJhPs38vO
	vYESVjEDBS7EEkDKF9jnrZxaQT9vuNM=
Date: Wed, 27 Mar 2024 15:16:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: mptcp splat
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 MPTCP Upstream <mptcp@lists.linux.dev>, Matthieu Baerts
 <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
References: <CAADnVQKCxxETthqDpcE1xMGwa5au8JuLr_49QuwemL7uBKfiVg@mail.gmail.com>
 <8410a6f61e7a778117819ebeda667687353ffb21.camel@redhat.com>
 <CAADnVQLj9bQDonRzJO5z2hMZ7kf6zdU-s6Cm_7_kj-wP3CiUSA@mail.gmail.com>
 <d917d3a5690a0115cb8136e1dda5fbe5621dcd95.camel@redhat.com>
 <CAADnVQKXcEhL680E85=rrYuu4eVvVTH60kYRY_VnAKzZo1qKYg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQKXcEhL680E85=rrYuu4eVvVTH60kYRY_VnAKzZo1qKYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/27/24 11:50 AM, Alexei Starovoitov wrote:
> On Wed, Mar 27, 2024 at 11:33 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On Wed, 2024-03-27 at 10:00 -0700, Alexei Starovoitov wrote:
>>> On Wed, Mar 27, 2024 at 9:56 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>>
>>>> On Wed, 2024-03-27 at 09:43 -0700, Alexei Starovoitov wrote:
>>>>> I ffwded bpf tree with the recent net fixes and caught this:
>>>>>
>>>>> [   48.386337] WARNING: CPU: 32 PID: 3276 at net/mptcp/subflow.c:1430
>>>>> subflow_data_ready+0x147/0x1c0
>>>>> [   48.392012] Modules linked in: dummy bpf_testmod(O) [last unloaded:
>>>>> bpf_test_no_cfi(O)]
>>>>> [   48.396609] CPU: 32 PID: 3276 Comm: test_progs Tainted: G
>>>>> O       6.8.0-12873-g2c43c33bfd23 #1014
>>>>> #[   48.467143] Call Trace:
>>>>> [   48.469094]  <TASK>
>>>>> [   48.472159]  ? __warn+0x80/0x180
>>>>> [   48.475019]  ? subflow_data_ready+0x147/0x1c0
>>>>> [   48.478068]  ? report_bug+0x189/0x1c0
>>>>> [   48.480725]  ? handle_bug+0x36/0x70
>>>>> [   48.483061]  ? exc_invalid_op+0x13/0x60
>>>>> [   48.485809]  ? asm_exc_invalid_op+0x16/0x20
>>>>> [   48.488754]  ? subflow_data_ready+0x147/0x1c0
>>>>> [   48.492159]  mptcp_set_rcvlowat+0x79/0x1d0
>>>>> [   48.495026]  sk_setsockopt+0x6c0/0x1540
>>>>>
>>>>> It doesn't reproduce all the time though.
>>>>> Some race?
>>>>> Known issue?
>>>>
>>>> It was not known to me. Looks like something related to not so recent
>>>> changes (rcvlowat support).
>>>>
>>>> Definitely looks lie a race.
>>>>
>>>> If you could share more info about the running context and/or a full
>>>> decoded splat it could help, thanks!
>>>
>>> This is just running bpf selftests in parallel:
>>> test_progs -j
>>>
>>> The end of the splat:
>>> [   48.500075]  __bpf_setsockopt+0x6f/0x90
>>> [   48.503124]  bpf_sock_ops_setsockopt+0x3c/0x90
>>> [   48.506053]  bpf_prog_509ce5db2c7f9981_bpf_test_sockopt_int+0xb4/0x11b
>>> [   48.510178]  bpf_prog_dce07e362d941d2b_bpf_test_socket_sockopt+0x12b/0x132
>>> [   48.515070]  bpf_prog_348c9b5faaf10092_skops_sockopt+0x954/0xe86
>>> [   48.519050]  __cgroup_bpf_run_filter_sock_ops+0xbc/0x250
>>> [   48.523836]  tcp_connect+0x879/0x1160
>>> [   48.527239]  ? ktime_get_with_offset+0x8d/0x140
>>> [   48.531362]  tcp_v6_connect+0x50c/0x870
>>> [   48.534609]  ? mptcp_connect+0x129/0x280
>>> [   48.538483]  mptcp_connect+0x129/0x280
>>> [   48.542436]  __inet_stream_connect+0xce/0x370
>>> [   48.546664]  ? rcu_is_watching+0xd/0x40
>>> [   48.549063]  ? lock_release+0x1c4/0x280
>>> [   48.553497]  ? inet_stream_connect+0x22/0x50
>>> [   48.557289]  ? rcu_is_watching+0xd/0x40
>>> [   48.560430]  inet_stream_connect+0x36/0x50
>>> [   48.563604]  bpf_trampoline_6442491565+0x49/0xef
>>> [   48.567770]  ? security_socket_connect+0x34/0x50
>>> [   48.575400]  inet_stream_connect+0x5/0x50
>>> [   48.577721]  __sys_connect+0x63/0x90
>>> [   48.580189]  ? bpf_trace_run2+0xb0/0x1a0
>>> [   48.583171]  ? rcu_is_watching+0xd/0x40
>>> [   48.585802]  ? syscall_trace_enter+0xfb/0x1e0
>>> [   48.588836]  __x64_sys_connect+0x14/0x20
>>
>> Ouch, it looks bad. BPF should not allow any action on mptcp subflows
>> that go through sk_socket. They touch the mptcp main socket, which is
>> _not_ protected by the subflow socket lock.
>>
>> AFICS currently the relevant set of racing sockopt allowed by bpf boils
>> down to SO_RCVLOWAT only - sk_setsockopt(SO_RCVLOWAT) will call sk-
>>> sk_socket->ops->set_rcvlowat()
>>
>> So something like the following (completely untested) should possibly
>> address the issue at hand, but I think it would be better/safer
>> completely disable ebpf on mptcp subflows, WDYT?
>>
>> Thanks,
>>
>> Paolo
>>
>> ---
>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>> index dcd1c76d2a3b..6e5e64c2cf89 100644
>> --- a/net/mptcp/sockopt.c
>> +++ b/net/mptcp/sockopt.c
>> @@ -1493,6 +1493,9 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
>>          struct mptcp_subflow_context *subflow;
>>          int space, cap;
>>
>> +       if (has_current_bpf_ctx())
>> +               return -EINVAL;
>> +
> 
> Looks fine to me.
> 
> Martin,
> 
> Do you have any better ideas?
> 
> The splat explains the race.
> In this case setget_sockopt test happen to run in parallel
> with mptcp/bpf test and the former one was TCP connect request
> but it was for subflow.
> 
> We can disable that callback when tcp flow is a subflow,
> but that doesn't feel right.

I am also not sure if we can disable all set/getsockopt for tcp subflows. Not 
clear if there is use case that depends on this to setsockopt the subflow.

> I think Paolo's targeted fix is cleaner.

I will also go with Paolo's fix. The radius is smaller. I don't have a better idea.

Unrelated, is there a way to tell if a tcp_sock is a subflow? bpf prog can use 
it to decide if it wants to setsockopt on a subflow or not.


