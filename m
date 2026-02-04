Return-Path: <netdev+bounces-256885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7ZZjEiTdg2lfvAMAu9opvQ
	(envelope-from <netdev+bounces-256885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 00:58:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A032EED5D0
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 00:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D47A03010141
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 23:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D15A3A0B28;
	Wed,  4 Feb 2026 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYl1blrw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A7539E6FB
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 23:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770249503; cv=pass; b=EodbEG0E0FZkFaR/QpZnC5YixaoknEAFtZ+4kYIHN0lPDbInhvk1oDqU95XpaHcOP3Qfj/Oxk02lXOO9ZC0pI09fcvPkzLndtSqJLPdTQ8A/RPb1WGLrl5Qboc4tByg518KmMsrRbRGbSiE+RE28C4tYR3fGsUTtDTg3wU5fXbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770249503; c=relaxed/simple;
	bh=2i4Lp3iEvj/iNMLkUgxtRL+i++4Ti2/hD8gCoRObVtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SaBk6X+MxbXpzGmg8ZYzSbvoYxryz5w6MJJIH5tlW/nVfmQx5y2JXpR8w/DQhx13lQUF85MCjdVtEYO4ia8+yIXvlIhOitHfhhII49kBB4s6yiJtmcRF8OBs7pCXohRupP2KGHl65AMkPqMlR7bVA916kmqaUFNVour7DGTLMuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYl1blrw; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-649655f14daso518436d50.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 15:58:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770249502; cv=none;
        d=google.com; s=arc-20240605;
        b=YMzdqQbMDEHRRUOlTJZsXPKGKHUamuXnz4MMSFYym6XdnR6ac7iQ0566NzsgjKB19k
         7yacAeEKhoPkfcECKnqCe0v6GEQzn84US1TgC19MWPSw7Ru80JKGojuyItYgTYgAcDMo
         cTJBzlyWTvMWJo1wsv3lhfajr/sRoYgQGg8ptnJBjdlhqd6hfgxxg4b0FHuLShzxmJmM
         mbMPe8gMKtVmDPzvdpyQdWlhItUmHdCOeaOoIe/IuwysYZXvGNoKK//q2VTqHkPNnEmM
         bIiojMLef9klBjRI6fY+zHWVMN3nK1Px2RuHzPluZG/Hxd75fNVMkD8KskMEAPteQLZO
         jfAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OzxOE42qWwrX8bbdMfqRXnUV4B0p7n38ddvRTtXVOPs=;
        fh=PkwwKveNY9Yf7vXR7px3JzbEhcjG9I23upjkxpKkvLU=;
        b=k+PjOrYE+BnMroZilZC96YgAgEwBH2e1FRnQ6G184zv1sfeeOE57zMlPAT/JAYQzO2
         NIV6dz0Oig+UI0eY5STkfg/a/aup3RFMGhM7BsPbUvDXZPPH+Kd1VSLGwSdAmqlIjD8E
         i18ShyIzRv2aKV9zrH21hrOAT6UtwBbG61p1wx+QS5IQh1Vsz+UwIBRWqAVxyb2tTex+
         5kKx47kCxEKTZswJJteGIHCGjMjuVGGO0C6YtLjSEa6xN81/AcdOmOxW9TDNZTxJngOJ
         k1OrbQ/WW/j+Fm5V9N/WLv2XJ4EgY5dc+Mp7CCb5WJyddqlpznMIRU+vjSwWnTm14KuR
         ZRsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770249502; x=1770854302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzxOE42qWwrX8bbdMfqRXnUV4B0p7n38ddvRTtXVOPs=;
        b=gYl1blrwkh0xLfpRkrLQez9v4Soq1kUcX4c3835u5b6GifUayE8ieVPE9HKfYrx+AO
         2+vqwiNjw3nQ4+G3VHY63nz5tdteSkGx4UFxof5yzUI2pbLI1iOdvT2Z7Xo7rM0qvBG8
         5nKt/B6kZKacNf+psFOOUH+VlNxCWorJuCumsACZH0rSv+We84+dkeHFofmkEV7kxzKc
         dKJK+o30jqdwHnFCkNdD34s8NaY8iBjdeT7sOe+nUXNBZ8RZ9P49Bp1ddyzRWxPi7eMd
         6lRLB1rVU1LJUBe+jXnzmvSWqy4gDemQc96siWObl6wKqzACIQvDfyb6Ryt9XrR4+Bxv
         ewsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770249502; x=1770854302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OzxOE42qWwrX8bbdMfqRXnUV4B0p7n38ddvRTtXVOPs=;
        b=Llq6rjn+g2QHlInjgokrUEm8UibpB1UtrLNHHGJii77v4iK0pdn9bZIoc6IMIcZ9Jq
         IKsb7iqfY5OnGhbmhqyGqsrgd5qw1LEukWE1XS4rije5LiUkR2ydG3t4suuBbM/cWBtq
         l326GpDaVyzTH+th1jXoML8dE9oiskyWpnKN46PGg++pmxnj9uQy92dVres3hdJhuaHj
         bhtccIyQVh7O9JTWPYLfr9EWLFlW8hHjmvTPcOaHQ70oLvMv1+QKpuzXfzs7aRY4/lIr
         a4DEQFPSmlLz1NugRxYd9RsL3cXtO0+IiR8PdOEo5tRHvU5J12xOIv12S72XHfvKmnXI
         xkJg==
X-Gm-Message-State: AOJu0Yweqm8qQ0pdW9hVQ858EclSTC6LtaNfm1badXs7SQa/XnoPDnUL
	B3hfzPJIIOgQS0kunkex0UEOy308ZXC8g4Lx90hl7fBcBzkboYQ2LrWPo1GupPBq10ttc1NLJgf
	EiV4TBMD2wXCOdtC+C5Y1Fn2EyVmF7PY=
X-Gm-Gg: AZuq6aIn1pPRBl5zU5hDU8RTiFFIA96P6lXfo+BRTAHUjmmXd9shU6x43tJlJOvhQ5n
	Tlq4JT5JSNPdSfKVAjJ+CMuC4fVGixdRVMR8/w0Fjq+Ibzq+vZsHlA3wz3Bkm2gX+MuBf7Ph4VT
	5mVzmXITip2JcuPFakqoL++qpl3/qzP8y2DceLKPsx5EGQiDueS2p25C+j2udzV7G6mqIgNCUUS
	xfRC8Vugf5B6g3ElVjb90X7z9nKnlBBvpVQAoF2iEO1YPJWj+UbG2ALA30J/UF9JWzcOdvwW6XH
	/f9PUUwWLS1nO7oxwv2omw==
X-Received: by 2002:a53:e1e9:0:b0:649:da8e:e905 with SMTP id
 956f58d0204a3-649db4945e5mr3550381d50.58.1770249501445; Wed, 04 Feb 2026
 15:58:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202214817.2853236-1-ameryhung@gmail.com>
In-Reply-To: <20260202214817.2853236-1-ameryhung@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 4 Feb 2026 15:58:10 -0800
X-Gm-Features: AZwV_QiACJmWf5vysX2IUcqDxBtsvxovFB1o2fpa-84VoTi12Q3UIkUHUvbGQK0
Message-ID: <CAMB2axOeNjwHrsZGimLK2tMn7GrQJ2peh9m=9LtEczETxv9tug@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 1/4] bpf: Fix and refactor object
 relationship tracking
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-256885-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A032EED5D0
X-Rspamd-Action: no action

