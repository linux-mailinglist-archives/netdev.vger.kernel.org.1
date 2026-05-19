Return-Path: <netdev+bounces-289604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDfwJoPFDGp2lwUAu9opvQ
	(envelope-from <netdev+bounces-289604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:18:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F77C58493B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D00F93029457
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520443BB13D;
	Tue, 19 May 2026 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcjfbkiW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289213B9DAC
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 20:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221883; cv=pass; b=cKrTYGVfzlPcETcvI29Qn/8GXq8eUGVvFweIiA/sWHTRhfalwTjjtHsV8t3RiBotivlrr4LFBRzPgQR+wiegRusmPz0cs9d7Z9rsTaKkGiDgtTjOXxCr+rCL0SBw/q6NDbOZsxj1Wx3qzI3xeWEYNznASgiFp7oBh0vxKgWcGbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221883; c=relaxed/simple;
	bh=959ecGSQOyj9LzHHwylEt6lV1ltX7MjF7+EsFpGgheU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7XO062sqrw3cR6A6REDlaVEF6ya6eqw10I2eV/UTMb0mOsGHOEUCv76FH51AncJLWVq86HJOvyznAzZQiosYpolbsqvhtlA5EGcqVaFWWhQ4mK/g6Fe0iqXZp0qKW6nZL8t33Swr3O0C5HZ+gNfA/dvtEHEJ/xgNlQO3iG+2HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcjfbkiW; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bdec52f48dso33912367b3.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 13:18:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779221881; cv=none;
        d=google.com; s=arc-20240605;
        b=EZV78dYgwZm6DUdQZhcotf/srUOI1rEGD9ATHQKlZGWpf0e2eob49mhtBGoR02VLbA
         rFUNHLV/YemdmG1P8MxiL8Y/zy9V3lFgZC8P6MZzihB4QnlknXwEAQ7WMagCQWstHncV
         A/WCpGBW0l36ndJshhNaaiWTkgjn8h+3GgLRC9QpaeK/I6NhiAhJ9Pw2xt6nXAS6zoS6
         tP8gvOghtxNIBV/q0OmHb+YR0Q8Cjd9rpQv3ZhTHUlcnDpdeE/59XAb9DaPgBL5TZa4x
         903mb6YJCoi/h6V7P7yInkfwkRJg0be8UW0anHGjjIYdh29NW3lxuDpgtpYFR6Syy7oc
         5w3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AeQJ/g2xW7OKfdXt1dZh7JNahioYNHjsulaXSVovxmU=;
        fh=9TAK1wRZcnVE4LgMtTy1l8EEJc8m7s/7BlqkyQTzEzg=;
        b=JYuCmTaVjAMih6cXMg3yMlwGvRSvvACseuHbj0PZdkPWKGC8SM07D66uBpGE+h5BVa
         vSWUY/58N8v0LjJ3dbBvEtMxROY4ih9CnhR2PG1hVpcizVzDY6Q5Mj5TpKoh2Cn3Phsk
         0GKA0SxOpXk8gEEIPkhJCw7L3ujo2UBkL+TpABkC4hHnES56pYld4l4v6ytHMlEf84+2
         eHxDSMCFGc55c4sLLGRyVWMuRUtHIQ6/tEKKuMwIalKeJNVff6Ahlm2jrsf8y97ciFsj
         h12UkGT7Y7w8qCFT1t/l9L5GeoUoq+pyPYro3XIH8DFB+WT3+K2sxdrYlV3wXc/qsSpd
         0zPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779221881; x=1779826681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeQJ/g2xW7OKfdXt1dZh7JNahioYNHjsulaXSVovxmU=;
        b=mcjfbkiWlNKLpSboUD0y3Xxy945zeKeoClNNTYWUVwqA1Mxf/RXX76h7q+T3gMSclK
         gFyGhzK7VCLiJ95QC3IFbucbWZLa+2o0P/IbQj+cqWMGkKPrsLhpqe4j7h7vxrSN0/ia
         cKauIskidi8pl3aMAT17BTz8qugn0Gw19LV48Kf+MGcAmGADBTyz/f9DDk4wd3hOcqmH
         aDEfeO/IdKLsUh7/ocfhj4tXHlUC85kmgelh8TXMdoQGQJEs4WmRA8DrBci/vkzzkAoW
         bsILRvMrXg+txOatPvypM7PifiYaME5gM6WO5x20drFP1LT7ZNKSteM3RvlUzxUUT4V3
         kuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779221881; x=1779826681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AeQJ/g2xW7OKfdXt1dZh7JNahioYNHjsulaXSVovxmU=;
        b=F6hNt+0r2XdSoIEXeddx/j0DKqpqQfLADz+aW1j2CX/n1aAewQDQwl99+zwQGrMvlf
         lVO4o6vpXA7ooS5EuEkRBX8reo10oV8q1dgqe+fYGQIv74DVtaZRGcgWTajPAG8UwKb8
         x5piFCvFOQE7doJjxVwzG3hgt3WTV7rxO49zU4c8DRwc3wVUcO/QoykLqC52Inh7BsTt
         NbxxtrpzzTNmMbn9NBCADMQ+tY0JgisftgwPeXIzTW7Vs7PeQMMUmueW3BKNK0DTSY+Q
         wWubSOKpaXNTpmkC9+QqEY/L46gZFui/L8r6UnxUs3od6/rO4FGdAzDAZHKEAeIYxKKS
         nSew==
X-Forwarded-Encrypted: i=1; AFNElJ+QJ0nHuM1jE8ABanwVp5yeWelOBBKfCKBf1c+bKpZscaM7nvrztut66wt65F9ome7Cw9RUdoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyH9pHzbGWua4VUB6jVRyli3tflbuZbXSO4DrNEu8c8ftNmJKb
	7Lz95AF3EWtyK+RB4THw8bAfZG9g+UGZ8o1tzDtWHB2REifelAK8BRTrhT+S5o57wE/9KK7jenT
	hljdN8bJgsugITi+AsKnbKuwyOfCG9qc=
X-Gm-Gg: Acq92OEyOaGRzlVUqedEIeUahn/+GOw+wIdFz0qnTVyPenJMy33ma/hGmN8O3XGisW6
	axLqA2QFcg/MGMsxCySZxL7NT9pqTCpBruxI3fHXtea+3AFsGM2fW7ZpvzM/FQhk4WR8qj0BHo9
	jU2UMto28K4jdbJj7dKOs92y9A5ZhG1NM5nQCR5tOvDWTC6FWeLVfYsjWR2vVnB+KQHUJ/t6fol
	bZ4hEGMfj6gOFqFFVr7amy7i3dIZkhgOe3ZrwEvLAlXoy3n6f6D3oU/pYCa3tah/Fhg4lWKdNHB
	5pEWL05GyrBO9dycG7Tg
X-Received: by 2002:a05:690c:e566:b0:798:5213:d90e with SMTP id
 00721157ae682-7c949cc03c7mr149969607b3.25.1779221876361; Tue, 19 May 2026
 13:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519181314.2731658-4-ameryhung@gmail.com> <2835fc606f98829230b388fc8c904e7ed52300b2b13e3c9368ec6449d17f5645@mail.kernel.org>
In-Reply-To: <2835fc606f98829230b388fc8c904e7ed52300b2b13e3c9368ec6449d17f5645@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 19 May 2026 13:17:42 -0700
X-Gm-Features: AVHnY4LOBIDu-OBUrVT8f--7dFCyYDTwkTr2rraD8hCw_C5sOM4z1o0c5f2AoTI
Message-ID: <CAMB2axPm6GUqSdjT49GxSjseuP+RHXMXSOnouBrSUwYiVYrzCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 03/14] bpf: Assign reg->id when getting
 referenced kptr from ctx
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com, 
	ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-289604-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9F77C58493B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 11:56=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > bpf: Assign reg->id when getting referenced kptr from ctx
