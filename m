Return-Path: <netdev+bounces-291139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJhLLQdzEmrUzQYAu9opvQ
	(envelope-from <netdev+bounces-291139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 05:39:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 556715C1503
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 05:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C0ED3009165
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 03:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBA7282F13;
	Sun, 24 May 2026 03:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V7YkrgAf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0CF156F45
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779593836; cv=pass; b=ibe1HjojAKDmovFG7AhmYtO9fb+1XEm4ZAYHwNaS0PShFRNReZ7RhGmbRSVIt4/Nk8eb/2HBB/+h0qn4oLBXdCXfPc9O/kzMU1NXCPnY/uqAs0FKEaFFU5FhxDtB/fRb5fGy/NkU1G682qgKkiLIsOexMkdGjvtwao/IKJWcNHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779593836; c=relaxed/simple;
	bh=Mff4l/ItXu9ZqNqYUtUuiPAKYv3iw1pM9tr4xWQgEVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8jQ1DY9Nn4Uf4qN/EB8guwQ46PGMipAStBr5lzUZvmH0zTW8ZTtS9izK53Y6Xi/4dYcfC7Rcud+hjc+0iWUY5SX3TYqHjwREMf2Vrs3IyE2DOL4ba0HXrF/CZGea/IHsxaGhQdW0p6h9p60XOpfWJs2Vm0gJ4CKbw8DWbU9AHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V7YkrgAf; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1309f4ee97fso9426600c88.1
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 20:37:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779593834; cv=none;
        d=google.com; s=arc-20240605;
        b=bW3TDPJC/lPZntt1aJRtSQsJHtscTgWXYsUxigQ17FC798b1e5ZJLQw7P/iIIi7paP
         41g7M+0l/xuJHrdVjhQr9R+c+cvOyXQ9grvCqY4j+yAErM0ChLwmNjCG4bwWv72a0CPj
         QC0L9EXwr11vbEyEa63CZn5iO3yLf8v2CvhaJXWXwgegqBl6kz448HmDbJO4+o/WCoMY
         G7nXKVMkNl2O+m3EDORaxmOs2bQ0BVeg/MS6BoGpGmNgey/2LkESY/QamVKgzUbdHq6g
         3PNAqm4bgsRc0AZezJNOi6FjoRiudgoHaBlY42LcOztQ95XH1rSCr74PRNpTaV84JqPp
         9IYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xu+3Mbkt9D4gGjs6xNbDhlWV9Mr0QNOutO1d5HR5CM4=;
        fh=e89JkU8ikQcUHQhXHRSn2dscv6HOQxePX01BQrRQomI=;
        b=Vp/wusBxrG5iDPVnbPoV9ri08jZKwkH9Q+KglaIKJ46njbTLJ8IySI6wfDeTrf+uhz
         YALU8/abQzWs5RhFXil2v4asVRYuOzna36Egmsgdkmzkx4bbRc7OB0yvuKgxwbclwAbh
         6lOSz5gKMkbD9029Clp64SmTGaKEUaeQ0KDkGfbN0fmLHqDq9fm/Em5Ufe//MLtFYFPF
         cjcuKE0EFf7i+5q5ruPkgEZjLWqSoHoVzYwnL5eGYR+c2F6IF+g5rnQtrsbyrhpvzlS9
         bgSp1/6zDlwGzEtPucho+PnUuScme+xAkYVZ7nmyecYnLWzPZ54Ad/YT8fw/bJlpD+B0
         f54g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779593834; x=1780198634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xu+3Mbkt9D4gGjs6xNbDhlWV9Mr0QNOutO1d5HR5CM4=;
        b=V7YkrgAfuUKjud69rP53WFp+/WN8XKChKRFb+RWCPY625tHwQa77BewPHwsE3a10Eu
         4XFleIzq7Av1UwTxxGEz4zHPEKbR72Tf44MBJC6vlK96DuCG2uXckdpTsIhUh80NDu0m
         hd1xa1s2QrITJkeg3oazUvZWD734csdHU2Aw2kvQ9uTE5ZVtOt1XZFVAI8eyjK2zao0z
         u51Q2aqXpfy7gSPh2YztWCgS1nceFEpgMC8eP5OyWwTxsl3Ymrimc+BYY6FmWxIsVDh8
         JnzvJrMbNpWZdH20z4rU8HBsiGPaYriTvQVU2bUKoVJMj23eJ+px3Tt3AobERityynMH
         CkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779593834; x=1780198634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xu+3Mbkt9D4gGjs6xNbDhlWV9Mr0QNOutO1d5HR5CM4=;
        b=CiRXpWeC0TTaZsaNio+E1Ss8K6uzBEcJUMz/XCHXR1kouLSrtF6phhBX2PzP/HGznZ
         fflhIalUrxPMicQkvK/kRH6PDedW+XfyZvMxq2rZRN10NuYVizTJvRJYtKZnG84+/GVk
         D7QxI1N8zIvBBFzwb2gfKC39dkKV//0jeLCTRxRwJmr4rSrMBCvuBBuEklE+leiswTkQ
         O+EPPei8ZP8nBztBa8XKZGvi3RRFHZSljDB20H8yUUWD0bJ7MtpBxpAGlZLdngxZ/e12
         j6Q/LO/XkC0CeFHH5/ZMdx/h34ej/HCJsKKkjeQ/AQ/a5rdysKeLLluPB9ietpwnWw5J
         mcJg==
X-Forwarded-Encrypted: i=1; AFNElJ/ULL1IEBCXDAgSINUf3V9SlXxZcbA22w+MAFEY4gOJOkY5wVIfOUweJft0W53gWssL4oiJ72Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLFNVm+ReHWhgNfMj/jtAtyBW7mjeDDmB81oF4ovxtem1ITkoW
	RxAAIIP1F4gCxaArv46Yhwj+4cPLvsATRvBbCXRxexSwqWwRJXkVgmo6it2Rgnxy6Spqn5fhjFX
	jBOsfO8j7/Y9EZoFHDP9vPrSkvoIAAw/E28ki8fSt
X-Gm-Gg: Acq92OFgu3vnURyTx00aiHcxJDkuOI2iCdFBD5iNg8yCY327gsay5vHhmvrT+UTnP61
	7zLQNsliAlkV9W/8LRsQT6UcsdDzS6MZJjxebfUox2lewTui+2tuHrlZNRZFbwgCpjKmhN3Awpk
	4g+tI7nzGBV7Qeh3JezsI8ostGSroU7y/TB9oXJqbrVRzBtOY+UpkG0CCh0RGU2sLggzqzeEXs2
	kFd7/lnGoKYOi/9xoNRxDzkTopVH6eDy86UL+xScPKOzh9gLxO5GDLYp3Fz3l5RK4/KmxEWdCfg
	lt3Bpg0mxNKVnP7SGIGyidhJAjcDl1Xh7l4GPcwTDijyL1Bw7y8nfKZiM4xpSDMM7OFwaQ9P2fp
	8bWrBcyN7tYybX4nidCsPW+aHaxqF7mh2NOQeS0JKK+fbfqQU5T/2Es9Ax0GWUgbdQ6O0n6+WQw
	==
X-Received: by 2002:a05:7022:126:b0:136:3520:7234 with SMTP id
 a92af1059eb24-1365f70aad4mr3408534c88.12.1779593832929; Sat, 23 May 2026
 20:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523083001.2911931-7-kuniyu@google.com> <0c3701f35cdef6411722a91c596d736cc9e88e3d7a14564caf5354302eb92d98@mail.kernel.org>
In-Reply-To: <0c3701f35cdef6411722a91c596d736cc9e88e3d7a14564caf5354302eb92d98@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 23 May 2026 20:37:01 -0700
X-Gm-Features: AVHnY4KgiB0CX2qyM7pkseVw3XHqXKIJ_6Yv9JljSTiebp-5w9SA3Cknk1SaxvE
Message-ID: <CAAVpQUCzzCwCK9+_GRJt53emU_9YQg3zL5Sg=vpPHue1KYr4bA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 06/11] bpf: tcp: Make BPF_SOCK_OPS_RCVQ_CB and
 SOCKMAP mutually exclusive.
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me, 
	edumazet@google.com, ncardwell@google.com, willemb@google.com, 
	ukyab@berkeley.edu, kuni1840@gmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org,meta.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-291139-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[20]
