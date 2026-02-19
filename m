Return-Path: <netdev+bounces-259399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGl5IfmclmksiAIAu9opvQ
	(envelope-from <netdev+bounces-259399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 06:17:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6179015C14B
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 06:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7A6430065D0
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 05:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977D1275AEB;
	Thu, 19 Feb 2026 05:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s1EnyG1r"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD4925A321
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 05:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771478263; cv=none; b=EpHf1nxiSZzIiJd8em7nbf9ziCtR3J97RO2XgrrkB5NI9JulJIrvxNzL1C1Jl9Duoxv0pfiln+x+a+I9nhwu/G0A8q5RFGXL/ZPFacBnUnU3j+jiSLsvuhqHU591UqLrFcpBNhOYg4LyNLHQ5tx/RZ1W0S7EMuq5jKIZsWLOBrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771478263; c=relaxed/simple;
	bh=9CfxS2RINrNA4HMKz1BbNhYqFgsoWu8o+Zo4mfiRAlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txKN+o4eIHRcx7p9lBIr3Y3Zy1zF5/95WwLHLpNvwYhCJcAuvBztlIfnMk24NKrY2TeyLz0+ikcWDifhoQCzmHGGAzXqancwrllf27RqIaDt5TOiTPMxmT0vOwL/Aq7fzCrxFFfQoIxdMH+hSq3WpNv9DQ/NrV7Pa/wLTr1P0Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s1EnyG1r; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <52bb474f-4b02-496b-ad27-31b0dfe0af5f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771478250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ce/qB83v8+271POftr+tV8f8fTpJav0alD44aA0UYo=;
	b=s1EnyG1r6Jf8BUk8JRdDLYDBEzkBmthGjNOJTOoqf4RnCrFod0aWmAMN4ANWH1cyV/KECy
	bik8bhh4Z1OnLkIjXBRWbFl2jtO86BqyYsNvY9jy673pQsB4nSjtJ21owWJ1KVMjwp7ykQ
	JSn7eR/FxOmFBsQbG/sTQV07lqSWJMk=
Date: Wed, 18 Feb 2026 21:17:20 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Add multi-level pointer parameter
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Slava Imameev <slava.imameev@crowdstrike.com>
Cc: Eduard <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Hao Luo <haoluo@google.com>, Simon Horman <horms@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 DL Linux Open Source Team <linux-open-source@crowdstrike.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Network Development <netdev@vger.kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>
References: <bb4bf5fe648ac71c969c6228ac6e72ea85cbc64b.camel@gmail.com>
 <20260218104328.14341-1-slava.imameev@crowdstrike.com>
 <CAADnVQ+xwC+J1hZcHPEUjBoKcUKmnucG4AFQ-kkDmqx+C-GcoA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+xwC+J1hZcHPEUjBoKcUKmnucG4AFQ-kkDmqx+C-GcoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259399-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,crowdstrike.com];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,crowdstrike.com,linux.dev,redhat.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yonghong.song@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 6179015C14B
X-Rspamd-Action: no action



On 2/18/26 7:15 PM, Alexei Starovoitov wrote:
> On Wed, Feb 18, 2026 at 2:44 AM Slava Imameev
> <slava.imameev@crowdstrike.com> wrote:
>>
>> - This programs cannot be compiled as bpf_core_cast cannot cast to a
>> multi-level pointer:
>>
>> SEC("lsm/sb_eat_lsm_opts")
>> int BPF_PROG(sb_eat_lsm_opts_1,char *options, void **mnt_opts)
>> {
>>      void** ppt = bpf_core_cast(mnt_opts, void*);
>>      bpf_printk("%p\t", *ppt);
>>      return 0;
>> }
> Looks like there is a bug in llvm, since it crashes on the above.
> But the following works:
>
> void** ppt = bpf_rdonly_cast(mnt_opts, 0);
> bpf_printk("%lx\t", *ppt);
>
> Plus Eduard's diff:
> -       if (is_void_or_int_ptr(btf, t))
> +       if (is_void_or_int_ptr(btf, t) || !btf_type_is_struct_ptr(btf, t))
>
>
>> - There is a workaround, which requires introducing a wrapper for
>> a pointer or typedef:
>>
>> struct pvoid {
>>      void* v;
>> };
> llvm should have handled it without the workaround. It's a bug
> that should be fixed.

Okay, I will take a look.

>
>> I think there are no technical restrictions for treating single
>> level pointers as PTR_TO_MEM.
> I think it will be a missed opportunity and a potential foot gun.
>
> We didn't support access to 'char *' initially.
> Later relaxed it to mean that it's a valid pointer to a single byte,
> but since the code is generic it also became the case
> that 'char *' is allowed in kfunc and the verifier checks
> that one valid byte is there.
> That was a bad footgun, since we saw several cases of broken
> kfunc implementations that assume that 'char *' means a string.
>
> There are only two lsm hooks that pass 'struct foo **'.
> If we make it ptr_to_mem of 8 bytes we lose the ability to do
> something smarter in the future.
> I think we better add support to annotate such '**' as an actual
> array with given size and track types completely, so
> 'struct foo * var[N]' will become array_to_ptr_to_btf_id.
> That's probably more work that you signed up to do,
> so I suggest treating 'void **' as a scalar as Eduard suggested.
> This particular sb_eat_lsm_opts() hook
> doesn't have a useful type behind it anyway.
> I'm less certain about 'char **'. If we make it scalar too
> it will be harder to make it a pointer to nul terminated string later.
>
> So I would do 'void **' -> scalar for now only.


