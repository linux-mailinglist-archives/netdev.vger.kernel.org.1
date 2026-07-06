Return-Path: <netdev+bounces-305195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HxUxGUMHTGodfAEAu9opvQ
	(envelope-from <netdev+bounces-305195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:51:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FF6715273
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:51:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fduKAlBq;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305195-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305195-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F3873453510
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 18:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F7643784C;
	Mon,  6 Jul 2026 18:28:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94656433BAE;
	Mon,  6 Jul 2026 18:28:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362522; cv=none; b=R+ZBmEMKygtpFAlOEDI9m5E0TB9G4z309HruSDaTp6nGGixwfqbkLj+R9dXQBf5hvcKMnV7+JniNnYzCc/GhgWxDpHJv9gYOWVSTHfG04o+8RYjAKOkK09n3hhHKjxOmcHxTbvb79CLSTOU79uTpQkSFtp+IF1RJCzPRSh1X9Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362522; c=relaxed/simple;
	bh=2GJVHk8J9oP4pqbk2rf4m610mitVjbW42vAzFhNMLlk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Lj1fFQHuPkIcpuaXyAlVsFrofHVxD2XIt8FWWjy6TV8uIkSBbFb4+OllixY+0+QKQAUSBRB8SS3n0d8HzLqSwZPPSA1VW1phnkA2LxRAifhzb5bsPAdk3IYtyGhk91UbONuZJpd3Rffcu1vHIUVcGeF8FNdSfDHBWdCvwRtCsOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fduKAlBq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AD61F000E9;
	Mon,  6 Jul 2026 18:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783362521;
	bh=bzTB0Uolf5gJZKoynBYTKORKIX0O4dCjDmQcxbolsSA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fduKAlBqxaeUAXgWJmIWmMUdEf7lR5xN4hfLqQFjDn7s+FFo70qeYmHHI1NL5shMZ
	 SjeqZOnGi10rNZ5nS6oDjMzDTDkheAc2wBbodsvLvukTb9z83gAIj+O4DAJxVpp54/
	 zC2rcwZjxcaT3zw+aoaknplj9cN/8aD3uMXxkYiUVwjCD6w2J1yK6jh6Apt6M/0gk8
	 m5+ed9ZUFfeTWxwLzNgqKx9YUeLyYx6plNhLaTk2Jke1fuopiglZIjYxkal21fuUfB
	 6OrtziqQESFy8pWqZFGXoIk2Ep6bv58tv24rfbfFlxIpo/fuusRAeEt6W3bFFnh0kC
	 kpgwngbFIlfxA==
Content-Type: multipart/mixed; boundary="===============2782450239906331367=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <53de193473737a3692df075a179e186e996dc26a592b697f2f335d9d4039c943@mail.kernel.org>
In-Reply-To: <20260706171918.317102-12-ameryhung@gmail.com>
References: <20260706171918.317102-12-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v3 11/15] bpf: tcp: Support selected sock_ops callbacks as struct_ops
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,shakeel.butt@linux.dev,roman.gushchin@linux.dev,kuniyu@google.com,kerneljasonxing@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  6 Jul 2026 18:28:41 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	TAGGED_FROM(0.00)[bounces-305195-lists,netdev=lfdr.de,bpf-ci];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_RECIPIENTS(0.00)[m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:kernel-team@meta.com,m:ast@kernel.org,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05FF6715273

--===============2782450239906331367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> new file mode 100644
> index 000000000000..3febbc8dd1a0
> --- /dev/null
> +++ b/net/ipv4/bpf_tcp_ops.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/bpf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/bpf_verifier.h>
> +#include <net/bpf_sk_storage.h>
> +#include <net/tcp.h>
> +
> +static int timeout_init_stub(struct sock *sk, struct request_sock *req__nullable)
> +{
> +	struct bpf_tramp_run_ctx *ctx =
> +		container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, run_ctx);
> +
> +	return ctx->retval;
> +}
> +
> +static int rwnd_init_stub(struct sock *sk, struct request_sock *req__nullable)
> +{
> +	struct bpf_tramp_run_ctx *ctx =
> +		container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, run_ctx);
> +
> +	return ctx->retval;
> +}

This isn't a bug, but could timeout_init_stub() and rwnd_init_stub()
simply return 0 like the analogous int-returning stubs in
net/ipv4/bpf_tcp_ca.c?

These stubs are only used for CFI/trampoline generation and never
executed. The sibling file's int stubs (bpf_tcp_ca_undo_cwnd,
bpf_tcp_ca_sndbuf_expand, bpf_tcp_ca_ssthresh) all return 0. The
container_of() plus ctx->retval logic here duplicates the actual
bpf_tcp_ops_get_retval() helper below.

> +static void active_established_stub(struct sock *sk, struct sk_buff *skb__nullable)
> +{
> +}

[ ... ]

> +BPF_CALL_0(bpf_tcp_ops_get_retval)
> +{
> +	struct bpf_tramp_run_ctx *ctx =
> +		container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, run_ctx);
> +
> +	/* bpf_get_retval() is only exposed to timeout_init/rwnd_init, which
> +	 * always run via bpf_tcp_ops_call_int(). Its run_ctx carries the int
> +	 * return value chained across the bpf_tcp_ops attached to the cgroup
> +	 * and is this program's saved_run_ctx.
> +	 */
> +	if (WARN_ON_ONCE(!ctx->saved_run_ctx))
> +		return 0;
> +
> +	return container_of(ctx->saved_run_ctx, struct bpf_tramp_run_ctx,
> +			    run_ctx)->retval;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28810680939
--===============2782450239906331367==--

