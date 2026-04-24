Return-Path: <netdev+bounces-281019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDyELe+Y62lSPAAAu9opvQ
	(envelope-from <netdev+bounces-281019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 18:23:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0DE461452
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 18:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55362300C938
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 16:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9703E1223;
	Fri, 24 Apr 2026 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaOX3lfh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ADB3CFF52
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047785; cv=pass; b=Nj08SvR6zSzS4ao8tuo10bQlkUFoxu3ara0XFLbJDBcYQT+kT1pgIfJJtMXhkIQIK2nZp+WuMbEaaNlDVuNe83d2Ryq3TMMfV8+Rbf3AxXtiQu8DmEjIsAzViq6s2bPnDbijmcyw9PEagDHKeBpgO1BFskBvjcw+y7CrMCApWQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047785; c=relaxed/simple;
	bh=3m4VXaMs4n4EPq3GLOSR3itDAfPEZGkQPOTO8GJSpCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3KTjQYLjjf4L8k7wtgRvhUHsAZfownA+WoDV7Urlh3xC+Kc9TVXNOr/bRqbT4rDtk+3cHUw+DOIv+KQL1kFHjK3SeZvZaVEq6rEHqqxjlJjpmc7PMM4GbuJA/AWoNysQF1icmlrAnfEYEkCpcaGh+0K5L83Pokv/FSiPpWzjN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaOX3lfh; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2aae146b604so54000755ad.3
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 09:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777047782; cv=none;
        d=google.com; s=arc-20240605;
        b=JP8i7ezwk20ekauC6GjDBY5NsX223yuIP43w/X/1EvvSOT7XxhEZ0oO7e8StDeW0op
         0LR4kqwbqzaeWchhUechzQBFh3iHdgwVBqXW9lhSN86r0A8oo2yTIdsBGX2jjko88C9T
         Gggu4d/bM3e9bBxG5j/EiomEli72nWuHNgwk72DjlmB0CrhdbXvINl01zuW0q70F23e7
         jSsAsf3aT24W664A4+OIfsgY0mpRuzuwnf2iggAEZIul8sNtwOprMeWWjujO1ACSMiKt
         acPbjLS5BNRoBKM/rKMvfFzquVgU18aC94KnhdE9/3RKlkziJGVrepWotAYEobZGr9eH
         MLLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uZSOT1Xpo8svsF0lfHeXNdp2/Y1pp+xVy0pY5P0ySGQ=;
        fh=c9dAXvwCgMiqHUqvGQII8kt4P6bp3M04Y7KOP1qyXn8=;
        b=edG+edE1HkEkTqCG4f6scq2ArY1ZU/3lpFUqODFsXcDUpDF/74KubP7VlptSBrF2nI
         BOSLrYwvfFjK3wWJFVai+zsyCEkSN4h4ia7CqzyNDvM4X5qWJ0lmJddMDuM4BFbt7oV/
         uGRrrdVO7SEQaXat6pekBzTs7WwXfC53aboD3PkxQ+3WuHwRfcypU5KiilF32XsQvpJC
         og0tJQuuIGaoz7KTDl/9oD7fG4Q8dPGgPm8E+6Vuf2XiFypshqTRb9i39jnUVGTkmjpk
         fgRlVT4zk9PJw8SPWTrzkWg9Y0wFH26Bzf3ZrgXjTR3qqxXYUDI19gOhtB3CTcQAbv01
         berA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777047782; x=1777652582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZSOT1Xpo8svsF0lfHeXNdp2/Y1pp+xVy0pY5P0ySGQ=;
        b=XaOX3lfhIPP1oCKWEcYqGQIlR4o33LR6uIcpT+k4JsMHw+fqDi7zAEpJEYW275teDS
         kc2ALhpBkWbeF7GVyEjyNuRaJskgpONreNAq1Fp20smkPNjqn5vuozbNwvanDYJPlSHx
         XUKNdEW3sj0uv4CxFVi6ZDu00/4aODwkPj/yYL/YvnPTlhiPRoePnqZ20bh5yUAq7uIH
         tMMfNvMxYMhxQEZcnCHtHPHtBhayjRpSuj08XTjYsapWi8RqgO5uOg16gDyYXCuvuTNd
         ZTvG9MO0afLoLf8qyyemi5/Wf9ZJYjNODXGPGSx2aFqfxoxuwPl0PymRYUC1aL6QSTt7
         jVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777047782; x=1777652582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uZSOT1Xpo8svsF0lfHeXNdp2/Y1pp+xVy0pY5P0ySGQ=;
        b=JlpkRZT+fHDsI7b2W+MmsN6CtEiO0377OQMDSfr9Hj4yDDeXK8GvWNZ58x4w1YrezS
         aD49SWmfwpM3TPFvXvqi52mSdCiM7FqiQLqTVssrRJleLQ68A0Q/o5Bfn9eWapbip4r4
         4x3C2ly+EoQanP11g7VIV+cO8ZbLEWFnKpSKxL7MljPyvSJ7jZrwNWLYSLHgAOH8iQNL
         Q8rALrKD2A70yDMtIOSnDG3R3PVIvR4f0Co7lhARJcTIyFC8GVY1GiB170kx704Q4Stu
         S3INISu0Y1Ovhf+V8xh03X7W1Wvav15lTrPZSgbITLRn6AEg4k6rc7FQUrPFbO/ZTn1U
         MmKw==
X-Forwarded-Encrypted: i=1; AFNElJ9u6yYDAkD83X4B7FCrLglTfm8bThnXhoe2bQCmRck5PYwreiDDMZiNEv7fzQFRa8Rvj6eNs5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1mKVo2i0rFSuMTADlkAW/2gOMAP2ZMDPpyTVQUmi+GPel2vQn
	UZLxHhm8Qs6xCi++yUh3LzQLBN6JI+w0P7aW2cWlbgM2Ao06OcHp72Qwn6pv8JpIenFZ2sR54TA
	hbeUWXhVGRwKOhDIE/Ip0/M/2gbOjVaM=
X-Gm-Gg: AeBDieuy6ocBLGVID53SikJspfaXVhi9E9ZIxpqixHZalmChszfAaMtLJ1Ua5xRavpN
	ypFiVbpTB/1QZF7LyP7ulxYt1amR9tDfMJcD7ujdHVRuGcmrdV9Db4zgicb9FI1Sfzt3aq98AYJ
	8zwFZ6Jx6QMspTbhHGEFr9Lf+FFbfpuey3a1DWJWuYRqyaC2TFY5Nygkvfw+6/EMDGgtrw74eUJ
	RzTMaGQHWHKIZRIbCAB+5Srk2Fs974QA6pZZAk6NuDWCvz35a5Uhab4Ih+FtJ28/PpH2foU015/
	eVCkNnLUEs10pSG8dg==
X-Received: by 2002:a17:903:3db3:b0:2b2:58a2:c8a with SMTP id
 d9443c01a7336-2b5f9d68827mr230869715ad.0.1777047782298; Fri, 24 Apr 2026
 09:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <20260421221016.2967924-2-ameryhung@gmail.com>
 <CAEf4BzZGg1EKwYFG6QKrkNbiE6RwWKew_Zz8mz9rjshKjWzcKA@mail.gmail.com> <CAMB2axMw7mOs8kTFZG8Z1wn8fX4D0Si3Ge4F58DXKkBBQwrjyw@mail.gmail.com>
In-Reply-To: <CAMB2axMw7mOs8kTFZG8Z1wn8fX4D0Si3Ge4F58DXKkBBQwrjyw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 24 Apr 2026 09:22:49 -0700
X-Gm-Features: AQROBzA4gxdMlVVwbP4QziFaumqbNPLGu0rKNfr3k9Zf5X-mR78Ckn8Sj18mJ3I
Message-ID: <CAEf4BzZ1LjRhh2DyQ8gPNKDh9fY+yOJrH0Ly9RoakBL2nOuxaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Unify dynptr handling in the verifier
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1F0DE461452
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281019-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]

