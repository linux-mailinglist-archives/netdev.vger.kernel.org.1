Return-Path: <netdev+bounces-293916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFCLFw4KHmrsggkAu9opvQ
	(envelope-from <netdev+bounces-293916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 00:39:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6289625FEB
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 00:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D930C3006393
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 22:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C97434845C;
	Mon,  1 Jun 2026 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4AAvY/l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0668926D4CA
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780353373; cv=pass; b=DD5ngZgWQBXoCY4MX3Zxjx5iJ/nTICZ4l9jViKcAihXOGI83Lbu6OGLZc6CBGgPPw/MdBxufgJHHLza4sajURM+HPgzWhG0ADJsEod1OhbWBV7XAIOLgygN/ifD1ltOZGhf3wPSk0h12Jt45QRzoJLOSfnq4AEowNEmbrUnsY7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780353373; c=relaxed/simple;
	bh=qShT15SiklauvTxBI3HDr3S2EIVD83CbuXS1PnSYHwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rauaQwCt8oc7sxtdop303KY643FmfvazECqyFyYL2HNVUKQd+8gIubvZHC9gGCWjDZP7chYtxz060v7fWLDUuTG7LgcQVCbMnAsV69Rz9f5DxnM++4+n6TJk4T2eXMS2W9H7CMlXnVVzY0aNXtPtA3VgFhl3gOTLwPO5ZhYu0PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4AAvY/l; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490a7876f8cso17424825e9.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 15:36:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780353370; cv=none;
        d=google.com; s=arc-20240605;
        b=frS0Vad6ZoAsS8rjImtcU/x0PouY3lYCZFooAd3PrxTZ58mMDcacQPncfTXYzZWUev
         sayCArGMzi4870Dm93nMMBnDoCKZU7+A1h3gPTsbFrCacvjfYY3CmdFieuYnmwwrvjYU
         rCC2SyMAJum3x5Rr4z2mF2IJtHRgM9JNd/JJ82aNq/KD+2WVwuK/5icSeGKkQW17Le3e
         16KbUNE8jtgwTSLKSjmCXX9cvFhz1Gm/+/AN4SniHa+XxRQY3OQiArG/MsVxeN5xk0uu
         TnYSRkCDIgKm6nAcsA1W+TJb/QlmvHg+uLqQagwGWM46kqWE9E+a6ZQgjPGB5JeD+5ft
         EQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HLFcaG3D1qUmnaU8KnhhzIi1V2WP+UuBdpZV2zlitg4=;
        fh=5iAs2A7znG3qG6Sqyi+X21Wo6XfPvMmUN4xTjJfO16A=;
        b=Esx81MUbbjzQ7mpwfU8cr6zdKFQIjG5D/vMhCchzWYn2+AVJWjMjESg7DVQycJWPNh
         mQjhMajUOzGK27dCvv2BGJa+zfEn8WXgHwOF7kjmtIaAOVM4vQpDB+BlTMXqLDq7XKJG
         6C+gAg+8zkD99S6/hgDsL0skxU9dhi+VkUetDC1jmHuiYxeTPoTVX4csNhyAmHRx2sfv
         uVx7qcxnW6aaAdGuDZPcs/cCO9acoQnvRh+T5Kj1f/ZCywMHelJHhqjpzrOuYrq27v5M
         6n1mfy5sOKkR64iTx6G/DsTWi4hcKnJyThnTZddG+o8rS3cF1Pi3AxRE5cvx0pHMQKtF
         CAig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780353370; x=1780958170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLFcaG3D1qUmnaU8KnhhzIi1V2WP+UuBdpZV2zlitg4=;
        b=o4AAvY/lrmvnvbxme7HUDd35mlvBo9PaEd4M80L+JAv2k7g/ykn3kO9iATJGSxU35/
         gxSly3+7f97WQIlcePGovKpjfhev51M5YX69mAvNxsu1sgA6bGgOpj0c77bWKtKrSkvX
         hgjKsJ/NXzLbHJ/jEm6AR+C2NA8iuIgWhwhzIlW1RUOaIxGE+dQhXQvUzIEpc+QjSko4
         +kpWfGmM3dQWopmsRUU2etOhYDZg5pjlvTeYuZgvUiwBbq89KwFEHasSjCMEY63ZIaQc
         E6ykJV1dfBftylypTA43pHs4SFHbJPCZVW99U5AsM0NabSTon5fmpRPXwhvSSUeVFySI
         BK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780353370; x=1780958170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HLFcaG3D1qUmnaU8KnhhzIi1V2WP+UuBdpZV2zlitg4=;
        b=HPVeNJXs8cfM3MYIM5vtD+A62vvteAmUBPWkJkCBX2kcKe2mhaBJRlldDmVmtW93hI
         2MV6h12GOARGTEl3fofgwVP/HPirtT1ZZKtjZyOCLXBEpGHG5M068bPxz4HxfewC4OF+
         +fDU3ez3kWNqqIug/XxMfK9N9HFifsFUuTmFOU2kV2mZmuGV9gFZ7t/wuvDGzqkm0Sil
         UNj5W+BoRHX8UTT9+eIZySqpV/nugu0mQgpelgUCjNMKWxzW3UgCpDMYK8uixHJHgmUy
         gFnvVRSnInadychhBfAwQqyvw/+nmrnfkcHjas/3CVoXxDn/I+iF9CVTd3c57OvbhL0Z
         DwLw==
X-Forwarded-Encrypted: i=1; AFNElJ9UCIjiEdoCJGYUqCGZXdriE3lwTnu8xxi6+14pXxR7hYs/0eKnbmZzWTNDp05oixKgMKUgtJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcM3NFgU4iIEyNeiRioYFfKg1QF6h1W/0mXSgNSInJNPt6739m
	79Y3VLBUkZk/ApDZHl4Y+hRhgaugwhUKOwRemeGXlWSsj/dV9NXZ3oHme8IMUR1Dw9MFz8d56hi
	RYVAlRC+0cg4zqs3WSEi7YKmSWVPCXhQ=
X-Gm-Gg: Acq92OFGgYScIIqspq6pnp1Cha6CtYI1sORVE7liv/i+gvdywTsgNBn8esp5Vw8wrbp
	A6uBdP/cBHKYT/wZiABdPAI0L8bq/l7Z9LeW6GwQgplDXsOEy8pTbs3tIugEWFwdTHblNlAvG99
	PZLkZHSQjKMp2wmjjM1u6wW4Rfl6KPr9OKWOnPirtHhPr09XrmNmeX2AhbhOk0Lt2OsVr9ruRHg
	1Wj7Eggu4mxTTjeWKmF1m9ZxB56L7fAD0QMkMVC9RjoxxfEFgnsOoGynyX3lSJ3D4z5idXwiosz
	MZFRVoqR2lQjPJLcu+n34XHnniSlaOUFQ24VOZaxZQVYmp+f7ZiVA2zgT+LAzm0TusB5W+s/afr
	oSw/xZrX2RC5INjDUyguyWq+VvcNa5B3qjAHL
X-Received: by 2002:a05:600d:8648:20b0:490:9d5c:a3e0 with SMTP id
 5b1f17b1804b1-490a29215ebmr177131975e9.9.1780353370288; Mon, 01 Jun 2026
 15:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529014936.2811085-1-ameryhung@gmail.com> <20260529014936.2811085-6-ameryhung@gmail.com>
 <1bf1a11fa5dcb38287384833dd77c748f3a766b7.camel@gmail.com>
 <CAMB2axNK9rf12YyLjfeUHWUpGEf=UrCtdHcgd2Tq6KcFY1ergA@mail.gmail.com> <37d229e482df3367436d9475d6e9d6d69c7366a5.camel@gmail.com>
In-Reply-To: <37d229e482df3367436d9475d6e9d6d69c7366a5.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 1 Jun 2026 15:35:58 -0700
X-Gm-Features: AVHnY4KEYaxT8t9axx2zREthu8aAqw3RqhNq0eCCwFyCqA_jHNC70gOnb66EEkg
Message-ID: <CAADnVQ+K_=xz6f3Czoj6f6AeO6Bh0eyq-ambF11+hYq7DZq15w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 05/13] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-293916-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B6289625FEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 11:41=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2026-06-01 at 11:36 -0700, Amery Hung wrote:
> > On Mon, Jun 1, 2026 at 11:00=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Thu, 2026-05-28 at 18:49 -0700, Amery Hung wrote:
> > >
> > > I think refsafe() needs an update.
> > >
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > >
> > > [...]
> > >
> > > > diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> > > > index 877338136009..5945956a7573 100644
> > > > --- a/kernel/bpf/states.c
> > > > +++ b/kernel/bpf/states.c
> > >
> > > I think refsafe() needs an update as well.
> > > Something like:
> > >
> > >     --- a/kernel/bpf/states.c
> > >     +++ b/kernel/bpf/states.c
> > >     @@ -886,6 +886,7 @@ static bool refsafe(struct bpf_verifier_state=
 *old, struct bpf_verifier_state *c
> > >
> > >             for (i =3D 0; i < old->acquired_refs; i++) {
> > >                     if (!check_ids(old->refs[i].id, cur->refs[i].id, =
idmap) ||
> > >     +                   !check_ids(old->refs[i].parent_id, cur->refs[=
i].parent_id, idmap) ||
> > >                         old->refs[i].type !=3D cur->refs[i].type)
> > >                             return false;
> > >                     switch (old->refs[i].type) {
> > >
> > > Wdyt?
> >
> > You are right. It needs to compare parent_id, but maybe only for
> > REF_TYPE_PTR like below.
>
> check_ids() should handle the case when parent_id is zero correctly,
> so I think both variants are fine.

if that's the only thing, maybe let's do it in the follow up?

Eduard,
are you Ack-ing the whole set?

