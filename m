Return-Path: <netdev+bounces-293921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AmgH5caHmpahQkAu9opvQ
	(envelope-from <netdev+bounces-293921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 01:49:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 861F16266E3
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 01:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7532300847B
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 23:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA11366052;
	Mon,  1 Jun 2026 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ8YZ5WL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D49125B0AB
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 23:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780357778; cv=none; b=mntDEfXPCrmNekdtZxteXfzCBbnM/s+cllWDrGK5stre0KSWuvwfr6NnOzdXz5cDFm+CjXS18rdEE8Gt3VyunLxDKpp+xU/qrvwfIfL/2dFVs1VjKOdthdInFp74BV/SCi7qY5KOVTJYGcuCuEvreb6sG6rz5ZI+iOc5YCe8NUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780357778; c=relaxed/simple;
	bh=LFJb4dUI2q670rL9vw2sGnQYlfcHgeUXGpkRSOp+BPA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=plVloVdR+Kr4U0nkRTvHHSWtxntY7FMRRDyzfK1ujgJyAdTTm5glaIzoR12babYKPdB1aVQNa2jDpmE4k/ihT1BIsJtEuWI19+skrtAAdVP5JlOIUZYHr7A3xGPXUD0t9ataDRDdm3cvu1vqsXrM0O/XCXqUP/FcFrJtW8n8T/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJ8YZ5WL; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-137eed84fc6so607350c88.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 16:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780357776; x=1780962576; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0BnYnRb2vtofh/fDuwPVdMwfNTqYx7MoOXZN6LCoYYE=;
        b=YJ8YZ5WL6wLvnPGV5Wz9l11oxY7Vxb6/oOMrSLDaf7EhSCGvtjpcMLary/0qX4rjm2
         rFCk/pIZ8kEIsKYz6w6xdoQTQcBRTnrPaIW0ahuSAYFVJpLxyWPGzp1Dp3yt9Ru9WHtz
         xYjD9e6GO5RMZFJUVP5RvLT2KIRaQkYEI8JODg1+ir8s+0aSsvKZqRMX8QlUgcBylJD2
         nWy6XeYMrsyxvIdDwCl3bsSTysQDjHXsqtgDrRhJ822TRzf6d/z+Y7DH1tOpCKq2Bh7/
         4Qz5GYg/mwwRQyHIqp480ExZxiT40KAHhuQ2EbpvvGkBN6hABvPJk2gYNCgkWZlDMD3r
         RZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780357776; x=1780962576;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BnYnRb2vtofh/fDuwPVdMwfNTqYx7MoOXZN6LCoYYE=;
        b=eUDUFrP81RoSEYVkNIfhCsl1PeTQwvp2sNMW/k0mhDh+zZkhS98lpm4oY+fHbZ63Kb
         Wue8xuIdD+PYfqCud9wTQcOR3vLMFvdQnME6qDT8Ge6vaKxIMlBokji8aUVri6jegiX8
         XwGmNMhEn3V/tdGMVH8Amy+o2fuAgab7qfVwM6HnFBWmwFnNlU9xT9L4m/xt8d3581lz
         zMZPyx6H/xRI0hJoD4zNtovNCB9yQsG6QsZUFqj1L4tE4Suh6mhjcIyrV8GgQ/fwkRLF
         O/8x9FVzSYLrkPc8gUFXq/Rdc5CYEacIqP2fLamg+lNE1E4YrxeXRuJYKPFMR//4gfOZ
         3m4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+GwqVAVun0Lwfc/NA6NRAlb9mwzFZaj8kF7cV/W0OLozswOgAPsQhiFqnkHo645CVUN47OiMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMbEnjvrpraiGYihLcTrk3GAnC8XEOicyta0PtZWBj0bT2O4k6
	RVHL2sXXaxBMdr2NbBDIICaXqGUfR8Kr8RDdOBuCMUgNzhg1HTrGZMap
X-Gm-Gg: Acq92OHosUjD1Ut6uT2cv0kPmRuPCs3lZVvlGYTN8QFphVw6mSwqtZsaVCsMpN3dpVg
	yVYDMFvAmMj4lbizCrhoB8vKBPp9DBV8o0OZTcJ6F18QCgEd0dIifskjURpOSfXllHxZX0TSS12
	pROpJG0T9zsEOdzkF7dpBXZ9/B4w4RsYc7ruK2B59ZQC+RtzWkJNE9y/Wimq1Ub4kgZ93XVIRqp
	RLInKswmT1AaX3z39ikF9xvu53RA1Hs3ehNorM3n9rrv6A1GuMSw4whXE9FKSacMKFPqJPyu/De
	6SS+P90jH7MoZk4rG9rBknG9JBUPVPDJ80eFhsoscnXEPP49bBabwSOrsM1e7x7Cq4fje1rXJmv
	uPs3y10XaEa5eyEZ/yviTPcnAKozH9Hx/8OMWLTqADsjpvhT2qnYw9SoJKWft4qA5rwa1pnF9Zo
	nNtIasBiigoKDeCZbMOzZcSmDT2kipqPSHOx1C/ju7LQgrSWZUURU5L61Jdnhdxt3s8ClQkI7t7
	RjeFtNrq2GCTrZn9P8=
X-Received: by 2002:a05:7300:2327:b0:304:b15:17d6 with SMTP id 5a478bee46e88-304fa49e2c3mr6375469eec.6.1780357776433;
        Mon, 01 Jun 2026 16:49:36 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c6ab:2254:f011:38f4? ([2620:10d:c090:500::3:1ca7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5d5385sm10073688eec.28.2026.06.01.16.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:49:36 -0700 (PDT)
Message-ID: <50097b521bbcfe988db984df73b9336fb32ae6e0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 05/13] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, Network
 Development <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, Mykyta
 Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team	 <kernel-team@meta.com>
Date: Mon, 01 Jun 2026 16:49:34 -0700
In-Reply-To: <CAADnVQ+K_=xz6f3Czoj6f6AeO6Bh0eyq-ambF11+hYq7DZq15w@mail.gmail.com>
References: <20260529014936.2811085-1-ameryhung@gmail.com>
	 <20260529014936.2811085-6-ameryhung@gmail.com>
	 <1bf1a11fa5dcb38287384833dd77c748f3a766b7.camel@gmail.com>
	 <CAMB2axNK9rf12YyLjfeUHWUpGEf=UrCtdHcgd2Tq6KcFY1ergA@mail.gmail.com>
	 <37d229e482df3367436d9475d6e9d6d69c7366a5.camel@gmail.com>
	 <CAADnVQ+K_=xz6f3Czoj6f6AeO6Bh0eyq-ambF11+hYq7DZq15w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-293921-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 861F16266E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-06-01 at 15:35 -0700, Alexei Starovoitov wrote:
> On Mon, Jun 1, 2026 at 11:41=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Mon, 2026-06-01 at 11:36 -0700, Amery Hung wrote:
> > > On Mon, Jun 1, 2026 at 11:00=E2=80=AFAM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> > > >=20
> > > > On Thu, 2026-05-28 at 18:49 -0700, Amery Hung wrote:
> > > >=20
> > > > I think refsafe() needs an update.
> > > >=20
> > > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > >=20
> > > > [...]
> > > >=20
> > > > > diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> > > > > index 877338136009..5945956a7573 100644
> > > > > --- a/kernel/bpf/states.c
> > > > > +++ b/kernel/bpf/states.c
> > > >=20
> > > > I think refsafe() needs an update as well.
> > > > Something like:
> > > >=20
> > > >     --- a/kernel/bpf/states.c
> > > >     +++ b/kernel/bpf/states.c
> > > >     @@ -886,6 +886,7 @@ static bool refsafe(struct bpf_verifier_sta=
te *old, struct bpf_verifier_state *c
> > > >=20
> > > >             for (i =3D 0; i < old->acquired_refs; i++) {
> > > >                     if (!check_ids(old->refs[i].id, cur->refs[i].id=
, idmap) ||
> > > >     +                   !check_ids(old->refs[i].parent_id, cur->ref=
s[i].parent_id, idmap) ||
> > > >                         old->refs[i].type !=3D cur->refs[i].type)
> > > >                             return false;
> > > >                     switch (old->refs[i].type) {
> > > >=20
> > > > Wdyt?
> > >=20
> > > You are right. It needs to compare parent_id, but maybe only for
> > > REF_TYPE_PTR like below.
> >=20
> > check_ids() should handle the case when parent_id is zero correctly,
> > so I think both variants are fine.
>=20
> if that's the only thing, maybe let's do it in the follow up?
>=20
> Eduard,
> are you Ack-ing the whole set?

Yes, I think this set is safe to land.
(Note that there was also a nit from Mykyta, can be a follow-up as well).

