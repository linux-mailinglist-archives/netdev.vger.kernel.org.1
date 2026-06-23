Return-Path: <netdev+bounces-301487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GUXQEjfwOmrsMAgAu9opvQ
	(envelope-from <netdev+bounces-301487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:44:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B826BA160
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:44:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=iu8OA32U;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301487-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301487-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDF6C303779B
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101AA3A7F73;
	Tue, 23 Jun 2026 20:44:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987863955EC
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 20:44:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247475; cv=pass; b=IO1GcPbv2hW8a9rxKRLXQ1y9DCyG9i9ncNfKKjeCHE0pO5DBgzF64Wqb4xbolTyiLdnZNSjfRtvWB2siPrH2zvUxsZOUzbaPJgAYZixrKz7deXqdSZgGGGD9qiqYJguT/M7lRaKkaUWlLIbsJNE955oDpvxkZrr+SpjxdaRtlaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247475; c=relaxed/simple;
	bh=peQMGgivtWX/4yVotHO3GauRipRZ55KBtEzx7s7Df+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYzC4vGTcrudKlelVTgG3OcQxCnNb7i3CgSiE1Svj5fmRT/T+jGPeYp/33lE+4SI/Qv5gRUXLGUuM6ahNU+r5ukArHiIbWpR3k7DujaHE0U8iXAOdRZKnUxhoKIkHRi5V4vf9BYI7HumOwZoEK7Z5ZMpX7tC85VrIn67SIqO5Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iu8OA32U; arc=pass smtp.client-ip=74.125.224.54
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6607048fa62so256509d50.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 13:44:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782247474; cv=none;
        d=google.com; s=arc-20240605;
        b=O+K2z0IbV/uaccIKfSXjqzia3Wr1Apmk0kr/cG5BNvdwIgINzWKBXe+SsR/5d0+pAN
         Lj5k0xPqF7hutlxnHURirafGlfg3aNGuLj6ydZnHdbXSpamIJB1MOOOq129Z0DXu3Zbc
         yWyw3vlKhbcOHHpI+3lQCQix5K0jGsMOdw9yA+iKmnT4+OFhZ2KjTbVQt56efl++E0tT
         +ssmvMHSjFNCPCHQJ/a8d+KtHhKaXC5S/wC0nxzQL8WAuN0Bn8fxNTaxjCohMOOwFGf/
         S5la1JDy0cTWYtqL/UMlIHyarNO8kEohd+BgC3tNkGGskVlfBuX6yhni/6PO7z+deTHZ
         xgJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j3bx0vWlQbek/bc5PVktDuuMBd9L/up5ejzVscDCOsg=;
        fh=Bj4ZQVKHKmXTaxVerx1wJaj/1XX6AmGxWnF4Tnmp2SY=;
        b=WzHK0E3d00ZHSb644KkdvXtj6PoHN/XlXT83Zao7CSZ75oEE7xtuH8/0NXrTf6tA3Z
         ed/dAsGXBWoND7XauJECNNRjHbukkA/OwHqDbMtZ4obvNpYDfx4rdi/ZQBA0Q3mjGw6k
         fHoxywc+jVXwgXmpeq+q1C874anOysI8DQwTJ55fwvBrwEURCZ1nsS0PIYSkdEzw01Bp
         7FRxRgRpztHbOd5VxIP1u5G5I1+MiIeAhuAwRa3RfHZ0jUZXTDxYgXFYWcH+cvSCQTBb
         +FYDjav5fg9Q790IECy5+R7qNNzmw6upebIV/wseQgdIrgMTSaXq6hK6lC2keABMWQdV
         b6zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782247474; x=1782852274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3bx0vWlQbek/bc5PVktDuuMBd9L/up5ejzVscDCOsg=;
        b=iu8OA32Ulo03e8JuuU/JQQM5HF+BSQ41TkCC5YqfU9w72BHGRUsW6EEdUzrCw9l+na
         FC2lITv2vmbwrdt8gPrZ4sZwkdmlRzAftvJ+Oe2JslKeUVDw5L4QNjUs/FuhaMje49GC
         HzjbfjLIbeIHNVfuVEPHaePAcz3KWIJ9FqKxl9jcwEvXSvWGruH8JsdzJziDwUGm804H
         /YJzd7nG0d/m9wnIfOhk9yO52jBo4m22Ke/DAqYo4XxgDC1vv5ZEtzFVJMhZPNt3gyLf
         xJYkVvQY5fMUL9g4YQ107Q6f0dZvqh4q6zmSsTO+q5Tx4Ka+2KjU0+1c2V50RpVLaXOY
         32EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782247474; x=1782852274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j3bx0vWlQbek/bc5PVktDuuMBd9L/up5ejzVscDCOsg=;
        b=rSULFJDPxx+sCZ1GyA/ig+2PY26nLfPdkmKfoXZijwOhDDG5Gn8lJ8dKbrSGzBGfyy
         rEQYaPivF0JP9+Y4iVwtFgATkh3Lh7Nhpj93aSE16CMw5C7gdEHHPlxIIOFaymBIZ5Zh
         gZewZL8XR0Vcsl1b5+fjWoB7+acS0MJKF9Y1CUrgeOrJozQrFoorQxyrvKjIeLrSNkxS
         YtdZhOgpQOJBIxJGsSJhr+16mugG40+JAV76XuVdJZeY8GsMwnG/oXnbfR/dEkiRLXFz
         CbZ1XuNOrxkXaFC9Wp+xhv3+tM520kbaO39lxnZFMs4kesCLLCeeqs9GDFx2daDJZ90z
         wLug==
X-Forwarded-Encrypted: i=1; AHgh+Ro6F1ffjI2K1O9M4OTwV1AK3HfBEv1Jgl4LGInF0B09ETauw2L+XWeSlMD6WyYtx6uIyfowd6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDyR+9GKWlx8pytH0vGDBnOlhxtRpNdlaH/qY8D/Ea1EEH+3Uj
	8lp1Ijj0+7Iakatj9KP0vFu+5LsH6qMRYgSEXly/5s23mLA1zvbrJ0fPpcgw+7tpZdZENW9j27J
	Jo9SutWxjCpz3czIdcIGs0ec+1dXcOF0=
X-Gm-Gg: AfdE7cm8m+w9Q5CrV4rhwfBqwG1pNXd6AJbrdIvKOPKt887IEv+NwWlWx7XG7mLD5E+
	5C4zrl0leQhN0Ymq322QlotMyuJO6E4TPKJIhuynhibgbbPoJvUnnnf72hPWGUk0QPFyby0b9ww
	IdxVnlTHBCCOVH4Uk6maUKNoRbgvCHqF7iH+eX9K16HZFGdn/wjo4NP6idw7Z44hDxwmPtezxXg
	eCMv17XMWqwSrCyhVtFGps5J/omWv4ml5icaxLl1TNMhbfkQDnjkFcFv0y9qEgBCotcYfvnM6xM
	L6xrzfgJxo1I
X-Received: by 2002:a05:690e:c48:b0:656:7cd:98e4 with SMTP id
 956f58d0204a3-66312db7cdcmr17211421d50.16.1782247473557; Tue, 23 Jun 2026
 13:44:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
 <CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
 <87v7b9ysep.fsf@cloudflare.com> <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
 <CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com>
 <87mrwlyqg4.fsf@cloudflare.com> <CAMB2axMVhJJpP5HZtDFyQLLbKoRxhW08rj1zGRtWtgDkfYaVNA@mail.gmail.com>
 <878q85yoy5.fsf@cloudflare.com>
In-Reply-To: <878q85yoy5.fsf@cloudflare.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 23 Jun 2026 13:44:19 -0700
X-Gm-Features: AVVi8CdfYEJbDpqhuNcrMZV5JVqWgKLR48l5Cm88ZUU8sCsFzlJtBSm5UT1qE5Q
Message-ID: <CAMB2axOGX+t=pTVf4X+QmeHMfgV7CJ5FG6gUca=XMdfrnhe6aA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301487-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,cloudflare.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jakub@cloudflare.com,m:alexei.starovoitov@gmail.com,m:kuniyu@google.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:jiayuan.chen@linux.dev,m:john.fastabend@gmail.com,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:alexeistarovoitov@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2B826BA160

On Tue, Jun 23, 2026 at 1:36=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Tue, Jun 23, 2026 at 01:22 PM -07, Amery Hung wrote:
> > On Tue, Jun 23, 2026 at 1:04=E2=80=AFPM Jakub Sitnicki <jakub@cloudflar=
e.com> wrote:
> >>
> >> On Tue, Jun 23, 2026 at 12:33 PM -07, Alexei Starovoitov wrote:
> >> > On Tue, Jun 23, 2026 at 12:31=E2=80=AFPM Kuniyuki Iwashima <kuniyu@g=
oogle.com> wrote:
> >> >>
> >> >> On Tue, Jun 23, 2026 at 12:21=E2=80=AFPM Jakub Sitnicki <jakub@clou=
dflare.com> wrote:
> >> >> >
> >> >> > On Tue, Jun 23, 2026 at 09:08 AM -07, Kuniyuki Iwashima wrote:
> >> >> > > On Tue, Jun 23, 2026 at 4:20=E2=80=AFAM Jakub Sitnicki <jakub@c=
loudflare.com> wrote:
> >> >> > >>
> >> >> > >> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MS=
G. When
> >> >> > >> completed all code paths related to sockmap-based redirects sh=
ould be
> >> >> > >> guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt o=
ut by
> >> >> > >> disabling NET_SOCK_MSG. The implementation of sockmap as a con=
tainer for
> >> >> > >> socket references would remain under BPF_SYSCALL.
> >> >> > >>
> >> >> > >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> >> >> > >> ---
> >> >> > >> Changes in v2:
> >> >> > >> - Handle prot->recvmsg being NULL (Sashiko)
> >> >> > >> - Elaborate on the end goal in description
> >> >> > >> - Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-spl=
it-unix-v1-1-d7e0cb7bb03b@cloudflare.com
> >> >> > >> ---
> >> >> > >>  net/unix/af_unix.c  | 4 ++--
> >> >> > >>  net/unix/unix_bpf.c | 6 ++++++
> >> >> > >>  2 files changed, 8 insertions(+), 2 deletions(-)
> >> >> > >>
> >> >> > >> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> >> >> > >> index f7a9d55eee8a..84c11c60c75f 100644
> >> >> > >> --- a/net/unix/af_unix.c
> >> >> > >> +++ b/net/unix/af_unix.c
> >> >> > >> @@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct soc=
ket *sock, struct msghdr *msg, size_t si
> >> >> > >>  #ifdef CONFIG_BPF_SYSCALL
> >> >> > >>         const struct proto *prot =3D READ_ONCE(sk->sk_prot);
> >> >> > >>
> >> >> > >> -       if (prot !=3D &unix_dgram_proto)
> >> >> > >> +       if (prot->recvmsg)
> >> >> > >
> >> >> > > There is no reason to have this dead branch when
> >> >> > > CONFIG_BPF_SYSCALL && !NET_SOCK_MSG.
> >> >> > >
> >> >> > > Let's compile out all sockmap code when both configs
> >> >> > > are not enabled.
> >> >> > >
> >> >> > > Since AF_UNIX differs from TCP/UDP, it can take the
> >> >> > > simpler approach.
> >> >> >
> >> >> > Okay, will put the whole file behind hidden config option like so=
:
> >> >> >
> >> >> > --- a/net/unix/Kconfig
> >> >> > +++ b/net/unix/Kconfig
> >> >> > @@ -30,3 +30,8 @@ config UNIX_DIAG
> >> >> >         help
> >> >> >           Support for UNIX socket monitoring interface used by th=
e ss tool.
> >> >> >           If unsure, say Y.
> >> >> > +
> >> >> > +config UNIX_BPF
> >> >>
> >> >> Maybe UNIX_BPF_SOCKMAP or something.
> >> >> bpf_iter is supported without this config.
> >> >
> >> > I don't like where it's going.
> >> > I strongly dislike new config knobs.
> >> > I'd rather remove existing knobs.
> >> > What is the motivation?
> >>
> >> The goal is to compile out sockmap bits that use sk_msg.
> >> NET_SOCK_MSG is natural, exisiting candidate.
> >> New knob wasn't my idea.
> >
> > I'm also missing the big picture here.
> >
> > sockmap already holds socket references today. You can store and look
> > up sockets without attaching any verdict/parser program, and no
> > redirect happens. So if the goal is to use sockmap purely as a socket
> > container without the sk_msg fast-path overhead, what does a
> > compile-time NET_SOCK_MSG knob add over the runtime checks?
>
> Sure, let me clarify. It's about the maintenance overhead.
>
> sockmap-based redirects are a rather niche feature with few users, for
> which we've been getting quite a few bug reports since AI came along.
>
> We're not using it internally at Cloudflare, so I don't really have a
> good reason to justify time spent on these bug reports.
>
> Hence the move to put sockmap-based redirect behind a config option,
> which you can enable at your own risk. Or which we can deprecate, but
> that's not really my call.
>
> > I am also not sure if NET_SOCK_MSG is right. It is broader than
> > "sockmap redirect". It is selected by TLS and {INET,INET6}_ESPINTCP.
> > Because those select it, it can't be toggled independently.
>
> Once the sockmap redirect bits are behind _some_ config option, it will
> be easy to replace it with a more granular one that depends on
> NET_SOCK_MSG. But we're not there yet. One step at a time.
>
> > Could you share the concrete use case you have in mind, and whether
> > this came out of an earlier discussion or thread upstream?
>
> This is a follow up from discussions at BPF summit with Alexei & John.

I see. Thanks for explaining the motivation.

