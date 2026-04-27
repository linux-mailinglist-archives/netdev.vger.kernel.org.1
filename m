Return-Path: <netdev+bounces-281482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEwuJK3F72m4FwEAu9opvQ
	(envelope-from <netdev+bounces-281482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:23:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C71A479F8A
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B4843006917
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799EF369972;
	Mon, 27 Apr 2026 20:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCBPO/SA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D50336605D
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 20:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321332; cv=pass; b=f+P3PTCC7CT66OwRswPvAKsXbjWiDDzavxN7QukQRYfN/2iIwQ6SiI3ZjPVXdthXj+4cjgCivgFlNk78lxv5hxj+t7FKFiR33hJ2VyaOjW+mOXVc4xEfBrUaLcrjekSd86xxk6GIFuvOeRRKlrsvFhei9TRbf652yozWzpzTsNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321332; c=relaxed/simple;
	bh=F7RnZQyofIqoxi6/JgCEvInihHjH9MJfRMoh9ax68EU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOwqvbBdsuqv23cpR0sSaCpgMoUPUM1ytqetnXjpxgWblh6G7ZmDrWI55yoOa8IuPh62YZG/f+oIjdiN/Sw2s43ES7qlTUET9bPQxcNwjjHlSWBiCgCcDp1i+/6l+uvVf8e3WFVCV/gxGqDYWIA8vJe3UGAUW2YhBakZlrSgSQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCBPO/SA; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7986e0553bdso100261587b3.2
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777321327; cv=none;
        d=google.com; s=arc-20240605;
        b=iyx2y5HvSwNlO3FBGPwnAIP50Ld7JBSqDxwPkn9w7ASKkjiwLXipf1n6QO9vf0OxSI
         rXqWO8Cp+t09dp9lr7f1I6PLJM/euGIKuss76PDsfGTIepdsJ/npEosNwEzv7Zif5Yv6
         kV+8JIjDeRi5Gh3ZT/n89oJRj1E4QvAk6KT5EkJYFnf9oCpyzF2P+fnJVaI3SKnT1Nbt
         CxsuCjosWNVMsnb+L6xJOukAmLLEZoyJ5yOTuJgsTu047q7UgfYwGtq5Y8kRzdfI0ExX
         JPQ3rhvhUeIeucoG09sVGQW/ddLVrIiP1qxfl0lrJ5OfMH6CwFYMhx6huDpKZpUpOsbf
         +akg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yOtoDnDNchld4ojNMPegBUESZZsJrSC2lT5MFUvnqLE=;
        fh=zWBxJYdUe/9nMEQpJ1Qj5e/mSGHa6d3P/3FMyoTrxTk=;
        b=VnNg5f0Q9Ttbr61/SVejGH+TK460DJESloN3MY7qGDrPdrth5LjUtHgbzY18fDWBEI
         whfrCjX3fW8ODjmg1XSG3Sc5+U2STcsxgubw5hTFxRd7kRRgfJd7LuYhIh/2ni4vep4D
         63RbAP+SlJg4pslZIkuZpCT/NUZcUEAaH6g7DdGLlCs1Bjiuhb7HCyQE1FNVhSZg8f/2
         YCgyIZ8pO34kwmutajCtoYZ/P426AYv5n0bLFc1Hv6vHvE+t2+lPpjFipx2l1Zy8d6Xg
         3i5MUjDFczfqFsub4yruO4fUQKVfGppft2SsjI90sfuvIbWQkCO/aIxVbOPdSlau2oxS
         tUPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777321327; x=1777926127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOtoDnDNchld4ojNMPegBUESZZsJrSC2lT5MFUvnqLE=;
        b=VCBPO/SA4xyM2FNDvaWN7zFHudA/Y+Vqj27rCQOSesxP0JeYAwtlqhftD/QDa325/B
         jhwFvpWIVNxxDwonSIyEyLEx7KrnBjjcoOKXZP9ebIt92Dn46Png07bfyVEbIC3H8G4c
         7gSfhU8BVlM7kGFwDh2m89BjuwpqjhnR1dmzkHlzP1w6xINXVbtxFdt/ygaHTKBoJdAr
         Eu5GTR4/h6w5EQDz9+nlEB2KgnE+6nwo+MvM2mkpNqAj18RQMDbCR7UC/A3dSwxwp7Yl
         Qvk6bmt8+Azw2KsRiFSLYjzUXNMEnon9vBxKH3YrVxF1vU47rKKr1FO3dvlmZ4yDewOE
         UrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777321327; x=1777926127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yOtoDnDNchld4ojNMPegBUESZZsJrSC2lT5MFUvnqLE=;
        b=gyOUt0gOGWjj96lHwWpe+VphfXHLEIHp63Wi10TKhoG/69HkIPTmdVIoN0M6TTToPq
         /SsCi9iYLWmMJgkfnjZ0/jkEZIodIok2BjnyGZBL09J+6TT5N8btTip0aIb2eEwVByVm
         TV/xjSX840KsTWpmogN/8IODUpwAERbWCBEA7TVKmatiqvGZ+Hq9DqpDrP+xHCc+AWC/
         PESXmd8EMX5WThPNl8FAb+VFa4nMKXq5+1xd2lm3zyP0EEa5jtphdQXEhkqtQyR19OQR
         OoXQ4d4FFMIlA4kLZIChMJERvcJ8UH+TQgwYjUL40mc5CjZJ1qTlt7iNfrX6mWdGam9/
         aSeg==
X-Forwarded-Encrypted: i=1; AFNElJ+r0/5hJ90xXqxjv3Fo/5ceVUmQpWo3xxJBASZ83fLYnDhHH536vuMjEsENM8Dd5eVPYdphWgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwffAiW9+tX+5Q8fADvMJnOwBAlAOQgHAuWyKLaXc8saluOUChX
	LZ+fRTC4h0sVPHyOj8mhfK867IrZWH90jZBPE++UXRg3O06UHGJQjFtPziP7G2s1Js66N8oHJZr
	/kl3Gx9mjHY9zzyCTbDlaun9Pt2Hy0ik=
X-Gm-Gg: AeBDievX99qTNBBwHtjUW3yK9AMCEzRQ2Gy0OLMHBzsbqSnroPgwCHwgL6RLCM5EKaa
	9fGZIznzi/BiPe5HYzHGL/0+K4hD7DLV/onYm+rHHtmmvdagSVbkh+1nMmY5PCj9vhQLDpHJ7WR
	0jteb9czeNk7ynZSBfw6a0JWT4j/E1htJ/xeEvd3YPruljRUrilh8qytGu9OcYKwDDJBHQ9OU5+
	D8cLWCiRUCvFXDmaLXhIguDGLND49TWa4PQUSaKssqHQ69mxeq4YK6fE/yYVwzDC1sNk7p6Ipip
	t9kh7UCOkJUHG10TiA==
X-Received: by 2002:a05:690c:dd4:b0:79e:766d:81df with SMTP id
 00721157ae682-7bcf569ae92mr557987b3.33.1777321327322; Mon, 27 Apr 2026
 13:22:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <20260421221016.2967924-5-ameryhung@gmail.com>
 <02dbf08511c72ea0c1a5caa33ed400f4a3e3c3c9.camel@gmail.com>
In-Reply-To: <02dbf08511c72ea0c1a5caa33ed400f4a3e3c3c9.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 27 Apr 2026 13:21:56 -0700
X-Gm-Features: AVHnY4KdDBFYuyv7k4V8_Bm_jmlOHY-wGyNt47hVjrqws-YsH583v8U2Z7HKWpA
Message-ID: <CAMB2axPaDEG_oKLxhcRmivv+YK_ExxNVY_KpSf1vvgLiPq1tvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/9] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9C71A479F8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281482-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 3:48=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2026-04-21 at 15:10 -0700, Amery Hung wrote:
>
> Tbh, I find current state of affairs with id/ref_obj_id/parent_id hard
> to follow. The release_reference() is an improvement, but the means by
> which the fields are propagated to bpf_reg_state objects are convoluted.
> I wonder if having a separate "object table" in bpf_verifier_state and
> having bpf_reg_state->id refer to objects within this table would make
> things more straight forward.

