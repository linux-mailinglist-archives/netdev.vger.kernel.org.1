Return-Path: <netdev+bounces-299175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jGOiA9hZLmoouAQAu9opvQ
	(envelope-from <netdev+bounces-299175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:35:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F01B680923
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:35:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CZNTexmB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299175-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299175-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CB96300797E
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02606314B8F;
	Sun, 14 Jun 2026 07:35:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C040D573
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 07:35:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781422548; cv=pass; b=MuLLCpNj7G/WF722Tm2lyXM9ZwKRsyzjUM+c/8DUpVKvctoKwbqyioN0E1qhta7W6pKOzOvYk3O4q2zR/uo+wjwtXxuLilirN6BHZGalkwxFoXHkYfzmyHjKPS7/GuIEa01P06aSyF20QZOvqWEW52ACYuHbBHrVj7PDxqBGLCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781422548; c=relaxed/simple;
	bh=jt9vfiaXpX9Ce0DF2iU5CYaSj0yXd2dYdT7MYev5Vs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmHogpi+ZBbXi3dzoGVXy1rRp76Y6pQ1YYRCaxBNx/5+ZNIMgcy/WPjGCw+yTje0AXSL4rC3/lk6oi8JHaiOppUWu8stVmEdUVxzve3WPmksZWq40Z4VBkejWK9O9ZOg7rKQ0BM2knjSOKem9PIWAQWdlycPXo7M+Kz0LkVbseE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZNTexmB; arc=pass smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4908b92904fso27194465e9.0
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781422546; cv=none;
        d=google.com; s=arc-20240605;
        b=DAeECQb17geH6yB1rBJ54KG/g2k3BiBVXAmOFkbaKcHEMJ9+2ivxKun0ACHE7NluSu
         +VQ0Pfg5Bi0ejvN99ktiN4mutIpTvwECbrQ3ttlJZXQbENrlvnkCcVunPl5BGzzC9q36
         lp8F2a9yHP6JIFAYEHuTqi9yns6SQTC8sdfXWU+A4O+Vggkgb2Jk24HlvrCTPIRtchk9
         cJ/9HFhh4aKoddJJSphkgJJpskupL9EzDbkpJtJAhiZDznyod+ACHQn+naMweDEMf0k/
         DyLuXLNX9aJ5ex1SdNsvJJ5tIWywkM8LGZmXDEDzxC0LuVTw3B94IoHvRiagFi6ohlOB
         vb3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G+kn/95nppQ4V0BrtS5dxP/rcmqLU2CIc2jCMr5ukIo=;
        fh=BONuwCb1j+pooUR4sNDe7wPxs4L5/vsct5XX6DRhDTU=;
        b=cn/h5s2sl5MiCnT8S2Sd8YC8VbCUwcZXR4s+WBpXvatdGQeasTgp/CzRZEgZEAzdXV
         5rBUEYUGMTXrS/7XqCQAqmUiwYgCevOeWPpcicDF1OdbRBwyPdU/eHS8D4Yo5njNOfwa
         DYJ+otKJ8Ead7i/dhJ2M5gSfZYkKyVeKDtD7RjtPh3lrdEV0Ja4vcdQCEo13wJ48WUDb
         zVDDTa8jrRohPN+XRj8kscgjCuz+Dj1yq7VUEEVyLMtghTYCCgOQiyA5aB+5cEWhqg0r
         aJK9AoCYnc3Qi2D1bVjx96opov8vqpR9AyzahnsdpmOFq3tFIV1NlS0ChE1X7yvA8RDF
         d7Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781422546; x=1782027346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+kn/95nppQ4V0BrtS5dxP/rcmqLU2CIc2jCMr5ukIo=;
        b=CZNTexmB+rYB6icWofn1xIyuUHlKAaWKCnsviw/rZ7rZUDBUxySstVxuwPx4TObStd
         U5iXyRBrfZRDQS9DXZfwiWVhxq5+oj++T2ECvMS15sbl3O6UXWC25bmyk76bEU5/kvT+
         DhEdbR2jQG+0rnSGluM5Mjg4qujgNlw35OdIgQsn+5FOhIgEQkrtbZSLPW1cO6fay6By
         rkvQjqOgANLzOGmxSvr10VZZlMxbkoSw4hTdas7B900WhfIAmMKpfBCztEr4XsAkopAA
         aJAoxtFP/kJPUcPdqjMaQJAjMUWDN1+g2SqR68PMwqTNrqcemRDA8Twc0dRgAVchcpTW
         5mGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781422546; x=1782027346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G+kn/95nppQ4V0BrtS5dxP/rcmqLU2CIc2jCMr5ukIo=;
        b=ThbHvWRBsXnT15WNW3fv9OV0PqHBA1C5EtVicCAR56ZYnKJmxK0YsWYqvzJ4DJjsGQ
         QsA11vWy+XXpDWT11ERc/97KL8PnfNMrbzWH8yCa61ljdG4eugEOH6v0cfXc7+OmsS4/
         jQeqpTnJ3MeqwUAH9ZKRuJO+WFjxPuIsOxx/4p8W4xPYvuvdQr47c1QiY/uDNxfcweSs
         WqICvQr75vXhZP19OPBofSKwkmhrNDjBzGWKLAZD9ojCdNaCmTSMWMmHIyJQrbEJcupa
         rK04kUHmwoBL5lwnk9+s0MYK7hrKMalVvdslXZJEjQHxhDT9MRU0RegmiwjCjauoxKeP
         ixfg==
X-Forwarded-Encrypted: i=1; AFNElJ9qmR3jg+sJFZxvvDQ7DHWqlnFJ/rEAOQST+w//yijaOeYd0/1tt8g7yrHBPA3GwHaSqL2OccQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP4y8tg+OjBWv/c+d3BG/Z9wOekiRdh4qav/nxu/C4CA/ArJ3+
	qPTocnl1pQUv429oIVpO/Mr+fZWTJMsSebOerxIIPijxth2GXqZUVuUGzSDh+PCrR+e6L4L4Jvm
	wpKPrMwfoloAxo0UV9NROvjABi05SkaY=
X-Gm-Gg: Acq92OFdit3Mgp82UryKjNMaxLQh9SxztcNCho1qaoJvDaNtUQP/1cKWvzGkfzj9lJu
	EG+xtmL5qE50wft0XW6Vo1lo3RKE2cBB6SlcvFxVM+x1AS6kCu4qs6QFTj1QNfpcr/5m/8SdMVT
	L2TeprLbFIaPXxtEV+ZhyN1o59HeF0qURrVP3JiYKT2yXF1B8mlR1rd2y4vbeEWiZ7jEbz7vKgy
	CqQzfFOvST7f8HQtgUa6fjSfGRpKNHAToMBdOtBRuDzFYhIwYAKvrtPW7p+doC9Hgw3ouiOTmuy
	TbbUCFO4
X-Received: by 2002:a05:600c:820c:b0:489:5022:39a4 with SMTP id
 5b1f17b1804b1-490ec4d652amr112488235e9.9.1781422545558; Sun, 14 Jun 2026
 00:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611160749.391279-1-jt26wzz@gmail.com> <DJ6DMGTPWXJN.1YKSBHULQ1PB9@gmail.com>
 <aivZ9jYGw6QRxLQQ@u94a> <DJ78FEGKX5S8.1H2M4C8415L98@gmail.com>
In-Reply-To: <DJ78FEGKX5S8.1H2M4C8415L98@gmail.com>
From: Zhenzhong Wu <jt26wzz@gmail.com>
Date: Sun, 14 Jun 2026 15:35:33 +0800
X-Gm-Features: AVVi8CeMd-vQB5-GRBpTKGXkjEefh5p3w8xHUU3WFVRuMmsTgKn_YIcq_b-BA8s
Message-ID: <CALgi0XmXX_hBkxZRv8TgxJuoH8QHSBMyM4D3Z90FZGHzs0-s7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add helper retval linked scalar
 pruning selftest
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, 
	eddyz87@gmail.com, stable@vger.kernel.org, mykolal@fb.com, tamird@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:shung-hsi.yu@suse.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:menglong8.dong@gmail.com,m:eddyz87@gmail.com,m:stable@vger.kernel.org,m:mykolal@fb.com,m:tamird@kernel.org,m:alexeistarovoitov@gmail.com,m:johnfastabend@gmail.com,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-299175-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,fb.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp,r0.id:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F01B680923

Let me add one more data point beyond Shung-Hsi's explanation.

I first tried running the current bpf-next verifier_scalar_ids tests on
a 6.6.y kernel as a rough filter. I then realized that the result was
not a clean comparison, because many of those tests validate verifier
log strings through __msg(), and verifier logs are not stable across
kernel versions. So I did not use the pass/fail result as evidence; I
only used it to pick the closest existing tests for source-level review.

The closest candidates I looked at were:

  precision_two_ids
  linked_regs_broken_link_2
  linked_regs_too_many_regs
  two_nil_old_ids_one_cur_id
  linked_regs_and_subreg_def

Some of them are pruning-related and some cover linked-register
precision, but I still do not see one that covers the same
helper-status/r7 conditional-link pruning scenario as this selftest.

So my current understanding is that the selftest adds distinct coverage.
If this still does not address the concern, I am fine with dropping this
selftest patch.

On Sat, Jun 13, 2026 at 1:04=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri Jun 12, 2026 at 3:18 AM PDT, Shung-Hsi Yu wrote:
> > On Thu, Jun 11, 2026 at 09:55:55AM -0700, Alexei Starovoitov wrote:
> >> On Thu Jun 11, 2026 at 9:07 AM PDT, Zhenzhong Wu wrote:
> >> > Add a verifier runtime test for a branch pattern where a helper retu=
rn
> >> > value and a related scalar stay live across the same control-flow
> >> > sequence. Rust/Aya-generated eBPF can naturally produce this shape w=
hen
> >> > a match on a helper status keeps data derived before the helper call
> >> > live across the same branches. Such code commonly uses the helper re=
turn
> >> > value in r0, where 0 means success, producing an r0 =3D=3D 0 / r0 !=
=3D 0
> >> > branch shape.
> > [...]
> >> > +SEC("tc")
> >> > +__description("helper retval linked scalar pruning")
> >> > +__success __retval(0)
> >> > +__naked void helper_retval_linked_scalar_pruning(void)
> >> > +{
> >> > +  asm volatile (
> >> > +  "r7 =3D *(u32 *)(r1 + %[__sk_buff_data_end]);"
> >> > +  "r5 =3D *(u32 *)(r1 + %[__sk_buff_data]);"
> >> > +  "r7 -=3D r5;"
> >> > +  "r2 =3D 0;"
> >> > +  "r3 =3D r10;"
> >> > +  "r3 +=3D -8;"
> >> > +  "r4 =3D 1;"
> >> > +  "call %[bpf_skb_load_bytes];"
> >> > +  "r0 +=3D 1;"
> >> > +  "r6 =3D 1;"
> >> > +  /* success path keeps r7 independent; failure path links r7 to r0=
. */
> >> > +  "if r0 =3D=3D 1 goto l0_%=3D;"
> >>
> >> this exercises linked registers with BPF_ADD_CONST logic.
> >> We already have such tests. Why do we need this one?
> >> How is it different?
> >
> > BPF_ADD_CONST wasn't what was meant to be tested.
> >
> > The main logic is r7.id =3D=3D r0.id only happens on "if r0 =3D=3D 1 go=
to l0_%=3D"
> > fall through, and does not have such link otherwise. I only check tests
> > added in commit c0087d59e504 ("selftests/bpf: tests for per-insn
> > sync_linked_regs() precision tracking"), but it doesn't seem like such
> > conditional linking was tested.
> >
> > The other rational is that this seem like a common pattern that is
> > genereated from Rust-based BPF program.
> >
> >> > +  /* success path keeps r7 independent; failure path links r7 to r0=
. */
> >> > +  "if r0 =3D=3D 1 goto l0_%=3D;"
> >> > +  "r7 =3D r0;"
> >          ^^^^^^^ conditional scalar linking
>
> Fine, it's a regular register linking without BPF_ADD_CONST.
> Still the question remains. I believe:
> "We already have such tests. Why do we need this one? How is it different=
?"
>