Brief note of an offline discussion with Andrii:

On Mon, Feb 2, 2026 at 1:48=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> This patch (1) fixes the missing link between dynptr and the parent
> referenced object and (2) simplifies the object relationship tracking
> to allow building more complex object relationship in the future.
>
> This patch makes dynptr tracks its parent object. After bpf qdisc is
> introduced, it is now possible for an skb to be freed in a qdisc program.
> However, since there is no link between the skb dynptr and the skb, the
> dynptr will not be invalidated after the skb is freed, resulting in
> use after free.
>
> In addition, also take the chance to refactor object relationship
> tracking. Currently ref_obj_id of an object will share the same
> ref_obj_id of the object it is referencing. For dynptr slice, a separate
> dynptr_id is used to track its parent.
>
> This design works for now, but after adding link between skb and dynptr,
> it becomes problematic. It cannot correctly handle the removal of some
> nodes in the object relationship tree. For example, if dynptr a is
> destroyed by overwriting the stack slot, release_reference(1) would be
> called and all nodes will be removed. The correct handling should leave
> skb, dynptr c, and slice d intact. This is not a problem before since
> dynptr created from skb has ref_obj_id =3D 0.
>
> In the future if we start allowing creating dynptr from slice, the curren=
t
> design also cannot correctly handle the removal of dynptr e. Again, all
> nodes will be removed instead of childrens of dynptr e.
>
> Before: object (id,ref_obj_id,dynptr_id)
>
>                       skb (1,1,0)
>                              ^ (Link added in this patch)
>                              +-------------------------------+
>                              |           bpf_dynptr_clone    |
>                  dynptr a (2,1,0)                dynptr c (4,1,0)
>                            ^                               ^
>         bpf_dynptr_slice   |                               |
>                            |                               |
>               slice b (3,1,2)                 slice d (5,1,4)
>                          ^
>     bpf_dynptr_from_mem  |
>     (NOT allowed yet)    |
>              dynptr e (6,1,0)
>
> The new design removes dynptr_id and use ref_obj_id to track the id
> of the parent object instead of sharing the ref_obj_id of the root.
> For release_reference(), this means ref_obj_id argument now can aslo
> contains id not acquired through acquire_reference(). Add an argument
> "acquired_ref" to indicate this. If true, there is no need to call
> release_reference_nomark(). In addition, when iterating the register
> state, when a reg->ref_obj_id matches the to be released ref_obj_id,
> other objects referencing reg->id also needs to be released. Finally,
> since dynptrs reside on the stack, release_reference() will also need
> to scan stack slots.
>
> After: object (id,ref_obj_id)
>
> Qdisc:
>                         skb (1,1)
>                              ^
>         bpf_dynptr_from_skb  +-------------------------------+
>                              |           bpf_dynptr_clone    |
>                  dynptr a (2,1)                  dynptr c (4,1)
>                            ^                               ^
>         bpf_dynptr_slice   |                               |
>                            |                               |
>                 slice b (3,2)                   slice d (5,4)
>                          ^
>     bpf_dynptr_from_mem  |
>     (NOT allowed yet)    |
>              dynptr e (6,3)
>
> Referenced dynptr:
>
>      bpf_dynptr_from_file  +---------------------------------+
>                            |           bpf_dynptr_clone      |
>                  dynptr a (1,1)                  dynptr c (2,1)

