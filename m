Return-Path: <netdev+bounces-280951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCAUM+oR62lsIAAAu9opvQ
	(envelope-from <netdev+bounces-280951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 08:47:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D38D945A4EB
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 08:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9E48300516F
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 06:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6E349620;
	Fri, 24 Apr 2026 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/HwCUdI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E223563F3
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013219; cv=pass; b=Ua9GMmLO6EQibyyXf96T0Nc2BnS9P7eEOJVctUudTSQNTPmVMcxX5RLXDU2grd1sjq6z2dtMXXOxGkWWO57fDT4E4I12k41ycz4pz+Fms1YArrNsKkwkEauBbcEYM625K6WJDZX3Z+jPWyWtfWFfMnANXb1kw1WtxA9CTOfpOKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013219; c=relaxed/simple;
	bh=qRFMoFp3syPnqQXJjTdkRUEYk2rQy+Gh/Burfci6Fi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0I2AWrvnSVNvJpU5vAbmPItqp+prQrtdIeZxjQntPknvk6C4LR3yho4YqU4YhB7W5qX01MnYfJtCccA3jSNI/k2+nUf5kJYX6j1lIbGo5UgIgtyr4uh+mNVEQmBTt82pX4m8JS4PzvgmpmDzaBEYIABlp+zA/g7bO/jAsrepWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/HwCUdI; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79a46260385so79664657b3.3
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 23:46:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777013216; cv=none;
        d=google.com; s=arc-20240605;
        b=C9eLbp9o41X3M0sk7w39dLN3lx3SQPcSD5kNFSrjIgww6/S5bQ245hdZLrCwcxEHe7
         3OLQqJWN/Cs8IRTJSJImSTm9BwhqqDcgbgZmWIShWtEU2QA44IMyQfe1WMz95lmfhPvC
         Pl6jvm1Rvk+HyY0uPBHmZSHW40RcbWFYnPjqTE+AFxsBoAapF1hHiyb/MoFhy1ey1iLO
         Pci8OoW/dQg0KLbDDugJwnzS8i/qnNJ34H2/KU2DgyHEgOMFbXh8fuAHQ+LzE+DfpYbL
         Xq4HjLDLVlYKP45PWx4BmK3WNRtbhki2usc2jSi1GGm3D/HBd8CbKZeQKtRtSEwf1sDn
         OmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pG5N1aWYqHr3VjwttN7NR3A/LWyrjywLz4dOCiEC67E=;
        fh=bZGsVqzeg/JlMwZgqTEdBFkKEWIJlpNFkE1VeA+PCYA=;
        b=h5tkTCGGl1/vIZLfVwGyM5NUzKrEXTq/9QgZbfJL+szjThQj7creRE6baRP4062jGt
         fP2QdfaUF2PFYSyX5EVNL911DIcETt1uWsRHlYeSXWcjo+LNABVTXyenYBA7AshBBYh1
         iTWgmONxAuSM2GNvW2ZpFvk4tG4Xg7aAve9+Ja25CJ/XZwJyDK58rXnFTR2PlxKcIBZg
         +9gWhLYM4CxcA1WyDrJuxvY7dTH5IX4l/7mqvaI/egWcJgbZam6pIX0EkZVU+7xObpN1
         Bhgc2udMsHOidUWu66fGk18rI9OAF/aBSlVulbHR817jnC1xTOVCTCmmGw1iMrygBDKg
         M12Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777013216; x=1777618016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG5N1aWYqHr3VjwttN7NR3A/LWyrjywLz4dOCiEC67E=;
        b=Q/HwCUdI0iA6p3Orf4EMjCiWNaHYONo5NJdJhKH3SjRwMiFlTSVy42iARC72A/EkJL
         y0wXfJTNdMpPRyVUhpMknqBxbGG2+tbqbLcTc/eBXv1wY7+5XasSblba4a4HOf6qe5D6
         vwczyc1szQjLIWTZk6aB+wTl8HxPuYspXzpvLvnfi9mmqagFkcttH8IDQYDloeSHRzvV
         GIQ4qo8MsYfGpLbt4oPjJaxMTg+/9vAg49k7Zlp0KgzihP8wTZXBLteGFN/roaOVLfqa
         hAo76Rd154Knhkb/II+Ccq5BxmIf+UGRwI01AKFRlFQJgolzSgTUvPo/25vctbb4k63g
         nTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777013216; x=1777618016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pG5N1aWYqHr3VjwttN7NR3A/LWyrjywLz4dOCiEC67E=;
        b=JQ68Pwsp4xfC81Xaof+EWJVbgwhlYEihRJ+hMsLFNgpwdqpZSxcxHo5fM3LItbKMuz
         y1JaNPlM26tgpoRC+MHgGwVCOQ3BeHN7SeG9BwYboR/NyOJSjnBJX2s5JGH+VV8BsWju
         A8GEGREaZ84Rvx83CAH5JztuRH9lBwAOGz5mU6evi3ohlzvGVoqJ8ey+0XW5diIvdUCj
         tC89YsbwLkBdRJ43vVrnnufsp6UcI5LRKm8CmHpK2bgRkM93xclRstbxLq7+xB/yndb5
         2jGnAXRiGGA0ONoHqbo3khmsdw/IphfS2eJpOJf+jSznTfBDYHacpOdVdI61nfd9fFg/
         rOkA==
X-Forwarded-Encrypted: i=1; AFNElJ84W2KlX7vu2pU24Yerqpbo8WaF1g3cSvWzkV+DkWJxrHwbPZPZTAYuRwuNfcUYLcVx7te1Gno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw06AFIA1LXQ/Ip/nk+FurMNqEgZ6CRt8S4IiaWRXN82yUpg2q6
	PM2OQwvYZV6tF4RiqOVNyubRw7Mk/6UaRqUsFq4sEJwXnRdKPGfWfCsJfVR00DZ3Xkimgei+dbL
	7bb9pMMGvgk8pImF0bgcdXm3qS4cHKF4=
X-Gm-Gg: AeBDieuq3kSMjUinOiaM75o+kx54mJAm7DB6EOvE6E4WbS8hQCpHPbDGDCoekARcZdf
	vy2uclRP7QhwSoLnBz8tHUxSHcZz9VIl+/Row/i3UVb4/ZdpXVXwtUrnvUXO2kfPzP+0P3izX/D
	joVddBPVB76ARGF8QbiP1BEQ+oiMRcnLoQbyNc6DMB5fuNxKYYVFB55d0MW5YhnYMOeQsDeF0pc
	lF7VKYO2kYj3IzxFEhuiU1E61UtNUgWMC2zfE2gTHLUwAbyio5J03b38ZHCg1OrRrmtj5tW7GTC
	TdnO9g801QqUbS3GXw==
X-Received: by 2002:a05:690c:398:b0:7ba:fe31:65df with SMTP id
 00721157ae682-7bafe316bf1mr169650047b3.31.1777013215788; Thu, 23 Apr 2026
 23:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <20260421221016.2967924-5-ameryhung@gmail.com>
 <4de82d94-a975-4703-b45e-8932dfc28248@gmail.com> <CAMB2axO5TJwmYyvRheoZGH4ktRa0d8ig-UGK5E269iVoDH-zPw@mail.gmail.com>
 <CAEf4BzYuaA0xDm9WXv0vnorOgzmzsD-Rf6R3w5kus5Uo37SBFg@mail.gmail.com>
In-Reply-To: <CAEf4BzYuaA0xDm9WXv0vnorOgzmzsD-Rf6R3w5kus5Uo37SBFg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 23 Apr 2026 23:46:44 -0700
X-Gm-Features: AQROBzDlrTDH-m1Sd2o5aNvKzf0YODxFxjr3CBtFdZ4EBt4YziJvzugAvl_pAr4
Message-ID: <CAMB2axNJjJPU_nwQ=b5=9CSAL4GEMDNgaZp6Qdek6BmbZ35PGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/9] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D38D945A4EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280951-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,meta.com];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Thu, Apr 23, 2026 at 5:04=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 23, 2026 at 11:44=E2=80=AFAM Amery Hung <ameryhung@gmail.com>=
 wrote:
