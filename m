Return-Path: <netdev+bounces-160403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F74A198A5
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 19:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195FE3AA9EF
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 18:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B1821578B;
	Wed, 22 Jan 2025 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m4kqJKTe"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7BB2153FF
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737571246; cv=none; b=GsLjWPWBGgFyqZNSu7fKhqjKWRrWpeAFHb5zE6NU2ElpdsSK0ik3fARE+X9D1n/pKtdPEFXngP8B9Yh1M3Ly7CrNMZnlZGaq7uEQgC1ExER6b/7NuE4uVktUAeRiEPrjOCqPPPEgdIekbKmIzWoaxOcwTNmbER0m1AZL76C9N2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737571246; c=relaxed/simple;
	bh=HDCBG2UbLWzEb2RfJZlDbYKBn92wCjQsU2Mm62T+IxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCOnZZDQNGrQF0yS8yX6b6YJ5DGZA2+5fkfAs1+S7wG46VtPyHKnwZ4vVsGEJlo/BYJqknEa3CBySa7OaRcewPcwHxBfEt0KfjyW6hOAwU14ncEsOWQcKDPcgztaG7ds5Hx+X0GMEjbHCuMAttgsqRH6adq1crxDq/1dvz21dQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m4kqJKTe; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <be0f5d0d-479e-46a3-9e9c-ebcd0b1987e9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737571227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+FoNUkA/X+kqdOijwIbqf3VGc3uuyPYzgArpkviCYQ0=;
	b=m4kqJKTeW1SWh+W6n2bc+YQ4rGmDWkibLF5MUZpcYSLAHHUBEWCL9ZZ/N0DuClOtMYYQnU
	d50W4XqChhFh9N+CcVP9rlleu4fyfPVERVRVNhm7tppyltO+8my4hz9MMuuPxRyvVo8Thf
	ckv4mtEo3rgIPOdUNAwsczZF3T5GETY=
Date: Wed, 22 Jan 2025 10:40:20 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC net-next] trace: tcp: Add tracepoint for
 tcp_cwnd_reduction()
Content-Language: en-GB
To: Breno Leitao <leitao@debian.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@meta.com, Song Liu <song@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20250120-cwnd_tracepoint-v1-1-36b0e0d643fa@debian.org>
 <CAL+tcoC+A94uzaSZ+SKhV04=iDWrvUGEfxYJKYCF0ovqvyhfOg@mail.gmail.com>
 <20250120-panda-of-impressive-aptitude-2b714e@leitao>
 <CAL+tcoCzStjkEMdNw5ORYbQy3VnVE9A6aj6HcmQvGj3VG1VypA@mail.gmail.com>
 <20250120-daring-outstanding-jaguarundi-c8aaed@leitao>
 <20250120100340.4129eff7@batman.local.home>
 <20250122-vengeful-myna-of-tranquility-f0f8cf@leitao>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250122-vengeful-myna-of-tranquility-f0f8cf@leitao>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 1/22/25 1:39 AM, Breno Leitao wrote:
> Hello Steven,
>
> On Mon, Jan 20, 2025 at 10:03:40AM -0500, Steven Rostedt wrote:
>> On Mon, 20 Jan 2025 05:20:05 -0800
>> Breno Leitao <leitao@debian.org> wrote:
>>
>>> This patch enhances the API's stability by introducing a guaranteed hook
>>> point, allowing the compiler to make changes without disrupting the
>>> BPF program's functionality.
>> Instead of using a TRACE_EVENT() macro, you can use DECLARE_TRACE()
>> which will create the tracepoint in the kernel, but will not create a
>> trace event that is exported to the tracefs file system. Then BPF could
>> hook to it and it will still not be exposed as an user space API.
> Right, DECLARE_TRACE would solve my current problem, but, a056a5bed7fa
> ("sched/debug: Export the newly added tracepoints") says "BPF doesn't
> have infrastructure to access these bare tracepoints either.".
>
> Does BPF know how to attach to this bare tracepointers now?
>
> On the other side, it seems real tracepoints is getting more pervasive?
> So, this current approach might be OK also?
>
> 	https://lore.kernel.org/bpf/20250118033723.GV1977892@ZenIV/T/#m4c2fb2d904e839b34800daf8578dff0b9abd69a0
>
>> You can see its use in include/trace/events/sched.h
> I suppose I need to export the tracepointer with
> EXPORT_TRACEPOINT_SYMBOL_GPL(), right?
>
> I am trying to hack something as the following, but, I struggled to hook
> BPF into it.
>
> Thank you!
> --breno
>
> Author: Breno Leitao <leitao@debian.org>
> Date:   Fri Jan 17 09:26:22 2025 -0800
>
>      trace: tcp: Add tracepoint for tcp_cwnd_reduction()
>      
>      Add a lightweight tracepoint to monitor TCP congestion window
>      adjustments via tcp_cwnd_reduction(). This tracepoint enables tracking
>      of:
>        - TCP window size fluctuations
>        - Active socket behavior
>        - Congestion window reduction events
>      
>      Meta has been using BPF programs to monitor this function for years.
>      Adding a proper tracepoint provides a stable API for all users who need
>      to monitor TCP congestion window behavior.
>      
>      Use DECLARE_TRACE instead of TRACE_EVENT to avoid creating trace event
>      infrastructure and exporting to tracefs, keeping the implementation
>      minimal. (Thanks Steven Rostedt)
>
>      Signed-off-by: Breno Leitao <leitao@debian.org>
>
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index a27c4b619dffd..07add3e20931a 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -259,6 +259,11 @@ TRACE_EVENT(tcp_retransmit_synack,
>   		  __entry->saddr_v6, __entry->daddr_v6)
>   );
>   
> +DECLARE_TRACE(tcp_cwnd_reduction_tp,
> +	TP_PROTO(const struct sock *sk, const int newly_acked_sacked,
> +		 const int newly_lost, const int flag),

I don't think we need 'const' for int types. For 'const strcut sock *',
it makes sense since we do not want sk-><fields> get changed.

> +	TP_ARGS(sk, newly_acked_sacked, newly_lost, flag));
> +
>   #include <trace/events/net_probe_common.h>
>   
>   TRACE_EVENT(tcp_probe,
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 4811727b8a022..74cf8dbbedaa0 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -2710,6 +2710,8 @@ void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked, int newly_lost,
>   	if (newly_acked_sacked <= 0 || WARN_ON_ONCE(!tp->prior_cwnd))
>   		return;
>   
> +	trace_tcp_cwnd_reduction_tp(sk, newly_acked_sacked, newly_lost, flag);
> +
>   	tp->prr_delivered += newly_acked_sacked;
>   	if (delta < 0) {
>   		u64 dividend = (u64)tp->snd_ssthresh * tp->prr_delivered +
> @@ -2726,6 +2728,7 @@ void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked, int newly_lost,
>   	sndcnt = max(sndcnt, (tp->prr_out ? 0 : 1));
>   	tcp_snd_cwnd_set(tp, tcp_packets_in_flight(tp) + sndcnt);
>   }
> +EXPORT_TRACEPOINT_SYMBOL_GPL(tcp_cwnd_reduction_tp);
>   
>   static inline void tcp_end_cwnd_reduction(struct sock *sk)
>   {


