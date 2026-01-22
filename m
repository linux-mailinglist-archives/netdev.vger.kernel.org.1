Return-Path: <netdev+bounces-252110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPjgK/RqcWmaGgAAu9opvQ
	(envelope-from <netdev+bounces-252110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:10:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 309975FD89
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A98950271C
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 00:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DCA21D5AA;
	Thu, 22 Jan 2026 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aE/PQNu4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB632135CE
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040614; cv=pass; b=iKkRzEfzkLye1s0bjxrz8Nde7pkRC3VIb1vtFC/oyk+8BSI8g8TL9OnWmZRxUvQ5eYY6pLTomQxa/MHVBlP+ucpsIhSIvVIOhs6Nbrcw4yLMjapoXNqoiLzrPtdTD5Ij4qaZ/LizFkURf4v9eePo8mHbZdiXr6xJB4nyoKJhdBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040614; c=relaxed/simple;
	bh=E+w1se1yD98YbUFA0FefiqES/M2g51jDvmuw5rYoG0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUy3bjdy1pqR9YDdlIty9uCXoZgx4ilIxpuiawyAZL4UprcFDEpJR0ItVeqNKRCu0VDI77YidnWR58Frf8TZu+XOpWfIACdHoevJUDxoLA2Gqo/jEvzERpwvYcnXPo5UoUtXIjMZaiAEN9zgifVC9KXJYCUi3tW8PsG97w00otM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aE/PQNu4; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c84dc332cso250600a91.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:10:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769040609; cv=none;
        d=google.com; s=arc-20240605;
        b=i+F9fdiZWjzUR4tTE8RD9JC4CDH9TSvxkXDXY7FlzJMe8Uzl2wgS018hc9u2rcq5yU
         wSqRzO4Zk/7f/LDtBwCU9Q2nQwRVdEgMkiKX2S3r5yyTYUfSoz8QQWcX3rfFpFutNmZJ
         1roE3iX0R73741zEnR5OhagOnzH5CiABUd2O6cA00p3G3XpUUlUj1QOtu3l67E/vqSJC
         GFYoRb+GpGx0e7BP2YTJt60A+BsZ30NgTIELeIbagXM882klRPTbjVZY/kPtUfp1S9Jy
         nydUeTMdmYLQMN625d7/6PWgjSmAIniN80NB6mq+zy800LWNcLRi4p7akRX20PftnqjZ
         miXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5RdFdvYZ2+yT8ESpVs1g7QzLTQwBWAi4m9fXSa+H6iU=;
        fh=S75ed1zxXn0w3hK3yJR3Pc4ZBtQBBAj+tSk9xiRvSJI=;
        b=amIEl0JDvbd3NR38fbFHKT6dRGIKAyMPm2DVsz6YJLFRUpO125rKihOBjpjVzY/VyB
         a3Q0GTfUW/Kmd1FhpskBHieMJbls2G8oDewOnRI3kVePFNjwioGIOv5HLHcQ+m1WblgK
         iT1aqFg9CAD4zYBNiR9fa6Y9O3qImUyF+pMWAaooDJ2sslP30AvYz/BCCDOLv4aM8Ywa
         pieToY57DH+7iK1//HdkLyp2/WJg68iuiPpzTXe4sUWkiPUK33y+7QP4BaUhLBTl+Nzb
         TtqGTa1Tc+6wTC/5aaRFQr2hqR4ZljFVTZnsva3wGkp440iYtmZx2+ZsOZDxKA4dZXas
         zfBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769040609; x=1769645409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RdFdvYZ2+yT8ESpVs1g7QzLTQwBWAi4m9fXSa+H6iU=;
        b=aE/PQNu4Szyxg6ar+5NYXSooXgj+xfmyWlbfu6Rc8v/eU8eSfwPk8dPH/fYb9D5Rwz
         +2DIenuTnkWS5mPp7AiVWfVkXRoQFTzXtbKsDURZGAf1s2CbIiZKPzLiK8FldV9ha44X
         1uNbtBJJaT22S9Giitok065IbQiSOurP8oahG/eFuEVU8BJq7DanhXUZ4yWv1sIdwdEH
         pC5SIn1uZqH67qRo42Hl0Bo4lW0SHEhYnt6BNvIGO2XAlQW8UPWKxtxRvWj2lah2RdDo
         2tok2qb1wnB3MqTRNVEDj4o+ndvW6tE8rQCwI8mkY6CO543k6xlTAEtMuIpDjzXryboM
         HGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769040609; x=1769645409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5RdFdvYZ2+yT8ESpVs1g7QzLTQwBWAi4m9fXSa+H6iU=;
        b=APinpXW4eTGMVlAlQJ8xTw8Msz7HRkdegbw7N4jNPKndrz/iMVL3p2sDEPxmBsSrnN
         U0kKKDJKm10I9Vu93N68kr/MV1Ss3EUaUfnAqAO/ks8g3Q8dhW2L73X2OLf0NeMnFzRa
         uAuClzHx6KHQdP2Nx108Xco/C5/Z/0bejI29M2ClV2m04Pk5sepTGetSvMRoEwKXxtZA
         wpqD0rjDYuZMpSHXj9tTmgnp5er/GgfDTa5pw0x1yoLxPgTGIeGeximOqHAbmAVWO82k
         4argNzlWIk0evumve7ABHC9Yl5oWZNTg0oxmcwVAZw7WoK6ee6UZpNglIWDtV5KOFedO
         vRlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeJWGf29767EJLo5IkxZN1ct4NGQZooPCStVmyTxC8Fx/+i05u19LAdHdaf1PibYOdmY/TsPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/c2SioNUwH2x/FY+0Nusj8kokN5Vx7x98JS806aXPrKveazWW
	l5N903/7yJ+GmpZFUHYK1Ivw1m/XKod9AdfhkvV9oaGisEkMUGmFaM3tTrSpEugvDRA56i3OeQx
	52x+cvAQevl744qWwwZ8fXcOjbPhO+DU=
X-Gm-Gg: AZuq6aLPDYEmVlOthFSbg8Yokzfo14oFfWE8aKvTez2IPqnd0+lZdGaWeYq4uCSqyha
	gYN//0x+Zkteg8kaoJ+0gLPqKJN8mhcVttfvz5iRc/WDArnmghlURoWUPaOcJvCaezTn8o6NhJ2
	idX82Gs9z7OhzQoS2n2eT2YfdJIcluRO+2vgBDB+cjNXvZRopQ1UnAYC8cY/B2YhQDLy9fjLrDb
	krOY58WWkoiPzlssLRA4xlYEZ1XDn7faG0ph3uuwqHolq7YWp7exr1U0TNjs6Y76YA61nNvSwGi
	lKpRahq68kXEeh4JnRU=
X-Received: by 2002:a17:90b:5603:b0:340:2a16:94be with SMTP id
 98e67ed59e1d1-35272ef6716mr14887681a91.4.1769040609143; Wed, 21 Jan 2026
 16:10:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115112246.221082-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260115112246.221082-1-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Jan 2026 16:09:56 -0800
X-Gm-Features: AZwV_Qj9mePZlRoySqiHX-dtgkm6Br8m3zLXq-i1fsayrU3p7IsjbTJy6NgYzOI
Message-ID: <CAEf4BzZX+hDww=MvMrqx3h9uKdB+Sef8rVMxrvxcm+9jj7MUjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 00/12] bpf: fsession support
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252110-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 309975FD89
X-Rspamd-Action: no action