> >
> > On Thu, Apr 23, 2026 at 11:19=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> > >
> > >
> > >
> > > On 4/21/26 11:10 PM, Amery Hung wrote:
> > > > Refactor object relationship tracking in the verifier and fix a dyn=
ptr
> > > > use-after-free bug where file/skb dynptrs are not invalidated when =
the
> > > > parent referenced object is freed.
> > > >
> > > > Add parent_id to bpf_reg_state to precisely track child-parent
> > > > relationships. A child object's parent_id points to the parent obje=
ct's
> > > > id. This replaces the PTR_TO_MEM-specific dynptr_id and does not
> > > > increase the size of bpf_reg_state on 64-bit machines as there is
> > > > existing padding.
> > > >
> > > > When calling dynptr constructors (i.e., process_dynptr_func() with
> > > > MEM_UNINIT argument), track the parent's id if the parent is a
> > > > referenced object. This only applies to file dynptr and skb dynptr,
> > > > so only pass parent reg->id to kfunc constructors.
> > > >
> > > > For release_reference(), invalidating an object now also invalidate=
s
> > > > all descendants by traversing the object tree. This is done using
> > > > stack-based DFS to avoid recursive call chains of release_reference=
() ->
> > > > unmark_stack_slots_dynptr() -> release_reference(). Referenced obje=
cts
> > > > encountered during tree traversal cannot be indirectly released. Th=
ey
> > > > require an explicit helper/kfunc call to release the acquired resou=
rces.
> > > >
> > > > While the new design changes how object relationships are tracked i=
n
> > > > the verifier, it does not change the verifier's behavior. Here is t=
he
> > > > implication for dynptr, pointer casting, and owning/non-owning
> > > > references:
> > > >
> > > > Dynptr:
> > > >
> > > > When initializing a dynptr, referenced dynptrs acquire a reference =
for
> > > > ref_obj_id. If the dynptr has a referenced parent, parent_id tracks=
 the
