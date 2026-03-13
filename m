Return-Path: <netdev+bounces-267592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id h1FSDV54tGmOogAAu9opvQ
	(envelope-from <netdev+bounces-267592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:49:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C01C8289E2B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 009273021408
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1F737EFEB;
	Fri, 13 Mar 2026 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b09BfDRB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6EC37DEB3
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773434971; cv=pass; b=NgMkZdRVHV850Bryt4c+TdJ4defUP5cUb3sUfFX3ZQY1NnNeQZu7YKcXQU/ouyFjYnS9jvdhDbWZZG87zJmcMbMXnD92q/5YAZ7qnklfQpFhmQP7sPwRBeycv0EYO19Rd2Ow5qk+yQJXXPTgL+7g4aw9d4jU3kAIqgl9RveeOD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773434971; c=relaxed/simple;
	bh=O4wbrTj2iFx9LOPFO28szlepMww2CuIsX/kRVN1W6iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfbLZoN+SDiTqWP1zbcia4Pr4zwWiI/QhZlndFxH6wnn50tTzUhnmqfnnfed96aMt7+PFGCAFr6sBLVlGTf+ijOgHwJfUCc1gdR92Cx7i4gCBsr88blbae8bYDDwDf7qRp9vUDAD4sAhZi4bNtEy7+GOsECmMqFgEO+gtveHjQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b09BfDRB; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64caaacb9bcso2851503d50.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773434969; cv=none;
        d=google.com; s=arc-20240605;
        b=a3B9tuadOQJfH9dT9ZXVZh+003Bev/xDsAc+pYhf9/1qRaBOtXVNDDj1O3ES9nLPlm
         f6S/fQpoKbQ5xW0GANgcE45kYdHugfNzPtWHSXm13ZS9bIPoSgkDax4aUFDmLnVVilzl
         u5pXSPQ+gzkpRydHVIRKYwFbt7f5xz91KQXDBAB/dDqOLvVXGmHdMw4fB4QEZUPfv5+z
         8iuClSjJQgsKWwSx80+dnEF3ytxq6XjDestcvQ3JLVN+/0jDdkDN5tsLGA7I1Z79rcrX
         r1PmFvJ72UEvORhJaAsBaN6y3cnTCzVAhEMBy7UB8q+tGlcSsnAnGw/EAyjNir59zw1U
         8wCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tXiszcF7N7frIIzHU2H1mV1fC3d+rzKovPJ6OOhwrtc=;
        fh=91a9zGe9PYhnVSSP4Cdm6pJTj4kr1qJUt7Or3o1gPoM=;
        b=U+7+cbi6h+ydGn9dVcgza6Pn70kLAv8N2YHEgbdeOdoZ173YaDNQnpHgfZjX1SaIyl
         +1VNO5VDXbWRK1nUy6yfbbzl5yXExcszPciHF7EXAu1E4opguTuy3pTGXvpfRL2u4sRP
         mxquCl7GTSmfDRfBFLT18TPMNTjTBc08D/2v5Bs0ncsx/WBTrtyBqSWZ+GITXYx5mL7f
         xEz3kYtqbIxrqsd3N67xQYH2ePOusTs3RjKMn77RTDDCQ61jMF5RKjkDfaCsSNh1CQVN
         UWlY15WVDYn1T8Y8CeAwHg1wE8Oo8uXn8I+0NjXZtUruDbq+kOW6/2TvmPjjgFMaO1ie
         SAig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773434969; x=1774039769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXiszcF7N7frIIzHU2H1mV1fC3d+rzKovPJ6OOhwrtc=;
        b=b09BfDRBn9O4CCA3xlpK44MKY+U0leb+gGBGpwYUB/JJ7wZMu8Mya+G+v54yM7AV+4
         0j4v0qtHpezXDMVA3P1R4EzyPV9iKgIz3YgXFuNQCvhRhbr9/AL1Dx6UhvQC2MnJo3+u
         XXjBhoLeXQ0LQrhMeJgNt01LNYKFI79+xvy8qafKlvcl8mQkMHCmoCRFb2QzD/NJalhX
         GfpIp5bUC2nFd8LMGccz3Ze+0kiOiFBkzefR+MLp1i9yC9sfXSBMiKW+52fSuJ5Oq1eB
         9oeW6+79Ke8fBYm4TFDFtnWcMRAr/ecooIqGW3ax3i9o+fUvAVo7AKzYmZ8b2tBod5I5
         DWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773434969; x=1774039769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tXiszcF7N7frIIzHU2H1mV1fC3d+rzKovPJ6OOhwrtc=;
        b=gAL6alXb9iZwNOdUjhUQUlIUFydJvonBXOr7Fq6MFwf/gvxxjGn7ymupoigrIylJ47
         rzq9Z/bWeXFfAJ3mBT1tJMAlLE7EhKK3SJuTXLuqwO6dwHdrJIf0zs2RxMkJhY1mANPP
         oiEB3WvVn3sYKpZbOqDh2m3GmV3KjTd3ViTD3iBjeLQZX5Likvh0wiuS4L1v5364OHXZ
         A+qbV42PRXTioVlXmTsNF5MPhtOk83y9sbI9xk7LTtghsBkSxQT2QDexMW7gn3EfxH5X
         L4jxFyETCEXHzqDJZnHxs7b9WzEfr303bUPDib+KiuB23ruvGamKmjE2AlRG8L3ehck4
         V4Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUH85t3LbN0bgseDX6X+/t+PoiGhmryZYZQUcoUpLslMW2f391GGSIqNFdDllzHF/bJ/2EMFRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YykU/dp5a7OUUw/ZN3BckqiZ6bpLzZmNFjtKNMJZjn/S1sApNQw
	FKfqo+7kxZimZMIqN3ZTNuV858nHopYou3FFKSi53P03QTHSELW5ItJEqB4sHu04urhaEAMP9XR
	UsQ+Rm+qJIBvJDMxevRSzSC+YbQGgD9c=
X-Gm-Gg: ATEYQzxB+WcyRyvgtJDGcBBqkdT5aKyqrkd3J64wLAFWil7VzpR4zDCCcwfsajJfGp9
	fcuL5Zfj2zlarOfgEPNE8n70FayOG++tQnUX8jQAgMK9tPWdI09Cpu6c0sYJSqlZD4mxah0hn2G
	jkzJ8x0t6/A6+dmpJmlrKyQUwalXRvY4KcoYmG84FDuuDJoElGPKMlrxriimVXBScX20yvGZpA3
	C+C9rUvMC2eRMKRI7NW/E4pxDsOky8wITGNg4V0cacoIjkKxluIqfrKNkX3JSfwEMgZwqsnKA+e
	wzu4s+U=
X-Received: by 2002:a05:690c:387:b0:796:3c39:eb96 with SMTP id
 00721157ae682-79a1c08c187mr54233147b3.13.1773434969119; Fri, 13 Mar 2026
 13:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <CAEf4BzZab92hO9ERcfkkg2OHab9F4M9fmwc8yudDu7kjp_qu+A@mail.gmail.com>
In-Reply-To: <CAEf4BzZab92hO9ERcfkkg2OHab9F4M9fmwc8yudDu7kjp_qu+A@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 13 Mar 2026 13:49:18 -0700
X-Gm-Features: AaiRm53lfScGUwYFmbGubf9WkTuJ-eGkQhpEuLUjD_uObXyRLbmaYiwZq73tqFY
Message-ID: <CAMB2axPa=tgZm5a-2gP36VWf4Xt-ZrMDXBrTsVLYqY8UAzUnhA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 00/11] Dynptr cleanup and bugfixes
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267592-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: C01C8289E2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 12:39=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > This patchset (1) cleans up dynptr handling (2) refactors object parent=
-
> > child relationship tracking to make it more precise and (3) fixes dynpt=
r
> > UAF bug due to a missing link between dynptr and the parent referenced
> > object in the verifier.
> >
> > This patchset will make dynptr tracks its parent object. In bpf qdisc
> > programs, an skb may be freed through kfuncs. However, since dynptr
> > currently does not track the parent referenced object (e.g., skb), the
> > verifier will not invalidate the dynptr after the skb is freed,
> > resulting in use-after-free. The similar issue also affects file dynptr=
.
> > To solve the issue, we need to track the parent skb in the derived
> > dynptr and slices.
> >
> > However, we need to refactor the verifier's object tracking mechanism
> > first because id and ref_obj_id cannot easily express more than simple
> > object relationship. To illustrate this, we use an example as shown in
> > the figure below.
> >
> > Before: object (id,ref_obj_id,dynptr_id)
> >   id         =3D id of the object (used for nullness tracking)
> >   ref_obj_id =3D id of the underlying referenced object (used for lifet=
ime
> >                tracking)
> >   dynptr_id  =3D id of the parent dynptr of the slice (used for trackin=
g
> >                parent dynptr, only for PTR_TO_MEM)
> >
> >                       skb (0,1,0)
> >                              ^ (try to link dynptr to parent ref_obj_id=
)
> >                              +-------------------------------+
> >                              |           bpf_dynptr_clone    |
> >                  dynptr A (2,1,0)                dynptr C (4,1,0)
> >                            ^                               ^
> >         bpf_dynptr_slice   |                               |
> >                            |                               |
> >               slice B (3,1,2)                 slice D (5,1,4)
> >                          ^
> >     bpf_dynptr_from_mem  |
> >     (NOT allowed yet)    |
> >              dynptr E (6,1,0)
>
> Ugh... This cover letter is... intimidating. It's good to have all
> this information, but for someone who didn't whiteboard this with you,
> I think it's a bit too hard and overwhelming to comprehend. You are
> also intermingling both problem statements and possible/actual
> solution (and problems with earlier possible solutions) all in the
> same go.
>
> May I suggest a bit of restructuring? This diagram you have here is a
> great start. I'd use it to "set the scene" and explain an example we
> are going to look at first. (Keep all the IDs, but mention that they
> will be more relevant a bit later and reader shouldn't concentrate on
> them just yet), and just explain that in BPF we have this potential
> hierarchy of interdependent things that have related lifetimes. When
> skb is released, all dynptrs and slices derived from those should be
> released. But also mention that it can't be all-or-nothing, in the
> sense that if dynptr A is "released", skb and dynptr C should still be
> valid.
>
> And it's currently not the case. That's the problem we are trying to
> solve. At this point you might use those IDs to explain why we can't
> solve the release problems with the way we use id and ref_obj_id.
>
> Then explain the idea of parent_id and how it fixes this hierarchy
> reconstruction problem.
>
> But then, mention that socket casting problem which introduces shared
> lifetime while objects are actually semi-independent (from verifier
> POV) due to independent NULL-ness. Which makes parent_id not enough
> and we still need ref_obj_id (maybe we should rename it to
> lifetime_id, don't know).
>
> In short, I think there is a clear logical story here, but your cover
> letter hides it a bit behind the wall of dense text, which is hard to
> get through initially.
>

Thanks for the writing suggestions. I will try to make it easier to
follow in the next respin. Really appreciate you sharing your thoughts
on how to structure the cover letter.

> >
> > Lets first try to fix the bug by letting dynptr track the parent skb
> > using ref_obj_id and propagating the ref_obj_id to slices so that when
> > the skb goes away the derived dynptrs and slices will also be
> > invalidated. However, if dynptr A is destroyed by overwriting the stack
> > slot, release_reference(ref_obj_id=3D1) would be called and all nodes w=
ill
> > be invaldiated. The correct handling should leave skb, dynptr C, and
> > slice D intact since non-referenced dynptr clone's lifetime does not
> > need to tie to the original dynptr. This is not a problem before since
> > dynptr created from skb has ref_obj_id =3D 0. In the future if we start
> > allowing creating dynptr from slice, the current design also cannot
> > correctly handle the removal of dynptr E. All objects will be
> > incorrectly invalidated instead of only invalidating childrens of
> > dynptr E. While it is possible to solve the issue by adding more
> > specialized handling in the dynptr paths [0], it creates more complexit=
y.
> >
>
> [...]

