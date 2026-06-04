Return-Path: <netdev+bounces-295481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xEtsGFQKImpcRwEAu9opvQ
	(envelope-from <netdev+bounces-295481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 01:29:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B241D643F37
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 01:29:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nZqCdzqf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295481-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295481-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64CBD3007F60
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 23:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970F3377ECA;
	Thu,  4 Jun 2026 23:28:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CBF379C57
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 23:28:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615683; cv=pass; b=dLvre9uotfNh5VfVQlSCAfQApvyBeyfCH8Bet79+YhuPLzAtEr6c5Ob+9Ran9ZloTYAgcktB61pAn3yAZ4tjwK/WzFQiJKKimSWY4Ssvf48DCp7sAY+DX5HQpdsMPxbLgy3ig+bhZnKngHLolvbGK5erb/dFs2LlAdzWULLuLn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615683; c=relaxed/simple;
	bh=0wvm306Vn7codzwbmQbdXFGfp57Ka7LuwQS0c2K9C44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJNWCuVSXPDQbF5taDctgYXahZ6L30mGSGceEEZvQ0Cy/dgjdM7RFwmS5cqqZzejIvlN2c5E9DDxBy3laH1hkIy8Iy3VfJftMqnIBvIK5UK/lbP5QYqLcLy2kDe6AQIPdccfhmI003qLkBlkZaEUfrToXMeto5Rk8Z5W3yitckY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZqCdzqf; arc=pass smtp.client-ip=209.85.128.182
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7e053987001so23490327b3.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 16:28:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780615681; cv=none;
        d=google.com; s=arc-20240605;
        b=FMc2+zmJakFxLvRB1tlVvGfXH/qj+L1FDnHSMJDC6H+9oRo624OkWzkOZnS02oIcd2
         1EvS5VPuz/+yb/AUNU3/3P8a1BqGdqsj/bftq/Dj/fqVA+lbyRTcIh7mDXNHjHtNpbI7
         LliMSWHfe4eoY83CWfPakCPaswoar5S5jIMINmSgZ3l1vUvw9L2dDZRRk25OO5WFVIrr
         d/Zfp78dIAdIVNsACeA1eTOcS+UG+MNDITFNb4gCUugd8BjRRP75ruYiC8oIxAI2U56X
         KQ3UK0CL3pgP1eH3vGhMOZ6h0SakB44/Y6O9t1BDPs92125Qe9pzMSHk7EMhUW3jhdfQ
         jjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tr814ukOJvlcYzx1VITy464T91Mqo8/bGv9DViNTSUs=;
        fh=3USaid6PJlpXExVn9US0imHG5lplY3bWoD8LdLQbKNo=;
        b=FDcjG7yMGrrnUjnbL8Vqd+rn5w27E2CS9FFx9AINHWP5nNbNpsB26catJc1HO09GQ3
         5CHVfuNhvrlS9w/5IlXGQjOMHS0Opoo/R64KZ0ciNnOVOP0UvEoZdiMTNjv+8q1GvBcZ
         YB9kioI7NC4i2bRGB+IQt1DtFGV9VvGDRTco7+zxOIA7ZOXSRwmTqmlKUzTnBxohbANx
         PyjYX5O6jIa5DfHmX+jXfFMBjr4tvVvmTRZ9kB4eKSXWGEmt0niMwTUWG6gkMkUHAyEN
         K8woGz7ise71/7XcY7obj7ZP5urClXjjOrVy/k5W9u1nKL1Nk1BJy2tBcRhqoqaGe2JR
         i7Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780615681; x=1781220481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tr814ukOJvlcYzx1VITy464T91Mqo8/bGv9DViNTSUs=;
        b=nZqCdzqf/2VoDdTzJbey+Hgznh0gerd+ouE1RKw/vq0v26eTjrYjL8p8Igrxct8GEl
         5kNyk0KAK163+juVjh68ZrZXKRhwwewUsP94u2zo9XqlHEhUV+AVl9qnMM5A15Eqe+YY
         NBEQz5T+NZQGwnAyA+rsfbTj/rriTVevenQuELoF0ZkodwrzjvOUV0JE1s/7Yqn4kXdl
         cxvmx+4WzA436gAwh3uuUiGP0VCHuBk1scLwRzPF2NrmD3PI/n2BZMsGdr6oHc7Fou0e
         9+XESp06S69W7KjRex2s97tT4Y7lfyvNglKJLklLEuUmoSJfxJNtkrjbpNCh27YPJe9X
         wDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780615681; x=1781220481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tr814ukOJvlcYzx1VITy464T91Mqo8/bGv9DViNTSUs=;
        b=mJvF3Me+nQiYz8j2+CAAqCkd4F6lW12c3JTgv6r11cw0ZQvyDX/BQQAcInqvRJ7h0X
         b7soFBUxmBjB/MHZUMABxFeHFMnDVrIt0HK829fpQhKlyRMY2IRQ8oMgH8OC+Li+mfsQ
         rfCJSbjc/yxRD9ZfwmeeZyaJ7oa9KeiN1WurWi+24JdmDhHEhbV7yy/rJ4e5BquEQUKU
         sbnHnUl9aUA/9hJiZMoRsDL/Md0kA0CWlnmBRXC3YndAgJx+eYZpZBnvaJZROiMqw8p7
         cAF5ZSAeo5iFj5r6pb2rlJzMZIoBOd8cM8Bh/i9iTEq0qqY9UVw9dUO+kzjNd4aAfKsp
         OuAg==
X-Forwarded-Encrypted: i=1; AFNElJ9n0YDWNCrbwzwIGjpTqn0tfi9Q/WRgMBEIQj9bGvMoGzH//06ek+2rFF+o/AeTDeJiDXRBN/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiopuxTfuacHDhvw5WVZYXiQvJDeb00l9m+GWbxS1ySwEW20n7
	XEOGTX8I5OMXMFrpi+ajw7bBw142RC7M4zaa8kTY25Xgz1KAz+h1kWk/wY3jmF2zn9kngE1Jnfp
	dfEohMJmLs175W+Iz7TvzALT28vLQB5E=
X-Gm-Gg: Acq92OFkpTGbs2Uj5jqYDwCIBS5acJDaYk2ln+v1F3xZRR/GQF+QQhrg3EaWPAJmLjd
	15THauf4626GhcTm1LGNek3Sqn9PBNIEksbtAZwetYWxpxIvToPPsX7XgVVh+ubAv3ZS+t1FmvC
	spelt69Q2w1Dk4DnJ5wbPtfb+vfmTEFpP7+6sR5SXeb0YzFRliNSuIl7Yw7eMvWIdRQkpSQvZuu
	yVjdE8ukqEoe6XCP5g7MCFQeTH5jiyr41jk9rt3Sbf25GuAum5vxKXbfOq+khkiTlw5XJZ7LSpG
	MnLfRmDchX+0c+QYag==
X-Received: by 2002:a05:690c:4d8a:b0:7bd:a94b:5df5 with SMTP id
 00721157ae682-7ed5097a77dmr1068907b3.8.1780615680908; Thu, 04 Jun 2026
 16:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604220904.1032145-3-ameryhung@gmail.com> <a5988106169c7350f39a4d07b36b679a5fb39cda49ca371cb79c23da7b63971d@mail.kernel.org>
 <b4302a13ccae77b304a09b47c58565c8ff1970c2.camel@gmail.com>
In-Reply-To: <b4302a13ccae77b304a09b47c58565c8ff1970c2.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 4 Jun 2026 16:27:50 -0700
X-Gm-Features: AVHnY4Ja5FO0GpDTrS7Dkk4N34t-5_mq2ZDIPbAIwsfjitIIRfX7_LFokMAE9hY
Message-ID: <CAMB2axPLpxk8fh-Qp2sGwtsZBCE42DLo+h8pB+ObffLifP9aZg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
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
	TAGGED_FROM(0.00)[bounces-295481-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,iogearbox.net,meta.com,linux.dev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B241D643F37

On Thu, Jun 4, 2026 at 4:21=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2026-06-04 at 22:59 +0000, bot+bpf-ci@kernel.org wrote:
> > > commit 89f2be9817e074d02702d22068104fb9fd9aa103
> > > Author: Amery Hung <ameryhung@gmail.com>
> > > Date:   Thu Jun 4 15:09:03 2026 -0700
> > >
> > >     bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
> > >
> > >     refsafe() compared each reference's id and type but not its paren=
t_id,
> > >     so two states whose PTR references differ only in the parent obje=
ct they
> > >     were derived from could be wrongly treated as equivalent and prun=
ed. Fix
> > >     it by checking parent_id too.
> > >
> > >     Signed-off-by: Amery Hung <ameryhung@gmail.com>
> >
> > This looks like a bug fix for parent_id tracking support. Should this
> > include:
> >
> >   Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and =
fix dynptr UAF bug")
> >
> > When commit 308c7a0ae885 added parent_id tracking, it updated several
> > safety-checking functions to compare parent_id but missed adding the
> > parent_id check in refsafe() for the REF_TYPE_PTR case. This caused sta=
tes
> > with different parent objects to be incorrectly treated as equivalent
> > during state pruning.
> >
> > > diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> > > index 5945956a7573..06d9ae24f006 100644
> > > --- a/kernel/bpf/states.c
> > > +++ b/kernel/bpf/states.c
> > > @@ -890,6 +890,9 @@ static bool refsafe(struct bpf_verifier_state *ol=
d, struct bpf_verifier_state *c
> > >                     return false;
> > >             switch (old->refs[i].type) {
> > >             case REF_TYPE_PTR:
> > > +                   if (!check_ids(old->refs[i].parent_id, cur->refs[=
i].parent_id, idmap))
> > > +                           return false;
> > > +                   break;
> > >             case REF_TYPE_IRQ:
> > >                     break;
> > >             case REF_TYPE_LOCK:
> >
> > This adds an extra check_ids() call for parent_id. Could this make it
> > easier to trigger the WARN_ON_ONCE() in check_ids() via BPF_ID_MAP_SIZE
> > exhaustion?
>
> I think the bot has the point here. Let's switch to reallocating idmap
> or failing check_ids() if there are to many ids (probably an
> unrealistic scenario).

Make sense. I will switch to failing check_ids() first since it is
unlikely for sane programs.

I will also change bpf_insn_access_aux::ref_id to int as pointed out by sas=
hiko.