I think this is a good idea in the long term. First, we need to make
id a stable and unique object identifier (i.e., always assign id to
objects; different objects have different ids). Then, we can create
the object table indexed by id and each entry contains the ref_obj_id
and parent_id moved from bpf_reg_state. Then, there will be helpers
managing the lifetime, relationship (e.g., bpf_obj_create,
bpf_obj_release, bpf_obj_clone) with clear semantics to centralize how
id,parent_id,ref_obj_id are manipulated.

If this makes sense, I can send this as a follow up patchset.

>
> A few nits below.
>
> [...]
>
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
>
> [...]
>
> > @@ -1323,6 +1335,7 @@ struct bpf_dynptr_desc {
> >       enum bpf_dynptr_type type;
> >       u32 id;
> >       u32 ref_obj_id;
> > +     u32 parent_id;
> >  };
>
> Nit: would be nice to have a comment describing when the above fields
>      are populated.

Ack

>
> >
> >  struct bpf_kfunc_call_arg_meta {
> > @@ -1334,6 +1347,7 @@ struct bpf_kfunc_call_arg_meta {
> >       const char *func_name;
> >       /* Out parameters */
> >       u32 ref_obj_id;
> > +     u32 id;
>
> Nit: would be nice to have a comment here too.

Ack

>
> [...]
>
> > diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> > index 8478d2c6ed5b..72bd3bcda5fb 100644
> > --- a/kernel/bpf/states.c
> > +++ b/kernel/bpf/states.c
> > @@ -494,7 +494,8 @@ static bool regs_exact(const struct bpf_reg_state *=
rold,
> >  {
> >       return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) =3D=
=3D 0 &&
> >              check_ids(rold->id, rcur->id, idmap) &&
> > -            check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
> > +            check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap) &&
> > +            check_ids(rold->parent_id, rcur->parent_id, idmap);
>
> Nit: these check_ids() become repetitive, maybe add a utility function
>      checking id/ref_obj_id/parent_id?

Will add a utility function.

>
> >  }
> >
> >  enum exact_level {
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
>
> Not something changed by the current patch, but still a question:
> this path ignores old_reg->id, is it a bug?

Yes. I will also check id.

>
> >                               return false;
> >                       break;
> >               case STACK_ITER:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0313b7d5f6c9..908a3af0e7c4 100644
>
> [...]
>
> > @@ -241,6 +241,7 @@ struct bpf_call_arg_meta {
> >       int mem_size;
> >       u64 msize_max_value;
> >       int ref_obj_id;
> > +     u32 id;
>
> Nit: please add a comment here as well.

Ack

>
> [...]
>
> > @@ -635,11 +636,12 @@ static int destroy_if_dynptr_stack_slot(struct bp=
f_verifier_env *env,
> >                                       struct bpf_func_state *state, int=
 spi);
> >
> >  static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struc=
t bpf_reg_state *reg,
> > -                                enum bpf_arg_type arg_type, int insn_i=
dx, int clone_ref_obj_id)
> > +                                enum bpf_arg_type arg_type, int insn_i=
dx, int parent_id,
> > +                                struct bpf_dynptr_desc *dynptr)
>
> Having both parent_id and dynptr->parent_id as parameters of this
> function is very confusing, but I don't have a suggestion on how to
> better deal with it.

Does tweaking the argument name and reorder the if-else block make it
more obvious how these two arguments are used?

if (clone_dynptr->type !=3D BPF_DYNPTR_TYPE_INVALID) { /* bpf_dynptr_clone(=
) */
        ref_obj_id =3D clone_dynptr->ref_obj_id;
        parent_id =3D clone_dynptr->parent_id;
} else { /* dynptr constructors */
        if (dynptr_type_referenced(type)) {
                ref_obj_id =3D acquire_reference(env, insn_idx);
                if (ref_obj_id < 0)
                        return ref_obj_id;
        }
}

>
> [...]
>
> > @@ -8489,6 +8444,7 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
> >                       return -EACCES;
> >               }
> >               meta->ref_obj_id =3D reg->ref_obj_id;
> > +             meta->id =3D reg->id;
>
> Could you please leave a comment here explaining when e.g.
> meta->ref_obj_id and meta->id would have same or different ids here?
> Maybe a few lines of BPF C code.

