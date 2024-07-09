Return-Path: <netdev+bounces-110408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2AC92C33F
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 20:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9AC2843CB
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 18:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453B518003E;
	Tue,  9 Jul 2024 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mrg/Q7KZ"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4D718002D
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720549513; cv=none; b=tLOA21OCh6d2/AU2hTUo3Vu47RYNQn6Qwtxys1fa7WDhYNSICcvoseZrK7T4xxktN+/CZDIinp62SktfLR1xTMIAYe8xbOEF3TItP8paqPz4EBdo5Sj/yKrFA9D7WVaa0tkESJE0klA8Nt0EaMrJ5qB4BNs7klAZc2waUFzUri8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720549513; c=relaxed/simple;
	bh=Jw7dwHPITXICNZcVM+fmJgME1qTGYzXuEe761IWq4W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6wlJawEN0CL+bt9doWUkkHxpwA1T0FpYjNS8JG6YWKhDH/Pe4KfNxEh0L99KD36mRfkzKWx8XyxztlD5OQrY8oRgarlQ10FV6PUvAWjQAbeT5gj76pZKyC7zNL07PTP1jwByAL90InEPELC5Yt3psldyLbna6fO70a5vSrQVsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mrg/Q7KZ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bigeasy@linutronix.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720549508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+lzj8HHpDdYXBfkhubcLB2WR2VzRqyg5JX5BCx13yDA=;
	b=Mrg/Q7KZ/6be0KxgXdVKT0tr33c7s1ctQwf9jQiSZdgNFBy+UEjQxz2jhC+AVsnEO/rlwf
	GOIwTc2MYV9ZV0ommip+0R8tSAB18V30X6qB6bDRKhslpuQmTgHp3coCtfSwmXu7Vley/V
	P4/02DSZK7fhZ4UZhREc1TWRcDrpBR8=
X-Envelope-To: syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: davem@davemloft.net
X-Envelope-To: dsahern@kernel.org
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: edumazet@google.com
X-Envelope-To: haoluo@google.com
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: sdf@fomichev.me
X-Envelope-To: sdf@google.com
X-Envelope-To: song@kernel.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
X-Envelope-To: yonghong.song@linux.dev
X-Envelope-To: tglx@linutronix.de
X-Envelope-To: m.xhonneux@gmail.com
X-Envelope-To: dlebrun@google.com
Message-ID: <c0b02b51-dba3-43f3-8d21-c3183c0342d8@linux.dev>
Date: Tue, 9 Jul 2024 11:24:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] seg6: Ensure that seg6_bpf_srh_states can only
 be accessed from input_action_end_bpf()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: syzbot <syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 dsahern@kernel.org, eddyz87@gmail.com, edumazet@google.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com,
 yonghong.song@linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 Mathieu Xhonneux <m.xhonneux@gmail.com>, David Lebrun <dlebrun@google.com>
References: <000000000000571681061bb9b5ad@google.com>
 <20240705104133.NU9AwKDS@linutronix.de>
 <82c77e30-6e9d-44c3-bdcd-7da17654fa81@linux.dev>
 <20240709051817.VmyBTQ86@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240709051817.VmyBTQ86@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/8/24 10:18 PM, Sebastian Andrzej Siewior wrote:
> On 2024-07-08 17:03:58 [-0700], Martin KaFai Lau wrote:
>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>> index 403d23faf22e1..ea5bc4a4a6a23 100644
>>> --- a/net/core/filter.c
>>> +++ b/net/core/filter.c
>>> @@ -6459,6 +6459,8 @@ BPF_CALL_4(bpf_lwt_seg6_store_bytes, struct sk_buff *, skb, u32, offset,
>>>    	void *srh_tlvs, *srh_end, *ptr;
>>>    	int srhoff = 0;
>>> +	if (!bpf_net_ctx_seg6_state_avail())
>>> +		return -EINVAL;
>>
>> The syzbot stack shows that the seg6local bpf_prog can be run by test_run
>> like: bpf_prog_test_run_skb() => bpf_test_run(). "return -EINVAL;" will
>> reject and break the existing bpf prog doing test with test_run.
> 
> But wouldn't this be the case anyway because seg6_bpf_srh_states::srh
> isn't assigned?

Good point.

I don't think the test_run for BPF_PROG_TYPE_LWT_SEG6LOCAL ever works. It seems 
no test_run selftest was ever added to exercise this code path since the 
lwt_seg6local_prog_ops was added in commit 004d4b274e2a ("ipv6: sr: Add 
seg6local action End.BPF").

I think the right thing to do here is to remove the test_run code path for 
BPF_PROG_TYPE_LWT_SEG6LOCAL instead of further patching it. A separate patch for 
proper test_run support is needed (cc: Mathieu Xhonneux).

To remove test_run for BPF_PROG_TYPE_LWT_SEG6LOCAL, this should do:

diff --git i/net/core/filter.c w/net/core/filter.c
index 403d23faf22e..db5e59f62b35 100644
--- i/net/core/filter.c
+++ w/net/core/filter.c
@@ -11053,7 +11053,6 @@ const struct bpf_verifier_ops lwt_seg6local_verifier_ops = {
  };

  const struct bpf_prog_ops lwt_seg6local_prog_ops = {
-	.test_run		= bpf_prog_test_run_skb,
  };

  const struct bpf_verifier_ops cg_sock_verifier_ops = {

Then the bpf_lwt_seg6_* helpers should stay in the input_action_end_bpf() code 
path only.


