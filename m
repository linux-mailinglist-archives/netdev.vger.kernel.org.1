Return-Path: <netdev+bounces-284054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIsxIdYV+Wls5QIAu9opvQ
	(envelope-from <netdev+bounces-284054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 23:55:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A5A4C441D
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 23:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFDFD300875E
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 21:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74C236EAB0;
	Mon,  4 May 2026 21:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uErvyW9W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4436366DC1
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777931621; cv=pass; b=OsBNSUl/ShNtDvYxIjLZsiLd8nOxOOxn4QUwrtM7vse1iJ0row6VohjAirpUc4sAFm2t+IMk54DCAOr674/9WfTpvgdaumjL0WLHSxWStPwVYupv1lnrWS/wkqBslwJtwYa7Yi0e0r4aaTzTgbsXLumlwftY/N52HsgsJRcfsdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777931621; c=relaxed/simple;
	bh=o1k8TbcL7uEQsmT8zaZK9TACGYgWElH9uAt/ppTSYX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oV2x88Isb4L0AVfPAb9J9aZSYJv7BHEV/0VlLefSywpECclqWWn1VoixS9NXfLx52CvPCZ11nR9MM4ajiz3/Fa+6WjvR3+SgIcVW/cvsEziFBW0Z52dZMP351uyqO6YpH+2pHr9nnjRwBvyfJJfLwK2rcvOJulOSepRDBa60Z80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uErvyW9W; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c8c9c4cd8so3169704c88.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 14:53:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777931619; cv=none;
        d=google.com; s=arc-20240605;
        b=icETYaLkfInAKTKWavn0OjdcPalkEZS8ZoNOAdOSeCW09AWWM02QGCZ1ipKxq1onhG
         6G2DoM2zsVJAqLoPCbnZY+gTOqWXW1Pl3ZkCL/XOzGDwomuaA77oOzqqPABfsHCAPp2p
         fGC+Dj5RQ7R5H6Y+rUP3ybze/ks4OLksbNIZn9idBSg5i3ORjlQT053fu5hiQptZamV/
         /JKjAx58eVtwz1BeNnBpAAe8+f6B4nj3ZQ1OgYS6OTklGCCPdBjxlyIxn/Q1kh1Ktgh/
         PNSkjlWSAOIbdf58QHmv+3lUZ3qiDEbqAsrVpjKoOVJLjfF1XMqaZpkTgrhsKBc8VMXJ
         jbgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O3PEir1LZ+0vgrvNb+HSA3dhRn8skm0babc5zb8Pu7M=;
        fh=RUqVLXfB8tfjLKwXVwMsNnLNBKIemcTKjsFqdl98nk0=;
        b=OvKG0SR1QRXMLwKY0551wydO5KH0C5KE+nmi1FetUAwLrG91r+b4P4t/23W/dc8ntd
         rfubacCiLfE+WtAVndB3WpWnRucQKy3mN4ROs0YigWde0mCY79zHUGZIoY8frrUAU2cd
         5DVTj2KNuq0li/hYSYdLFImHaftL09S/hRBBGVtSpxXiA12R0yWZbAQF6OPWSPGd2HrF
         9qVyE2dexkbaWQcxhSfL2p1mb1WRlBrCOs/SgRyEURS4KwKepO7cHWzr8B5rh1xjyZcx
         8kZRfUbdTd9Pow0wjrUZIPbD2LgEL3nTX9sNyvWBCkbTXmmVsHm9hh4CiHG+WnoW2gIK
         prUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777931619; x=1778536419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3PEir1LZ+0vgrvNb+HSA3dhRn8skm0babc5zb8Pu7M=;
        b=uErvyW9W9gBjZnxrwTj98YFy/EIlI6MrYcNZFfFD+O9zFnO08Ai1BymXw3ib7R/eEk
         9b/3fqIg11M7gSz9NeqrzpmNVpTaBZ8RVsZB6dravrOtLWYLLmzL+S64eq1B6Ptz4f1Z
         BLseyKhumNXBDllcAyJoXJej3LtAUBTIRjoeJXz+7zB3smZvPOYFiPYTDUT5uzYrYG6q
         8gRVPJHxRrPopBE+qwB1x5JKvcgq6JZCeRG25w42Idcf41afzz58fMeh5pChmZZ2SdVC
         92ZRwbY7DIjxiMi8J7ujHFIdariG76A9IxaO4oAMXlW9laNRUvKdXS8qimddveXQLVf3
         PPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777931619; x=1778536419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O3PEir1LZ+0vgrvNb+HSA3dhRn8skm0babc5zb8Pu7M=;
        b=ANHit5MwXfTNkMPjpHz9G0zRm3pzXm/DBTMD1WwFx2wRUcCAaRYuk5bf8aBE6mU8wK
         22rnRjRlXjEA0nTlWZi8XU0NBXpdxqIdACdX0KVjObhMmSXOwLs24zgFao8o+DFtoKHD
         kpef77QkyOZVysxSl9grFDqVOwwIdEoR1Mf0ex5RfyUHwQTKZRW/h0eShbG07dTQBb/v
         rv5yYE6Ghrk00g5eRouu7HSe/QA3S1nxh97UHvmOMnmB2NIO02g6Jt7mWGXSZIvWUZMH
         Ti8Yfu0k0U9mttN8AC520cTj/RqNy2F7joLJUOxZCIu1LMisnWWX+pmXvOtzY/dsA5YN
         78Lg==
X-Forwarded-Encrypted: i=1; AFNElJ+29zUTA5V0dOB2Iagz9YvOs0TV634WdnOiZ4G8I/9JkX1fjkGsik1QfMqwo6Yq9PXKDyAxIYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgASZba5aieAykQGbhfQAE8GUKEbrsZbTVcJ7sHnyIUME4MaUU
	ec8pfOJeyY3kNr/2Nf8xIiWteh51PltqlIK5YQ83wRhwaZRBokUcOxecxgGCbTqLKpUrog1K7Ev
	Mmo++lRMAdLcffgyj4AyZmy1nMW5Fe5i0tH1FjuIF
X-Gm-Gg: AeBDievi28t9+tt7Y7sZhYac0FitqHzfahE+aAuczFHVrSpWW4JH7fdTqU625eY5qam
	P6gZY4AxUG6vZhRgS2BMw69WalQBRkqvcujFXJSP3bCUJQ2XOFNaJbfGzyXvXJjzCZbgfKx+cQo
	ORlSb73wQCwymmsiDND21kIPyd9ykQFzT4tA+Kf23vmpTsuYe2I/BAYTlbXzg8LPjn2RhWbPWd0
	ziSLKHpKy3HsiI++pPbkXNwpRm74ZL4dFcTDtRT1r168BGqvriiAGcBF+t0n7L76IvEwOMBjTd3
	BwTWWnlNqVFcn4QdRQ/fMkHmOHDr+xav9lBlSp5tpSio0FOV6D+OV/qamBPl4jc7NCRZ/Pdz/AR
	KyFydzHXY0mz9+hXjGAZ9i1QG4u1f16zkI1rS3xh5aq1OlV1SqIoIDCshZAqskWU8IVnsI5s=
X-Received: by 2002:a05:7022:ec86:b0:119:e569:f86d with SMTP id
 a92af1059eb24-130a9deca09mr479698c88.10.1777931618299; Mon, 04 May 2026
 14:53:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504210610.180150-2-kuniyu@google.com> <f3fb214ed73246731c525dfdccdcd379bd6d4f1e4570eba0cd19d56f888f9b0a@mail.kernel.org>
In-Reply-To: <f3fb214ed73246731c525dfdccdcd379bd6d4f1e4570eba0cd19d56f888f9b0a@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 4 May 2026 14:53:27 -0700
X-Gm-Features: AVHnY4IglCvi52y3FrnDwdstFXacRE-gfopygiqQ7Wc1b74Q6ktBMo2kGwY5mnE
Message-ID: <CAAVpQUCoxKwxafqsVrqCxkcfpxCTwYKBLmhyZJSugeLjXKa81w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 1/6] bpf: tcp: Fix type confusion in bpf_tcp_sock().
To: bot+bpf-ci@kernel.org
Cc: martin.lau@linux.dev, daniel@iogearbox.net, ast@kernel.org, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	john.fastabend@gmail.com, sdf@fomichev.me, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, edumazet@google.com, 
	kuni1840@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	melotti@google.com, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E4A5A4C441D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284054-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,kernel.org,gmail.com,fomichev.me,google.com,vger.kernel.org,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, May 4, 2026 at 2:50=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index bc96c18df4e0..cd88633f8dc1 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -7475,7 +7475,7 @@ u32 bpf_tcp_sock_convert_ctx_access(enum bpf_acce=
ss_type type,
> >
> >  BPF_CALL_1(bpf_tcp_sock, struct sock *, sk)
> >  {
> > -     if (sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP)
> > +     if (sk_fullsock(sk) && sk_is_tcp(sk))
> >               return (unsigned long)sk;
> >
> >       return (unsigned long)NULL;
>
> While this patch fixes bpf_tcp_sock(), does sol_tcp_sockopt() remain

It seems Sashiko does not have context on the following patches.

All helper functions mentioned in the review comment are fixed
in the later patches separately.



> vulnerable? Since ctx->sk evaluates to PTR_TO_SOCKET in a CGROUP_SOCKOPT
> program and is directly accepted by bpf_setsockopt() and bpf_getsockopt()
> via ARG_PTR_TO_BTF_ID_SOCK_COMMON, can a user create a RAW socket with
> IPPROTO_TCP and directly pass ctx->sk to bpf_setsockopt(), bypassing
> bpf_tcp_sock() entirely?
>
> Looking at sol_tcp_sockopt():
>
> static int sol_tcp_sockopt(struct sock *sk, int optname,
>                            char *optval, int *optlen,
>                            bool getopt)
> {
>         if (sk->sk_protocol !=3D IPPROTO_TCP)
>                 return -EINVAL;
>
> This appears to only check sk->sk_protocol =3D=3D IPPROTO_TCP without ver=
ifying
> sk->sk_type =3D=3D SOCK_STREAM, which would allow the same slab out-of-bo=
unds
> access through a different code path.
>
> Additionally, do bpf_skc_to_tcp_sock() and bpf_skc_to_tcp6_sock() suffer
> from the same type confusion? They appear to check sk->sk_protocol =3D=3D
> IPPROTO_TCP without verifying sk->sk_type =3D=3D SOCK_STREAM.
>
> Could a BPF program pass a RAW socket with IPPROTO_TCP to these helpers
> and receive a valid BTF pointer to struct tcp_sock, allowing out-of-bound=
s
> slab reads?
>
> Looking at bpf_skc_to_tcp_sock():
>
> BPF_CALL_1(bpf_skc_to_tcp_sock, struct sock *, sk)
> {
>         if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP)
>                 return (unsigned long)sk;
>
>         return (unsigned long)NULL;
> }
>
> And bpf_skc_to_tcp6_sock():
>
> BPF_CALL_1(bpf_skc_to_tcp6_sock, struct sock *, sk)
> {
>         /* tcp6_sock type is not generated in dwarf and hence btf,
>          * trigger an explicit type generation here.
>          */
>         BTF_TYPE_EMIT(struct tcp6_sock);
>         if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP &=
&
>             sk->sk_family =3D=3D AF_INET6)
>                 return (unsigned long)sk;
>
> Finally, does bpf_mptcp_sock_from_subflow() in net/mptcp/bpf.c also need
> a similar update? It checks sk->sk_protocol =3D=3D IPPROTO_TCP and immedi=
ately
> evaluates sk_is_mptcp(sk).
>
> Since sk_is_mptcp() indiscriminately casts the socket to struct tcp_sock
> and accesses tcp_sk(sk)->is_mptcp, passing a RAW socket could trigger an
> immediate out-of-bounds slab read. If this memory happens to be non-zero,
> it might proceed to call mptcp_subflow_ctx(sk)->conn, which would read a
> garbage pointer from out-of-bounds memory:
>
> struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
> {
>         if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP &=
& sk_is_mptcp(sk))
>                 return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
>
>         return NULL;
> }
>
> These issues were raised by sashiko-bot@kernel.org in v1:
> https://lore.kernel.org/bpf/20260501184452.7F46FC2BCB4@smtp.kernel.org/
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/253442=
93379