File dynptr should also have ref_obj_id point to the file's id

>
> Other non-referenced dynptr
>
>       bpf_dynptr_from_skb  +---------------------------------+
>                            |           bpf_dynptr_clone      |
>                  dynptr a (1,0)                  dynptr c (2,1)

This should be dynptr c (2,0)

>
> While this change introduces a potential circular call chain of
> release_reference() -> __unmark_stack_slots_dynptr(), we currently do
> not allow creating dynptr from slice so the depth of the tree will be
> capped at three. In the future when this is allowed, the recursion
> depth will still be bounded as the number of slices is limited by the
> number registers. Besides, mark_ptr_or_null_reg() also needs to preserve
> reg->id of slices.

Use BFS to avoid the potential unsafe recursive calls.

>
> Note that the new design does not support intermediate nodes to acquire
> reference. If this is needed in the future, we might need to separate
> ref_obj_id into ref_obj_id and parent_id to handle it.
>

For historical reasons, an ptr object can have an id for MAYBE_NULL
tracking and a different ref_obj_id for referenced object tracking.
However in the new scheme, while we might still keep the same name,
"id" really means the unique id of an object, which may or may not be
referenced (i.e., return of acquire_reference()); while ref_obj_id
saves the parent object's "id". Therefore, there should be no need for
(id, ref_obj_id, parent_id) mentioned in the last paragraph.

