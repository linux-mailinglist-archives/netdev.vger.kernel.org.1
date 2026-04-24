Return-Path: <netdev+bounces-280897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLnBAES06mnOCgAAu9opvQ
	(envelope-from <netdev+bounces-280897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 02:07:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D13D458826
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 02:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6787D30363AF
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A4F9460;
	Fri, 24 Apr 2026 00:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHMb3+Jq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA0F17D6
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 00:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776989097; cv=pass; b=gk1cGd+DFAaiDZzzCZrw6poLYJImYKLRtJEnGybgbzFZW1Ny2vB3diLffCZg2aQkX+k7+XGZUHmV0gDTTVpT7sX3kQxKyyn+Khzki9UL5B4xFlDPwpYQW3PPWOzT2uTOuJvuRF23gVXMLYoPQuNA+vY1tNUrExpai0Nrw9XxKGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776989097; c=relaxed/simple;
	bh=hJsV6cT0vW7qV0qdk7JA9SVae9yh9D+KWEZQ1r3SdRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/PDS/YsZSSlovgM+3w8AD2keeLUCpGtgJq97Ig/M9VYUvTE/iOWDRv2EjWALLtlvmtd1TYSd7IMo/UXBhLN++VwmyjMg291xdvwVxDodEvwxdiO/ELyvC24hyhlIqxjRwA4uram6sr/dOF0baLoZXK73wqu8GiVJV7Y77UQ7EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHMb3+Jq; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b788a98557so26885435ad.2
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 17:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776989096; cv=none;
        d=google.com; s=arc-20240605;
        b=WwVNly72binL4WAaM8ddAEAyoPbuKQlySeMVnwTX8qecAsPImhgMNQLj42TwY/Y235
         GQuIkcrZMs0OgzeWUIJDbGFBW2U89MlpMed/Y4VvfVMLEvUfhIvR90qzHeXfLHXC/KaZ
         1hRJHgUtz6E+4ZKxnQiXFn0+1BGVsVQrPUdweuHUGPVci9WDz3FOQ+nUAh8Iw1bnaUrN
         P4AkBEOOx15YG5Cp7E8hEw+QT2rntzZylLAZiCXuU59OUGQLldPFqZdq1dCFT+lSYGP1
         D8ggZb5+WKW5OYYjz+jZLkrPlj1MsxRLr+fahK0BzskaSedbA0AeEA7zOXdWBVbDVrYY
         NzbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MVkJEn3Mtic/kTmoQ1tOEAyWz1TWjYBFP0Bj1cv7eKU=;
        fh=1QFqm7nnm7dJkHyPwfu0+I5kFDXJw+mzvt6rnRIov1I=;
        b=gGPRgF32Esd1ySYMujFGV6zUWowg9qckRDVN5T8rCvvvfddKy+4UQ2W/fmbE5dVpGI
         ykQNh25GaKhXnszegksJP1MTG48e1UMeYIVMQ8bY3hJEogmqR1yVM4veikEAnU4Gs+z3
         QIxoSIp+w6jAKsCGpGTvYPqq3riQ/f2RwfGg12v3qs12pbaqBENRyKgPpR0y5Rpb+VJO
         Hgq4iDenPoOd9yuPZOmVPTAdldyUui1WyDotNuwwXFc949S1HnFZLfG7vVmL2ddZTJLH
         n8vTmSaYEaAj4bxH4dYcoSl+L6DfkYjQKHrQiP0TbGaBlsBot9bH01zAT/oVZMnNOIpg
         fI6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776989096; x=1777593896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVkJEn3Mtic/kTmoQ1tOEAyWz1TWjYBFP0Bj1cv7eKU=;
        b=sHMb3+JqSq2TZh/SmCB37vC1hPwFnoE8AAFvsyjyUr6t7Hh3cdEeaax7uh9k9W1VyN
         5PkwbF7oubK6cC81RF4evi8WpaQtbST56d1evfQUsJ/NnpLWefDFYJ0+6920h/0Ge5/Z
         pcI3NKjmSKySvL2joEvoF8/vo/bLMaKxYMo93WNsqNTMEXTRNJoDg3LXy4dfKqtWLMSi
         nbL0m26JfSuPa1kINI2gS8yf8wQ53u/FJPWLSOqTA3XrBaZxILbNwYxT2mhulhObaFnf
         IAjD1qvjRzDVzB8cJYkstzRRrNDvRtE6u2pQb+KEXTWCOrDqC0HyfnQt5m8V9VQmecFE
         NWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776989096; x=1777593896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MVkJEn3Mtic/kTmoQ1tOEAyWz1TWjYBFP0Bj1cv7eKU=;
        b=IxaWOrKidp5rut7ztTlpCptIZnW366o1axyK+pDtIFDWNckbAJ6ZUYCYf6bq/tZfxZ
         3xQLjzmRNyCXCkpSiBcxb1nUXjkZJdiMjCc17OvjNUNA1ncPSRiNmBiGdMXA9nKukkm/
         2W/FGtrKGJrtgB5Q+JTC2jthFB4r/aVZ8bdUvKc6alZEI69zOUt+5Qv/nIYtpuaYX923
         JungyPPpHj4nImP2PaGN+YVpb3e2eSNTUYneNIEj63LDPtrAtBp0zQ5Sh5zFzrHpHYZH
         Hs/iSxrek5v6Bl/T8WVVb9siTuUzFJbIQI0yb5LxSCKb6mH7CDAU1RmcEUrIXkFRrvnd
         0MgQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DhQl3VPY7qWfOSn0Tg4Y78QqspACZIPRB9aOQMZx15fAtjdBxd3l3FhwiT4u5x/at3ZzwLi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjkIjmWdDx1bnG5FkvVVOz0fFsSjyrddqAIheF8ycYEORu9qOY
	PoDW3PSU0h8clMgFeOnEaQGq1gnGgt0ILa3XdbYCQA5hQ/J0st72vQ1diXiKfIk5RcQP8LAi3Yu
	qQajuKOAAw5ZwDaikQA+y1X92iDWoXohteQ==
X-Gm-Gg: AeBDietYxm/68g3cAxM+aZbQyReEkiM5NYF/vp1KeCANXHWSlwNz/tt7qGzN0DWFDTF
	FL9mgHyEZjfcDCfJvB5DVOigNFzbGU6YTsdiSSnkO5M3zadndPjS9b1pNgtEby/ZCV92FnBp2/k
	hOz+LCDIvtpnIlRZQzN/Mod+VG5TkK8T0lfy3/uDtz4c0LglfoLgUGTajHyUInAwzjWgNYz5v9n
	fbHAkRkI2OonBZQi9BWr5+nrD/VmfTGHDsBMXum8EvezlJGG6ZmM9zHViwyNQP6zcv6uab5V1kO
	Xuh3YE0yjAhlMIp1WeEJi5+/V9woCwI2JA==
X-Received: by 2002:a17:903:1105:b0:2b7:ad1f:cc0c with SMTP id
 d9443c01a7336-2b7ad1fcd58mr48496375ad.30.1776989095819; Thu, 23 Apr 2026
 17:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <20260421221016.2967924-5-ameryhung@gmail.com>
 <4de82d94-a975-4703-b45e-8932dfc28248@gmail.com> <CAMB2axO5TJwmYyvRheoZGH4ktRa0d8ig-UGK5E269iVoDH-zPw@mail.gmail.com>
In-Reply-To: <CAMB2axO5TJwmYyvRheoZGH4ktRa0d8ig-UGK5E269iVoDH-zPw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 23 Apr 2026 17:04:40 -0700
X-Gm-Features: AQROBzB5Lyd9RPKGzNgDQY9m8WkZtzNam9RMcL4ErM8Z9IzqcJ9leXMeGhhQdDg
Message-ID: <CAEf4BzYuaA0xDm9WXv0vnorOgzmzsD-Rf6R3w5kus5Uo37SBFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/9] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
To: Amery Hung <ameryhung@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8D13D458826
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
	TAGGED_FROM(0.00)[bounces-280897-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,meta.com];
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

