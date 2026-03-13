Return-Path: <netdev+bounces-267591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NtMJdZ0tGmUoQAAu9opvQ
	(envelope-from <netdev+bounces-267591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:34:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CDA289C70
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED3F73049335
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8A637B00E;
	Fri, 13 Mar 2026 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkTllBaa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFB637C90D
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773434023; cv=pass; b=iJc9TnRL1ki9JCZLwRNlsl3cuxUqcv1OlEev/AYMA5eahmqbcsVST1fhcDlHpELUo16dT4bL02X3wPcPGW3DcF+rA88teMLdUipUEp4rnZemXVAe/77ESaFacnOm2ZI2mZ47Ik43xK9abrvK4I4LFNdXxI7uYs6BXDGrWEw7a+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773434023; c=relaxed/simple;
	bh=KigqEiU5ir5fK974/mou1mjF/UDnZJdZf8k4UrSQ5f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3qqfbaUjTRqUNRmgsdxIl32hwxVv6ZuW9P7uu8wn75hB8hQrYGWY8XqwRpLGZyyBd4aaKG2hm8GgQDAyeYv++HybwgIrfv5DPv5Bc+xDcRjHsmo+nC5ThCIdwu9MrvgiJ8p27xFYNrGrZ8PIdGIR9VR8DpS2xtyaP5f8DLbsR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkTllBaa; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79906e5c7f1so28101847b3.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773434020; cv=none;
        d=google.com; s=arc-20240605;
        b=fPHyf6DSNyMoC5KiWRphi0r4Tf5QLaRce9OFfIgRq5ovQYIfdOjqBQtppWzL15xaKe
         P2HNtnAVIssXlgmA+9JVGHjIIXf2liIvw+MRkXpxJ4ycXCDXmcSmQfOSFaLqtSriYivr
         vZMjAPu+K3R5NBXeR+7v+zXnKdfbRKjVwXeijPIktmhAjMO0K+l3ZfAeaYEf9gbW2L4U
         xZRH20obJ9XQrhCmXp1Qx1GPiucYlEHIXqLsRfd4SHW6YWS1J0w6KwRpAOdqBUcviv8i
         iSex9ahhJxJDFFmktNWRdDHrGforliYmH6x2M04DRdsoxx9HV7tp1jtPOpix6uwzjMOP
         Trzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SXk1x+OrfxCI+KRjy1ffsvpyWQf6bNg0D0dNKlXNNp0=;
        fh=aG0msOzyJXka6i/GN82ZAQqeicEiXYRDYRSn/tMdxCc=;
        b=dxLvosAUiqwbFamOjMarezTt9MJWv4h5GKjCyPWM/gzpt0PMywHAAhFACKLFCljZjf
         0SQo0KFIfX+qteRCzCaQU1GJbohjWvh86aRk8oba9j1fltgKAXiXGMcrYUOqC9KXrFUl
         A1NXdkcX/PR54PTMZnC3XxKyujgseD/ajDVfcl1oqxRRcQRcaBjaZuWt5533ZZIctEJ9
         /9NWSterXVavnNQ/q6isHlYpyZpJYMFZB7//jFzcOjR/JJlwyHbGDxMig+4kCkMykSTI
         /BNgbx/a2pgrrzQK61LO16oTDSA4pGMbKTsm9ix2SGdg7/l/Y3BPsHGNjjzqbsHHlhoO
         rqug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773434020; x=1774038820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXk1x+OrfxCI+KRjy1ffsvpyWQf6bNg0D0dNKlXNNp0=;
        b=HkTllBaagbk//jKZnE0kyHWmeRnoJOdR5InuK8tx8yhi0WgVS2rEBcUUo418Zp+8Ub
         /6N7xGlVTVtPbSFs2YKLybrFoYICGwp7DzA9SL+HtatZuqKL3hXbclt8rtKXa5hcNii5
         sXUe2oomoYu4OlXljXQHN7kVBLFH1wfoKrGACdhm+AwxT5Tq7XEjP7VzGXAufPmihGLJ
         ICAXt6Pg8PSJHxhPlULItDxQejePnysqXF0md8vKUmCyKQ4m9xtH4/5uqS5DnxqokyzP
         xiJpibItUJ02h06U2qikBc/0qZenPP9HYRTWqSagCl8w89OKglh+VirBD4vj2tWmahlx
         426Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773434020; x=1774038820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SXk1x+OrfxCI+KRjy1ffsvpyWQf6bNg0D0dNKlXNNp0=;
        b=rOUiI5FiISygwLe9ypaRIZ1/R58W3mzBGyTd5ZpaiTNmkq/wLZDIBqcFqPYHDNy7uu
         1VDVHYXJ7OSaROVBj5L/bvEp5CIIiifABkgAOakkADEMRmmm/yVmVSwD42y2QPnryLVr
         DOPaSmwJUC6GRJ51mTk1fiwKgIUleycbSKP/EtOeP3wthM4yTHQtaXv47sfux2YhLaud
         JF7KeGGlp9L/t67LiHhlBTEdHO8rF5DFUrY0niyx5IPVVy0AaQNQlmIrWx/88h051frt
         pVrDivbwLsvKUVXDeOGLik+JYQWT/NBGWkfCFzPa/mbVSR1HJhsOe2XEhtapKY94gNHN
         Fq/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMl6Q1wbOUqh8Ky5ik4xv41iVuRe5skIqKj9UNyrxXNJgSc+Zlt0yFBrccCyKaY1A71otj+KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhzibeUAnOG5ZNHnUAZzdQpZnzUhY+7HoBKYlisxmJJxkLFeAv
	BiqigDXvL7ti23cy5A5l3K8IK0Kbz5WvuLckveNN0ey80KL6cFF1iP/6GsXtasU0kzNtjP9xWv8
	b/o0AyWhXqetppDXNqypgfPB55SAN+yU=
X-Gm-Gg: ATEYQzzUzTQ1+nG3lSDoQHNkIG1i6fYe8icSf3ekfU/GYkCOpIUOne79+KozF0CMigd
	piSSBKDAO9vJ0B1PzoK0ffrDAZcdm6+fwOQKSGHiaQaPkqmPJgE8UNSm/DgvRgFsLRyl4MCfS/U
	uLoFcq8lT4Ys9KPpHI7N1dB/nr1LNdaTB5PuXi84gbw+ryGObvRhUgC4W22HTWEl+MGD8fv3WIp
	x6w66FA+hpm2X5UCiXqz/3tWiIfm9pu8q5qMc/2USlc3z1hxO/S7KKxdr9AWP8MoVh/8W445RJg
	ooB/nRQ=
X-Received: by 2002:a05:690c:6e83:b0:798:5b02:25bf with SMTP id
 00721157ae682-79a1c23c251mr50620607b3.57.1773434019609; Fri, 13 Mar 2026
 13:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-7-ameryhung@gmail.com>
 <87cy18tyg2.fsf@gmail.com>
In-Reply-To: <87cy18tyg2.fsf@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 13 Mar 2026 13:33:28 -0700
X-Gm-Features: AaiRm51BFE7eXZuPPt2fyWTUR4pvnw1GeNcf_8q4S1pJd_0CxjEgOmX1dUbCrU8
Message-ID: <CAMB2axNzwU1scAbHf0FbO0ZrNbMDeujo+8+U2HswJCR87LzwpQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 06/11] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267591-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60CDA289C70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 4:33=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Amery Hung <ameryhung@gmail.com> writes:
>
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
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index c1e30096ea7b..e987a48f511a 100644
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
> > @@ -707,6 +713,11 @@ struct bpf_idset {
> >       } entries[BPF_ID_MAP_SIZE];
> >  };
> >
> > +struct bpf_idstack {
> > +     int cnt;
> > +     u32 ids[BPF_ID_MAP_SIZE];
> > +};
> > +
> >  /* see verifier.c:compute_scc_callchain() */
> >  struct bpf_scc_callchain {
> >       /* call sites from bpf_verifier_state->frame[*]->callsite leading=
 to this SCC */
> > @@ -789,6 +800,7 @@ struct bpf_verifier_env {
> >       union {
> >               struct bpf_idmap idmap_scratch;
> >               struct bpf_idset idset_scratch;
> > +             struct bpf_idstack idstack_scratch;
> >       };
> >       struct {
> >               int *insn_state;
> > diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> > index 37d72b052192..cb4129b8b2a1 100644
> > --- a/kernel/bpf/log.c
> > +++ b/kernel/bpf/log.c
> > @@ -707,6 +707,8 @@ static void print_reg_state(struct bpf_verifier_env=
 *env,
> >               verbose(env, "%+d", reg->delta);
> >       if (reg->ref_obj_id)
> >               verbose_a("ref_obj_id=3D%d", reg->ref_obj_id);
> > +     if (reg->parent_id)
> > +             verbose_a("parent_id=3D%d", reg->parent_id);
> >       if (type_is_non_owning_ref(reg->type))
> >               verbose_a("%s", "non_own_ref");
> >       if (type_is_map_ptr(t)) {
> > @@ -810,8 +812,6 @@ void print_verifier_state(struct bpf_verifier_env *=
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
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 8f9e28901bc4..0436fc4d9107 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -204,7 +204,7 @@ struct bpf_verifier_stack_elem {
> >
> >  static int acquire_reference(struct bpf_verifier_env *env, int insn_id=
x);
> >  static int release_reference_nomark(struct bpf_verifier_state *state, =
int ref_obj_id);
> > -static int release_reference(struct bpf_verifier_env *env, int ref_obj=
_id);
> > +static int release_reference(struct bpf_verifier_env *env, int id);
> >  static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
> >  static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
> >  static int ref_set_non_owning(struct bpf_verifier_env *env,
> > @@ -281,6 +281,7 @@ struct bpf_dynptr_desc {
> >       enum bpf_dynptr_type type;
> >       u32 id;
> >       u32 ref_obj_id;
> > +     u32 parent_id;
> >  };
> >
> >  struct bpf_call_arg_meta {
> > @@ -294,6 +295,7 @@ struct bpf_call_arg_meta {
> >       int mem_size;
> >       u64 msize_max_value;
> >       int ref_obj_id;
> > +     u32 id;
> >       int func_id;
> >       struct btf *btf;
> >       u32 btf_id;
> > @@ -321,6 +323,7 @@ struct bpf_kfunc_call_arg_meta {
> >       const char *func_name;
> >       /* Out parameters */
> >       u32 ref_obj_id;
> > +     u32 id;
> >       u8 release_regno;
> >       bool r0_rdonly;
> >       u32 ret_btf_id;
> > @@ -721,14 +724,14 @@ static enum bpf_type_flag get_dynptr_type_flag(en=
um bpf_dynptr_type type)
> >       }
> >  }
> >
> > -static bool dynptr_type_refcounted(enum bpf_dynptr_type type)
> > +static bool dynptr_type_referenced(enum bpf_dynptr_type type)
> >  {
> >       return type =3D=3D BPF_DYNPTR_TYPE_RINGBUF || type =3D=3D BPF_DYN=
PTR_TYPE_FILE;
> >  }
> >
> >  static void __mark_dynptr_reg(struct bpf_reg_state *reg,
> >                             enum bpf_dynptr_type type,
> > -                           bool first_slot, int dynptr_id);
> > +                           bool first_slot, int id);
> >
> >  static void __mark_reg_not_init(const struct bpf_verifier_env *env,
> >                               struct bpf_reg_state *reg);
> > @@ -755,11 +758,12 @@ static int destroy_if_dynptr_stack_slot(struct bp=
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
> > +                                struct bpf_dynptr_desc *initialized_dy=
nptr)
> >  {
> >       struct bpf_func_state *state =3D func(env, reg);
> > +     int spi, i, err, ref_obj_id =3D 0;
> >       enum bpf_dynptr_type type;
> > -     int spi, i, err;
> >
> >       spi =3D dynptr_get_spi(env, reg);
> >       if (spi < 0)
> > @@ -793,22 +797,28 @@ static int mark_stack_slots_dynptr(struct bpf_ver=
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
> > +     if (initialized_dynptr->type =3D=3D BPF_DYNPTR_TYPE_INVALID) {
> > +             if (dynptr_type_referenced(type)) {
> > +                     ref_obj_id =3D acquire_reference(env, insn_idx);
> > +                     if (ref_obj_id < 0)
> > +                             return ref_obj_id;
> > +             }
> > +     } else {
> > +             /*
> > +              * Referenced dynptr clones have the same lifetime as the=
 original dynptr
> > +              * since bpf_dynptr_clone() does not initialize the clone=
s like the
> > +              * constructor does. If any of the dynptrs is invalidated=
, the rest will
> > +              * also need to invalidated. Thus, they all share the sam=
e non-zero ref_obj_id.
> > +              */
> > +             ref_obj_id =3D initialized_dynptr->ref_obj_id;
> > +             parent_id =3D initialized_dynptr->parent_id;
> >       }
> >
> > +     state->stack[spi].spilled_ptr.ref_obj_id =3D ref_obj_id;
> > +     state->stack[spi - 1].spilled_ptr.ref_obj_id =3D ref_obj_id;
> > +     state->stack[spi].spilled_ptr.parent_id =3D parent_id;
> > +     state->stack[spi - 1].spilled_ptr.parent_id =3D parent_id;
> > +
> >       bpf_mark_stack_write(env, state->frameno, BIT(spi - 1) | BIT(spi)=
);
> >
> >       return 0;
> > @@ -832,7 +842,7 @@ static void invalidate_dynptr(struct bpf_verifier_e=
nv *env, struct bpf_func_stat
> >  static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, str=
uct bpf_reg_state *reg)
> >  {
> >       struct bpf_func_state *state =3D func(env, reg);
> > -     int spi, ref_obj_id, i;
> > +     int spi;
> >
> >       /*
> >        * This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR =
cannot
> > @@ -843,45 +853,19 @@ static int unmark_stack_slots_dynptr(struct bpf_v=
erifier_env *env, struct bpf_re
> >               verifier_bug(env, "CONST_PTR_TO_DYNPTR cannot be released=
");
> >               return -EFAULT;
> >       }
> > +
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
> >  }
> >
> >  static void __mark_reg_unknown(const struct bpf_verifier_env *env,
> > @@ -898,10 +882,6 @@ static void mark_reg_invalid(const struct bpf_veri=
fier_env *env, struct bpf_reg_
> >  static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
> >                                       struct bpf_func_state *state, int=
 spi)
> >  {
> > -     struct bpf_func_state *fstate;
> > -     struct bpf_reg_state *dreg;
> > -     int i, dynptr_id;
> > -
> >       /* We always ensure that STACK_DYNPTR is never set partially,
> >        * hence just checking for slot_type[0] is enough. This is
> >        * different for STACK_SPILL, where it may be only set for
> > @@ -914,7 +894,7 @@ static int destroy_if_dynptr_stack_slot(struct bpf_=
verifier_env *env,
> >       if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
> >               spi =3D spi + 1;
> >
> > -     if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.t=
ype)) {
> > +     if (dynptr_type_referenced(state->stack[spi].spilled_ptr.dynptr.t=
ype)) {
> >               verbose(env, "cannot overwrite referenced dynptr\n");
> >               return -EINVAL;
> >       }
> > @@ -922,31 +902,8 @@ static int destroy_if_dynptr_stack_slot(struct bpf=
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
> > -     __mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
> > -     __mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
> > -
> > -     bpf_mark_stack_write(env, state->frameno, BIT(spi - 1) | BIT(spi)=
);
> > -
> > -     return 0;
> > +     /* Invalidate the dynptr and any derived slices */
> > +     return release_reference(env, state->stack[spi].spilled_ptr.id);
> >  }
> >
> >  static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, s=
truct bpf_reg_state *reg)
> > @@ -1583,15 +1540,15 @@ static void release_reference_state(struct bpf_=
verifier_state *state, int idx)
> >       return;
> >  }
> >
> > -static bool find_reference_state(struct bpf_verifier_state *state, int=
 ptr_id)
> > +static struct bpf_reference_state *find_reference_state(struct bpf_ver=
ifier_state *state, int ptr_id)
> >  {
> >       int i;
> >
> >       for (i =3D 0; i < state->acquired_refs; i++)
> >               if (state->refs[i].id =3D=3D ptr_id)
> > -                     return true;
> > +                     return &state->refs[i];
> >
> > -     return false;
> > +     return NULL;
> >  }
> >
> >  static int release_lock_state(struct bpf_verifier_state *state, int ty=
pe, int id, void *ptr)
> > @@ -2186,6 +2143,7 @@ static void __mark_reg_known(struct bpf_reg_state=
 *reg, u64 imm)
> >              offsetof(struct bpf_reg_state, var_off) - sizeof(reg->type=
));
> >       reg->id =3D 0;
> >       reg->ref_obj_id =3D 0;
> > +     reg->parent_id =3D 0;
> >       ___mark_reg_known(reg, imm);
> >  }
> >
> > @@ -2230,7 +2188,7 @@ static void mark_reg_known_zero(struct bpf_verifi=
er_env *env,
> >  }
> >
> >  static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynp=
tr_type type,
> > -                           bool first_slot, int dynptr_id)
> > +                           bool first_slot, int id)
> >  {
> >       /* reg->type has no meaning for STACK_DYNPTR, but when we set reg=
 for
> >        * callback arguments, it does need to be CONST_PTR_TO_DYNPTR, so=
 simply
> > @@ -2239,7 +2197,7 @@ static void __mark_dynptr_reg(struct bpf_reg_stat=
e *reg, enum bpf_dynptr_type ty
> >       __mark_reg_known_zero(reg);
> >       reg->type =3D CONST_PTR_TO_DYNPTR;
> >       /* Give each dynptr a unique id to uniquely associate slices to i=
t. */
> > -     reg->id =3D dynptr_id;
> > +     reg->id =3D id;
> >       reg->dynptr.type =3D type;
> >       reg->dynptr.first_slot =3D first_slot;
> >  }
> > @@ -2801,6 +2759,7 @@ static void __mark_reg_unknown_imprecise(struct b=
pf_reg_state *reg)
> >       reg->type =3D SCALAR_VALUE;
> >       reg->id =3D 0;
> >       reg->ref_obj_id =3D 0;
> > +     reg->parent_id =3D 0;
> >       reg->var_off =3D tnum_unknown;
> >       reg->frameno =3D 0;
> >       reg->precise =3D false;
> > @@ -8746,7 +8705,7 @@ static int process_kptr_func(struct bpf_verifier_=
env *env, int regno,
> >   * type, and declare it as 'const struct bpf_dynptr *' in their protot=
ype.
> >   */
> >  static int process_dynptr_func(struct bpf_verifier_env *env, int regno=
, int insn_idx,
> > -                            enum bpf_arg_type arg_type, int clone_ref_=
obj_id,
> > +                            enum bpf_arg_type arg_type, int parent_id,
> >                              struct bpf_dynptr_desc *initialized_dynptr=
)
> >  {
> >       struct bpf_reg_state *reg =3D reg_state(env, regno);
> > @@ -8798,7 +8757,8 @@ static int process_dynptr_func(struct bpf_verifie=
r_env *env, int regno, int insn
> >                               return err;
> >               }
> >
> > -             err =3D mark_stack_slots_dynptr(env, reg, arg_type, insn_=
idx, clone_ref_obj_id);
> > +             err =3D mark_stack_slots_dynptr(env, reg, arg_type, insn_=
idx, parent_id,
> > +                                           initialized_dynptr);
> >       } else /* MEM_RDONLY and None case from above */ {
> >               /* For the reg->type =3D=3D PTR_TO_STACK case, bpf_dynptr=
 is never const */
> >               if (reg->type =3D=3D CONST_PTR_TO_DYNPTR && !(arg_type & =
MEM_RDONLY)) {
> > @@ -8835,6 +8795,7 @@ static int process_dynptr_func(struct bpf_verifie=
r_env *env, int regno, int insn
> >                       initialized_dynptr->id =3D reg->id;
> >                       initialized_dynptr->type =3D reg->dynptr.type;
> >                       initialized_dynptr->ref_obj_id =3D reg->ref_obj_i=
d;
> > +                     initialized_dynptr->parent_id =3D reg->parent_id;
> >               }
> >       }
> >       return err;
> > @@ -9787,7 +9748,7 @@ static int check_func_arg(struct bpf_verifier_env=
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
> > @@ -9815,6 +9776,7 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
> >                       return -EACCES;
> >               }
> >               meta->ref_obj_id =3D reg->ref_obj_id;
> > +             meta->id =3D reg->id;
> >       }
> >
> >       switch (base_type(arg_type)) {
> > @@ -10438,26 +10400,82 @@ static int release_reference_nomark(struct bp=
f_verifier_state *state, int ref_ob
> >       return -EINVAL;
> >  }
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
> > +static void idstack_reset(struct bpf_idstack *idstack)
> > +{
> > +     idstack->cnt =3D 0;
> > +}
> > +
> I agree with Andrii, maybe new bpf_idstack is not really worth adding,
> Since the total number of reg_states is bounded, the idstack could be
> replaced with a simpler approach using bpf_idset: store
> discovered IDs in a flat array and keep a cursor to the first
> unprocessed entry. IDs before the cursor are already visited, IDs at
> and after it are pending. "Popping" becomes just advancing the cursor,
> and deduplication comes naturally by searching the full array (both
> visited and pending) before inserting a new ID.
>
> This avoids the possibility of pushing the same child ID multiple times.

Agree. I will use id_set for this purpose and not introduce id_stack.
Thanks for the suggestion.

> > +static void idstack_push(struct bpf_idstack *idstack, u32 id)
> > +{
> > +     if (WARN_ON_ONCE(idstack->cnt >=3D BPF_ID_MAP_SIZE))
> > +             return;
> > +
> > +     idstack->ids[idstack->cnt++] =3D id;
> > +}
> > +
> > +static u32 idstack_pop(struct bpf_idstack *idstack)
> > +{
> > +     return idstack->cnt > 0 ? idstack->ids[--idstack->cnt] : 0;
> > +}
> > +
> > +static int release_reg_check(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg,
> > +                          int id, int root_id, struct bpf_idstack *ids=
tack)
> >  {
> > +     struct bpf_reference_state *ref_state;
> > +
> > +     if (reg->id =3D=3D id || reg->parent_id =3D=3D id || reg->ref_obj=
_id =3D=3D id) {
> > +             /* Cannot indirectly release a referenced id */
> > +             if (reg->ref_obj_id && id !=3D root_id) {
> > +                     ref_state =3D find_reference_state(env->cur_state=
, reg->ref_obj_id);
> > +                     verbose(env, "Unreleased reference id=3D%d alloc_=
insn=3D%d when releasing id=3D%d\n",
> > +                             ref_state->id, ref_state->insn_idx, root_=
id);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             if (reg->id && reg->id !=3D id)
> > +                     idstack_push(idstack, reg->id);
> > +             return 1;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int release_reference(struct bpf_verifier_env *env, int id)
> > +{
> > +     struct bpf_idstack *idstack =3D &env->idstack_scratch;
> >       struct bpf_verifier_state *vstate =3D env->cur_state;
> > +     int spi, fi, root_id =3D id, err =3D 0;
> >       struct bpf_func_state *state;
> >       struct bpf_reg_state *reg;
> > -     int err;
> >
> > -     err =3D release_reference_nomark(vstate, ref_obj_id);
> > -     if (err)
> > -             return err;
> > +     idstack_reset(idstack);
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
> > +             bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> > +                     err =3D release_reg_check(env, reg, id, root_id, =
idstack);
> > +                     if (err < 0)
> > +                             return err;
> > +                     if (err =3D=3D 1)
> > +                             mark_reg_invalid(env, reg);
> > +             }));
> > +
> > +             for (fi =3D 0; fi <=3D vstate->curframe; fi++) {
> > +                     state =3D vstate->frame[fi];
> > +                     bpf_for_each_spilled_reg(spi, state, reg, (1 << S=
TACK_DYNPTR)) {
> > +                             if (!reg || !reg->dynptr.first_slot)
> > +                                     continue;
> > +                             err =3D release_reg_check(env, reg, id, r=
oot_id, idstack);
> > +                             if (err < 0)
> > +                                     return err;
> > +                             if (err =3D=3D 1)
> > +                                     invalidate_dynptr(env, state, spi=
);
> > +                     }
> > +             }
> > +     }
> >
> >       return 0;
> >  }
> > @@ -11643,11 +11661,8 @@ static int check_helper_call(struct bpf_verifi=
er_env *env, struct bpf_insn *insn
> >                        */
> >                       err =3D 0;
> >               }
> > -             if (err) {
> > -                     verbose(env, "func %s#%d reference has not been a=
cquired before\n",
> > -                             func_id_name(func_id), func_id);
> > +             if (err)
> >                       return err;
> > -             }
> >       }
> >
> >       switch (func_id) {
> > @@ -11925,10 +11940,8 @@ static int check_helper_call(struct bpf_verifi=
er_env *env, struct bpf_insn *insn
> >               regs[BPF_REG_0].ref_obj_id =3D id;
> >       }
> >
> > -     if (func_id =3D=3D BPF_FUNC_dynptr_data) {
> > -             regs[BPF_REG_0].dynptr_id =3D meta.initialized_dynptr.id;
> > -             regs[BPF_REG_0].ref_obj_id =3D meta.initialized_dynptr.re=
f_obj_id;
> > -     }
> > +     if (func_id =3D=3D BPF_FUNC_dynptr_data)
> > +             regs[BPF_REG_0].parent_id =3D meta.initialized_dynptr.id;
> >
> >       err =3D do_refine_retval_range(env, regs, fn->ret_type, func_id, =
&meta);
> >       if (err)
> > @@ -13295,6 +13308,7 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
> >                               return -EFAULT;
> >                       }
> >                       meta->ref_obj_id =3D reg->ref_obj_id;
> > +                     meta->id =3D reg->id;
> >                       if (is_kfunc_release(meta))
> >                               meta->release_regno =3D regno;
> >               }
> > @@ -13429,7 +13443,6 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
> >               case KF_ARG_PTR_TO_DYNPTR:
> >               {
> >                       enum bpf_arg_type dynptr_arg_type =3D ARG_PTR_TO_=
DYNPTR;
> > -                     int clone_ref_obj_id =3D 0;
> >
> >                       if (is_kfunc_arg_const_ptr(btf, &args[i]))
> >                               dynptr_arg_type |=3D MEM_RDONLY;
> > @@ -13458,14 +13471,10 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_kfunc_call_
> >                               }
> >
> >                               dynptr_arg_type |=3D (unsigned int)get_dy=
nptr_type_flag(parent_type);
> > -                             clone_ref_obj_id =3D meta->initialized_dy=
nptr.ref_obj_id;
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
> > +                     ret =3D process_dynptr_func(env, regno, insn_idx,=
 dynptr_arg_type,
> > +                                               meta->ref_obj_id ? meta=
->id : 0,
> >                                                 &meta->initialized_dynp=
tr);
> >                       if (ret < 0)
> >                               return ret;
> > @@ -13913,12 +13922,7 @@ static int check_special_kfunc(struct bpf_veri=
fier_env *env, struct bpf_kfunc_ca
> >                       verifier_bug(env, "no dynptr id");
> >                       return -EFAULT;
> >               }
> > -             regs[BPF_REG_0].dynptr_id =3D meta->initialized_dynptr.id=
;
> > -
> > -             /* we don't need to set BPF_REG_0's ref obj id
> > -              * because packet slices are not refcounted (see
> > -              * dynptr_type_refcounted)
> > -              */
> > +             regs[BPF_REG_0].parent_id =3D meta->initialized_dynptr.id=
;
> >       } else {
> >               return 0;
> >       }
> > @@ -14113,9 +14117,6 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
> >                       err =3D unmark_stack_slots_dynptr(env, reg);
> >               } else {
> >                       err =3D release_reference(env, reg->ref_obj_id);
> > -                     if (err)
> > -                             verbose(env, "kfunc %s#%d reference has n=
ot been acquired before\n",
> > -                                     func_name, meta.func_id);
> >               }
> >               if (err)
> >                       return err;
> > @@ -14134,7 +14135,7 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
> >                       return err;
> >               }
> >
> > -             err =3D release_reference(env, release_ref_obj_id);
> > +             err =3D release_reference_nomark(env->cur_state, release_=
ref_obj_id);
> >               if (err) {
> >                       verbose(env, "kfunc %s#%d reference has not been =
acquired before\n",
> >                               func_name, meta.func_id);
> > @@ -14225,7 +14226,7 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
> >
> >                       /* Ensures we don't access the memory after a rel=
ease_reference() */
> >                       if (meta.ref_obj_id)
> > -                             regs[BPF_REG_0].ref_obj_id =3D meta.ref_o=
bj_id;
> > +                             regs[BPF_REG_0].parent_id =3D meta.ref_ob=
j_id;
> >
> >                       if (is_kfunc_rcu_protected(&meta))
> >                               regs[BPF_REG_0].type |=3D MEM_RCU;
> > @@ -19575,7 +19576,8 @@ static bool regs_exact(const struct bpf_reg_sta=
te *rold,
> >  {
> >       return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) =3D=
=3D 0 &&
> >              check_ids(rold->id, rcur->id, idmap) &&
> > -            check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
> > +            check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap) &&
> > +            check_ids(rold->parent_id, rcur->parent_id, idmap);
> >  }
> >
> >  enum exact_level {
> > @@ -19697,7 +19699,8 @@ static bool regsafe(struct bpf_verifier_env *en=
v, struct bpf_reg_state *rold,
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
> > @@ -19852,7 +19855,8 @@ static bool stacksafe(struct bpf_verifier_env *=
env, struct bpf_func_state *old,
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
> > --
> > 2.47.3

