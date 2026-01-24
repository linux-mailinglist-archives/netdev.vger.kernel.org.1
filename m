Return-Path: <netdev+bounces-253027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCotF19idGmv5AAAu9opvQ
	(envelope-from <netdev+bounces-253027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:10:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A5D7C9A5
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BC5D3013B4D
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 06:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C792823A99E;
	Sat, 24 Jan 2026 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="caspnkqA"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FAC21256C
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235031; cv=none; b=Hlk4B4TDC5yGONCv0nPf6IWRFJ4u5yefz5xKK12Xxf0EsuZ07DSedAqo+U0rXW4PKe3me+kNX/5EYip/Hww4Ji2A94eZEhu0L+4O3f9V12cjp4iApfgzrI4KHVFlo4Tz/05BOC9sinb+4Nt0RAn/xG4TquRWxh53lP90PjWj/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235031; c=relaxed/simple;
	bh=3DshowPd5UH8QdtymmXbXqHLZNSLQexFMhz/sxvHnbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8vZKtQVsNKFTmYGfSfae2CNEO8qPDucl1Wz933MfKUhDP7kLuXIRTio9MLIUlCkgd17kZsi/EXE8kjm3nMmzePiNcKF7/2faiZRJkX9Z2mAkH2jtugc59iAZWa/Akf2yTGHR1vbhmZl1SiO11HzP/40x9zZm9o1VmbCMPhFNn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=caspnkqA; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769235017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLL+DSALaiaCyHkccN04ZlpoBn+BdgA+NrFlgliZ5k4=;
	b=caspnkqAJ50SJc8nbFa/JkdpIe/38FO1OkKTaLWqSf0RhEa6aowplV8D9JthGmVAYzxrHY
	QgTYulyJQnW56EH7bZMQDLwHjntqgFsZO8Qaoqx44sr3Tm9sYh63aFGH71BGoPPL8H9AkK
	+RACdOkhT0r7JqMUWdqnGMg44xO/9TY=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v12 11/13] selftests/bpf: test bpf_get_func_* for
 fsession
Date: Sat, 24 Jan 2026 13:09:12 +0800
Message-ID: <5962490.DvuYhMxLoT@7950hx>
In-Reply-To: <20260124033119.28682-12-dongml2@chinatelecom.cn>
References:
 <20260124033119.28682-1-dongml2@chinatelecom.cn>
 <20260124033119.28682-12-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	CTE_CASE(0.50)[];
	URIBL_RED(0.50)[chinatelecom.cn:email];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	HAS_ANON_DOMAIN(0.10)[];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253027-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[linux.dev:s=key1];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim]
X-Rspamd-Queue-Id: 04A5D7C9A5
X-Rspamd-Action: no action

On 2026/1/24 11:31, Menglong Dong wrote:
> Test following bpf helper for fsession:
>   bpf_get_func_arg()
>   bpf_get_func_arg_cnt()
>   bpf_get_func_ret()
>   bpf_get_func_ip()
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  .../bpf/prog_tests/get_func_args_test.c       |  1 +
>  .../bpf/prog_tests/get_func_ip_test.c         |  2 ++
>  .../selftests/bpf/progs/get_func_args_test.c  | 31 ++++++++++++++++++-
>  .../selftests/bpf/progs/get_func_ip_test.c    | 14 +++++++++
>  4 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
> index fadee95d3ae8..96b27de05524 100644
> --- a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
> @@ -41,6 +41,7 @@ void test_get_func_args_test(void)
>  	ASSERT_EQ(skel->bss->test4_result, 1, "test4_result");
>  	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
>  	ASSERT_EQ(skel->bss->test6_result, 1, "test6_result");
> +	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
>  
>  cleanup:
>  	get_func_args_test__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> index c40242dfa8fb..7772a0f288d3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> @@ -46,6 +46,8 @@ static void test_function_entry(void)
>  	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
>  	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
>  	ASSERT_EQ(skel->bss->test8_result, 1, "test8_result");
> +	ASSERT_EQ(skel->bss->test9_entry_result, 1, "test9_entry_result");
> +	ASSERT_EQ(skel->bss->test9_exit_result, 1, "test9_exit_result");
>  
>  cleanup:
>  	get_func_ip_test__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
> index 5b7233afef05..8ecc5f339552 100644
> --- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
> +++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/bpf.h>
> +#include <vmlinux.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  #include <errno.h>
> @@ -165,3 +165,32 @@ int BPF_PROG(tp_test2)
>  
>  	return 0;
>  }
> +
> +__u64 test7_result = 0;
> +SEC("fsession/bpf_fentry_test1")
> +int BPF_PROG(test7)
> +{
> +	__u64 cnt = bpf_get_func_arg_cnt(ctx);
> +	__u64 a = 0, z = 0, ret = 0;
> +	__s64 err;
> +
> +	test7_result = cnt == 1;
> +
> +	/* valid arguments */
> +	err = bpf_get_func_arg(ctx, 0, &a);
> +	test7_result &= err == 0 && ((int) a == 1);
> +
> +	/* not valid argument */
> +	err = bpf_get_func_arg(ctx, 1, &z);
> +	test7_result &= err == -EINVAL;
> +
> +	if (bpf_session_is_return(ctx)) {
> +		err = bpf_get_func_ret(ctx, &ret);
> +		test7_result &= err == 0 && ret == 2;
> +	} else {
> +		err = bpf_get_func_ret(ctx, &ret);
> +		test7_result &= err == 0 && ret == 0;
> +	}
> +
> +	return 0;
> +}

CI failed, as this testcase can't run on !CONFIG_X86_64, and
"#ifdef __TARGET_ARCH_x86" should be used here.

Will send a V13 later :)

> diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> index 2011cacdeb18..bd7598a037cd 100644
> --- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> +++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> @@ -103,3 +103,17 @@ int BPF_URETPROBE(test8, int ret)
>  	test8_result = (const void *) addr == (const void *) uprobe_trigger;
>  	return 0;
>  }
> +
> +__u64 test9_exit_result = 0;
> +__u64 test9_entry_result = 0;
> +SEC("fsession/bpf_fentry_test1")
> +int BPF_PROG(test9, int a)
> +{
> +	__u64 addr = bpf_get_func_ip(ctx);
> +
> +	if (bpf_session_is_return(ctx))
> +		test9_exit_result = (const void *) addr == &bpf_fentry_test1;
> +	else
> +		test9_entry_result = (const void *) addr == &bpf_fentry_test1;
> +	return 0;
> +}
> 





