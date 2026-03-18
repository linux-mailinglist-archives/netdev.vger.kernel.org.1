Return-Path: <netdev+bounces-268986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPVRNpKVumnSXgIAu9opvQ
	(envelope-from <netdev+bounces-268986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:07:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB9B2BB3E2
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A5D13015B59
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 12:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461D53BED1A;
	Wed, 18 Mar 2026 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="FNUPR+6U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7A63B9607
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773835664; cv=pass; b=Bovgp8cS3s7eNL1qKV2KorvZpaJ+M5jAjyJL4YaKCQ9SoIbVq9NTT/xIlJrKwmXkBaw+vEiO7V4+Z7uReAGiKoQssBLoUW0xxK1uppDWczeh4o39iZGou7FsxiFf3fV7kpWf8xvMHrL4fZhxGEVGTL/e4BtYXRMWSCW/x6cZo9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773835664; c=relaxed/simple;
	bh=0MWtM+Q3fOjQ3gTtcI9PBHPid9Cr2JUowGSTtmTprAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuGHHNSoTQ9G0zyhx9IG1HVqPwa/7HMk1X2jgF3A0Soj01T9RLTxN9tWXXNOmgYBBRwQp3g4GvKdaRuspilX2Dj0XAVRDBRfvLgrqBn+7+Z0+z2d6WTr1uUj57ZKyFqTbkUL5giQe9AgPwI5v0v6KYBzZvuraBiYHIWoK3s7Y34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=FNUPR+6U; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-667952fd262so1924407a12.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 05:07:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773835660; cv=none;
        d=google.com; s=arc-20240605;
        b=QDz2pRzhlCw0S20zjQYA1egf1lgQmg4HCd4nODCSOXao3smUDyGkP6mBb2YtLB3LQ5
         K2ClgVQ+47TSUIJybjjpIgymuOsiB/83AommEbMmxjRKQymyTfUP7iVt9RJ0JHq3AqKm
         q1n/Q2FwVYEuKG8/+AhuoQK2PPn4SyRvtwqebUiErkvc0YaL1ZpW7iE21RK+kpIwcaXG
         zr1dLea56DnFZWs42tvDunP1b/t2bmnPIOLnL79AnEFlko7UfTFiRGMn4W+ROzuAqbWw
         DEjQUBlTOD3w3DN08GG21o7tUS/1TfbGUHXl+bKtpEn1JX02mOVcYRWoXmEyw3lCD2BA
         xACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NsCJ3acJ4VXgmE/y7c6nUeV4zYXKY1pEx9fFAhUIDJ0=;
        fh=JikLCICB2iKyrA4x1+dqfAzll3CViO1X38fnneb3PN8=;
        b=LMR8f4EX6ERzO7OIhsc/v7Y329LrxATzw18sZ+lC3GZF1k8DPELsuCkZEf0/fmRNID
         Y+DuUnomXco3KYBWGfqF9CV6ZAjiN/nx1Tpka5pgYiSZmywLCx2GJcJrFtIarB47sD/w
         TB4UBf/fLDEcrlx89KkeMrAbsj8wg0ZByFbR87jz3ALIVHPqle3NXPzqOQM9qNzA3zVJ
         Na4fwtI0gSi9l12L3BUZWSbVpHpA2M0EMmB+027JYJCI8rqQKKMmVd9wVSY3xnca+lnd
         MKcazBlWtIHWMtXTI7UHo6vVgz1sr1i1i0fyRtMqmkL+2/V8JWcPbmaxntHHX+XH8j/e
         XxwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1773835660; x=1774440460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsCJ3acJ4VXgmE/y7c6nUeV4zYXKY1pEx9fFAhUIDJ0=;
        b=FNUPR+6UebALLBZWh0AAnNIoKVRvFaSYMKeNz5PjacYzO7D22ZRMSYUHloYI9g2nHm
         tVPh00i0W0o/U98xmReucwmeUY90Bpl6koJwaEZQb7zK+JNY2yq9ZfLzSdH/PDx3IA5Z
         iOaWHf/e+SptMM7A0wwOuwvYtWHBj7mDcWuzjjxXhEbncL/vBselGhNmMwiCnqgeKwKT
         oPjJ/97ZKbXH5KIyG3fsFfFfmQYdaARQ37NFNDcsvTlTMkcU4NuNp+tvrTK+lwZWATuw
         poJE14o3goSFDVgkj1eNsWFflflbnRsBjAP5EkLz9adu38GbFFEWbJa620t831ndlwzv
         6iZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773835660; x=1774440460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NsCJ3acJ4VXgmE/y7c6nUeV4zYXKY1pEx9fFAhUIDJ0=;
        b=QrZv9XwCua4glzbuBCwPPqNCWrzpbU4Hj9y/S8ZrBC8nD+/2WSkPg+giyhczxJY3w6
         lWq+733cbqtdCeUNkSLM3mfvnd4+PPqI6SXcTKK5DkPBSa0SSJMxg6uDbZUwWFo23k69
         1iKHvmaB3yUPWNo7mxeMJvmuZvKdaZ8IO8bxorcd3SmV0RLc/ZXtZOPq38o45HhY9wF5
         tY5wr0Q8M47stHkNCU5iYVGLmMZFLDFsFjrfOm36/qFPX2YOn5XysCRT+JMWz+NQ4S+8
         8tkKx+KXmZ9CH1Q8zo8unFXw7d7fKKwPZl/qcBQAah5gXpe7c7wC9HLDX1/+sPu1/CPf
         PP1A==
X-Gm-Message-State: AOJu0YzRobSL2S23h32abxBIfRDdsYqaAJlMTppxI34u+x7Jg8KQn2CW
	sG6LfZibE6oWofZu6gDEvMBQnVPiyOs0QeFeIB4o1PwV6HmjrDxxiq4OL/QaoBs8H9HfPq/0OgR
	V0Fb7CclukpN/nnZLVn+XTHlA27XUY7A+Fy21WqbsXA==
X-Gm-Gg: ATEYQzwYltujPgbPQsH4bGMLFnxQs26gJ3yvMuNYAxX2oXNc2jRdQulN2HekOT9wURM
	sHEiKV9NfUydedRO2CHEFpwSVtYOGDWXQk1iRqrz64Ze6T/ImGGw8+7xT6Wpa4PPva6c4dQfta1
	SbRmLCBjDZupcAKGr8Mk+6qARjv5XYtq/LhXdUPbP6pAWWMegyQ8YpcU4f0TRvBZNIpRgypvA05
	9fuQab6Ozhff1nCT1nO2SuBJSivBLdk68ZOOssnwqWhGNkAYuPJhZWE4O4xiHk3pDu0l2hLq7BX
	AuUVow==
X-Received: by 2002:a17:906:2099:b0:b96:ff4f:11ea with SMTP id
 a640c23a62f3a-b97f49bdb32mr122996866b.41.1773835660334; Wed, 18 Mar 2026
 05:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316164907.1255510-1-justin.iurman@6wind.com>
 <20260316164907.1255510-2-justin.iurman@6wind.com> <20260317121023.5f3035b3b8a51e10c4e0408e@uniroma2.it>
In-Reply-To: <20260317121023.5f3035b3b8a51e10c4e0408e@uniroma2.it>
From: Justin Iurman <justin.iurman@6wind.com>
Date: Wed, 18 Mar 2026 13:07:29 +0100
X-Gm-Features: AaiRm50TZe8Drge4tD3BkuV-LevFMUaKJqVDgH_Q2Lo2bQ-et-S9vA0Qt1YghXo
Message-ID: <CAOY2BqzY75q7RV0GqbjKzg3AWb5iiVH3D21CwYjiO2d0Z1YDKA@mail.gmail.com>
Subject: Re: [PATCH iproute2-next 1/2] seg6: add tunsrc support in iproute_lwtunnel
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org, 
	justin.iurman@gmail.com, nicolas.dichtel@6wind.com, 
	stefano.salsano@uniroma2.it, paolo.lungaroni@uniroma2.it, ahabdels@cisco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,networkplumber.org,gmail.com,6wind.com,uniroma2.it,cisco.com];
	TAGGED_FROM(0.00)[bounces-268986-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,uniroma2.it:email]