X-Rspamd-Queue-Id: 556715C1503
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 2:20=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index c6a6853909c4..bc95d8e7b62e 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2853,6 +2853,7 @@ struct sk_msg;
> >  struct sk_psock;
> >
> >  #ifdef CONFIG_BPF_SYSCALL
> > +bool tcp_in_sockmap(const struct sock *sk);
> >  int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool=
 restore);
> >  void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
> >  #ifdef CONFIG_BPF_STREAM_PARSER
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 3608036632a8..1fb63b264b18 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
>
> [ ... ]
>
> > @@ -5382,12 +5382,34 @@ static int bpf_sol_tcp_getsockopt(struct sock *=
sk, int optname,
> >       return 0;
> >  }
> >
> > +static int __bpf_sock_ops_cb_flags_set(struct sock *sk, int val)
> > +{
> > +     if (!(val & BPF_SOCK_OPS_RCVQ_CB_FLAG) ||
> > +         tcp_sk(sk)->bpf_sock_ops_cb_flags & BPF_SOCK_OPS_RCVQ_CB_FLAG=
) {
> > +             tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> > +             return 0;
> > +     }
> > +
> > +     write_lock_bh(&sk->sk_callback_lock);
> > +
> > +     if (unlikely(tcp_in_sockmap(sk))) {
> > +             write_unlock_bh(&sk->sk_callback_lock);
> > +             return -EBUSY;
> > +     }
> > +
> > +     tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> > +
> > +     write_unlock_bh(&sk->sk_callback_lock);
> > +
> > +     return 0;
> > +}
> > +
>
> [ ... ]
>
> > diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> > index cc0bd73f36b6..7e7966b095f9 100644
> > --- a/net/ipv4/tcp_bpf.c
> > +++ b/net/ipv4/tcp_bpf.c
> > @@ -705,6 +705,16 @@ int tcp_bpf_strp_read_sock(struct strparser *strp,=
 read_descriptor_t *desc,
> >  }
> >  #endif /* CONFIG_BPF_STREAM_PARSER */
> >
> > +bool tcp_in_sockmap(const struct sock *sk)
> > +{
> > +     const struct proto *prot =3D sk->sk_prot;
> > +
> > +     lockdep_assert_held(&sk->sk_callback_lock);
> > +
> > +     return &tcp_bpf_prots[0][0] <=3D prot &&
> > +             prot <=3D &tcp_bpf_prots[TCP_BPF_NUM_PROTS - 1][TCP_BPF_N=
UM_CFGS - 1];
> > +}
> > +
> >  int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool=
 restore)
