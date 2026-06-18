Return-Path: <netdev+bounces-300403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JnQPFArNM2rqGQYAu9opvQ
	(envelope-from <netdev+bounces-300403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:48:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E245E69F7E1
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:48:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DYvfibE6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300403-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300403-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA490307E689
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EACD3EE1E4;
	Thu, 18 Jun 2026 10:45:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B10D3E63BB
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 10:45:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779534; cv=pass; b=Ht+cp05xm1bs3eWz5lQhbZCxnM4XS5fDk6R/vM5eLrsU5bLY61yyDCh3EQCGp/bdkjA4dxZiuRe/1s5Qw/eEXb+yuSr7lQ6FUXLNvxfmUcaWIO9KmrvscyNjru0t/0DIdquEQw7zo/v0pA0UUdycUgxAv80UCps4EbKGeoBzk+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779534; c=relaxed/simple;
	bh=yeE5VZid+PR+8xO9WKfTDka5xDLbl39UJCqmBBiuLSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rna5lombEqCuWtkbhxgBzOMYzumrbCf/O/bpGanCZPjcu1Qer+OaZvPpbO3CHGtrgSElxM/D+QoAJ9DAOPbYrEvfJXNH9l0Us02JIY2Jy3WaK+LeeGv2N7mYuoWst+9+r1VovNn58u23GMKVil5J73sQVbAwvIzVlRwZc2TzJFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYvfibE6; arc=pass smtp.client-ip=209.85.128.179
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7dfe7712572so8107897b3.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 03:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781779531; cv=none;
        d=google.com; s=arc-20240605;
        b=XQdqZ786COPfGynMYcQRd52ghFEpLKKu6FQC9a2QrIsySie1p2yxdeOFtGcQ7gRsTQ
         ayggvrCkzaCqwfVA5Kza1dLQFAI3Hq/tLkeyZ6ugLwcxmiTLVsRhAyrb4HwdaPd2noEu
         OhZXYLR/0kjjGLR1+XrsJ4jLnUOakQ7kDWwiqewp1rQJ/s9v0oekLvH00SgUEH6qv4DJ
         G++IFSBRbTKaxDEYop6wBqM6R5xxhBsmvYM7+T2I1bLGHU++X2EyMY+JcV4RNsTHbSh9
         Ii1rRmldsoHAhObXsgRM24YOECmXVAKs9+tdoQogzJAsCZaLQqPsEMWryC8JpSX1OAm6
         fvew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IAX/QMZ2lNnCR4HEVf+9VfFWBfEVxUbspDlYV1+1z1k=;
        fh=Vcnvu+RCimF9CDJmMw2RoUhhBbfiYKEV5pTfzR5v6xw=;
        b=YXuvibKeDklS1LK7lBTewxVNZuJISvhCyw+FrOeG2PD0TQdc28YRCvpuESV7NSaP1u
         m2pEsj6Yf64CD+imnYt8HoxWdQ8H0ZXCe2rGobtewhw/h/y6XwqBvos/r1tGV74k2bWF
         fdpfshOVVSMZcnp5Rv9i5V4gRZ7+vEysjfMJikWb1Oa5Z2Jx+SFyIpoD99UklPf1188t
         wU9rIjM8rwk4utwSwr2UySoPgUGtgXbe4Bn1mm1W+FW6g2LLzqX+4lvU7Zk75+8IL9YG
         kyxUf5s6A1SGblazVukZkx6vfbntd4z+gsVh/rA8DOaO97gxiVh4M33G6ZzLE+0XIM3l
         v6tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781779531; x=1782384331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAX/QMZ2lNnCR4HEVf+9VfFWBfEVxUbspDlYV1+1z1k=;
        b=DYvfibE6iT3k3xxwapGSwjFKAh2mfqmxG+heGaSqRjX6FMW2Pb+vbJcb4+9ALQM0Fo
         vC1n7S2rJmq1Pji9je9fpoWUzDuukmz5jcNv1Z/200bju5dOj0B3EwBt7XED9LHRiVw9
         YB49oRBwK20jUDd2ofifnf3lKvhDaOxJbT174SMFCyHOBGHgx/w+T3o9TUB4GtjJl10b
         fsTYS3iKXbadciPl+Ee6626u75GmGKdTfLPJEY4duXt+TPB0PCifGc+TeQfExSjAk4Ve
         +tunLmy2LXDglMLwv6OU/DzqPuzJIz9UHPFsZ/ehfJyiaLL+ZTmhOrDX1vf10rHq9yW/
         XMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781779531; x=1782384331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IAX/QMZ2lNnCR4HEVf+9VfFWBfEVxUbspDlYV1+1z1k=;
        b=rIy0py67J8TA5fvixNodavw62aabi3KspaAz1xf/0r8ssJmrgonwT586kgdD22jCgW
         4dfx5o0GC33gYg5rLDtil74hDkToG1BBCo/1TYwGofFaDIESi+uq4YZCMUnb0Rb5pcBg
         HpgEfYUHVD1+UD5DBuMx+IHhYOrjr0bw75YWJDbzTfCFaCq36LzshvT9cpv/h4hSBCqC
         kS4fDwOUKNpj51ArLmHGP6h50M1qViwfspI82nmCZtq3QJO3Amm4CiSGUw69z54f7wAo
         u+l/fm6YHVYzJzp+6uGoaFQRmgrTv2TfHj3luMr9bF0H0/lnws3YpNiEP4bFQSGrw/ga
         IoJw==
X-Forwarded-Encrypted: i=1; AFNElJ+fYfxqPevZ5nuQpjC5sJE/D5wCJ/TE9m8sxDpDyCNlMVXhgd7tZaN6n0IVJXqV5iS1d4gfImQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR/TcOXscsEJZvI8ZnhE41JadCqcagC9bmdFxEsQEIUaIZIwWk
	LLp+C2FBZcYPkH+QyO4qkoxz3vF6tp7H4qo49yYOqaGyy8CvRYwD7f7xsxnTKP4ylKHqdFKr7/o
	iLcIA2GyhFMSEgK5FXmoypOkIalog1Lw=
X-Gm-Gg: AfdE7cmf9uF/QBaaaNn96LE4wBC68anxB453g5XC4qjBa0331ExrWZklChGUlaGDEn2
	pLbojgZRHSt5TTyGboZi9ZGEkf5iCD6kXF9hlwEa60DcckT4r9spNRkYNK22yZsqnExEjjH1in7
	mCtNcRplfUmcUMwK39T0ZDqBjX8/bur9NLxvkkZWyicgw3hM3iNd0jqut2z3uHIrd3/romvX+58
	5P3SqNiq2Czots0NCUaLC+K0b+fRf/3nnn/hQlByS8msfAiBbH3Uet9hH7vlq8aNg+tnM+5ML15
	yB3PUihS7NBDwcyfSxRwyaMHZI+hz+ALMv5GC5vp
X-Received: by 2002:a05:690c:b91:b0:7f8:7e6f:f543 with SMTP id
 00721157ae682-7ffc86c9549mr29850657b3.49.1781779531112; Thu, 18 Jun 2026
 03:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617093557.63880-3-sun.jian.kdev@gmail.com>
 <2dad9b5c184fa101d7cffa1d8f5eea5b5df60f53533d98c68175c9e3ec5ee6ac@mail.kernel.org>
 <CABFUUZFeh18OjQ6EhjD17ZwQKb1aiVNkYKv-hAkVGrHhPpjE4Q@mail.gmail.com> <ajOv_oOd1zInaW1b@mail.gmail.com>
In-Reply-To: <ajOv_oOd1zInaW1b@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 18 Jun 2026 18:45:18 +0800
X-Gm-Features: AVVi8Ceo2RL3_RfBhTUKCmC5sJSFyC9LIcZeW8zb5WpwBtQh_A6J58Lq3pCapyk
Message-ID: <CABFUUZHCr=4kb7kSaaPGpc4nkyn32i-svD9v7ONF+TYrrQ-xaQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Cover partial copy of
 non-linear test_run output
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, toke@redhat.com, 
	lorenzo@kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:paul.chaignon@gmail.com,m:bot+bpf-ci@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:toke@redhat.com,m:lorenzo@kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:paulchaignon@gmail.com,m:bot@kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-300403-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,google.com,redhat.com,fomichev.me,meta.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernelnewbies.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E245E69F7E1

On Thu, Jun 18, 2026 at 4:44=E2=80=AFPM Paul Chaignon <paul.chaignon@gmail.=
com> wrote:
>
> On Wed, Jun 17, 2026 at 10:19:52PM +0800, sun jian wrote:
> > On Wed, Jun 17, 2026 at 6:31=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
> > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c=
 b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > > > index 01f1d1b6715a..9cc898e6a9f7 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > > > @@ -4,6 +4,10 @@
> > > >
> > > >  #include "test_pkt_access.skel.h"
> > > >
> > > > +#define NONLINEAR_PKT_LEN 9000
> > > > +#define NONLINEAR_LINEAR_DATA_LEN 64
> > > > +#define SHORT_OUT_LEN 100
> > > > +
> > >
> > > [ ... ]
> > >
> > > > @@ -20,6 +24,69 @@ static void check_run_cnt(int prog_fd, __u64 run=
_cnt)
> > > >             "incorrect number of repetitions, want %llu have %llu\n=
", run_cnt, info.run_cnt);
> > > >  }
> > > >
> > > > +static void init_pkt(__u8 *pkt, size_t len)
> > > > +{
> > > > +     size_t i;
> > > > +
> > > > +     for (i =3D 0; i < len; i++)
> > > > +             pkt[i] =3D i & 0xff;
> > > > +}
> > >
> > > A question was raised on v2 about whether pkt_v4 could be reused by
> > > reducing the linear area to ETH_HLEN, rather than introducing a custo=
m
> > > init_pkt() with a 9000-byte stack packet.
> > >
> > > Can't we reuse pkt_v4 here by reducing the linear area to ETH_HLEN?
> > > The v3 still adds init_pkt() and the NONLINEAR_PKT_LEN packet, so thi=
s
> > > doesn't seem to have been picked up.
> > >
> > > > +
> > > > +static void test_skb_nonlinear_data_out_partial(struct test_pkt_ac=
cess *skel)
> > > > +{
> > > > +     LIBBPF_OPTS(bpf_test_run_opts, topts);
> > > > +     __u8 pkt[NONLINEAR_PKT_LEN];
> > > > +     __u8 out[SHORT_OUT_LEN];
> > > > +     struct __sk_buff skb =3D {};
> > > > +     int prog_fd, err;
> > > > +
> > > > +     init_pkt(pkt, sizeof(pkt));
> > > > +
> > > > +     skb.data_end =3D NONLINEAR_LINEAR_DATA_LEN;
> > > > +
> > > > +     topts.data_in =3D pkt;
> > > > +     topts.data_size_in =3D sizeof(pkt);
> > > > +     topts.data_out =3D out;
> > > > +     topts.data_size_out =3D sizeof(out);
> > > > +     topts.ctx_in =3D &skb;
> > > > +     topts.ctx_size_in =3D sizeof(skb);
> > > > +
> > > > +     prog_fd =3D bpf_program__fd(skel->progs.tc_pass_prog);
> > >
> > > [ ... ]
> > >
> > > > diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/=
tools/testing/selftests/bpf/progs/test_pkt_access.c
> > > > index bce7173152c6..cd284401eebd 100644
> > > > --- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
> > > > +++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
> > > > @@ -150,3 +150,15 @@ int test_pkt_access(struct __sk_buff *skb)
> > > >
> > > >       return TC_ACT_UNSPEC;
> > > >  }
> > > > +
> > > > +SEC("tc")
> > > > +int tc_pass_prog(struct __sk_buff *skb)
> > > > +{
> > > > +     return TC_ACT_OK;
> > > > +}
> > > > +
> > > > +SEC("xdp.frags")
> > > > +int xdp_frags_pass_prog(struct xdp_md *ctx)
> > > > +{
> > > > +     return XDP_PASS;
> > > > +}
> > >
> > > A related suggestion on v2 was that, once pkt_v4 is reused, the exist=
ing
> > > BPF program could be reused instead of adding new pass-through progra=
ms.
> > >
> > > Could tc_pass_prog and xdp_frags_pass_prog be dropped in favour of th=
e
> > > existing program? The v3 still adds both of these, so this point also
> > > seems to be open.
> > >
> > >
> > > ---
> > > AI reviewed your patch. Please fix the bug or email reply why it's no=
t a bug.
> > > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/R=
EADME.md
> > >
> > > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27=
680511802
> >
> > Hi,
> >
> > Thanks for checking this.
>
> Hi Sun Jian,
>
> It would help if you could reply inline instead of at the end of the
> messages, especially when there are multiple comments. See [1] for an
> explanation of how that works.
>
> 1: https://kernelnewbies.org/FirstKernelPatch#Responding_inline

