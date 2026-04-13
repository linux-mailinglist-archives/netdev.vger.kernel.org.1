Return-Path: <netdev+bounces-278220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJdCMkZw3WkgeQkAu9opvQ
	(envelope-from <netdev+bounces-278220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:37:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F72A3F3F0A
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 789C130179E0
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56B139B4A1;
	Mon, 13 Apr 2026 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZmb/lT4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8300E3914FF
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776119758; cv=pass; b=MeFHkHxejWuYae2dTTHwB8nuiAvqNHn3nh99sh5h8S7z55TDN1OoKOgys427PFkhc39EI6IA6/fxupPdi1w8tZ9PIGXVa0g77ct4V5J1gRlKw/ecCrGte60N6jfa+A/IK2+nM0594/KTQzxrTc8qbqwnZImOqlBPS0jeoO0r/cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776119758; c=relaxed/simple;
	bh=tlM/UqpzwAkG4897Z9KkIFpRqSA94khz+tUFrWPsFzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFxrKl0ZDx7ztaRCodRVtKmBVu93TMNQXEtBG9q//o2flOyz/blxAyk3wtxS3skDhrSTzNo3f7XAm0Sf4lBTZuTuc46/9p8MBKABByGrNw7csmLxcB5o1px2Nm/lkrQpiVtcKAC6kXRey4uyaOqjMnY+HlJm/WY2Hnc61oLTH7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZmb/lT4; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7b37d84a6b3so14487537b3.2
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 15:35:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776119756; cv=none;
        d=google.com; s=arc-20240605;
        b=dgQAkwj1HRxGo0bFmWSJQ8zRRgKLiPlRod1up0tz1Umx2ZGin1Vi4N6lNzJzhWOwNp
         b26YIee3/HNRIgkCiYdcSKnXqgymLjg4l6NkNGy3j8sCNCWbwxwzmGUNpmkoM+WeO6I3
         fixmwKggbHhZChHiD1bl1hSroeZwkBHwlaOswZw3YEyvMT5pzNNEhE/z922CWsOixVhw
         Hk53/eSs4ZADCAp2tXEeknpzD25MTEhcLytL/6sVcWZAi5+qF2yb6sAPr20cnd+eeSnH
         /jSWKVVzOvRtfJMKS61kB5PwAOVNzZTR22ujsa4d8Fv+t0avHEEkqYrAG91lRVxZUwCy
         o4Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LAtnQ5/+5avspTyva2/r2vMsULn41s5x0aE/zBra4io=;
        fh=VHkWkYlxKX3Opyenv3RfEKbwbkthm87HyjvPCyiNe8w=;
        b=hKljCX1lYfAf9lCwTq/nxVWwEPnyVf6JiRDmkRURUIrfv2KsRyTJFmqvwaZwzBfIoA
         My0h/6tKfyUH1uoiJ1vgT09Lm2vQAGmFLxkPvn8TDqnhVYbg3dl5WhE9+g7YKE9esXVy
         xumxSUTC0VlfTv3qglXpvg1nEvwdRcfeRNpENXR1nir1hBGAXaiaZTMIO8y6sD6N3DLK
         7Lko73BllTSJ9e5TQH4sAMN2vagiYctWRUgYveOwRXhMGcSNixlaVf15kEODK5Ko2rfP
         LlUhfGbYNb8BPJY2QSveWwquYkCnRqQtkHlWx/MEisj5Y1QM32wtnz8ckgYdsgVGbKG0
         ED1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776119756; x=1776724556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAtnQ5/+5avspTyva2/r2vMsULn41s5x0aE/zBra4io=;
        b=hZmb/lT4BuO6Q8cM78TxlJ0bT7AEbFo3WqrGmv35+c4vNeOz7Ta4zqh+NFGAPUZJoZ
         9TEHF544ZO6rKyVg6ndJ8MZ3GVtDuCDHBJyUAP+c8eONNHUnO3pEiNKJEkw0zysHEFSW
         5wJ846a3McWFgYfFTpeEXMksIbY5LgEbvXu/bAnFN5GGT2X5Q34F41Y2Fya596356qjg
         DDKEecljd4iCsk5UeNRoFrAhuZh6uXnQssIidfQ0Hj3bH4GWx1q84AP0ZRe4lwFtNV6K
         YqErIlySmCU4aMSr0SHMFHgnEY4TuzWv1m3dA4ad0++632K4Qmri05iTODIHlvzkckEW
         D/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776119756; x=1776724556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LAtnQ5/+5avspTyva2/r2vMsULn41s5x0aE/zBra4io=;
        b=amlHGrhO+FS2vUajYhe27uOMu1Ymic4rUJ5uEqariCHRSSOwzmxOwPs69P0mbIn1fN
         Z5jOOeEQ5tCsoaDlE3GeMNEqRqukCDEjage6DyOyRgV3rEinThbLwhNiKQwErpACn6xq
         5K10tiUbKNVwgnxVKD+tYVQApYiYYJ0EzNhBTgwgxaIDjb3/2f+de6UsNRaHBgn9v6km
         0AS4NF6rIRtr5QSLU2T08NYa4jkP2DRnggOeYRvfaNNxPs9uela7j9/T24HtVPHLvvPm
         tYEnm1cN5qRcdK9Gmw2b0irk4WWeGIzr80OWPHcbm+ey7NSOR4AMm9kwQSDVtKtxHapI
         HjVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9n3PnjPTT509AJltNcHhhKVhAiuO9wNCGWzzyIX1nWFlUeKtW/5feG9OZvCNrr7IQSuGVv/BA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwpY7UbSsXqbvfQdRFjYj9NEkZonM80sAM/DB1zqFj80YAJ0hm
	+zEUZSliCxgiLVi8oeMyy1vCPZrXO4gJkXfTBl2/K41kS70sd/dV8W0H7V2HS5/DXBbJQ8Xs1xR
	IlR7Hq5CBoXV45P9pQjTo6ryh9BF4+Cw=
X-Gm-Gg: AeBDieuxRBsGnv3sk6BWmm1mOWEfrlU8NkoW9Ywo5ou9B1+y78dtOR1mL+yfM2H/uU4
	nSuGy0hydf+DHxarYH5IAsM2ayaaKpJ7qqQxGgKTFX6eac8b596ZUgpCWenmiDPzvmkkaVVIoRX
	VCjwb/3x4KDr7ThRbmN0/w2lUE9kAmt1r/NakGL3vK3gb3nJQqEeLGAoSez4CrmOq1av1ClO3SZ
	RBjdtDm1WPoCGhD+MlAmMMoPfycDaVhvTovDaFlEl1ud4KK0T/hcWpmXueZnqLFEn6eDYiMDpjm
	5AUd2Yc=
X-Received: by 2002:a05:690c:8:b0:7b2:6b19:df2b with SMTP id
 00721157ae682-7b26b19ec84mr77916157b3.17.1776119756463; Mon, 13 Apr 2026
 15:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402065013.884228-1-ameryhung@gmail.com> <20260402065013.884228-2-ameryhung@gmail.com>
 <123ccf9c-a6ec-496a-872d-965e46d07d51@gmail.com>
In-Reply-To: <123ccf9c-a6ec-496a-872d-965e46d07d51@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 13 Apr 2026 15:35:44 -0700
X-Gm-Features: AQROBzCw9vgbGeZQLc5RlQC3MjwVA40A0NB8aiUJTHHOHriGRGrMCK771PsmiNs
Message-ID: <CAMB2axME=jJ2=0E0wSVLbCFpH4FeGFHvCugij-ZzYNw2L2rWCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] bpf: Refactor dynptr mutability tracking
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, eddyz87@gmail.com, 
	yatsenko@meta.com, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278220-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5F72A3F3F0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 9:05=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:

