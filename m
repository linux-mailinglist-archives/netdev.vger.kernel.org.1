Return-Path: <netdev+bounces-263421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNz7JcNPp2k0gwAAu9opvQ
	(envelope-from <netdev+bounces-263421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:16:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DD21F7557
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8187A3101DD9
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 21:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491133C279D;
	Tue,  3 Mar 2026 21:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sPd6IZY5"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AD63CD8AB
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 21:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572462; cv=none; b=Iy1+qMG9byQo6/TbKypwDyg6UHwalSHru5Mp7Zb0MJHZ4eWNlnXR5x2r6coIS2vHAZ9tMsAnJEyNnY0gjwIbLsyIeiw9/MRKBK8D4Ubt6iotFVAIwB54JX8gLmvzagPQ3gARjJ7qnbV6RNz8EVTvl0AoLrRLQ4oMGl5ViznvJf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572462; c=relaxed/simple;
	bh=aU8I06Byo+0ZrO9kKuYwRLdqMdSB/u++Mp9DqrpLlHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PoujGAThkTu9+jvmThx91QV/fi7bDIHfSScCPDqyH5FNzbrxUJ11NNVv9kqAYvDwX5dbVBRS2L2TdfhiUFYKV79WVkWPal4Z7LJErT/l0tVHYWVi8JPHqWxgAYQeC2LouDRSSziABX2fn4XV8yjiTMzw5ZvKoFGBi1k7YYt/9wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sPd6IZY5; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6302ae47-88b0-40cf-9b02-ff35f7292ec1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772572455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HcApNV65xllvWnEY+rPw944sQYzISRxzIQ3ebOilVOg=;
	b=sPd6IZY5BwhSavOZfUXvUe8VRuPQz+7hK1dLTG0NrL0SWePSqnA1hrIbpDT8U07bKu804S
	LhCTcL/+8T0kpBl2lOss+Y2k7DZwF9fChFNX/exWsmjjMofIQhmich8CsVoBXAjlFl+yf5
	WyeZbswUwzHOEax6ZNhTDaJk2dvqnOQ=
Date: Tue, 3 Mar 2026 13:13:59 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v9 bpf-next 2/2] selftests/bpf: Add selftests for the
 invocation of bpf_lwt_xmit_push_encap
To: Feng Yang <yangfeng59949@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, posk@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260303074423.172680-1-yangfeng59949@163.com>
 <20260303074423.172680-3-yangfeng59949@163.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260303074423.172680-3-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 37DD21F7557
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263421-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action



On 3/2/26 11:44 PM, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> Calling bpf_lwt_xmit_push_encap will not cause a crash when dst is missing.
> 
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>   .../selftests/bpf/progs/verifier_lwt.c        | 20 +++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_lwt.c b/tools/testing/selftests/bpf/progs/verifier_lwt.c
> index 5ab746307309..9cef07e6eceb 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_lwt.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_lwt.c
> @@ -231,4 +231,24 @@ __naked void not_permitted_for_lwt_prog(void)
>   	: __clobber_all);
>   }
>   
> +SEC("lwt_xmit")
> +__description("missing dst when calling bpf_lwt_xmit_push_encap")
> +__success __retval(0)
> +__naked void missing_dst_call_bpf_lwt_xmit_push_encap(void)
> +{
> +	asm volatile ("					\
> +	r9 = 69;					\

hmm... I just noticed this.

69 is the ip version and ihl?

> +	r3 = r10;					\
> +	r3 += -32;					\
> +	*(u64 *)(r3 + 0) = r9;				\

This will not work in big endian. Although x86 arch is enough to cover 
this test, these little things (e.g., the value 69, unnecessary asm 
...etc) make this test hard to read.

Let's bite the bullet and move this bpf test prog out of verifier_lwt.c. 
It is not testing the verifier to begin with. No need to write in asm 
either. Create its own progs/lwt_misc.c test file for misc lwt tests. 
Create a corresponding prog_tests/lwt_misc.c also. Write the bpf prog in 
C instead of asm. Use "char iph[20];" for the iph and init "iph[0] = 
0x45". Search for RUN_TESTS() usage in prog_tests/. It is pretty 
straightforward.

pw-bot: cr

> +	r2 = 2;						\
> +	r4 = 20;					\
> +	call %[bpf_lwt_push_encap];			\
> +	r0 = 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_lwt_push_encap)
> +	: __clobber_all);
> +}
> +
>   char _license[] SEC("license") = "GPL";


