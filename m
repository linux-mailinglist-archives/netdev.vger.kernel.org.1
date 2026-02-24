Return-Path: <netdev+bounces-260586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kA/6M0fQnWn4SAQAu9opvQ
	(envelope-from <netdev+bounces-260586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:22:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD9A189BE3
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80DC0304E7E6
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28183A4F56;
	Tue, 24 Feb 2026 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICp0Ma/m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9061F1304;
	Tue, 24 Feb 2026 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950144; cv=none; b=WOiXff2SL5TWa2imWeWiBqrnZ0XxqptizKoySXA5mukvSzobEk8gWvohnkJIn0zN//B2bUmeK+nH38HCipEbg+tmI+zFjiuIpQxAdfu+E/ZmljrJZp5X8JmjLK554ETt+QUv+glF4GiDBx39DkJrAAHXMuluyRoRK4N7G0E5wkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950144; c=relaxed/simple;
	bh=i0yBSYNQVXqQLHf+QKtAovioFrDUL3+0JKsF71qQBPU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JyjDDQcvonysQ+f2osfeY0QyrmCBERAm+s1SdAoDsuMiotlw6JX1zUzlHqWNClTSeDSvgrT4eKWJh19B6wd2sZVVHCb+/W/3C+lggbUHG66Q8dq1FDR4PDg6N42Fuch42+vgZGYSqqQUj8+YPDqu9p2wVrcJx+lYv/12WM5Lv6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICp0Ma/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC42AC116D0;
	Tue, 24 Feb 2026 16:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771950144;
	bh=i0yBSYNQVXqQLHf+QKtAovioFrDUL3+0JKsF71qQBPU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ICp0Ma/mN0PtXb/NGRS/I16spVEa4xQ083N9N/N77en1BRpheeTPzEit+UqYvq5Gs
	 D3Jlbu9f4qqP2QM4BM+OQRXoFc2gkGF28OP8bbWdTDHFOIi4EaplvLHACL/a1YunLN
	 qsF7GAXofXdy/49g/ETIDiu9sPAPCM4bPVDxlFB47jXQT+rV15GdDCF+6H5MRSSXyi
	 NclIsvkF9Isee8COIzRKCpDay/bNBx8x9oxRs53W8PV2k74a21mz6er/kD2/SpArh+
	 0b3XbpS1RKk5XbmKbh5OoDFQAoT9XPn+ssr33xsbX4MBQDutEzOthQxotsP+dbE46p
	 MGxau+VlJrL7A==
Content-Type: multipart/mixed; boundary="===============1426995775684406543=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <71126da53c4e4779c8509e8c5da0873f2e1c51528f8c49dde82336201703c69f@mail.kernel.org>
In-Reply-To: <20260224154024.12504-3-leon.hwang@linux.dev>
References: <20260224154024.12504-3-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 2/8] bpf: Disallow !kprobe_write_ctx progs tail-calling kprobe_write_ctx progs
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,yangfeng@kylinos.cn,leon.hwang@linux.dev,menglong8.dong@gmail.com,puranjay@kernel.org,bjorn@kernel.org,pulehui@huawei.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,netdev@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 24 Feb 2026 16:22:21 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260586-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,kylinos.cn,huawei.com,vger.kernel.org,fb.com,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 4BD9A189BE3
X-Rspamd-Action: no action

--===============1426995775684406543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -2415,6 +2416,8 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
>  		      map->owner->jited == fp->jited &&
>  		      map->owner->xdp_has_frags == aux->xdp_has_frags &&
>  		      map->owner->sleepable == fp->sleepable;
> +		if (ret && (!map->owner->kprobe_write_ctx && aux->kprobe_write_ctx))
> +			ret = false;

Is this check one-directional on purpose? It rejects the case
where the map owner is !kprobe_write_ctx and the incoming program
has kprobe_write_ctx, but it allows the reverse: a !kprobe_write_ctx
program passing the compatibility check against a kprobe_write_ctx-
owning map.

This means the following sequence is possible:

  1. Program A (kprobe_write_ctx=true) is stored first in a
     prog_array, becoming the map owner.

  2. Program B (kprobe_write_ctx=false) passes the compatibility
     check because (!true && false) evaluates to false, so ret
     stays true.

  3. Program B is attached to a kprobe via __perf_event_set_bpf_prog(),
     which only rejects (kprobe_write_ctx && !is_uprobe) -- B passes
     because its kprobe_write_ctx is false.

  4. At runtime B tail-calls into A. Program A's instructions now
     execute in kprobe context and write to kernel pt_regs.

The same path applies when B merely uses the map for bpf_tail_call()
without being stored -- bpf_check_tail_call() runs the same
__bpf_prog_map_compatible() check and allows B through.

The commit message says "Reject the combination of !kprobe_write_ctx
progs with kprobe_write_ctx progs" which suggests both directions
should be blocked. Would a symmetric check be more appropriate here?

>  		if (ret &&
>  		    map->map_type == BPF_MAP_TYPE_PROG_ARRAY &&
>  		    map->owner->expected_attach_type != fp->expected_attach_type)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22358832658

AI-authorship-score: low
AI-authorship-explanation: The commit message is concise and uses standard kernel terminology; the code changes follow established BPF patterns with no signs of AI-generated phrasing or structure.
issues-found: 1
issue-severity-score: high
issue-severity-explanation: The asymmetric compatibility check allows a !kprobe_write_ctx program attached to a kprobe to tail-call a kprobe_write_ctx program, enabling writes to kernel pt_regs in kprobe context and defeating the security enforcement the patch is meant to provide.

--===============1426995775684406543==--