> > -__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_=
dynptr *digest_p)
> > +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, const struc=
t bpf_dynptr *digest_p)
> >   {
> >       struct bpf_dynptr_kern *digest_ptr =3D (struct bpf_dynptr_kern *)=
digest_p;
>
> maybe we can make this digest_ptr const as well, otherwise it's a little
> bit strange to introduce const, but cast to non-const kernel struct
> immediately. I think we can apply this in other kfuncs.

Good catch. Will double check other instances.

>
> >       const struct inode *inode =3D file_inode(file);
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 05b34a6355b0..329b78940b79 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -3621,8 +3621,8 @@ static inline int bpf_fd_reuseport_array_update_e=
lem(struct bpf_map *map,
> >   struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags);
> >   struct bpf_key *bpf_lookup_system_key(u64 id);
> >   void bpf_key_put(struct bpf_key *bkey);
> > -int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
> > -                            struct bpf_dynptr *sig_p,
> > +int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_p,
> > +                            const struct bpf_dynptr *sig_p,
> >                              struct bpf_key *trusted_keyring);
> >
> >   #else
>
> ...
>
> >               err =3D mark_stack_slots_dynptr(env, reg, arg_type, insn_=
idx, clone_ref_obj_id);
> > -     } else /* MEM_RDONLY and None case from above */ {
> > +     } else /* OBJ_RELEASE and None case from above */ {
> >               /* For the reg->type =3D=3D PTR_TO_STACK case, bpf_dynptr=
 is never const */
> > -             if (reg->type =3D=3D CONST_PTR_TO_DYNPTR && !(arg_type & =
MEM_RDONLY)) {
> > -                     verbose(env, "cannot pass pointer to const bpf_dy=
nptr, the helper mutates it\n");
> > +             if (reg->type =3D=3D CONST_PTR_TO_DYNPTR && (arg_type & O=
BJ_RELEASE)) {
> > +                     verbose(env, "CONST_PTR_TO_DYNPTR cannot be relea=
sed");
>
> \n is missing in the verbose.

Ack.

>
> >                       return -EINVAL;
> >               }
> >
> > @@ -8958,7 +8929,7 @@ static int process_dynptr_func(struct bpf_verifie=
r_env *env, int regno, int insn
> >                       return -EINVAL;
> >               }
> >
> > -             /* Fold modifiers (in this case, MEM_RDONLY) when checkin=
g expected type */
> > +             /* Fold modifiers (in this case, OBJ_RELEASE) when checki=
ng expected type */
> >               if (!is_dynptr_type_expected(env, reg, arg_type & ~MEM_RD=
ONLY)) {
>
> Do we need to update the `is_dynptr_type_expected(env, reg, arg_type &
> ~MEM_RDONLY)` as MEM_RDONLY is no longer applied to the dynptr?

Ah yes. AI review bot didn't find it but sashiko did.

>
> >                       verbose(env,
> >                               "Expected a dynptr of type %s as arg #%d\=
n",
> > @@ -10803,7 +10774,7 @@ static int btf_check_func_arg_match(struct bpf_=
verifier_env *env, int subprog,
> >                               bpf_log(log, "R%d is not a pointer to are=
na or scalar.\n", regno);
> >                               return -EINVAL;
> >                       }
> > -             } else if (arg->arg_type =3D=3D (ARG_PTR_TO_DYNPTR | MEM_=
RDONLY)) {
> > +             } else if (arg->arg_type =3D=3D ARG_PTR_TO_DYNPTR) {
> >                       ret =3D check_func_arg_reg_off(env, reg, regno, A=
RG_PTR_TO_DYNPTR);
> >                       if (ret)
> >                               return ret;
> > @@ -13718,9 +13689,6 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
> >                       enum bpf_arg_type dynptr_arg_type =3D ARG_PTR_TO_=
DYNPTR;
> >                       int clone_ref_obj_id =3D 0;
> >
> > -                     if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
> > -                             dynptr_arg_type |=3D MEM_RDONLY;
> > -
> >                       if (is_kfunc_arg_uninit(btf, &args[i]))
> >                               dynptr_arg_type |=3D MEM_UNINIT;

