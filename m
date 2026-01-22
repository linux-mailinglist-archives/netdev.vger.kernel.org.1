Return-Path: <netdev+bounces-252112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJMGIcZtcWkPHAAAu9opvQ
	(envelope-from <netdev+bounces-252112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:22:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E21B75FE82
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5999D4E30E7
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 00:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9960D288C0E;
	Thu, 22 Jan 2026 00:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqdtBtgz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016DC296BA9
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 00:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769041344; cv=pass; b=rObuLURdHWFFM8w3WKn10Igddg4mCiJp4kUtnhWnY4iOKHawm37ltfY/oHqUjIxd5zWgB4ITwV08xBlod2q3rNNrwEIkqKbtEcM5SiBmw3nAuh5kJ7YNUIQjKa1pElDgMycq2AcKUk6KiimmXSnh8iJJbSdcWV/Ey372M7Ud/w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769041344; c=relaxed/simple;
	bh=rTht2jlgLZtnSSDufST2BGNnua07jyJe5oueYXcI7Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lm59D5GFlw4Lj7RMJCIXuLFzn/LVMLCtmh8XswiVQKV38KFtqvfgcdT8tnQN25iwi214AzmvBdqLCWJGQhBmUFa8Dfjes1Xj+1BQeOT4i2erM4MqAp756ry0poPEzB9EdAO5ukhvlAWuBiGw/Qo3ScaiZo/YT+tiiYgTkbe5wv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqdtBtgz; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c626bd75628so101328a12.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:22:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769041342; cv=none;
        d=google.com; s=arc-20240605;
        b=H97ba1Z93cHy7Zhw46B3WE+OWg4nnxgXbXU6hpUCmcIqHMyqUhP2GOpTXX6WayK+XE
         cKgyIP6aTvnyQ3cyZkJIIIQcimm3+eylFZqX3R21GRiYxB637gFWom5aUme4MQOluK0L
         TOfcYUdia+iuMaMCFITNTJCgHV22ewIcr7Xe5L8z3uA71/KZv5lifX+iOAiuzan44zph
         7G2uBSexz+P2Mn9QaKWVRt8Y1CqED7FUZgdTkegsYrl9TmBlcvd/g5bQlCq2wOEAO+wi
         hO2JxEssiZqeHFuDog0HOQin/zyWGG/o8jg9ZZm1rgsejoTra8puzHSJSl3MlX9zmWJz
         f7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=esxls06rnSQ7IobZFMhGI9SPyZewHXysfYzPDMfIq/A=;
        fh=BLXoGvfSOxYI9C7rcX07CkEyroe9KJe4b3ZXLF34Pqc=;
        b=dnZYaWMES7ajayRtYO4MEVHxL2bP618ZSItgGDzuD9xUB1JnJv+X3w9jHIYendHihQ
         iChMDk+kkQSUjokORjkUqx4pymQm/lL5s9gQ58JtXmwXnB29T1ioGoMJLuXtEEcjHbcH
         Z+9NsKvq/2i/ENlHbVcS3sT8IDPhoUcCrLFsRMiNWEpqnsZAtzYisIEMp0pSTWK+JOXN
         ue/7ySP/SmqFg0B2kTZ0oE/BpmDwnPmPCHEpvQjyFBza93rVHBzZspIISff9hJl2KjwQ
         mPYyrOTUhcI7M+Ftc+VdJ8SopkDBVuLWIxXj93uX5V/3AZPugdm/otlFzM0ZOW45NcMW
         nrZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769041342; x=1769646142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esxls06rnSQ7IobZFMhGI9SPyZewHXysfYzPDMfIq/A=;
        b=ZqdtBtgzzbRgwHjLyZCQ1cgnAVX1ZiQDxVhmOvSyq2oJtKFY/KDinWvaGuzNlecrO3
         DfVq1naiANaKsyaoshfG3d2YEH20fTLOTpyk/PhhoKbEBT/7MJ1XA//V+aSLbsPWZYx8
         ulQkVIg+3f50V/7rS4mzTGIl2faERmdDxBRreDhBZB7eF9x9mXoq+Hp6LMMyAJCWxa/P
         3OJWMemDo8q5pGcZSWt0inTcdpongEwXADofbYzCEnsn/lwO65yeFtrSgpQtIbbk+ytm
         FCJNFHxO3HADMOfyuHgdr6LpCyKuVbHoRK72Jpqyk3Yq536lM5yLHzn6NaYy6wWFogO0
         Jiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769041342; x=1769646142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=esxls06rnSQ7IobZFMhGI9SPyZewHXysfYzPDMfIq/A=;
        b=k04z2qhwP/dFhOsQO4txdAca9+aKx78gjEmNI0MBIOkAnSqrd6BVj2LTWmFlNkdedz
         dk4yFlkUVP6moj6a6WzbWAPcWQNsWZvyzBb9f85pQAc34GsfxnF+geMM6e3Y3Qj4KZgX
         GIxGjkftNqMoK8+yxahemcotUzJ+oZlSwIxCzOBKethz1BBFaV8tNJmtGrmzpqlPOUYT
         I4mO6GxoMe18+jTArcIjWDVkca+jJARbh6F/+Qg5lcjA5dqag4FqhsesxiZyrTtTy/Ke
         JoWgUsxUWMzTW5aoRmui7FvFatyzS+dd+SaPueyKLSyVE5EVQXIOSbgLoiZ8h+H3hNi0
         dTrA==
X-Forwarded-Encrypted: i=1; AJvYcCU74LquPbdams2fnWOmRZ/ofglgquzSNo/VlxKWfzLrHroXnnE27OE37ZsoN/GXDtnkq2zil48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx15thQL6VWfWgok/1l7a8THacmZwwn1hxqjCPlRlLaUQL1JFsk
	jxt33DCZDTSyCn1hCOmE7Bq4DORph6Gf643Ax6wGhvbPIuy2ru0uF79YYiKuQjH9knaq5hSO1Xa
	upb0aDAFKoHQ/AKlbUogNks5tpDmQZNI=
X-Gm-Gg: AZuq6aKOb9yfgxadT1aD//h9He87edBc9j6HB90AAZOtXxcvZfh6LN8p1kQoOTxaNnd
	YgD0Wya3S6ydTkM+jXWIIZmo+TIJ67ePqmVls07SKC4CQ8AwftWdxKAdxfexRM7oaKG3fYI3l5g
	etPJ1LGt8gBJXxneX6XhDi6p8C8vuhnpzwuN4XGPffEewMMCFjwhvzwjahA5lhHZKzseD4Aafzd
	9nLl0qILMzJmyNjgEcJr1XsYQZMa5Hg53JPqwxaQ11sT/dKa+NoipCQ63BEzNDwgc3AQ8ukHk4q
	khf8v36F
X-Received: by 2002:a17:903:3810:b0:2a1:388d:8ef5 with SMTP id
 d9443c01a7336-2a7698fb1a2mr63903145ad.19.1769041342107; Wed, 21 Jan 2026
 16:22:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115112246.221082-1-dongml2@chinatelecom.cn>
 <20260115112246.221082-8-dongml2@chinatelecom.cn> <CAEf4BzYop1GT1v7qxNQi44dsEebjwnLp-sHDp-HPzVrj69WzTw@mail.gmail.com>
In-Reply-To: <CAEf4BzYop1GT1v7qxNQi44dsEebjwnLp-sHDp-HPzVrj69WzTw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Jan 2026 16:22:07 -0800
X-Gm-Features: AZwV_QhWzV_mYhMnCtmTeqRyohTRDUETfQ34KN9rYVEgegWCd1UfxQzHm8802cs
Message-ID: <CAEf4BzZm5uenrYO3ZXiGB8qXCg67Ov7crNvZtsj=Be4XEm6OpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 07/12] bpf,x86: add fsession support for x86_64
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
	TAGGED_FROM(0.00)[bounces-252112-lists,netdev=lfdr.de];
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
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E21B75FE82
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 4:06=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jan 15, 2026 at 3:24=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Add BPF_TRACE_FSESSION supporting to x86_64, including:
> >
> > 1. clear the return value in the stack before fentry to make the fentry
> >    of the fsession can only get 0 with bpf_get_func_ret().
> >
> > 2. clear all the session cookies' value in the stack.
> >
> > 2. store the index of the cookie to ctx[-1] before the calling to fsess=
ion
> >
> > 3. store the "is_return" flag to ctx[-1] before the calling to fexit of
> >    the fsession.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> > Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> > ---
> > v10:
> > - use "|" for func_meta instead of "+"
> > - pass the "func_meta_off" to invoke_bpf() explicitly, instead of
> >   computing it with "stack_size + 8"
> > - pass the "cookie_off" to invoke_bpf() instead of computing the curren=
t
> >   cookie index with "func_meta"
> >
> > v5:
> > - add the variable "func_meta"
> > - define cookie_off in a new line
> >
> > v4:
> > - some adjustment to the 1st patch, such as we get the fsession prog fr=
om
> >   fentry and fexit hlist
> > - remove the supporting of skipping fexit with fentry return non-zero
> >
> > v2:
> > - add session cookie support
> > - add the session stuff after return value, instead of before nr_args
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 52 ++++++++++++++++++++++++++++---------
> >  1 file changed, 40 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 2f31331955b5..16720f2be16c 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -3094,13 +3094,19 @@ static int emit_cond_near_jump(u8 **pprog, void=
 *func, void *ip, u8 jmp_cond)