On Thu, Apr 23, 2026 at 11:44=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> On Thu, Apr 23, 2026 at 11:19=E2=80=AFAM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >
> >
> >
> > On 4/21/26 11:10 PM, Amery Hung wrote:
> > > Refactor object relationship tracking in the verifier and fix a dynpt=
r
> > > use-after-free bug where file/skb dynptrs are not invalidated when th=
e
> > > parent referenced object is freed.
> > >
> > > Add parent_id to bpf_reg_state to precisely track child-parent
> > > relationships. A child object's parent_id points to the parent object=
's
> > > id. This replaces the PTR_TO_MEM-specific dynptr_id and does not
> > > increase the size of bpf_reg_state on 64-bit machines as there is
> > > existing padding.
> > >
> > > When calling dynptr constructors (i.e., process_dynptr_func() with
> > > MEM_UNINIT argument), track the parent's id if the parent is a
> > > referenced object. This only applies to file dynptr and skb dynptr,
> > > so only pass parent reg->id to kfunc constructors.
> > >
> > > For release_reference(), invalidating an object now also invalidates
> > > all descendants by traversing the object tree. This is done using
> > > stack-based DFS to avoid recursive call chains of release_reference()=
 ->
> > > unmark_stack_slots_dynptr() -> release_reference(). Referenced object=
s
> > > encountered during tree traversal cannot be indirectly released. They
> > > require an explicit helper/kfunc call to release the acquired resourc=
es.
> > >
> > > While the new design changes how object relationships are tracked in
> > > the verifier, it does not change the verifier's behavior. Here is the
> > > implication for dynptr, pointer casting, and owning/non-owning
> > > references:
> > >
> > > Dynptr:
> > >
> > > When initializing a dynptr, referenced dynptrs acquire a reference fo=
r
> > > ref_obj_id. If the dynptr has a referenced parent, parent_id tracks t=
he
> > > parent's id. When cloning, ref_obj_id and parent_id are copied from t=
he
> > > original. Releasing a referenced dynptr via release_reference(ref_obj=
_id)
> > > invalidates all clones and derived slices. For non-referenced dynptrs=
,
> > > only the specific dynptr and its children are invalidated.
> > >
> > > Pointer casting:
> > >
> > > Referenced socket pointers and their casted counterparts share the sa=
me
> > > lifetime but have different nullness =E2=80=94 they have different id=
 but the
