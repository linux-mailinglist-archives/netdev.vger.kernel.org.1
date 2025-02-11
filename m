Return-Path: <netdev+bounces-165077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AAFA3053A
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 09:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B85163327
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 08:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790E21EE00D;
	Tue, 11 Feb 2025 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bnH152uW"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286BE1EE01F
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 08:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261171; cv=none; b=TQqXehaUsQkTX9cL8uUWiriZdjuQJU0ea9baj7HrDIF7VDCdb/6OJVwc0KYErUUoWxG4dZlTR/mTGf7zEze/SZWHk/9sdi+v/Xh6c0vKsWgdI4bZcs+Y/TWlSDZUsIN9oUpt4NH22VoAEgr5z+o1tWiO/64U6+0oNCj4cyj5we4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261171; c=relaxed/simple;
	bh=6sU8F6TX0euA2jkNZIJk4Cc+iN1AjOABB6zgXU3hJDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c94ctfyxmeeTA7OeKq4cEPeh1ZMxd8KJhWgJCmo93oXP5Iy3RxzW/j5Vu3oszLfsTB1NGyCIsiExyJ3N6xbIRwXDg2jqx5eGuJA7LVfD3itNLYj74tz+M0VtjPT1n54QE4spxXEBRaeN2+e15HWz+ueLHnk4po0e7INI/W8PAGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bnH152uW; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <520cad5d-e6ab-49fe-a0f2-daa522805e19@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739261157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBGj3TiFw9EHGGZXCAtkf+zy+3IOvslCOoLSXdqXzpM=;
	b=bnH152uWHttNeQskEQfcGJbLMn+paS4Q+Ib2fZpEDdm/UOgNfj/Hf4I9nnJK/gsYKYklAl
	b9YWFgkptoJn0u+kGI6a0IytpuswjIG5hCN+OTVIJImbdLeQw9jmlk/nT8QZ6mAnFZzfL3
	CF8glgs83FW21HNCsaiBPIBM+tpfoA0=
Date: Tue, 11 Feb 2025 00:05:48 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 12/12] selftests/bpf: add simple bpf tests in
 the tx path for timestamping feature
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
 <20250208103220.72294-13-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250208103220.72294-13-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/8/25 2:32 AM, Jason Xing wrote:
> ---
>   .../bpf/prog_tests/so_timestamping.c          |  79 +++++
>   .../selftests/bpf/progs/so_timestamping.c     | 312 ++++++++++++++++++

A bike shedding. s/so_timestamping.c/net_timestamping.c/

> diff --git a/tools/testing/selftests/bpf/progs/so_timestamping.c b/tools/testing/selftests/bpf/progs/so_timestamping.c
> new file mode 100644
> index 000000000000..4974552cdecb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/so_timestamping.c
> @@ -0,0 +1,312 @@
> +#include "vmlinux.h"
> +#include "bpf_tracing_net.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +#include "bpf_kfuncs.h"
> +#define BPF_PROG_TEST_TCP_HDR_OPTIONS
> +#include "test_tcp_hdr_options.h"
> +#include <errno.h>
> +
> +#define SK_BPF_CB_FLAGS 1009
> +#define SK_BPF_CB_TX_TIMESTAMPING 1
> +
> +int nr_active;
> +int nr_snd;
> +int nr_passive;
> +int nr_sched;
> +int nr_txsw;
> +int nr_ack;
> +
> +struct sockopt_test {
> +	int opt;
> +	int new;
> +};
> +
> +static const struct sockopt_test sol_socket_tests[] = {
> +	{ .opt = SK_BPF_CB_FLAGS, .new = SK_BPF_CB_TX_TIMESTAMPING, },
> +	{ .opt = 0, },
> +};
> +
> +struct loop_ctx {
> +	void *ctx;
> +	const struct sock *sk;
> +};
> +
> +struct sk_stg {
> +	__u64 sendmsg_ns;	/* record ts when sendmsg is called */
> +};
> +
> +struct sk_tskey {
> +	u64 cookie;
> +	u32 tskey;
> +};
> +
> +struct delay_info {
> +	u64 sendmsg_ns;		/* record ts when sendmsg is called */
> +	u32 sched_delay;	/* SCHED_OPT_CB - sendmsg_ns */
> +	u32 sw_snd_delay;	/* SW_OPT_CB - SCHED_OPT_CB */
> +	u32 ack_delay;		/* ACK_OPT_CB - SW_OPT_CB */
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +	__type(key, int);
> +	__type(value, struct sk_stg);
> +} sk_stg_map SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__type(key, struct sk_tskey);
> +	__type(value, struct delay_info);
> +	__uint(max_entries, 1024);
> +} time_map SEC(".maps");
> +
> +static u64 delay_tolerance_nsec = 10000000000; /* 10 second as an example */
> +
> +extern int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops) __ksym;
> +
> +static int bpf_test_sockopt_int(void *ctx, const struct sock *sk,
> +				const struct sockopt_test *t,
> +				int level)

