Return-Path: <netdev+bounces-300136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id neiBJ/OCMmrt1AUAu9opvQ
	(envelope-from <netdev+bounces-300136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:20:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDBA698FA7
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:20:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LRYTyJP2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300136-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300136-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6526B3020A75
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD536271464;
	Wed, 17 Jun 2026 11:16:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B6824677F
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 11:16:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781694961; cv=pass; b=niOj+5+PUHkKv73Kzmo2Xl8cDifeIwEZMRidDD3ripqytojHKQ4och+sxB3EmTa8JsMWDwjnkPQx/wJuqouLXovimM/k37s/yaiLaCFr7Nqd1eLzc0ElQ4z6Oie/1Zo3vIMwt/mSv0rKRqmlJflJGf7EC8h56pGhO74YI7YdtEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781694961; c=relaxed/simple;
	bh=Vgf4p8OUhbON0fRrDiTOY7TWsQBBAk9ikrFGazN2RhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S70Iz8T0BbYAlTueWtvMUFCXdHEbR15A8Wjb7XWpeYq5ZLvFrhVezLTOKcGEUGjvGMUv4U46yOjPsi2Ojo3tZGY1pWGBAsg4cdDgy9CVLViJvxdf+ugvKsdWlD7lFY3t68ZLKJLqRQijQ6NOHhyFX4jp5C8BwPa/P4DjJ2EimtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRYTyJP2; arc=pass smtp.client-ip=209.85.167.177
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-487135fd4f9so2273558b6e.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 04:16:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781694959; cv=none;
        d=google.com; s=arc-20240605;
        b=XgxRrPpBXUt80porfBPpyHndMH7HNFgFV8Jax4ncieHl5ksinM+ZAzOa+FKtwA5YcU
         lq4SQjo9ZCaJSieVcwiMsB2ZC0PKm5j9C2sxU/XkTTfbFh04pbEv+kAfcAVyBJAPm2es
         M6e4VG1hQsNjDMknkvBDi2UDyj6eV3swsZ3/6uAWhoOYVPCwZ/cdY0Agl8BTmy1W11bS
         wPWGl0U4nOJ2WfpzosJyZxSr/vhOdwg+NQdmBcCf2AHhB1pFsJY5Zy3h+aEryNZ0Tt6x
         3zWmY9/Cu72o/nte4giwLvKgDfusa/kJzUCYgCKhw4ah4Qxrvsj8m5gHdBPlP617YD+W
         g2XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5prARgjp1JGeRSIbUSTtBH7ygssHwR24oHI47HYcMcU=;
        fh=+tp9AkRrFz0+1Hh6sKLECNbWfCKOsD8QCQaz2kquIF4=;
        b=d9vN5wbF39F8Cc8j2XaNb7RlLg9fwwUIV7VY8kJAIGZgV0ufN5l8DwPPFOXM/c5kvH
         URZJLYjmm1WbXcYr0JbK41C3N0KI6kN1clc55zQh51BwtQDSs1gmddP9XMRZgBYdmsPP
         rsdofDWsm/SOWVbxk2FbvrvwPb8XXOQl/cuaSvzIzcUE0gvB7x9XNsKoEw/UNlLdoqYf
         +lRnjnQdxKR/RxpnHVN0gERcYyna7E9rhRcM8W5BAiWYfCwx5mKpHIofAo+QP2DyjeBj
         t4AuGqEhXTgZjjao/F8m5pmWjxVuQG9kHW+BK91BTQldYs4EOyg9vcb0nxwAFQEfbu/I
         hgOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781694959; x=1782299759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5prARgjp1JGeRSIbUSTtBH7ygssHwR24oHI47HYcMcU=;
        b=LRYTyJP2b/XTIKm40DrwU9oepa+VTxbQ1HDN8VcnWwIpeQi8qCUjqjpw9SghiaRD5l
         dsr8y8IIx0BYmsQ2ngL447joan2HhagZzeK+vp0Uc1sGXC9RysZ5LFlMhRV/vlwsGpN0
         UBRbNbV3BMy2Z93XMuaOQk8ZfYxcuT8wLdMPP++Sbzm8GJ9j9Wb/S3pm1Lgbkw2pc/Tm
         KFDQLdUrN6uQLKk3kzCXN4Xv+8jWmoAF8iM6SMu9IEzgFCa0FkKxe4ltQmPEQLGUni4H
         NT+UHTTYFcnmVEBP62RpyDHy/GMYEuSZ49LDFwXZic86VpPsWcUPtWMtcLOjXD5qTulR
         JOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781694959; x=1782299759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5prARgjp1JGeRSIbUSTtBH7ygssHwR24oHI47HYcMcU=;
        b=s7VR//SGLZzEv8R6Wov5EgVzecdMqQWsIg2SDgiMRoYGtIRstWbUyiq5vx63NHmpZA
         cSiEmZoK2v6iBvdZdUJ9wmPiTf53HiqWZAOZgcRVWU9SuORmGccqItntAzMZgH3BWjNN
         kaNTkFbwL7IMyQsbtFAmIul3+NFTDFHkSC44BUwbs1JvEtlAVrA7R12D9fDDri3isaec
         ley+qUb/6+izzhWSAcwq36ob0lAblAdqzIXtXlWqrFlwQHjDENKjCL8BY5t/o5DqkUsU
         nGU5uTlodKPGifl/N/YCERSCAywwr0miBwTsZt2HjTkFNnJfFCo4Bf6JI9E8oal26kCK
         Mmgg==
X-Forwarded-Encrypted: i=1; AFNElJ/7XX6Qq4mdXye0eH74MICJFvjGvCHJwU0uTDsx8XaRYtuEq9WtpDcdXgwQQ4lYqcg40o2B7A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpqG3PlMrlz0NuaqXD4iDl+jXQVOIubgfe/1O3F2D10o1oBKG+
	RgBzHS8BLqjZtxgminuFEWialN0lEr/a0C/r8FmxieckUZuJr9FpF3oADpRwlX6s1UeZj2SsEiO
	VX6m2TYuqgrh4OdepXVJFpamoxQcsUFo=
X-Gm-Gg: Acq92OFYhVXwx61/P7/F1OlBAsBFOar0FEJDVny2B/dmTN3LE8FncOMe6bDyV0aKiy1
	u443dbmNkhgPhHDdPv1RVNaWNmq/bJ8YYCR2CJoy2+8L0k8KMQDG1SBuS+M1OAl/fYeLQ18dSj8
	ojcuVqUL4whyAIsLmB/AxerDWTdGIRj4oLkMAKoRCgeWs4CCrrN0FxJ03An1oYgk+V+eSoSscSj
	D+Hf9CZocYfG0SCwsD0MHR4tQWkl1jULNCgJPqtjFevuJ5DpU3oQSuHy+PHwWcRQYdQOCyelN6S
	CGVb1xEnTaXaNmfI99j6qB6vRNE+ZS+BfcdcY3c=
X-Received: by 2002:a05:6808:30a8:b0:485:3b64:3174 with SMTP id
 5614622812f47-489428dcb50mr2997542b6e.19.1781694959269; Wed, 17 Jun 2026
 04:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615111235.3544282-1-kyle.switch@motor-comm.com>
 <CAAXyoMOp8mYLUx4CQBn=9R8rNqEsb8ybWD0z+=FJgh2j-F0s8A@mail.gmail.com> <88f726d5-1617-4d2e-8fbb-d3da9478b386@motor-comm.com>
In-Reply-To: <88f726d5-1617-4d2e-8fbb-d3da9478b386@motor-comm.com>
From: David Yang <mmyangfl@gmail.com>
Date: Wed, 17 Jun 2026 19:15:22 +0800
X-Gm-Features: AVVi8CfgxP9xkrq96wmAqH7aVv7sJD_KbhY9H6loX6aGMU4JGEguogMM2-OAeaw
Message-ID: <CAAXyoMMYxRTwHD6QmpAkspCtiY853KkYuOAUR=qV0v9g5w9v+g@mail.gmail.com>
Subject: Re: [RESEND PATCH v1] net: dsa: motorcomm: add yt92xx dsa driver
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ming.xu@motor-comm.com, 
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, de.ge@motor-comm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300136-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kyle.switch@motor-comm.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ming.xu@motor-comm.com,m:xiaolin.xu@motor-comm.com,m:jianmin.wang@motor-comm.com,m:de.ge@motor-comm.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,motor-comm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBDBA698FA7

On Wed, Jun 17, 2026 at 10:37=E2=80=AFAM Kyle Switch <kyle.switch@motor-com=
m.com> wrote:
> >> +/* To define the from cpu tag format 8 bytes:
> >> + *
> >> + * 0 1 2 3 4 5 6 7 | 0 1 2 3 4 5 6 7
> >> + *|<----------TPID 0x9988---------->|
> >> + *|<--RESERVE-->|<-----DST PORT---->|
> >> + *|-|<---------RESERVE------------->|
> >> + *|<------------------------------->|
> >> + */
> >> +#define YT922X_TAG_FORMAT2_NAME "yt922x-8b"
> >> +#define YT922X_FORMAT2_TAG_LEN                  8
> >> +#define YT922X_PKT_TYPE          GENMASK(15, 14)
> >> +#define YT922X_8B_CPUTAG_PKT_FROM_CPU      0x1
> >> +#define YT922X_8B_CPUTAG_SRC_PORT          GENMASK(6, 2)
> >> +#define YT922X_8B_CPUTAG_DST_PORTMASK      GENMASK(8, 0)
> >> +#define YT922X_8B_CPUTAG_DST_PORTMASK_0      BIT(15)
> >> +#define YT922X_8B_CPUTAG_DST_PORTMASK_0_EN      0x1
> >> +#define YT922X_8B_CPUTAG_FORCE_DST         BIT(9)
> >> +#define YT922X_8B_CPUTAG_FORCE_DST_EN      0x1
> >
> > If yt922x tag format shares no common with yt921x, make a new tag drive=
r.
>
> Ans: thank you for your suggestion, we will consider whether to create a =
new driver in the new file.

I'm not an expert in this, but if yt922x tag does support cpu codes
and priority, please consider updating yt921x tagger to support it,
even if you don't use or test these features for now.

> >
> >> +static struct dsa_tag_driver *dsa_tag_driver_array[] =3D {
> >> +       &DSA_TAG_DRIVER_NAME(yt921x_netdev_ops),
> >> +       &DSA_TAG_DRIVER_NAME(yt922x_4b_netdev_ops),
> >> +       &DSA_TAG_DRIVER_NAME(yt922x_8b_netdev_ops),
> >> +};
> >
> > If both are supported by the chip and 4b does nothing more than 8b
> > does, do not bother with it.
>
> Ans: 4b and 8b dsa tag may have different application scenarios. from my =
opinion,
>      1. 4b dsa tag can save 4 bytes of payload
>      2. 8b dsa tag carry more package info.

We do not support every tag protocol. For DSA switches,
  - the conduit interface supports jumbo frames so there is room for
the DSA header, or
  - you end up with MTU less than 1500 anyway.
4-byte reduction does not make a practical difference here. An
alternative protocol poses 2x work to everyone else, and unnecessarily
exposes your driver to interoperability issues, as pointed by Andrew.

As I've commented before, if there is a particular reason to add
4-byte protocol, leave it behind for the moment, and focus on a
minimal yt922x_dsa_switch_ops + yt922x_netdev_ops for your first
patchset without any offloading supports. This way, others can easily
see your changes and move the work forward efficiently.

