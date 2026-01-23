Return-Path: <netdev+bounces-252680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCa6LM4sc2mTswAAu9opvQ
	(envelope-from <netdev+bounces-252680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:09:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAA3723CE
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 613AA304AAD3
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CF333F8B3;
	Fri, 23 Jan 2026 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jXcqbV9i"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D508F33EB09
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155573; cv=none; b=ErJnu12ed9mzWRMQSSRgtlNspRRKflalm+0jJC1cEXTVoqBuSyzZQSpq8H325JlrzmQM+F2q5XwVLfzIjw3AmvkwTssLZgJnBVaMgPJ8dZiAjnbiuTY8QDrm0Z5Me379aaNrZYe4eX8dtoNSafc34CaVpCQq3o1NxzkWZrxHtdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155573; c=relaxed/simple;
	bh=NoNHTmDRI4VDQCjM6SBpQBy5k+KRzJXkF8/1Rwg9VeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAMAjup8ugImlwWewRkrGR7k6jBNMeQLGn9rcbz9tjhWJmRNG2JVmZogQFKPi+W5pOwkDQiyvAKYaYbQUZmExrY+3M3oVtfkyhcX6+fgCDffUfg9YSWPLKdhaAp3qp802yE/dmYt8kAjrJO3oCMiXdyItloxQ4mX2ibj/1ugR5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jXcqbV9i; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769155559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpLS1xvNWvaqlDj8byf7/WXIXjI0jG8CHvPr3U0nJuQ=;
	b=jXcqbV9i4Yacw4nRzEs5u9F48ku5UcoUdZg+ffNtjbPmh7xReTG9ZMDRMWxfquG1fGDSR2
	C7jzPYzYxOaw3YHVvJKEYzIo5fYXB5uGEYxLZ1iT7ihDFF7Xh6i/0oWcfAnkvmNi8xBDgf
	044joIq2RqsaGuGc44FjeT0S7JzNM+E=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, andrii@kernel.org, bot+bpf-ci@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
Subject:
 Re: [PATCH bpf-next v11 10/12] selftests/bpf: add testcases for fsession
Date: Fri, 23 Jan 2026 16:05:43 +0800
Message-ID: <12822324.O9o76ZdvQC@7940hx>
In-Reply-To:
 <28d092553ad40300324a21ccbc1dfd89f06283ca4801a5196e993f11e1522e71@mail.kernel.org>
References:
 <20260123073532.238985-11-dongml2@chinatelecom.cn>
 <28d092553ad40300324a21ccbc1dfd89f06283ca4801a5196e993f11e1522e71@mail.kernel.org>
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
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252680-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[iogearbox.net,linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim]
X-Rspamd-Queue-Id: 5CAA3723CE
X-Rspamd-Action: no action

On 2026/1/23 15:57 bot+bpf-ci@kernel.org write:
> > diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
> > new file mode 100644
> > index 000000000000..f504984d42f2
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/fsession_test.c
> > @@ -0,0 +1,110 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2025 ChinaTelecom */
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +char _license[] SEC("license") = "GPL";
> 
> [ ... ]
> 
> > +__u64 test6_entry_result = 0;
> > +__u64 test6_exit_result = 0;
> > +SEC("fsession/bpf_fentry_test1")
> > +int BPF_PROG(test6, int a)
> > +{
> > +	__u64 addr = bpf_get_func_ip(ctx);
> > +
> > +	if (bpf_session_is_return(ctx))
> > +		test6_exit_result = (const void *) addr == &bpf_fentry_test1;
> > +	else
> > +		test6_entry_result = (const void *) addr == &bpf_fentry_test1;
>                                                           ^^^^^^^^^^^^^^^^^^
> 
> Is the bpf_fentry_test1 symbol declared somewhere? The code references
> &bpf_fentry_test1 but there is no extern declaration with __ksym in this
> file.

The symbol "bpf_fentry_test1" will be declared in vmlinux.h, which is
generated automatically.

> 
> Other BPF selftests that take addresses of kernel symbols declare them
> explicitly, for example get_func_ip_test.c has:
> 
>     extern int bpf_fentry_test1(int a) __ksym;
> 
> And kprobe_multi_session.c has:
> 
>     extern const void bpf_fentry_test1 __ksym;
> 
> Without a similar declaration, will this BPF program compile and load
> correctly?

As I said above, it won't cause compile problem.

Thanks!
Menglong Dong

> 
> > +	return 0;
> > +}
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21278745581
> 