> > > same ref_obj_id.
> > >
> > > Owning to non-owning reference conversion:
> > >
> > > After converting owning to non-owning by clearing ref_obj_id (e.g.,
> > > object(id=3D1, ref_obj_id=3D1) -> object(id=3D1, ref_obj_id=3D0)), th=
e
> > > verifier only needs to release the reference state, so it calls
> > > release_reference_nomark() instead of release_reference().
> > >
> > > Note that the error message "reference has not been acquired before" =
in
> > > the helper and kfunc release paths is removed. This message was alrea=
dy
> > > unreachable. The verifier only calls release_reference() after
> > > confirming meta.ref_obj_id is valid, so the condition could never
> > > trigger in practice (no selftest exercises it either). With the
> > > refactor, release_reference() can now be called with non-acquired ids
> > > and have different error conditions. Report directly in
> > > release_reference() instead.
> > >
> > > Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> > >   include/linux/bpf_verifier.h |  22 ++-
> > >   kernel/bpf/log.c             |   4 +-
> > >   kernel/bpf/states.c          |   9 +-
> > >   kernel/bpf/verifier.c        | 264 +++++++++++++++++---------------=
---
> > >   4 files changed, 152 insertions(+), 147 deletions(-)
> > >

[...]

> > > @@ -673,82 +675,56 @@ static int mark_stack_slots_dynptr(struct bpf_v=
erifier_env *env, struct bpf_reg_
> > >       mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
> > >                              &state->stack[spi - 1].spilled_ptr, type=
);
> > >
> > > -     if (dynptr_type_refcounted(type)) {
> > > -             /* The id is used to track proper releasing */
> > > -             int id;
> > > -
> > > -             if (clone_ref_obj_id)
> > > -                     id =3D clone_ref_obj_id;
> > > -             else
> > > -                     id =3D acquire_reference(env, insn_idx);
> > > -
> > > -             if (id < 0)
> > > -                     return id;
> > > -
> > > -             state->stack[spi].spilled_ptr.ref_obj_id =3D id;
> > > -             state->stack[spi - 1].spilled_ptr.ref_obj_id =3D id;

is id assigned somewhere else now? where?

> > > +     if (dynptr->type =3D=3D BPF_DYNPTR_TYPE_INVALID) { /* dynptr co=
nstructors */
> > > +             if (dynptr_type_referenced(type)) {
> > > +                     ref_obj_id =3D acquire_reference(env, insn_idx)=
;
> > > +                     if (ref_obj_id < 0)
> > > +                             return ref_obj_id;
> > > +             }
> > > +     } else { /* bpf_dynptr_clone() */
> > > +             ref_obj_id =3D dynptr->ref_obj_id;
> > > +             parent_id =3D dynptr->parent_id;
> > >       }
> > >
> > > +     state->stack[spi].spilled_ptr.ref_obj_id =3D ref_obj_id;
> > > +     state->stack[spi - 1].spilled_ptr.ref_obj_id =3D ref_obj_id;
> > > +     state->stack[spi].spilled_ptr.parent_id =3D parent_id;
> > > +     state->stack[spi - 1].spilled_ptr.parent_id =3D parent_id;
> > > +
> > >       return 0;
> > >   }
> > >

