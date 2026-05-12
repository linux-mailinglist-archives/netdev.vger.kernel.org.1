Return-Path: <netdev+bounces-287328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGDoADKcA2qF8AEAu9opvQ
	(envelope-from <netdev+bounces-287328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:31:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FF052A4F7
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E81823006930
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E0C36F913;
	Tue, 12 May 2026 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggN3G67r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D413EDE76
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 21:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621484; cv=pass; b=jqHC2eOJDxoYwlow4MR6br/zJb+c6zSHoKAexfMx/fDsKWB1ccBOlNaB5c3EkE1dSiSWfkG5j5dmJw2O7y+MwxO8bSJfxPw/8SS4F10iqFi+6zbyqwN3s79IJKHuMS0UQz+qLccpldorHNqSTDWGpu+OFqW9s0oObkYGqBoX3IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621484; c=relaxed/simple;
	bh=PkC5s/4Uy0m2CN2hO3KoNCLTqq0UuYmaEjzo9fWkdZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgeOToqjtMVqtiy77RejMOY5eAzO6myzVP+5VWqf690OmvosjGSGIwh/a4iHswZUJ4NGnTwxTgRgQr/ZEnasFYTsIJ+Vqy7jBWg06nzw4yeQiiMaptu3+8oiv3pM/r8y4dyUaJpxMTEDQfTG+0FSZAn3QW+6l9CDuvdXoZ2HMhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggN3G67r; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7bf14e33f5bso55595957b3.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778621482; cv=none;
        d=google.com; s=arc-20240605;
        b=dRinU4C8yQao6DvtBpGo7Vh0kKxhfpdchunVU/eZZwVPpCbmh2q8l5yBy6/j/l1BTd
         vVzAdsSX4h/Av3kTjwPHvj43RwhgD3mMZSgYl7DCJMXMcAamKPlgNm4D803oKBcQCDJF
         o4qCHOkBm1/vdr2WfpSPoaeuebAjMiq3rLLMW02VZqIqNrehm8k03x0U6bU6yO/314oc
         o4SgCRqqVCJr7Qo8IRHnZoQMWPRoyEzW63Qym3UN/1xV9N6C2/w378PS9vKeMtbyS71j
         Y7Xp8/v9MD0mkxvl+5PbsNemFsqNITqSqNFIXO1KY/aivriRFaZlOQRLcKfi7MI7w2ZI
         cpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7W6y2t+nJOe9TUUMwUkhxdnxRPcdVhvGuxKswbifoKM=;
        fh=kKibDW6yqoHGykKO1QwQE6rZd3GXxUTp/9tA6cgXBI0=;
        b=c36teGIfphaAPCkNQDJMZuV7t6urqDB6NPEV7OVsF+cBh7RlKVs7RUAbySme1a0/C4
         A6WBQvLS7359ehmBLUgQzp4KkawOrtiVTEtDJr4t0k7HRNv1aj58QRTX5VhsGDPxgWUT
         b9SqeTdndPBZi4A2tcd7Z4jgXXJJNeEuWLSqFRmwyDsR5cSON2prO96uTC2x2cSfQFjX
         fpowB/wRIiO4SIQFXAozk0TzUgDaPX4ke1yWqVHMSht20sRAllKg4rz7FAtQAueDBt9C
         bA5HPTHq2GM3q0Cy8pjROYIXi/Jbxe0dMNb1opP8krUVadmHz3ulZ106WZXDBah/n93j
         LPSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778621482; x=1779226282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7W6y2t+nJOe9TUUMwUkhxdnxRPcdVhvGuxKswbifoKM=;
        b=ggN3G67rWqVlp5MMgZoOlp+RR467rJEeDqWMIg4duWAlSoD0l8HB5D7A/hmnSNV30S
         oEvYtAGgYbdPhJh5oEP95It8BlNRuptO/+ry/5x1sdIicwG/8ZxSfVXEG1wpr+H9NUUh
         s6NnUqoti0MfCG/1CLVJYHu4n5etI2T+NwXO1naJc+IPSAQyJCXtVTrGvCJuwGM4FT3W
         d9aCMit7z966MLIBv5XvZd3oIUHUWxts1t0CBcAWo2tw4vCgAvfMRXo1DQFqzbhQfp0D
         ZjNsuDn+KqpVF2mf9mBSKK8LaY5lCONdYP1zIuor8wCNftPTP08vmXTDVOeQ5XPap4cC
         dugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778621482; x=1779226282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7W6y2t+nJOe9TUUMwUkhxdnxRPcdVhvGuxKswbifoKM=;
        b=BvmhdKpXgQQPStn+fHrUzIzjzgfgSmK5kZFN7p6i/riak+qeXVV1040Y7qogQYk4sp
         /QtUZBEGM10qEVj5spoZZtKeBDlWj8wNzZZ+9rXPnaYzl5ESA01VghXhOeNaz+7YuNRH
         fs25a2fOsIPZ1G2+yo7SR4SLkzgNX2w2Y4ejcMp9xvu1aCkviefRxVurg4DfRXc7v/a4
         cqcW5yWSYfCAPh2ON6I8nJc5ZBVe57ojNz/TXZRTXkKl/mnghgVjIYdLr/qqYN3MJjNt
         DEIimL8gIEG3sBzPG39JJYf6XchyHiwWKalu1JHYn83hIVv0Ofxs+UruQdqohxXOgR3L
         4g3A==
X-Forwarded-Encrypted: i=1; AFNElJ9AG4aglI3w6tAqh8PXegDDMPdkAL1okVsXoE7coZuGAlu0calCK1cRmrqpw1R6g2rl25tuAjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPyJ9tNnhEsfSVLyWTqdDodVN9C7WbQfm6M9hEEuCQ80wIbjlX
	4nDRFq4HKZAbaJugsYhwVHJRI6Q+GjWnHiAydX0LboBoZzWT5I27FTmVlz3YGAAk77F6E+QcqUT
	bmmWrNOxXkQZiX6E7pgnp3pgxWY8THvY=
X-Gm-Gg: Acq92OH+y+cMEwVIyXRBfRNptPsELgGQFUB3FiEwSGZVxja3RrTtdPkkqVdYWOzAVgx
	0u2fpAt0s5In/bAIPmUQxdOVIdnP+LL4KzmABPiyE7Mz/qxmbrIUwwtsrj3LjSDpoZq3SLLtK+d
	JLbZwjvrYiR2PWlKHVwbg5RkAQKkcBpo4v5yVu8o90edvuwajMV7lkIa8WRNnOE2Fuoc/u/0bwq
	xV0g4BdYOnBHvRi71+ePI4xtZMmjgpB/xJFsnpMyzKYNV3TJUFgm7QQDbeAX0TNAIe07NWR01jf
	uzcnPhyomGZQ5VoxL4kIijg=
X-Received: by 2002:a05:690c:9e:b0:7ba:ef98:9712 with SMTP id
 00721157ae682-7c6a9b31e3bmr6451997b3.11.1778621482311; Tue, 12 May 2026
 14:31:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142709.2298255-1-ameryhung@gmail.com> <20260506142709.2298255-8-ameryhung@gmail.com>
 <23140ed4c48babfa8af91f3b67f379773bdc04c1.camel@gmail.com>
 <CAMB2axM8hR=OVqbkbTMJw_ej2pfnEm9Cm-quuoFPqsVhmJxO0g@mail.gmail.com>
 <701f9924ff6d13cf948c4ce4527eb866a26950e2.camel@gmail.com>
 <CAMB2axOsnVj=PBuMU8utqKsSj7DsVhWNi9Vddytx6BKfFGs0JQ@mail.gmail.com> <073fd24d1220adccec5248b094f4f80fd5e66f93.camel@gmail.com>
In-Reply-To: <073fd24d1220adccec5248b094f4f80fd5e66f93.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 12 May 2026 23:31:09 +0200
X-Gm-Features: AVHnY4L9IEgzBtCBDye1dKv4hRa9WilvXqRGKK6a36Cij0o4gsGIpgpGL2yqSGQ
Message-ID: <CAMB2axMSBOxpUkSPr9JtD2KT4FVvwKho-G8HKJp0DP+WEK0aEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 07/12] bpf: Unify referenced object tracking
 in verifier
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 04FF052A4F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287328-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 2:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2026-05-12 at 23:27 +0200, Amery Hung wrote:
> > On Tue, May 12, 2026 at 2:09=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Tue, 2026-05-12 at 22:37 +0200, Amery Hung wrote:
> > > > On Tue, May 12, 2026 at 12:04=E2=80=AFPM Eduard Zingerman <eddyz87@=
gmail.com> wrote:
> > > > >
> > > > > On Wed, 2026-05-06 at 07:27 -0700, Amery Hung wrote:
> > > > >
> > > > > LGTM, a nit below.
> > > > >
> > > > > [...]
> > > > >
> > > > > > @@ -8028,14 +8024,13 @@ static int check_func_arg(struct bpf_ve=
rifier_env *env, u32 arg,
> > > > > >       }
> > > > > >
> > > > > >       if (reg->ref_obj_id && base_type(arg_type) !=3D ARG_KPTR_=
XCHG_DEST) {
> > > > > > -             if (meta->ref_obj_id) {
> > > > > > -                     verbose(env, "more than one arg with ref_=
obj_id R%d %u %u",
> > > > > > -                             regno, reg->ref_obj_id,
> > > > > > -                             meta->ref_obj_id);
> > > > > > +             if (meta->release_regno && meta->ref_obj.cnt) {
> > > > > > +                     verbose(env, "more than one arg with ref_=
obj_id %s %u %u",
> > > > > > +                             reg_arg_name(env, argno), reg->re=
f_obj_id,
> > > > > > +                             meta->ref_obj.ref_obj_id);
> > > > >
> > > > > I think this should be reported from update_ref_obj() itself,
> > > > > it is more consistent logically and also avoids reporting code
> > > > > duplication in check_kfunc_args() and check_kfunc_call().
> > > > > Also, technically the reg_arg_name() is an independent fix.
> > > >
> > > > We have kfuncs that have more than one ref_obj. This is not a probl=
em
> > > > unless ref_obj is referenced in the verification and is ambiguous
> > > > (e.g., used it to tie the lifetime of the allocated memory with
> > > > ref_obj). Therefore, it is kept at the location of use instead of
> > > > update_ref_obj() to prevent breaking existing kfuncs.
> > >
> > > Ack, thank you for explaining.
> > >
> > > > >
> > > > > > Drop the selftest introduced in 7ec899ac90a2 (=E2=80=9Cselftest=
s/bpf: Negative
> > > > > > test case for ref_obj_id in args=E2=80=9D) since the verifier n=
o longer
> > > > > > complains about ambiguous ref_obj if it is not used.
> > > > >
> > > > > On the other hand, if you think that this property is worth havin=
g,
> > > > > then maybe wrap the check with in some utility function?
> > > >
> > > > A utility function like below makes sense if we fold ref_obj_id int=
o
> > > > id. It would be too cumbersome for v3 as we may need two of this fo=
r
> > > > ref_obj->ref_obj_id and ref_obj->id.
> > > >
> > > > static int get_ref_obj_id()
> > > > {
> > > >         if (ref_obj->cnt > 1) {
> > > >                 verifier_bug(env, "function expects only one
> > > > referenced object but got %d\n", ref_obj->cnt);
> > > >                 return -EFAULT;
> > > >         }
> > > >         return ref_obj->id;
> > > > }
> > >
> > > Maybe just like this:
> > >
> > >   static void validate_ref_obj(struct ref_obj_desc *d) { ... }
> > >
> >
> > Do you mean:
> > static int validate_ref_obj(struct ref_obj_desc *d) { ... }
> >
> > Then to use it:
> > err =3D validate_ref_obj(meta.ref_obj);
> > if (err)
> >         return err;
> >
> > regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj.ref_obj_id;
> >
> > > ?
>
> Yes, like that, sorry.

Np. Thanks for the suggestion. I will add the utility function.