Acknowledged, I will reply inline.

>
> >
> > I tried reusing pkt_v4 and the existing TC program, but they do not fit
> > the skb case this test is trying to cover.
> >
> > For skb test_run, IPv4/IPv6 inputs with a too-short L3 header in the
> > linear area are rejected before bpf_test_finish(). With pkt_v4 and a
> > linear area of ETH_HLEN, the test fails with -EINVAL before reaching th=
e
> > partial copy-out path. If the linear area is increased enough to pass t=
he
> > IPv4 check, pkt_v4 is too small to both trigger the old
> > copy_size - frag_size path and verify that the copied prefix spans the
> > linear data and the first fragment. pkt_v6 has the same issue: after
> > making the IPv6 header linear, only 20 bytes remain in frags.
> >
> > The existing test_pkt_access program has its own packet-access coverage
> > goals and is not just a pass-through carrier. With such a short linear
> > area or small packet fixture, it can fail before the test hits the
> > bpf_test_finish()'s partial copy-out path. A pass-through TC program is
> > therefore a better fit, because it keeps the test focused on the
> > bpf_test_finish() copy-out semantics.
>
> If we're keeping tc_pass_prog() then can't we use pkt_v4 and get rid of
> init_pkt?
>

pkt_v4 is too small to construct a meaningful nonlinear skb with a stable
linear/frag split while still exercising the partial copy-out boundary in
bpf_test_finish().

With pkt_v4, we either do not reach a fragmented layout, or lose control ov=
er
the linear/frag boundary needed to exercise the regression path.

This test uses a 9000B packet so it does not depend on small-packet
allocation details. Smaller packets might work depending on allocation
state, but 9000B reliably gives us a non-linear skb with page frags and a
stable linear/frag boundary for the copy-out regression.

init_pkt() is needed to ensure deterministic byte content across both linea=
r
and fragmented regions so that the memcmp-based validation is stable.

Thanks,
Sun Jian


> >
> > For XDP, this object does not have an existing xdp.frags pass-through
> > program, so the small XDP frags program is needed to cover the other
> > caller of the shared bpf_test_finish() path.
> >
> > Thanks,
> > Sun Jian

