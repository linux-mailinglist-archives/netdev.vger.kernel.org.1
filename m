Return-Path: <netdev+bounces-301476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a5FHISDrOmq3LQgAu9opvQ
	(envelope-from <netdev+bounces-301476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:22:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9F66B9F40
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:22:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qQcXQ22h;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301476-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301476-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CF2830166C2
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F87A396B76;
	Tue, 23 Jun 2026 20:22:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB89F35DA7B
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 20:22:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246174; cv=pass; b=AYNcgv9ceCj+SU9bKdSnkVqkeEE+8sKHdeWTr5OaCbx0u2cGtf/lG4zSaYEJZdzaSBREyUSjE0ZEevpMPrkXv97z8NYWkwOo9yud/xBrwZ7ZvoKFAnEobH+9P0NwPazEu8y+/XKsYUfzRy2NZuFrLOVyeNDPcgAvqjFk09rpeek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246174; c=relaxed/simple;
	bh=0MzRaeA3gAz8QYO7u/KFgEphT3lY2mqcohRfwTGlkDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trOBYr1DcmNVGn8BWEOb+BpGkHZlNFcAXFtu4j38sEY+8zVwQCqeEoSkaNc7KumUwRRuZhYVQHtrpX6dnhVtdYHkiJ2KTjYz4kThsCEs3FvIIrvPBaATB8PseNj2eoqVQP3ec+UGU/f70lB4bSoDRRUiGmDD5K73jRcUI90P9IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQcXQ22h; arc=pass smtp.client-ip=74.125.224.42
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-662df6a4fe4so324355d50.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 13:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782246172; cv=none;
        d=google.com; s=arc-20240605;
        b=KNMiG/Mv8LqHD/K1Du1FpZZBs+dLIiiqWM9c/ZKnWgtkMzfGYFe+1q36C8WGy+YFbw
         eBPG4G1tWrbsNvNGRf1ERN7f1iOvasqXFV1Yre/EjORLFsk/RTFbtmaDlAgVaA+oMUTf
         hG1H/qN/E3UW5ZvCbqSuawGOZVvxSiUBrziD68A4QOFxUAk8AMdPGNXzFBTsAi5Su3EF
         B/sW7oAC3ESAnOKjfFMKNKs6T3Z+qLTHRv6468L1ks1DpBn/ATdm/MpzlrKQkZENeMht
         d4EoITlQxnU19h3/CNZjqWLXxkE6jAUVeX0YSo70eMP01AJylakfhNLSJSkusdD4wg4l
         j11w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z+qPE3ZLfrrjwShyrsUwND+Pow1Vtpy5cQfWnnfwlCg=;
        fh=ISHtsMqry0DG1HuBQfejN+LTkBt130/68/NRa+dx39Q=;
        b=FjrOiMvfa+wbbzMhyTU7r4wKLOaDdZup3cpMwb4GyfgjrHse1RXgNRednHbqXYWvUY
         W/cM+/Dqr+WUvOlMUYEOcASLmk+VTliXrAq5nZTp2HTmj9gN+aLvZ7qz44qyDpx+ulru
         Dexk9xxJ+WnypkGkdcznuEBnSThtFT7/sW4W4vzpJADa9Bqn4jijEoRnzAB1M6MYkZCS
         Rb7pOz9WI3cZBOcppy86jFzdJMmKxkzEvhujxnF+D8d25l1wWWgHEL2oZkMgwTGQ+JMq
         vIuCZBtokochsu6eR4p4QQPl/6Pd1iSY+4eZbYFzSWwzsRL9d2rE/XPtcg13+WjKmTmb
         WdWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782246172; x=1782850972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+qPE3ZLfrrjwShyrsUwND+Pow1Vtpy5cQfWnnfwlCg=;
        b=qQcXQ22hWZJ7F1UQ0BH1Y4R3nZB9kSEsDq1gYLUJY3CnNPM6fh8iBqcE6Fe+ML9rmu
         4XalIbl6IOtY+dcwIwRAHAlNr4sB2I05SAelm8LDqhUwNIbiGkIOaEHcujNV4wdwZhxt
         WW48KOrE/BygQcLIF0MpXlDA63r0AR8Vi1RN8KGUS+9R67kF8JazwpVBzK/mMzXstFLG
         hxHjYEem1d8H/Ur0glQuTo/NO+s4VP1hHq3pSgBWeL8Tj656SfXobPgjICd4ScBYCUr3
         NBRrdRGAI/azHHTpmaQ02Ikprqg6Vc985/XzGvXuEDRX+9IpAqwSu6XVd9IhXDVL8xdq
         g3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782246172; x=1782850972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z+qPE3ZLfrrjwShyrsUwND+Pow1Vtpy5cQfWnnfwlCg=;
        b=FlIPl7zEigZ4i4glrNDT775HwczStrp7J34SkgvxxP0vxFr+2zA/GJ3BWsMOOhqTxo
         9Wl8VFTPewU05iZ3N6TS5KURDr6w6wkTWKmu5zYYqFlXZM7h0ImgYZ/gNaaYHVxamFCD
         bKGZIM+/gUcuVQn9YtDqMHxhGmXp0/PPcqS01Z56WbYoyJz/buHm/89OZGP6e1SOOdZB
         g/8oXT24Umskj6g0wW2BzaujrdWrh8SoFWRbOLpCH4dXFfh7XR+nkYdbArFMzFYAT4Hd
         8AjePkPAtuAhnBSgmDZbJWWRP5K8gq0LjDT6iGcnRL2Vuvf28np+ymC0nOCiFxRV9a6x
         mGiw==
X-Forwarded-Encrypted: i=1; AHgh+RqoVs3F3irSNl/1VJf16TG2Y5xlGfe6av4PQIksXhGNckWs46K+XwM/t2vCoJC+YYXI0HmsSZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpYGz3XFm5Z6yBpjL2KcYnRNJjmtIOmoHzVzAiJyIONPme7Pw0
	57A52O5FXJ7o7mu4DbW9r9QV4CRnvoCGd3EAbFvTZagVJvgQJZSQycvqxPmUqwMiWPd1GSwR4+I
	hQtVHkaC/VgpfDQyjDR09TYHZ2roF3s8=
X-Gm-Gg: AfdE7cmAJzMEHWTSHBIyIP2HhcoScIXMR3iH1WBBvS2sBj2ijM6NFeOrQ84sAA91swW
	1pxlrAq/G4sADPFEnU8FPSrIl0NED+G8IOQKeELSD1dpVTjzNCGV9QGl/wrMHwyCl4dUT9818+U
	HaaJYLZk59VQqZO6GlG2LQDhBQnj+91pgW7orHy6DLXphFFHi/b8XKcWAd3a+34JdlCLqcXWf/y
	dPuxsPfGT8u250UzrSy/pUTAND115uPHd3pZs0+glreKDmNVyemEtmf9h4bRUsfb0iMC7B0Vi4p
	lnB+rnFerJS+
X-Received: by 2002:a05:690e:1685:b0:661:1669:b784 with SMTP id
 956f58d0204a3-66359e1b367mr4192169d50.10.1782246171839; Tue, 23 Jun 2026
 13:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
 <CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
 <87v7b9ysep.fsf@cloudflare.com> <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
 <CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com> <87mrwlyqg4.fsf@cloudflare.com>
In-Reply-To: <87mrwlyqg4.fsf@cloudflare.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 23 Jun 2026 13:22:38 -0700
X-Gm-Features: AVVi8Cc_kvY2-hiFq-rqmW8Jf1KhrQ23ATZsBbzS0ewBwc43J2MEhRPb9SEpfFU
Message-ID: <CAMB2axMVhJJpP5HZtDFyQLLbKoRxhW08rj1zGRtWtgDkfYaVNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code behind CONFIG_NET_SOCK_MSG
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301476-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jakub@cloudflare.com,m:alexei.starovoitov@gmail.com,m:kuniyu@google.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:jiayuan.chen@linux.dev,m:john.fastabend@gmail.com,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:alexeistarovoitov@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,cloudflare.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,cloudflare.com:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF9F66B9F40

On Tue, Jun 23, 2026 at 1:04=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Tue, Jun 23, 2026 at 12:33 PM -07, Alexei Starovoitov wrote:
> > On Tue, Jun 23, 2026 at 12:31=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goog=
le.com> wrote:
> >>
> >> On Tue, Jun 23, 2026 at 12:21=E2=80=AFPM Jakub Sitnicki <jakub@cloudfl=
are.com> wrote:
> >> >
> >> > On Tue, Jun 23, 2026 at 09:08 AM -07, Kuniyuki Iwashima wrote:
> >> > > On Tue, Jun 23, 2026 at 4:20=E2=80=AFAM Jakub Sitnicki <jakub@clou=
dflare.com> wrote:
> >> > >>
> >> > >> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG. =
When
> >> > >> completed all code paths related to sockmap-based redirects shoul=
d be
> >> > >> guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt out =
by
> >> > >> disabling NET_SOCK_MSG. The implementation of sockmap as a contai=
ner for
> >> > >> socket references would remain under BPF_SYSCALL.
> >> > >>
> >> > >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> >> > >> ---
> >> > >> Changes in v2:
> >> > >> - Handle prot->recvmsg being NULL (Sashiko)
> >> > >> - Elaborate on the end goal in description
> >> > >> - Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-split-=
unix-v1-1-d7e0cb7bb03b@cloudflare.com
> >> > >> ---
> >> > >>  net/unix/af_unix.c  | 4 ++--
> >> > >>  net/unix/unix_bpf.c | 6 ++++++
> >> > >>  2 files changed, 8 insertions(+), 2 deletions(-)
> >> > >>
> >> > >> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> >> > >> index f7a9d55eee8a..84c11c60c75f 100644
> >> > >> --- a/net/unix/af_unix.c
> >> > >> +++ b/net/unix/af_unix.c
> >> > >> @@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct socket=
 *sock, struct msghdr *msg, size_t si
> >> > >>  #ifdef CONFIG_BPF_SYSCALL
> >> > >>         const struct proto *prot =3D READ_ONCE(sk->sk_prot);
> >> > >>
> >> > >> -       if (prot !=3D &unix_dgram_proto)
> >> > >> +       if (prot->recvmsg)
> >> > >
> >> > > There is no reason to have this dead branch when
> >> > > CONFIG_BPF_SYSCALL && !NET_SOCK_MSG.
> >> > >
> >> > > Let's compile out all sockmap code when both configs
> >> > > are not enabled.
> >> > >
> >> > > Since AF_UNIX differs from TCP/UDP, it can take the
> >> > > simpler approach.
> >> >
> >> > Okay, will put the whole file behind hidden config option like so:
> >> >
> >> > --- a/net/unix/Kconfig
> >> > +++ b/net/unix/Kconfig
> >> > @@ -30,3 +30,8 @@ config UNIX_DIAG
> >> >         help
> >> >           Support for UNIX socket monitoring interface used by the s=
s tool.
> >> >           If unsure, say Y.
> >> > +
> >> > +config UNIX_BPF
> >>
> >> Maybe UNIX_BPF_SOCKMAP or something.
> >> bpf_iter is supported without this config.
> >
> > I don't like where it's going.
> > I strongly dislike new config knobs.
> > I'd rather remove existing knobs.
> > What is the motivation?
>
> The goal is to compile out sockmap bits that use sk_msg.
> NET_SOCK_MSG is natural, exisiting candidate.
> New knob wasn't my idea.

I'm also missing the big picture here.

sockmap already holds socket references today. You can store and look
up sockets without attaching any verdict/parser program, and no
redirect happens. So if the goal is to use sockmap purely as a socket
container without the sk_msg fast-path overhead, what does a
compile-time NET_SOCK_MSG knob add over the runtime checks?

I am also not sure if NET_SOCK_MSG is right. It is broader than
"sockmap redirect". It is selected by TLS and {INET,INET6}_ESPINTCP.
Because those select it, it can't be toggled independently.

Could you share the concrete use case you have in mind, and whether
this came out of an earlier discussion or thread upstream?

>
> Alternatively, we can do this to avoid the extra knob:
>
> ifdef CONFIG_BPF_SYSCALL
> unix-$(CONFIG_NET_SOCK_MSG) +=3D unix_bpf.o
> endif
>

