Return-Path: <netdev+bounces-262719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDkeK4qzpWlaEgAAu9opvQ
	(envelope-from <netdev+bounces-262719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 16:58:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 100BD1DC42F
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 16:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B54F630899AD
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 15:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5568241C31D;
	Mon,  2 Mar 2026 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfSgNZ2c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC543ED101;
	Mon,  2 Mar 2026 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466791; cv=none; b=opZk/p73izoTUK6KMFNo+XsJxfvZNagYYsPpPMPU5RmDrK5N520zY7nlczIUEl0SLRGZIP4T4Xz7d+50vI9fNYtIpDIzZy7P4M20wpAYb/AAKO6VEKl9ZV6NoeD1hWyBcg4L0ULV9Y2XmsATFoJoTv/0g1wll/3kd/f9RV2c8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466791; c=relaxed/simple;
	bh=akuNwk2L4Tn+oc6eO7tYHYsdIETv0qD02YiOi5S0QAk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=URksePQQ7O0zlOo32ZQDaEQfhfQ//BVU9VzFspa3cwUndMJ1VzstqVk1tcFdjDovhl0tPebwaSc53paXcvd+gOb9Hdhryf0nhYRzEeKnHzJSCOHYXTtJ+sG0p0+1RJmIoKj/sInfJt5blT4m0D8cd17B6Klit6VXnScHAAiBMYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfSgNZ2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1DAC2BC86;
	Mon,  2 Mar 2026 15:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772466791;
	bh=akuNwk2L4Tn+oc6eO7tYHYsdIETv0qD02YiOi5S0QAk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=kfSgNZ2cK9nDuVRxY8qczDvvWdZSz5onHG/DHIrmTfFCr/kbCdMxWECoyxrrjBagB
	 ggdqD3nfCnQJbMktiLY1u53Bd8eC+EH8mPPdDWpTpPDaNRqqSWvwsQ7P6mvizX2lrr
	 8ziO42b+hTazkWfzY7Ur4zERoEo2rHaHLhzc5/BCGVMctDMwARBgwg+4XKPR+YpJEI
	 ULah02MSneAXpJUqtwGuqdp7bHHvm5F+3URLeK/OeiGH3aGX7IotuMnCalJQWg8iEC
	 nPmU16CahP3t/P6bDph90Cl9TXppO88/CJ3WHXVxWuOn6rQqZuo+YGnobxEPMBF7TM
	 KgVvIXCEyFOyA==
Content-Type: multipart/mixed; boundary="===============5904675307736768806=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <abc5556bf4da9afc2d8100cd8937c41e9718f1a14b343d8a398499546157126c@mail.kernel.org>
In-Reply-To: <20260302150342.55709-5-leon.hwang@linux.dev>
References: <20260302150342.55709-5-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v2 4/6] bpf: Disallow !call_get_func_ip progs tail-calling call_get_func_ip progs
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,yangfeng@kylinos.cn,leon.hwang@linux.dev,menglong8.dong@gmail.com,puranjay@kernel.org,bjorn@kernel.org,pulehui@huawei.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,netdev@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  2 Mar 2026 15:53:10 +0000 (UTC)
X-Rspamd-Queue-Id: 100BD1DC42F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262719-lists,netdev=lfdr.de,bpf-ci];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Action: no action

--===============5904675307736768806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -2422,11 +2423,17 @@ static bool bpf_map_owner_matches(const struct bpf_map *map, const struct bpf_prog *fp,
>  	case BPF_MAP_OWNER_MATCH_FOR_INIT:
>  		if (owner->kprobe_write_ctx != aux->kprobe_write_ctx)
>  			return false;
> +		if (owner->call_get_func_ip != fp->call_get_func_ip)
> +			return false;
>  		break;
>
>  	case BPF_MAP_OWNER_MATCH_FOR_UPDATE:
>  		if (!owner->kprobe_write_ctx && aux->kprobe_write_ctx)
>  			return false;
> +		if (bpf_prog_has_trampoline(fp)) {
> +			if (!owner->call_get_func_ip && fp->call_get_func_ip)
> +				return false;
> +		}
>  		break;

The FOR_UPDATE path correctly guards the call_get_func_ip check with
bpf_prog_has_trampoline(fp), since only trampoline-based programs
rely on the func IP stored on the trampoline stack. Kprobe programs
get func_ip from kprobe_running()->addr via bpf_get_func_ip_kprobe(),
which is independent of the trampoline.

Should the FOR_INIT path have the same bpf_prog_has_trampoline()
guard? Without it, two kprobe programs that share a prog_array will
be rejected if one calls bpf_get_func_ip() and the other does not,
even though mixing is safe for kprobes.

bpf_check_tail_call() calls this with BPF_MAP_OWNER_MATCH_FOR_INIT:

    kprobe prog_a (call_get_func_ip=1) loads, references jmp_table
      -> owner->call_get_func_ip = 1
    kprobe prog_b (call_get_func_ip=0) loads, references same jmp_table
      -> owner->call_get_func_ip != fp->call_get_func_ip
      -> returns false, prog_b fails to load

Something like this would match the FOR_UPDATE scoping:

    case BPF_MAP_OWNER_MATCH_FOR_INIT:
            if (owner->kprobe_write_ctx != aux->kprobe_write_ctx)
                    return false;
            if (bpf_prog_has_trampoline(fp)) {
                    if (owner->call_get_func_ip != fp->call_get_func_ip)
                            return false;
            }
            break;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22582690876

AI-authorship-score: medium
AI-authorship-explanation: The v1 selftests carried Assisted-by Codex tags, and the kernel code follows a mechanical copy-paste pattern across commits; the v2 selftests were rewritten but the overall series structure suggests AI-assisted development.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The FOR_INIT strict equality check on call_get_func_ip is missing a bpf_prog_has_trampoline() guard, causing unnecessary rejection of kprobe programs that share a prog_array with different call_get_func_ip values.

--===============5904675307736768806==--