> >  {
> >       int family =3D sk->sk_family =3D=3D AF_INET6 ? TCP_BPF_IPV6 : TCP=
_BPF_IPV4;
> > @@ -729,6 +739,8 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk=
_psock *psock, bool restore)
> >                       sock_replace_proto(sk, psock->sk_proto);
> >               }
> >               return 0;
> > +     } else if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_C=
B_FLAG)) {
> > +             return -EBUSY;
>                    ^^^^
>
> A subsystem pattern flags this as potentially concerning: the commit
> message explains that write_lock_bh(&sk->sk_callback_lock) is taken to
> synchronise with tcp_bpf_update_proto(), but does tcp_bpf_update_proto()
> actually take sk->sk_callback_lock?
>
> Looking at the call chain, tcp_bpf_update_proto() is invoked from the
> SOCKMAP path through:
>
> sock_map_link() in net/core/sock_map.c
>   -> sock_map_init_proto()
>      -> tcp_bpf_update_proto()
>
> In sock_map_link(), sk_callback_lock is acquired after sock_map_init_prot=
o()
> completes, not before.

Oh I assumed it's under lock since sock_map_del_link() and
sk_psock_drop() call it under the lock.

I'll move sock_map_init_proto() under the lock as well.


> The lock is taken when setting sk_user_data to the
> psock, but sock_map_init_proto() runs outside the lock and calls
> sock_replace_proto() to write sk->sk_prot without holding sk_callback_loc=
k.
>
> Is there a race here? Consider this interleaving (the commit message
> acknowledges sock_map_update_elem only holds bh_lock_sock(), so it can ru=
n
> concurrently with setsockopt that holds the socket lock):
>
>   CPU 0 (sockmap path)                   CPU 1 (BPF setsockopt RCVQ_CB)
>   sock_map_link():                       __bpf_sock_ops_cb_flags_set():
>     sk_psock_init():                       (val has RCVQ_CB, current=3D0)
>       lock sk_callback_lock
>       set sk_user_data =3D psock
>       unlock sk_callback_lock
>     sock_map_init_proto():
>       tcp_bpf_update_proto():
>         BPF_SOCK_OPS_TEST_FLAG: 0
>         (no flag yet, check passes)
>                                            write_lock_bh(sk_callback_lock=
)
>                                            tcp_in_sockmap(sk): sk_prot
>                                            still old, returns false
>                                            tp->bpf_sock_ops_cb_flags =3D =
val
>                                            (RCVQ_CB set)
>                                            write_unlock_bh
>         sock_replace_proto(sk,
>           &tcp_bpf_prots[][])
>         (sk_prot now in tcp_bpf_prots)
>
> Final state: sk_prot is in tcp_bpf_prots[][] AND bpf_sock_ops_cb_flags ha=
s
> BPF_SOCK_OPS_RCVQ_CB_FLAG. Both features are now enabled, which violates =
the
> mutual exclusion goal.
>
> The validation checks in tcp_bpf_update_proto() and __bpf_sock_ops_cb_fla=
gs_set()
> each check shared state before the exclusion point, not under common excl=
usion.
> Running a lockset analysis on the two shared variables:
>
>   bpf_sock_ops_cb_flags: written by __bpf_sock_ops_cb_flags_set under
>   sk_callback_lock; read by tcp_bpf_update_proto with no lock.
>   Lockset intersection =3D {sk_callback_lock} intersect {} =3D {}.
>
>   sk->sk_prot: read by tcp_in_sockmap under sk_callback_lock; written by
>   sock_replace_proto (called from tcp_bpf_update_proto) with no lock.
>   Lockset intersection =3D {} intersect {sk_callback_lock} =3D {}.
>
> Could the synchronization be strengthened so both paths access both varia=
bles
> under the same lock?
>
> >       }
> >
> >       if (sk->sk_family =3D=3D AF_INET6) {
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/263285=
41814

