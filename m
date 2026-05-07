Return-Path: <netdev+bounces-285313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCweHu2H/GleRAAAu9opvQ
	(envelope-from <netdev+bounces-285313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:39:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1ED4E84C4
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 058DC30078A7
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 12:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5163C65F0;
	Thu,  7 May 2026 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxsZSBGV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C470C3AB29C
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157546; cv=pass; b=Zq1fcCawfkuh0Fgvn/WppThPH6steoqv+I6utoOihNxcuDeybOPAAI6elflBtyWhH0s707Bqh7zmw+IVe/9xXSRaEGgOWX6T2/VNiv3f/Vxdr6xldQsBXVJ61ftJ7OQ1C4Qn2pfXun76KhUfEdLRrJJF7v7iFOwpEjcz1yvhQ7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157546; c=relaxed/simple;
	bh=fV9SbuhPu+ZC2t3/nHhYdEpTV0whbwwDTfKjD88hpYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DupCoUAzTTzhnTmGlxWzhGvXrZbd7Y1bRJGVVaGR7pltnvzClRmdDl/tOCWVtCaUgDBSNdL3l12Li1az5q9IMlSQ51HCxVD3HPpn1s+cKdSCpMMBYeL/AZB+mO4+4hpkvk7apZnfBXhOAf4DBUX6iaF52plbLXetTLPrZjPT2aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxsZSBGV; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65c1ba7eeb6so661023d50.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 05:39:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778157544; cv=none;
        d=google.com; s=arc-20240605;
        b=YtDPiiKvRjW/Dz/4s7V2vixO67frLLR6AWS4t/wtQJRzKwygVyp8PvYOHim95UatH8
         S/NDFcAvApdTiFWiB51yE/LwRC+Ri8LLDFhmMbN7Z2q3FEj54MBzVX6AXTx6HIYVniC9
         P4vq32wi+h7Bshf5VNIcX/WVJYrnqcO3ib62AoLFsZTe4zA+uExPQgl2kUpkewa47+aE
         cxbw55z8gSQErMzqNCtd9D1ZVbSxTLu7QR3c+kfaZxWgOuYc0zE29W+ZBcmrWQIN4nlB
         5rTQurbAgLBb7McGxmVnFnVkB6XlerQ9qm4gqlMw8q5/PKRiIkRCIar4VnByU7WxVXlQ
         1Juw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=24f92+2s3Bem/6CFNRp+DVqIBOUC5rSCjbALyAaR/O4=;
        fh=4dDPJYzX2OfvPbbN5VlrxD1lenkfphuGtyzdablUsA0=;
        b=SFMU8fJltAFvrzBf+Md7cFhG5wD7yGx8g1FxN0AlZ2CaaHpDsQt+Ks2kOg9Iwp94t9
         aveXI968zpheWYD4gjXW51mEif4Vf1+XA4ZzCteyHs/XaoFyQmOhbY4ZWdQC9VS0cNGE
         p1rsmxlQcdS0mPu2pYUiTP1Q7Md8IUazeA9heuNOdDw9Dp1RbhHqxO1aVy1Frxdhu4eE
         2XTZG6fBzCREQqEgFujnh4Lhvm91xJtIAjMQGRvynXfwsNY2jXlEaAfY1feUoR6vs7MB
         VJ/+xcWpM/l7O8p26x/g6FygoAtLbSfSWIhe4gDnatS+OZ9BHlX7CFjK2GoEPrtE/Nta
         Qapg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778157544; x=1778762344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24f92+2s3Bem/6CFNRp+DVqIBOUC5rSCjbALyAaR/O4=;
        b=GxsZSBGVghZFXY0aonSpU3atIw/Vr1tH3M+/bzr1O08Op/M+5YRQkNinR2ZT5GaWKv
         hrn7zgDsHy9xdz9LsPkDBd1N8NFU+Kz9mGjlWgxm5GG/4M6mjLkZ0ogJFRopPmVNm6N8
         C+VuFoUJXVgvzbdv5FZ9xtEJte5tZMlkLruAtFiEjoMkt09Am3p7Mn+D2rS7yrD6QxI0
         YLXsDAZdYb7TxMqMzbBA469D5ZM+3ICrzccRcxLSLsaXKn6ZVWdh8p2puZBRP+/ZHy4u
         oWltswfeL1y5R1/p9+tHqK8nEgS8tVD3iqvJylACPst8sZl9TE8xRXiRnnoDKSie4mCy
         AuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778157544; x=1778762344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24f92+2s3Bem/6CFNRp+DVqIBOUC5rSCjbALyAaR/O4=;
        b=RbI5pYPQ7KoIVOAiWRvz/Qe3rMY2gT6uJXQR+NMic8Zf5AHFbhSeOW5xIXOLBbmK9f
         D4REBbkyd0TSC/cauTGGZ9zbyQ/1JZlYYoPDk1m68aT3qS8Jz8zD4Tk3AYuEdnzfilDx
         O8WlTm+hZ+yfQB+9fig3nyG37YEcIOihtWQ1fYcnBwnFL6yrZwNz/1GxbqGAnr1zI0JK
         DWCkeJldV5q/EMOspDhY1wL+la4oIIReG8UHvqHcu/H5O2NGBmNF4dX4/BavZztJceWP
         hOHuzozSkChBSsedPRoTkAqBLha2RhcWn2WMPn34ba9K9+m5GDpGuLyHO/IdvILA8CkI
         hbiw==
X-Forwarded-Encrypted: i=1; AFNElJ8mnUE2jjkIF/GezCbUQkGLj4/x1L5Zqg9LDw39DeQt5Qe2+6KfiSjd+IlOlJjuR9K61zS/w9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrSfAigyduF6bGBlQuqaCL4PJdmE5oRozvCzIk/Y5PWCEVzpLj
	hZl2JHfCHQ+nXSzrNAas0KxcZZ2rfsaQ3AruoZ0QIOtCDG6CEDy1JMuJ8HsmE+UqbyW/qymjKKb
	qr9f7u4DwC6uDQuoTBNro/7ACwva3jo4=
X-Gm-Gg: Acq92OEa9U2OOu/ywaK+KlDZSUQKeuGCGirQYGIBANVIEx23fSCFxBF9/Jhf5wedyL8
	7mferzbrVjwYwDaYyELNCrDq4hxa7vPT5JCWJd0X/f/jMm8s91+Ha1sgvGl/n0Qm3l2S1SqR8uh
	5XRSxpsNoxoOTKRKLxoso3qVU2fqmGlDW6+yqMN058TEuHA7h3LYunMcb2P9Gdrr8U69XgWP7ZO
	qzMp5C4lhfd4LrIwiEoLIU5weJ7VllbXenQw6fZ4S/9JjarvO0OhqALlWw2fEQm3QapohRZraz+
	zljC37604EXoykvxb5nT28SzeBRnJA==
X-Received: by 2002:a05:690c:dd5:b0:7bd:4a12:f08c with SMTP id
 00721157ae682-7bdf5eeea18mr85704497b3.39.1778157543721; Thu, 07 May 2026
 05:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142709.2298255-4-ameryhung@gmail.com> <c50e87ba73094da8cf153aa71d110868fe0e0e27bea866e294af7647712c9a6a@mail.kernel.org>
In-Reply-To: <c50e87ba73094da8cf153aa71d110868fe0e0e27bea866e294af7647712c9a6a@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 7 May 2026 14:38:52 +0200
X-Gm-Features: AVHnY4L8BTSGTMkaQ_vSAxNoM8ylP56QTtO1zr33GYSdvSMLCwJhuls_W3Ifc34
Message-ID: <CAMB2axM=8U08vR0HE3yi341G8K_6CjL7QiVh1VUe2UUi7yL54A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 03/12] bpf: Assign reg->id when getting
 referenced kptr from ctx
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com, 
	ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DC1ED4E84C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-285313-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Wed, May 6, 2026 at 4:27=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6057,8 +6057,6 @@ struct bpf_insn_access_aux info =3D {
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
> > @@ -6068,8 +6066,11 @@ struct bpf_insn_access_aux info =3D {
> >                               if (base_type(info.reg_type) =3D=3D PTR_T=
O_BTF_ID) {
> >                                       regs[value_regno].btf =3D info.bt=
f;
> >                                       regs[value_regno].btf_id =3D info=
.btf_id;
> > +                                     regs[value_regno].id =3D info.ref=
_obj_id;
>                                         ^^^^
>
> Does this introduce a bug when reading the same nullable context field
> multiple times?
>
> The new code sets reg->id =3D info.ref_obj_id, where ref_obj_id comes fro=
m
> ctx_arg_info->ref_obj_id. The ctx_arg_info structure is initialized once
> during program type setup in check_attach_btf_id(), making ref_obj_id a
> static value per context field, not per read.
>
> When a BPF program reads the same nullable context field into different
> registers, they would share the same ID:
>
>     r1 =3D ctx->nullable_kptr;  // r1->id =3D ref_obj_id =3D 5
>     r2 =3D ctx->nullable_kptr;  // r2->id =3D ref_obj_id =3D 5 (SAME!)
>     if (r1 !=3D NULL) {
>         // mark_ptr_or_null_regs(id=3D5) marks ALL registers with id=3D=
=3D5
>         // Both r1 AND r2 are now considered safe
>         use(r2);  // BUG: r2 was never checked but verifier allows use
>     }
>
> The mark_ptr_or_null_reg() function uses reg->id to identify which
> registers should be updated together after a NULL check. With shared IDs,
> independent reads are incorrectly treated as aliases.

I don't think this is a bug. They are indeed aliases. The referenced
kptr acquired from struct_ops argument, if valid, should always have
the same ref_obj_id (also id) because they point to the same kernel
object

>
> The old code generated a unique ID via ++env->id_gen for each nullable
> read, ensuring proper NULL-check tracking.
>
> >                                       regs[value_regno].ref_obj_id =3D =
info.ref_obj_id;
> >                               }
> > +                             if (type_may_be_null(info.reg_type) && !r=
egs[value_regno].id)
> > +                                     regs[value_regno].id =3D ++env->i=
d_gen;
>
> Would this fallback path prevent fresh ID generation when id was already
> set to ref_obj_id? The condition '!regs[value_regno].id' is now false for
> nullable PTR_TO_BTF_ID pointers, so each read gets the same static ID
> instead of a unique one.

Yes. It is intentional. This mirror referenced object obtained through
KF_ACQUIRE kfunc, where id =3D=3D ref_obj.

>
> Eduard Zingerman's review comment from v3 suggested that the commit messa=
ge
> should mention that this patch is mandatory for proper invalidation
> propagation in later patches. He noted that without the line
> 'regs[value_regno].id =3D info.ref_obj_id;', the test
> 'bpf_qdisc_fail__invalid_dynptr_cross_frame.c:invalid_dynptr_cross_frame'
> fails because the .id link is needed to propagate invalidation triggered =
by
> 'free_skb(skb);' to 'hdr'. The current commit message mentions consistenc=
y
> and parent_id tracking but does not explicitly mention the invalidation
> propagation aspect.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/254424=
56702