On Thu, Apr 23, 2026 at 10:34=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> On Thu, Apr 23, 2026 at 5:04=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Amery Hung <ameryhung@gmail.com=
> wrote:
> > >
> > > Simplify dynptr checking for helper and kfunc by unifying it. Remembe=
r
> > > the initialized dynptr (i.e.,g !(arg_type |=3D MEM_UNINIT)) pass to a
> > > dynptr kfunc during process_dynptr_func() so that we can easily
> > > retrieve the information for verification later. By saving it in
> > > meta->dynptr, there is no need to call dynptr helpers such as
> > > dynptr_id(), dynptr_ref_obj_id() and dynptr_type() in check_func_arg(=
).
> > >
> > > Remove and open code the helpers in process_dynptr_func() when
> > > saving id, ref_obj_id, and type. It is okay to drop spi < 0 check as
> > > is_dynptr_reg_valid_init() has made sure the dynptr is valid.
> > >
> > > Besides, since dynptr ref_obj_id information is now pass around in
> > > meta->bpf_dynptr_desc, drop the check in helper_multiple_ref_obj_use.
> > >
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> > >  include/linux/bpf_verifier.h |  12 ++-
> > >  kernel/bpf/verifier.c        | 178 +++++++--------------------------=
--
> > >  2 files changed, 41 insertions(+), 149 deletions(-)
> > >
> >
> > [...]
> >
> > > @@ -7433,7 +7426,8 @@ static int process_kptr_func(struct bpf_verifie=
r_env *env, int regno,
> > >   * and checked dynamically during runtime.
> > >   */
> > >  static int process_dynptr_func(struct bpf_verifier_env *env, int reg=
no, int insn_idx,
> > > -                              enum bpf_arg_type arg_type, int clone_=
ref_obj_id)
> > > +                              enum bpf_arg_type arg_type, int clone_=
ref_obj_id,
> > > +                              struct bpf_dynptr_desc *dynptr)
> > >  {
> > >         struct bpf_reg_state *reg =3D reg_state(env, regno);
> > >         int err;
> > > @@ -7499,6 +7493,20 @@ static int process_dynptr_func(struct bpf_veri=
fier_env *env, int regno, int insn
> > >                 }
> > >
> > >                 err =3D mark_dynptr_read(env, reg);
> >
> > if mark_dynptr_read() fails, should we exit instead of proceeding to
> > fill out dynptr info?.. even if mark_dynptr_read() cannot fail because
> > of is_dynptr_reg_valid_init(), it still looks wrong and error-prone
>
> I think I will change mark_dynptr_read() to receive spi from the
> caller and make the function return void (It is technically nofail
> after liveness tracking code is removed). Then, move dynptr_get_spi()
> before it and don't error out. A comment seems to be enough.

yep, makes sense

>
> /* Cannot fail as we already make sure reg is valid dynptr */
> spi =3D dynptr_get_spi(env, reg);
>
> mark_dynptr_read(env, reg, spi);
>
> >
> > > +
> > > +               if (dynptr) {
> > > +                       struct bpf_func_state *state =3D bpf_func(env=
, reg);
> > > +                       int spi;
> > > +
> > > +                       if (reg->type !=3D CONST_PTR_TO_DYNPTR) {
> > > +                               spi =3D dynptr_get_spi(env, reg);
>
> ^ move this up
>
> > > +                               reg =3D &state->stack[spi].spilled_pt=
r;
> > > +                       }
> > > +
> > > +                       dynptr->id =3D reg->id;
> > > +                       dynptr->type =3D reg->dynptr.type;
> > > +                       dynptr->ref_obj_id =3D reg->ref_obj_id;
> > > +               }
> > >         }
> > >         return err;
> > >  }
> >
> > [...]

