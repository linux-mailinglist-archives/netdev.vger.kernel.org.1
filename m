Return-Path: <netdev+bounces-258000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LlAOD1nimkHKAAAu9opvQ
	(envelope-from <netdev+bounces-258000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 00:01:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5207D1154BA
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 00:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD8BB301692C
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 23:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FAB318ED0;
	Mon,  9 Feb 2026 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbcYBDp5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F1230FC34
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770678048; cv=pass; b=coxIYylj7Vnv/D0m0Uz1xxGJSXM20tJFVpP4pjmwde+pnkN8NsOwynRXrr9kumKRjfPKQ16ko/iupjy8Aant4TEEicZ2TJf63svtXir3zHZe5uCBO4vJWGV3tFzuRZ5ZPU3vVdvJhqQUWj45I6mfpVf5nx9EKcokgskosxRuzmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770678048; c=relaxed/simple;
	bh=9lWPPpht6PEPxvl7XktSgKubPJ14O2RmyK4nhm8y/Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s78q/1kwqVVH6XpEvfusrLWfucr8fgQDrEj/IDEDAIixIANUb7RrpcYBYPayP4KO6/RKyVAD4G5TMI7iPTGQwKnREXc1/FPOFpS4ZupYsb4lViX9As9NBxQvMwTmwULzCw03ZJn7JHaZVMkR+IFPRUDavL8YtaxDEHsg2L5u2Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbcYBDp5; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43590777e22so2141421f8f.3
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 15:00:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770678045; cv=none;
        d=google.com; s=arc-20240605;
        b=DfTCfAlgUtgHhxSIikmq/L0K1UVEHA/djf77e7qiNCDe0ZSsDBw2cwQg0E3NvoR1lE
         FfWGQmUgoq1RX9zEbkzDeiUh//rlqLpb1+/KPABhu4vsqJmMJPOnFtHSTvkYlNgqxmoV
         geSxnHF1yhvb9Ir4+FLMybiCulgCelL6deI8UoMPniVsGvrO85hGBraoC9HhONRpnmfb
         YsalbVa4sOoCo7Gb8YQ8OEAbfygdG3nrpfXNDgyfRjP4lXSJ7XZFIBc6dxzRx6Rx0OJm
         /A/W2DykEFzVhS4fb8ZUCxzitCRF54prmMffnZ0mxXFNA6DuPr2Uqce0TUoQ5amE57LC
         bSdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eUKh+ktP4D5UjlpU51UCVp2mx5vtmlgwv81LOUnstJs=;
        fh=nnDEDNy5RG2JPPg545iw+HjzyS1sacqv1CP/5H3iwkA=;
        b=MK4xOg9FZN1rhks3jsQtpKv+GsV8x/JOes+/w4a+zFZGLMDWwa2AP9BxQ8p2FDPUIx
         1rvbVGlSMsTQxFywNGCVJlpCyxl+mtU1Wo8kZA97f/lekTIALZGcQQKxTyo2PTBnFfZf
         1EzIm/cLEU6nBQhGXff1eLd3eOok9bIFyQGTl71maVCb4UyNd9X3tDw5lz0v0BZA4mLq
         FmFLDeFHVmceufhR1C96wtVQyXXceOZ2nAOq9VKCGe4BRVUN2nEezYU10a8ZtLH0/wsc
         ML2/64n3tRwzwxyZnZSuS95PZVJc5L1HqulVa+0Z/2gi1y9MXi2G3HsUAoqskMaRV6sP
         ViGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770678045; x=1771282845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUKh+ktP4D5UjlpU51UCVp2mx5vtmlgwv81LOUnstJs=;
        b=UbcYBDp5Y6WV096x6YuhzuXZB+rRFAhRDDTHiP3jxwZZ4lyrx4c6ODsEeZQQrxa6hE
         hojlASsqpYS1ENeWxG1id+4HwOlAyhDoAoS9XxXoC5NeJexd8021/UZU6vLTlSqtsxNY
         ROBXuEEPTNbPPLhX/6FBqFL6XzBpt6VGTGwKLtoGQD5dfqpwfLyIA/g4JG4US46dAf65
         xWfIlC2N0Bjv7KqPiXpEe7LhNrPgVOv1jA0YeT6Obm/iVyTh4KpC/ogiFGxYKTNU36Tn
         urPLHIWXE3K8f+T4yVGD4kF+qRCuMlpv+FxClA2PutZ2bJUROoJUWCrhMT/WVz6Q3G2u
         uTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770678045; x=1771282845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eUKh+ktP4D5UjlpU51UCVp2mx5vtmlgwv81LOUnstJs=;
        b=cQKPFH+/VvtgPdgnQFWqdkw1siiyzmxgaznXkGiwxylnfXIqdULK+wRpCQPVkoNqHW
         /v/bg06Ym7N8I6a0hCtDJIRO9aEoxRWYSvIntRsK8qzEvRT+wuTTlrF1PNc3G6LWdd0w
         UXuGVCxZJALJT0riuKtYIBhv/2pcKtRDfUcllFZTrCNrwljGCdQCxnyAXO5RoL6UYxBO
         Rae0rQYpjtzXAntK1FTTSc8iw5v8Kfqk+M9YASkj+UgbWuGeaK9kXk8fUPnBbP4u20Yq
         Ltt3DYMslAlndKmL4KXDoOhD0uWADpHB3gyi6NBLQ8+f87wQ1B6jJQqi3v+dNMQjfUAa
         xTsg==
X-Forwarded-Encrypted: i=1; AJvYcCWzQ084p7bu0raQkGDnoAS1Piuo5ZVyHIBPxsiS/3SpDDdz+p5DcnzBML2AO6hl/lQcwCMCMXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPzcwNj2bwpxN5Gfk3XaOJzNEx0VkGMAoJi7dFrs4oIVmNkV3R
	8EBrTv0e9yhQcGIfbwpp7M0UiYnZ/NcZNt7L0//9/BJu2cG7n7WnNFK9mxDEOnWpithTnubX83w
	QipqllyXezztrNHzYjl70Ny7OwJRyltBVZQ==
X-Gm-Gg: AZuq6aKbxodYrm4cLNEHnSQLgIIs/f9FhgD9b0gZZTUyo9JV53Py2gSuIWd5DnQK/ms
	/s3glke0ZTS0aIx5n91w8g7n0NmZaqIEJVqHtlIZOXdPqpP1mxMwKBHE6c2wYXG1dhKcrgNG+B3
	sNvaSNP/+0gghF/dpF0+27S+6M8ehQSHnH1Ao0vebwAfDvX31GPYvx7G1YmFyNi+XTpmR1q3yZ6
	7VitLZdXi0zOQTAOuVhnWof8xMl+g7vjkj7O6aQs5ujCRTaxkURaZjfEmx2aO5VZ7EAeahyIaBq
	4UMsQrA9mPeYAOrxrbvvnLYfRBerUJ4MTZPkFYGWYxgDoqETu15zdrWwGxH1slvFFdnAMhtU05d
	32BAlsXnABZTxkA==
X-Received: by 2002:a05:6000:2585:b0:436:1a2e:9f1c with SMTP id
 ffacd0b85a97d-4362937847emr19414201f8f.19.1770678045015; Mon, 09 Feb 2026
 15:00:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207230720.2542943-1-kuniyu@google.com> <20260207230720.2542943-2-kuniyu@google.com>
In-Reply-To: <20260207230720.2542943-2-kuniyu@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Feb 2026 15:00:33 -0800
X-Gm-Features: AZwV_Qg5AU1ZTDTiqn3vH5Veon_e04vfTf3pMmck8qqfJ6fs_hJwxlUAdfcazLU
Message-ID: <CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs4ox0HhAA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf 1/2] bpf: Reject access to unix_sk(sk)->peer.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258000-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,rbox.co,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,rbox.co:email]
X-Rspamd-Queue-Id: 5207D1154BA
X-Rspamd-Action: no action

