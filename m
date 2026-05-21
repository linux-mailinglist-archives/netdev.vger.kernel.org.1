Return-Path: <netdev+bounces-290176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gpimIHpWDmoZ+AUAu9opvQ
	(envelope-from <netdev+bounces-290176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:48:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D281359D66C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50117301FD6C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DBA23D7F0;
	Thu, 21 May 2026 00:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5wmiscM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F6026ACC
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 00:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779324173; cv=pass; b=BtM3uYphyxcnMoZnhGIcZtlB9r9fudqr3dz1WmPv8JoyZ8baz6CkOe6UJTGSXegDkC06j6pnp4xDi8CkV96m11YZhfIkppOXckzJycNYKFho2u3SweaLgYL5vxPGB4Jelc5BENqvNL2tRTvwz8BRF8LvTGNQ7tmV9JB/8UqsZtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779324173; c=relaxed/simple;
	bh=041G+oWl/T3HHMonz2NXyaRLdDkbifUXTz13zphUlOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFgiMnHofx5e56q5fzj9evZSO8VsP0epbosnn83zn1MT8Ke9785eygO1//N26F7znqEJhrQMKB6gjcva0dnorv1+FnHB3U6/dw96ztJ/tMuJQs77If5zQUDl5ZOBfeCJbzN1iEuJ3DrX+xj0Vg1BROH59UY/PFi3lWjJpB9o7Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5wmiscM; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67da63ae541so11921297a12.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:42:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779324169; cv=none;
        d=google.com; s=arc-20240605;
        b=RQS98VdK5zeJQx55p5ExTN+Mo64CfNHW4fUJ5Og85oR9vZAz0kcKoMM0SzC1DMdmE9
         nHtOL3b4ILJRc2okMH0VLVLbsoTL+HiRxTM490lobiY3QYZpXZfP3LcvdohLnTeexD1u
         O0/SBa35ECzUwbMaNLgVthQDae0SGl1u2KBDdEGL42QKgWktJRjnm6oB7zGDS5bAW/vb
         d86p0xzOODhuZD8kwS1DLsrgPQegUYMv8kKXkMec96bF3tW+IsJmNF5K3S2uaK9P9wLc
         VFTykz+x6bsSfaWkHp7DsvG/4EKToBa9HUrVyzaicmQljS/jcVtTUc5CQ0Cu9+u3hRSD
         MITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OCkfzbYQ3ZOHf7x1sBRWngxdfLCGqDDmcendFg2AnMo=;
        fh=9ZABQE5jw1uVCqLQRjTCNojZMM5IStY01gN0IjJx39w=;
        b=Ea0KywLxg/umomSuULrwhFjWSoz1l9jYpJcUghep7mYDbC6wqJj0Ta7fLV53HOnCSd
         kSnda+Rii/Gj6JI8DA7LqGxoS/n3t8KyGxjoycieN/shBGYI0kMTjCyafsXLJ2Va9jsd
         w2K+rQhxG8qnXsY9bNxCXV8d3QzjRRs9QvDHX+ouQG3xnw1y1gcDicbwUIW3RZ1ZGEso
         N4sv/spzDGl3IHnBk2NsYsVzHWUe9c6YeVcrSK+lqnsvYVRaHWkmwj2NbZrxbcy0OkTR
         C9q5aI4ZL/XMmfrmNGxlexjWowpuS/vK6ApjwE4bPDmM0pJ81yPaZj0jltvpZmdmzkP1
         9X2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779324169; x=1779928969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCkfzbYQ3ZOHf7x1sBRWngxdfLCGqDDmcendFg2AnMo=;
        b=U5wmiscMQhIZtAHnHBn9nhafaRdpsI8m8CJEZbrFB8flBVU7ANCVQhM1fd8b3ETgtg
         Dp14L/Og0lhG4sQQ5DjFZJJK9wKDewRlmb5zqp+KzIj/FPvFsJhozr+RYzn2ePbqxSGg
         G35Jkbya8jqBUrfHTVncTfXuFYFl0g4ILvGc+3D3Ltr1WDHWz1uHGPl0YG9O6j+PBu+N
         NdPUAkWjlOC4XxhTEKXaXMX1ZXBh6c3Ln2/4liOYn5//67GlLFzFdmmD68JWRDAssoQv
         C0CCxFpNgUvln4/HxAcTh2Nr0iaSkAO3r7mXAEs2FSLJMT5UeLebkNP4C7QmVUZJYUGa
         H4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779324169; x=1779928969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OCkfzbYQ3ZOHf7x1sBRWngxdfLCGqDDmcendFg2AnMo=;
        b=kKRRKaSw+yYIAns0mcg854eouD7RRiPFE7KKDFSsUFrf9qJuzIQr0ihEyn9IxE/LyS
         MOFSIM41yjdMdJmdPECyjtHjgLy83hf1KaFSlgA3OzVp66JlA1AxZX18QOth6u1HdLr1
         YMUuqQVsweYHEIn5NnpTMKUwIlejHCvrxYZ1TcdwVvztYHaPGgwilNWQhqLVCSWldYXc
         x4jxzGCU3KPNjEpRIIiA5BaQbD8JPEQCQqYC6bLgRzGEXS/woLEbRwdEsPfO1MSJlOy+
         iCeez/QkB5la8QUb8tEwsj6XgRv6TjXlbuQkPmWu9yNCvz/8U6pF0zcBF4n+NRuqRevX
         OrKw==
X-Gm-Message-State: AOJu0Ywmon+vndFQuJEZtCVkKRsr6B46wymjPCQeLvQZoV7iljHdGm8s
	42EbYYeooMKY6cltiO5bwSbBEUyVPH9K4VUOaCbe4wSZn/l9naSpoyv5LIWbRdxoC8g++W78PR2
	RjmPoVcPac3xIemjPIcKa5SHaMrTlByo=
X-Gm-Gg: Acq92OEd20CoPzWVTsIPw8hQkqNJnmNuS9NCLEItE8tuTaL3nBTHYLUiUtcAbEnghVj
	ylUodOwf556ksZf0Kt/j+idlAiYpg4Zan6mchdl7F+DpbXONgWeIIWDhvKMW73tH+Rnay4aqaY2
	Z4xLJrAQixXUTuhqGLXorL0O713Hzj0FWBLtEr1IKKoQXkCav+btp1FrbvSEAitLfaC2qGXTzor
	i5i8bftnVCoeHG4RXlD2lAkivESGBYyXGiZuKxOlT5ukXQ3lsSLb6wYhsHYtAF1xRi/wcqgFOVp
	P5l2IgBuoXYUDqNri8KvWKenAOUJ4zDL7psF5eRt2NXA5z0yxNAY3YYB7uQTqNeZ8lvBL3+jvti
	PTsAaTkHfWDRtKy/MhNV1RzvH3mlZFYwXD0mMkS4z281C3kTsJy+u2A8M7zEXd1RaF4RP
X-Received: by 2002:a05:6402:28c5:b0:672:8f26:8aad with SMTP id
 4fb4d7f45d1cf-68835bf7867mr180207a12.9.1779324168757; Wed, 20 May 2026
 17:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518044047.1002235-1-rosenp@gmail.com> <20260520170607.27cdf572@kernel.org>
In-Reply-To: <20260520170607.27cdf572@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 20 May 2026 17:42:37 -0700
X-Gm-Features: AVHnY4I33Gbx02jGrjRGB9LPpWVda2IHGmWJm7F5BlqpPUuy6wx1V1WvbMspxGY
Message-ID: <CAKxU2N-88yEQeGcMbj0_3Hd6RWMANEKKTvw3i6qVriG6wk38SA@mail.gmail.com>
Subject: Re: [PATCH net] net: fec_mpc52xx: Fix resource size format
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Joe Perches <joe@perches.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290176-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D281359D66C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 5:06=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 17 May 2026 21:40:47 -0700 Rosen Penev wrote:
> > resource_size() is printed after casting to unsigned long,
>
> This portion is confusing and irrelevant, you're touching the second
> arg.
>
> > but sizeof() returns size_t.
> >
> > Use %zx for the sizeof() value so the format string matches the
> > argument type so that 64-bit builds compile.
>
> Not on 64-bit x86 builds apparently. Please provide more details
> on which platform and compiler you see a warning and the warning.
64-bit powerpc. How would this driver be built on x86? There are a lot
of PPC APIs used here.

drivers/net/ethernet/freescale/fec_mpc52xx.c:46:10: fatal error:
'asm/mpc52xx.h' file not found
   46 | #include <asm/mpc52xx.h>
      |          ^~~~~~~~~~~~~~~
>
> > Assisted-by: Codex:GPT-5.5
> > Fixes: 31b7720c8259 ("fec: Convert printks to netdev_<level>")
>
> Not a fix.
>
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/ethernet/freescale/fec_mpc52xx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx.c b/drivers/net=
/ethernet/freescale/fec_mpc52xx.c
> > index 556f646073af..a770e7edb1dc 100644
> > --- a/drivers/net/ethernet/freescale/fec_mpc52xx.c
> > +++ b/drivers/net/ethernet/freescale/fec_mpc52xx.c
> > @@ -834,7 +834,7 @@ static int mpc52xx_fec_probe(struct platform_device=
 *op)
> >               goto err_netdev;
> >       }
> >       if (resource_size(&mem) < sizeof(struct mpc52xx_fec)) {
> > -             pr_err("invalid resource size (%lx < %x), check mpc52xx_d=
evices.c\n",
> > +             pr_err("invalid resource size (%lx < %zx), check mpc52xx_=
devices.c\n",
> >                      (unsigned long)resource_size(&mem),
> >                      sizeof(struct mpc52xx_fec));
> >               rv =3D -EINVAL;
>

