Return-Path: <netdev+bounces-304657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 95aCE4cNSGrKkwAAu9opvQ
	(envelope-from <netdev+bounces-304657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 21:29:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDA47051BB
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 21:29:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=frAODzYj;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304657-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304657-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AC0C3017255
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 19:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE143290D2;
	Fri,  3 Jul 2026 19:29:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DDF326D4A
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 19:29:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783106948; cv=pass; b=L/5O7yZ9kjYYmLVBnnSxhdv6MP6idUGbFUllOAwsddsCmNRwFu9dNZ3VsX+9VMKLKcw4RRcWqhUqChcrIigvCXztQRL96lp/FFig56eSFRjYiHsMFPql6pDa59gVnQYdRCz/ziShW8YxIYp/U+r6dngS18Ql1OscspyH8txLDRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783106948; c=relaxed/simple;
	bh=LGL9mFjMAI5KMqpGOvbEgqcbqxF8NEU2pbQF7gDm4oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+zGjaYREnEMmOUFINNoj/CTGqQX7UXJW5e6Sswi5Sti/pDaB7YSmBHNegdkdV3DzxQsEK7vABJ0dMJYsou047USvm60sJV79gfPiUnrrahlCSDfR3z4o+l8NN7bgFlwK8VylooDQyLB/p8zjELZJMtWLDMmVOzj2j7ybSojObg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frAODzYj; arc=pass smtp.client-ip=209.85.208.46
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso3096289a12.0
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 12:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783106945; cv=none;
        d=google.com; s=arc-20260327;
        b=KIMXriJlen80Jic6Y5RJPFTON3E2LISObKPsuGWuXtGK3fVuM+l21iMrkcF/eJL9AB
         qFxvXSakba220TPkYvSxkNPz7Lo4pylLbThR6yB8NkHwRhm+Akidtbza1n4wMcC0XjMY
         qOpWOI8iS7TmKJ3Ct8LA06KeQpGxpK1gg+XgMxKFJGnY2UvLqYHpDMIEJ012eGJtfA02
         ALI3QhLw700BsawLE5FMIKX5ofZ4D8uoexKnyqZvJ+oErLBu2AHJOb37WEHx4o61DWSx
         5PTzjiB/qVjR5crK+RrsHdP0qJsjqw9+xtglfkSFTWwqaCKKYgix7iOxSQsKL0k/mgdh
         pEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qXJ61l3+3+IRv7w34wurskcWfLKumEDS1E6MxZsZAJ0=;
        fh=YJx+IHOmb/vsrgOCmu+GOS7UGjAdtkUnQF/ehGDCa4k=;
        b=EqdMYu9f/wF0vXe8vPd4/CM0SAsVUAubqQ307dGlNNiNgZcYYfngk7+Q9wISXZjIb6
         cs7XTQBfrJlSWe5N6hnzdOfLACYsdskZDt0a/G+u5ybri78cHSNEdPqOPxjnFhz8Tbrg
         M2gEYBuqU2m9IAedIcKE6OhTUy+tY4I9APTNGmaxTxsIPbgN4ypNIwqJeNHT+KPaeprT
         3ic7dzUNucMW/2Cse99b69llLFM5dZ+NGdi8F4lJJR7E3LKIFV0EscK2RHj8FB+L2zu7
         +Wavj4FHBk+qwILgco7qiaEPLS6pD2KoEelWGGqTBxnoVVOfcErl3oafGS1LvMastCL3
         tqlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783106945; x=1783711745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXJ61l3+3+IRv7w34wurskcWfLKumEDS1E6MxZsZAJ0=;
        b=frAODzYjfTz1S1zaJygiiOfrveqyUE2Ec6CeKY8bbhiqlS/MyvWLCKx0IoJxcmtwt6
         Ti7ow2F4MJlffI1pOX0Ah55vdID7JSrN5KHvKghqdmLNA9vjISMl3Oj0O24eUEut4ww5
         MgTzxZ9uSG+36qrj+01598IRq2P00ZJs5Hpn8797ECQHFohRHrbrS9SY3TzOB2g0mtCu
         jV6Q4bg/KUuPVD9abXGWr2Qye+kp/c8PeurPCKoPCkofS6Oh5uUdq1uD3C2tmVk6eYRj
         0pREi4sA74zNGVIJLsBKn+XmqjzRM+h/8TRlsA2n4VLUbH96GE7AlCxOzGaQKZnVdF2/
         EOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783106945; x=1783711745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qXJ61l3+3+IRv7w34wurskcWfLKumEDS1E6MxZsZAJ0=;
        b=YOF+8GivJL6zQ0Y/CwuExtqmJK1JFYzl80U6jV6O5eseCb0cKzqM8Uwv0kAT8GLcM8
         br3hm/EsBl0WIz0iyUbGLLQNZeLIZR4x5dYkSXZSSNPdxi3ED9lqCWWez8ad29NKsilz
         hGlXvuZEP3BZ8fTkb83xyUBT+jvGOeKkkPVpxVTyqWmkzMOxtvKCvuqo32MKlacmQP8t
         /PR1qgrZ76vJ3sjGhXzLIxcAcyTBE5TY3V9SLGEk10iYWljS/33zR4wivfp9N05KqVet
         zm75lQtqcunSTzNzam7d5udVOdmd/0AroHxxpzjYZbBwp5rCKXXkAbuDPoLHzIvhpYwx
         OBVg==
X-Forwarded-Encrypted: i=1; AHgh+RqAM2ukJgniZ1q0Lj8I1eIPf3tno/crnAPQ7l5xKtDP7sQzqox9jvDfxuz4UARf8zcf1ykMLc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4vpxCEbGdXBREMA3j9kYUziDuNE8GXr1VwBsJ2qGVPj7ldcCH
	rJQdOwI+9F5JVyA+tJYreWSU+nMXsJNoM9Cl9ZlX2DKbObVIHLZ8RS2ayxP+gu+p6ZUEa2Ov4SB
	n9vTnK5s9qFG63B5Mfak4Q2fBgUxRys8=
X-Gm-Gg: AfdE7claaaaP022I9XsfigbaLcFwKpfE0H4dVxJWEU22iByobLM2l7n+Eq5KAzDcGVP
	AHUGatxtI1CM87GllxSFe2yqWlyv3raz5RF9kOOT+mEITAGz2teAz+KUx2USYUarFKNfPx137el
	FiWNovcDfAnjQ1fiNsUABUlNspvJYlTvjFK9v1dNNZPDXRZvsbcNl5X0+vHLNKeSiBT9y1mwrbZ
	G+zsAWv1t5Ndh2zwKDF37ns4oHSAEf7JPrWcFjHe74VRAsii+W6bQCR0O1TRWOQyhuL9BEBvuI6
	uX375X/9DhBnjg9o5VtqaJBoQ1DkzScAjVHALFMhrEwgVXWoy9hngupkOo170T9cK/AkCNJ3lPF
	P7H2YOLpcsQz5aJndNRGhT/7ZxoY=
X-Received: by 2002:aa7:c68e:0:b0:698:ff3:85ea with SMTP id
 4fb4d7f45d1cf-698c104c5f8mr1644669a12.5.1783106945189; Fri, 03 Jul 2026
 12:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702234923.1320412-1-rosenp@gmail.com> <akcnQEiJYfAtPqN1@zatzit>
 <3a9bdad9-3755-4efd-8de4-a3ce3ff30b69@lunn.ch> <CAKxU2N8u+psVg4aqcm9Pooo92XsxTT12r02dNt6GttZZ_NkHPg@mail.gmail.com>
 <7a7e8805-9ef3-4846-a17d-20b8e5a33af0@lunn.ch>
In-Reply-To: <7a7e8805-9ef3-4846-a17d-20b8e5a33af0@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 3 Jul 2026 12:28:54 -0700
X-Gm-Features: AVVi8CfP7yARMxLqZOC4uJAkJN-dpJZSLfDFrKkKacwn7KjoMVjvGIF5qNTPlyg
Message-ID: <CAKxU2N_Vex5b2mkeRSYYC=DvFrb0KnLjT_E1NTNT0at1P3T2Vg@mail.gmail.com>
Subject: Re: [PATCH net] net: emac: mal: fix W1C write race in ICINTSTAT clearing
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Gibson <david@gibson.dropbear.id.au>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jeff Garzik <jeff@garzik.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304657-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:david@gibson.dropbear.id.au,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jeff@garzik.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BDA47051BB

On Fri, Jul 3, 2026 at 12:11=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Only verification I have is the hardware and whether or not
> > something breaks.
>
> We get so many patches, generated by LLM, which never get anything
> more than compile testing, it is now actually useful to comment you
> tested it on real hardware. Which is sad.
OK. I'll resubmit mentioning that.
>
>        Andrew

