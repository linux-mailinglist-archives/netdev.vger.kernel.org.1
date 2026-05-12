Return-Path: <netdev+bounces-287324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DpjKR6aA2p27wEAu9opvQ
	(envelope-from <netdev+bounces-287324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:22:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2160452A3A2
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DECC30160F8
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7045437F8A8;
	Tue, 12 May 2026 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1PvxHyi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EB737F019
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620956; cv=pass; b=rFkuiBGKaZ3KEajyZKwrjuboXCeLLjzIF2tWsCC8ByIh/NAUyaNMzPeZj77bZVpkpF/QtT/9dCpFDCKm6IAL/ymX+yRQJ7Kp0e6DYXjLjOzjse9+/dlKqudsdkrS5mFkvdkF7yEe4gi48v+e7o+vTxXpqKxgJSAU9ClWnUcQOQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620956; c=relaxed/simple;
	bh=PiDYevi2kgVcvyRTmr06usMvTBl/SGOPbnIPQRlvqb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeLxivplUgvr/rY0+7LyTbea9lSQI2uHkaTVmrKLCmBwz6DHX8VUk+NMJIwRH535hkpNes5CC3WbNebAyZJMU9uB1YVzftlJjYqcOM8/vOwKLx24X5RnBkQhCS/3QyOHN/SF76cXe59ciWB/KrQuhgvzA640g8qC3+/p9gkDH6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s1PvxHyi; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7c0de780bf1so32760337b3.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:22:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778620953; cv=none;
        d=google.com; s=arc-20240605;
        b=Qr5+9toFpJcArYPfddNvaTP8iKq3fVrthLnhymBxePGs+PXe6k++2WBjEEdHgfqxjB
         v+cftu71TH24i2In7XnXE6FmgXQPb/uVvGhRfiOkHdShAdiX/OwWD4+YLXIkKL4p0X6M
         OzM6JwVczsq/0q4lBqLTpxbG3LhsALWarKKpMkwwvGBOgMhCQf8I98QCr6FTDhvFOc/1
         ypf+4a71TSeiw/bYFyuFSl92kILANsLs8P8yVfs2VZ7oJMaXEV+tXFZahWxqqMuuzRP3
         KjLKr9Xxr0/e3KrErbM7lCPo/VnMhcYyDXgb9sbYYPmZFCcCaTqNOPnEQ4azLdflTjxv
         On/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3KuydEKLLJrXqUzzkqH1Oq4poBO4K1OP1ji2kRqJ9uI=;
        fh=5yfaC6RlQV5LYdFVJ6qC9xVPheZaOVbiYpMSaAZX2B8=;
        b=AOJ/wYPm7Ugs0/sSDW+4XNZRGFV8olXwWC4OK/aHWszZNGs0a+3sh6yvqAEI4wvWdn
         XW3+rSdI7ePANWuf2ADl8vGEk6AaTyfTLvvxpqsvETUDUQmYXBDPx9QQT2it8Jk/n0No
         TRFQFJMfglB0+HcP/qRCkuxXg3Dwd4YOcTyQ4mdizTQUGyHf5jw+Wq0700USqrIDomEk
         g2pyW/GDaCnX87mTW2vJ92qg/FYfbC6Rv4O1XAiFQRV0atMJYJwXy36jXRxRmhE6BKds
         oKvvGAQsPLMALRwDDjL6kNQusAD+c64iVHBZdaT3JfKQHURcM1nT4/TZq47QYQJszzTr
         5wlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778620953; x=1779225753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KuydEKLLJrXqUzzkqH1Oq4poBO4K1OP1ji2kRqJ9uI=;
        b=s1PvxHyiAacYS+SqmWtq0dqNrDJnHfhs6NH1lQ6Bjx51gHrgAlSNIhkd9Djcy9PdgX
         pVj/FGBfk6EC7zXiORaL5hzwkwhMc60gLd42DorXVC1/IT9XbKcS0bvlZNjz0cSsN86s
         HW8T0hdplYXuI8VocEgnH63KG9uG9f5MJvIh63D+F9DvgtDwigVhmW2P1Y9oDWvvyqLX
         RQf3AB7QN86vgLVN0W6C4O5IwQzdnKuna/WVvDlcMr3mgUxpTiZ1hkVRVqgNRf7LEc2x
         hE60ft1n7WlrF9hpocG0ZNu5eJZ0E6WV11akcPTQ/3dg9SQ1MA8MRHoA4fPVd8DuhQ/4
         j32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620953; x=1779225753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3KuydEKLLJrXqUzzkqH1Oq4poBO4K1OP1ji2kRqJ9uI=;
        b=ImnAfXPD4Nc1D9+tPU8/ztPFpAmgIgs6W9CE58XdOATKzPJtLY68L+L4InnG1RJkp8
         0WlhmQV8WBOuIAubDjxU9qbyfsEMmtOZP1rscYahFNj8gC0syVto3LqMtn44zZtf2aKF
         cVtihztfOkFIvTJvTx0fx/sstqrJjQmrsyrqysEfP2w4JLgecDepmVK/Usg230xBGE5p
         YnOUDVuNrOiop+T739Po4U+70Ur7cPWR3q2uzyL6hqjIAQhjeTzZ6zF7IDs2Ku9+B2QH
         rfC3gvNVxleoH0tlqlNlbw1AkydguXwy33Cub0E86lJ5LPut95oEK1NM/VUVx7JAMhxC
         W+ow==
X-Forwarded-Encrypted: i=1; AFNElJ+lmiqyeUBLslDP2xZUN7eudDBTKzR8kd0EGJDc79ZWeW7JJf3K2HYVsK+SnEfdRbQSASPCmA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaGHTfRa7oXUb7WH/vWB6bYS1YJFpX9148CKF6WTNeev3REQIX
	PwLX8E/I3uKhEMT3aXfSD7SurzJIlgok2kd2EvqSpDur75+9iGbEgCkGC1A/1YRkFrJCeuGc60V
	kr5F0eqwb0ij2BguL4BLvcYiBxSZrCRZXQsFa
X-Gm-Gg: Acq92OEVEdK+0gYN3072HKeFKcdrMAZsjp6t3HkJoBU8/+K6s/3G18IsEeivrZg35fe
	GDXRJH3U3vfluL9WNwQ5jx20i2Mubu+CVuD+7qWjUtbgEWpeAbcUSpRMbpumS0MiAtD/DHO99Ag
	IH0y6GkSWray8qDIxMMxra9ySISqnl+29mMfL0iB9kBb7PehvBJ2/OUxI1ySjzOoVOybcDhTtuv
	+PECMzdZWBiGN6NzMYgerL/CPA3t+XVxZg/qJKqo0Hw4qmkuj2HFgqRiMNi1LsmSrVI9rO0Umgh
	Oyj+l2klbUngDrOP0PFqvbM=
X-Received: by 2002:a05:690c:e1d8:20b0:7bf:424:bf6b with SMTP id
 00721157ae682-7c6a9f2df4dmr5357877b3.14.1778620953441; Tue, 12 May 2026
 14:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142709.2298255-1-ameryhung@gmail.com> <20260506142709.2298255-9-ameryhung@gmail.com>
 <cfdb2d4af893d70bcb15bcc22d6467f800b7291f.camel@gmail.com>
In-Reply-To: <cfdb2d4af893d70bcb15bcc22d6467f800b7291f.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 12 May 2026 23:22:20 +0200
X-Gm-Features: AVHnY4KL5O_WnB5HWg9pGPB5V8Psv_hjQSNaVwa-FNe_x5m6XeUyNhDo48F-8aQ
Message-ID: <CAMB2axO3pL5uCLL-=Ov7Nnyf7_=8tL+j0vUNHRV=Z8EFg66hyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 08/12] bpf: Unify release handling for helpers
 and kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2160452A3A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287324-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 1:20=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2026-05-06 at 07:27 -0700, Amery Hung wrote:
>
> LGTM, one question below.
>
> > @@ -8010,28 +8010,15 @@ static int check_func_arg(struct bpf_verifier_e=
nv *env, u32 arg,
> >               return err;
> >
> >  skip_type_check:
> > -     if (arg_type_is_release(arg_type)) {
> > -             if (!arg_type_is_dynptr(arg_type) && !reg->ref_obj_id && =
!bpf_register_is_null(reg)) {
> > -                     verbose(env, "R%d must be referenced when passed =
to release function\n",
> > -                             regno);
> > -                     return -EINVAL;
> > -             }
> > -             if (meta->release_regno) {
> > -                     verifier_bug(env, "more than one release argument=
");
> > -                     return -EFAULT;
> > -             }
> > -             meta->release_regno =3D regno;
> > +     if (arg_type_is_release(arg_type) && !arg_type_is_dynptr(arg_type=
) &&
> > +         !reg->ref_obj_id && !bpf_register_is_null(reg)) {
> > +             verbose(env, "release helper %s expects referenced PTR_TO=
_BTF_ID passed to %s\n",
> > +                     func_id_name(meta->func_id), reg_arg_name(env, ar=
gno));
> > +             return -EINVAL;
>
> Nit: a similar check is added in check_kfunc_args(),
>      can these be wrapped in some utility function?

Make sense.

>
> >       }
> >
> > -     if (reg->ref_obj_id && base_type(arg_type) !=3D ARG_KPTR_XCHG_DES=
T) {
> > -             if (meta->release_regno && meta->ref_obj.cnt) {
> > -                     verbose(env, "more than one arg with ref_obj_id %=
s %u %u",
> > -                             reg_arg_name(env, argno), reg->ref_obj_id=
,
> > -                             meta->ref_obj.ref_obj_id);
> > -                     return -EACCES;
> > -             }
> > +     if (reg->ref_obj_id)
> >               update_ref_obj(&meta->ref_obj, reg);
> > -     }
> >
> >       switch (base_type(arg_type)) {
> >       case ARG_CONST_MAP_PTR:
>
> [...]
>
> > @@ -9825,7 +9883,7 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
> >       memset(&meta, 0, sizeof(meta));
> >       meta.pkt_access =3D fn->pkt_access;
> >
> > -     err =3D check_func_proto(fn);
> > +     err =3D check_func_proto(fn, &meta);
> >       if (err) {
> >               verifier_bug(env, "incorrect func proto %s#%d", func_id_n=
ame(func_id), func_id);
> >               return err;
> > @@ -9870,37 +9928,11 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
> >       }
> >
> >       if (meta.release_regno) {
> > -             err =3D -EINVAL;
> > -             if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - =
BPF_REG_1])) {
> > -                     err =3D unmark_stack_slots_dynptr(env, &regs[meta=
.release_regno]);
> > -             } else if (func_id =3D=3D BPF_FUNC_kptr_xchg && meta.ref_=
obj.ref_obj_id) {
> > -                     u32 ref_obj_id =3D meta.ref_obj.ref_obj_id;
> > -                     bool in_rcu =3D in_rcu_cs(env);
> > -                     struct bpf_func_state *state;
> > -                     struct bpf_reg_state *reg;
> > -
> > -                     err =3D release_reference_nomark(env->cur_state, =
ref_obj_id);
> > -                     if (!err) {
> > -                             bpf_for_each_reg_in_vstate(env->cur_state=
, state, reg, ({
> > -                                     if (reg->ref_obj_id =3D=3D ref_ob=
j_id) {
> > -                                             if (in_rcu && (reg->type =
& MEM_ALLOC) && (reg->type & MEM_PERCPU)) {
> > -                                                     reg->ref_obj_id =
=3D 0;
> > -                                                     reg->type &=3D ~M=
EM_ALLOC;
> > -                                                     reg->type |=3D ME=
M_RCU;
> > -                                             } else {
> > -                                                     mark_reg_invalid(=
env, reg);
>
> Note: release_reg() does not have this 'else' path, but it seem to be not=
 a problem,
>       assuming that MEM_ALLOC | MEM_PERCPU registers are generated only f=
rom some
>       other cmp_xchg call. Is that the case?

AFAIK, percpu allocated objects (i.e., MEM_ALLOC | MEM_PERCPU
registers) only come from bpf_kptr_xchg() and bpf_percpu_obj_new(). We
don't have a mechanism to derive registers from percpu allocated
objects such that we need to mark_reg_invalid when calling
bpf_kptr_xchg().

If there is such case in the future, maybe we can do the following in
release_reg() then

        if (convert_rcu)
                err =3D ref_convert_alloc_rcu_protected(env, reg->ref_obj_i=
d);

        if (release_dynptr)
                err =3D unmark_stack_slots_dynptr(env, reg);
        else if (reg->ref_obj_id)
                err =3D release_reference(env, reg->ref_obj_id);
        else if (bpf_register_is_null(reg))
                err =3D 0;


>
> > -                                             }
> > -                                     }
> > -                             }));
> > -                     }
> > -             } else if (meta.ref_obj.ref_obj_id) {
> > -                     err =3D release_reference(env, meta.ref_obj.ref_o=
bj_id);
> > -             } else if (bpf_register_is_null(&regs[meta.release_regno]=
)) {
> > -                     /* meta.ref_obj.ref_obj_id can only be 0 if regis=
ter that is meant to be
> > -                      * released is NULL, which must be > R0.
> > -                      */
> > -                     err =3D 0;
> > -             }
> > +             struct bpf_reg_state *reg =3D &regs[meta.release_regno];
> > +             bool convert_rcu =3D (func_id =3D=3D BPF_FUNC_kptr_xchg) =
&& in_rcu_cs(env) &&
> > +                                (reg->type & MEM_ALLOC) && (reg->type =
& MEM_PERCPU);
> > +
> > +             err =3D release_reg(env, reg, convert_rcu, !!meta.dynptr.=
ref_obj_id);
> >               if (err)
> >                       return err;
> >       }
>
> [...]
>
> > @@ -11609,18 +11640,16 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_kfunc_call_
> >                       return -EACCES;
> >               }
> >
> > -             if (reg->ref_obj_id) {
> > -                     if (is_kfunc_release(meta) && meta->ref_obj.cnt) =
{
> > -                             verbose(env, "more than one arg with ref_=
obj_id %s %u %u",
> > -                                     reg_arg_name(env, argno), reg->re=
f_obj_id,
> > -                                     meta->ref_obj.ref_obj_id);
> > -                             return -EFAULT;
> > -                     }
> > -                     update_ref_obj(&meta->ref_obj, reg);
> > -                     if (is_kfunc_release(meta))
> > -                             meta->release_regno =3D regno;
> > +             if (regno =3D=3D meta->release_regno && !is_kfunc_arg_dyn=
ptr(meta->btf, &args[i]) &&
> > +                 !reg->ref_obj_id && !bpf_register_is_null(reg)) {
> > +                     verbose(env, "release kfunc %s expects referenced=
 PTR_TO_BTF_ID passed to %s\n",
> > +                             func_name, reg_arg_name(env, argno));
> > +                     return -EINVAL;
> >               }
> >
> > +             if (reg->ref_obj_id)
> > +                     update_ref_obj(&meta->ref_obj, reg);
> > +
> >               ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id);
> >               ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
> >
>
> [...]

