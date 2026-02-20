Return-Path: <netdev+bounces-259732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO7FOTN/mGlMJQMAu9opvQ
	(envelope-from <netdev+bounces-259732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 16:35:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6E1168ED2
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 16:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D8563015883
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 15:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CB4342C8B;
	Fri, 20 Feb 2026 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pq1jHNkx"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66FF1F8AC5
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771601694; cv=none; b=dHOJm/5ZUISapMuSM2JfjjdYcm0XInH+kB8X9WDwcHKM7tjJ/2usnO6DlfKg+CLzryysc7qVkgQAmCw0Ce9ZnIOhs0+kfRkokrl2u41/ow7/JchCtrgydXNyZtwYf7HO5IHyRW/eKDPG6ddNv+bcXzjzi5VCP9u46YijkAxjTI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771601694; c=relaxed/simple;
	bh=pI1O8R9NQmElqnZf7f9jqAr1JKxcuC8TjAmVVLVErWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jx6sAL0T0btwGvu7Cnfok8uycgrN0kSVx7avrvt7s+5SGqH2ALJJf3Rh2hHsBLsfAQVTT3s7L2QNBTV7U2Ft4m6HePHff1w15Co1sUvm1p6XAV0QJrNmUkRBwd/gWnkVCa4VravFOrqeRL3L4RLQrqFKZ3L5Dqw6FUCf+QgxU0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pq1jHNkx; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e617cdaa-049a-453b-8f52-1966d350f907@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771601679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z943trj5fRXyCPYj1ZkF6pjisLAiil83x3fUBjHtWMM=;
	b=pq1jHNkxADK2dq95ZhyKT83WWsDHhuAU9Tk7GgkqH3T9xhFYuhT/xltBiGx4vnSB6psZG9
	mIcOrCU5w+8U9+VIJBy/0AT2mJIzS9OqpoZ7YzjSqS+5FgjD7J4hZ7u7S2FD6sYgP4+qEX
	ir5KmvMrEex2xcOtCALbiOVA35HY59Q=
Date: Fri, 20 Feb 2026 23:34:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Introduce 64-bit bitops kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, Peilin Ye <yepeilin@google.com>,
 Luis Gerhorst <luis.gerhorst@fau.de>, Viktor Malik <vmalik@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 kernel-patches-bot@fb.com
References: <20260219142933.13904-1-leon.hwang@linux.dev>
 <20260219142933.13904-2-leon.hwang@linux.dev>
 <CAADnVQK=5Gb3w_QG4Vq32EfvpqAK_DPwCHtzzt7DzRkJ5_h6JQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQK=5Gb3w_QG4Vq32EfvpqAK_DPwCHtzzt7DzRkJ5_h6JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259732-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,huaweicloud.com,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,fau.de,lists.infradead.org,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC6E1168ED2
X-Rspamd-Action: no action



On 2026/2/20 01:50, Alexei Starovoitov wrote:
> On Thu, Feb 19, 2026 at 6:30 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>> +static bool bpf_kfunc_is_fastcall(struct bpf_verifier_env *env, u32 func_id, u32 flags)
>> +{
>> +       if (!(flags & KF_FASTCALL))
>> +               return false;
>> +
>> +       if (!env->prog->jit_requested)
>> +               return true;
>> +
>> +       if (func_id == special_kfunc_list[KF_bpf_clz64])
>> +               return bpf_jit_inlines_kfunc_call(bpf_clz64);
>> +       if (func_id == special_kfunc_list[KF_bpf_ctz64])
>> +               return bpf_jit_inlines_kfunc_call(bpf_ctz64);
>> +       if (func_id == special_kfunc_list[KF_bpf_ffs64])
>> +               return bpf_jit_inlines_kfunc_call(bpf_ffs64);
>> +       if (func_id == special_kfunc_list[KF_bpf_fls64])
>> +               return bpf_jit_inlines_kfunc_call(bpf_fls64);
>> +       if (func_id == special_kfunc_list[KF_bpf_bitrev64])
>> +               return bpf_jit_inlines_kfunc_call(bpf_bitrev64);
>> +       if (func_id == special_kfunc_list[KF_bpf_popcnt64])
>> +               return bpf_jit_inlines_kfunc_call(bpf_popcnt64);
>> +       if (func_id == special_kfunc_list[KF_bpf_rol64])
>> +               return bpf_jit_inlines_kfunc_call(bpf_rol64);
>> +       if (func_id == special_kfunc_list[KF_bpf_ror64])
>> +               return bpf_jit_inlines_kfunc_call(bpf_ror64);
> 
> This is too ugly. Find a way to do it differently.

Agreed.

I'd like to introduce a new flag KF_JIT_MAY_INLINE to indicate the kfunc
will be inlined by JIT backends if possible. As for those kfuncs w/
KF_FASTCALL w/o KF_JIT_MAY_INLINE, they are fastcall always.

Thanks,
Leon


