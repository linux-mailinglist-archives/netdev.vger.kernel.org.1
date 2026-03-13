Return-Path: <netdev+bounces-267590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CqUEVp0tGmUoQAAu9opvQ
	(envelope-from <netdev+bounces-267590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:32:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAE5289BF8
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7ECDF3028EA2
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28333750B5;
	Fri, 13 Mar 2026 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpL8V104"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A9A34B426
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433942; cv=pass; b=JCEi5cTOHMTJ0A0O3WmTifhlrRmSAp4hTlxFZNJqmIFtMg//aaedf/l6V3MRjDav/DawvWhrR+s8076Ey+U8jdak6FwOCAaeV9Dr3aP2hUTDvB78O5vR1UpgjNkC6pRPYzjDHaJz41haNk+tbc/0zICWyaF9IUlC1fIF+/ltKt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433942; c=relaxed/simple;
	bh=40KYgHnhjSiHLdwDpLF5x4iF2sn2Ws3bs7xDuEqjSMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkAav9aUuALiznE1FFqLRfFfM6e/UDlXUuAC6IE/qea9nLfUwsrG0IzRSZZ22TA36laBvrPaVIW5UjA+VFmABGpq1KzbRWWDR7nRE5wAiLIF3frQy+5eP6WLhWHCCI818uLK3k4wgKkusI4ylhPzMSaOt/WPX3BYg1jM8ZUSy8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpL8V104; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7986d231b3cso54935897b3.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773433937; cv=none;
        d=google.com; s=arc-20240605;
        b=CcCOxrRpVvvjAQa43GMQdtmKVqZCokz89GeTN6qfqFQpdGpW2Q1yp9bVTRvdDpWJBk
         v12SN8FWwLLcgFwfojT4HjUrbZUGsZhqzAh1E2bxnh+eythL/XXFOw9Gs7TFQVt8wnjg
         mNrH4jalll51UycofbH2vr/638U3KdR9A+qx2sYrYIjRwREZG1n0411zWX+w82cCq3zu
         2BrXwXEHYJdAxD9/sppNFqro/RMOAHESGpv+20AcacHcVCAuZc/gkJ6+KjiBMgHSzrTo
         BgaT5eH6B4OkUxdLVrDUqLzzQ1rn0TdzEN+AHD3S4cGk7f77orPEElrAXxoATE7LGWH6
         IuSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xrvXrc2a0tLMlC/MG2taLuEzPA0KpCXPwW0g4OAbVgc=;
        fh=yQV6EL6NmkFOcL7sIA8uB6jQdrB4utncu6+SsZjkBrI=;
        b=WIrE+68B+ekfTqVLicvl/kf9vT2/VJF780xCzJCmUhCfEIhroTwWQaHhnZ9WDoGmI3
         voTxeAhvx9qLUQbNksYcZomuM6IW6ZUH6i0/RyzroomfCPJk13q+ryAokbe1J+gSkU3o
         lGU/zphJ80Zk+xicm6Qztk0K20NoiUIA7qHzU7fCqLqatrUjhRQ41fdeGj5k7RM9F3E2
         2ig/6y6cS/CGONWMfRGWcWl7qtGrqY77khQQlddNg9kc9VwkicPNZB48eB/c8NcG7igS
         mv8mDLSM1i0wtvTnMR25wLcan01dSU5Jh0fHyjp9N7DO9TxF1p6jJKR3+clR2UJ3ZsW2
         785g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773433937; x=1774038737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrvXrc2a0tLMlC/MG2taLuEzPA0KpCXPwW0g4OAbVgc=;
        b=KpL8V104jRZ3Fba7JgU0Ae9IWnB7HlpWi/DqCMvYQcYtjSnb3wwJgpQY1iUJups3lh
         TfsKv/0bT/4WcOE3O/QmuJfUo7hNl53w/VYFsd/qrehuEsc8+8TIDuyHSnruK+4nS9Y/
         K3NL2W2k5He0cJesN+KRji5TSQikVMw5PVozjTM0yGS+dSd4boJRs9dS0uFymdCp6Nfb
         jOeeAxY5POihkCK4eaq1rMclRdGy3quuMxpWMKoStG2YKnxQTk4nY2vOxqUqe7kcmd9y
         V5+ZwYH/xtO6eSyqQOLnjpXCcgCjTUE/VngFZ2OfqPfCpRCBVdgmxDiPQEqzLFWUVgmE
         ajFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773433937; x=1774038737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xrvXrc2a0tLMlC/MG2taLuEzPA0KpCXPwW0g4OAbVgc=;
        b=QrCnrw7kT8zspDMu00xvbmCpOIU+yk13kawseLStjflqUe1FUFiQzH/nBLtOrAIf3h
         UQTBPRNeway6r2LBSJBRGOMBnMwBMYcyzGk5+KHG8hkl7IwZY1+KzQPkskkIxfjTSzdR
         7CcbgcoT8l8xlaHJH+i7JWFbPStLZyALS1C4SPT/Ih1DZ9r6SOamECg7o1JC7Sp1Qkti
         ie10U7I07ko12ZLKvC7E3Tnp21QrfFcB0xaMPpPZESFlIupOArDXZS/fWhXrtPa7K9wj
         uNPOFAXVQoc/URVRAer7lvW8KHIzRoQwxoyd3ncPwKVCalI0Elxu4d/tMfPGC1o6ogVN
         UZVw==
X-Forwarded-Encrypted: i=1; AJvYcCVXZS1u2/zE9pi3ctc/BIOA0Jown6GzuyqX3Qj9alv40vcoL8ivq9KjJyfG8fvIJsvwA9Px0dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKBPkHc2+u2ID9yIQ2YdAY1/ZbIsJZd4FOhe23CxOfN3aP92Cf
	nsJ+2Q7HG9agSOynmUD7r70It3+TTv6J5lye6RJf+xDo+/l64vF8UEp49T4Q3f5VlScIGwBum0B
	dxSAi6JvykDkMJ+s0pMO0BdiHjNQcfV0=
X-Gm-Gg: ATEYQzytCNU5QSs6VYolj9HCsRRt6Tadhl9ymmHyeJmO4v/a/GFCtLPQ+DknCUNjRwH
	pr4MWLkY3FKReYalzaex1BRw6vz01jyW2mNupkCtpZL1+JYU6j7ec2CmIeQrNz6caS4Ysa+uDVm
	G2BqyJKfd/iEI7bcVMBVBzWk9t/1aHpqz3wSrrfCivSBFt2LzW9Fg1NMQa65VOEPzcAxZCmYDPV
	TCLHsTqAlajbF76cJ39uId6q7GbNYI9Gx9OqMd1mLWavLGSmVeNOXYa5zYq0dBi1VW+2oPkmhri
	p9bx/v4J+9OSVFjvIw==
X-Received: by 2002:a05:690c:4807:b0:796:db6:2386 with SMTP id
 00721157ae682-7994767b56dmr78688927b3.31.1773433936908; Fri, 13 Mar 2026
 13:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-7-ameryhung@gmail.com>
 <CAEf4BzZhAmLV92tw=tDs62WmUTnHbfVOu3KVE3_g-vtMt-bcoQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZhAmLV92tw=tDs62WmUTnHbfVOu3KVE3_g-vtMt-bcoQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 13 Mar 2026 13:32:04 -0700
X-Gm-Features: AaiRm51-cq0fcOUdY-MoWMmGBdxaEXlCaJ5KUoLBs-RCotGipFO7aonQv-Ut6gM
Message-ID: <CAMB2axOqyQtVbf1YAASNV8WWNrQBJRZ7kcBEXovBBLDRmmKpBQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 06/11] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
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
	TAGGED_FROM(0.00)[bounces-267590-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7BAE5289BF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 3:32=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > Refactor object relationship tracking in the verifier by removing
> > dynptr_id and using parent_id to track the parent object. Then, track
> > the referenced parent object for the dynptr when calling a dynptr
> > constructor. This fixes a use-after-free bug. For dynptr that has
> > referenced parent object (skb dynptr in BPF qdisc or file dynptr),
> > the dynptr or derived slices need to be invalidated when the parent
> > object is released.
> >
> > First, add parent_id to bpf_reg_state to be able to precisely track
> > objects' child-parent relationship. A child object will use parent_id
> > to track the parent object's id. This replaces dynptr slice specific
> > dynptr_id.
> >
> > Then, when calling dynptr constructors (i.e., process_dynptr_func() wit=
h
> > MEM_UNINIT argument), track the parent's id if parent is an referenced
> > object. This only applies to file dynptr and skb dynptr, so only pass
> > parent reg->id to kfunc constructors.
> >
> > For release_reference(), this mean when invalidating an object, it need=
s
> > to also invalidate all dependent objects by traversing the subtree. Thi=
s
> > is done using stack-based DFS to avoid recursive call chain of
> > release_reference() -> unmark_stack_slots_dynptr() ->
> > release_reference(). Note that, referenced objects cannot be released
> > when traversing the tree if it is not the object id initially passed to
> > release_reference() as they would actually require helper call to
> > release the acquired resources.
> >
> > While the new design changes how object relationships are being tracked
> > in the verifier, it does NOT change the verifier's behavior. Here is
> > the implication of the new design for dynptr, ptr casting and
> > owning/non-owning references.
> >
> > Dynptr:
> >
> > When initializing a dynptr, referenced dynptr will acquire an reference
> > for ref_obj_id. If the dynptr has a referenced parent, the parent_id
> > will be used to track the its id. When cloning dynptr, ref_obj_id and
> > parent_id of the clone are copied directly from the original dynptr.
> > This means, when releasing a dynptr, if it is a referenced dynptr,
> > release_reference(ref_obj_id) will release all clones and the original
> > and derived slices. For non-referenced dynptr, only the specific dynptr
> > being released and its children slices will be invalidated.
> >
> > Pointer casting:
> >
> > Referenced socket pointer and the casted pointers should share the same
> > lifetime, while having difference nullness. Therefore, they will have
> > different id but the same ref_obj_id.
> >
> > When converting owning references to non-owning:
> >
> > After converting a reference from owning to non-owning by clearing the
> > object's ref_reg_id. (e.g., object(id=3D1, ref_obj_id=3D1) -> object(id=
=3D1,
> > ref_obj_id=3D0)), the verifier only needs to release the reference stat=
e
> > instead of releasing registers that have the id, so call
> > release_reference_nomark() instead of release_reference().
> >
> > CC: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h |  14 +-
> >  kernel/bpf/log.c             |   4 +-
> >  kernel/bpf/verifier.c        | 274 ++++++++++++++++++-----------------
> >  3 files changed, 154 insertions(+), 138 deletions(-)
> >
>
> [...]
>
>
> > -       ref_obj_id =3D state->stack[spi].spilled_ptr.ref_obj_id;
> > -
> > -       /* If the dynptr has a ref_obj_id, then we need to invalidate
> > -        * two things:
> > -        *
> > -        * 1) Any dynptrs with a matching ref_obj_id (clones)
> > -        * 2) Any slices derived from this dynptr.
> > +       /*
> > +        * For referenced dynptr, the clones share the same ref_obj_id =
and will be
> > +        * invalidated too. For non-referenced dynptr, only the dynptr =
and slices
> > +        * derived from it will be invalidated.
> >          */
>
> this is confusing to me. Why the nature of dynptr should change
> anything about the scope of invalidation? This should be controlled
> from outside. E.g., if someone invalidates clone by overwriting it on
> the stack, we shouldn't just go an invalidate all other clones. We
> just invalidate that particular clone (regardless of whether it's a
> clone of file dynptr or just some mem dynptr).

