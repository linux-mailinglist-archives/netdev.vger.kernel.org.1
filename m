Return-Path: <netdev+bounces-280887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kA3AGmGh6mlF1gIAu9opvQ
	(envelope-from <netdev+bounces-280887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:46:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C621B458361
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DA963016900
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 22:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DBA3385A1;
	Thu, 23 Apr 2026 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hUQ7Hbix"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC4B3093CB
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984411; cv=pass; b=s7YTaKdmyLK7UZ2Cmms6EFMlW5SEJ7HACI8Siw3MBqK/VbdraXjfKTI7lWnzRiJ4MNhSlU/kl+ZlaFEPun8zS0zZWzpIKr5K0Os+kbLibwlDZITNHETQudO1UPrKQhxgEeWTfG6jzq4kJKxby5mq+EoPkrUYAhryPoHCzrqqe+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984411; c=relaxed/simple;
	bh=Wxr23wANLnnyuzn218fgcEsk3niAu/vPTkNHqBH3Tn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOKfBBc1YTNwzLfbb9XGYLDjfqxhSyxnMK8GqzygXWGw6PyACQ1cOYs4NmRCVh1acVYM3bXCrXDyFZ5UelLeCdAlMnF7BAB8hJIuXWdUwC97TJ64hFJitS6uBFHIGGSvznmV8X00FzwEIz1GdIOpG13UWAkfwRRmHzi5O4vnx+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hUQ7Hbix; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 63NH8lC01998188
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 15:46:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=PquePwN2z+FIAknp17G21flfgP6AWqZXSQwJJptNxF8=; b=hUQ7Hbixk7KH
	V6p3ES/P2a8CUtPmNt74t2cfuKABvfu/m4D6tbVY5gJFj9eJ/n3+/iJQWTVArvg/
	oMqQVJ95qtjzKP32JCFVknOAexBRDj6Mffc7oJ5QInNnJhytcy2KTnv6notZJeEr
	k0j7rbuOZ+ELiPyAddoRU/DteHRQnxXE7Q6qu1e5SKVCpdCr6MkdXCA5t6Yuy7sV
	iqxBpub2msTYWRBiu5ecNK90BXZB0calftezHQR5aB/iqFzdFZSYtVp8nwE1WH60
	w5hHU4VPDIZ1gHuPhwWch+XnA48N/04PWW0oPI9beYdQn+hd/m+6t2/MmJVqAlp0
	P7NU/bVRyA==
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	by m0089730.ppops.net (PPS) with ESMTPS id 4dpepafnqe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 15:46:40 -0700 (PDT)
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ba84b4c7130so460106166b.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 15:46:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776984399; cv=none;
        d=google.com; s=arc-20240605;
        b=T3wHAQ9a75+XbOrBa91MNy5hFqWHwRxOUQjapZM/6uPK4Y+ZcHtU4SREotGIPRTY2i
         APeOz/1Ej2DitO7J5Q1VZ+a+fVohsFvSudioyXMJbPHFMCZeBz1Ow04Q9WW8Ux7p+x5V
         pSmyfWjSPCRBT2M0b9jmpDnWqx76KRXPqZQjArTeMpTnl8BBkJG0xFRUkTV6u+gi4N6W
         SvsLJyc9mH/o5QBf9IfZeZFmnU3ERHb4J5Q35MLQTzLx4bQXK+qF42U/zcUIavNuTG+a
         +mRhzviILjn2uxq1NkCjk0uVKFDtfA9qMHArhe7AEHyLsd+tmgYJGBzWJpdUkBEBoSTZ
         GewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=PquePwN2z+FIAknp17G21flfgP6AWqZXSQwJJptNxF8=;
        fh=DUyFJQyizO7KQiHPMSqDotHs7GUAUqHxBeksj9YlezM=;
        b=eChilnUXJUnrDqjvtAm2qBUj0dlC4HFl9ry0Fdb44GGY9He9ZSaWdbQ71Yv0TFUcgK
         xWT1s34CCQGPPTYK2h4K2s/Xc5tFYcRtEjT3x2pzJ/G8m/Itwd5imirOgKKM5oY670oh
         S/z74Fmez+Jd7IT0iaW9kcAsN+NFawsBccnCcHASNAYQia/sc5yewhw40GWEf5XH1b9J
         7Z3BF6NbbS3KXl34Aq8zkWSlBkOillkMGYhtapwPH/BhoK3A7qAwLGZstTO606UvTGFd
         G/mUe38WzndmfLtfs3JLF+zfuZeBHVzIazn1MRsEmaMZBacJUlvNEXkroBQIuJZsPpij
         0C9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776984399; x=1777589199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PquePwN2z+FIAknp17G21flfgP6AWqZXSQwJJptNxF8=;
        b=p1/BMliTNFSNLT8u9acxNfoQPRF1tGrwIvaG0T3KYwK3dED2dVCv0KRO4SX7xEjmo1
         6hQqSB201Ywhg8d9nDRCw4vocktbnScqMFs1tdC/nAEfkzU+E7AfowkRhcR80bhbKu4v
         ctDQsgnI8KO5Na2HZ4PRWGTg5nipmsoOnm1bxtRlOgT66luhZXdorVR3lBtAXlLM6PsZ
         OXbq9ihTitA4/GtsI8C67KX6/0f5H/TGtbE3Zp8dIh+qWetsqK7JJJM/Am837eKV3E61
         dPYtQFHLQ5s6Imr72Wei8+lKQI8SfskrJFFYv1b65aun4LAn8nU21RMOgba+dKjmXHny
         laLA==
X-Forwarded-Encrypted: i=1; AFNElJ/2+I4IjLJjD2RcGe434mBBZ6Efqbgbuo6VLt31oDquqHlHqnhl4iG17/uHsC/0zhb/85ltWIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvBxFHncwYu3w2nxuuHpMIYVHn37GIwwwFmd+Uzyg+Q6502tZL
	9j9WBXrvmm4OFE/yvL86omOFe7eLg+85XN+xgY/trynKD0g3+ILuM8M4EA8jC/QS0DziLT2092b
	64L0TrbUattoJ8PcA3btJxglwdOW64gUrIR/BhyAH7FYrT/B6zHFhFFK5FMJtGekrDtx0jCzPXS
	n9WkqUdEARvm9Y5xfKL4Ydi8BiLJMeWNg=
X-Gm-Gg: AeBDieu7EKQI4Jx5vg8NVTtW4VSr28LHuxlqBs+AfetpjkE8rm30Bh52JtNB3uOFYLn
	N/efYwp2QV9vj3iYvgJueqgb4UJow1MT0Ly8spsW0TewouZMKQZybsk/rst62fD/OPh/zl8BPla
	cZTzmpBuq7dXqf66hz1mEPUu37+tOyZUEWlY6wkr5lr/gW22TgA6yt7ehzHWyMjnIBblomuEMTC
	WH9VdzjRHNR4h3MAt2+zmSTJHYcVA==
X-Received: by 2002:a17:907:7fa0:b0:ba5:962f:9db8 with SMTP id a640c23a62f3a-ba5962fcc19mr1234842966b.29.1776984399334;
        Thu, 23 Apr 2026 15:46:39 -0700 (PDT)
X-Received: by 2002:a17:907:7fa0:b0:ba5:962f:9db8 with SMTP id
 a640c23a62f3a-ba5962fcc19mr1234841166b.29.1776984398771; Thu, 23 Apr 2026
 15:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <20260421221016.2967924-3-ameryhung@gmail.com>
 <9237d7b35463c79863488e3f2180239aab679049.camel@gmail.com>
 <CAMB2axMzeQs3WzFd1PZFB=DgR6d2ye4qzHKhATK2895ryzAEog@mail.gmail.com> <c84a7beccd4ae527981797a6e5a6af840ba9c312.camel@gmail.com>
In-Reply-To: <c84a7beccd4ae527981797a6e5a6af840ba9c312.camel@gmail.com>
From: Amery Hung <ameryhung@meta.com>
Date: Thu, 23 Apr 2026 15:46:24 -0700
X-Gm-Features: AQROBzC1De56wmESn2eT6JrBcX_snpphIjr5o2acJR5S3Bb8bBEZf2if_Th2DN4
Message-ID: <CAP17u3Nh=_9ftdp-tA=yS5TRW7j-5Tk1PPdaDz-GZCW6k_Nvvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] bpf: Assign reg->id when getting
 referenced kptr from ctx
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
        andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com,
        martin.lau@kernel.org, mykyta.yatsenko5@gmail.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: m1aiZjAeI2klfQIWzY9U0Op_Ot41x4sh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDIyMSBTYWx0ZWRfX86hpEndJLv/P
 082xC/ExvJVDURS0ZhnNhEMQFJhLM3b7WydWpFsQZXfrDeiA6vSEbJqxfTTNzYUdYGugcETRag+
 1kECCI7tusbANejCMtyPSFuWa0WMMi6cFhpNhsQTR8+tEJrNsEznt1gh8Pd7nocSUZwnMmoG3m4
 1Enk56FbOk0E3rGo5EkKI8JieXyOxFtanT8YPiskD2dOGqSrn0VyYvepbbE9tcA9D60wfJsQu+S
 fmUsr9qGO9cGemPt5t41ZBwq1CeiM8kP8DwPRS7yPpGNMnpPDrnmiYmJ9jzqYdBCFr5pXBXc+yV
 V5+SkfYP9Jsf50+6VUYZj5MXt5LsPgqbcx3JKwZD/B0YZF0dcjBlHFTaE23orwSFeLRUsWErWV9
 vlyLLHiy1SJEdW1elsp1SRM9KfyCAVSgobbPaJlVaVRZn0GLzsNjBhWFQqtm9UPo0GUs8JjGc1M
 2NsIW4IMVGgmkpo/8wA==
