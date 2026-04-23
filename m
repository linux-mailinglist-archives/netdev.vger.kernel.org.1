Return-Path: <netdev+bounces-280836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDPlCoto6mkHzAIAu9opvQ
	(envelope-from <netdev+bounces-280836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:44:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 296E44562D0
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE9313009F0B
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50513AE6FB;
	Thu, 23 Apr 2026 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/sgCpNj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8EA3115BD
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776969859; cv=pass; b=gzs7CZFF3tYjzRNwCbU/lbtQGiwgtSpI2MIDOP19J83bX9FDrWrnzBhoBT9HCtlX3vUJwbiueiWgxpk1H0lfXW2pIHyAyfcz4C+b6d7+ee6yTDB5mqrj7qJKyqmSsV8ysXjW48DNlWx32a+LxW9KCByKXdro6U9Xds2Ip26IYEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776969859; c=relaxed/simple;
	bh=Y8g/nKzxS2O/jBt83iUAcdJpECu7E+NhYCiwI8IkdDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXKbkYFuanFpt2vvFmDE3ku7CiF1kIvfBEtamWANoHMg4z5XNhRpI9f3EG3fiPXchu0G/FV0mSaysZpZ6U/loj0oy+YvoDi/P5a8aallLDrldxUW+D9JPaugIbMi8bJT3QtrMFESoTTbTptPsMPRVQRNqvbHIMF6LqgJt59O0+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/sgCpNj; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7b186dfc1d0so102451317b3.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 11:44:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776969856; cv=none;
        d=google.com; s=arc-20240605;
        b=IAfIa/KQ2zS6f7jQLNCXeoaamZuNZrzUCgZWmM7qFBhgTT2yca3nw//1X0/mW9gCq0
         SwxwbqkP9GvPBQHehdHvpO9acCvflUfMX9BYbKUtI2WgXctqu+qLIPZluM4Gsttd8iNs
         t7Q2QiUYnQ++DTR3UTPt1gw/J3+jiFZW4T5DvtSUDn1EU6sz3zfAgU2u0BIzwVd6WDJa
         1MHo40WabmNyz+p1iiA1sIA4b3UZXOTOKbiJDO82sBtvMKHHKL+rjs5+wQRgTQgPoMXv
         6Lbhwpxb6+pznJaNuXGTxbOCV1YKYGKHbFjLWB81Eh1n9cnpSOw6RorZfcF0fD5YdDLc
         Cu2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wO6E3RAxt0kBsAc7vQIu6tD0EXwfc5BAxzyEJrHqViA=;
        fh=Zr3p9xZa7ys3trr60Xxi+HWdl1E44xIm9FhSWOJHU8o=;
        b=cXm0++d0PRlAKiHVWXa9+81lsbCyJ+6Wrqt/Xp2rUQCY3rmjex3vJ1e1EEmke0QZVm
         /tPSnrEOaPx3zLASg+BocQ5UZtDH3HR9xAfisTOYN1f1XBBmrLaeJ5nDXQST3aJkCE3g
         s8brQOMj7TJYilalgc/RuPdT6S5ec1sUhVwMd7IXvu2GUQSCxWjsaFkxLEqirwj6KkPQ
         Yy30Ryz93ACyt83T076Qx303RyyeLoN2wgdUNbioPDjOEldfzu+KzsWrtFYoUmdRvXx6
         Unx/TkFBZnyMJGA8k7qvD69Rck8sCctYKs7n4euKN++OOW0mY0U3r3D3E47zPvdHkxHj
         L91g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776969856; x=1777574656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wO6E3RAxt0kBsAc7vQIu6tD0EXwfc5BAxzyEJrHqViA=;
        b=R/sgCpNj2U+/oW6McT8v9dCYy10g1pIWDVeVCYFmIsmvG+SHRyYLxaQm4qy0wse19h
         wXyZe+6LP85zznKUtCMPLgE3MNE1Wtbm9NclI12L4+Ivm6HbbafNEaCb79RQzC2FZPzJ
         XzTWfk644zT5Ivc1B2SJZSEF9LjVk6Bg5KCgpGBkzw8eGBSZnFN9LxD2Dzsgsd4w1UeG
         pjf1vvejJDmWGg5zWT/1yq+1FkUFfaV2uOBpN1u2vt9wRgCOgHhHgl/AEXCBt5lYXxm4
         D+PfITNgHClKCYe8kvQs4jttOVWneuhWkoMIv2+LRrkNUNgfWM/SbvkdtIoQcENIh2oz
         FXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776969856; x=1777574656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wO6E3RAxt0kBsAc7vQIu6tD0EXwfc5BAxzyEJrHqViA=;
        b=XREpDtidCUyvPfM9K59z0C/lxSs/t7oS3weHYDwGLGlIIo66qa5aDmOoMV7Gu/sE3B
         hb0qtgT1xw5JB2N6Ua1EQVwI2EFhdC+Itnus9JcL9nPX/4zgo5JVWTS42GXtqd5EH8K+
         eaMf7uy1Twy9XKIrFqb7bcePv+PZ2wURjce6TTXTpVTv+cROOCaLOlhuXbecnN+KOPfl
         dVKPM2Blsnm6acbuUJvp2dtU677L5NFfZ7XAavFf4kCg5SS/zAXsi2iNxhFGEtgONOoX
         haZkZ+49Knjl9bAgUGa9DML/0VYW+AHv5CYJx7JVCubygi4xB5bJAbEsQWNeL1Hx9jQv
         YMlw==
X-Forwarded-Encrypted: i=1; AFNElJ/F80IUfVZ5OJp2dDNqFDaN1I/wzEOJR+k0ao6+tz8jvit61hTzt5q6JczBmSDeqbxWLsOIERw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXy/TeCVn+F9+B6V/+v30thghv1rbnYVuR0UFlAYl5A9JDfjB7
	pzcJWylXr9CWSK08mKKERrvBaqdHm5ZGkNLRf8Bj0UsISbGDwYag9+lKKPzHKtPa5hAoSPHatwO
	VxtPsLVK2YP8zT6B8OXPglUZLNkVovmg=
X-Gm-Gg: AeBDievuPn7uTY/vCpJH16NAe9YriNpVztu++IDftc2c5Ho4Bw/Fu6vs651OGpsYWWB
	emOSIyWdVO1UU59tycYdJ8SdZP8WOgAT+LUhqJUDHBfD9jzOasQH0jWFyU1cy9bK38LkZpWap61
	jnOb5VUJLSdRSDbZ8l4JlkTRBue/uqJC5C2pFUr2jyk3sscB2pzJN2agfJwKkOEdslrQL3jsu7Q
	IurBZWckCGIvggKdfwY/6ugcQ7gRDd5ZF2lOSHftQXdP2BgZ0krvOTjI/XSWycyxTo+ZctKroCc
	1FsWJy14D58j786l3DKWMo43EHNQjpw=
X-Received: by 2002:a05:690c:f14:b0:7ba:d5fb:b547 with SMTP id
 00721157ae682-7bad5fbbf52mr182131057b3.7.1776969856071; Thu, 23 Apr 2026
 11:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <20260421221016.2967924-5-ameryhung@gmail.com>
 <4de82d94-a975-4703-b45e-8932dfc28248@gmail.com>
In-Reply-To: <4de82d94-a975-4703-b45e-8932dfc28248@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 23 Apr 2026 11:44:03 -0700
X-Gm-Features: AQROBzDWbEW8UwRyQH8fuvc9W4E30-SWV8ajl8OvK1C5YzG1Zjx1JJtxEZsH1Z0
Message-ID: <CAMB2axO5TJwmYyvRheoZGH4ktRa0d8ig-UGK5E269iVoDH-zPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/9] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-280836-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 296E44562D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 11:19=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
>
> On 4/21/26 11:10 PM, Amery Hung wrote:
> > Refactor object relationship tracking in the verifier and fix a dynptr
> > use-after-free bug where file/skb dynptrs are not invalidated when the
> > parent referenced object is freed.
> >
> > Add parent_id to bpf_reg_state to precisely track child-parent
> > relationships. A child object's parent_id points to the parent object's
> > id. This replaces the PTR_TO_MEM-specific dynptr_id and does not
> > increase the size of bpf_reg_state on 64-bit machines as there is
> > existing padding.
> >
> > When calling dynptr constructors (i.e., process_dynptr_func() with
> > MEM_UNINIT argument), track the parent's id if the parent is a
> > referenced object. This only applies to file dynptr and skb dynptr,
> > so only pass parent reg->id to kfunc constructors.
> >
> > For release_reference(), invalidating an object now also invalidates
> > all descendants by traversing the object tree. This is done using
> > stack-based DFS to avoid recursive call chains of release_reference() -=
>
> > unmark_stack_slots_dynptr() -> release_reference(). Referenced objects
> > encountered during tree traversal cannot be indirectly released. They
> > require an explicit helper/kfunc call to release the acquired resources=
.
> >
> > While the new design changes how object relationships are tracked in
> > the verifier, it does not change the verifier's behavior. Here is the
> > implication for dynptr, pointer casting, and owning/non-owning
> > references:
> >
> > Dynptr:
> >
> > When initializing a dynptr, referenced dynptrs acquire a reference for
> > ref_obj_id. If the dynptr has a referenced parent, parent_id tracks the
> > parent's id. When cloning, ref_obj_id and parent_id are copied from the
> > original. Releasing a referenced dynptr via release_reference(ref_obj_i=
d)
> > invalidates all clones and derived slices. For non-referenced dynptrs,
> > only the specific dynptr and its children are invalidated.
> >
> > Pointer casting:
> >
> > Referenced socket pointers and their casted counterparts share the same
> > lifetime but have different nullness =E2=80=94 they have different id b=
ut the
> > same ref_obj_id.
> >
> > Owning to non-owning reference conversion:
> >
> > After converting owning to non-owning by clearing ref_obj_id (e.g.,
> > object(id=3D1, ref_obj_id=3D1) -> object(id=3D1, ref_obj_id=3D0)), the
> > verifier only needs to release the reference state, so it calls
> > release_reference_nomark() instead of release_reference().
> >
> > Note that the error message "reference has not been acquired before" in
> > the helper and kfunc release paths is removed. This message was already
> > unreachable. The verifier only calls release_reference() after
> > confirming meta.ref_obj_id is valid, so the condition could never
> > trigger in practice (no selftest exercises it either). With the
> > refactor, release_reference() can now be called with non-acquired ids
> > and have different error conditions. Report directly in
> > release_reference() instead.
> >
> > Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >   include/linux/bpf_verifier.h |  22 ++-
> >   kernel/bpf/log.c             |   4 +-
> >   kernel/bpf/states.c          |   9 +-
> >   kernel/bpf/verifier.c        | 264 +++++++++++++++++-----------------=
-
> >   4 files changed, 152 insertions(+), 147 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index dc0cff59246d..1314299c3763 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -65,7 +65,6 @@ struct bpf_reg_state {
> >
> >               struct { /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> >                       u32 mem_size;
> > -                     u32 dynptr_id; /* for dynptr slices */
> >               };
> >
> >               /* For dynptr stack slots */
> > @@ -193,6 +192,13 @@ struct bpf_reg_state {
> >        * allowed and has the same effect as bpf_sk_release(sk).
> >        */
> >       u32 ref_obj_id;
> > +     /* Tracks the parent object this register was derived from.
> > +      * Used for cascading invalidation: when the parent object is
> > +      * released or invalidated, all registers with matching parent_id
> > +      * are also invalidated. For example, a slice from bpf_dynptr_dat=
a()
> > +      * gets parent_id set to the dynptr's id.
> > +      */
> > +     u32 parent_id;
> >       /* Inside the callee two registers can be both PTR_TO_STACK like
> >        * R1=3Dfp-8 and R2=3Dfp-8, but one of them points to this functi=
on stack
> >        * while another to the caller's stack. To differentiate them 'fr=
ameno'
> > @@ -508,7 +514,7 @@ struct bpf_verifier_state {
> >            iter < frame->allocated_stack / BPF_REG_SIZE;              \
> >            iter++, reg =3D bpf_get_spilled_reg(iter, frame, mask))
> >
> > -#define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __mask,=
 __expr)   \
> > +#define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __stack=
, __mask, __expr)   \
> >       ({                                                               =
\
> >               struct bpf_verifier_state *___vstate =3D __vst;          =
  \
> >               int ___i, ___j;                                          =
\
> > @@ -516,6 +522,7 @@ struct bpf_verifier_state {
> >                       struct bpf_reg_state *___regs;                   =
\
> >                       __state =3D ___vstate->frame[___i];              =
  \
> >                       ___regs =3D __state->regs;                       =
  \
> > +                     __stack =3D NULL;                                =
  \
> >                       for (___j =3D 0; ___j < MAX_BPF_REG; ___j++) {   =
  \
> >                               __reg =3D &___regs[___j];                =
  \
> >                               (void)(__expr);                          =
\
> > @@ -523,14 +530,19 @@ struct bpf_verifier_state {
> >                       bpf_for_each_spilled_reg(___j, __state, __reg, __=
mask) { \
> >                               if (!__reg)                              =
\
> >                                       continue;                        =
\
> > +                             __stack =3D &__state->stack[___j];       =
  \
> >                               (void)(__expr);                          =
\
> >                       }                                                =
\
> >               }                                                        =
\
> >       })
> >
> >   /* Invoke __expr over regsiters in __vst, setting __state and __reg *=
/
> > -#define bpf_for_each_reg_in_vstate(__vst, __state, __reg, __expr) \
> > -     bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, 1 << STACK=
_SPILL, __expr)
> > +#define bpf_for_each_reg_in_vstate(__vst, __state, __reg, __expr)     =
       \
> > +     ({                                                               =
       \
> > +             struct bpf_stack_state * ___stack;                       =
       \
> > +             bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __=
_stack,\
> > +                                             1 << STACK_SPILL, __expr)=
;      \
> > +     })
> >
> >   /* linked list of verifier states used to prune search */
> >   struct bpf_verifier_state_list {
> > @@ -1323,6 +1335,7 @@ struct bpf_dynptr_desc {
> >       enum bpf_dynptr_type type;
> >       u32 id;
> >       u32 ref_obj_id;
> > +     u32 parent_id;
> >   };
> >
> >   struct bpf_kfunc_call_arg_meta {
> > @@ -1334,6 +1347,7 @@ struct bpf_kfunc_call_arg_meta {
> >       const char *func_name;
> >       /* Out parameters */
> >       u32 ref_obj_id;
> > +     u32 id;
> >       u8 release_regno;
> >       bool r0_rdonly;
> >       u32 ret_btf_id;
> > diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> > index 011e4ec25acd..d8dd372e45cd 100644
> > --- a/kernel/bpf/log.c
> > +++ b/kernel/bpf/log.c
> > @@ -667,6 +667,8 @@ static void print_reg_state(struct bpf_verifier_env=
 *env,
> >               verbose(env, "%+d", reg->delta);
> >       if (reg->ref_obj_id)
> >               verbose_a("ref_obj_id=3D%d", reg->ref_obj_id);
> > +     if (reg->parent_id)
> > +             verbose_a("parent_id=3D%d", reg->parent_id);
> >       if (type_is_non_owning_ref(reg->type))
> >               verbose_a("%s", "non_own_ref");
> >       if (type_is_map_ptr(t)) {
> > @@ -770,8 +772,6 @@ void print_verifier_state(struct bpf_verifier_env *=
env, const struct bpf_verifie
> >                               verbose_a("id=3D%d", reg->id);
> >                       if (reg->ref_obj_id)
> >                               verbose_a("ref_id=3D%d", reg->ref_obj_id)=
;
> > -                     if (reg->dynptr_id)
> > -                             verbose_a("dynptr_id=3D%d", reg->dynptr_i=
d);
> >                       verbose(env, ")");
> >                       break;
> >               case STACK_ITER:
> > diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> > index 8478d2c6ed5b..72bd3bcda5fb 100644
> > --- a/kernel/bpf/states.c
> > +++ b/kernel/bpf/states.c
> > @@ -494,7 +494,8 @@ static bool regs_exact(const struct bpf_reg_state *=
rold,
> >   {
> >       return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) =3D=
=3D 0 &&
> >              check_ids(rold->id, rcur->id, idmap) &&
> > -            check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
> > +            check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap) &&
> > +            check_ids(rold->parent_id, rcur->parent_id, idmap);
> >   }
> >
> >   enum exact_level {
> > @@ -619,7 +620,8 @@ static bool regsafe(struct bpf_verifier_env *env, s=
truct bpf_reg_state *rold,
> >                      range_within(rold, rcur) &&
> >                      tnum_in(rold->var_off, rcur->var_off) &&
> >                      check_ids(rold->id, rcur->id, idmap) &&
> > -                    check_ids(rold->ref_obj_id, rcur->ref_obj_id, idma=
p);
> > +                    check_ids(rold->ref_obj_id, rcur->ref_obj_id, idma=
p) &&
> > +                    check_ids(rold->parent_id, rcur->parent_id, idmap)=
;
> >       case PTR_TO_PACKET_META:
> >       case PTR_TO_PACKET:
> >               /* We must have at least as much range as the old ptr
> > @@ -799,7 +801,8 @@ static bool stacksafe(struct bpf_verifier_env *env,=
 struct bpf_func_state *old,
> >                       cur_reg =3D &cur->stack[spi].spilled_ptr;
> >                       if (old_reg->dynptr.type !=3D cur_reg->dynptr.typ=
e ||
> >                           old_reg->dynptr.first_slot !=3D cur_reg->dynp=
tr.first_slot ||
> > -                         !check_ids(old_reg->ref_obj_id, cur_reg->ref_=
obj_id, idmap))
> > +                         !check_ids(old_reg->ref_obj_id, cur_reg->ref_=
obj_id, idmap) ||
> > +                         !check_ids(old_reg->parent_id, cur_reg->paren=
t_id, idmap))
> >                               return false;
> >                       break;
> >               case STACK_ITER:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0313b7d5f6c9..908a3af0e7c4 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -201,7 +201,7 @@ struct bpf_verifier_stack_elem {
> >
> >   static int acquire_reference(struct bpf_verifier_env *env, int insn_i=
dx);
> >   static int release_reference_nomark(struct bpf_verifier_state *state,=
 int ref_obj_id);
> > -static int release_reference(struct bpf_verifier_env *env, int ref_obj=
_id);
> > +static int release_reference(struct bpf_verifier_env *env, int id);
> >   static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
> >   static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
> >   static int ref_set_non_owning(struct bpf_verifier_env *env,
> > @@ -241,6 +241,7 @@ struct bpf_call_arg_meta {
> >       int mem_size;
> >       u64 msize_max_value;
> >       int ref_obj_id;
> > +     u32 id;
> >       int func_id;
> >       struct btf *btf;
> >       u32 btf_id;
> > @@ -603,14 +604,14 @@ static enum bpf_type_flag get_dynptr_type_flag(en=
um bpf_dynptr_type type)
> >       }
> >   }
> >
> > -static bool dynptr_type_refcounted(enum bpf_dynptr_type type)
> > +static bool dynptr_type_referenced(enum bpf_dynptr_type type)
> >   {
> >       return type =3D=3D BPF_DYNPTR_TYPE_RINGBUF || type =3D=3D BPF_DYN=
PTR_TYPE_FILE;
> >   }
> >
> >   static void __mark_dynptr_reg(struct bpf_reg_state *reg,
> >                             enum bpf_dynptr_type type,
> > -                           bool first_slot, int dynptr_id);
> > +                           bool first_slot, int id);
> >
> >
> >   static void mark_dynptr_stack_regs(struct bpf_verifier_env *env,
> > @@ -635,11 +636,12 @@ static int destroy_if_dynptr_stack_slot(struct bp=
f_verifier_env *env,
> >                                       struct bpf_func_state *state, int=
 spi);
> >
> >   static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, stru=
ct bpf_reg_state *reg,
> > -                                enum bpf_arg_type arg_type, int insn_i=
dx, int clone_ref_obj_id)
> > +                                enum bpf_arg_type arg_type, int insn_i=
dx, int parent_id,
> > +                                struct bpf_dynptr_desc *dynptr)
> >   {
> >       struct bpf_func_state *state =3D bpf_func(env, reg);
> > +     int spi, i, err, ref_obj_id =3D 0;
> >       enum bpf_dynptr_type type;
> > -     int spi, i, err;
> >
> >       spi =3D dynptr_get_spi(env, reg);
> >       if (spi < 0)
> > @@ -673,82 +675,56 @@ static int mark_stack_slots_dynptr(struct bpf_ver=
ifier_env *env, struct bpf_reg_
> >       mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
> >                              &state->stack[spi - 1].spilled_ptr, type);
> >
> > -     if (dynptr_type_refcounted(type)) {
> > -             /* The id is used to track proper releasing */
> > -             int id;
> > -
> > -             if (clone_ref_obj_id)
> > -                     id =3D clone_ref_obj_id;
> > -             else
> > -                     id =3D acquire_reference(env, insn_idx);
> > -
> > -             if (id < 0)
> > -                     return id;
> > -
> > -             state->stack[spi].spilled_ptr.ref_obj_id =3D id;
> > -             state->stack[spi - 1].spilled_ptr.ref_obj_id =3D id;
> > +     if (dynptr->type =3D=3D BPF_DYNPTR_TYPE_INVALID) { /* dynptr cons=
tructors */
> > +             if (dynptr_type_referenced(type)) {
> > +                     ref_obj_id =3D acquire_reference(env, insn_idx);
> > +                     if (ref_obj_id < 0)
> > +                             return ref_obj_id;
> > +             }
> > +     } else { /* bpf_dynptr_clone() */
> > +             ref_obj_id =3D dynptr->ref_obj_id;
> > +             parent_id =3D dynptr->parent_id;
> >       }
> >
> > +     state->stack[spi].spilled_ptr.ref_obj_id =3D ref_obj_id;
> > +     state->stack[spi - 1].spilled_ptr.ref_obj_id =3D ref_obj_id;
> > +     state->stack[spi].spilled_ptr.parent_id =3D parent_id;
> > +     state->stack[spi - 1].spilled_ptr.parent_id =3D parent_id;
> > +
> >       return 0;
> >   }
> >
> > -static void invalidate_dynptr(struct bpf_verifier_env *env, struct bpf=
_func_state *state, int spi)
> > +static void invalidate_dynptr(struct bpf_verifier_env *env, struct bpf=
_func_state *state,
>
> it looks like state is no longer needed.

Ack.

>
> > +                           struct bpf_stack_state *stack)
> >   {
> >       int i;
> >
> >       for (i =3D 0; i < BPF_REG_SIZE; i++) {
> > -             state->stack[spi].slot_type[i] =3D STACK_INVALID;
> > -             state->stack[spi - 1].slot_type[i] =3D STACK_INVALID;
> > +             stack[0].slot_type[i] =3D STACK_INVALID;
> > +             stack[1].slot_type[i] =3D STACK_INVALID;
> >       }
> >
> > -     bpf_mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
> > -     bpf_mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
> > +     bpf_mark_reg_not_init(env, &stack[0].spilled_ptr);
> > +     bpf_mark_reg_not_init(env, &stack[1].spilled_ptr);
> >   }
> >
> >   static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, st=
ruct bpf_reg_state *reg)
> >   {
> >       struct bpf_func_state *state =3D bpf_func(env, reg);
> > -     int spi, ref_obj_id, i;
> > +     int spi;
> >
> >       spi =3D dynptr_get_spi(env, reg);
> >       if (spi < 0)
> >               return spi;
> >
> > -     if (!dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.=
type)) {
> > -             invalidate_dynptr(env, state, spi);
> > -             return 0;
> > -     }
> > -
> > -     ref_obj_id =3D state->stack[spi].spilled_ptr.ref_obj_id;
> > -
> > -     /* If the dynptr has a ref_obj_id, then we need to invalidate
> > -      * two things:
> > -      *
> > -      * 1) Any dynptrs with a matching ref_obj_id (clones)
> > -      * 2) Any slices derived from this dynptr.
> > +     /*
> > +      * For referenced dynptr, the clones share the same ref_obj_id an=
d will be
> > +      * invalidated too. For non-referenced dynptr, only the dynptr an=
d slices
> > +      * derived from it will be invalidated.
> >        */
> > -
> > -     /* Invalidate any slices associated with this dynptr */
> > -     WARN_ON_ONCE(release_reference(env, ref_obj_id));
> > -
> > -     /* Invalidate any dynptr clones */
> > -     for (i =3D 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {
> > -             if (state->stack[i].spilled_ptr.ref_obj_id !=3D ref_obj_i=
d)
> > -                     continue;
> > -
> > -             /* it should always be the case that if the ref obj id
> > -              * matches then the stack slot also belongs to a
> > -              * dynptr
> > -              */
> > -             if (state->stack[i].slot_type[0] !=3D STACK_DYNPTR) {
> > -                     verifier_bug(env, "misconfigured ref_obj_id");
> > -                     return -EFAULT;
> > -             }
> > -             if (state->stack[i].spilled_ptr.dynptr.first_slot)
> > -                     invalidate_dynptr(env, state, i);
> > -     }
> > -
> > -     return 0;
> > +     reg =3D &state->stack[spi].spilled_ptr;
> > +     return release_reference(env, dynptr_type_referenced(reg->dynptr.=
type) ?
> > +                                   reg->ref_obj_id : reg->id);
> >   }
> >
> >   static void __mark_reg_unknown(const struct bpf_verifier_env *env,
> > @@ -765,10 +741,6 @@ static void mark_reg_invalid(const struct bpf_veri=
fier_env *env, struct bpf_reg_
> >   static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
> >                                       struct bpf_func_state *state, int=
 spi)
> >   {
> > -     struct bpf_func_state *fstate;
> > -     struct bpf_reg_state *dreg;
> > -     int i, dynptr_id;
> > -
> >       /* We always ensure that STACK_DYNPTR is never set partially,
> >        * hence just checking for slot_type[0] is enough. This is
> >        * different for STACK_SPILL, where it may be only set for
> > @@ -781,9 +753,9 @@ static int destroy_if_dynptr_stack_slot(struct bpf_=
verifier_env *env,
> >       if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
> >               spi =3D spi + 1;
> >
> > -     if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.t=
ype)) {
> > +     if (dynptr_type_referenced(state->stack[spi].spilled_ptr.dynptr.t=
ype)) {
> >               int ref_obj_id =3D state->stack[spi].spilled_ptr.ref_obj_=
id;
> > -             int ref_cnt =3D 0;
> > +             int i, ref_cnt =3D 0;
> >
> >               /*
> >                * A referenced dynptr can be overwritten only if there i=
s at
> > @@ -808,29 +780,8 @@ static int destroy_if_dynptr_stack_slot(struct bpf=
_verifier_env *env,
> >       mark_stack_slot_scratched(env, spi);
> >       mark_stack_slot_scratched(env, spi - 1);
> >
> > -     /* Writing partially to one dynptr stack slot destroys both. */
> > -     for (i =3D 0; i < BPF_REG_SIZE; i++) {
> > -             state->stack[spi].slot_type[i] =3D STACK_INVALID;
> > -             state->stack[spi - 1].slot_type[i] =3D STACK_INVALID;
> > -     }
> > -
> > -     dynptr_id =3D state->stack[spi].spilled_ptr.id;
> > -     /* Invalidate any slices associated with this dynptr */
> > -     bpf_for_each_reg_in_vstate(env->cur_state, fstate, dreg, ({
> > -             /* Dynptr slices are only PTR_TO_MEM_OR_NULL and PTR_TO_M=
EM */
> > -             if (dreg->type !=3D (PTR_TO_MEM | PTR_MAYBE_NULL) && dreg=
->type !=3D PTR_TO_MEM)
> > -                     continue;
> > -             if (dreg->dynptr_id =3D=3D dynptr_id)
> > -                     mark_reg_invalid(env, dreg);
> > -     }));
> > -
> > -     /* Do not release reference state, we are destroying dynptr on st=
ack,
> > -      * not using some helper to release it. Just reset register.
> > -      */
> > -     bpf_mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
> > -     bpf_mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
> > -
> > -     return 0;
> > +     /* Invalidate the dynptr and any derived slices */
> > +     return release_reference(env, state->stack[spi].spilled_ptr.id);
> >   }
> >
> >   static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, =
struct bpf_reg_state *reg)
> > @@ -1449,15 +1400,15 @@ static void release_reference_state(struct bpf_=
verifier_state *state, int idx)
> >       return;
> >   }
> >
> > -static bool find_reference_state(struct bpf_verifier_state *state, int=
 ptr_id)
> > +static struct bpf_reference_state *find_reference_state(struct bpf_ver=
ifier_state *state, int ptr_id)
> >   {
> >       int i;
> >
> >       for (i =3D 0; i < state->acquired_refs; i++)
> >               if (state->refs[i].id =3D=3D ptr_id)
> > -                     return true;
> > +                     return &state->refs[i];
> >
> > -     return false;
> > +     return NULL;
> >   }
> >
> >   static int release_lock_state(struct bpf_verifier_state *state, int t=
ype, int id, void *ptr)
> > @@ -1764,6 +1715,7 @@ static void __mark_reg_known(struct bpf_reg_state=
 *reg, u64 imm)
> >              offsetof(struct bpf_reg_state, var_off) - sizeof(reg->type=
));
> >       reg->id =3D 0;
> >       reg->ref_obj_id =3D 0;
> > +     reg->parent_id =3D 0;
> >       ___mark_reg_known(reg, imm);
> >   }
> >
> > @@ -1801,7 +1753,7 @@ static void mark_reg_known_zero(struct bpf_verifi=
er_env *env,
> >   }
> >
> >   static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dyn=
ptr_type type,
> > -                           bool first_slot, int dynptr_id)
> > +                           bool first_slot, int id)
> >   {
> >       /* reg->type has no meaning for STACK_DYNPTR, but when we set reg=
 for
> >        * callback arguments, it does need to be CONST_PTR_TO_DYNPTR, so=
 simply
> > @@ -1810,7 +1762,7 @@ static void __mark_dynptr_reg(struct bpf_reg_stat=
e *reg, enum bpf_dynptr_type ty
> >       __mark_reg_known_zero(reg);
> >       reg->type =3D CONST_PTR_TO_DYNPTR;
> >       /* Give each dynptr a unique id to uniquely associate slices to i=
t. */
> > -     reg->id =3D dynptr_id;
> > +     reg->id =3D id;
> >       reg->dynptr.type =3D type;
> >       reg->dynptr.first_slot =3D first_slot;
> >   }
> > @@ -2451,6 +2403,7 @@ void bpf_mark_reg_unknown_imprecise(struct bpf_re=
g_state *reg)
> >       reg->type =3D SCALAR_VALUE;
> >       reg->id =3D 0;
> >       reg->ref_obj_id =3D 0;
> > +     reg->parent_id =3D 0;
>
> nit: it looks like we can do memset(0) on the entire reg and then set
> fields that need to be non-zero: type, var_off + __mark_reg_unbounded().
>
> >       reg->var_off =3D tnum_unknown;
> >       reg->frameno =3D 0;
> >       reg->precise =3D false;
> > @@ -7427,7 +7380,7 @@ static int process_kptr_func(struct bpf_verifier_=
env *env, int regno,
> >    * and checked dynamically during runtime.
> >    */
> >   static int process_dynptr_func(struct bpf_verifier_env *env, int regn=
o, int insn_idx,
> > -                            enum bpf_arg_type arg_type, int clone_ref_=
obj_id,
> > +                            enum bpf_arg_type arg_type, int parent_id,
> >                              struct bpf_dynptr_desc *dynptr)
> >   {
> >       struct bpf_reg_state *reg =3D reg_state(env, regno);
> > @@ -7470,7 +7423,8 @@ static int process_dynptr_func(struct bpf_verifie=
r_env *env, int regno, int insn
> >                               return err;
> >               }
> >
> > -             err =3D mark_stack_slots_dynptr(env, reg, arg_type, insn_=
idx, clone_ref_obj_id);
> > +             err =3D mark_stack_slots_dynptr(env, reg, arg_type, insn_=
idx, parent_id,
> > +                                           dynptr);
> >       } else /* OBJ_RELEASE and None case from above */ {
> >               /* For the reg->type =3D=3D PTR_TO_STACK case, bpf_dynptr=
 is never const */
> >               if (reg->type =3D=3D CONST_PTR_TO_DYNPTR && (arg_type & O=
BJ_RELEASE)) {
> > @@ -7507,6 +7461,7 @@ static int process_dynptr_func(struct bpf_verifie=
r_env *env, int regno, int insn
> >                       dynptr->id =3D reg->id;
> >                       dynptr->type =3D reg->dynptr.type;
> >                       dynptr->ref_obj_id =3D reg->ref_obj_id;
> > +                     dynptr->parent_id =3D reg->parent_id;
> >               }
> >       }
> >       return err;
> > @@ -8461,7 +8416,7 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
> >                        */
> >                       if (reg->type =3D=3D PTR_TO_STACK) {
> >                               spi =3D dynptr_get_spi(env, reg);
> > -                             if (spi < 0 || !state->stack[spi].spilled=
_ptr.ref_obj_id) {
> > +                             if (spi < 0 || !state->stack[spi].spilled=
_ptr.id) {
> >                                       verbose(env, "arg %d is an unacqu=
ired reference\n", regno);
> >                                       return -EINVAL;
> >                               }
> > @@ -8489,6 +8444,7 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
> >                       return -EACCES;
> >               }
> >               meta->ref_obj_id =3D reg->ref_obj_id;
> > +             meta->id =3D reg->id;
> >       }
> >
> >       switch (base_type(arg_type)) {
> > @@ -9111,26 +9067,75 @@ static int release_reference_nomark(struct bpf_=
verifier_state *state, int ref_ob
> >       return -EINVAL;
> >   }
> >
> > -/* The pointer with the specified id has released its reference to ker=
nel
> > - * resources. Identify all copies of the same pointer and clear the re=
ference.
> > - *
> > - * This is the release function corresponding to acquire_reference(). =
Idempotent.
> > - */
> > -static int release_reference(struct bpf_verifier_env *env, int ref_obj=
_id)
> > +static int idstack_push(struct bpf_idmap *idmap, u32 id)
> > +{
> > +     int i;
> > +
> > +     if (!id)
> > +             return 0;
> > +
> > +     for (i =3D 0; i < idmap->cnt; i++)
> > +             if (idmap->map[i].old =3D=3D id)
> > +                     return 0;
> > +
> > +     if (WARN_ON_ONCE(idmap->cnt >=3D BPF_ID_MAP_SIZE))
> > +             return -EFAULT;
>
> It feels like this check belongs above, maybe the first thing to do.

Shouldn't it allow the verification to continue when pushing an id
that already exists in the stack?

>
> > +
> > +     idmap->map[idmap->cnt++].old =3D id;
> > +     return 0;
> > +}
> > +
> > +static int idstack_pop(struct bpf_idmap *idmap)
> >   {
> > +     if (!idmap->cnt)
> > +             return 0;
> > +
> > +     return idmap->map[--idmap->cnt].old;
> > +}
> > +
> > +/* Release id and objects referencing the id iteratively in a DFS mann=
er */
> > +static int release_reference(struct bpf_verifier_env *env, int id)
> > +{
> > +     u32 mask =3D (1 << STACK_SPILL) | (1 << STACK_DYNPTR);
> >       struct bpf_verifier_state *vstate =3D env->cur_state;
> > +     struct bpf_idmap *idstack =3D &env->idmap_scratch;
> > +     struct bpf_stack_state *stack;
> >       struct bpf_func_state *state;
> >       struct bpf_reg_state *reg;
> > -     int err;
> > +     int root_id =3D id, err;
> >
> > -     err =3D release_reference_nomark(vstate, ref_obj_id);
> > -     if (err)
> > -             return err;
> > +     idstack->cnt =3D 0;
> > +     idstack_push(idstack, id);
> >
> > -     bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> > -             if (reg->ref_obj_id =3D=3D ref_obj_id)
> > -                     mark_reg_invalid(env, reg);
> > -     }));
> > +     if (find_reference_state(vstate, id))
> > +             WARN_ON_ONCE(release_reference_nomark(vstate, id));
> > +
> > +     while ((id =3D idstack_pop(idstack))) {
> > +             bpf_for_each_reg_in_vstate_mask(vstate, state, reg, stack=
, mask, ({
> > +                     if (reg->id !=3D id && reg->parent_id !=3D id && =
reg->ref_obj_id !=3D id)
> > +                             continue;
> > +
> > +                     if (reg->ref_obj_id && id !=3D root_id) {
>
> Does this line check that the only ref_obj_id we should see is either
> 0 or root_id? can we rewrite it as
> if (reg->ref_obj_id && reg->ref_obj_id !=3D root_id)
>
> this is simpler, because id can also be reg->id/reg->parent_id, which is
> hard to reason what that means.
>

Looking at it again, I think my release_reference() is wrong. It first
calls release_reference_nomark() if the id is a ref_obj_id. This will
invalidate all registers with the same ref_obj_id without traversing
their children.

I should remember the root_ref_obj_id instead of calling
release_reference_nomark(). Then, the check you mentioned should be:
 if (reg->ref_obj_id && reg->ref_obj_id !=3D root_ref_obj_id)

I will write a selftest to confirm the issue and include it in the
next respin if this turns out to be a bug.

