Return-Path: <netdev+bounces-255489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aTb8FaNMfmnQWwIAu9opvQ
	(envelope-from <netdev+bounces-255489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 19:40:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B474EC389C
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 19:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A4E4301495C
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D84F366DA9;
	Sat, 31 Jan 2026 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuJdc+DM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6B233AD8B
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769884831; cv=pass; b=Olswe50ZyEIw0ZN+Cg+lsGYuRT4wEFCq2JK2Wrizocx9DgMFMYwaveZY9d44/9WhOxWIDWNsMYi3H/L/Pk6ed/9HO/Uryue21GmzY2McPSsNyWRb8pZ3rrPKmQ3BP131WeK0UnUJTY0rinV5bj8FOQUrGblqcRO8PMF1c5OxIv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769884831; c=relaxed/simple;
	bh=PRn824+A/c7Ht8xBpSIA1cULL2eht/BI7CyXtooYyNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLNqDhd6Q7SZplp2eJeI2M/N2I1D8TEbxJdPH4/LOwPYwMHX6/nWrshh4winxgW4Xq/o/S9qgo1TSvPlvYsM8WHiIXBHGoOJZV2SKK+F88k74xeuosV8nzk48l2DA+L3Ptw08gadF15k1UT2OTuP8y/7dDvoj6EOTFXiJp9VzLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuJdc+DM; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-649523de905so4815806d50.1
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 10:40:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769884829; cv=none;
        d=google.com; s=arc-20240605;
        b=IkkOdmlqhHphmEKJeXK0O/65YHgYQOhxcLwZf0MfK5LSx4toeT+auaENE1wwQoXoLC
         cbIR1gT/Dh3o5dOsJF7ZmURR4pIlqnDYeIJW2McYuw9Yg9zEIs4ziKuFS/qHo3xF3AlF
         +TaN9e0u36DUNFialT9YR7nsxXbG68tzsOvXA3EqG2S6i/vVC6Vxf5eqeYPIIylt5y+8
         mv2DPmTTPtrOnLQtPxCAZlR+N7oTCA7HoM0EKf/Yt9UbJxYF3xBL5BsVX+fNJnyb5Hp5
         oZrkDycvJOb6o+Me4zdRgwPEAdrLbC00GVc/tHHVGOMqe6gaV0RX/4iMH0XkOKEKUgiK
         g4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZAAZwuiurkfmrGKZybeACCskuypcxNx54sP1LxN8Mkg=;
        fh=gjhgfmB2zH3N4yqBesZ43KlkX//64+Y4PaGLjhSFiSI=;
        b=HyNZGdM4ixwPLAUZhEhz1voN/Xu1Iwj+81XdQ8RqB+uxeot6amJXBxRr1ulu1m+voq
         Uj78VQZwsWx8LIiLDBVe/RUYn3oLvRLrr3BkplxaVKQVBVhGTi8iIFI/OISd374ulU1w
         NJIhu6l/Ku/OD6Uf8paA8ugSyfTWdyIB+mRBejp7QL9oIp0bn3v99bcVKRIjjF88kHhX
         PGAUQdAg5t6Wfi42UxCuYKtAb2E4KH91ZTz+y4D0zUo+egcLi4mfh98JhrcTeDWcuaQC
         1r5cCaSCdg65eXOfuJsSDIv0VyDcCFRq0d5WlK/cMnOOau8rjZMC+FwJay36h1BvLvyA
         mu1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769884829; x=1770489629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAAZwuiurkfmrGKZybeACCskuypcxNx54sP1LxN8Mkg=;
        b=XuJdc+DMAGQDyljVXnnF35jRAGnQJnn4Xju31mOumd5wW1jFZeC7rNtMgfjASTmoL5
         +sw0iWZfXsDpbKsc3oO+9QWjVzGa99cHuc0GT3Zn/TyAf1q3KZwu84i4D+hf5+LmVi2s
         1dudSdYTvaY+i+hCtDGe40sfvvtyPP7CypoQ3QRYYcxlI23zT3fi/cqciuo/ST87NIUA
         uXN1S+Vtk/92AiZcD6aZp5iaLPpEDA7vhoKTK/QZ2ebmN0B9kU00YcEMUK8w9Z3Dd/LP
         RkMLxmLhTLqGGGt9bxLp8Rw4+xj5rvGQjf+QpNYL+8jOeLC4fAx/Lh3KjHPY/T02eDRO
         WsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769884829; x=1770489629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZAAZwuiurkfmrGKZybeACCskuypcxNx54sP1LxN8Mkg=;
        b=S9CgJUGOpWKi4lj2/hOo8veAXmljlrtxUTi/e9AcTe6rQpF0RfTpa+WFp7mm7SRKVP
         ODrUnISPVsf1OG0OcbTy29mjBLxJuZh5qPznebOz3bje36diffTXCSUz/taHHm4yPwrg
         R4dXzkGyVltnfnDRbSTHQfYaZ1S+A39VocQ4ioalO3sl+TLMHZib3mCsCSeDQTxFrZpN
         AmiU7D5PugYPD53drxu3pNa+mFemCdt45ortva5X/V3zusZlgQsfSEP8aYTMbI69Wdij
         zz/c1L3TrtxxvcvZTojFpfvKHoo8WUNGBOXbZ0rKP+61FENq71PiSTN6jB/ENCH4sq8y
         8wxw==
X-Forwarded-Encrypted: i=1; AJvYcCWzlyRRmfGU1BpGCi+mn2RTDwAT3ucVy8iJ2qcYHCQlEG8AN7CZNaDgZ3Kb+Msbg6Pa+pAaiPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YytSnnLSp6xko62TdOKAam7L7zma8rf+qyp/zLLALBNzRmwOgs5
	yn3t62rfabbXrVXRNH/HGfVRtGd5yYcziEpfD669hAOIRwi4YkvWJNjVgFUGaVejn8gKIvWWvvf
	0QvyGPpRctqU5cfkwGhh0A8tdzsgufZo=
X-Gm-Gg: AZuq6aK9E/9qPUm4oJMKlq1qbORTr2D++8IvC0yFwIJgAxzge8DZgG732c3H1rgFQEn
	hNqvQ4yWWA0uYB8bgVVoCoo99hlXajhM/6dGvI9bTz3tX+vO3ASwK3vaulCfHhZiPWz2UMBxd5n
	LNJSgcGlpsyruDS85dH+OXE84a9mbO3HdQdFjdk8J3lDK+Q7wcEwzZLOGdDTcwI8RnmfVru4ZVx
	qNetZBQgq+jw0rdRBR3Rxwz12RzpnzIYSeEGNqFcHdW+W3T7WpJKsKXdKL7l9oDLfGN/EY=
X-Received: by 2002:a05:690e:118a:b0:649:4621:92a3 with SMTP id
 956f58d0204a3-649a8e90d32mr5040731d50.45.1769884828958; Sat, 31 Jan 2026
 10:40:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131050920.2574084-2-ameryhung@gmail.com> <fc5f36c2f50b99cba8b9b6d020a7400911a84c372ca15be7707c8513239228f3@mail.kernel.org>
In-Reply-To: <fc5f36c2f50b99cba8b9b6d020a7400911a84c372ca15be7707c8513239228f3@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Sat, 31 Jan 2026 10:40:18 -0800
X-Gm-Features: AZwV_QgZdXjlzSWfe-SaHSbm78i9UD87mqJEBMyrqX5PVwUTPucEaKRgHovIzR8
Message-ID: <CAMB2axMA_8t6M2RJ97Y-9BB_E3N0h=9ZKArazbNKS_ySuNkKAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 01/16] bpf: Select bpf_local_storage_map_bucket
 based on bpf_local_storage
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kpsingh@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, haoluo@google.com, kernel-team@meta.com, ast@kernel.org, 
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255489-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: B474EC389C
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 9:33=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_stor=
age.c
> > index e2fe6c328..6615091dd 100644
> > --- a/kernel/bpf/bpf_local_storage.c
> > +++ b/kernel/bpf/bpf_local_storage.c
>
> [ ... ]
>
> > @@ -368,9 +371,13 @@ static void bpf_selem_unlink_map(struct bpf_local_=
storage_elem *selem)
> >  void bpf_selem_link_map(struct bpf_local_storage_map *smap,
> >                       struct bpf_local_storage_elem *selem)
> >  {
> > -     struct bpf_local_storage_map_bucket *b =3D select_bucket(smap, se=
lem);
> > +     struct bpf_local_storage *local_storage;
> > +     struct bpf_local_storage_map_bucket *b;
> >       unsigned long flags;
> >
> > +     local_storage =3D rcu_dereference_check(selem->local_storage,
> > +                                           bpf_rcu_lock_held());
> > +     b =3D select_bucket(smap, local_storage);
>
> The commit message states: "This is safe since a selem is always linked t=
o
> local_storage before linked to map."
>
> Is this claim accurate? Looking at bpf_local_storage_update(), the order =
is:
>
>     /* First, link the new selem to the map */
>     bpf_selem_link_map(smap, selem);
>
>     /* Second, link (and publish) the new selem to local_storage */
>     bpf_selem_link_storage_nolock(local_storage, selem);
>
> The comment explicitly says "First, link the new selem to the map" which =
is
> the opposite order from what the commit message claims.
>
> Similarly, in bpf_sk_storage_clone() when new_sk_storage is non-NULL:
>
>     bpf_selem_link_map(smap, copy_selem);
>     bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
>
> Since bpf_selem_alloc() does not initialize selem->local_storage (it only
> sets SDATA(selem)->smap), and bpf_selem_link_storage_nolock() is what set=
s
> selem->local_storage, wouldn't this mean bpf_selem_link_map() reads NULL
> from selem->local_storage?
>
> With local_storage being NULL, select_bucket() would compute hash_ptr(NUL=
L)
> which returns 0, placing all newly linked selems into bucket 0. Later whe=
n
> bpf_selem_unlink_map() runs, selem->local_storage has been set, so it
> computes a different bucket and tries to unlink from the wrong bucket.
>
> The next commit in the series (82de4fd08 "bpf: Convert bpf_selem_unlink_m=
ap
> to failable") introduces bpf_selem_link_map_nolock() to fix this for
> bpf_local_storage_alloc() and bpf_local_storage_update(), but
> bpf_sk_storage_clone() still uses bpf_selem_link_map() and appears to
> remain affected throughout the series.

AI is right here. I will fix the bug. We should follow the
local_storage then map linking order in these three places.

>
> >       raw_spin_lock_irqsave(&b->lock, flags);
> >       hlist_add_head_rcu(&selem->map_node, &b->list);
> >       raw_spin_unlock_irqrestore(&b->lock, flags);
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/215393=
40647
>
> AI-authorship-score: low
> AI-authorship-explanation: The commit has typical human characteristics: =
domain-specific BPF knowledge, concise explanations, and follows kernel con=
ventions.
> issues-found: 1
> issue-severity-score: high
> issue-severity-explanation: Hash bucket mismatch causes selems to be inse=
rted into wrong bucket and never properly unlinked, leading to hash list co=
rruption.