> CC: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
>
> ---
>
> This refactor is based on Kumar work in [0]
>
> [0] https://lore.kernel.org/bpf/20250414161443.1146103-2-memxor@gmail.com=
/
> ---
>  include/linux/bpf_verifier.h |   1 -
>  kernel/bpf/log.c             |   2 -
>  kernel/bpf/verifier.c        | 173 ++++++++++++++++-------------------
>  3 files changed, 81 insertions(+), 95 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 8355b585cd18..0cb14648a269 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -66,7 +66,6 @@ struct bpf_reg_state {
>
>                 struct { /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
>                         u32 mem_size;
> -                       u32 dynptr_id; /* for dynptr slices */
>                 };
>
>                 /* For dynptr stack slots */
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index a0c3b35de2ce..8851adfdb581 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -808,8 +808,6 @@ void print_verifier_state(struct bpf_verifier_env *en=
v, const struct bpf_verifie
>                                 verbose_a("id=3D%d", reg->id);
>                         if (reg->ref_obj_id)
>                                 verbose_a("ref_id=3D%d", reg->ref_obj_id)=
;
> -                       if (reg->dynptr_id)
> -                               verbose_a("dynptr_id=3D%d", reg->dynptr_i=
d);
>                         verbose(env, ")");
>                         break;
>                 case STACK_ITER:
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6b62b6d57175..a357e0305139 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -204,7 +204,7 @@ struct bpf_verifier_stack_elem {
>
>  static int acquire_reference(struct bpf_verifier_env *env, int insn_idx)=
;
>  static int release_reference_nomark(struct bpf_verifier_state *state, in=
t ref_obj_id);
> -static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d);
> +static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d, bool acquired_ref);
>  static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
>  static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
>  static int ref_set_non_owning(struct bpf_verifier_env *env,
> @@ -287,7 +287,7 @@ struct bpf_call_arg_meta {
>         int mem_size;
>         u64 msize_max_value;
>         int ref_obj_id;
> -       int dynptr_id;
> +       int id;
>         int func_id;
>         struct btf *btf;
>         u32 btf_id;
> @@ -733,7 +733,7 @@ static bool dynptr_type_refcounted(enum bpf_dynptr_ty=
pe type)
>
>  static void __mark_dynptr_reg(struct bpf_reg_state *reg,
>                               enum bpf_dynptr_type type,
> -                             bool first_slot, int dynptr_id);
> +                             bool first_slot, int id);
>
>  static void __mark_reg_not_init(const struct bpf_verifier_env *env,
>                                 struct bpf_reg_state *reg);
> @@ -764,7 +764,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifie=
r_env *env, struct bpf_reg_
>  {
>         struct bpf_func_state *state =3D func(env, reg);
>         enum bpf_dynptr_type type;
> -       int spi, i, err;
> +       int spi, i, err, id;
>
>         spi =3D dynptr_get_spi(env, reg);
>         if (spi < 0)
> @@ -798,22 +798,17 @@ static int mark_stack_slots_dynptr(struct bpf_verif=
ier_env *env, struct bpf_reg_
>         mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
>                                &state->stack[spi - 1].spilled_ptr, type);
>
> -       if (dynptr_type_refcounted(type)) {
> -               /* The id is used to track proper releasing */
> -               int id;
> -
> -               if (clone_ref_obj_id)
> -                       id =3D clone_ref_obj_id;
> -               else
> -                       id =3D acquire_reference(env, insn_idx);
> +       id =3D clone_ref_obj_id;
>
> +       if (dynptr_type_refcounted(type) && !clone_ref_obj_id) {
> +               id =3D acquire_reference(env, insn_idx);
>                 if (id < 0)
>                         return id;
> -
> -               state->stack[spi].spilled_ptr.ref_obj_id =3D id;
> -               state->stack[spi - 1].spilled_ptr.ref_obj_id =3D id;
>         }
>
> +       state->stack[spi].spilled_ptr.ref_obj_id =3D id;
> +       state->stack[spi - 1].spilled_ptr.ref_obj_id =3D id;
> +
>         bpf_mark_stack_write(env, state->frameno, BIT(spi - 1) | BIT(spi)=
);
>
>         return 0;
> @@ -834,10 +829,30 @@ static void invalidate_dynptr(struct bpf_verifier_e=
nv *env, struct bpf_func_stat
>         bpf_mark_stack_write(env, state->frameno, BIT(spi - 1) | BIT(spi)=
);
>  }
>
> +static void __unmark_stack_slots_dynptr(struct bpf_verifier_env *env, st=
ruct bpf_func_state *state,
> +                                       int spi)
> +{
> +       enum bpf_dynptr_type type;
> +       int id, ref_obj_id;
> +
> +       id =3D state->stack[spi].spilled_ptr.id;
> +       ref_obj_id =3D state->stack[spi].spilled_ptr.ref_obj_id;
> +       type =3D state->stack[spi].spilled_ptr.dynptr.type;
> +
> +       invalidate_dynptr(env, state, spi);
> +
> +       /* Release the reference acquired on the dynptr */
> +       if (dynptr_type_refcounted(type))
> +               WARN_ON_ONCE(release_reference(env, ref_obj_id, true));
> +
> +       /* Invalidate any slices associated with this dynptr */
> +       WARN_ON_ONCE(release_reference(env, id, false));
> +}
> +
>  static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struc=
t bpf_reg_state *reg)
>  {
>         struct bpf_func_state *state =3D func(env, reg);
> -       int spi, ref_obj_id, i;
> +       int spi;
>
>         /*
>          * This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR =
cannot
> @@ -848,44 +863,12 @@ static int unmark_stack_slots_dynptr(struct bpf_ver=
ifier_env *env, struct bpf_re
>                 verifier_bug(env, "CONST_PTR_TO_DYNPTR cannot be released=
");
>                 return -EFAULT;
>         }
> +
>         spi =3D dynptr_get_spi(env, reg);
>         if (spi < 0)
>                 return spi;
>
> -       if (!dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.=
type)) {
> -               invalidate_dynptr(env, state, spi);
> -               return 0;
> -       }
> -
> -       ref_obj_id =3D state->stack[spi].spilled_ptr.ref_obj_id;
> -
> -       /* If the dynptr has a ref_obj_id, then we need to invalidate
> -        * two things:
> -        *
> -        * 1) Any dynptrs with a matching ref_obj_id (clones)
> -        * 2) Any slices derived from this dynptr.
> -        */
> -
> -       /* Invalidate any slices associated with this dynptr */
> -       WARN_ON_ONCE(release_reference(env, ref_obj_id));
> -
> -       /* Invalidate any dynptr clones */
> -       for (i =3D 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {
> -               if (state->stack[i].spilled_ptr.ref_obj_id !=3D ref_obj_i=
d)
> -                       continue;
> -
> -               /* it should always be the case that if the ref obj id
> -                * matches then the stack slot also belongs to a
> -                * dynptr
> -                */
> -               if (state->stack[i].slot_type[0] !=3D STACK_DYNPTR) {
> -                       verifier_bug(env, "misconfigured ref_obj_id");
> -                       return -EFAULT;
> -               }
> -               if (state->stack[i].spilled_ptr.dynptr.first_slot)
> -                       invalidate_dynptr(env, state, i);
> -       }
> -
> +       __unmark_stack_slots_dynptr(env, state, spi);
>         return 0;
>  }
>
> @@ -905,7 +888,7 @@ static int destroy_if_dynptr_stack_slot(struct bpf_ve=
rifier_env *env,
>  {
>         struct bpf_func_state *fstate;
>         struct bpf_reg_state *dreg;
> -       int i, dynptr_id;
> +       int i, id;
>
>         /* We always ensure that STACK_DYNPTR is never set partially,
>          * hence just checking for slot_type[0] is enough. This is
> @@ -933,13 +916,13 @@ static int destroy_if_dynptr_stack_slot(struct bpf_=
verifier_env *env,
>                 state->stack[spi - 1].slot_type[i] =3D STACK_INVALID;
>         }
>
> -       dynptr_id =3D state->stack[spi].spilled_ptr.id;
> +       id =3D state->stack[spi].spilled_ptr.id;
>         /* Invalidate any slices associated with this dynptr */
>         bpf_for_each_reg_in_vstate(env->cur_state, fstate, dreg, ({
>                 /* Dynptr slices are only PTR_TO_MEM_OR_NULL and PTR_TO_M=
EM */
>                 if (dreg->type !=3D (PTR_TO_MEM | PTR_MAYBE_NULL) && dreg=
->type !=3D PTR_TO_MEM)
>                         continue;
> -               if (dreg->dynptr_id =3D=3D dynptr_id)
> +               if (dreg->ref_obj_id =3D=3D id)
>                         mark_reg_invalid(env, dreg);
>         }));
>
> @@ -1098,7 +1081,7 @@ static int unmark_stack_slots_iter(struct bpf_verif=
ier_env *env,
>                 struct bpf_reg_state *st =3D &slot->spilled_ptr;
>
>                 if (i =3D=3D 0)
> -                       WARN_ON_ONCE(release_reference(env, st->ref_obj_i=
d));
> +                       WARN_ON_ONCE(release_reference(env, st->ref_obj_i=
d, true));
>
>                 __mark_reg_not_init(env, st);
>
> @@ -2235,7 +2218,7 @@ static void mark_reg_known_zero(struct bpf_verifier=
_env *env,
>  }
>
>  static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr=
_type type,
> -                             bool first_slot, int dynptr_id)
> +                             bool first_slot, int id)
>  {
>         /* reg->type has no meaning for STACK_DYNPTR, but when we set reg=
 for
>          * callback arguments, it does need to be CONST_PTR_TO_DYNPTR, so=
 simply
> @@ -2244,7 +2227,7 @@ static void __mark_dynptr_reg(struct bpf_reg_state =
*reg, enum bpf_dynptr_type ty
>         __mark_reg_known_zero(reg);
>         reg->type =3D CONST_PTR_TO_DYNPTR;
>         /* Give each dynptr a unique id to uniquely associate slices to i=
t. */
> -       reg->id =3D dynptr_id;
> +       reg->id =3D id;
>         reg->dynptr.type =3D type;
>         reg->dynptr.first_slot =3D first_slot;
>  }
> @@ -10481,22 +10464,43 @@ static int release_reference_nomark(struct bpf_=
verifier_state *state, int ref_ob
>   *
>   * This is the release function corresponding to acquire_reference(). Id=
empotent.
>   */
> -static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d)
> +static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d, bool acquired_ref)
>  {
>         struct bpf_verifier_state *vstate =3D env->cur_state;
>         struct bpf_func_state *state;
>         struct bpf_reg_state *reg;
> -       int err;
> +       int err, spi;
>
> -       err =3D release_reference_nomark(vstate, ref_obj_id);
> -       if (err)
> -               return err;
> +       if (acquired_ref) {
> +               err =3D release_reference_nomark(vstate, ref_obj_id);
> +               if (err)
> +                       return err;
> +       }
>
>         bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> -               if (reg->ref_obj_id =3D=3D ref_obj_id)
> +               if (reg->ref_obj_id =3D=3D ref_obj_id) {
>                         mark_reg_invalid(env, reg);
> +                       if (reg->id && reg->id !=3D ref_obj_id) {
> +                               err =3D release_reference(env, reg->id, f=
alse);
> +                               if (err)
> +                                       return err;
> +                       }
> +               }
>         }));
>
> +       bpf_for_each_spilled_reg(spi, state, reg, (1 << STACK_DYNPTR)) {
> +               if (!reg || !reg->dynptr.first_slot)
> +                       continue;
> +               if (reg->ref_obj_id =3D=3D ref_obj_id) {
> +                       __unmark_stack_slots_dynptr(env, state, spi);
> +                       if (reg->id && reg->id !=3D ref_obj_id) {
> +                               err =3D release_reference(env, reg->id, f=
alse);
> +                               if (err)
> +                                       return err;
> +                       }
> +               }
> +       }
> +
>         return 0;
>  }
>
> @@ -11673,7 +11677,7 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>                                 }));
>                         }
>                 } else if (meta.ref_obj_id) {
> -                       err =3D release_reference(env, meta.ref_obj_id);
> +                       err =3D release_reference(env, meta.ref_obj_id, t=
rue);
>                 } else if (register_is_null(&regs[meta.release_regno])) {
>                         /* meta.ref_obj_id can only be 0 if register that=
 is meant to be
>                          * released is NULL, which must be > R0.
> @@ -11757,19 +11761,14 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
>         case BPF_FUNC_dynptr_data:
>         {
>                 struct bpf_reg_state *reg;
> -               int id, ref_obj_id;
> +               int id;
>
>                 reg =3D get_dynptr_arg_reg(env, fn, regs);
>                 if (!reg)
>                         return -EFAULT;
>
> -
> -               if (meta.dynptr_id) {
> -                       verifier_bug(env, "meta.dynptr_id already set");
> -                       return -EFAULT;
> -               }
> -               if (meta.ref_obj_id) {
> -                       verifier_bug(env, "meta.ref_obj_id already set");
> +               if (meta.id) {
> +                       verifier_bug(env, "meta.id already set");
>                         return -EFAULT;
>                 }
>
> @@ -11779,14 +11778,7 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>                         return id;
>                 }
>
> -               ref_obj_id =3D dynptr_ref_obj_id(env, reg);
> -               if (ref_obj_id < 0) {
> -                       verifier_bug(env, "failed to obtain dynptr ref_ob=
j_id");
> -                       return ref_obj_id;
> -               }
> -
> -               meta.dynptr_id =3D id;
> -               meta.ref_obj_id =3D ref_obj_id;
> +               meta.id =3D id;
>
>                 break;
>         }
> @@ -11990,10 +11982,9 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>                 return -EFAULT;
>         }
>
> -       if (is_dynptr_ref_function(func_id))
> -               regs[BPF_REG_0].dynptr_id =3D meta.dynptr_id;
> -
> -       if (is_ptr_cast_function(func_id) || is_dynptr_ref_function(func_=
id)) {
> +       if (is_dynptr_ref_function(func_id)) {
> +               regs[BPF_REG_0].ref_obj_id =3D meta.id;
> +       } else if (is_ptr_cast_function(func_id)) {
>                 /* For release_reference() */
>                 regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj_id;
>         } else if (is_acquire_function(func_id, meta.map.ptr)) {
> @@ -13328,7 +13319,9 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>                 }
>
>                 if (reg->ref_obj_id) {
> -                       if (is_kfunc_release(meta) && meta->ref_obj_id) {
> +                       if (meta->ref_obj_id &&
> +                           (is_kfunc_release(meta) ||
> +                            meta->func_id =3D=3D special_kfunc_list[KF_b=
pf_dynptr_from_skb])) {
>                                 verifier_bug(env, "more than one arg with=
 ref_obj_id R%d %u %u",
>                                              regno, reg->ref_obj_id,
>                                              meta->ref_obj_id);
> @@ -13478,6 +13471,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>
>                         if (meta->func_id =3D=3D special_kfunc_list[KF_bp=
f_dynptr_from_skb]) {
>                                 dynptr_arg_type |=3D DYNPTR_TYPE_SKB;
> +                               clone_ref_obj_id =3D meta->ref_obj_id;
>                         } else if (meta->func_id =3D=3D special_kfunc_lis=
t[KF_bpf_dynptr_from_xdp]) {
>                                 dynptr_arg_type |=3D DYNPTR_TYPE_XDP;
>                         } else if (meta->func_id =3D=3D special_kfunc_lis=
t[KF_bpf_dynptr_from_skb_meta]) {
> @@ -13955,12 +13949,7 @@ static int check_special_kfunc(struct bpf_verifi=
er_env *env, struct bpf_kfunc_ca
>                         verifier_bug(env, "no dynptr id");
>                         return -EFAULT;
>                 }
> -               regs[BPF_REG_0].dynptr_id =3D meta->initialized_dynptr.id=
;
> -
> -               /* we don't need to set BPF_REG_0's ref obj id
> -                * because packet slices are not refcounted (see
> -                * dynptr_type_refcounted)
> -                */
> +               regs[BPF_REG_0].ref_obj_id =3D meta->initialized_dynptr.i=
d;
>         } else {
>                 return 0;
>         }
> @@ -14154,7 +14143,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>                 if (meta.initialized_dynptr.ref_obj_id) {
>                         err =3D unmark_stack_slots_dynptr(env, reg);
>                 } else {
> -                       err =3D release_reference(env, reg->ref_obj_id);
> +                       err =3D release_reference(env, reg->ref_obj_id, t=
rue);
>                         if (err)
>                                 verbose(env, "kfunc %s#%d reference has n=
ot been acquired before\n",
>                                         func_name, meta.func_id);
> @@ -14176,7 +14165,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>                         return err;
>                 }
>
> -               err =3D release_reference(env, release_ref_obj_id);
> +               err =3D release_reference(env, release_ref_obj_id, true);
>                 if (err) {
>                         verbose(env, "kfunc %s#%d reference has not been =
acquired before\n",
>                                 func_name, meta.func_id);
> --
> 2.47.3
>