X-Rspamd-Queue-Id: 6EB9B2BB3E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 12:10=E2=80=AFPM Andrea Mayer <andrea.mayer@uniroma=
2.it> wrote:
>
> On Mon, 16 Mar 2026 17:49:06 +0100
> Justin Iurman <justin.iurman@6wind.com> wrote:
>
> > Add support for the new optional "tunsrc" parameter. Now, a tunnel
> > source address can be configured per route and has priority over the
> > configured per-netns source address (if any).
> >
> > Example:
> > ip -6 r a 2001:db8:1::/64 encap seg6 mode encap tunsrc 2001:db8:ab::
> >     segs 2001:db8:42::1,2001:db8:ffff::2 dev eth0
> >
> > Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
> > ---
> >  ip/iproute_lwtunnel.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)

[snip]

> Hi Justin,
>
> This doesn't build: SEG6_IPTUNNEL_SRC is used in iproute_lwtunnel.c
> but the UAPI header sync for include/uapi/linux/seg6_iptunnel.h is
> missing from this patch. Please include it.

Hi Andrea,

I usually don't include uapi changes in iproute2-next patches: instead
I add a note that it needs a uapi rebase, which I forgot btw (i.e.,
David would drop it and rebase uapi from net-next anyway). Right, I'll
send v2 and include it to simplify testing.

Cheers,
Justin

