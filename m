Return-Path: <netdev+bounces-280557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NW5KtNP6Wl2XgIAu9opvQ
	(envelope-from <netdev+bounces-280557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 00:46:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBC644B51E
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 00:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F85B3063D7F
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 22:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1400934FF5B;
	Wed, 22 Apr 2026 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9XqroqH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF6C156F45
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776897964; cv=pass; b=c4bmX36xUKwG+33SGCuTy+fKXD9monanFOBHcxhuJe5h/4IHix6SXxeY1uxILUDViU4d81OlQSQyYo9DpXp6JkLKTG+9zEkOcadXTEoUlh9GE0VGJndlWkyrE7s17oK6vr6gCAJo352yNlGB7iJopiWd2kOv4gABgaK6mVR0ak0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776897964; c=relaxed/simple;
	bh=A/Qoxx4G2gmi5Rql7zyl/GJMT37HnSL/uR/rJUOHfos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brItgcE35NPmXPkPobwA9BL0dc5TvNcwLW3NSU5beaQh6v5OKyAvsqu2c9HzbBhfyWRCG8cXqEAKAgWLfA45txum8MKPBv19E1Ddg0pwcGDSa//CTys9OpTqaVOPrz2ic/mT+R07MtI+2sCC0manzoYIabxxwiDxOnTwBEIRLBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9XqroqH; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-797ab169454so78749237b3.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 15:45:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776897954; cv=none;
        d=google.com; s=arc-20240605;
        b=RA36A7x68+2Va8K6qdUfYmPruBcYZ17gqKletR5AKOGm6SAA5LMSanxspUTGqK38zL
         98A9qE0fuTWNPuGCSRRTUYXzFITH682Kwyq/mf8eDQQWR2mtzIW2+rZMKUMEnnPuP0qv
         VykIN/B8FfrofVvYNpE+jUae0d0tlB9c0/XiRszKfo+ScfiLAuAyHetGc3xFS+hivO30
         4tPyuFdTD6KOQMbv0LD1E9Nz2+VMZc64DfRdiWyw4ski2lBcDZBwxWcRR+mSJII7nNC8
         /oE6njuqhFEH3uT2TAUFt/ijPBpvPH3B8uzVKDR3Z9YnE9nAQWp3cDXarX+mTYWTdaY5
         mYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=072Izvm4+mNTHXaNnuS5DC7zjKMyy2O2f09dKfQvUGE=;
        fh=uvvyVkytmAAAgezY/BSYwXWBCis9Y2732ur0SGisg5I=;
        b=cv1xmDRSzDT/3Sl9bxZpK3DCoUhRyuOiAncIKM6Aq/x5MbnbmhvKDeFQHiMDybfMzg
         ppxsflVhPttF1cKGL8Zsy7fqfWzhbNqBtKLZDedFjAYzZXhatsVGi8aagRIHxbgWtapa
         PpFBPFZfXg9ce7ANM0XG3Fah1mqRi1PTcbvLgo2NNByu1IyfKbw+IiApKfeHviqd9Yfj
         jupDEY1A7Qpv/hT5T1fT5erxdMbFqEV5l0LHd25TpQc16ziWQHzX889deST1lctBBFL7
         cengBRYlp0HMjGDVzi/IZeI0OsnuGHuH2/5ZRdC44YAM3mQWLWh4tRfS3XlB9R8Y8W8K
         3c+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776897954; x=1777502754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=072Izvm4+mNTHXaNnuS5DC7zjKMyy2O2f09dKfQvUGE=;
        b=S9XqroqHMVacfdMnxlqDC15ZoxmMG201vrP74+zA4vhqLevtyHnj9rXLlSnh++AJcE
         UnrZiiy+LJvke/Hba2lbLyci9Q3sP4D6xewcjKCESXLw3OVmo7dqvEXwD5ZkUUzGJvtq
         2b0hkUvWAvNyJ0sDo1hk1qeb1C/mqyNhZyTCcsZV+YszNHI6ejVG4NOOssBVOCuCoZxM
         0u9XuRQhHT3VeqSYykOvgIcmG3pr12olys/QUYAJY2R0G/XP9uquXwbbSrIkuCXgd4CY
         zzeRXqfihsWdBGTe7VLDot3+Axfu8WUCQvJbEU9dESowCz5HhfahZjr7v5vgPS/vh+vw
         A/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776897954; x=1777502754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=072Izvm4+mNTHXaNnuS5DC7zjKMyy2O2f09dKfQvUGE=;
        b=XqEEYDFXJRReVCYQ/XL0ESSWAh4V5bNDwVoSvwORjBRCBHwS60uaK4c72Sam3UfC90
         sr6aG5ikRRVqAzDUTswX3Vwa1N6rCM8DRe+5T2d4jV7/Ty2S/4CQ2M9XsmfXFEZoZNOP
         umBKpSVwMO7Mas5Cn+kr7A39bBtperK6o7HmBwY7IncgiswOpSygzGTW9UPteww/6/79
         9T9dw2TielujCledpscTnaTYKI9M+jySOR/yw2QyY27ny5FX36m315YTkmz2k43Hk3dv
         yL/u52m2KzNnllMG+3ti4tmHWjPr9ByFSLjBazVrSarQX/5y/oF+nGB1xOhZN99BrBjG
         0XbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/v3PwSgf7sj4I5Xn4RcAMkOG+nKoDu0rI916lMj6HfsagGIBmVAzWDhBIv77QIVXLmsz2PX1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+sl87pRRCOF4wcuhMkb32LEmsUAcMPNRpmVatQJxZI7svmp1
	lT+a2iqbNr4kXxzUyZ8zbNJHkRjYhpzbr2Iole6JHTPI9l09LJWwCKQDl5MzNOxpCIUGb4aSEJE
	TKgzXlK3GcjtIFZfGtKP6/5I0nwBZS3c=
X-Gm-Gg: AeBDievw6gz7nUnBYmzQUA4lLYHk3Nj/y7elCZNODPgOguDv8j8apq+fRUb5Lv+Bev4
	D48/Lt/qrJMglmL6DlLteyCMniCxOSvsBQJyQW/zB2l7EGfSMr6FTetEGzYLwS0NT5YK50nimuS
	M5gN4rQ3lY2RF161Xt47d/CpORppSx9g5VtcFTrP5eAmOvauq/Xjrv/taPPHAutrzGVc5hudfAH
	GBPV5LqETygrw0PKVbnlgrTQjP71V2T+Xae+IpFRzGwHUgKvKQhevApwPRPfOHQ+QvBUSqPjGtU
	LK5r8oxf6MCOcadExekP9uEV8IQs
X-Received: by 2002:a05:690c:4d0a:b0:7b7:29e4:7dcc with SMTP id
 00721157ae682-7b9ecfdc8d4mr268661087b3.39.1776897954202; Wed, 22 Apr 2026
 15:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <20260421221016.2967924-3-ameryhung@gmail.com>
 <9237d7b35463c79863488e3f2180239aab679049.camel@gmail.com>
In-Reply-To: <9237d7b35463c79863488e3f2180239aab679049.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 22 Apr 2026 15:45:43 -0700
X-Gm-Features: AQROBzAXsM892ROEM1DlXvqbk7JLvZJKqyM159SJgbzOPsMyx6s4VJcBDmdaM9Q
Message-ID: <CAMB2axMzeQs3WzFd1PZFB=DgR6d2ye4qzHKhATK2895ryzAEog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] bpf: Assign reg->id when getting
 referenced kptr from ctx
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280557-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0FBC644B51E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 2:46=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2026-04-21 at 15:10 -0700, Amery Hung wrote:
> > Assign reg->id when getting referenced kptr from read program context
> > to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track the
> > referenced skb in qdisc programs using a new field reg->parent_id in
> > a later patch.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 41e4ea41c72e..93003a2a96b0 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6448,8 +6448,6 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, u32 regn
> >                       } else {
> >                               mark_reg_known_zero(env, regs,
> >                                                   value_regno);
> > -                             if (type_may_be_null(info.reg_type))
> > -                                     regs[value_regno].id =3D ++env->i=
d_gen;
> >                               /* A load of ctx field could have differe=
nt
> >                                * actual load size with the one encoded =
in the
> >                                * insn. When the dst is PTR, it is for s=
ure not
> > @@ -6459,8 +6457,11 @@ static int check_mem_access(struct bpf_verifier_=
env *env, int insn_idx, u32 regn
> >                               if (base_type(info.reg_type) =3D=3D PTR_T=
O_BTF_ID) {
> >                                       regs[value_regno].btf =3D info.bt=
f;
> >                                       regs[value_regno].btf_id =3D info=
.btf_id;
> > +                                     regs[value_regno].id =3D info.ref=
_obj_id;
> >                                       regs[value_regno].ref_obj_id =3D =
info.ref_obj_id;
> >                               }
>
> Hi Amery,
>
> Could you please help me double-check my understanding of this change?
>
> It adds a new behavior, if struct_ops method parameter is annotated
> with __ref, then if a field is read from such struct_ops context
> the destination register would now have it's .id =3D=3D ref_obj_id
> allocated for the parameter at the beginning of do_check().
> E.g. for `rB =3D *(T *)(rA + off)`, if `rA` is a pointer to struct_ops
> context and parameter corresponding to `off` has `__ref` annotation
> the `rB.id` will be assigned, contrary to old behavior, when it remained =
0.
>

Right

> This change in behavior, however, becomes visible only after the
> changes to release_reference() later in the series.
> There the `rB.id` is used to initiate `mark_reg_invalid(env, reg)` for
> the `rB`.
>

I probably should mention it in the commit message. The purpose of the
patch is to make the implementation consistent with the design:
parent_id tracks the id of the parent objects.

Without this patch, it should still work since in this case ref_obj_id
always equals to id. When release_reference() is called on a
KF_RELEASE kfunc, the children objects will still be invalidated
correctly.

> Are the above observations correct?
>
> > +                             if (type_may_be_null(info.reg_type) && !r=
egs[value_regno].id)
> > +                                     regs[value_regno].id =3D ++env->i=
d_gen;
> >                       }
> >                       regs[value_regno].type =3D info.reg_type;
> >               }