Ack

>
> >       }
> >
> >       switch (base_type(arg_type)) {
> > @@ -9111,26 +9067,75 @@ static int release_reference_nomark(struct bpf_=
verifier_state *state, int ref_ob
>
> [...]
>
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
> > +                             struct bpf_reference_state *ref_state;
> > +
> > +                             ref_state =3D find_reference_state(env->c=
ur_state, reg->ref_obj_id);
> > +                             verbose(env, "Unreleased reference id=3D%=
d alloc_insn=3D%d when releasing id=3D%d\n",
> > +                                     ref_state->id, ref_state->insn_id=
x, root_id);
> > +                             return -EINVAL;
> > +                     }
> > +
> > +                     if (reg->id !=3D id) {
> > +                             err =3D idstack_push(idstack, reg->id);
> > +                             if (err)
> > +                                     return err;
> > +                     }
> > +
> > +                     if (!stack || stack->slot_type[BPF_REG_SIZE - 1] =
=3D=3D STACK_SPILL)
> > +                             mark_reg_invalid(env, reg);
> > +                     else if (stack->slot_type[BPF_REG_SIZE - 1] =3D=
=3D STACK_DYNPTR)
> > +                             invalidate_dynptr(env, state, stack);
>
> invalidate_dynptr() rewrites to stack slots, can it be the case that
> this body of bpf_for_each_reg_in_vstate_mask() is computed for first
> and second dynptr stack slots, hence triggering invalidate_dynptr() to
> rewrite three slots instead of two?

invalidate_dynptr() will mark the two stack slots as STACK_INVALID so
I didn't bother to check whether it is the first slot or not. Am I
missing anything?

>
> > +             }));
> > +     }
> >
> >       return 0;
> >  }
>
> [...]
>
> > @@ -12009,6 +12009,7 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
> >                               return -EFAULT;
> >                       }
> >                       meta->ref_obj_id =3D reg->ref_obj_id;
> > +                     meta->id =3D reg->id;
>
> And here a comment describing when this happens would be helpful.
>

Ack

> [...]
>
> > @@ -12171,15 +12171,10 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_kfunc_call_
> >                               }
> >
> >                               dynptr_arg_type |=3D (unsigned int)get_dy=
nptr_type_flag(parent_type);
> > -                             clone_ref_obj_id =3D meta->dynptr.ref_obj=
_id;
> > -                             if (dynptr_type_refcounted(parent_type) &=
& !clone_ref_obj_id) {
> > -                                     verifier_bug(env, "missing ref ob=
j id for parent of clone");
> > -                                     return -EFAULT;
> > -                             }
> >                       }
> >
> > -                     ret =3D process_dynptr_func(env, regno, insn_idx,=
 dynptr_arg_type, clone_ref_obj_id,
> > -                                               &meta->dynptr);
> > +                     ret =3D process_dynptr_func(env, regno, insn_idx,=
 dynptr_arg_type,
> > +                                               meta->ref_obj_id ? meta=
->id : 0, &meta->dynptr);
>
> And an example here as well.

Ack

>
> >                       if (ret < 0)
> >                               return ret;
> >                       break;
>
> [...]

