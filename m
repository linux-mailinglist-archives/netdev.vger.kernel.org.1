Return-Path: <netdev+bounces-303244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bl0gKUTXQ2rTjwoAu9opvQ
	(envelope-from <netdev+bounces-303244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:48:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D7B6E58FB
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:48:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="LSsPTQJ/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303244-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303244-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E10833057890
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F77943637C;
	Tue, 30 Jun 2026 14:46:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617A8368D46;
	Tue, 30 Jun 2026 14:46:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830777; cv=none; b=TOTH6cg9mo7u3RUvIKMj1uyzNPaZWT6HqrzSSQz9sn9Wv6bD7rKAjNjgclw9jVIOP+KqchLLaDE2PmqF1NIxhLrS4yKu72NcCVgEbHwDIWA6EEqSoQaXEawhAgeTVIAgvciz1vLTRmz6t2KiPHyUfa8Waf5qkbc8z+Hi4y1vGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830777; c=relaxed/simple;
	bh=et6WWXnaS2+pKmOqfW2RoPxasq8OHuop6VwHgCWWPSU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WB5C+SOmZwWut1JD0TKchAV+jPMoltAoYeqD13ZLG9yahOLl0QOIjiwGtFo38sAJH8Bl4Sr7G/QAwe08qBF7Uq6uBDIgpfY0mR8mMdXcdOkbzFKXpvQcpN0Q7D19kZVggQVJ9EuPblttRdXR/GmOSQih9Kh6IgWovRMTcsHgmSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSsPTQJ/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9051F000E9;
	Tue, 30 Jun 2026 14:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782830776;
	bh=tUR1TZqZgIjf7g/qHfTnghrYzXKLgJDw1xWeRAXLWJo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LSsPTQJ/A+v2jDQU690DW1fqHe/pLTvNXjuDFl1rNxlNreEw651MXk4g2iYcEkoLB
	 KROa+IraIHhnWx/b6ykEYVlhLxSwURZ9K26rgS/qXttBW2D93uWcRAWbN5dIAwlbi8
	 X02xOAeT7hZ0ojScXO8wXPseolmhnMbMlwzYfR7RhiuZ1xZfY05wJ87frNwYoh+nrQ
	 RO4Ul8we42r3+7z/nlPPDsK5oKwF/PsNJqIJsydcQPhx+LzlUVH7yErgroIo+P11v9
	 LP8cPpZBrN1+fcphatL2PpF7s8pSsl8PMQveBJqOfHIP7AJJaiXkR04oMK6v1IZemB
	 Fla9dRfgznWKw==
Content-Type: multipart/mixed; boundary="===============4372272007352423530=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <da582eb50a1b974b40f4f4c22b0ff138e490d84e0c3ff06a6f13428f62608ded@mail.kernel.org>
In-Reply-To: <tencent_5E4F8F8DADA5DE0DAD924ADD835DD7991707@qq.com>
References: <tencent_5E4F8F8DADA5DE0DAD924ADD835DD7991707@qq.com>
Subject: Re: [PATCH v4] bpf: Fix smp_processor_id() call trace for preemptible kernels
From: bot+bpf-ci@kernel.org
To: eadavis@qq.com,sashiko-bot@kernel.org
Cc: eadavis@qq.com,jiayuan.chen@linux.dev,sashiko-reviews@lists.linux.dev,andrii@kernel.org,ast@kernel.org,bpf@vger.kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,jolsa@kernel.org,linux-kernel@vger.kernel.org,martin.lau@linux.dev,memxor@gmail.com,netdev@vger.kernel.org,song@kernel.org,syzkaller-bugs@googlegroups.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 30 Jun 2026 14:46:15 +0000 (UTC)
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
	TAGGED_FROM(0.00)[bounces-303244-lists,netdev=lfdr.de,bpf-ci];
	FORGED_RECIPIENTS(0.00)[m:eadavis@qq.com,m:sashiko-bot@kernel.org,m:jiayuan.chen@linux.dev,m:sashiko-reviews@lists.linux.dev,m:andrii@kernel.org,m:ast@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:emil@etsalapatis.com,m:jolsa@kernel.org,m:linux-kernel@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:netdev@vger.kernel.org,m:song@kernel.org,m:syzkaller-bugs@googlegroups.com,m:yonghong.song@linux.dev,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[qq.com,linux.dev,lists.linux.dev,kernel.org,vger.kernel.org,iogearbox.net,gmail.com,etsalapatis.com,googlegroups.com,meta.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com,kernel.org];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.kernel.org:mid,appspotmail.com:email,qq.com:email,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1D7B6E58FB

--===============4372272007352423530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Fix smp_processor_id() call trace for preemptible kernels
>
> bpf_mem_cache_free_rcu() maybe called in preemptible context, this
> will trigger the below warning message:
>
> BUG: using smp_processor_id() in preemptible [00000000] code: syz.0.17/5820
> caller is bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
> Call Trace:
>  check_preemption_disabled+0xd3/0xe0 lib/smp_processor_id.c:47
>  bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
>  rhtab_delete_elem+0x185a/0x1b30 kernel/bpf/hashtab.c:2969
>  __rhtab_map_lookup_and_delete_batch+0x935/0xcb0 kernel/bpf/hashtab.c:3349
>  bpf_map_do_batch+0x445/0x630 kernel/bpf/syscall.c:-1
>  __sys_bpf+0x906/0xd90 kernel/bpf/syscall.c:-1
>
> this_cpu_ptr() access needs to be guarded against migration.

The commit message says "guarded against migration" but the fix actually
disables preemption using get_cpu()/put_cpu(). Is this description accurate?

get_cpu() does preempt_disable() + __smp_processor_id(), not just
migrate_disable(). The later sentence "disabling preemption rather than
prohibiting migration" correctly describes the fix, but this earlier line
understates the requirement.

> Wrapping this batch operation in bpf_disable_instrumentation() risk
> blinding BPF tracing globally on the CPU if preemption occurs.
>
> bpf_disable_instrumentation() increments the per-CPU bpf_prog_active counter.
> Because migrate_disable() and rcu_read_lock() do not disable preemption under
> CONFIG_PREEMPT_RCU, the task can be preempted during this potentially long
> loop.
>
> If preempted, bpf_prog_active would remain elevated on that CPU, which could
> cause subsequent tasks scheduled on the same CPU to silently drop BPF tracing
> events (kprobes, tracepoints, perf).

The reasoning about bpf_disable_instrumentation() is sound, but could the
commit message clarify that rhtab_delete_elem() already calls
bpf_disable_instrumentation() internally?

Looking at rhtab_delete_elem():

kernel/bpf/hashtab.c:rhtab_delete_elem() {
    ...
    bpf_disable_instrumentation();
    ret = rhashtable_remove_fast(&rhtab->table, &elem->htab_node,
                                  rhtab->rhtable_params);
    bpf_enable_instrumentation();
    ...
}

This means the same "blinding BPF tracing" window already exists in the
per-element path. The argument is against a longer-held instrumentation
disable across the entire loop, not a categorical concern.

> Therefore, we fix this by disabling preemption rather than prohibiting
> migration.
>
> Fixes: 5af6807bdb10 ("bpf: Introduce bpf_mem_free_rcu() similar to kfree_rcu().")

Should the Fixes tag point to a different commit? The bug occurs when
__rhtab_map_lookup_and_delete_batch() calls rhtab_delete_elem() which calls
bpf_mem_cache_free_rcu() in preemptible context.

Commit 5af6807bdb10 introduced bpf_mem_free_rcu() in 2023 but did not modify
kernel/bpf/hashtab.c or introduce the rhtab code. The call chain was
introduced by:

  Fixes: 6905f8601298 ("bpf: Allow special fields in resizable hashtab")

which added the rhtab implementation including __rhtab_map_lookup_and_delete_batch()
and the call to bpf_mem_cache_free_rcu() in rhtab_delete_elem().

> Reported-by: syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fd7e415d891073b83e1f
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

[ ... ]

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -3345,8 +3345,10 @@
>  	}
>
>  	if (do_delete) {
> +		get_cpu();
>  		for (i = 0; i < total; i++)
>  			rhtab_delete_elem(rhtab, del_elems[i], NULL, 0);
> +		put_cpu();
>  	}
>
>  	rcu_read_unlock();

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28451219226
--===============4372272007352423530==--