This is the nuance that lies in dynptr.

When invalidating a referenced dynptr clone, all clones and the
original must be invalidated. There is no option to just invalidate
one. The reason is that bpf_dynptr_clone just copies bpf_dynptr_kern,
not calling the dynptr ctor to set up necessary stuff to make a dynptr
valid. (Also want to mention referenced dynptr cannot be destroy by
overwriting the stack slot)

This is not the case for unreferenced dynptr. The entire state of the
dynptr is saved in bpf_dynptr_kern. Therefore their clones can live
independently.

To summarize, referenced dynptr can only be released via helper and
all clones must be invalidated. Non-referenced dynptr do not need to
be released, but when invalidated by overwriting the stack slot, it
does not affect other clones.

>
> But if someone is calling bpf_dynptr_file_discard() on one of the
> clones, then yes, all the clones need to be invalidated. But that
> should be handled as more generic "this file lifetime is ending", no?
>
> Maybe I'm missing something, but it feels wrong to make decisions like
> this inside a low-level (and thus intentionally dumb)
> unmark_stack_slots_dynptr() helper.
>
> > -
> > -       /* Invalidate any slices associated with this dynptr */
> > -       WARN_ON_ONCE(release_reference(env, ref_obj_id));
> > -
> > -       /* Invalidate any dynptr clones */
> > -       for (i =3D 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {
> > -               if (state->stack[i].spilled_ptr.ref_obj_id !=3D ref_obj=
_id)
> > -                       continue;
>
> [...]
>
> > +static u32 idstack_pop(struct bpf_idstack *idstack)
> > +{
> > +       return idstack->cnt > 0 ? idstack->ids[--idstack->cnt] : 0;
> > +}
> > +
> > +static int release_reg_check(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg,
> > +                            int id, int root_id, struct bpf_idstack *i=
dstack)
>
> tbh, I feel like release_reg_check is doing too much, it both enqueues
> children and checks unreleased references. And this <0, 0, and 1 as
> return values (where 1 is completely unobvious) is an indicator of
> that. I think id/parent_id/ref_obj_id check can be done inline in
> release_reg_check() just fine (yes, two place, no big deal, but if so,
> make it a small helper) and then you'll have more obvious logic break
> down into a) check if reg should be enqueue, b) if so, check ref leak,
> and c) enqueue new id

Make sense to break it down. I also found it hard to name this
function and maybe that already indicates that it is trying to do
much.

>
> >  {
> > +       struct bpf_reference_state *ref_state;
> > +
> > +       if (reg->id =3D=3D id || reg->parent_id =3D=3D id || reg->ref_o=
bj_id =3D=3D id) {
> > +               /* Cannot indirectly release a referenced id */
> > +               if (reg->ref_obj_id && id !=3D root_id) {
> > +                       ref_state =3D find_reference_state(env->cur_sta=
te, reg->ref_obj_id);
> > +                       verbose(env, "Unreleased reference id=3D%d allo=
c_insn=3D%d when releasing id=3D%d\n",
> > +                               ref_state->id, ref_state->insn_idx, roo=
t_id);
> > +                       return -EINVAL;
> > +               }
> > +
> > +               if (reg->id && reg->id !=3D id)
> > +                       idstack_push(idstack, reg->id);
>
> can't you push the same id multiple times into stack this way? your
> idstack is actually a set, no? so idmap serves you better (just map id
> to 1 for "to be checked")? And then you don't need to introduce a new
> idstack_scratch data structure

Ack.

>
> > +               return 1;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
>
> [...]

