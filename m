Return-Path: <netdev+bounces-267169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID70ORfxsmloRAAAu9opvQ
	(envelope-from <netdev+bounces-267169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 18:00:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D702763C4
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 18:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C31823001FB5
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4361F3F65F4;
	Thu, 12 Mar 2026 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWCSX92D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A0337DE99
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334764; cv=pass; b=UG+STUeUetRIEqYIl/PgHkF/RNr6nFwhMZ93LV3LaRZlCsx01xzr+MtVEpIBpUBRtwEZaTzYUmt+eAQtcN7sQxOTk7NuZh0JTiLXORCXvDSbj9hUlkOiWMdXxMcx1hB7WC/kiDcBjPhFC1RQyY3/Wlce3kgZuW5Z283AWy0mQlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334764; c=relaxed/simple;
	bh=M2iymQZKX+8vHWjM+sGVXO0KItugHB5MFB2eFn6DzUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pak1By+LOCSk5spSXcnn4GRbg9AJd5q8OOrMF6eVdyGV7fOpoTy5YWDnrlDMr7aMRvDPL5ZPaAudkLUosNKNybX/KHJNN4EcVsNi8t0e5s9zlQAsbtXQVhHDok/P/QFj4chUtBbs4z4iFD5XPx3xqKH163Jgzu4dfvK2nZT1Agg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWCSX92D; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79863ab8478so13054157b3.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 09:59:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773334762; cv=none;
        d=google.com; s=arc-20240605;
        b=Kv7NqB/dV3No343VZilESolF8CmcSNQult1DXiX/7yoksT2JM4N3QMgG6VxeNjLZkV
         YXAEGphmsoJ4BlwYgMoJeK9HcKw5xG7dDGIQ1gLMooYG4ieXOzRkTm2qjpV6yFrm7roO
         L3KFQNcY2FEocHYMmTDNSOcwwWyWk5zcIXwCEfz7n9QsycagFJcPnmgOji8UzHOJPIPT
         bUQXpPP66Csj0rIiBjDbCWpsBbb13TlEKxyNBsNtAELCtc2IaDOOMnFkRclF4jev1fs1
         qJeaemzhi07IRlRP1BMDrrM+VxTtEMrp0GYLLDWPRGTMLiyXP/kIqZVFqH13xFFOfvR2
         5FEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RmhvuLaKjTTuQXwRd83noFpknqFUxs50sL6rs4k8AXI=;
        fh=RDN2ABwCs0SnPiYjARsd0nRqD08v2ablqub58+h9JgM=;
        b=JkOadXJnDI/4R4wg1HbYpEj1aAEvJfGjd+yk8KYyTryHL21IaXfCDZl8ukB98QPcCH
         2jfVKBggiCpdLgV4DIhHOak989g/tR0edrHrrxE36efBuPgo5mPw9KyExxwUqKAmM1v3
         2n3BDrMvZcW8t9DkcZQrdHd18ppf8dOaNLshox3sjJ8ZMJ1BKHkKNSEGYoOJ4lmb39Uc
         e5Kfv1kSuE4b2jtq+IkdYsD48xJ4iWGJAR6/7SbFURl42RO9e/JCCLeAghyCM/UKEFcl
         FFn0C+IB42Dow9F+GkCPIy7AjBWEDzHXfuEuai8v1TVA3caS4iUPeUeOROHiHUnvpVK7
         dUsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773334762; x=1773939562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmhvuLaKjTTuQXwRd83noFpknqFUxs50sL6rs4k8AXI=;
        b=gWCSX92DxRzsHIArEfcyFHW1BcfGsf4MTfVadaYPiInZHJSy//LNws/N47+3iZbVeZ
         If6eZzxrP9PAluwd8KIFKsQ9hE7+y0gWOS3lWjw/8oifly41rVrtf88/4lUB86Rhydxy
         mf26a8CC+UGfgpvZhpkmSYywbkwlVebSHt81+sH2Ug0063exXBXzgiwib05Lljd6h58O
         AHyYoByEy5y7OM4lbUyaBE5Lxfn78MjW1CcQIF7biPdrUee+eLeYufz7luROimahmkK7
         45GNU7LRWrJ49jbze4q07mcas4aOkRNm212rvvGxd5ngT+PNbKs9nO7OzCbkVxWq+1ZR
         90pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773334762; x=1773939562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RmhvuLaKjTTuQXwRd83noFpknqFUxs50sL6rs4k8AXI=;
        b=IaYcpBUrHBrA/PQsLxWFqZIBytjPlwVXwPraaF3vw26D2u7PgXMFFHqck6LuifoNCF
         iPenfYL0fjuVnM9hGgZ9meD9bIuzwtZovfljfGnL+YnXcUQop8viS616I3fYvVTfnABV
         gkcVyVXiR8a41fvsr3ZIVGqpqnbUj1dzH/g4VVKioFK6qSmt9uy2eA2V++SQy0+hdaH8
         +lf8s7VkjobsFmJzItm9SPaEWCtS4k4SVylXcLgtrsgjqnDy6aK3wzcRubmCTjPw7PBQ
         9m+T6XJY4cvR8UuiZ4lfby6NV3F5Xk/uFZuIMgojHY0ytinYE/EREUEEGv3zG7jNONiN
         ddWg==
X-Forwarded-Encrypted: i=1; AJvYcCU2KIHHnXdsW4MDFV4OANjIoZfIXWVCvYSkoV4FFCuVEgtaDZI61tnfQMmzAolkUpBbNuZ/FhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp2iTo8FQT9orPXIaHsqUmKFcEHx42cAqiZ9JNftdL615nJEuw
	fk9/Yrzu51etSxiXyCF0yRuQu7AhBkIH/J8ggf4h4KC1EF7w955qSQM1+AWowhLV3aNOMqd7Pox
	4cjHnypwCDVPb2kqvUND5SzSzBjFZglQ=
X-Gm-Gg: ATEYQzxU6keQ8CHCzb7wahDPA41U+atKbemrkfV1TS76DSS7dadt5F3XgssLU5e4+pa
	lNE5gngfh3YRGVQlENZkxhMoE8G4d7PxC1cXC/wiJZfNPMjcajdQCOP5tjisddD3X9ikL71Z5Pi
	mKipVqb91Y8DlF3anFaKHadtnY7U65s99fDCFVB+UC3UlNdk06byu8zNQ03an/4vBqZuR83VgyC
	VgniKpLy/XjUnl227+mQWVFgunbxqK2bJCL4Te2xetLUaUVLcPYeiRwUSWfscgY70VafD+HhX80
	YXFZs4qyptT5on/E1C/w0X0=
X-Received: by 2002:a05:690c:f06:b0:796:4235:ea1c with SMTP id
 00721157ae682-79a1c1881a6mr2948747b3.40.1773334761723; Thu, 12 Mar 2026
 09:59:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-2-ameryhung@gmail.com>
 <CAEf4BzZubPSaS8SQSEQJvTphwgbaBfdC0CYEhsfQN8CJ7HS3pw@mail.gmail.com>
 <CAMB2axNR6qPRVy5YCiMygVseS+k9JxY9DFONNHD5Lt8=wD9MGQ@mail.gmail.com>
 <CAEf4BzYTO9e-UAEd+W+ftqQZLUZCWHWXAYVnVjHeNtsZL1=Pdw@mail.gmail.com>
 <CAMB2axN+8+V+29r9tuoVF57ObpvkUE5d5_8jtd5iRPYq4_gLGg@mail.gmail.com> <CAEf4BzY1O1Ne9Rf+O2terCT8f9e6pNFr3N4hOv98N84ZoehCaw@mail.gmail.com>
In-Reply-To: <CAEf4BzY1O1Ne9Rf+O2terCT8f9e6pNFr3N4hOv98N84ZoehCaw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 12 Mar 2026 09:59:10 -0700
X-Gm-Features: AaiRm53ZaiCWGNz9hMLXMLHUgWZMOtoU8omxpXk2jjffjeh5iM3eI87em5sVbOU
Message-ID: <CAMB2axN8Qe6r_siq5_6od7D_kDZPcYw_Z6KVOFtXNJVKzajqzw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267169-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05D702763C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 4:15=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Mar 11, 2026 at 4:03=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > On Wed, Mar 11, 2026 at 3:37=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Mar 11, 2026 at 1:01=E2=80=AFPM Amery Hung <ameryhung@gmail.c=
om> wrote:
> > > >
> > > > On Wed, Mar 11, 2026 at 12:44=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gma=
il.com> wrote:
> > > > > >
> > > > > > The verifier should decide whether a dynptr argument is read-on=
ly
> > > > > > based on if the type is "const struct bpf_dynptr *", not the ty=
pe of
> > > > > > the register passed to the kfunc. This currently does not cause=
 issues
> > > > > > because existing kfuncs that mutate struct bpf_dynptr are const=
ructors
> > > > > > (e.g., bpf_dynptr_from_xxx and bpf_dynptr_clone). These kfuncs =
have
> > > > > > additional check in process_dynptr_func() to make sure the stac=
k slot
> > > > > > does not contain initialized dynptr. Nonetheless, this should s=
till be
> > > > > > fixed to avoid future issues when there is a non-constructor dy=
nptr
> > > > > > kfunc that can mutate dynptr. This is also a small step toward =
unifying
> > > > > > kfunc and helper handling in the verifier, where the first step=
 is to
> > > > > > generate kfunc prototype similar to bpf_func_proto before the m=
ain
> > > > > > verification loop.
> > > > > >
> > > > > > We also need to correctly mark some kfunc arguments as "const s=
truct
> > > > > > bpf_dynptr *" to align with other kfuncs that take non-mutable =
dynptr
> > > > > > argument and to not break their usage. Adding const qualifier d=
oes
> > > > > > not break backward compatibility.
> > > > > >
> > > > > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > > > > ---
> > > > > >  fs/verity/measure.c                            |  2 +-
> > > > > >  include/linux/bpf.h                            |  8 ++++----
> > > > > >  kernel/bpf/helpers.c                           | 10 +++++-----
> > > > > >  kernel/bpf/verifier.c                          | 18 ++++++++++=
+++++++-
> > > > > >  kernel/trace/bpf_trace.c                       | 18 +++++++++-=
--------
> > > > > >  tools/testing/selftests/bpf/bpf_kfuncs.h       |  6 +++---
> > > > > >  .../selftests/bpf/progs/dynptr_success.c       |  6 +++---
> > > > > >  .../bpf/progs/test_kfunc_dynptr_param.c        |  7 +------
> > > > > >  8 files changed, 43 insertions(+), 32 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> > > > > > index 6a35623ebdf0..3840436e4510 100644
> > > > > > --- a/fs/verity/measure.c
> > > > > > +++ b/fs/verity/measure.c
> > > > > > @@ -118,7 +118,7 @@ __bpf_kfunc_start_defs();
> > > > > >   *
> > > > > >   * Return: 0 on success, a negative value on error.
> > > > > >   */
> > > > > > -__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, str=
uct bpf_dynptr *digest_p)
> > > > > > +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, con=
st struct bpf_dynptr *digest_p)
> > > > >
> > > > > but kfunc is writing into digest_p, so that const is wrong?...
> > > > >
> > > > > >  {
> > > > > >         struct bpf_dynptr_kern *digest_ptr =3D (struct bpf_dynp=
tr_kern *)digest_p;
> > > > > >         const struct inode *inode =3D file_inode(file);
> > > > >
> > > > > [...]
> > > > >
> > > > > > index 6eb6c82ed2ee..3d44896587ac 100644
> > > > > > --- a/kernel/bpf/helpers.c
> > > > > > +++ b/kernel/bpf/helpers.c
> > > > > > @@ -3000,8 +3000,8 @@ __bpf_kfunc int bpf_dynptr_clone(const st=
ruct bpf_dynptr *p,
> > > > > >   * Copies data from source dynptr to destination dynptr.
> > > > > >   * Returns 0 on success; negative error, otherwise.
> > > > > >   */
> > > > > > -__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u6=
4 dst_off,
> > > > > > -                               struct bpf_dynptr *src_ptr, u64=
 src_off, u64 size)
> > > > > > +__bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_p=
tr, u64 dst_off,
> > > > >
> > > > > again, dst_ptr clearly is modifiable because we are copying data =
into it.
> > > > >
> > > > > What am I missing, why is this logically correct?
> > > > >
> > > > > (I understand that from purely C type system POV this is fine, be=
cause
> > > > > we don't modify bpf_dynptr struct itself on the stack, but bpf_dy=
nptr
> > > > > is a representation of some memory, and if we are modifying this
> > > > > memory, then I think it should be not marked as const)
> > > >
> > > > The patch is just to first make the arg type determination independ=
ent
> > > > from bpf_reg_state and make kfunc signature consistent based on wha=
t
> > > > commit 52f37c4e0f11 (bpf: Rework process_dynptr_func) has laid out.
> > > >
> > > > Perhaps MEM_RDONLY is a bit misleading. In process_dynptr_func(), t=
he
> > > > flag means the dynptr struct on the stack is immutable. Currently,
> > > > there is no way (and maybe no need?) to specify read-only dynptr.
> > > >
> > >
> > > are you basically trying to determine if CONST_DYNPTR_PTR is allowed =
or not?
> >
> > Yes.
> >
> > >
> > > > > > The verifier should decide whether a dynptr argument is read-on=
ly
> > >
> > > can you please remind us what "read-only dynptr argument" means for v=
erifier?
> >
> > Oh well... my apologies for the inconsistency in commit message and
> > comments. It should be "immutable" instead of "read-only" here.
>
> I guess I'd suggest
>
> struct bpf_dyntpr *const dptr
>
> to mark this through type system? that is, *constant pointer* to
> dynptr, not a pointer to *constant dynptr*
>
> WDYT?

I think they both make sense from different angles, but I am not sure
which one is better.

From purely C's point of view. the pointer points to a struct dynptr
that should not be mutated so "const struct dynptr *p" is correct.

From the BPF dynptr abstraction's point of view, the pointer points to
the underlying memory (e.gg., skb, file, ringbuf, etc.), so "struct
dynptr * const p".

Any way we choose, I'd suggest that to be a separate patch. This patch
at least makes things consistent and fixes a logical bug.

>
> >
> > >
> > > > >
> > > > > > +                               const struct bpf_dynptr *src_pt=
r, u64 src_off, u64 size)
> > > > > >  {
> > > > > >         struct bpf_dynptr_kern *dst =3D (struct bpf_dynptr_kern=
 *)dst_ptr;
> > > > > >         struct bpf_dynptr_kern *src =3D (struct bpf_dynptr_kern=
 *)src_ptr;
> > > > >
> > > > > [...]