On Thu, Jan 15, 2026 at 3:23=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Hi, all.
>
> In this version, I followed Andrii's suggestions in v9, and did many
> adjustment.
>
> overall
> -------
> Sometimes, we need to hook both the entry and exit of a function with
> TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
> function, which is not convenient.
>
> Therefore, we add a tracing session support for TRACING. Generally
> speaking, it's similar to kprobe session, which can hook both the entry
> and exit of a function with a single BPF program.
>
> We allow the usage of bpf_get_func_ret() to get the return value in the
> fentry of the tracing session, as it will always get "0", which is safe
> enough and is OK.
>
> Session cookie is also supported with the kfunc bpf_session_cookie().
> In order to limit the stack usage, we limit the maximum number of cookies
> to 4.
>
> kfunc design
> ------------
> In order to keep consistency with existing kfunc, we don't introduce new
> kfunc for fsession. Instead, we reuse the existing kfunc
> bpf_session_cookie() and bpf_session_is_return().
>
> The prototype of bpf_session_cookie() and bpf_session_is_return() don't
> satisfy our needs, so we change their prototype by adding the argument
> "void *ctx" to them.
>
> We inline bpf_session_cookie() and bpf_session_is_return() for fsession
> in the verifier directly. Therefore, we don't need to introduce new
> functions for them.
>
> architecture
> ------------
> The fsession stuff is arch related, so the -EOPNOTSUPP will be returned i=
f
> it is not supported yet by the arch. In this series, we only support
> x86_64. And later, other arch will be implemented.
>
> Changes v9 -> v10:
> * 1st patch: some small adjustment, such as use switch in
>   bpf_prog_has_trampoline()
> * 2nd patch: some adjustment to the commit log and comment
> * 3rd patch:
>   - drop the declaration of bpf_session_is_return() and
>     bpf_session_cookie()
>   - use vmlinux.h instead of bpf_kfuncs.h in uprobe_multi_session.c,
>     kprobe_multi_session_cookie.c and uprobe_multi_session_cookie.c
> * 4th patch:
>   - some adjustment to the comment and commit log
>   - rename the prefix from BPF_TRAMP_M_ tp BPF_TRAMP_SHIFT_

