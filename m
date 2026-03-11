Return-Path: <netdev+bounces-266788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJp4IZTtsWnbHAAAu9opvQ
	(envelope-from <netdev+bounces-266788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:32:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BBF26AEAA
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3489C30579E4
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 22:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB5E392C2D;
	Wed, 11 Mar 2026 22:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7cvD8wz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F6B36896D
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773268366; cv=pass; b=HqG584WI1C7kgAd8+OAfGYcDv7t9dABuko34slPQmYpJUg7F2Sm02d8rBsvfo1xsJ+YusnwUORZd3iXarmirZdS0tNQP65KISp8hLAlOgzeNbyaxL7SEOG5ytJHs7Os2zuZpVnS31uQwUC61QFkVQDXvOZ/645WQyMFwBUzOX1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773268366; c=relaxed/simple;
	bh=IluHK/BQMAOXLhhspT0YZWitH/jIrjg7fem6CEVmj6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awD9tSLcYmUBSTL13twzCkZmao3GtDBDsiiPP7Li1CjNkMwC55DK6ahl+2swxH0sh6anpjjh0UiCCaqoT8q0kUk83h97WbWlGGxumRthod4m3vvekqq5drF2VVPGQ2Qyk1myZGIE2SZFs+P8zykS1JKBwBzMxtgC2bwxdbl81Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7cvD8wz; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae43042ea7so5160015ad.0
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 15:32:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773268364; cv=none;
        d=google.com; s=arc-20240605;
        b=kZm6Mo0e05nWkwDuQ5ChecExV4t8xag0D6FNEOiym7k1tidVZxXr1Zvf4bItiMs7AI
         kMUFSrfv3gI11nF4caC2THQWkrTG/c74Fx9PoS065HHhELh+eu7sOE2u1boS92kmcbtF
         FxEIowObF9Zj57yOEi85/R50Ubjtnpf9YPMppRw3W/jALUUKA2Pc6yV0Yb3ZpHEGsQY5
         0kjSY4LQTec3R64mgA8GVu8rzTQiyb/+/zAtc3SbJzulwkgXUkvEd+VGVUQ1Jt3MLuR7
         s/EHRk1heWGBevJrf0eNk0+c8vr2mSK+nfGbsfdAQMjoHEerMu6FWPDhMjWaEiCIJDqf
         g4Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZPsXmDrGSA3JNcaQ1tbw5DFVGY4N5/j+Kfbesdf6nl8=;
        fh=RGyLcv23edldM//Z1XbgbgY0DrUvZGX4b4UUCN3wvmQ=;
        b=gsQP+CepI9u3X6+m+SxV9TNrQH/MYl8stOGVRAnV/2LUK6DkcM62WUXCOiS9pW/9I5
         A+OlZwMaz3Jv5cra2fzrR+yjDnchoCEUPoSyjGVypYe4bJ3zYmXwhO2rSJFzLX7pDX5k
         J3TNCV4Ktu+Qj2OGdG1o2fn6QDs7Hcb5UUlgFAxOyEZaZ0s/Ji0Cd4JvLj/Zow/rBMNE
         M7GsZIcmNBtfHKDWVj13YWQWmrrStKrFmQ6OuQbNqfRHSApcvaq6Xe/1HtzqQ1noKcT2
         fzFIRw7rcE9DdOLzNBl2jrz9HURGfD5EqTERGa3Jan47OtJAZM9+8YMpEEpRL5o9YZpp
         aaVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773268364; x=1773873164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPsXmDrGSA3JNcaQ1tbw5DFVGY4N5/j+Kfbesdf6nl8=;
        b=i7cvD8wzMFrHW4156jTQSn5DK2i/5Gu3nQGwCsQjwAyFbZog7MRn3VdUumQqGG92yP
         K7Fe7ztTe/ub3NOFLqQxkApdS56uaNDZMMxYye9AbnIfMYdv1aTLKS2wJZJx0FKCV/LD
         6H0lKg5UBW84UkaKS+aC3IU/3HWMjJtur3SWZUcQxJ22ga6Rt/gsJtrpnJijYIEsmhye
         aD5uJ6exitb/Jb9hJFZG1eSZ19gQq1cnETBROZxNHAO998+utV1evmhWsviDJCd4sTTe
         6CFUjKO7UN+YPR+kjfBiy60KQT1JANGQUhUGKyXp9AkpSHzkiiNFQ7UsPTtz9qyAryuz
         0l4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773268364; x=1773873164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZPsXmDrGSA3JNcaQ1tbw5DFVGY4N5/j+Kfbesdf6nl8=;
        b=rTkNl005+u4g066/DFTevobHDjnUupylV1ExdNP9iFYHcRW8jv9fUJD96G8c3Ilm56
         bp12ORRUtRLCMQwn+hVsyvmAorkuHedy6sBlyuKBULUtn8HRtL12sqjiKaMPg1WpjzCq
         ScvfDtuvvkDLcbTAvw4sKdPB1vDHQPoZ1AKa5+7JZvSqZLZfSYlfXBQM+TwpXVkwEB2A
         9AehZqN6oDGheGKJiikT3+ltxNTTTrYaUZvTTJiDYTI1f4jMbqNo+AigqIc8qglz5Rbv
         FmLzQvwT76w5kHtCN4oORPuijLth3oQFng85T4P/GKU7LcTdmZJOq6yFXIqB4cq/nbid
         kPDg==
X-Forwarded-Encrypted: i=1; AJvYcCX8LZFKI8v8FrmU8FTuID4bAwqkSEfe+9hjRQF3h8ReOpccs4D+Ra9T64xrXMen/tEqmKfJMvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsx7Lhmain+dkjsv/VSE4WumwfYBHOGxymEEAAh8mFLT1SWzzV
	9VjR10cff38tBf8moevgYiUNOpd0j3CAcO48AOTaLdXLLIKsUmuPA6Aw8dt7CMeL2cH8yQjMagj
	HqgeECvo2XYkzFbDGnQ0lP61rnxyeIQY=
X-Gm-Gg: ATEYQzzXyBM2qzN8HPCC8SDuAuxqfRkpDpUpfvstet9UuJfAhmdrI5TcpQM2zTs2sHK
	TVg0qNGt9SYpVcTNWmaUPLNUSSzva0106R75JhOxAUgcfjU2ZIxOFfO5axBxzgHAmtFxc1+gy1E
	ppiJTq5CaqztYK9QaOpbRRsfNWof2q8cmpTAhMZ0nmjJGLWvsW5mkZGlXBlT98/YXWJasf8kZij
	faQeLIURbjNE6vri1nRhE3wlPIJxMbyXPnQ67hNzQbTUyv0/GkDmw+HSqTpQRkHflbHA9nwp0BM
	UvEoeWM=
X-Received: by 2002:a17:902:d54f:b0:2ae:7f6d:78a4 with SMTP id
 d9443c01a7336-2aeae9219c3mr42974885ad.56.1773268363553; Wed, 11 Mar 2026
 15:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-7-ameryhung@gmail.com>
In-Reply-To: <20260307064439.3247440-7-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 15:32:31 -0700
X-Gm-Features: AaiRm519En_c9oLt51jMT3Bhgvy-Lz_7wa80M5UYf8ztIz4PvmEdFd11v6cxKwE
Message-ID: <CAEf4BzZhAmLV92tw=tDs62WmUTnHbfVOu3KVE3_g-vtMt-bcoQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 06/11] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266788-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31BBF26AEAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Refactor object relationship tracking in the verifier by removing
> dynptr_id and using parent_id to track the parent object. Then, track
> the referenced parent object for the dynptr when calling a dynptr
> constructor. This fixes a use-after-free bug. For dynptr that has
> referenced parent object (skb dynptr in BPF qdisc or file dynptr),
> the dynptr or derived slices need to be invalidated when the parent
> object is released.
>
> First, add parent_id to bpf_reg_state to be able to precisely track
> objects' child-parent relationship. A child object will use parent_id
> to track the parent object's id. This replaces dynptr slice specific
> dynptr_id.
>
> Then, when calling dynptr constructors (i.e., process_dynptr_func() with
> MEM_UNINIT argument), track the parent's id if parent is an referenced
> object. This only applies to file dynptr and skb dynptr, so only pass
> parent reg->id to kfunc constructors.
>
> For release_reference(), this mean when invalidating an object, it needs
> to also invalidate all dependent objects by traversing the subtree. This
> is done using stack-based DFS to avoid recursive call chain of
> release_reference() -> unmark_stack_slots_dynptr() ->
> release_reference(). Note that, referenced objects cannot be released
> when traversing the tree if it is not the object id initially passed to
> release_reference() as they would actually require helper call to
> release the acquired resources.
>
> While the new design changes how object relationships are being tracked
> in the verifier, it does NOT change the verifier's behavior. Here is
> the implication of the new design for dynptr, ptr casting and
> owning/non-owning references.
>
> Dynptr:
>
> When initializing a dynptr, referenced dynptr will acquire an reference
> for ref_obj_id. If the dynptr has a referenced parent, the parent_id
> will be used to track the its id. When cloning dynptr, ref_obj_id and
> parent_id of the clone are copied directly from the original dynptr.
> This means, when releasing a dynptr, if it is a referenced dynptr,
> release_reference(ref_obj_id) will release all clones and the original
> and derived slices. For non-referenced dynptr, only the specific dynptr
> being released and its children slices will be invalidated.
>
> Pointer casting:
>
> Referenced socket pointer and the casted pointers should share the same
> lifetime, while having difference nullness. Therefore, they will have
> different id but the same ref_obj_id.
>
> When converting owning references to non-owning:
>
> After converting a reference from owning to non-owning by clearing the
> object's ref_reg_id. (e.g., object(id=3D1, ref_obj_id=3D1) -> object(id=
=3D1,
> ref_obj_id=3D0)), the verifier only needs to release the reference state
> instead of releasing registers that have the id, so call
> release_reference_nomark() instead of release_reference().
>
> CC: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  14 +-
>  kernel/bpf/log.c             |   4 +-
>  kernel/bpf/verifier.c        | 274 ++++++++++++++++++-----------------
>  3 files changed, 154 insertions(+), 138 deletions(-)
>