[...]

> > > -/* The pointer with the specified id has released its reference to k=
ernel
> > > - * resources. Identify all copies of the same pointer and clear the =
reference.
> > > - *
> > > - * This is the release function corresponding to acquire_reference()=
. Idempotent.
> > > - */
> > > -static int release_reference(struct bpf_verifier_env *env, int ref_o=
bj_id)
> > > +static int idstack_push(struct bpf_idmap *idmap, u32 id)
> > > +{
> > > +     int i;
> > > +
> > > +     if (!id)
> > > +             return 0;
> > > +
> > > +     for (i =3D 0; i < idmap->cnt; i++)
> > > +             if (idmap->map[i].old =3D=3D id)
> > > +                     return 0;
> > > +
> > > +     if (WARN_ON_ONCE(idmap->cnt >=3D BPF_ID_MAP_SIZE))
> > > +             return -EFAULT;
> >
> > It feels like this check belongs above, maybe the first thing to do.
>
> Shouldn't it allow the verification to continue when pushing an id
> that already exists in the stack?

yep

>
> >
> > > +
> > > +     idmap->map[idmap->cnt++].old =3D id;
> > > +     return 0;
> > > +}
> > > +
> > > +static int idstack_pop(struct bpf_idmap *idmap)
> > >   {
> > > +     if (!idmap->cnt)
> > > +             return 0;
> > > +
> > > +     return idmap->map[--idmap->cnt].old;
> > > +}
> > > +
> > > +/* Release id and objects referencing the id iteratively in a DFS ma=
nner */
> > > +static int release_reference(struct bpf_verifier_env *env, int id)
> > > +{
> > > +     u32 mask =3D (1 << STACK_SPILL) | (1 << STACK_DYNPTR);
> > >       struct bpf_verifier_state *vstate =3D env->cur_state;
> > > +     struct bpf_idmap *idstack =3D &env->idmap_scratch;
> > > +     struct bpf_stack_state *stack;
> > >       struct bpf_func_state *state;
> > >       struct bpf_reg_state *reg;
> > > -     int err;
> > > +     int root_id =3D id, err;
> > >
> > > -     err =3D release_reference_nomark(vstate, ref_obj_id);
> > > -     if (err)
> > > -             return err;
> > > +     idstack->cnt =3D 0;
> > > +     idstack_push(idstack, id);
> > >
> > > -     bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> > > -             if (reg->ref_obj_id =3D=3D ref_obj_id)
> > > -                     mark_reg_invalid(env, reg);
> > > -     }));
> > > +     if (find_reference_state(vstate, id))
> > > +             WARN_ON_ONCE(release_reference_nomark(vstate, id));
> > > +
> > > +     while ((id =3D idstack_pop(idstack))) {
> > > +             bpf_for_each_reg_in_vstate_mask(vstate, state, reg, sta=
ck, mask, ({
> > > +                     if (reg->id !=3D id && reg->parent_id !=3D id &=
& reg->ref_obj_id !=3D id)
> > > +                             continue;
> > > +
> > > +                     if (reg->ref_obj_id && id !=3D root_id) {
> >
> > Does this line check that the only ref_obj_id we should see is either
> > 0 or root_id? can we rewrite it as
> > if (reg->ref_obj_id && reg->ref_obj_id !=3D root_id)
> >
> > this is simpler, because id can also be reg->id/reg->parent_id, which i=
s
> > hard to reason what that means.
> >
>
> Looking at it again, I think my release_reference() is wrong. It first
> calls release_reference_nomark() if the id is a ref_obj_id. This will
> invalidate all registers with the same ref_obj_id without traversing
> their children.
>

hm, will it? from what I see, release_reference_nomark() doesn't do
anything with registers/stack slots, just removes the reference from
state->refs


> I should remember the root_ref_obj_id instead of calling
> release_reference_nomark(). Then, the check you mentioned should be:
>  if (reg->ref_obj_id && reg->ref_obj_id !=3D root_ref_obj_id)
>
> I will write a selftest to confirm the issue and include it in the
> next respin if this turns out to be a bug.