This is minor nit, but I think BPF_TRAMP_IS_RETURN_SHIFT and
BPF_TRAMP_COOKIE_INDEX_SHIFT (note added INDEX, because that's what we
store, not the cookie itself) makes more sense naming-wise and is more
natural to read. Consider updating this.

>   - remove the definition of BPF_TRAMP_M_NR_ARGS
>   - check the program type in bpf_session_filter()
> * 5th patch: some adjustment to the commit log
> * 6th patch:
>   - add the "reg" to the function arguments of emit_store_stack_imm64()
>   - use the positive offset in emit_store_stack_imm64()
> * 7th patch:
>   - use "|" for func_meta instead of "+"
>   - pass the "func_meta_off" to invoke_bpf() explicitly, instead of
>     computing it with "stack_size + 8"
>   - pass the "cookie_off" to invoke_bpf() instead of computing the curren=
t
>     cookie index with "func_meta"
> * 8th patch:
>   - split the modification to bpftool to a separate patch
> * v9: https://lore.kernel.org/bpf/20260110141115.537055-1-dongml2@chinate=
lecom.cn/
>

Overall this looks great, I was actually trying to apply and push it
despite those minor nits I left. But unfortunately there is some
conflict, so you'll have to rebase and resend. Hopefully just one last
time :)