[...]


> -       ref_obj_id =3D state->stack[spi].spilled_ptr.ref_obj_id;
> -
> -       /* If the dynptr has a ref_obj_id, then we need to invalidate
> -        * two things:
> -        *
> -        * 1) Any dynptrs with a matching ref_obj_id (clones)
> -        * 2) Any slices derived from this dynptr.
> +       /*
> +        * For referenced dynptr, the clones share the same ref_obj_id an=
d will be
> +        * invalidated too. For non-referenced dynptr, only the dynptr an=
d slices
> +        * derived from it will be invalidated.
>          */

this is confusing to me. Why the nature of dynptr should change
anything about the scope of invalidation? This should be controlled
from outside. E.g., if someone invalidates clone by overwriting it on
the stack, we shouldn't just go an invalidate all other clones. We
just invalidate that particular clone (regardless of whether it's a
clone of file dynptr or just some mem dynptr).

But if someone is calling bpf_dynptr_file_discard() on one of the
clones, then yes, all the clones need to be invalidated. But that
should be handled as more generic "this file lifetime is ending", no?

Maybe I'm missing something, but it feels wrong to make decisions like
this inside a low-level (and thus intentionally dumb)
unmark_stack_slots_dynptr() helper.

> -
> -       /* Invalidate any slices associated with this dynptr */
> -       WARN_ON_ONCE(release_reference(env, ref_obj_id));
> -
> -       /* Invalidate any dynptr clones */
> -       for (i =3D 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {
> -               if (state->stack[i].spilled_ptr.ref_obj_id !=3D ref_obj_i=
d)
> -                       continue;

[...]

> +static u32 idstack_pop(struct bpf_idstack *idstack)
> +{
> +       return idstack->cnt > 0 ? idstack->ids[--idstack->cnt] : 0;
> +}
> +
> +static int release_reg_check(struct bpf_verifier_env *env, struct bpf_re=
g_state *reg,
> +                            int id, int root_id, struct bpf_idstack *ids=
tack)

tbh, I feel like release_reg_check is doing too much, it both enqueues
children and checks unreleased references. And this <0, 0, and 1 as
return values (where 1 is completely unobvious) is an indicator of
that. I think id/parent_id/ref_obj_id check can be done inline in
release_reg_check() just fine (yes, two place, no big deal, but if so,
make it a small helper) and then you'll have more obvious logic break
down into a) check if reg should be enqueue, b) if so, check ref leak,
and c) enqueue new id

>  {
> +       struct bpf_reference_state *ref_state;
> +
> +       if (reg->id =3D=3D id || reg->parent_id =3D=3D id || reg->ref_obj=
_id =3D=3D id) {
> +               /* Cannot indirectly release a referenced id */
> +               if (reg->ref_obj_id && id !=3D root_id) {
> +                       ref_state =3D find_reference_state(env->cur_state=
, reg->ref_obj_id);
> +                       verbose(env, "Unreleased reference id=3D%d alloc_=
insn=3D%d when releasing id=3D%d\n",
> +                               ref_state->id, ref_state->insn_idx, root_=
id);
> +                       return -EINVAL;
> +               }
> +
> +               if (reg->id && reg->id !=3D id)
> +                       idstack_push(idstack, reg->id);

can't you push the same id multiple times into stack this way? your
idstack is actually a set, no? so idmap serves you better (just map id
to 1 for "to be checked")? And then you don't need to introduce a new
idstack_scratch data structure

> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +

[...]