> > > > parent's id. When cloning, ref_obj_id and parent_id are copied from=
 the
> > > > original. Releasing a referenced dynptr via release_reference(ref_o=
bj_id)
> > > > invalidates all clones and derived slices. For non-referenced dynpt=
rs,
> > > > only the specific dynptr and its children are invalidated.
> > > >
> > > > Pointer casting:
> > > >
> > > > Referenced socket pointers and their casted counterparts share the =
same
> > > > lifetime but have different nullness =E2=80=94 they have different =
id but the
> > > > same ref_obj_id.
> > > >
> > > > Owning to non-owning reference conversion:
> > > >
> > > > After converting owning to non-owning by clearing ref_obj_id (e.g.,
> > > > object(id=3D1, ref_obj_id=3D1) -> object(id=3D1, ref_obj_id=3D0)), =
the
> > > > verifier only needs to release the reference state, so it calls
> > > > release_reference_nomark() instead of release_reference().
> > > >
> > > > Note that the error message "reference has not been acquired before=
" in
> > > > the helper and kfunc release paths is removed. This message was alr=
eady
> > > > unreachable. The verifier only calls release_reference() after
> > > > confirming meta.ref_obj_id is valid, so the condition could never
> > > > trigger in practice (no selftest exercises it either). With the
> > > > refactor, release_reference() can now be called with non-acquired i=
ds
> > > > and have different error conditions. Report directly in
> > > > release_reference() instead.
> > > >
> > > > Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
> > > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > > ---
> > > >   include/linux/bpf_verifier.h |  22 ++-
> > > >   kernel/bpf/log.c             |   4 +-
> > > >   kernel/bpf/states.c          |   9 +-
> > > >   kernel/bpf/verifier.c        | 264 +++++++++++++++++-------------=
-----
> > > >   4 files changed, 152 insertions(+), 147 deletions(-)
> > > >
>
> [...]
>
> > > > @@ -673,82 +675,56 @@ static int mark_stack_slots_dynptr(struct bpf=
_verifier_env *env, struct bpf_reg_
> > > >       mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
> > > >                              &state->stack[spi - 1].spilled_ptr, ty=
pe);
> > > >
> > > > -     if (dynptr_type_refcounted(type)) {
> > > > -             /* The id is used to track proper releasing */
> > > > -             int id;
> > > > -
> > > > -             if (clone_ref_obj_id)
> > > > -                     id =3D clone_ref_obj_id;
> > > > -             else
> > > > -                     id =3D acquire_reference(env, insn_idx);
> > > > -
> > > > -             if (id < 0)
> > > > -                     return id;
> > > > -
> > > > -             state->stack[spi].spilled_ptr.ref_obj_id =3D id;
> > > > -             state->stack[spi - 1].spilled_ptr.ref_obj_id =3D id;
>
> is id assigned somewhere else now? where?
>
> > > > +     if (dynptr->type =3D=3D BPF_DYNPTR_TYPE_INVALID) { /* dynptr =
constructors */
> > > > +             if (dynptr_type_referenced(type)) {
> > > > +                     ref_obj_id =3D acquire_reference(env, insn_id=
x);
> > > > +                     if (ref_obj_id < 0)
> > > > +                             return ref_obj_id;
> > > > +             }
> > > > +     } else { /* bpf_dynptr_clone() */
> > > > +             ref_obj_id =3D dynptr->ref_obj_id;
> > > > +             parent_id =3D dynptr->parent_id;
> > > >       }
> > > >
> > > > +     state->stack[spi].spilled_ptr.ref_obj_id =3D ref_obj_id;
> > > > +     state->stack[spi - 1].spilled_ptr.ref_obj_id =3D ref_obj_id;
> > > > +     state->stack[spi].spilled_ptr.parent_id =3D parent_id;
> > > > +     state->stack[spi - 1].spilled_ptr.parent_id =3D parent_id;
> > > > +
> > > >       return 0;
> > > >   }
> > > >
>
> [...]
>
> > > > -/* The pointer with the specified id has released its reference to=
 kernel
> > > > - * resources. Identify all copies of the same pointer and clear th=
e reference.
> > > > - *
> > > > - * This is the release function corresponding to acquire_reference=
(). Idempotent.
> > > > - */
> > > > -static int release_reference(struct bpf_verifier_env *env, int ref=
_obj_id)
> > > > +static int idstack_push(struct bpf_idmap *idmap, u32 id)
> > > > +{
> > > > +     int i;
> > > > +
> > > > +     if (!id)
> > > > +             return 0;
> > > > +
> > > > +     for (i =3D 0; i < idmap->cnt; i++)
> > > > +             if (idmap->map[i].old =3D=3D id)
> > > > +                     return 0;
> > > > +
> > > > +     if (WARN_ON_ONCE(idmap->cnt >=3D BPF_ID_MAP_SIZE))
> > > > +             return -EFAULT;
> > >
> > > It feels like this check belongs above, maybe the first thing to do.
> >
> > Shouldn't it allow the verification to continue when pushing an id
> > that already exists in the stack?
>
> yep
>
> >
> > >
> > > > +
> > > > +     idmap->map[idmap->cnt++].old =3D id;
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int idstack_pop(struct bpf_idmap *idmap)
> > > >   {
> > > > +     if (!idmap->cnt)
> > > > +             return 0;
> > > > +
> > > > +     return idmap->map[--idmap->cnt].old;
> > > > +}
> > > > +
> > > > +/* Release id and objects referencing the id iteratively in a DFS =
manner */
> > > > +static int release_reference(struct bpf_verifier_env *env, int id)
> > > > +{
> > > > +     u32 mask =3D (1 << STACK_SPILL) | (1 << STACK_DYNPTR);
> > > >       struct bpf_verifier_state *vstate =3D env->cur_state;
> > > > +     struct bpf_idmap *idstack =3D &env->idmap_scratch;
> > > > +     struct bpf_stack_state *stack;
> > > >       struct bpf_func_state *state;
> > > >       struct bpf_reg_state *reg;
> > > > -     int err;
> > > > +     int root_id =3D id, err;
> > > >
> > > > -     err =3D release_reference_nomark(vstate, ref_obj_id);
> > > > -     if (err)
> > > > -             return err;
> > > > +     idstack->cnt =3D 0;
> > > > +     idstack_push(idstack, id);
> > > >
> > > > -     bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> > > > -             if (reg->ref_obj_id =3D=3D ref_obj_id)
> > > > -                     mark_reg_invalid(env, reg);
> > > > -     }));
> > > > +     if (find_reference_state(vstate, id))
> > > > +             WARN_ON_ONCE(release_reference_nomark(vstate, id));
> > > > +
> > > > +     while ((id =3D idstack_pop(idstack))) {
> > > > +             bpf_for_each_reg_in_vstate_mask(vstate, state, reg, s=
tack, mask, ({
> > > > +                     if (reg->id !=3D id && reg->parent_id !=3D id=
 && reg->ref_obj_id !=3D id)
> > > > +                             continue;
> > > > +
> > > > +                     if (reg->ref_obj_id && id !=3D root_id) {
> > >
> > > Does this line check that the only ref_obj_id we should see is either
> > > 0 or root_id? can we rewrite it as
> > > if (reg->ref_obj_id && reg->ref_obj_id !=3D root_id)
> > >
> > > this is simpler, because id can also be reg->id/reg->parent_id, which=
 is
> > > hard to reason what that means.
> > >
> >
> > Looking at it again, I think my release_reference() is wrong. It first
> > calls release_reference_nomark() if the id is a ref_obj_id. This will
> > invalidate all registers with the same ref_obj_id without traversing
> > their children.
> >
>
> hm, will it? from what I see, release_reference_nomark() doesn't do
> anything with registers/stack slots, just removes the reference from
> state->refs

You are right... I was conflating it with something else.

I think Mykyta's suggestion seems to be more straightforward so I will
change it in the next version.


>
>
> > I should remember the root_ref_obj_id instead of calling
> > release_reference_nomark(). Then, the check you mentioned should be:
> >  if (reg->ref_obj_id && reg->ref_obj_id !=3D root_ref_obj_id)
> >
> > I will write a selftest to confirm the issue and include it in the
> > next respin if this turns out to be a bug.