On Sat, Feb 7, 2026 at 3:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> Michal Luczaj reported use-after-free of unix_sk(sk)->peer by
> bpf_skc_to_unix_sock(). [0]
>
> Accessing unix_sk(sk)->peer is safe only under unix_state_lock(),
> but there are many functions where bpf prog can access the field
> locklessly via fentry/fexit.
>
> unix_dgram_connect() could clear unix_sk(sk)->peer and release
> the last refcnt of the peer sk while a bpf prog is accessing it,
> resulting in use-after-free.
>
> Another problematic scenario is that unix_sk(sk)->peer could
> go away while being passed to bpf_setsockopt() in bpf iter.
>
> To avoid such issues, let's reject access to unix_sk(sk)->peer
> by marking the pointer with PTR_UNTRUSTED.
>
> If needed, we could add a new helper later that uses unix_peer_get()
> and requires bpf_sk_release().
>
> [0]:
> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
> Read of size 2 at addr ffff888147d38890 by task test_progs/2495
> Call Trace:
>  dump_stack_lvl+0x5d/0x80
>  print_report+0x170/0x4f3
>  kasan_report+0xe1/0x180
>  bpf_skc_to_unix_sock+0xa4/0xb0
>  bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
>  bpf_trampoline_6442564662+0x47/0xab
>  unix_shutdown+0x9/0x880
>  __sys_shutdown+0xe1/0x160
>  __x64_sys_shutdown+0x52/0x90
>  do_syscall_64+0x6b/0x3a0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Fixes: 9eeb3aa33ae0 ("bpf: Add bpf_skc_to_unix_sock() helper")
> Reported-by: Michal Luczaj <mhal@rbox.co>
> Closes: https://lore.kernel.org/all/408569e7-2b82-4eff-b767-79ce6ef6cae0@=
rbox.co/
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  kernel/bpf/verifier.c                         | 18 +++++++++++++
>  .../selftests/bpf/progs/verifier_sock.c       | 25 +++++++++++++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3135643d5695..b328a1640c82 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7076,6 +7076,7 @@ static int bpf_map_direct_read(struct bpf_map *map,=
 int off, int size, u64 *val,
>  #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __safe_rcu_or=
_null)
>  #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_trusted)
>  #define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__type, __safe_tr=
usted_or_null)
> +#define BTF_TYPE_SAFE_UNTRUSTED(__type)  __PASTE(__type, __safe_untruste=
d)
>
>  /*
>   * Allow list few fields as RCU trusted or full trusted.
> @@ -7154,6 +7155,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struc=
t) {
>         struct file *vm_file;
>  };
>
> +BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock) {
> +       struct sock *peer;
> +};
> +

That's just one out of many. It's not really a fix,
but a bandaid for one case.
We discussed it in the past and the only way forward is to make
helpers only accept trusted args.
Recently we made KF_TRUSTED_ARGS a default for all kfuncs.
We should do the same for helpers.

pw-bot: cr

