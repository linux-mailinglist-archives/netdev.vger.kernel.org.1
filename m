Return-Path: <netdev+bounces-280937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGgzMwgB62kzHQAAu9opvQ
	(envelope-from <netdev+bounces-280937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:35:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D43459EDF
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90AFB300383E
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A899934253B;
	Fri, 24 Apr 2026 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuOlUEPP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A63A33031C
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 05:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777008899; cv=pass; b=Ho7efKfzzkJpTmC0TSL/i5doY0HPO33AjFZcWGjoRkRplO+9rMCuRsA057QVulgyQwDFuikJI9aa1BbNLYFCpOI58DIiAE3oD/p9dtUwX/7xgi7RJ2i79ZpHmO6GDR3CxC12W3afv1tHRj8WFrlIhS3i4FfKMatkZN6xXs++T4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777008899; c=relaxed/simple;
	bh=nJMfrq4tRFpvzrW37H2S2vo5RQzb38ojM1/0Nck60UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSEhpKsKMHB/gwMNHSwbN7ozbmaSGos7AO5kVvLKPZq/w2375fglmS6stkJbeYF+DTUq33beNEw73OBc4+Y8IoPp5JSHGi4slogjY5D0a2C17Nzn5OZxYmVGzGgHHHseXoGlgOGTZdHEvFchoirDvRVoi9KjthUaM9So/pZPmLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuOlUEPP; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7986e0553bdso71347707b3.2
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 22:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777008897; cv=none;
        d=google.com; s=arc-20240605;
        b=e5L8sSkMadQ9jIpxvA1PRJQAvqGcCeydBbcMWj7yO05jeWX3uj9uPyJLDhBIlNbq8p
         4wpAi5yv3UdZWH4J4+4oiCWbeWUbySkA+LknbXuXgClLKk8sIrMJGQ/1kX3LN+6mAE6N
         E6+PN+Ec5qrvosPcIrnfeQwQ9WCJxd82imBNSiKHBmtcOQ2NH/B6QW3E7pMD8wduz27/
         qjluEusXmMYNcQUL+6/o1DacXhbC0ihjaHQnneaj39KAZcj3w6PegyyreYJ7an4v2mYw
         MpspRELU5JL1oK0v1/FNePa4o7nmQhPfnR3QEkYaJ+IxkJe0KGRCBGgWZKXkh24q8Wxy
         fqbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Mco96ugiiVLyRZYUFRtNHTAzHRl/YzNAOoenKfciLs=;
        fh=W+6T116vhGiNmRJmn6cHv2FqP/oZ5KgMeSHpHGHMnuQ=;
        b=C0h/btWfUC/czypLixOW6PdZ0cZsjHG6suigofuzXDX+yRr5ssBe2usbh3q6lvnx4G
         ofWDSX8Lzp2UlFIfRcMmdVn+GCnvUAlZ1pJEuYnA9eCv8WJsqNiCrVF8PlCbU82XvA7S
         9VzI+/KnZk8AVZ6e/HGlkgtMXTKR3dUX0/tq0OEoZDMLSFHUUU3DTDXP82RY8S+Hfwv1
         veR9uh6zzKLtRU55s67Tf1ZcqzLfXZ7jKNPs2L5E7qKy3UFA1qEeD4oYOAChGXbYirOA
         2oumr8bMdWbuSTftJRCRHC71/AhdIw0Z2Cb66a8B/B2xh5jg3WYUBJpixTkCtTJ/2b+9
         qdzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777008897; x=1777613697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Mco96ugiiVLyRZYUFRtNHTAzHRl/YzNAOoenKfciLs=;
        b=MuOlUEPPa8OBQ985mfstEuLGKdIhww073pDFlYJrwYQLpgs+vlfgHsAl8rXw1IMTfZ
         eIzbe6WNZjYYAKhSR7PFMesln0DPD0cY/bk69pc4Xx4GZBWRuLn522mJPVHHQgvlxPQL
         2DEB//oxlUsOePHixZvgzOD8kAddq8yqf3/Hy7jdeWEp02nnlSw2AjBlW/NLJGof+HgP
         tjeOyY8XZTrUL+rcehQldRRAw0fEXcMZ7ZTc/O9yrHSkEUYRIM+tPX4kIpnuFgHA5+dq
         pdsGlnlgnZb+nWq+NtiJ36Ly6nXQ4TeXWNRZQUJLf1ww7LML3MhPW88fU6vm6G+yb/aR
         s35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777008897; x=1777613697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Mco96ugiiVLyRZYUFRtNHTAzHRl/YzNAOoenKfciLs=;
        b=cL5xeTuIzU+cWCSk2mzd5tnknnf6P/mzI46n/YKsOIfWuZjfKJ7AF9CMaQfxUzFLxM
         LRKKaOHuwNvu9CTCjsH1lZWxQnIdbQndgslNZ6S7Pwz2vKh+KPc8lB0nshzgFNFbm1jR
         9ziMTq66P3NwOPbDTxQSBgNSHFQaICxUK3lMx1euMjDWG3/DGbDnNE7khShkXEOlifvS
         dpjyUs+PS4kntUPUSW4vS0JxylAjH+65BjtQdcRjOUdpoJJqVxMeHSV/rVmYZHD69Ji3
         /3pO2XTSYNrS+8rAQfPUiMeh8Vk2zPUR7+Y9VXLguqAaRdxP1iKf83/Uc87p1yENnsgS
         nE1w==
X-Forwarded-Encrypted: i=1; AFNElJ+NiFQ6bCM3svyFZedIwIW8TTlk26xM+zNOoqSelTBkSQyBxtUOLCD3p2mXEk2PaskiHJPfBTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywjeH7mKAWEfNPrzHEsZ7gWpjBTWC3eDqbhM8VeHX4zY8bIp2D
	lwKpMs6uvBrUc8j7hId77UBdToEO6lcbMft6UVyI1a28jkjpSx8xPh9SXkR8051OIto1ocz/qWe
	lxO470Ho8IWNOeGtfIT0CFBRyxJwKZxo=
X-Gm-Gg: AeBDievF3mPbsYDfYY76V1joVbCaKNqBgkGuO+Mio9rKqvPyKPH2SbQdP///V//BUyC
	fIUGTnPgw6VRMPiG6+cBC8NFOZ1YO05OFb71lzvS/DzyVcZSQHRDO+DJxOqGAQrtqpLY6eXF4Ce
	AAA/OKJOYhR9n1lIDYk/OLH2tP48G2+9nWcWRt0lIC9MEVLNyWdrUzR7hckvKkN8ww14+M33L3x
	SeXzXtxPlUOAqUt51iYY88X4cuOQP+/eHj0WiPgWwgEFitXE06IheZdHqgvwIk27fDbykI1gNme
	RZUVsAccSGfWOK3b+WF0zBrdzhim
X-Received: by 2002:a05:690c:941c:b0:79f:d961:47bf with SMTP id
 00721157ae682-7b9eceb5c27mr256699517b3.8.1777008897374; Thu, 23 Apr 2026
 22:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <20260421221016.2967924-2-ameryhung@gmail.com>
 <CAEf4BzZGg1EKwYFG6QKrkNbiE6RwWKew_Zz8mz9rjshKjWzcKA@mail.gmail.com>
In-Reply-To: <CAEf4BzZGg1EKwYFG6QKrkNbiE6RwWKew_Zz8mz9rjshKjWzcKA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 23 Apr 2026 22:34:46 -0700
X-Gm-Features: AQROBzAECWMJ15GcfaCGgs5nF8PZG0BrwMnhTANNSqKOcTnjKUnZMafn0Ia7ElQ
Message-ID: <CAMB2axMw7mOs8kTFZG8Z1wn8fX4D0Si3Ge4F58DXKkBBQwrjyw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Unify dynptr handling in the verifier
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B1D43459EDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280937-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Thu, Apr 23, 2026 at 5:04=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > Simplify dynptr checking for helper and kfunc by unifying it. Remember
> > the initialized dynptr (i.e.,g !(arg_type |=3D MEM_UNINIT)) pass to a
> > dynptr kfunc during process_dynptr_func() so that we can easily
> > retrieve the information for verification later. By saving it in
> > meta->dynptr, there is no need to call dynptr helpers such as
> > dynptr_id(), dynptr_ref_obj_id() and dynptr_type() in check_func_arg().
> >
> > Remove and open code the helpers in process_dynptr_func() when
> > saving id, ref_obj_id, and type. It is okay to drop spi < 0 check as
> > is_dynptr_reg_valid_init() has made sure the dynptr is valid.
> >
> > Besides, since dynptr ref_obj_id information is now pass around in
> > meta->bpf_dynptr_desc, drop the check in helper_multiple_ref_obj_use.
> >
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h |  12 ++-
> >  kernel/bpf/verifier.c        | 178 +++++++----------------------------
> >  2 files changed, 41 insertions(+), 149 deletions(-)
> >
>
> [...]
>
> > @@ -7433,7 +7426,8 @@ static int process_kptr_func(struct bpf_verifier_=
env *env, int regno,
> >   * and checked dynamically during runtime.
> >   */
> >  static int process_dynptr_func(struct bpf_verifier_env *env, int regno=
, int insn_idx,
> > -                              enum bpf_arg_type arg_type, int clone_re=
f_obj_id)
> > +                              enum bpf_arg_type arg_type, int clone_re=
f_obj_id,
> > +                              struct bpf_dynptr_desc *dynptr)
> >  {
> >         struct bpf_reg_state *reg =3D reg_state(env, regno);
> >         int err;
> > @@ -7499,6 +7493,20 @@ static int process_dynptr_func(struct bpf_verifi=
er_env *env, int regno, int insn
> >                 }
> >
> >                 err =3D mark_dynptr_read(env, reg);
>
> if mark_dynptr_read() fails, should we exit instead of proceeding to
> fill out dynptr info?.. even if mark_dynptr_read() cannot fail because
> of is_dynptr_reg_valid_init(), it still looks wrong and error-prone

I think I will change mark_dynptr_read() to receive spi from the
caller and make the function return void (It is technically nofail
after liveness tracking code is removed). Then, move dynptr_get_spi()
before it and don't error out. A comment seems to be enough.

/* Cannot fail as we already make sure reg is valid dynptr */
spi =3D dynptr_get_spi(env, reg);

mark_dynptr_read(env, reg, spi);

>
> > +
> > +               if (dynptr) {
> > +                       struct bpf_func_state *state =3D bpf_func(env, =
reg);
> > +                       int spi;
> > +
> > +                       if (reg->type !=3D CONST_PTR_TO_DYNPTR) {
> > +                               spi =3D dynptr_get_spi(env, reg);

^ move this up

> > +                               reg =3D &state->stack[spi].spilled_ptr;
> > +                       }
> > +
> > +                       dynptr->id =3D reg->id;
> > +                       dynptr->type =3D reg->dynptr.type;
> > +                       dynptr->ref_obj_id =3D reg->ref_obj_id;
> > +               }
> >         }
> >         return err;
> >  }
>
> [...]