> Changes v8 -> v9:
> * remove the definition of bpf_fsession_cookie and bpf_fsession_is_return
>   in the 4th and 5th patch
> * rename emit_st_r0_imm64() to emit_store_stack_imm64() in the 6th patch
> * v8: https://lore.kernel.org/bpf/20260108022450.88086-1-dongml2@chinatel=
ecom.cn/
>
> Changes v7 -> v8:
> * use the last byte of nr_args for bpf_get_func_arg_cnt() in the 2nd patc=
h
> * v7: https://lore.kernel.org/bpf/20260107064352.291069-1-dongml2@chinate=
lecom.cn/
>
> Changes v6 -> v7:
> * change the prototype of bpf_session_cookie() and bpf_session_is_return(=
),
>   and reuse them instead of introduce new kfunc for fsession.
> * v6: https://lore.kernel.org/bpf/20260104122814.183732-1-dongml2@chinate=
lecom.cn/
>
> Changes v5 -> v6:
> * No changes in this version, just a rebase to deal with conflicts.
> * v5: https://lore.kernel.org/bpf/20251224130735.201422-1-dongml2@chinate=
lecom.cn/
>
> Changes v4 -> v5:
> * use fsession terminology consistently in all patches
> * 1st patch:
>   - use more explicit way in __bpf_trampoline_link_prog()
> * 4th patch:
>   - remove "cookie_cnt" in struct bpf_trampoline
> * 6th patch:
>   - rename nr_regs to func_md
>   - define cookie_off in a new line
> * 7th patch:
>   - remove the handling of BPF_TRACE_SESSION in legacy fallback path for
>     BPF_RAW_TRACEPOINT_OPEN
> * v4: https://lore.kernel.org/bpf/20251217095445.218428-1-dongml2@chinate=
lecom.cn/
>
> Changes v3 -> v4:
> * instead of adding a new hlist to progs_hlist in trampoline, add the bpf
>   program to both the fentry hlist and the fexit hlist.
> * introduce the 2nd patch to reuse the nr_args field in the stack to
>   store all the information we need(except the session cookies).
> * limit the maximum number of cookies to 4.
> * remove the logic to skip fexit if the fentry return non-zero.
> * v3: https://lore.kernel.org/bpf/20251026030143.23807-1-dongml2@chinatel=
ecom.cn/
>
> Changes v2 -> v3:
> * squeeze some patches:
>   - the 2 patches for the kfunc bpf_tracing_is_exit() and
>     bpf_fsession_cookie() are merged into the second patch.
>   - the testcases for fsession are also squeezed.
> * fix the CI error by move the testcase for bpf_get_func_ip to
>   fsession_test.c
> * v2: https://lore.kernel.org/bpf/20251022080159.553805-1-dongml2@chinate=
lecom.cn/
>
> Changes v1 -> v2:
> * session cookie support.
>   In this version, session cookie is implemented, and the kfunc
>   bpf_fsession_cookie() is added.
> * restructure the layout of the stack.
>   In this version, the session stuff that stored in the stack is changed,
>   and we locate them after the return value to not break
>   bpf_get_func_ip().
> * testcase enhancement.
>   Some nits in the testcase that suggested by Jiri is fixed. Meanwhile,
>   the testcase for get_func_ip and session cookie is added too.
> * v1: https://lore.kernel.org/bpf/20251018142124.783206-1-dongml2@chinate=
lecom.cn/
>
> Menglong Dong (12):
>   bpf: add fsession support
>   bpf: use the least significant byte for the nr_args in trampoline
>   bpf: change prototype of bpf_session_{cookie,is_return}
>   bpf: support fsession for bpf_session_is_return
>   bpf: support fsession for bpf_session_cookie
>   bpf,x86: introduce emit_store_stack_imm64() for trampoline
>   bpf,x86: add fsession support for x86_64
>   libbpf: add fsession support
>   bpftool: add fsession support
>   selftests/bpf: add testcases for fsession
>   selftests/bpf: add testcases for fsession cookie
>   selftests/bpf: test fsession mixed with fentry and fexit
>
>  arch/x86/net/bpf_jit_comp.c                   |  71 +++++--
>  include/linux/bpf.h                           |  36 ++++
>  include/uapi/linux/bpf.h                      |   1 +
>  kernel/bpf/btf.c                              |   2 +
>  kernel/bpf/syscall.c                          |  18 +-
>  kernel/bpf/trampoline.c                       |  53 +++++-
>  kernel/bpf/verifier.c                         |  86 +++++++--
>  kernel/trace/bpf_trace.c                      |  49 +++--
>  net/bpf/test_run.c                            |   1 +
>  net/core/bpf_sk_storage.c                     |   1 +
>  tools/bpf/bpftool/common.c                    |   1 +
>  tools/include/uapi/linux/bpf.h                |   1 +
>  tools/lib/bpf/bpf.c                           |   1 +
>  tools/lib/bpf/libbpf.c                        |   3 +
>  tools/testing/selftests/bpf/bpf_kfuncs.h      |   3 -
>  .../selftests/bpf/prog_tests/fsession_test.c  |  90 +++++++++
>  .../bpf/prog_tests/tracing_failure.c          |   2 +-
>  .../selftests/bpf/progs/fsession_test.c       | 179 ++++++++++++++++++
>  .../bpf/progs/kprobe_multi_session_cookie.c   |  15 +-
>  .../bpf/progs/uprobe_multi_session.c          |   7 +-
>  .../bpf/progs/uprobe_multi_session_cookie.c   |  15 +-
>  .../progs/uprobe_multi_session_recursive.c    |  11 +-
>  22 files changed, 550 insertions(+), 96 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.=
c
>  create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c
>
> --
> 2.52.0
>