X-Proofpoint-GUID: m1aiZjAeI2klfQIWzY9U0Op_Ot41x4sh
X-Authority-Analysis: v=2.4 cv=MIJQXsZl c=1 sm=1 tr=0 ts=69eaa150 cx=c_pps
 a=Ak8bExYEjeps3Jj0Zi+cTQ==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=pGLkceISAAAA:8 a=rXDmgZ6x93T5uffNZgUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-280887-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C621B458361
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 3:50=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2026-04-22 at 15:45 -0700, Amery Hung wrote:
> > On Wed, Apr 22, 2026 at 2:46=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Tue, 2026-04-21 at 15:10 -0700, Amery Hung wrote:
> > > > Assign reg->id when getting referenced kptr from read program conte=
xt
> > > > to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track=
 the
> > > > referenced skb in qdisc programs using a new field reg->parent_id i=
n
> > > > a later patch.
> > > >
> > > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > > ---
> > > >  kernel/bpf/verifier.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 41e4ea41c72e..93003a2a96b0 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -6448,8 +6448,6 @@ static int check_mem_access(struct bpf_verifi=
er_env *env, int insn_idx, u32 regn
> > > >                       } else {
> > > >                               mark_reg_known_zero(env, regs,
> > > >                                                   value_regno);
> > > > -                             if (type_may_be_null(info.reg_type))
> > > > -                                     regs[value_regno].id =3D ++en=
v->id_gen;
> > > >                               /* A load of ctx field could have dif=
ferent
> > > >                                * actual load size with the one enco=
ded in the
> > > >                                * insn. When the dst is PTR, it is f=
or sure not
> > > > @@ -6459,8 +6457,11 @@ static int check_mem_access(struct bpf_verif=
ier_env *env, int insn_idx, u32 regn
> > > >                               if (base_type(info.reg_type) =3D=3D P=
TR_TO_BTF_ID) {
> > > >                                       regs[value_regno].btf =3D inf=
o.btf;
> > > >                                       regs[value_regno].btf_id =3D =
info.btf_id;
> > > > +                                     regs[value_regno].id =3D info=
.ref_obj_id;
> > > >                                       regs[value_regno].ref_obj_id =
=3D info.ref_obj_id;
> > > >                               }
> > >
> > > Hi Amery,
> > >
> > > Could you please help me double-check my understanding of this change=
?
> > >
> > > It adds a new behavior, if struct_ops method parameter is annotated
> > > with __ref, then if a field is read from such struct_ops context
> > > the destination register would now have it's .id =3D=3D ref_obj_id
> > > allocated for the parameter at the beginning of do_check().
> > > E.g. for `rB =3D *(T *)(rA + off)`, if `rA` is a pointer to struct_op=
s
> > > context and parameter corresponding to `off` has `__ref` annotation
> > > the `rB.id` will be assigned, contrary to old behavior, when it remai=
ned 0.
> > >
> >
> > Right
>
> Ack, thank you.
>
> > > This change in behavior, however, becomes visible only after the
> > > changes to release_reference() later in the series.
> > > There the `rB.id` is used to initiate `mark_reg_invalid(env, reg)` fo=
r
> > > the `rB`.
> > >
> >
> > I probably should mention it in the commit message. The purpose of the
> > patch is to make the implementation consistent with the design:
> > parent_id tracks the id of the parent objects.
> >
> > Without this patch, it should still work since in this case ref_obj_id
> > always equals to id. When release_reference() is called on a
> > KF_RELEASE kfunc, the children objects will still be invalidated
> > correctly.
>
> bpf_qdisc_fail__invalid_dynptr_cross_frame.c:invalid_dynptr_cross_frame
> fails if I comment out the line `regs[value_regno].id =3D info.ref_obj_id=
;`.
> The added .id link is used to propagate invalidation triggered by
> `free_skb(skb);` to  `hdr`.
> The patch seem mandatory for the series.

Ah yes... because an skb dynptr do track parent's id in
check_kfunc_args(). Thanks for the correction.

ret =3D process_dynptr_func(env, regno, insn_idx, dynptr_arg_type,
                          meta->ref_obj_id ? meta->id : 0, &meta->dynptr);

