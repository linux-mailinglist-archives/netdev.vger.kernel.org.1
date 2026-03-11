Return-Path: <netdev+bounces-266725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J2CICumsWn4EAAAu9opvQ
	(envelope-from <netdev+bounces-266725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 18:28:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C56268060
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 18:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 525843003EE3
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1938318EE1;
	Wed, 11 Mar 2026 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdFcC59W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C8E30EF8F
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773249842; cv=pass; b=tUqMdzHP544gdkt3Aw7Nr5lb2zO3ilXp6r1PRCPmufW7PC/vU1drexXfhgJsVwaH9Iq2wVWt44Vk4O4nQLdt8StnaskbypkHiE+UNORKIzEZmAFwVM7hlNzpF0AsZLt5xcS77afhbni+OQtoY4ZIe0Dl3YFuH9wd71M6lC4DJ14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773249842; c=relaxed/simple;
	bh=XrHXjlptHkjlZOxUlvkXZTubb9BWdYNy53Fpgx0LNIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZSd8wLLa2ng50LBI2MKgnY0gAhkXTcK0rYnqrpN7AvFU9Z+G+xrR4crqW95fvO7NBBTVqyRUdW57zfG/t1NidFj2ousw5WUlvYh//p4nmVvQEocwZz9LyMGeQrvWLFUKtnJ+QDgW7EMlhQhyDkJiENXu7Z61jEeuuIZdGIPkFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdFcC59W; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79868cde1eeso885887b3.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 10:24:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773249840; cv=none;
        d=google.com; s=arc-20240605;
        b=cH6Zcdqhjq11TAO+fGjhc/9vpdB//17g0JovhjVLgqCi/xSCZ1ZiNQDzj6t9U7mwG+
         0gTIDlGiWl+Ua/sv38zv1t3sJpzFtfXiHM0GNBfkzKwP3ixyd+4s0zZCpIz5qe+WNk/P
         9Yxk+ODXgaTkyKMDEzsnu0lx0Ohbc+LbTm0zbGKb3idd3SzodtsVyQWhvVup8zmXjuXh
         MsvopEVfCUM2PBHXcvPBWQ/egTQQ465LxA8YGnPBNaBLtu6ylB2h05Jl1DgvYNgwUF8a
         ovr4/szdg6WZJxxgJRV8sWyflohlIz1Kn8pHxAAq7caalYbVm2Yk12+mydJZaiF6SDEW
         V+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MfiA7UUuKbDnIQiMEl+5EvA5pBbt4xaYzihYVrz2S9M=;
        fh=NtKtNr7JjVPDFVZu2TT0kW88uttBISJpQrnIrKZ5Z60=;
        b=b6f/9k3sPcdQ0meLGjY++v5CQEa/O4xNsrvQjRkpOik4um6FYIEwAqm4pXwjR0oFZC
         fsTzxRoEYZ5WcUBAUYR48PpErnQWHOQWRiarIIdYa2dY5lfOBeL7jc8Jxz0FUdFqg+71
         b/SDgQGZ1ioWYdFXtjtHjBjgM6mixP6bGyHMPx3em3CHqIcSldQBHDx4kR6f4Q/Cqz/N
         /ilZ+QfB4WQXDJeIXFbShfxYD5WSiRMa4EgyblYlqAN1O19Lk4cHvwN1n8Q202T1Z2zV
         UAm8cMQ/nvo92fpfiH/T95y4EgmzW8U2aHgiSNlaT+8eQS8o+jX3DKvv/pTVJuMlB6mt
         ikTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773249840; x=1773854640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfiA7UUuKbDnIQiMEl+5EvA5pBbt4xaYzihYVrz2S9M=;
        b=EdFcC59Wl1JPxmPt9TG8BZRun9RyQiu0ObkKkyuiQOFByv/S6omI83MnkruRmcaKju
         9SislCg6P+dKNqk2rniee5AHbEtmbDPPr0wIND3bEsgOsYie/1ZE8WHdWPGLB6fGNNrz
         rGwRDFt8CkLIpRKtPhJVk2Q0sPUP+uPtP271aSUaRH0fv7p6cFmI/VnlHKE1OUbNA7G9
         SkpsLU79anNmI3Y1p7kP/xmpHpznP3t5apUqNAVI7lAlcGS2I4DyhJL/fpWYTXOFBeDV
         JGcNPqcvQSXSrh+zmr05yRcCPBghJ7u7BhCQtIsRai1wMNOZ04Ukia7PqhqYHtlOJeTq
         R9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773249840; x=1773854640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MfiA7UUuKbDnIQiMEl+5EvA5pBbt4xaYzihYVrz2S9M=;
        b=IQ3nYtjR3ACkC3Bo9nuh7fDn0+Khybzju8WioHIl88OaX9nOuLlVJaRcF94escC4E9
         JJweXOiVdY7dzTZXh7DVIhlgceq3al/Cd+HPyHh57yenhJHagabifKQJ8sd7sadBsT8P
         dYfxC7GAUXA2qRdHT0h2hvkiGyx+8IurmIuHgUOwJbYI67Naa2J2ROnlLadEFvGUkWkD
         gV4ZWXIDDaZytRX7IRnUZWX71nln/oIQnf5I8DlreyM2zRBWCCxqvxW8f9dagdqZ9lqb
         xgg/fl3alQkV2sJVkQIJXHjlPMWeSIXHY2whoLDYHnP5B+BF6vrXgLDnppTS06fuKwFT
         itYg==
X-Forwarded-Encrypted: i=1; AJvYcCXqkz3PY8w4pbt2mohpW6WfwyOykJ+6nPsynTJP+YPjlpi8amJxA36n7fjrOWlaGlp8bqgmH88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBtyDTLMfOXLdUlgmXnxzccPGSOFXa6Ff4F6ICpMX6uqE8nMIN
	Exv4ioguC3i5vJ/BQnjSM6pm21d/h1lYSQqcKUOIDD40g/gZc46E50LqmZJ304lclVtK3tWLwOL
	HwbLyBKumb7j0EoqQKmif6ei9kSj+8yc=
X-Gm-Gg: ATEYQzww/vdVEXM6Cy5v5F/Kq2siuxbk3jZAM0cTv9cc59hqjEZZkGtbGLBLVRhpI10
	Xzlp0Dirr1bP1qoPEVCuT1YpDhv+qi199Q7qUexqGckOoTln8UK1SD4fg0x8RaRyjXvZtY/7dQS
	gmjd5pCAwIDq7IMZ3zPzlOyMnJfdu/UfE4IJYutNUIZ73vbNNCc7ses3UjI81gxhltWIE0oE5eV
	La0Rf8CJTmgbTtamf0dzIiZNvIRLEPasqFibkVS1GD6oquRnS2JFFZ+JI48F4zHAXpwWI16EPJe
	d8LgAJI=
X-Received: by 2002:a05:690c:e694:20b0:798:980f:66f0 with SMTP id
 00721157ae682-79917f69fd8mr24689587b3.33.1773249840201; Wed, 11 Mar 2026
 10:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-4-ameryhung@gmail.com>
 <87ikb2tkta.fsf@gmail.com>
In-Reply-To: <87ikb2tkta.fsf@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 11 Mar 2026 10:23:49 -0700
X-Gm-Features: AaiRm52s_sbz6BqGdUQ9tQg_tjoI3Gti4Ez7Mqw-B1DqJ6sCr9sviFDkl9d1iXw
Message-ID: <CAMB2axOuQGzb0ekbS6-5K_cTcDta+sUk3NjZtzSaYvbXT1EOcw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 03/11] bpf: Unify dynptr handling in the verifier
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266725-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8C56268060
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 9:03=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Amery Hung <ameryhung@gmail.com> writes:
>
> > Simplify dynptr checking for helper and kfunc by unifying it. Remember
> > initialized dynptr in process_dynptr_func() so that we can easily
> > retrieve the information for verification later.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 179 +++++++++---------------------------------
> >  1 file changed, 36 insertions(+), 143 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0f77c4c5b510..d52780962adb 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -277,8 +277,15 @@ struct bpf_map_desc {
> >       int uid;
> >  };
> >
> > +struct bpf_dynptr_desc {
> > +     enum bpf_dynptr_type type;
> > +     u32 id;
> > +     u32 ref_obj_id;
> nit: let's add a comment here explaining what this field is for.

We are about to change the meaning of id and ref_obj_id. I can add
comments explaining id, ref_obj_id and parent_id in the refactor patch
(#6). That said, the meaning of these fields will apply to all objects
tracked by the verifier, not just limited to dynptr, and is already
documented when we define bpf_reg_state in
include/linux/bpf_verifier.h. Can you share a bit what info you are
looking for?

> > +};
> > +
> >  struct bpf_call_arg_meta {
> >       struct bpf_map_desc map;
> > +     struct bpf_dynptr_desc initialized_dynptr;
> >       bool raw_mode;
> >       bool pkt_access;
> >       u8 release_regno;
> > @@ -287,7 +294,6 @@ struct bpf_call_arg_meta {
> >       int mem_size;
> >       u64 msize_max_value;
> >       int ref_obj_id;
> > -     int dynptr_id;
> >       int func_id;
> >       struct btf *btf;
> >       u32 btf_id;
> > @@ -346,16 +352,12 @@ struct bpf_kfunc_call_arg_meta {
> >       struct {
> >               struct btf_field *field;
> >       } arg_rbtree_root;
> > -     struct {
> > -             enum bpf_dynptr_type type;
> > -             u32 id;
> > -             u32 ref_obj_id;
> > -     } initialized_dynptr;
> >       struct {
> >               u8 spi;
> >               u8 frameno;
> >       } iter;
> >       struct bpf_map_desc map;
> > +     struct bpf_dynptr_desc initialized_dynptr;
> >       u64 mem_size;
> >  };
> >
> > @@ -511,11 +513,6 @@ static bool is_ptr_cast_function(enum bpf_func_id =
func_id)
> >               func_id =3D=3D BPF_FUNC_skc_to_tcp_request_sock;
> >  }
> >
> > -static bool is_dynptr_ref_function(enum bpf_func_id func_id)
> > -{
> > -     return func_id =3D=3D BPF_FUNC_dynptr_data;
> > -}
> > -
> >  static bool is_sync_callback_calling_kfunc(u32 btf_id);
> >  static bool is_async_callback_calling_kfunc(u32 btf_id);
> >  static bool is_callback_calling_kfunc(u32 btf_id);
> > @@ -597,8 +594,6 @@ static bool helper_multiple_ref_obj_use(enum bpf_fu=
nc_id func_id,
> >               ref_obj_uses++;
> >       if (is_acquire_function(func_id, map))
> >               ref_obj_uses++;
> > -     if (is_dynptr_ref_function(func_id))
> > -             ref_obj_uses++;
> >
> >       return ref_obj_uses > 1;
> >  }
> > @@ -8750,7 +8745,8 @@ static int process_kptr_func(struct bpf_verifier_=
env *env, int regno,
> >   * type, and declare it as 'const struct bpf_dynptr *' in their protot=
ype.
> >   */
> >  static int process_dynptr_func(struct bpf_verifier_env *env, int regno=
, int insn_idx,
> > -                            enum bpf_arg_type arg_type, int clone_ref_=
obj_id)
> > +                            enum bpf_arg_type arg_type, int clone_ref_=
obj_id,
> > +                            struct bpf_dynptr_desc *initialized_dynptr=
)
> >  {
> >       struct bpf_reg_state *reg =3D reg_state(env, regno);
> >       int err;
> > @@ -8825,6 +8821,20 @@ static int process_dynptr_func(struct bpf_verifi=
er_env *env, int regno, int insn
> >               }
> >
> >               err =3D mark_dynptr_read(env, reg);
> > +
> > +             if (initialized_dynptr) {
> > +                     struct bpf_func_state *state =3D func(env, reg);
> state is only used if reg->type !=3D CONST_PTR_TO_DYNPTR, does it make
> sense to move state =3D func(env, reg); to the corresponding if block?

I think this is fine. It looks less cluttered this way.

> > +                     int spi;
> > +
> > +                     if (reg->type !=3D CONST_PTR_TO_DYNPTR) {
> > +                             spi =3D dynptr_get_spi(env, reg);
> looking at the deleted dynptr_id() and dynptr_ref_obj_id() spi can be
> negative, what changed here that we no longer need this check?

is_dynptr_reg_valid_init() above already makes sure reg points to a
valid dynptr so we don't need to check it again.

> > +                             reg =3D &state->stack[spi].spilled_ptr;
> > +                     }
> > +
> > +                     initialized_dynptr->id =3D reg->id;
> > +                     initialized_dynptr->type =3D reg->dynptr.type;
> > +                     initialized_dynptr->ref_obj_id =3D reg->ref_obj_i=
d;
> > +             }
> >       }
> >       return err;
> >  }
> > @@ -9587,72 +9597,6 @@ static int check_func_arg_reg_off(struct bpf_ver=
ifier_env *env,
> >       }
> >  }
> >
> > -static struct bpf_reg_state *get_dynptr_arg_reg(struct bpf_verifier_en=
v *env,
> > -                                             const struct bpf_func_pro=
to *fn,
> > -                                             struct bpf_reg_state *reg=
s)
> > -{
> > -     struct bpf_reg_state *state =3D NULL;
> > -     int i;
> > -
> > -     for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++)
> > -             if (arg_type_is_dynptr(fn->arg_type[i])) {
> > -                     if (state) {
> > -                             verbose(env, "verifier internal error: mu=
ltiple dynptr args\n");
> > -                             return NULL;
> > -                     }
> > -                     state =3D &regs[BPF_REG_1 + i];
> > -             }
> > -
> > -     if (!state)
> > -             verbose(env, "verifier internal error: no dynptr arg foun=
d\n");
> > -
> > -     return state;
> > -}
> > -
> > -static int dynptr_id(struct bpf_verifier_env *env, struct bpf_reg_stat=
e *reg)
> > -{
> > -     struct bpf_func_state *state =3D func(env, reg);
> > -     int spi;
> > -
> > -     if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
> > -             return reg->id;
> > -     spi =3D dynptr_get_spi(env, reg);
> > -     if (spi < 0)
> > -             return spi;
> > -     return state->stack[spi].spilled_ptr.id;
> > -}
> > -
> > -static int dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg)
> > -{
> > -     struct bpf_func_state *state =3D func(env, reg);
> > -     int spi;
> > -
> > -     if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
> > -             return reg->ref_obj_id;
> > -     spi =3D dynptr_get_spi(env, reg);
> > -     if (spi < 0)
> > -             return spi;
> > -     return state->stack[spi].spilled_ptr.ref_obj_id;
> > -}
> > -
> > -static enum bpf_dynptr_type dynptr_get_type(struct bpf_verifier_env *e=
nv,
> > -                                         struct bpf_reg_state *reg)
> > -{
> > -     struct bpf_func_state *state =3D func(env, reg);
> > -     int spi;
> > -
> > -     if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
> > -             return reg->dynptr.type;
> > -
> > -     spi =3D __get_spi(reg->var_off.value);
> > -     if (spi < 0) {
> > -             verbose(env, "verifier internal error: invalid spi when q=
uerying dynptr type\n");
> > -             return BPF_DYNPTR_TYPE_INVALID;
> > -     }
> > -
> > -     return state->stack[spi].spilled_ptr.dynptr.type;
> > -}
> > -
> >  static int check_reg_const_str(struct bpf_verifier_env *env,
> >                              struct bpf_reg_state *reg, u32 regno)
> >  {
> > @@ -10007,7 +9951,8 @@ static int check_func_arg(struct bpf_verifier_en=
v *env, u32 arg,
> >                                        true, meta);
> >               break;
> >       case ARG_PTR_TO_DYNPTR:
> > -             err =3D process_dynptr_func(env, regno, insn_idx, arg_typ=
e, 0);
> > +             err =3D process_dynptr_func(env, regno, insn_idx, arg_typ=
e, 0,
> > +                                       &meta->initialized_dynptr);
> >               if (err)
> >                       return err;
> >               break;
> > @@ -10666,7 +10611,7 @@ static int btf_check_func_arg_match(struct bpf_=
verifier_env *env, int subprog,
> >                       if (ret)
> >                               return ret;
> >
> > -                     ret =3D process_dynptr_func(env, regno, -1, arg->=
arg_type, 0);
> > +                     ret =3D process_dynptr_func(env, regno, -1, arg->=
arg_type, 0, NULL);
> >                       if (ret)
> >                               return ret;
> >               } else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_BTF=
_ID) {
> > @@ -11771,52 +11716,10 @@ static int check_helper_call(struct bpf_verif=
ier_env *env, struct bpf_insn *insn
> >                       }
> >               }
> >               break;
> > -     case BPF_FUNC_dynptr_data:
> > -     {
> > -             struct bpf_reg_state *reg;
> > -             int id, ref_obj_id;
> > -
> > -             reg =3D get_dynptr_arg_reg(env, fn, regs);
> > -             if (!reg)
> > -                     return -EFAULT;
> > -
> > -
> > -             if (meta.dynptr_id) {
> > -                     verifier_bug(env, "meta.dynptr_id already set");
> > -                     return -EFAULT;
> > -             }
> > -             if (meta.ref_obj_id) {
> > -                     verifier_bug(env, "meta.ref_obj_id already set");
> > -                     return -EFAULT;
> > -             }
> > -
> > -             id =3D dynptr_id(env, reg);
> > -             if (id < 0) {
> > -                     verifier_bug(env, "failed to obtain dynptr id");
> > -                     return id;
> > -             }
> > -
> > -             ref_obj_id =3D dynptr_ref_obj_id(env, reg);
> > -             if (ref_obj_id < 0) {
> > -                     verifier_bug(env, "failed to obtain dynptr ref_ob=
j_id");
> > -                     return ref_obj_id;
> > -             }
> > -
> > -             meta.dynptr_id =3D id;
> > -             meta.ref_obj_id =3D ref_obj_id;
> > -
> > -             break;
> > -     }
> >       case BPF_FUNC_dynptr_write:
> >       {
> > -             enum bpf_dynptr_type dynptr_type;
> > -             struct bpf_reg_state *reg;
> > -
> > -             reg =3D get_dynptr_arg_reg(env, fn, regs);
> > -             if (!reg)
> > -                     return -EFAULT;
> > +             enum bpf_dynptr_type dynptr_type =3D meta.initialized_dyn=
ptr.type;
> >
> > -             dynptr_type =3D dynptr_get_type(env, reg);
> >               if (dynptr_type =3D=3D BPF_DYNPTR_TYPE_INVALID)
> >                       return -EFAULT;
> >
> > @@ -12007,10 +11910,7 @@ static int check_helper_call(struct bpf_verifi=
er_env *env, struct bpf_insn *insn
> >               return -EFAULT;
> >       }
> >
> > -     if (is_dynptr_ref_function(func_id))
> > -             regs[BPF_REG_0].dynptr_id =3D meta.dynptr_id;
> > -
> > -     if (is_ptr_cast_function(func_id) || is_dynptr_ref_function(func_=
id)) {
> > +     if (is_ptr_cast_function(func_id)) {
> >               /* For release_reference() */
> >               regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj_id;
> >       } else if (is_acquire_function(func_id, meta.map.ptr)) {
> > @@ -12024,6 +11924,11 @@ static int check_helper_call(struct bpf_verifi=
er_env *env, struct bpf_insn *insn
> >               regs[BPF_REG_0].ref_obj_id =3D id;
> >       }
> >
> > +     if (func_id =3D=3D BPF_FUNC_dynptr_data) {
> > +             regs[BPF_REG_0].dynptr_id =3D meta.initialized_dynptr.id;
> > +             regs[BPF_REG_0].ref_obj_id =3D meta.initialized_dynptr.re=
f_obj_id;
> > +     }
> > +
> >       err =3D do_refine_retval_range(env, regs, fn->ret_type, func_id, =
&meta);
> >       if (err)
> >               return err;
> > @@ -13559,22 +13464,10 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_kfunc_call_
> >                               }
> >                       }
> >
> > -                     ret =3D process_dynptr_func(env, regno, insn_idx,=
 dynptr_arg_type, clone_ref_obj_id);
> > +                     ret =3D process_dynptr_func(env, regno, insn_idx,=
 dynptr_arg_type, clone_ref_obj_id,
> > +                                               &meta->initialized_dynp=
tr);
> >                       if (ret < 0)
> >                               return ret;
> > -
> > -                     if (!(dynptr_arg_type & MEM_UNINIT)) {
> > -                             int id =3D dynptr_id(env, reg);
> > -
> > -                             if (id < 0) {
> > -                                     verifier_bug(env, "failed to obta=
in dynptr id");
> > -                                     return id;
> > -                             }
> > -                             meta->initialized_dynptr.id =3D id;
> > -                             meta->initialized_dynptr.type =3D dynptr_=
get_type(env, reg);
> > -                             meta->initialized_dynptr.ref_obj_id =3D d=
ynptr_ref_obj_id(env, reg);
> > -                     }
> > -
> >                       break;
> >               }
> >               case KF_ARG_PTR_TO_ITER:
> > --
> > 2.47.3

