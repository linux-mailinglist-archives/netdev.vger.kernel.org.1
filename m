Return-Path: <netdev+bounces-266794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKQ4Cbj0sWl7HQAAu9opvQ
	(envelope-from <netdev+bounces-266794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 00:03:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6DA26B0C7
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 00:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FC6930364DE
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E896439936B;
	Wed, 11 Mar 2026 23:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI607PNC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED3236DA1E
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 23:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270197; cv=pass; b=kEzqSjg8lmBttN17tqz8nDuRtqWqIOeLcfgaJiibONAcy94lKjGXr9AZBDjYTVe1SuG06iarcQIxhpruAVT+3Tr4tEWdsNzWG/aicZcrVvepb0gf0Of84aEapQ83VeF9FXtGuFgWd5gdWNeaQokc8YvAflDCwRdlaSobXAhmB1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270197; c=relaxed/simple;
	bh=J2BzAUt05n/jQUFtmc1TlupJWF+4/koq5zZ9Fy6XhQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHRl/oyBnUZ6IWIh+Hfxm/RZp6jfrl39g4NGDqgdFPBIhiSuHZOk1SvUZu9ZICQ9k68WyUNrhJ0Jzjgs4mLw0DxZ+hOmZpidmN2X/gHpugS5loq9naDi3pTDMULGDpTY2A+kj5OERlXxHvpQ+Il+psBrPRs2CQQXq6H21S8xtgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI607PNC; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7986c7b8076so4540057b3.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 16:03:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773270194; cv=none;
        d=google.com; s=arc-20240605;
        b=dF/4xM70xfwNH/HBkb2sJjANqvC15QnLOQG/oxzwrInW8N9GNBDLsfFrXqHwz/HsoU
         YKrPRr2XmAyDiMwNm0GNQ503GK83mDAUR/cYgZSsdd3NT8Go1VuENXDEvUv8g+q6TTZb
         59QTvfHItqqkNi9Tv+kcd51WrfNM/4OpNY5zbFyPj7onjygq1lrDyITp8ItjdN4AnXdm
         /udiRslf7lPKtQw5w2aPeV+SBVmJ21oU5YL4xPEEpHo4l+uuRhtLV9ZsQnkB8g4wesnO
         NqMMLTuqMSqrUuA0xYf1/+AZlogMXJIwbCh0uEciDJJkUGkcsmrRrA+UF8qi6NQC3+Sq
         b9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p1nL4RVoOG6FSE4X+rL71zaGJT8RA06evE5D7IZSb+4=;
        fh=oAhSs5qQMPDlEvpSjXAyyhEK0Ibl0MoygGWOFyncFiw=;
        b=k9MBXIqf8PR0+SwYZftXZyq3MSV/E+z0uzjOEjCoBdZKFP8zD+1KUm1WHOvX/xdybq
         nZVPcqiEKArbYpKdFRfrozI2pWFhQjzhqqjY85YBPstdcrlbPt9lcO90SxLWTg4KJMWT
         gqTtFOUEE8LjArQEOa0MLMUJdwNN4y1HA6JrEb5uruqL89K0DrDYDejyPdgDeoFOF769
         L3WC870S0TVMOxPOJUMihklay/tK0/ZeuEzDKKyQdijbpNYV98ZA+KmhZxWnbQftFU1k
         ULysC20gj44IFeSsXsYRKDIs8+fT1L9aWEDey/j9HFH3T/1Z8S3cJMfy+1u5pwtaQyjg
         jS9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773270194; x=1773874994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1nL4RVoOG6FSE4X+rL71zaGJT8RA06evE5D7IZSb+4=;
        b=SI607PNCZjKM5J0PC0HQcoesj7tVYrSrqvSCl7W858mfWaUoAzl8ktUdNAM1wKztWn
         6j5OJtTwYbkaJIXnillXl5lLp9SM1cghr42ndR4YXIi20ibGq4sB8/9qmUjN2dxcaF1b
         jh/X2ZAU68gW3BZz/DX7zjX/9Xp8dcrxw70XGdYFSjv8lpZd0ubx/QXKbHfHC8v/KCPk
         jWoCVRgahLMXUhZAOpk1NAbrydllGAZQLTuJ6oSkGp7QYmc9Y58rs8xH/xrYGz01Fd8o
         hxjwrlxM2DqY13zmyg0+HCw91RcxKAYf67REeM8s3Tg+lU9K4F9LUBDY57QrWHcs3pbY
         7c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773270194; x=1773874994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p1nL4RVoOG6FSE4X+rL71zaGJT8RA06evE5D7IZSb+4=;
        b=d8/2l0IO0qFfYdquaJToI1tJmvtKL2TjOnNxMTC/QxwSduO2ZunVS4kh01RAMaod8s
         HH0aEQ6TwiTI66cM2uUdpjDBToB7dWu7Hl/VKzWe/oHnMTZUr6AGdGCB+3+uJnLWFAXd
         0yX/qB88sabVTMVLIMUKeXVZGj6+h9yZao7LjXFTLKtTMf3Mv3Wau+5DHdacrAOzYz1J
         6fDhYw0FtJf7veuRAX7HXy7nfGpiUmCpttjv4QIjdBwTgnzceRuItNMT6CnpvQT6G94b
         ycXvM/nyrvkqnJ4oPS6AjUpP1mP1yV/w3YV8x+Cp2hQ8TAuD8KgJkH12ml/ssIjNU5yC
         YLvw==
X-Forwarded-Encrypted: i=1; AJvYcCUWX+H1GnqUHIb34gvYlg2lqwH6AXtxreqkx7qoxpkpclRAAwdnkgvMtr2TFDKBZmAV02iUc88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIN7PhqO59NCUNrUwPoKmT5L1pHMLzWTTqgAdO3br0iwJ2ICBi
	v15WyPdiVprIVjRrrcngKOD9+0chaPypY8tYh735r4FsaXAYiegtc/MK7/b3AFUCgSUSfXoejS0
	lycfsRod7mEIWzImESpyp2q7GRlYtayg=
X-Gm-Gg: ATEYQzx58f8qVOSR98OGHMiW6NMU059/GIk9dqihrdEkFSrV2QcaW9RFJc9yCRx6ORY
	FW8n424Ahw9foezkX3RuSgaKIEnC+qPZ1g4hW4CbgcEHshvaSvdBwf8JNSDAhTnDc7hLe/geqBD
	aHmU/JZG6EN9vv+Iub7fcSFr2xarpFdOdkkdb7u2h8nzwhEH/UsMB/oCGK8h1FcCTi62CqHdejg
	j9Jnw93jpJhZx6yuIFmxn46G0oywcl9u+3twx86BeWl4LEpITKXeYMbkC95OTCCXECGdpPW7VZP
	BsF2T1U=
X-Received: by 2002:a05:690c:6e84:b0:794:78d0:9b57 with SMTP id
 00721157ae682-79917e9de17mr39016587b3.16.1773270194093; Wed, 11 Mar 2026
 16:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-2-ameryhung@gmail.com>
 <CAEf4BzZubPSaS8SQSEQJvTphwgbaBfdC0CYEhsfQN8CJ7HS3pw@mail.gmail.com>
 <CAMB2axNR6qPRVy5YCiMygVseS+k9JxY9DFONNHD5Lt8=wD9MGQ@mail.gmail.com> <CAEf4BzYTO9e-UAEd+W+ftqQZLUZCWHWXAYVnVjHeNtsZL1=Pdw@mail.gmail.com>
In-Reply-To: <CAEf4BzYTO9e-UAEd+W+ftqQZLUZCWHWXAYVnVjHeNtsZL1=Pdw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 11 Mar 2026 16:03:02 -0700
X-Gm-Features: AaiRm52aqQKm9IrpolvS8vKyhIuaxkmlqQ4ERAyf1ATinHmIsdtysTaU_QZQ0OY
Message-ID: <CAMB2axN+8+V+29r9tuoVF57ObpvkUE5d5_8jtd5iRPYq4_gLGg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 01/11] bpf: Set kfunc dynptr arg type flag
 based on prototype
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266794-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B6DA26B0C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 3:37=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Mar 11, 2026 at 1:01=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > On Wed, Mar 11, 2026 at 12:44=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.c=
om> wrote:
> > > >
> > > > The verifier should decide whether a dynptr argument is read-only
> > > > based on if the type is "const struct bpf_dynptr *", not the type o=
f
> > > > the register passed to the kfunc. This currently does not cause iss=
ues
> > > > because existing kfuncs that mutate struct bpf_dynptr are construct=
ors
> > > > (e.g., bpf_dynptr_from_xxx and bpf_dynptr_clone). These kfuncs have
> > > > additional check in process_dynptr_func() to make sure the stack sl=
ot
> > > > does not contain initialized dynptr. Nonetheless, this should still=
 be
