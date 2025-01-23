Return-Path: <netdev+bounces-160669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7E6A1AC75
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 23:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBA53A5F90
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 22:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5461CBE95;
	Thu, 23 Jan 2025 22:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vRXkir+J"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AB01C5F26
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 22:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737670167; cv=none; b=meld69h8bx6OewPFtk3vyUzBN/c7TP/jhhizKULh9DIfJU05Sa54QJ/qUeMyAwqxRLqNqooolP9FKsAX0DsDrmEAIJkFbkkoAg3Sc7SGwyx4f7708EyZaexf2DAld1unYjaRYSrF8cDOJxrEcQbTXeixQkWOFFXuzPNAPF+hNN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737670167; c=relaxed/simple;
	bh=2JmqOhboPRPDZz8CXMfItF1J+nsmfLoDcpmyWJDutdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/YsxaBhkBofpO0qGMhvWMUUxpTvfIWPEQmmO6GY+pfyaXsX/vWQYVw0T+apqmFrtE0RdgfTbvOUK7xyvqmlI3ZmgPUz6fMgY9vR+NOeztmfTfkxgwgJfqG0zuLSAEsS0T+X/ra99f7xPYAyixOeZWlGXBhitzmuGsUAihUDZj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vRXkir+J; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5e342fea-764b-48a0-afda-4adfb504bd46@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737670157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxuszYqUcy92pyE+ca7H2NSup9nD9q/odGEB7qlqknw=;
	b=vRXkir+JQPNyMCu8k53IOq2yLa+Qcydt9EevYYPxmoWVS7MI5lmT5nYf9S9/4+mQF+wf0+
	Ij1m0yi/0gApsoRssOUIs4t3eEN6zgtDpwiEETFnmrSUJHzkAfkJllVVl8dQr0MpkIt2sJ
	nZ0UCYkI8jiSbQXTf8AeHGM4uqF2e7w=
Date: Thu, 23 Jan 2025 14:09:09 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Adjust data size to have
 ETH_HLEN
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Shigeru Yoshida <syoshida@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 hawk@kernel.org, lorenzo@kernel.org, toke@redhat.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250121150643.671650-1-syoshida@redhat.com>
 <20250121150643.671650-2-syoshida@redhat.com> <Z5KWE6J8OtRVCFDR@mini-arch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <Z5KWE6J8OtRVCFDR@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/23/25 11:18 AM, Stanislav Fomichev wrote:
> On 01/22, Shigeru Yoshida wrote:
>> The function bpf_test_init() now returns an error if user_size
>> (.data_size_in) is less than ETH_HLEN, causing the tests to
>> fail. Adjust the data size to ensure it meets the requirement of
>> ETH_HLEN.
>>
>> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>> ---
>>   .../testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c  | 4 ++--
>>   .../testing/selftests/bpf/prog_tests/xdp_devmap_attach.c  | 8 ++++----
>>   2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
>> index c7f74f068e78..df27535995af 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
>> @@ -52,10 +52,10 @@ static void test_xdp_with_cpumap_helpers(void)
>>   	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to cpumap entry prog_id");
>>   
>>   	/* send a packet to trigger any potential bugs in there */
>> -	char data[10] = {};
>> +	char data[ETH_HLEN] = {};
>>   	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
>>   			    .data_in = &data,
>> -			    .data_size_in = 10,
>> +			    .data_size_in = sizeof(data),
>>   			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
>>   			    .repeat = 1,
>>   		);
> 
> We should still keep 10, but change the ASSERT_OK below to expect the
> error instead. Looking at the comment above, the purpose of the test
> is to exercise that error case.
> 

I think the bpf_prog_test_run_opts in this dev/cpumap test is to check the 
bpf_redirect_map() helper, so it expects the bpf_prog_test_run_opts to succeed.

It just happens the current data[10] cannot trigger the fixed bug because the 
bpf prog returns a XDP_REDIRECT instead of XDP_PASS, so xdp_recv_frames is not 
called.

To test patch 1, a separate test is probably needed to trigger the bug in 
xdp_recv_frames() with a bpf prog returning XDP_PASS.

