Return-Path: <netdev+bounces-255496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOqsLXtUfmkRXQIAu9opvQ
	(envelope-from <netdev+bounces-255496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 20:14:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE70C3A05
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 20:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3123F3004605
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 19:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1343B369233;
	Sat, 31 Jan 2026 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqwclV+f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A325C367F5B
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 19:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769886839; cv=pass; b=nCY+gjVf1t7HiqWyXOIRV/exe3FrIsRHJLvmZ6WYlDRazkBTuXwvuS8cjW5Ntrp2bZNFIgA1b6QHTdk5TdXcACgvRYI0zNIoqOF/nygpdgkIzInKvp6MmmXudjGHl79R5ug57MjobcEQ9sHfq29wN+/nja46DfgfrKF3PtGsM1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769886839; c=relaxed/simple;
	bh=ekOn+DEhFEy/8AkcFkDhbU/K+bPIUURUGDSbh6V3fUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FY65bYs2qD5dyzj6xm+G3brjYWosEQHR6A93+37Lt0hp6B9/J9FeIv8haqkapaSrryuSKEY01OnD0GVq0b2UiJbCZDdOwkMQ8CFoqOx0eaK9xjmN1X71XGmvZh1jmzIxsA/n/6DzMZ3mCrye9KCnIEEdy7kNi1qyh2dR/wskYQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqwclV+f; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-649ba412b8dso279553d50.2
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 11:13:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769886836; cv=none;
        d=google.com; s=arc-20240605;
        b=KDI77BUkGYNuXRnCa5VQ2xXHBjgv0gOHmH1fr6dBqwBQdC0G0HE07bbfiTvd0dBbHs
         BThlFW/LFcJ8YVpDkHU4i6HIegrNEqyOJKIN8GYJlVvpT3B7JW2cPblfwBHi73VT0e6L
         abwMcWoPFtsmwaTtBHe7zCwK/OJK0qFveCEPlQyOx/q5bPaHKDo68IigjJIGKnNeFAii
         Tw2XQSc/qpGztNl9Kf1OQpr0jtleIUhan0MU+rjRymBxD35H2gHhNyDyQAWVMAFZixY2
         EHVSRbi4XsOlu3uOLesClIh+Ygx4+Xc7nN89z9PM/bMc+Sf0I4XUF3XgVSOh21OqUHdW
         aQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=08g6K7KOBWEXWExX7xDMLno5kwYNjpmPpi5QBvnVcUw=;
        fh=E4UMtMSm/00mOsYPkV3TdiCnHwikF9p1U/Q1s4PbxXU=;
        b=WSsPca5MTDpvBEIvsFP/7NaTGyQB2rRdfNdmKekM2D363VDH3IY5CwljobYvyxKxCO
         RxhG7ZY/icK7Jmv8n+DYrwEICAPeT9a7uKU+YTtaHc2HcS/JgPIcqZCaCPMPk350N9yX
         c2AIuq4st5tNIFD2g1oxvzVFN0WGASq0gtJ+VmkBAlsQTKqwUjX54BJUU8oq0Zmu7hrH
         OnjfneCcKCXQfKcI3e5ScOd7iAhP2f3kB0OIoe1MJdR0JHihdNGIFdSKTJa0zNATTF6O
         qOr8vX14SH2Yfn+3UpB45JXYR1/qeQ/Ocjz4NbxM2nDFfWuC2uk8UIbxQzG0d4mNsx+a
         wT7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769886836; x=1770491636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08g6K7KOBWEXWExX7xDMLno5kwYNjpmPpi5QBvnVcUw=;
        b=fqwclV+f+UHilYybE4RcCC5YyWf2DFmkimjysZNxNmUvigNJ+BCwPPpHAaoFmqx9fe
         kH5O9YkNoj2H5Wi0HyO3kHCD2YfsAot5rOGpaOn1bQmzCcwks+XXwci3fZ4/iUfJQ7He
         6UO81YEnaVCjSVXN4N4vW/vcyDD1kjorpD4DhCpJhQZlt+mknaLtKkceWn/rW0ekXFez
         ElzgKS8iRc3Yp+gAkugT1gzEX5u7LE5TMVbroPDXB0kpY7Q9pIp8BNZ1aKd92VLfxCvK
         RcG7LXaTlgCcT3UE1ZPOoi3lHwOjxfogGK0zynqEwcM5BQKSam1opbN3mmFIRqIBnjJp
         uTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769886836; x=1770491636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=08g6K7KOBWEXWExX7xDMLno5kwYNjpmPpi5QBvnVcUw=;
        b=Teo4dST7htxl5hxaI0WrqRBgPQxBAzSLVbJANoMYXVA4Sfw5XCU1kfmfh9TZwdBsrQ
         bRjlyIlTv355w8iMNCXEVKMY1DMuw3UdrPH5HUAMu1wlmcE0MXU09X+XgXcSyvnaPC7t
         yHsmJ9rkhWBWdfNip/RCtTcpl0zEwC67UHi8fgldWWDYlJM3iU8EV41XBTzCS9xiG9VJ
         7COg4nUM/hN6sSZnjEqDNN6361fgQGSbke+FRM9CwLbluS1waAv/iMKb1nK8oBKu2d5f
         oCseneIkZRuxNAn8pUk6OApo1/mha/pGuXmlNocAHo2UHqR+e9B5Rqnh4jwI/5/Ebz9G
         T/JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh+xvDUex2RKqGglz+bgAOIlc9MpxB/sVfNGzJ/VdqyCSLAtxLuehO1R4TTRUoxGZRwy90hQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrYCOj2FtafAHtJK1MDTYvxFH/JuDYEIUlqf4kCAc2X4NKB2hb
	UCpQfBT/FDMwSWF3B29emAUWXB45zDEjgp4Z9GD2gHMPaEof1fkXg88LbjjMF8KSBIaYQlF67cR
	JGDtvksA7+xtl127FjyDukeH0IMRss54=
X-Gm-Gg: AZuq6aKfvdUiYyFePbbB+iqkzFdRcBvGJ5SlMYq7aXq3JJSt+5P9U3ZSAkgP/IgY6RW
	V+SW9fPpF+HLjLmcmoO+XjD2oJsPJe3abqUJiIx9EeQAaVZX+8qLNVE8X6rQxUSen9cc9nD/Xyv
	FxsaFNnIC5qdw9lO6urQ67R+dAnVhKl8wPkh+MjeBAKtcH2/Z2tlsEFbnX3cGfTJsHxl6mqCvxy
	iSSPOntlZiPqozsqwEkaZMVUyEak/lVJaWd6pTylRS06m9psAsFbvObRpEhC4i08I/2Bx8=
X-Received: by 2002:a05:690e:1510:b0:63f:9937:6cce with SMTP id
 956f58d0204a3-649a849ef6fmr5497104d50.61.1769886836545; Sat, 31 Jan 2026
 11:13:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131050920.2574084-2-ameryhung@gmail.com> <fc5f36c2f50b99cba8b9b6d020a7400911a84c372ca15be7707c8513239228f3@mail.kernel.org>
 <CAMB2axMA_8t6M2RJ97Y-9BB_E3N0h=9ZKArazbNKS_ySuNkKAQ@mail.gmail.com>
In-Reply-To: <CAMB2axMA_8t6M2RJ97Y-9BB_E3N0h=9ZKArazbNKS_ySuNkKAQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Sat, 31 Jan 2026 11:13:45 -0800
X-Gm-Features: AZwV_QgR3Qklgxr5I6eJuJay4vGJHsEohIefeJJW_1k08xFjlty2yd7F843ksak
Message-ID: <CAMB2axOyfFGdDbyZO0tBvj9Yv9=CGrT=9+a_A4mu0OTjwy7UUQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255496-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4AE70C3A05
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 10:40=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> On Fri, Jan 30, 2026 at 9:33=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
> >
> > > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_st=
orage.c
> > > index e2fe6c328..6615091dd 100644
> > > --- a/kernel/bpf/bpf_local_storage.c
> > > +++ b/kernel/bpf/bpf_local_storage.c
> >
> > [ ... ]
> >
> > > @@ -368,9 +371,13 @@ static void bpf_selem_unlink_map(struct bpf_loca=
l_storage_elem *selem)
> > >  void bpf_selem_link_map(struct bpf_local_storage_map *smap,
> > >                       struct bpf_local_storage_elem *selem)
> > >  {
> > > -     struct bpf_local_storage_map_bucket *b =3D select_bucket(smap, =
selem);
> > > +     struct bpf_local_storage *local_storage;
> > > +     struct bpf_local_storage_map_bucket *b;
> > >       unsigned long flags;
> > >
> > > +     local_storage =3D rcu_dereference_check(selem->local_storage,
> > > +                                           bpf_rcu_lock_held());
> > > +     b =3D select_bucket(smap, local_storage);
> >
> > The commit message states: "This is safe since a selem is always linked=
 to
> > local_storage before linked to map."
> >
> > Is this claim accurate? Looking at bpf_local_storage_update(), the orde=
r is:
> >
> >     /* First, link the new selem to the map */
> >     bpf_selem_link_map(smap, selem);
> >
> >     /* Second, link (and publish) the new selem to local_storage */
> >     bpf_selem_link_storage_nolock(local_storage, selem);
> >
> > The comment explicitly says "First, link the new selem to the map" whic=
h is
> > the opposite order from what the commit message claims.
> >
> > Similarly, in bpf_sk_storage_clone() when new_sk_storage is non-NULL:
> >
> >     bpf_selem_link_map(smap, copy_selem);
> >     bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
> >
> > Since bpf_selem_alloc() does not initialize selem->local_storage (it on=
ly
> > sets SDATA(selem)->smap), and bpf_selem_link_storage_nolock() is what s=
ets
> > selem->local_storage, wouldn't this mean bpf_selem_link_map() reads NUL=
L
> > from selem->local_storage?
> >
> > With local_storage being NULL, select_bucket() would compute hash_ptr(N=
ULL)
> > which returns 0, placing all newly linked selems into bucket 0. Later w=
hen
> > bpf_selem_unlink_map() runs, selem->local_storage has been set, so it
> > computes a different bucket and tries to unlink from the wrong bucket.
> >
> > The next commit in the series (82de4fd08 "bpf: Convert bpf_selem_unlink=
_map
> > to failable") introduces bpf_selem_link_map_nolock() to fix this for
> > bpf_local_storage_alloc() and bpf_local_storage_update(), but
> > bpf_sk_storage_clone() still uses bpf_selem_link_map() and appears to
> > remain affected throughout the series.
>
> AI is right here. I will fix the bug. We should follow the
> local_storage then map linking order in these three places.

Actually, we should link map first. I will pass local_storage to
bpf_selem_link_map() to get the bucket.

>
> >
> > >       raw_spin_lock_irqsave(&b->lock, flags);
> > >       hlist_add_head_rcu(&selem->map_node, &b->list);
> > >       raw_spin_unlock_irqrestore(&b->lock, flags);
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/REA=
DME.md
> >
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/2153=
9340647
> >
> > AI-authorship-score: low
> > AI-authorship-explanation: The commit has typical human characteristics=
: domain-specific BPF knowledge, concise explanations, and follows kernel c=
onventions.
> > issues-found: 1
> > issue-severity-score: high
> > issue-severity-explanation: Hash bucket mismatch causes selems to be in=
serted into wrong bucket and never properly unlinked, leading to hash list =
corruption.