> > > > fixed to avoid future issues when there is a non-constructor dynptr
> > > > kfunc that can mutate dynptr. This is also a small step toward unif=
ying
> > > > kfunc and helper handling in the verifier, where the first step is =
to
> > > > generate kfunc prototype similar to bpf_func_proto before the main
> > > > verification loop.
> > > >
> > > > We also need to correctly mark some kfunc arguments as "const struc=
t
> > > > bpf_dynptr *" to align with other kfuncs that take non-mutable dynp=
tr
> > > > argument and to not break their usage. Adding const qualifier does
> > > > not break backward compatibility.
> > > >
> > > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > > ---
> > > >  fs/verity/measure.c                            |  2 +-
> > > >  include/linux/bpf.h                            |  8 ++++----
> > > >  kernel/bpf/helpers.c                           | 10 +++++-----
> > > >  kernel/bpf/verifier.c                          | 18 ++++++++++++++=
+++-
> > > >  kernel/trace/bpf_trace.c                       | 18 +++++++++-----=
----
> > > >  tools/testing/selftests/bpf/bpf_kfuncs.h       |  6 +++---
> > > >  .../selftests/bpf/progs/dynptr_success.c       |  6 +++---
> > > >  .../bpf/progs/test_kfunc_dynptr_param.c        |  7 +------
> > > >  8 files changed, 43 insertions(+), 32 deletions(-)
> > > >
> > > > diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> > > > index 6a35623ebdf0..3840436e4510 100644
> > > > --- a/fs/verity/measure.c
> > > > +++ b/fs/verity/measure.c
> > > > @@ -118,7 +118,7 @@ __bpf_kfunc_start_defs();
> > > >   *
> > > >   * Return: 0 on success, a negative value on error.
> > > >   */
> > > > -__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct =
bpf_dynptr *digest_p)
> > > > +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, const s=
truct bpf_dynptr *digest_p)
> > >
> > > but kfunc is writing into digest_p, so that const is wrong?...
> > >
> > > >  {
> > > >         struct bpf_dynptr_kern *digest_ptr =3D (struct bpf_dynptr_k=
ern *)digest_p;
> > > >         const struct inode *inode =3D file_inode(file);
> > >
> > > [...]
> > >
> > > > index 6eb6c82ed2ee..3d44896587ac 100644
> > > > --- a/kernel/bpf/helpers.c
> > > > +++ b/kernel/bpf/helpers.c
> > > > @@ -3000,8 +3000,8 @@ __bpf_kfunc int bpf_dynptr_clone(const struct=
 bpf_dynptr *p,
> > > >   * Copies data from source dynptr to destination dynptr.
> > > >   * Returns 0 on success; negative error, otherwise.
> > > >   */
> > > > -__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u64 ds=
t_off,
> > > > -                               struct bpf_dynptr *src_ptr, u64 src=
_off, u64 size)
> > > > +__bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, =
u64 dst_off,
> > >
> > > again, dst_ptr clearly is modifiable because we are copying data into=
 it.
> > >
> > > What am I missing, why is this logically correct?
> > >
> > > (I understand that from purely C type system POV this is fine, becaus=
e
> > > we don't modify bpf_dynptr struct itself on the stack, but bpf_dynptr
> > > is a representation of some memory, and if we are modifying this
> > > memory, then I think it should be not marked as const)
> >
> > The patch is just to first make the arg type determination independent
> > from bpf_reg_state and make kfunc signature consistent based on what
> > commit 52f37c4e0f11 (bpf: Rework process_dynptr_func) has laid out.
> >
> > Perhaps MEM_RDONLY is a bit misleading. In process_dynptr_func(), the
> > flag means the dynptr struct on the stack is immutable. Currently,
> > there is no way (and maybe no need?) to specify read-only dynptr.
> >
>
> are you basically trying to determine if CONST_DYNPTR_PTR is allowed or n=
ot?

Yes.

>
> > > > The verifier should decide whether a dynptr argument is read-only
>
> can you please remind us what "read-only dynptr argument" means for verif=
ier?

Oh well... my apologies for the inconsistency in commit message and
comments. It should be "immutable" instead of "read-only" here.

>
> > >
> > > > +                               const struct bpf_dynptr *src_ptr, u=
64 src_off, u64 size)
> > > >  {
> > > >         struct bpf_dynptr_kern *dst =3D (struct bpf_dynptr_kern *)d=
st_ptr;
> > > >         struct bpf_dynptr_kern *src =3D (struct bpf_dynptr_kern *)s=
rc_ptr;
> > >
> > > [...]

