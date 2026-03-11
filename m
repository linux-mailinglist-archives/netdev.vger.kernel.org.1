Return-Path: <netdev+bounces-266790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALwQBknusWnbHAAAu9opvQ
	(envelope-from <netdev+bounces-266790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:35:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C635326AED1
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A800F303327E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 22:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742CF37703D;
	Wed, 11 Mar 2026 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBhcKjeE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93ED35DA46
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773268546; cv=pass; b=ceVXTc0Orv19WFTY7DsUe1edOI7meO727qpSJu2FAMu9V7dG8Saym7iKUNcSLBPbwlYCychMlCii3UIxtPITmWuYtby6fR5XhZciRna6Lc9jF0Qz3TMdNphj5NgbA5UjP2SP2iy8jAPv+56MaXDgZ4xcXfuqH0Jgsv2dDGAsgyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773268546; c=relaxed/simple;
	bh=67PSG/tWHcIbZD4vOkiJyiLFwy7uv6FrDYqiVkErixw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5esHe3cMEk3v8hKxL4WnH2qJxdKaEh9iE6fSSMZSFH+M3vp5i1zDpatTDJHUjcdeGw9RetX2TGK61lDHWvc1PVaeRx3aUx+GdjvnFSiZKbghxiPedOQqoFzXftg/RhcUtng9/fczQhUJM2NcGEiE71i33fJSLeqreo6gMXFNPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBhcKjeE; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7985d11da10so4090757b3.3
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 15:35:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773268543; cv=none;
        d=google.com; s=arc-20240605;
        b=Qk/D6xAKWFZTgdi+gSd+VJHuyfbsSJS2bed9SBI5cG5rjE23pce+4Hk4dWFkvZ0PhR
         zTZIcMTG8nt889Vk15V6NCu6gzg95KLYBVbfpgb+MdL1i3U56TqkuVot01+B8qqqWWC2
         UoIoN2mt7XGX/pMbNO8UPVO6BMhFDU6RV03ApwCcC6rhF09/sX+4gFiRGgrdeLSP5xa7
         qCpaDmoDP4b+XkSKkFYLTrmau88RrCSZXfBeVIqmmWy8oyFK5NX5max1faFCmmEX4qJG
         33zlpVGhPSwzMyUxDWZ6vjadgVGiX8GLEJ/W/xvAp2QBzQPMGJ1iJA4SQdyCXrU3/dr8
         KjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d9f5zqwvBPaGmSqwRuC9Wz/sZWDcUA3Gh/ijMN/0svI=;
        fh=TLLWL2fJoN0isXCEX6svCG5hK/MM4ZyOemH/EnIYKIA=;
        b=TaaVYA+sxnA+e2pIVgW8xTOEaBKngdteetrOfEbkzOq/TP8FEQne+OKFNT7JQHcgz6
         hzuS/KZlikuFyfDXB2lELgfT4K2JJmVPr4GzIxUXko+vqGQhFHdcmL9rMRHGQKf2AhpF
         oY0HfjdzchAnFuAjByxj1Ujdm5XUWTJH+3pMR0Be5K6pDauc6kwTxPPvCQCYrq4EMS4T
         RqRvD5hNdLaBGIWzHJTFD+xjFap4YEB4QHyQzQo1nmXk70e10fwo3Xz0xQRTnoensMQC
         ml+pr77NT0d+r/uP/dsVvDPmGFMMz/MQqv6NuMYqR8HTizOLEpWkpSEwmVX3OCfOisUQ
         4eoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773268543; x=1773873343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9f5zqwvBPaGmSqwRuC9Wz/sZWDcUA3Gh/ijMN/0svI=;
        b=DBhcKjeEfJ0hoA0vNGJe+P9kKTAaMHhbophciMXd5FcV9zJMzB1XvbRUxbZEYLVojV
         XCIY1Q62X2eiTFsGRy8HfUCBa7EcWGoltwDEWXOG8DjxUokcMyWXtnMcAzegvSuH9Xxa
         Mkl2LV6PfUWY4bn9V9Ac4nlyLhbyJybdbcwqQcGSIRx0eMbh+8OZ3vdWUpWFKPEDQNwa
         UcW4hbRGC+G34b1Mnggr4ryeJ7AZaiJBrmp0vD/GoGph/2Ag2Oa5dHD5YrhsLmElZ0OC
         CmifYsS2L61Z2WVn7Uc8bB/QiqfZhfkqkLyp7xG5MxCTFr3VyWqIyksVGz+kTmDaWi6n
         0oAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773268543; x=1773873343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d9f5zqwvBPaGmSqwRuC9Wz/sZWDcUA3Gh/ijMN/0svI=;
        b=m/xCL5H4z26XBAnyvOrV/6aOPlkCIrffH4M3SIjNdH/0w7OHbtHCmokeVOFE3J9Ehh
         xTqCnU7rJ3GXFfPHhB+ywoyD5utRsCXJl39SOpGrBNaudFrd8GXsTdaQSbo/GcG8SX+P
         pq6qNoMtletilzglmv6deexzesQcK8kUibRfm2kh8oMDRXuCnLwqauozTSeFB8QYykwg
         gnt02FwGsk33hWb4dugOAU4i7JNELpDKvt6HZtTsMDoL35InT58EYG1LtYGqd2zBCVkE
         0qjw/RooJeoogQlMm0HHAkFC6oXNDRt8MvJhinPbVxbXvnQiA9alwLJSwFBuZ4RGkFS1
         Vzvw==
X-Forwarded-Encrypted: i=1; AJvYcCXctC9pZK6+aNXAhQ6ItjVWX3bRW4P+hPNwmqcEvFyiHWfAf8NfTOaqYjsOxIywrS/eaximK38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/W+d3Eer+zGaZi1SMSrQQEsJ38km+BwQRx6KXR4tUF7BXHLXY
	BAl58YFEBZTPoh65CwNfTYE1M4uX67LnkVkrBk8FLeRLi/f9Jlf6glRiqIv3BJOII6aWeRPNWoE
	mC8O+u4uq5i2sWWnaPFw7bUTQqza2FHiw9EN1
X-Gm-Gg: ATEYQzxmvvd46Wki/3VS3tBWkrZhSvgZGjIX7gncAXoYTSJ23DGEp1p7wZ7ilDJEpuh
	+Psv/eKrQaklsDmC0gQER3txMxgZvLgmhH6wCQHQyibKpLhjMgTBED6ufJXpbwMzBh/cXdLga8n
	mrjfio2Zz8jEydpKhW0ptbbhi1ogrwIRXO5jXDOhgTMf4ob3x1KZCex4B2VIZ7UXz3aG65QpAgu
	xG/Az4qUZlLxNEXUH61h4oR9ds+VzFCt6yoqkNXbXU0wu3BBDzxMygVOHOj4bChy51nGSaw1G35
	Jq8l1ETBgTC8Jo5kBg==
X-Received: by 2002:a05:690c:6081:b0:798:980f:670e with SMTP id
 00721157ae682-79917fb08c8mr41417637b3.62.1773268542863; Wed, 11 Mar 2026
 15:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-4-ameryhung@gmail.com>
 <87ikb2tkta.fsf@gmail.com> <CAMB2axOuQGzb0ekbS6-5K_cTcDta+sUk3NjZtzSaYvbXT1EOcw@mail.gmail.com>
 <87fr66t3a7.fsf@gmail.com>
In-Reply-To: <87fr66t3a7.fsf@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 11 Mar 2026 15:35:32 -0700
X-Gm-Features: AaiRm50QV7C9RHpJUUpVECsszu2UUAVyaUB411aOYM5KPBo3A60txAtoc7fyKEA
Message-ID: <CAMB2axN_NmWS2rW+rwuETnFHX-opMT3J8Tu5YhvQ_tyAqsTNYA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266790-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C635326AED1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 3:22=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Amery Hung <ameryhung@gmail.com> writes:
>
> > On Wed, Mar 11, 2026 at 9:03=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >>
> >> Amery Hung <ameryhung@gmail.com> writes:
> >>
> >> > Simplify dynptr checking for helper and kfunc by unifying it. Rememb=
er
> >> > initialized dynptr in process_dynptr_func() so that we can easily
> >> > retrieve the information for verification later.
> >> >
> >> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> >> > ---
> >> >  kernel/bpf/verifier.c | 179 +++++++++------------------------------=
---
> >> >  1 file changed, 36 insertions(+), 143 deletions(-)
> >> >
> >> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> > index 0f77c4c5b510..d52780962adb 100644
> >> > --- a/kernel/bpf/verifier.c
> >> > +++ b/kernel/bpf/verifier.c
> >> > @@ -277,8 +277,15 @@ struct bpf_map_desc {
> >> >       int uid;
> >> >  };
> >> >
> >> > +struct bpf_dynptr_desc {
> >> > +     enum bpf_dynptr_type type;
> >> > +     u32 id;
> >> > +     u32 ref_obj_id;
> >> nit: let's add a comment here explaining what this field is for.
> >
> > We are about to change the meaning of id and ref_obj_id. I can add
> > comments explaining id, ref_obj_id and parent_id in the refactor patch
> > (#6). That said, the meaning of these fields will apply to all objects
> > tracked by the verifier, not just limited to dynptr, and is already
> > documented when we define bpf_reg_state in
> > include/linux/bpf_verifier.h. Can you share a bit what info you are
> > looking for?
> >
> >
> the description from commit message would help:
> /* id of the referenced object; objects with same ref_obj_id have the sam=
e lifetime */
>
> Oftentimes when I work on verifier, it's difficult to understand what
> some data field is for. It's easier now with the AI, but still I see a
> lot of value to have that inline. Essentially ref_obj_id does not have
> obvious meaning (at least to me).

I see. bpf_reg_state->ref_obj_id is already explained in
bpf_verifier.h, but only mentioned how it is used in tracking
referenced socket and casted socket pointers. I will update the
comment in patch 6 in the next respin.

> >> > +};
> >> > +
> >> >  struct bpf_call_arg_meta {
> >> >       struct bpf_map_desc map;
> >> > +     struct bpf_dynptr_desc initialized_dynptr;
> >> >       bool raw_mode;
> >> >       bool pkt_access;
> >> >       u8 release_regno;
> >> > @@ -287,7 +294,6 @@ struct bpf_call_arg_meta {
> >> >       int mem_size;
> >> >       u64 msize_max_value;
> >> >       int ref_obj_id;
> >> > -     int dynptr_id;
> >> >       int func_id;
> >> >       struct btf *btf;
> >> >       u32 btf_id;
> >> > @@ -346,16 +352,12 @@ struct bpf_kfunc_call_arg_meta {
> >> >       struct {
> >> >               struct btf_field *field;
> >> >       } arg_rbtree_root;
> >> > -     struct {
> >> > -             enum bpf_dynptr_type type;
> >> > -             u32 id;
> >> > -             u32 ref_obj_id;
> >> > -     } initialized_dynptr;
> >> >       struct {
> >> >               u8 spi;
> >> >               u8 frameno;
> >> >       } iter;
> >> >       struct bpf_map_desc map;
> >> > +     struct bpf_dynptr_desc initialized_dynptr;
> >> >       u64 mem_size;
> >> >  };
> >> >
> >> > @@ -511,11 +513,6 @@ static bool is_ptr_cast_function(enum bpf_func_=
id func_id)
> >> >               func_id =3D=3D BPF_FUNC_skc_to_tcp_request_sock;
> >> >  }
> >> >
> >> > -static bool is_dynptr_ref_function(enum bpf_func_id func_id)
> >> > -{
> >> > -     return func_id =3D=3D BPF_FUNC_dynptr_data;
> >> > -}
> >> > -
> >> >  static bool is_sync_callback_calling_kfunc(u32 btf_id);
> >> >  static bool is_async_callback_calling_kfunc(u32 btf_id);
> >> >  static bool is_callback_calling_kfunc(u32 btf_id);
> >> > @@ -597,8 +594,6 @@ static bool helper_multiple_ref_obj_use(enum bpf=
_func_id func_id,
> >> >               ref_obj_uses++;
> >> >       if (is_acquire_function(func_id, map))
> >> >               ref_obj_uses++;
> >> > -     if (is_dynptr_ref_function(func_id))
> >> > -             ref_obj_uses++;
> >> >
> >> >       return ref_obj_uses > 1;
> >> >  }
> >> > @@ -8750,7 +8745,8 @@ static int process_kptr_func(struct bpf_verifi=
er_env *env, int regno,
> >> >   * type, and declare it as 'const struct bpf_dynptr *' in their pro=
totype.
> >> >   */
> >> >  static int process_dynptr_func(struct bpf_verifier_env *env, int re=
gno, int insn_idx,
> >> > -                            enum bpf_arg_type arg_type, int clone_r=
ef_obj_id)
> >> > +                            enum bpf_arg_type arg_type, int clone_r=
ef_obj_id,
> >> > +                            struct bpf_dynptr_desc *initialized_dyn=
ptr)
> >> >  {
> >> >       struct bpf_reg_state *reg =3D reg_state(env, regno);
> >> >       int err;
> >> > @@ -8825,6 +8821,20 @@ static int process_dynptr_func(struct bpf_ver=
ifier_env *env, int regno, int insn
> >> >               }
> >> >
> >> >               err =3D mark_dynptr_read(env, reg);
> >> > +
> >> > +             if (initialized_dynptr) {
> >> > +                     struct bpf_func_state *state =3D func(env, reg=
);
> >> state is only used if reg->type !=3D CONST_PTR_TO_DYNPTR, does it make
> >> sense to move state =3D func(env, reg); to the corresponding if block?
> >
> > I think this is fine. It looks less cluttered this way.
> >
> >> > +                     int spi;
> >> > +
> >> > +                     if (reg->type !=3D CONST_PTR_TO_DYNPTR) {
> >> > +                             spi =3D dynptr_get_spi(env, reg);
> >> looking at the deleted dynptr_id() and dynptr_ref_obj_id() spi can be
> >> negative, what changed here that we no longer need this check?
> >
> > is_dynptr_reg_valid_init() above already makes sure reg points to a
> > valid dynptr so we don't need to check it again.
> >
> >> > +                             reg =3D &state->stack[spi].spilled_ptr=
;
> >> > +                     }
> >> > +
> >> > +                     initialized_dynptr->id =3D reg->id;
> >> > +                     initialized_dynptr->type =3D reg->dynptr.type;
> >> > +                     initialized_dynptr->ref_obj_id =3D reg->ref_ob=
j_id;
> >> > +             }
> >> >       }
> >> >       return err;
> >> >  }
> >> > @@ -9587,72 +9597,6 @@ static int check_func_arg_reg_off(struct bpf_=
verifier_env *env,
> >> >       }
> >> >  }
> >> >
> >> > -static struct bpf_reg_state *get_dynptr_arg_reg(struct bpf_verifier=
_env *env,
> >> > -                                             const struct bpf_func_=
proto *fn,
> >> > -                                             struct bpf_reg_state *=
regs)
> >> > -{
> >> > -     struct bpf_reg_state *state =3D NULL;
> >> > -     int i;
> >> > -
> >> > -     for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++)
> >> > -             if (arg_type_is_dynptr(fn->arg_type[i])) {
> >> > -                     if (state) {
> >> > -                             verbose(env, "verifier internal error:=
 multiple dynptr args\n");
> >> > -                             return NULL;
> >> > -                     }
> >> > -                     state =3D &regs[BPF_REG_1 + i];
> >> > -             }
> >> > -
> >> > -     if (!state)
> >> > -             verbose(env, "verifier internal error: no dynptr arg f=
ound\n");
> >> > -
> >> > -     return state;
> >> > -}
> >> > -
> >> > -static int dynptr_id(struct bpf_verifier_env *env, struct bpf_reg_s=
tate *reg)
> >> > -{
> >> > -     struct bpf_func_state *state =3D func(env, reg);
> >> > -     int spi;
> >> > -
> >> > -     if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
> >> > -             return reg->id;
> >> > -     spi =3D dynptr_get_spi(env, reg);
> >> > -     if (spi < 0)
> >> > -             return spi;
> >> > -     return state->stack[spi].spilled_ptr.id;
> >> > -}
> >> > -
> >> > -static int dynptr_ref_obj_id(struct bpf_verifier_env *env, struct b=
pf_reg_state *reg)
> >> > -{
> >> > -     struct bpf_func_state *state =3D func(env, reg);
> >> > -     int spi;
> >> > -
> >> > -     if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
> >> > -             return reg->ref_obj_id;
> >> > -     spi =3D dynptr_get_spi(env, reg);
> >> > -     if (spi < 0)
> >> > -             return spi;
> >> > -     return state->stack[spi].spilled_ptr.ref_obj_id;
> >> > -}
> >> > -
> >> > -static enum bpf_dynptr_type dynptr_get_type(struct bpf_verifier_env=
 *env,
> >> > -                                         struct bpf_reg_state *reg)
> >> > -{
> >> > -     struct bpf_func_state *state =3D func(env, reg);
> >> > -     int spi;
> >> > -
> >> > -     if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
> >> > -             return reg->dynptr.type;
> >> > -
> >> > -     spi =3D __get_spi(reg->var_off.value);
> >> > -     if (spi < 0) {
> >> > -             verbose(env, "verifier internal error: invalid spi whe=
n querying dynptr type\n");
> >> > -             return BPF_DYNPTR_TYPE_INVALID;
> >> > -     }
> >> > -
> >> > -     return state->stack[spi].spilled_ptr.dynptr.type;
> >> > -}
> >> > -
> >> >  static int check_reg_const_str(struct bpf_verifier_env *env,
> >> >                              struct bpf_reg_state *reg, u32 regno)
> >> >  {
> >> > @@ -10007,7 +9951,8 @@ static int check_func_arg(struct bpf_verifier=
_env *env, u32 arg,
> >> >                                        true, meta);
> >> >               break;
> >> >       case ARG_PTR_TO_DYNPTR:
> >> > -             err =3D process_dynptr_func(env, regno, insn_idx, arg_=
type, 0);
> >> > +             err =3D process_dynptr_func(env, regno, insn_idx, arg_=
type, 0,
> >> > +                                       &meta->initialized_dynptr);
> >> >               if (err)
> >> >                       return err;
> >> >               break;
> >> > @@ -10666,7 +10611,7 @@ static int btf_check_func_arg_match(struct b=
pf_verifier_env *env, int subprog,
> >> >                       if (ret)
> >> >                               return ret;
> >> >
> >> > -                     ret =3D process_dynptr_func(env, regno, -1, ar=
g->arg_type, 0);
> >> > +                     ret =3D process_dynptr_func(env, regno, -1, ar=
g->arg_type, 0, NULL);
> >> >                       if (ret)
> >> >                               return ret;
> >> >               } else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_=
BTF_ID) {
> >> > @@ -11771,52 +11716,10 @@ static int check_helper_call(struct bpf_ve=
rifier_env *env, struct bpf_insn *insn
> >> >                       }
> >> >               }
> >> >               break;
> >> > -     case BPF_FUNC_dynptr_data:
> >> > -     {
> >> > -             struct bpf_reg_state *reg;
> >> > -             int id, ref_obj_id;
> >> > -
> >> > -             reg =3D get_dynptr_arg_reg(env, fn, regs);
> >> > -             if (!reg)
> >> > -                     return -EFAULT;
> >> > -
> >> > -
> >> > -             if (meta.dynptr_id) {
> >> > -                     verifier_bug(env, "meta.dynptr_id already set"=
);
> >> > -                     return -EFAULT;
> >> > -             }
> >> > -             if (meta.ref_obj_id) {
> >> > -                     verifier_bug(env, "meta.ref_obj_id already set=
");
> >> > -                     return -EFAULT;
> >> > -             }
> >> > -
> >> > -             id =3D dynptr_id(env, reg);
> >> > -             if (id < 0) {
> >> > -                     verifier_bug(env, "failed to obtain dynptr id"=
);
> >> > -                     return id;
> >> > -             }
> >> > -
> >> > -             ref_obj_id =3D dynptr_ref_obj_id(env, reg);
> >> > -             if (ref_obj_id < 0) {
> >> > -                     verifier_bug(env, "failed to obtain dynptr ref=
_obj_id");
> >> > -                     return ref_obj_id;
> >> > -             }
> >> > -
> >> > -             meta.dynptr_id =3D id;
> >> > -             meta.ref_obj_id =3D ref_obj_id;
> >> > -
> >> > -             break;
> >> > -     }
> >> >       case BPF_FUNC_dynptr_write:
> >> >       {
> >> > -             enum bpf_dynptr_type dynptr_type;
> >> > -             struct bpf_reg_state *reg;
> >> > -
> >> > -             reg =3D get_dynptr_arg_reg(env, fn, regs);
> >> > -             if (!reg)
> >> > -                     return -EFAULT;
> >> > +             enum bpf_dynptr_type dynptr_type =3D meta.initialized_=
dynptr.type;
> >> >
> >> > -             dynptr_type =3D dynptr_get_type(env, reg);
> >> >               if (dynptr_type =3D=3D BPF_DYNPTR_TYPE_INVALID)
> >> >                       return -EFAULT;
> >> >
> >> > @@ -12007,10 +11910,7 @@ static int check_helper_call(struct bpf_ver=
ifier_env *env, struct bpf_insn *insn
> >> >               return -EFAULT;
> >> >       }
> >> >
> >> > -     if (is_dynptr_ref_function(func_id))
> >> > -             regs[BPF_REG_0].dynptr_id =3D meta.dynptr_id;
> >> > -
> >> > -     if (is_ptr_cast_function(func_id) || is_dynptr_ref_function(fu=
nc_id)) {
> >> > +     if (is_ptr_cast_function(func_id)) {
> >> >               /* For release_reference() */
> >> >               regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj_id;
> >> >       } else if (is_acquire_function(func_id, meta.map.ptr)) {
> >> > @@ -12024,6 +11924,11 @@ static int check_helper_call(struct bpf_ver=
ifier_env *env, struct bpf_insn *insn
> >> >               regs[BPF_REG_0].ref_obj_id =3D id;
> >> >       }
> >> >
> >> > +     if (func_id =3D=3D BPF_FUNC_dynptr_data) {
> >> > +             regs[BPF_REG_0].dynptr_id =3D meta.initialized_dynptr.=
id;
> >> > +             regs[BPF_REG_0].ref_obj_id =3D meta.initialized_dynptr=
.ref_obj_id;
> >> > +     }
> >> > +
> >> >       err =3D do_refine_retval_range(env, regs, fn->ret_type, func_i=
d, &meta);
> >> >       if (err)
> >> >               return err;
> >> > @@ -13559,22 +13464,10 @@ static int check_kfunc_args(struct bpf_ver=
ifier_env *env, struct bpf_kfunc_call_
> >> >                               }
> >> >                       }
> >> >
> >> > -                     ret =3D process_dynptr_func(env, regno, insn_i=
dx, dynptr_arg_type, clone_ref_obj_id);
> >> > +                     ret =3D process_dynptr_func(env, regno, insn_i=
dx, dynptr_arg_type, clone_ref_obj_id,
> >> > +                                               &meta->initialized_d=
ynptr);
> >> >                       if (ret < 0)
> >> >                               return ret;
> >> > -
> >> > -                     if (!(dynptr_arg_type & MEM_UNINIT)) {
> >> > -                             int id =3D dynptr_id(env, reg);
> >> > -
> >> > -                             if (id < 0) {
> >> > -                                     verifier_bug(env, "failed to o=
btain dynptr id");
> >> > -                                     return id;
> >> > -                             }
> >> > -                             meta->initialized_dynptr.id =3D id;
> >> > -                             meta->initialized_dynptr.type =3D dynp=
tr_get_type(env, reg);
> >> > -                             meta->initialized_dynptr.ref_obj_id =
=3D dynptr_ref_obj_id(env, reg);
> >> > -                     }
> >> > -
> >> >                       break;
> >> >               }
> >> >               case KF_ARG_PTR_TO_ITER:
> >> > --
> >> > 2.47.3

