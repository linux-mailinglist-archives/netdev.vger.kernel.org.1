Return-Path: <netdev+bounces-266796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AdPGjL4sWl7HQAAu9opvQ
	(envelope-from <netdev+bounces-266796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 00:18:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1E726B4CA
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 00:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59B1630F3D55
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C423A1E81;
	Wed, 11 Mar 2026 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGkxeh4T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6879D3A3806
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270945; cv=pass; b=J1VKgnjYs7QSp4J/3dTc4YsXH+4Jz3uzrNNjRDv9r+38Ks47mR8GZHQiAg+SeHal1yIPygOU5lyqgDGTX1YioMkSUmdj5lqJ8lXROYA5h1iZzFyi6nXkYhBZmRwD/tWuUkJQA4Ku+KwjpL6ZsljjNWG+rgXLoyThF/M/YYxGAuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270945; c=relaxed/simple;
	bh=nSmnfI47vHMiBpFxxOG/S59YEPeHsgHRJ9Mzsi8WylA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPtiewv39AZi6FBdN3oytmhjercnZWmL4EXey/ae7BbKppkQx17wae+06dJ0rGmLzWUpHEr2HCB+/l33tSh1IkF/6XOcDt0r4xOij8Pb0Df9Al8atsinJpEX742u4FoX9AeQqDBIPUA3Au/Hmnj85s535CoEK4AFMzwY7yixTHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGkxeh4T; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35a08ce49dcso316233a91.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 16:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773270944; cv=none;
        d=google.com; s=arc-20240605;
        b=amIbSkKAbARUTBbWjCzRBZbnrHp/EtOQiG6hVYvisK7tqvMNzdXFXQMma1AdBt/6NH
         mc1kUtLEFXZAD6xSYaNYl/Ixf15O8UasGkb92/vUXX5AisTGRrgUKjMXk/fh4iVq6y75
         mK8tI0lxBWhJbLvDmjp7Mcg9m3FbvWLfcUbi83wnsj/DrUqlCELm7NQYaLXin7YtNi1p
         2RIsGWJ5ramWL+HXtBRvjKTGYT5oOUrze2+yG2qdo9iBzKOsFvSLiCB7DBX9QFSel25w
         /5+aOzrWcd12sBMADamE5SxCzTyAaPuIzOUlBFY5jzMWYLMUo9BBXutVsslpvX/kX0/t
         0Ctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M6+PvKVMOamsJ/SoYC181vL7TcbAdXReF8gR1dckpDs=;
        fh=KdHmiAkuHDIB7XWu9ER+aZv/BpLecAuKWOu7/mT4npk=;
        b=QPqQakNWbIUCoCDJfIiOSD4yh4lGy2PmhWqjdB8eCTnUtt0OCvrl2IBg7Hv8+2fnzV
         u8B7nLKhzMpS8vgrmn0xgm37eXv7jrU0J37Lx6U+db39GRx7aJMAEVcE6qbDdhdqpAr7
         x75IcljDlkJ8b24GcIWVLPWshwPonAvWcoLqH4dkRSIOi1QesU5YIVDxj5tMKj2sY5Hi
         T6nzcP0kQbYHY6XVdcPR825E4lm1nkLw7khLyPBTDoBmLnhQAQ4lFtVg370P/FKaFd0t
         xjpizYP/AuloWbeymnOzHUr9VP6oZtUmEgsgLbO9q8jJTn1tAxigKRQmEQ+1l12Z3LrB
         5tPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773270944; x=1773875744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6+PvKVMOamsJ/SoYC181vL7TcbAdXReF8gR1dckpDs=;
        b=CGkxeh4T3t9ZJRyXBdBVLUESXBqWBHYQv5lJhfc2Ln+pe1XBl61OAEbsCLAPWENXXC
         G+y4lxGVV/6obXb4IPwJ5iPQvz+F4jaVY12jdfy6q8IvVrykllAkj5HoIP7zoiuDLeJV
         TCVZ0rnakCHJcsHPDp0LaluSFOxDj10WHrsrGXKW5MxXzDVoaVDx8sPa4Y9cnlO5cwjE
         gkBjtuxf2ATK47JKlWvrKIqrd3LLiq9A7rLMwhfmfPL8MEAlnHb+UOpkklvA1QIY1R7S
         /QgnqpCRlxcmCgiW0JX1nTVY0+wjbC1meGgCUefDcA3MAuPrLcogSVr/H44oR/0oLYPY
         j8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773270944; x=1773875744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M6+PvKVMOamsJ/SoYC181vL7TcbAdXReF8gR1dckpDs=;
        b=E12xKcR8GvRqecB1nTqJMipZOkuHZzgb1RIAClInerFZlQObTwh5aAH8jh2PIQZWWr
         Z5I7aZ0V3cfOqEYiNcUhLGPn3c4NB1tuS2pKCb50Heo9mF1X2ht+b/7ZhX0izlnTR9vY
         SvsmeCi6hs1ddjCYxjcRy5Rtr/tSScyNk1uYvtZhOx/nFWrbcxA/ZwPlj2nca7v354Na
         SgsQmaaCr7qGMm4ZgCtpumgacYmdqkWNljSYO3dk1GjiVb3sZz5CoD4Nbs9jA5IlyZ7M
         VY/al4cO+B9DVOD94xnEZieXPShrYW41oTon/crtHwY4huRKdmz82RN3bOy2Wq6bPg3C
         EO+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZnQLRC3uMP9+joZVbZlB/1x7tSJ0wzY3kmes/E/gzD+A7DUPx2OqFIjsKs3UyrlzSiKMuDe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGJaFBABLWQDIEtTxGxYYRaO1o6+C/lbcvbU6KfM60wIo6Am20
	C8mEYkq4F9BwVQOGObF9q2jDa/RJG6G3o8SJN+MjAnosIXVTHWnVliJlPnfpFSyKzBN7vlrhSXF
	ffWkpQd6GC8QqS42EEfNTW2o0yC0kCOs=
X-Gm-Gg: ATEYQzxg1pCGCDAcEMxdG47DlYHlQb+i/IfIuzAx7kOrhGGK8gYwQmR6BkZAFgN9tcs
	bgLvMQxMEofl/mIsxtPVfvHVNfQfDFHCo8Bo3z4Rx2NsoUBhU/f1A9FYdaP9TWOG00njvlg5pdZ
	VJJ1cfAaXghuzwVFr1VIhmeaGSs/IIQQYqgT5aDHAkYZtml893EInTf72tc2eUrV0NQtSIkf9NH
	Aa+31K+nmvekGIp0LUAxBYEB9L6s8anYTMv4WK/O/+anQoZGOIbFwtLZppF96n7vMsMH9AaiioS
	E1qS4Gk=
X-Received: by 2002:a17:90a:ec85:b0:345:badf:f1b7 with SMTP id
 98e67ed59e1d1-35a012cbadfmr3770969a91.28.1773270943706; Wed, 11 Mar 2026
 16:15:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-2-ameryhung@gmail.com>
 <CAEf4BzZubPSaS8SQSEQJvTphwgbaBfdC0CYEhsfQN8CJ7HS3pw@mail.gmail.com>
 <CAMB2axNR6qPRVy5YCiMygVseS+k9JxY9DFONNHD5Lt8=wD9MGQ@mail.gmail.com>
 <CAEf4BzYTO9e-UAEd+W+ftqQZLUZCWHWXAYVnVjHeNtsZL1=Pdw@mail.gmail.com> <CAMB2axN+8+V+29r9tuoVF57ObpvkUE5d5_8jtd5iRPYq4_gLGg@mail.gmail.com>
In-Reply-To: <CAMB2axN+8+V+29r9tuoVF57ObpvkUE5d5_8jtd5iRPYq4_gLGg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 16:15:31 -0700
X-Gm-Features: AaiRm51yJ0u0juKG9fWYP7eI6FVhFH7X0uPQ8g8NpFoQk31xTypnakOrgWGLMBM
Message-ID: <CAEf4BzY1O1Ne9Rf+O2terCT8f9e6pNFr3N4hOv98N84ZoehCaw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 01/11] bpf: Set kfunc dynptr arg type flag
 based on prototype
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266796-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB1E726B4CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 4:03=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Wed, Mar 11, 2026 at 3:37=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Mar 11, 2026 at 1:01=E2=80=AFPM Amery Hung <ameryhung@gmail.com=
> wrote:
> > >
> > > On Wed, Mar 11, 2026 at 12:44=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail=
.com> wrote:
> > > > >
> > > > > The verifier should decide whether a dynptr argument is read-only
> > > > > based on if the type is "const struct bpf_dynptr *", not the type=
 of
