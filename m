Return-Path: <netdev+bounces-295471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1LEDH2gDImpQRgEAu9opvQ
	(envelope-from <netdev+bounces-295471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:59:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C116B643E1B
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:59:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nILAVJ5v;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295471-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295471-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1817E30037C0
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EEF30D3EA;
	Thu,  4 Jun 2026 22:59:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44B12F7F00;
	Thu,  4 Jun 2026 22:59:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613959; cv=none; b=Hdkl7PPJu/iJGCuRoytNGWD7eCCidMnJN3Dbe7ioP7AjNXsqVUfnZ69aGcQBOaMfXRQy3BCoFZKLyGxWA23QW++0n9+zIAu04ztlyf9uA5/Bi/pLrDDlmaOzS8hn42ZBe55WfnLgTt3D7kFvnxMsQesbKq+R3KG0aG9saDWtxQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613959; c=relaxed/simple;
	bh=jBGDOCmpTHD+9TVIhyMuXjecGM81uJ2glpxcyVZfL2E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nWYLB4M2eWZMXsqBXCGrjCana+7T2hsOrk8u1q0KA35RwsezmHFKsrhpA8JnpUNHRr19tbEKSWr219Ng0ODy6fICzbk03UUeZkNzZA+qyVvCOPboQvwZk1TKM4Pm0Vp07MuBULaCDIX121WvGlJ0Sf6qVlWhYwGXl+8EXCQSGk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nILAVJ5v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235AF1F00893;
	Thu,  4 Jun 2026 22:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780613958;
	bh=2VhV2FATKxM7MoCvKViCJtX17rRVhZ2gyTgGOU2AlwU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nILAVJ5vLIJQg0mHYtFxblm+7PGoHkAUQ7S32AJvbNy3MjjtQ8ZRakDj4qmua/M+u
	 9uO0YgDMWV/8AocGiFOXuEdg3+o3Izd9/jzQRKaUSuWXe5sOKSk5offrQePUqrZHOo
	 kSE/1UbuNaHSxtUCxJ5V3xo1cOkg7qvh6AkbTgMexEC6B15bnN4xR5uI60PN8MwZIE
	 ivBV+ryS6Sgpy2cEptn12nW6e7f6XagUWN34RkuQtL9a6euS9hYvMadPpzjvxCMMfQ
	 n+2U2WUvhlAeYXVEoGjG+RfuJH1JuWozIDr1peldPGf6R5GrFCDE8Nfw/BHcLszEz2
	 ClhpLcG2FcTow==
Content-Type: multipart/mixed; boundary="===============5991609851191417382=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a5988106169c7350f39a4d07b36b679a5fb39cda49ca371cb79c23da7b63971d@mail.kernel.org>
In-Reply-To: <20260604220904.1032145-3-ameryhung@gmail.com>
References: <20260604220904.1032145-3-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,mykyta.yatsenko5@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  4 Jun 2026 22:59:18 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295471-lists,netdev=lfdr.de,bpf-ci];
	FORGED_RECIPIENTS(0.00)[m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:kernel-team@meta.com,m:ast@kernel.org,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C116B643E1B

--===============5991609851191417382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 89f2be9817e074d02702d22068104fb9fd9aa103
> Author: Amery Hung <ameryhung@gmail.com>
> Date:   Thu Jun 4 15:09:03 2026 -0700
>
>     bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
>
>     refsafe() compared each reference's id and type but not its parent_id,
>     so two states whose PTR references differ only in the parent object they
>     were derived from could be wrongly treated as equivalent and pruned. Fix
>     it by checking parent_id too.
>
>     Signed-off-by: Amery Hung <ameryhung@gmail.com>

This looks like a bug fix for parent_id tracking support. Should this
include:

  Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")

When commit 308c7a0ae885 added parent_id tracking, it updated several
safety-checking functions to compare parent_id but missed adding the
parent_id check in refsafe() for the REF_TYPE_PTR case. This caused states
with different parent objects to be incorrectly treated as equivalent
during state pruning.

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 5945956a7573..06d9ae24f006 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -890,6 +890,9 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
>  			return false;
>  		switch (old->refs[i].type) {
>  		case REF_TYPE_PTR:
> +			if (!check_ids(old->refs[i].parent_id, cur->refs[i].parent_id, idmap))
> +				return false;
> +			break;
>  		case REF_TYPE_IRQ:
>  			break;
>  		case REF_TYPE_LOCK:

This adds an extra check_ids() call for parent_id. Could this make it
easier to trigger the WARN_ON_ONCE() in check_ids() via BPF_ID_MAP_SIZE
exhaustion?

Since acquired_refs has no explicit limit, a BPF program could acquire and
leak many references (e.g., via bpf_sk_lookup_tcp) before a branch merge
point. When states_equal() invokes refsafe(), it calls check_ids() for
each acquired reference.

The idmap has a fixed size based only on registers and stack slots:

include/linux/bpf_verifier.h:
#define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE + \
			  MAX_STACK_ARG_SLOTS) * MAX_CALL_FRAMES)

If a program accumulates enough leaked references, checking them all will
run out of idmap slots and trigger the warning:

kernel/bpf/states.c:check_ids() {
	...
	/* Reached the end of known mappings; haven't seen this id before */
	if (idmap->cnt < BPF_ID_MAP_SIZE) {
		...
		return true;
	}

	/* We ran out of idmap slots, which should be impossible */
	WARN_ON_ONCE(1);
	return false;
}

With this patch now checking both reference id and parent_id for
REF_TYPE_PTR (doubling the idmap slot usage per reference), does this
allow exhausting BPF_ID_MAP_SIZE much faster?

Could a user intentionally leak enough references to trigger this warning
and potentially panic the kernel if panic_on_warn is set?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26983135146
--===============5991609851191417382==--