This should be the only one that is needed even when supporting the future RX 
timestamping.

TX and RX timestamping need to be tested independently. Looping it will either 
enabling them together or disabling them together. It cannot test whether RX 
will work by itself.

Thus, the bpf_loop won't help. Lets remove it to simplify the test.

> +{
> +	int new, opt, tmp;
> +
> +	opt = t->opt;
> +	new = t->new;
> +
> +	if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
> +		return 1;
> +
> +	if (bpf_getsockopt(ctx, level, opt, &tmp, sizeof(tmp)) ||
> +	    tmp != new)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int bpf_test_socket_sockopt(__u32 i, struct loop_ctx *lc)
> +{
> +	const struct sockopt_test *t;
> +
> +	if (i >= ARRAY_SIZE(sol_socket_tests))
> +		return 1;
> +
> +	t = &sol_socket_tests[i];
> +	if (!t->opt)
> +		return 1;
> +
> +	return bpf_test_sockopt_int(lc->ctx, lc->sk, t, SOL_SOCKET);
> +}
> +
> +static int bpf_test_sockopt(void *ctx, const struct sock *sk)
> +{
> +	struct loop_ctx lc = { .ctx = ctx, .sk = sk, };
> +	int n;
> +
> +	n = bpf_loop(ARRAY_SIZE(sol_socket_tests), bpf_test_socket_sockopt, &lc, 0);
> +	if (n != ARRAY_SIZE(sol_socket_tests))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static bool bpf_test_access_sockopt(void *ctx)
> +{
> +	const struct sockopt_test *t;
> +	int tmp, ret, i = 0;
> +	int level = SOL_SOCKET;
> +
> +	t = &sol_socket_tests[i];
> +
> +	for (; t->opt;) {

It really does not need a loop here. It only needs to test "one" optname to 
ensure it is -EOPNOTSUPP.

> +		ret = bpf_setsockopt(ctx, level, t->opt, (void *)&t->new, sizeof(t->new));
> +		if (ret != -EOPNOTSUPP)
> +			return true;
> +
> +		ret = bpf_getsockopt(ctx, level, t->opt, &tmp, sizeof(tmp));
> +		if (ret != -EOPNOTSUPP)
> +			return true;
> +
> +		if (++i >= ARRAY_SIZE(sol_socket_tests))
> +			break;
> +	}
> +
> +	return false;
> +}
> +
> +/* Adding a simple test to see if we can get an expected value */
> +static bool bpf_test_access_load_hdr_opt(struct bpf_sock_ops *skops)
> +{
> +	struct tcp_opt reg_opt;

Just noticed this one. Use a plain u8 array. Then no need to include the 
"test_tcp_hdr_options.h" from an unrelated test.

> +	int load_flags = 0;
> +	int ret;
> +
> +	reg_opt.kind = TCPOPT_EXP;

The kind could be any integer, e.g. 2.

> +	reg_opt.len = 0;
> +	reg_opt.data32 = 0;
> +	ret = bpf_load_hdr_opt(skops, &reg_opt, sizeof(reg_opt), load_flags);
> +	if (ret != -EOPNOTSUPP)
> +		return true;
> +
> +	return false;
> +}

