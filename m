Return-Path: <netdev+bounces-295923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +gFNBwsOI2odhQEAu9opvQ
	(envelope-from <netdev+bounces-295923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 19:57:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D728764A5C4
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 19:57:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=O2bCJw07;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295923-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295923-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29C4A3015726
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 17:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAF63955D1;
	Fri,  5 Jun 2026 17:57:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE9A3955E0
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 17:57:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682247; cv=pass; b=lEwEC+HzLW/E2n1oRirIfPWHey5HNRX1NeHmpdBaVUR5HCBUYq+qCGS+6VD2WwlgjX/g2n7OVV+uYviP0tb9VO+RBVNyQbkHfC9/imbz20H1dTB/3jFI3bQMegH0mqYmsTR8Dq7Mz9hBFuH9uSmgsnDZev7UKZLSH0ipvSgqwxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682247; c=relaxed/simple;
	bh=B/ePAnDi7gjX0wObDwCkcVlhRTzzZqaKwRsAtFuwlh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMn4CoX8LFmvDkeeLWijmMI8gGLrE7975vZVcy+tSScgdUpjhtwVrIAEYDNhornKeVp0gcJIOLc5Uae9OyBOuEzzXgfNW2mhX7wGNL+YNVdkS9ufKsLor/xMqtQwwhZ09KThYc9nKUFv1+lMZ/piXEKdf472G4+1p7GUmLHTMOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2bCJw07; arc=pass smtp.client-ip=209.85.128.170
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7dfceeaf168so22072287b3.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 10:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780682236; cv=none;
        d=google.com; s=arc-20240605;
        b=L87I3y6gaLP5oh7njLNCFocn6/X6Lylnv0oVPUhM29KxQ1gnWM/iIIBB77VfIf1Jmy
         VRH+JTh439slmAgsfPntnTu0uOj/1ciRMSpHt3MUF0mEPZaUGhANG4xs3onopAHH+6Wg
         ntAvlXJucrpyMsh3QzY4UYDsq9A3nmLQYisP7HqlglBTqowXecYjmvWN/VpYj79+a46P
         7J6BaqF2ZengiOySYgnKQR2B7gW3mVqAzVDGAxC6MapQQScfkKFh1AtM37zjF5K3Lsqb
         NeE7OPzhMNQaGTfo037c1OHQdIzMfjU6L7EUzM6mpofgVt4UKQCmG25yVbXm4jmqIJLU
         Vt4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cmSM1b2FxFpkiErqZSBNSk3eQpOEWiURszgQnptqPlc=;
        fh=O3/uHS+IR24/Vw0wEM5O71HS6k5IaaMbxY84wD8WCoE=;
        b=XtWdP5mvsDHpgwq9VtTezqSUzhkEzDChV5xRpnSIvO/4usBCp8fpVq2tzG/mXNAF+5
         2BRKRR3LVn74ayQHlYMNqXHQT1hWh5bcmSmO96ywhDBvjbFpUsIe9ihMP/FWM/8fOPbv
         V17faPRVOak4KR+q7ja3OVvLNg94VFN7j/GIGnKDTvpGzOc9fNuu9ex0XaTNLe5ENiwe
         5RdkGwMp0Ia59fX9nxA7mrM5c7oKcAyFrqQftX6G15Rr+mMauWFMg0sjy/0CBd3x6cF2
         uF9OzWCiRvY62x2/dXl+oouCk/8pvKEur9PQdyXAFd66FXP20GA661XZWmSExZ/V0UP/
         AFaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780682236; x=1781287036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmSM1b2FxFpkiErqZSBNSk3eQpOEWiURszgQnptqPlc=;
        b=O2bCJw07DLfQWvmBGuR3QGWI1JZRQqwYA99ti0db9Z7XaHTLhsT6CWZbxHliSrwZpm
         P+OBVP15CWWtekRTymKVuWeexM7Wo3upElF122SII+PEDuiwmfN7JmsBFe4FTJgYYoEw
         zb0L/uSx1EQTIEJc8elgj9BYNy5pkcS04wJ+y/vwCZ9Ce4pSmZH2x2f2qndyxxpNQKzM
         seJMQEV2NNlXoaKVVSPA9XL21xl8Y9VzfdWuf9Gz3tYXO0csZSOarqxm45dWSIvDt1A5
         7DCWGZ1Fxx+bG13JtfFd9ommDt1xSFIFM14wXzWcxJqSTGP4PEoTT/Mb/a4dPZ7wljUT
         32vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780682236; x=1781287036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cmSM1b2FxFpkiErqZSBNSk3eQpOEWiURszgQnptqPlc=;
        b=VvfXBBVIOf3U7oj3pgc68Hmowcq39G/Ne5OHdaIP0jWbxj9oDKR9sj8G0JfD6lXJtW
         8bEAZKHnXQCyWD0T6BmNvkeVmh8yaFmVWOrqcIoqW3grKEPvqAhk0t2JckHlkTOGwHG2
         lhJVbEsHjwe+AIsZF2/KaJ4/lISmkibz9kQw0sY8j7Ieju5H+PlKk1/fbkNH/T1f9wei
         yGRZrpA3MIzzRQUkd+cwi8c3hgWXx9BkJZN8MhiZUNVP4cGt1/z05f0ENJQYKVvlmdry
         0fzM1UPJsM3egolrhG/cD++nBuU4oCavNjzIQU+2Laqoqy6TUV8Bub+Eis0G2aG6gq3H
         qRSQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ccT9bwbLVhaMWr6SEmHxu2IxPH3+oaB+JBh0j4Pnvvo9EzXC2+apnybgAWrUJ4YmQGK2vqT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqF/ic4sBTIadGQOKFx00JFh70wT+Rb2uFEfpWYHdXS7EIjyCy
	uy55DKS2NaQX0FBBJP7LLYXFPv8J168c31E+ZvirQ5sBXPzRCI8AQPTqy+ofCGK9WsXH5N8fQaW
	vbmdnQUmrVxrRdh/dZr8q4zQLSwYfAU4=
X-Gm-Gg: Acq92OEGpwpfBbOG0PCRtr9REvBrvfUua2QrWQDwVU6VulKIqUZOtRRIB98rHBzZlcS
	RY/cDnoFTbxdYRbQXt1W0CH94YMqPySMuvO3975VETJg+7tz+bQ/PbBY9hX6cSEedDIIRaASvQG
	PmjUQmWSlsyJrieduzz2omX31Sr9hOvV69y2aM8Yc3d5TN5+NQ9woXc7W6D0b2ZHdP6EGkgIfWF
	PVO+TLB08PDWwE2Yqold7f64qSEw56gXXNBUy763Yxf8Fm/ImxeX7fLRJH94MwqcypUbseLJ8Ej
	fK6Y5kxsUZmFz7tCXBYfOsmQv2BDDLdGtQ==
X-Received: by 2002:a05:690c:6a11:b0:7d1:c256:b5c2 with SMTP id
 00721157ae682-7ed11288b78mr49193467b3.33.1780682236167; Fri, 05 Jun 2026
 10:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604220904.1032145-3-ameryhung@gmail.com> <a5988106169c7350f39a4d07b36b679a5fb39cda49ca371cb79c23da7b63971d@mail.kernel.org>
 <b4302a13ccae77b304a09b47c58565c8ff1970c2.camel@gmail.com> <CAMB2axPLpxk8fh-Qp2sGwtsZBCE42DLo+h8pB+ObffLifP9aZg@mail.gmail.com>
In-Reply-To: <CAMB2axPLpxk8fh-Qp2sGwtsZBCE42DLo+h8pB+ObffLifP9aZg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 5 Jun 2026 10:57:05 -0700
X-Gm-Features: AVHnY4Iiyh1DufQo6AdcLUGItcW4SgUvYf0y6EkKBe7FclLb_9ezORLnhygaKT8
Message-ID: <CAMB2axOOG3ptDkWvTDpGut+EmDeroe3GPR3obb-Br_Dg1aGmgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, 
	kernel-team@meta.com, ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:eddyz87@gmail.com,m:bot+bpf-ci@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:kernel-team@meta.com,m:ast@kernel.org,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:bot@kernel.org,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295923-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,iogearbox.net,meta.com,linux.dev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D728764A5C4

On Thu, Jun 4, 2026 at 4:27=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> On Thu, Jun 4, 2026 at 4:21=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Thu, 2026-06-04 at 22:59 +0000, bot+bpf-ci@kernel.org wrote:
> > > > commit 89f2be9817e074d02702d22068104fb9fd9aa103
> > > > Author: Amery Hung <ameryhung@gmail.com>
> > > > Date:   Thu Jun 4 15:09:03 2026 -0700
> > > >
> > > >     bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
> > > >
> > > >     refsafe() compared each reference's id and type but not its par=
ent_id,
> > > >     so two states whose PTR references differ only in the parent ob=
ject they
> > > >     were derived from could be wrongly treated as equivalent and pr=
uned. Fix
> > > >     it by checking parent_id too.
> > > >
> > > >     Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > >
> > > This looks like a bug fix for parent_id tracking support. Should this
> > > include:
> > >
> > >   Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking an=
d fix dynptr UAF bug")
> > >
> > > When commit 308c7a0ae885 added parent_id tracking, it updated several
> > > safety-checking functions to compare parent_id but missed adding the
> > > parent_id check in refsafe() for the REF_TYPE_PTR case. This caused s=
tates
> > > with different parent objects to be incorrectly treated as equivalent
> > > during state pruning.
> > >
> > > > diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> > > > index 5945956a7573..06d9ae24f006 100644
> > > > --- a/kernel/bpf/states.c
> > > > +++ b/kernel/bpf/states.c
> > > > @@ -890,6 +890,9 @@ static bool refsafe(struct bpf_verifier_state *=
old, struct bpf_verifier_state *c
> > > >                     return false;
> > > >             switch (old->refs[i].type) {
> > > >             case REF_TYPE_PTR:
> > > > +                   if (!check_ids(old->refs[i].parent_id, cur->ref=
s[i].parent_id, idmap))
> > > > +                           return false;
> > > > +                   break;
> > > >             case REF_TYPE_IRQ:
> > > >                     break;
> > > >             case REF_TYPE_LOCK:
> > >
> > > This adds an extra check_ids() call for parent_id. Could this make it
> > > easier to trigger the WARN_ON_ONCE() in check_ids() via BPF_ID_MAP_SI=
ZE
> > > exhaustion?
> >
> > I think the bot has the point here. Let's switch to reallocating idmap
> > or failing check_ids() if there are to many ids (probably an
> > unrealistic scenario).
>
> Make sense. I will switch to failing check_ids() first since it is
> unlikely for sane programs.
>

Actually, looking at it a bit more. I think I would hold on changing
check_ids().

This patch should not increase idmap usage. parent_id refers to id and
therefore check_ids(parent_id) will reuse an existing slot.

The id_map is indeed more likely to be triggered since there is also
an intermediate reference for reference dynptr introduce during the
refactor, but that should still be very unlikely under normal usage.
check_ids() also already fails in this scenario by returning false. So
overall, I am not sure if we need to change it.

WDYT?

