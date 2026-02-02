Return-Path: <netdev+bounces-256029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Fy8Ndw1gWmUEwMAu9opvQ
	(envelope-from <netdev+bounces-256029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 00:40:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43844D2B1A
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 00:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C77BD30185AC
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 23:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DAF38E5D4;
	Mon,  2 Feb 2026 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7h0F2SA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349DD2C234C
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770075607; cv=pass; b=lVNYvInnSc955pJTRTsCv/PhrGQxAjwjlIRWzQ21pNFYtrFK2nGX5xDkjy9oCUC6KF/zzQIWs5NbVwIMYRpsJheZprwtAdaq5U7rGTWzpC2O9dVvfzLxvN+dB+mZF5lov5gvr3fACZURa+X/B7LmlScFlPdeHbhiG2aApxdBZnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770075607; c=relaxed/simple;
	bh=d/4PHqC+8q/tKZn/tZq2NAmR55Jba9qxeMWuH7IIevg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQ+UvT41WDhfEBYsVqhpFMU49s+lmo1VZ621LubGD1tAD94LDkS0MmvxORmdaDOJegTsrw9+medj6wOzaE0XyMO+k24gClRGWkg5zwaGcb3JPDmpgKUMkY+tlRvqkt/FDw7CLI0gfqA8YLbGYbZ7g4Ek7M109/tB/ksgQI9u2qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7h0F2SA; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-649605d3664so5668044d50.3
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 15:40:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770075605; cv=none;
        d=google.com; s=arc-20240605;
        b=Dsw2ASuGj4nojwwTVy2f6276kwyKM5NQh/ZyAcNvwq7ozFRD4TmNw1XbeTp7bcNren
         qegnWQxIrsRPuB1nDWjgViWFaSWiMq5SwphGhZLgpDYRzjasqAuzDRlzYtnT6kge+hm8
         nWtdDXrhxU6VlWbNnUXq6X/5erGJ3y+m3AkKIWX56/REesbHNPIWYP+uYcUemukoNls1
         NSwSCHwmiCNzFLEB3QqjFl0AwcG8h5DIDQ89sudlZ6+zqH4iMjgmDKUaXFdwAkjdJf8k
         Gtp8VHcAhZBbXDceh6hiKdbUZ9HmBUsksrOSJKd5yvSZKLlT7h4fjsXL1wxILRnXWrQl
         2VtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4HH9dV4RRnbaqS1byKBaPP2XgnUxuW8qreK1Jv1zuQM=;
        fh=W1sYI/wzKKsFVWvNDjNJFWXR4aWCdmHc0nvzaBWuCe8=;
        b=jm64HGPZWaq150WhlNe2lEm3BVVAY7hxTjC+piqqTK9UZI9lsah1WNDcTUaKmqn6Um
         li3/8TtoYN6tXd37d8LCCidV0kN+Mqg2WKJXTBapYmVvj4p77zkVQam07HzheqQn/jYk
         huORo6wxO+qhM9vkl8T5Xxkg9yrrgtE4I5eS6IlpRkrn8t77efpK1SuMFlUPkKbR+iMB
         30h6uHPiRzxXIBaiiuv0tYxQR0ti6C9Brb55wrLaJkHEVHZ49RzyFh7Urtaio5ODki9Q
         jzlORNLSsWtSyeSCsL/8HFi6hW1w485Mq3vseir9yziQTsMbNYX0lFt8JdV2Z+/7rQQf
         C4qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770075605; x=1770680405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HH9dV4RRnbaqS1byKBaPP2XgnUxuW8qreK1Jv1zuQM=;
        b=h7h0F2SAWC3KFQY2tCrVyMspUmWt9Df4McF9PZhELLjDx2XialR6IB19dqEfJv5c6u
         3OzcnQZJgYw46SXQZUf0eh8ggUawRdZvwD04Naw1eEfk4Y0Pix4H/NgsyuQSocK5jcbc
         AsM37eZZ+QPkd0iN94CjgdbKK44ian9+rdUok0gnWtBKmPBSG/kpDs94vAKgtneY7dmk
         cGL3MA5GsKDk+YCq3Cd99rPzr9tQOiiZrlOzciZ9ovPX/7VlN+7KIwjK4nOetWiAY6f1
         p95VIbgWPd5Sr1RhOnYgJ+na430yxnhCtlH2nOtS3Bht5eRM5qujEXOucWJB+a/M9PJS
         paag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770075605; x=1770680405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4HH9dV4RRnbaqS1byKBaPP2XgnUxuW8qreK1Jv1zuQM=;
        b=oBTNz6KqlgO+w3lcYDonaFY+3NIl26RJ0WFsi3fGaVSLmUknXJ5CBAZEc089S4yoA7
         P9Jy76CCoKDmkFN4wY9pFsW1fLybcY60odSchya8iUIMnQDh8ubKpl75Vu0obauKmG8D
         fmhjNTsY90Lv9o6lojaYy+b7K9JZvx1dhsfkdbp6kDJ+vcWrgM0W+CyGuXHsTo96YTgS
         4UqPEjduI2ZtzFPE08QTep7YkLyydEZca/1ScpVG6ulTDpTC4E+uvxZ50ddUcAsCv7Ep
         /KabzxmOzFNUxYjTvovqRn/cOH9nUNgO5gpSM4ipLcQf9hBVGLOwTQW7/l4BuzUrrPLR
         RwVA==
X-Forwarded-Encrypted: i=1; AJvYcCWqzIJLNdrUxiHy/gD+RL9ic5G7ZThM58SBMK9vg2dIuZLEhzAXuxia+sw8KQsm7YoCuexKoEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXCoMPJraXC/90UN3N3RmIEF6/EGS8Kh8CR8+1W9f+1QHHh1Z0
	OsKO8/CnFlYdrNCXEMzshu/YmmyL3DO1AEPtX+9+/A2+KbHlBYPNR/0y30s3sJ+M6nSAo5yNVX+
	WQOJmxx1j/Zc/mgbKH/J1pnRJCYZj2Tc=
X-Gm-Gg: AZuq6aL99hW4m7quDfa1DlV3wsa65C4Sh2bSesF+z9w6iq38pecVRXPya4pajf+4V5n
	hzGHhebmza3pB4crKXhewHd2xdYKybOvjPzZdGFuOTwIc1WAAkv1FMfLHFYRv/pI3BFbSmNowL0
	LobsggBE26Wdr4DfNrFpRq9fm7MHPXmzch4hlbZC/JE6cBE88C+hTIIjMD4/xu3RyfLYwv+8sGm
	DId198J4uPAsepWEqJIUFNjtboZjlFyoqzfiFHFVpLIziGOjvKkJMy/rPWxaCNZv2cSzQo=
X-Received: by 2002:a05:690e:1486:b0:649:36f4:afb7 with SMTP id
 956f58d0204a3-649a84647f5mr11076549d50.29.1770075605146; Mon, 02 Feb 2026
 15:40:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202214817.2853236-1-ameryhung@gmail.com> <77f6c7cf5ed980f733fad13caf87baddedae6c1bbaa8e55db00a81828638dec3@mail.kernel.org>
In-Reply-To: <77f6c7cf5ed980f733fad13caf87baddedae6c1bbaa8e55db00a81828638dec3@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 2 Feb 2026 15:39:54 -0800
X-Gm-Features: AZwV_Qg5iGE7_oTNtKvKninvgG8pNqygpI5JosEyD2JMt1ubCtCeqspUbTTVL9k
Message-ID: <CAMB2axNRZtGGgGxiEsNCi3Dz7PTDOi_B71RgzeWLJ_=RaQGpJQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 1/4] bpf: Fix and refactor object
 relationship tracking
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com, ast@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-256029-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43844D2B1A
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 2:23=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6b62b6d571..a357e03051 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > @@ -10481,22 +10464,43 @@ static int release_reference_nomark(...)
> >  *
> >  * This is the release function corresponding to acquire_reference(). I=
dempotent.
> >  */
> > -static int release_reference(struct bpf_verifier_env *env, int ref_obj=
_id)
> > +static int release_reference(struct bpf_verifier_env *env, int ref_obj=
_id, bool acquired_ref)
> >  {
> >       struct bpf_verifier_state *vstate =3D env->cur_state;
> >       struct bpf_func_state *state;
> >       struct bpf_reg_state *reg;
> > -     int err;
> > +     int err, spi;
> >
> > -     err =3D release_reference_nomark(vstate, ref_obj_id);
> > -     if (err)
> > -             return err;
> > +     if (acquired_ref) {
> > +             err =3D release_reference_nomark(vstate, ref_obj_id);
> > +             if (err)
> > +                     return err;
> > +     }
> >
> >       bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> > -             if (reg->ref_obj_id =3D=3D ref_obj_id)
> > +             if (reg->ref_obj_id =3D=3D ref_obj_id) {
> >                       mark_reg_invalid(env, reg);
> > +                     if (reg->id && reg->id !=3D ref_obj_id) {
> > +                             err =3D release_reference(env, reg->id, f=
alse);
> > +                             if (err)
> > +                                     return err;
> > +                     }
> > +             }
> >       }));
> >
> > +     bpf_for_each_spilled_reg(spi, state, reg, (1 << STACK_DYNPTR)) {
> > +             if (!reg || !reg->dynptr.first_slot)
> > +                     continue;
> > +             if (reg->ref_obj_id =3D=3D ref_obj_id) {
> > +                     __unmark_stack_slots_dynptr(env, state, spi);
> > +                     if (reg->id && reg->id !=3D ref_obj_id) {
> > +                             err =3D release_reference(env, reg->id, f=
alse);
> > +                             if (err)
> > +                                     return err;
> > +                     }
> > +             }
> > +     }
>
> Does this loop only scan dynptrs in the current frame?
>
> The bpf_for_each_reg_in_vstate macro sets 'state' to each frame in sequen=
ce:
>
>     for (___i =3D 0; ___i <=3D ___vstate->curframe; ___i++) {
>         __state =3D ___vstate->frame[___i];
>         ...
>     }
>
> After the macro completes, 'state' holds the last assigned value, which i=
s
> vstate->frame[vstate->curframe] - only the top frame.
>
> The subsequent bpf_for_each_spilled_reg loop uses this 'state' variable,
> so it only scans STACK_DYNPTR slots in the top frame. Dynptrs residing in
> caller frames (frames 0 through curframe-1) would not be found.
>
> When a BPF program creates a dynptr in frame 0 and then calls a subprog
> (frame 1) that releases the parent object, the dynptr in frame 0 would no=
t
> be invalidated. The selftest bpf_qdisc_fail__invalid_dynptr_cross_frame.c
> appears to test this exact scenario.
>
> Should the bpf_for_each_spilled_reg loop be wrapped in a loop over all
> frames, similar to how bpf_for_each_reg_in_vstate_mask handles it?

AI is right, it should loop through all frames. The selftest fail to
catch this because free_skb is inlined. Will fix the bug and add
__noinline to free_skb().

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/216081=
54622
>
> AI-authorship-score: low
> AI-authorship-explanation: The commit demonstrates deep domain expertise =
with detailed ASCII diagrams, uses standard kernel conventions, and the bug=
 is a typical human oversight from misunderstanding macro variable scoping.
> issues-found: 1
> issue-severity-score: medium
> issue-severity-explanation: The dynptr invalidation loop only scans the t=
op frame, potentially missing dynptrs in caller frames when parent objects =
are released, which could lead to use-after-free in the BPF verifier.