> > > > > the register passed to the kfunc. This currently does not cause i=
ssues
> > > > > because existing kfuncs that mutate struct bpf_dynptr are constru=
ctors
> > > > > (e.g., bpf_dynptr_from_xxx and bpf_dynptr_clone). These kfuncs ha=
ve
> > > > > additional check in process_dynptr_func() to make sure the stack =
slot
> > > > > does not contain initialized dynptr. Nonetheless, this should sti=
ll be
> > > > > fixed to avoid future issues when there is a non-constructor dynp=
tr
> > > > > kfunc that can mutate dynptr. This is also a small step toward un=
ifying
> > > > > kfunc and helper handling in the verifier, where the first step i=
s to
> > > > > generate kfunc prototype similar to bpf_func_proto before the mai=
n
> > > > > verification loop.
> > > > >
> > > > > We also need to correctly mark some kfunc arguments as "const str=
uct
> > > > > bpf_dynptr *" to align with other kfuncs that take non-mutable dy=
nptr
> > > > > argument and to not break their usage. Adding const qualifier doe=
s
> > > > > not break backward compatibility.
> > > > >
> > > > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > > > ---
> > > > >  fs/verity/measure.c                            |  2 +-
> > > > >  include/linux/bpf.h                            |  8 ++++----
> > > > >  kernel/bpf/helpers.c                           | 10 +++++-----
> > > > >  kernel/bpf/verifier.c                          | 18 ++++++++++++=
+++++-
> > > > >  kernel/trace/bpf_trace.c                       | 18 +++++++++---=
------
> > > > >  tools/testing/selftests/bpf/bpf_kfuncs.h       |  6 +++---
> > > > >  .../selftests/bpf/progs/dynptr_success.c       |  6 +++---
> > > > >  .../bpf/progs/test_kfunc_dynptr_param.c        |  7 +------
> > > > >  8 files changed, 43 insertions(+), 32 deletions(-)
> > > > >
> > > > > diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> > > > > index 6a35623ebdf0..3840436e4510 100644
> > > > > --- a/fs/verity/measure.c
> > > > > +++ b/fs/verity/measure.c
> > > > > @@ -118,7 +118,7 @@ __bpf_kfunc_start_defs();
> > > > >   *
> > > > >   * Return: 0 on success, a negative value on error.
> > > > >   */
> > > > > -__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struc=
t bpf_dynptr *digest_p)
> > > > > +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, const=
 struct bpf_dynptr *digest_p)
