Return-Path: <netdev+bounces-166638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6049DA36B79
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 03:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308AC16B28F
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 02:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5822985931;
	Sat, 15 Feb 2025 02:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ngq2Cjk0"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ECB1078F
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 02:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739587180; cv=none; b=TiJtdZNZdZqjGikWH1UlGdzTC0wByvsOZ/vFSED+R9OtNab77mxLkaEY27yrPzdJcHExSnE5IQZEOH9ydmj92oz+dxVKXg8cwZP8VbDkKJCxnAhBIDaa8WmLg8gHLu/YLug4dqpVht7aE/33jLoUlPqf4wYZ7fm5eCNpHtNH8sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739587180; c=relaxed/simple;
	bh=PRSzxunal1ITQFP6OQ8WURsSphZ0eJAA2ZvAwE8E2ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iN563GPFfI+Eja/t6zHVZpRfOoGCe2SYxyASUe1s1TooH0dt66tBLvIbSp6L7c892NFG4L3ifGZcGRtL+kns1m7X1yxlE8d8skvokc2o77cK+xcuu5BeBZQW8q5RCTZdjfY8vZ6LbJpgpSVn/0bk98JBtbYZV/ny5dakrNM8mLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ngq2Cjk0; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d7e21933-cd3b-43a2-9678-4f0e592ec87a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739587166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NbHmdbolauoHSWeTkAMTQwQrllAhAEGsRt2pwbxLJBk=;
	b=ngq2Cjk0aEXum0U2E7t9HnvFzsJtLtQDoDnqAZlbKCNeOARfdQya8I4Z+ZQ8biMgTMCcnP
	dSMEv0FXvZH/VhtCq9JbBQuDiS1FPVzQLmzZ3Cdrd4Nltt6GJFv4pVocpq2ES9xO5ZV2rw
	UiqOv0Ev72S2VoiZgF852ZIV283U3Q0=
Date: Fri, 14 Feb 2025 18:39:18 -0800
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
 <039bfa0d-3d61-488e-9205-bef39499db6e@linux.dev>
 <CAL+tcoBAv5QuGeiGYUakhxBwVEsut7Gaa-96YOH03h57jtTVaQ@mail.gmail.com>
 <86453e67-d5dc-4565-bdd6-6383273ed819@linux.dev>
 <CAL+tcoApvV0vyiTKdaMWMp8F=ZWSodUg0zD+eq_F6kp=oh=hmA@mail.gmail.com>
 <b3f30f7d-e0c3-4064-b27e-6e9a18b90076@linux.dev>
 <CAL+tcoB2EO_FJis4wp7WkMdEZQyftwuG2X6z0UrJEFaYnSocNg@mail.gmail.com>
 <3dab11ad-5cba-486f-a429-575433a719dc@linux.dev>
 <CAL+tcoAhQTMBxC=qZO0NpiqRCdfGEkD7iWxSg7Odfs4eO7N_JQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoAhQTMBxC=qZO0NpiqRCdfGEkD7iWxSg7Odfs4eO7N_JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/14/25 3:53 PM, Jason Xing wrote:
> Another related topic about rto min test, do you think it's necessary
> to add TCP_BPF_RTO_MIN into the setget_sockopt test?

hmm... not sure why it is related to the existing TCP_BPF_RTO_MIN.
I thought this patch is adding the new TCP_RTO_MAX_MS...

or you want to say, while adding a TCP_RTO_MAX_MS test, add a test for the 
existing TCP_BPF_RTO_MIN also because it is missing in the setget_sockopt?
iirc, I added setget_sockopt.c to test a patch that reuses the kernel 
do_*_{set,get}sockopt. Thus, it assumes the optname supports both set and get. 
TCP_BPF_RTO_MIN does not support get, so I suspect setget_sockopt will not be a 
good fit. They are unrelated, so I would leave it out of your patch for now.

