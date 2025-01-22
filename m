Return-Path: <netdev+bounces-160406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66217A198EB
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 20:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B388316C6D5
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 19:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFFD21577C;
	Wed, 22 Jan 2025 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dSTu3bEM"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9551E214A9B
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737572550; cv=none; b=Iz2YDhl57ub6QSQtRBwwtkUwgrYkksl+Odjvv4VZEmdvQlxtZyMm8mULDu+kARN7jVvBNMTLCF2cJj+Stmw/8FV7B0L1dbgvG2YozU9ZBw85prGRJi4TXG95sol/201y2zHdahBKNiWKfEi6HuR0F064P2mL1CO25uMCwpvucVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737572550; c=relaxed/simple;
	bh=yVOl7uKZwAPzL3hOo1/yIB0AA01qrS2OlwWoDfRibec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZoQbFSBQNASyI5pEIA2/LYRlfkiIvbFGMmS09ddYv0/VzF/Judu73w51i+bfesgKgv4y1XZ5jXciTEH9WLdV3UAgFnBnXxtM+dzXW54jlOjOEIpsV1Dsw9XdzbYiIgSZjFcJRbRBmaer3qcZroKiOVZ0sCD2R6YZXKXXTen918o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dSTu3bEM; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <453fbdbc-1843-498b-9a1c-8c83e7e244ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737572536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8FKpvfe4T9AnrcyGP1Vg1JqYGIC8GWW31gvSYVAm1E=;
	b=dSTu3bEMKZOMYG8VODFIRLWE+0EC6zY7TARf8/Jb94x02xb52o1JTn8e/cptSgx1KqH0Ga
	IU/fRr9lryQk1ho9fZT7Wmrub7Ipu4/2LeE04UEAWKoScthZHY+vnijyrz0uJtEo45EzjQ
	kd/KLlSxQ92RxISwLyMTUwv8tVxKUr4=
Date: Wed, 22 Jan 2025 11:02:08 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC net-next] trace: tcp: Add tracepoint for
 tcp_cwnd_reduction()
Content-Language: en-GB
To: Steven Rostedt <rostedt@goodmis.org>, Breno Leitao <leitao@debian.org>
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
 <20250122095604.3c93bc93@gandalf.local.home>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250122095604.3c93bc93@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 1/22/25 6:56 AM, Steven Rostedt wrote:
> On Wed, 22 Jan 2025 01:39:42 -0800
> Breno Leitao <leitao@debian.org> wrote:
>
>> Right, DECLARE_TRACE would solve my current problem, but, a056a5bed7fa
>> ("sched/debug: Export the newly added tracepoints") says "BPF doesn't
>> have infrastructure to access these bare tracepoints either.".
>>
>> Does BPF know how to attach to this bare tracepointers now?
>>
>> On the other side, it seems real tracepoints is getting more pervasive?
>> So, this current approach might be OK also?
>>
>> 	https://lore.kernel.org/bpf/20250118033723.GV1977892@ZenIV/T/#m4c2fb2d904e839b34800daf8578dff0b9abd69a0
> Thanks for the pointer. I didn't know this discussion was going on. I just
> asked to attend if this gets accepted. I'm only a 6 hour drive from
> Montreal anyway.
>
>>> You can see its use in include/trace/events/sched.h
>> I suppose I need to export the tracepointer with
>> EXPORT_TRACEPOINT_SYMBOL_GPL(), right?
> For modules to use them directly, yes. But there's other ways too.
>
>> I am trying to hack something as the following, but, I struggled to hook
>> BPF into it.
> Maybe you can use the iterator to search for the tracepoint.
>
> #include <linux/tracepoint.h>
>
> static void fct(struct tracepoint *tp, void *priv)
> {
> 	if (!tp->name || strcmp(tp->name, "<tracepoint_name>") != 0)
> 		return 0;
>
> 	// attach to tracepoint tp
> }
>
> [..]
> 	for_each_kernel_tracepoint(fct, NULL);
>
> This is how LTTng hooks to tracepoints.

The LTTng approach in the above needs a kernel module to enable and disable
the tracepoint and this is not a bpf-way to handle tracepoints.

So for bpf, we need a new UAPI to pass <tracepoint_name> from user
space to the kernel to attach to tracepoint tp since <tracepont_name> is not
available in trace_fs.

What is the criteria for a tracepoint to be a normal tp or a bare tp?


>
> -- Steve
>