> >
> > Assign reg->id when getting referenced kptr from read program context
> > to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track the
> > referenced skb in qdisc programs using a new field reg->parent_id in
> > a later patch.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
>
> During the v3 review on lore, Eduard Zingerman noted that this patch is
> mandatory for the series because the .id link is needed to propagate
> invalidation triggered by free_skb() to child objects. Specifically, the
> test bpf_qdisc_fail__invalid_dynptr_cross_frame.c:invalid_dynptr_cross_fr=
ame
> fails if the line "regs[value_regno].id =3D info.ref_obj_id;" is commente=
d
> out. This invalidation propagation aspect is not mentioned in the current
> commit message.
>
> Reference:
>   https://lore.kernel.org/bpf/c84a7beccd4ae527981797a6e5a6af840ba9c312.ca=
mel@gmail.com/
>   Date: Wed, 22 Apr 2026 15:50:52 -0700
>   Reviewer: Eduard Zingerman
>
> Could the commit message be updated to mention the invalidation propagati=
on
> requirement?
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 564679f70afd..441950b43a4c 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6209,8 +6209,6 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, struct b
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
> > @@ -6220,8 +6218,11 @@ static int check_mem_access(struct bpf_verifier_=
env *env, int insn_idx, struct b
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
> > +                             if (type_may_be_null(info.reg_type) && !r=
egs[value_regno].id)
> > +                                     regs[value_regno].id =3D ++env->i=
d_gen;
> >                       }
> >                       regs[value_regno].type =3D info.reg_type;
> >               }
>
> This looks like a bug fix for the id generation logic introduced when
> support for may-be-null types was added to the check_ctx_access path. The
> issue is that when getting a referenced kptr from program context (PTR_TO=
_BTF_ID
> with ref_obj_id), the code was generating a fresh id for nullable types b=
efore
> assigning ref_obj_id, causing inconsistency with KF_ACQUIRE kfunc behavio=
r
> where reg->id is set to info.ref_obj_id.
>
> Should this include:
>
>   Fixes: 93c230e3f5bd ("bpf: Enforce id generation for all may-be-null re=
gister type")

The inconsistency is not a bug. It is only needed later when I added
reg->parent_id that track reg->id. We do not need a fix tag here.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/261166=
80637