> >
> >  static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
> >                       struct bpf_tramp_links *tl, int stack_size,
> > -                     int run_ctx_off, bool save_ret,
> > -                     void *image, void *rw_image)
> > +                     int run_ctx_off, int func_meta_off, bool save_ret=
,
> > +                     void *image, void *rw_image, u64 func_meta,
> > +                     int cookie_off)
> >  {
> > -       int i;
> > +       int i, cur_cookie =3D (cookie_off - stack_size) / 8;
>
> not sure why you went with passing cookie_off and then calculating,
> effectively, cookie count out of that?... why not pass cookie count
> directly then? it's minor, but just seems like a weird choice here,
> tbh
>

consider also just calculating cookie count out from bpf_tramp_links?
would that work? Then "func_meta" would really be just nr_args (and
I'd call it that) and bool for whether this is entry or exit
invokation (for IS_RETURN bit, and maybe we'll need this distinction
somewhere else in the future), and then invoke_bpf() will construct
func_meta from scratch.

It's relatively minor thing, but as I mentioned before, it's this
hybrid approach of partially opaque (from invoke_bpf's POV) func_meta
which we also adjust or fill out (for cookie index) is a bit of a sign
that this is not a proper interface.

>
>
> >         u8 *prog =3D *pprog;
> >
> >         for (i =3D 0; i < tl->nr_links; i++) {
> > +               if (tl->links[i]->link.prog->call_session_cookie) {
> > +                       emit_store_stack_imm64(&prog, BPF_REG_0, -func_=
meta_off,
> > +                                              func_meta | (cur_cookie =
<< BPF_TRAMP_SHIFT_COOKIE));
> > +                       cur_cookie--;
> > +               }
> >                 if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
> >                                     run_ctx_off, save_ret, image, rw_im=
age))
> >                         return -EINVAL;
>
> [...]

