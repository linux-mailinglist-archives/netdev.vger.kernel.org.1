Return-Path: <netdev+bounces-252355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAIxIYY1cmmadwAAu9opvQ
	(envelope-from <netdev+bounces-252355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:34:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFD567FE4
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E171B783FBD
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F93F309EF5;
	Thu, 22 Jan 2026 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QT8onKVL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F392FFDE3
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088009; cv=pass; b=M4g6rHlc8hEyiZ7co42SfnApZBkfPVlBj4o2z0K/PmCfzolEFoHnKbY5qvFdIrVF0pSR3oxk0MipdXVCdpWeIhMTnG8D4AbSwEAXztqYbGFOZ/bLNB6UIk0KTcZwpaewUhsQf7dv3f4DhSMwvAGdwgA8dzizSRCbRS11T06lIJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088009; c=relaxed/simple;
	bh=woYUwod8TKYVzIIN0DT0+ctMAsMwdmcm6DDUjGPzj0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLSgjCYU9jxPzChX7eWgzuMz31UO6Yh6+nkMRuYWnppat548El+g95aZD/qzb9NwDja21/5GSbWyunGRIr9+CL/66KPyyo5CBbmPZ+BI3ML4tBXhM4lII30zlA8VObeBn1Se6m51TU9PyK4dX6yyWDavRMRUp9OdhGDn3VhrVBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QT8onKVL; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-45c889aba0dso1031569b6e.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 05:20:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769088007; cv=none;
        d=google.com; s=arc-20240605;
        b=ly8ddASgRn2qF+wwgXNLJODpNRhUHldEtd0hrySKTQAi9ZHNoSsLebZbJ2zl7tG4lL
         Zt6phQtDMpLjgmnpQoOnRH0QDVSrraM53Dw8VEukeyfdYkZjDZCXQKdvS6pC3Sm+UZmL
         aMH4eo23NRldrLCKI0yLLAHW5VtbkPSEjirb5UrRdJpiKUWi1HpsM9iEqhJw9PeNvWHO
         x+YgA/z5QpswArT0rp6MV5h1HQcBe5eRY0gi3Ud3oZ29pp23AhFfdgzzeDcyEuV3/Prs
         cbXSz7kFDziD4AzbycjstMHuSvY12wKfMr3cxh2veA8JxBW/A/T6AwNClcH8uUopAOe1
         wJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1gIUT/Ak+Xu1vabwpjPvPS8vu7p88ym7q+0kHYvrD80=;
        fh=G8yG+moR5sU/oMDADY9FkrJILI6KAADjn5NlmBB5TBI=;
        b=fabucocagaZd94+b+WOHv6MQvo1CBy25LByIizVDcOwVvckPCXMchOoEeSg0brvUbx
         MsPddWTk7jiy4Xg8L45vlYRu3nNr3M22pvWQG7PlizcO71i1zqk+5qufi1CMWLQdzOtJ
         iKXXXbti7B4kiC6FihGz8fjm7n4J8TklIeNTb0Nu/5LbYJ+nz24P7rU0XLD73DjCvfD/
         HxigWCiOnNiF+O8G+ps4Jcgt9vMItzehNvW3TQPesgy0LO5bjFYOCp30uJMZKpdk0Jlk
         QSl8B/5h/gyIM12BndNq8lVghMRNM1m1ap2utu5JivmRZZ2DfqJ1MctYCKGJ20Yo3Le3
         UEhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769088007; x=1769692807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gIUT/Ak+Xu1vabwpjPvPS8vu7p88ym7q+0kHYvrD80=;
        b=QT8onKVLXPL8b84kTtCXgLnfc7+E/sJFJdXYuJitI6oWDjhXVzdufykx6tampL7/mo
         UsrhsIs8zJBU8OaZxAruGwdHg1U/cwZQUFudty/Jhga5E2qCxn68NVzlwoCL0YngMnUF
         HL3rVCnz0tFCCqNxL6EJg6WbJy/yMvh0abxixPMtLRSY/iOYzg+MnIBhhY22YpFpb8nP
         9vCPYlu+52qNMPEeTrd7HNoQnY3yc6nYQQe46uq3ju41KVKnhbAwTAN7S+FK1hLxzOgm
         DQ9DnDXrBOXB4P/45Cz5Q/OGdq1Jxn3cyLRLXIbFigs2CB6JURLNGkNP0qZ0j2OORESF
         ToSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769088007; x=1769692807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1gIUT/Ak+Xu1vabwpjPvPS8vu7p88ym7q+0kHYvrD80=;
        b=QgLNenLQ3NDXOSfcZEu/D1qn5CIUfBl6Xiv12WIVJfpsKMLQil8uo3GhqMzS75rzYL
         WXi62yVqjtjV1sRGgLC4hYkyVOE1i6D+nJgO3YklEn9fi75v+bVfrGpuHRbSUJhYATQ+
         uVKI4pqVI+qnqtRWg/fBD96GTZVg3MNdaXLZJ34pKnSP12jbnqmutOjWoQDMs5D9P8Qd
         RhrEp1JDlCJQMF0Os019ESPrOjxCML9mnJqUTJdunguEOVi9WbnKYnyUaWJkhkyE8us8
         n1IAnlmbLxfnJTNlCP7s2gnzEjwJvrk9V94f1YxklGLzXVQWiV8Rv5siZRPmS2/6IHmp
         FyEg==
X-Gm-Message-State: AOJu0YyGgxQc6g8xiniovrTl3zFPfhwUlFaFLjTWrbqZTMvk9wsi7eEF
	er6CycmTp0jXb6iiveAPkGSEEATxNaIshyQtOI34Eac6rBSJH9cb3maCzVv9iNJ4vC27PPpvKhQ
	iz48E9yneskcY533bjHkc4yL8rTbbW+ZzoUnTzkA=
X-Gm-Gg: AZuq6aKfKUTdKsVF3Mv6Cbx6/ER5UHoJ3iqiN28zNx8Qv1MKU/EPoTH50m0FdGywwnD
	DYvOOQ0wou698RstsSxsF6w8au/i4LvP09dv2X8uFy+5j8AmQnQekefRHEfGN70jlAO7j3Raa1J
	ndOg8BUy0rMVv6Uc5x10FpGP0Bjf6XHKRL4EQnPObXfYb93Czyi3HIpq1upSdTTG+fi6MK/tPb0
	lA0Gwq2nLRJlqElX6w6FPBQlL58HTQbD7LvmQS5qKO7cNP+s0QYJpaXHRFLRYynHhPlHfcz/b6q
	GED0ArLgDIrUluNJR5PoFR9+U/EZatQI/FAb5MthNh6KnJMwhmFEdPcup24z
X-Received: by 2002:a05:6820:4a8e:b0:661:8a3:ad19 with SMTP id
 006d021491bc7-662c1c0844emr1594433eaf.30.1769088006833; Thu, 22 Jan 2026
 05:20:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118013019.1078847-1-mmyangfl@gmail.com> <20260118013019.1078847-2-mmyangfl@gmail.com>
 <a5b78a79-8f8a-44d3-9a1e-1019ec57f910@redhat.com>
In-Reply-To: <a5b78a79-8f8a-44d3-9a1e-1019ec57f910@redhat.com>
From: Yangfl <mmyangfl@gmail.com>
Date: Thu, 22 Jan 2026 21:19:29 +0800
X-Gm-Features: AZwV_QhOzb29n3ar48nMiSUDqG1nK-w4zdYZh7ac3GFaxsZo-7rztev9y__Cr_c
Message-ID: <CAAXyoMPfQnrYWX_5LPr=vODQcg1Nx1-=rk7+6SSHZ6EqpXH69g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/3] net: dsa: yt921x: Fix MIB overflow
 wraparound routine
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, David Laight <david.laight.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,linaro.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252355-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 4EFD567FE4
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 5:41=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 1/18/26 2:30 AM, David Yang wrote:
> > Reported by the following Smatch static checker warning:
> >
> >   drivers/net/dsa/yt921x.c:702 yt921x_read_mib()
> >   warn: was expecting a 64 bit value instead of '(~0)'
> >
> > Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921=
x")
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/netdev/aPsjYKQMzpY0nSXm@stanley.mountai=
n/
> > Suggested-by: David Laight <david.laight.linux@gmail.com>
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > ---
> >  drivers/net/dsa/yt921x.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> > index 0b3df732c0d1..5e4e8093ba16 100644
> > --- a/drivers/net/dsa/yt921x.c
> > +++ b/drivers/net/dsa/yt921x.c
> > @@ -682,21 +682,22 @@ static int yt921x_read_mib(struct yt921x_priv *pr=
iv, int port)
> >               const struct yt921x_mib_desc *desc =3D &yt921x_mib_descs[=
i];
> >               u32 reg =3D YT921X_MIBn_DATA0(port) + desc->offset;
> >               u64 *valp =3D &((u64 *)mib)[i];
> > -             u64 val =3D *valp;
> >               u32 val0;
> > -             u32 val1;
> > +             u64 val;
> >
> >               res =3D yt921x_reg_read(priv, reg, &val0);
> >               if (res)
> >                       break;
> >
> >               if (desc->size <=3D 1) {
> > -                     if (val < (u32)val)
> > -                             /* overflow */
> > -                             val +=3D (u64)U32_MAX + 1;
> > -                     val &=3D ~U32_MAX;
> > -                     val |=3D val0;
> > +                     u64 old_val =3D *valp;
>
> Why targeting net-next here? the blamed commit is already in Linus'tree
> and it looks like the above could causes functional issues, ad the wrong
> value is written into the mib.
>
> I think this should go via net.
>
> /P
>

There are following patches which are not fully suitable for net tree,
and the issue does not block the main functionality, only gives wrong
statistics.

Should the whole series be sent to net, or split into two parts?

