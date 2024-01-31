Return-Path: <netdev+bounces-67379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B54A384326D
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 02:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2351F21A45
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 01:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3408C4A2D;
	Wed, 31 Jan 2024 01:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KBcLPuM1"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25DD1C2D
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 01:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706662886; cv=none; b=ZDLgqGoHloNz0cgLEgKgDteT/Cmm0cN+79uyV//aB2Nz4y1n1wkvTTLOn5MQzbPsQifAj/x/6Gqk78ZKLO5uDixIC0ZSLgXsjTsw2hYq58xV0R0j/aT7dQdV/KFF3OvyQgOM85BL2hjFKjpB3WhrsShkO1oVDc82tbUDlQTVnzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706662886; c=relaxed/simple;
	bh=JPWbcteyF/B/SUQc1IBzn5CKOh8NRM6vo4FHl/I4eMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVs6SgK0vvueBWBWFJhm+qT999Yxs+XLLdfW73h9XFl9OoQ7ovOWo3oJnXRKQuj7DszLXNdXkIzlwsT2s2cML1MX4CpusO97OYsQUDSppqXxh4PSgBlrzHIHN5t4XD2+n4Pd3KIPWNAJu99NMgmLFsHomStl0GxkZaouvYl1dfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KBcLPuM1; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b36c40fb-d274-41ea-abbe-231bebfabdc9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706662881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lybkWAjuJkn5+elNY5z6HFDPpOuO054YdAYasMBSg7M=;
	b=KBcLPuM1rq69TK5pKwWL2MA/hkQ4DRFlpGI/0MCwP/DTFIB3o5lXt+h++83bgiLLbCbqfw
	Rmj2Rf9XEQsKINFRKesTNBs1AQJZc/G9g7pOmAtaIf1XwnegXYuKmyAC7uH4cFnyAW38lA
	fN4V3h6j9uV5KNCIIjzgg11bBcxIB+k=
Date: Tue, 30 Jan 2024 17:01:14 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v7 1/8] net_sched: Introduce eBPF based Qdisc
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
 yangpeihao@sjtu.edu.cn, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 sdf@google.com, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com,
 netdev@vger.kernel.org, Kui-Feng Lee <thinker.li@gmail.com>
References: <cover.1705432850.git.amery.hung@bytedance.com>
 <232881645a5c4c05a35df4ff1f08a19ef9a02662.1705432850.git.amery.hung@bytedance.com>
 <0484f7f7-715f-4084-b42d-6d43ebb5180f@linux.dev>
 <CAMB2axM1TVw05jZsFe7TsKKRN8jw=YOwu-+rA9bOAkOiCPyFqQ@mail.gmail.com>
 <01fdb720-c0dc-495d-a42d-756aa2bf4455@linux.dev>
 <CAMB2axOZqwgksukO5d4OiXeEgo2jFrgnzO5PQwABi_WxYFycGg@mail.gmail.com>
 <8c00bd63-2d00-401e-af6d-1b6aebac4701@linux.dev>
 <845df264-adb3-4e00-bb8e-2a0ac1d331ae@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <845df264-adb3-4e00-bb8e-2a0ac1d331ae@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/30/24 9:49 AM, Kui-Feng Lee wrote:
>>> 2. Returning a kptr from a program and treating it as releasing the reference.
>>
>> e.g. for dequeue:
>>
>> struct Qdisc_ops {
>>      /* ... */
>>      struct sk_buff *        (*dequeue)(struct Qdisc *);
>> };
>>
>>
>> Right now the verifier should complain on check_reference_leak() if the 
>> struct_ops bpf prog is returning a referenced kptr.
>>
>> Unlike an argument, the return type of a function does not have a name to tag. 
>> It is the first case that a struct_ops bpf_prog returning a 
> 
> We may tag the stub functions instead, right?

What is the suggestion on how to tag the return type?

I was suggesting it doesn't need to tag and it should by default require a 
trusted ptr for the pointer returned by struct_ops. The pointer argument and the 
return pointer of a struct_ops should be a trusted ptr.

> Is the purpose here to return a referenced pointer from a struct_ops
> operator without verifier complaining?

Yes, basically need to teach the verifier the kernel will do the reference release.

> 
>> pointer. One idea is to assume it must be a trusted pointer (PTR_TRUSTED) and 
>> the verifier should check it is indeed with PTR_TRUSTED flag.
>>
>> May be release_reference_state() can be called to assume the kernel will 
>> release it as long as the return pointer type is PTR_TRUSTED and the type 
>> matches the return type of the ops. Take a look at check_return_code(). 