> > > >
> > > > but kfunc is writing into digest_p, so that const is wrong?...
> > > >
> > > > >  {
> > > > >         struct bpf_dynptr_kern *digest_ptr =3D (struct bpf_dynptr=
_kern *)digest_p;
> > > > >         const struct inode *inode =3D file_inode(file);
> > > >
> > > > [...]
> > > >
> > > > > index 6eb6c82ed2ee..3d44896587ac 100644
> > > > > --- a/kernel/bpf/helpers.c
> > > > > +++ b/kernel/bpf/helpers.c
> > > > > @@ -3000,8 +3000,8 @@ __bpf_kfunc int bpf_dynptr_clone(const stru=
ct bpf_dynptr *p,
> > > > >   * Copies data from source dynptr to destination dynptr.
> > > > >   * Returns 0 on success; negative error, otherwise.
> > > > >   */
> > > > > -__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u64 =
dst_off,
> > > > > -                               struct bpf_dynptr *src_ptr, u64 s=
rc_off, u64 size)
> > > > > +__bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr=
, u64 dst_off,
> > > >
> > > > again, dst_ptr clearly is modifiable because we are copying data in=
to it.
> > > >
> > > > What am I missing, why is this logically correct?
> > > >
> > > > (I understand that from purely C type system POV this is fine, beca=
use
> > > > we don't modify bpf_dynptr struct itself on the stack, but bpf_dynp=
tr
> > > > is a representation of some memory, and if we are modifying this
> > > > memory, then I think it should be not marked as const)
> > >
> > > The patch is just to first make the arg type determination independen=
t
> > > from bpf_reg_state and make kfunc signature consistent based on what
> > > commit 52f37c4e0f11 (bpf: Rework process_dynptr_func) has laid out.
> > >
> > > Perhaps MEM_RDONLY is a bit misleading. In process_dynptr_func(), the
> > > flag means the dynptr struct on the stack is immutable. Currently,
> > > there is no way (and maybe no need?) to specify read-only dynptr.
> > >
> >
> > are you basically trying to determine if CONST_DYNPTR_PTR is allowed or=
 not?
>
> Yes.
>
> >
> > > > > The verifier should decide whether a dynptr argument is read-only
> >
> > can you please remind us what "read-only dynptr argument" means for ver=
ifier?
>
> Oh well... my apologies for the inconsistency in commit message and
> comments. It should be "immutable" instead of "read-only" here.

I guess I'd suggest

struct bpf_dyntpr *const dptr

to mark this through type system? that is, *constant pointer* to
dynptr, not a pointer to *constant dynptr*

WDYT?

>
> >
> > > >
> > > > > +                               const struct bpf_dynptr *src_ptr,=
 u64 src_off, u64 size)
> > > > >  {
> > > > >         struct bpf_dynptr_kern *dst =3D (struct bpf_dynptr_kern *=
)dst_ptr;
> > > > >         struct bpf_dynptr_kern *src =3D (struct bpf_dynptr_kern *=
)src_ptr;
> > > >
> > > > [...]

