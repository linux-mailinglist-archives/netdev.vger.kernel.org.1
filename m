Return-Path: <netdev+bounces-282143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNOUHnxJ8WnAfgEAu9opvQ
	(envelope-from <netdev+bounces-282143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:57:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE3448DA6F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC054303BB17
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392AF3815C5;
	Tue, 28 Apr 2026 23:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPu6cejQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EF435F60B
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 23:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777419581; cv=pass; b=t0EUdQv5L+VCRujp3q9bW0CMyeGnug63GAQifKnDKLLSeh2boGv1X2maNv7KR2ogYgtbZp95xrthocAmkkpMs1ACIm3b7AgWQjj88oPx7QVQ7fp64VlzyWqUxA85YI4mmcS3I1QwO+oudRv4CxFSvU+fFt7XkomV+mxDUsqc14A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777419581; c=relaxed/simple;
	bh=A92B7NWE4WCpfgY+IcSqaAp3BVYZYZu2BPhtantz6ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pM4l0DoG2rqtb8VDaOgZTT+xrLyW0b+xjM7RxxYn3KqrahVyNTKe67vLYpQNr+JMdTbjzCqPx+efN/RxtYBl0D/9gK1Kl1w90LlzTXC68gPFBxvlZLhPR4yZtbE+YYH3Xc7tjTc33y63xrpDsMW5mLXKKk3wkkg3cAacxXYex+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPu6cejQ; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-676e62faf2bso12981262a12.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 16:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777419578; cv=none;
        d=google.com; s=arc-20240605;
        b=b44YUvPiuJ/ZUzPAO9EpTSYmCmYdkQjMPsRzfwQl35JKYj5RV1pA8cQgQ6aCLEcYxG
         DITVuyUOw6X7ldfh7Yilmnj3bwLiQQZ9+nrVMcnY+wKa1fWaC5PQ7VAMX7B5OaOTfCxY
         GzzpOb4zor5oFZiHkWSO0A8wVL75vEZdJUsLd9PlnE8iHvIPrVgocW+a9o4kaAteED9q
         TVE5h2SZPs8qjBaGjTAR95dprbxds/xR2vOabVXTxfCskJ30UBVJi0tc5/dM+tRBvCxP
         cJ4O2EMgOE5tnymhYkfGO2ECv3CrsLeBrwe5IFDfJelTk/OnixGTrjraBeu7mLdOLfjm
         bkXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VNhHVWc3bpXNfUDQcvDEyzFhmpbPBlmGiAxIX7G+FhE=;
        fh=xYqZzbZo7gkXGIXbZUWrdlEbdtmvlA4A3HGwRevES9Q=;
        b=NMDVO45ksfPpbv3tP3prDAe8kUiZhPCRsZdE7O3lQ5Bq0NVBqSLgD7qdgyMfTkxU1N
         fBOKEE9bQwLu+VrILn8WZqahpFQnX7hJX3qS04LhjBMGD3S3v5ojVczeiKErWMultU4h
         7i2xz+P17wR258ozMvL9RHCVnV+Lt2F+zOORrPcwywPtWra2o2oJJeHlf9gr511D8F1u
         Xxlh1ssgBhN12vzNLyWXoubBsxscPMwBB0lqVmfib/ZUQYsbkFE9E6LkSOuLyTjChfuL
         ecedlqGwNmOFA4Nzii5ReaXTQCORq8f1QP0TAefd08u+oCshIuhIXePgnx7UwZMcA6gp
         UCzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777419578; x=1778024378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNhHVWc3bpXNfUDQcvDEyzFhmpbPBlmGiAxIX7G+FhE=;
        b=oPu6cejQNwBw7wbf+IYD/iu/w6j2wExHNLhANDxxHYC6lDFOHCeGwY6iy/Y0q76X43
         ee5xsH7q++15xegzi19CHhtjqYxZa88ac+3/4Tffj42PzdmaILzLmb0986yg4TOkx9mO
         j6PNVJO3DKj3eq/jZiYIyJhWTQhKi/epyQOdZjFr+xPgdn/bUmO/zxPIxwzBceeLmMWX
         D94jvgjnlpb71uZhADC1thPX8EHZq+66NCeH0iCroxe4E7Xz1MIeUHdVA4E3VkbEQOtI
         y5arTi5cCBleoYezwFRhFOR5pcBA0jyOEGXtdsBrbUbLcr4FeDpzQ/xYJwdZRmSjDsPl
         pasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777419578; x=1778024378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VNhHVWc3bpXNfUDQcvDEyzFhmpbPBlmGiAxIX7G+FhE=;
        b=f13DR9KBfdmb3t4SiQyY5A8P2nahNEf3idgb0fJctMwTAJVKnxsgFhjTHWz6VNg9AY
         RwvAOEDK7TC3T+R0oVhCupwHBa+5vrGfqrXKWN5713pvsVSdZTRs9wfW3EjTtKWnjTAA
         p6s1UBnZsLR9x3YVP0AiFX616RftIuR06JtVfDN3VdLNoNVAvOWIR4laGen0agkvonYL
         5M3FR/Hwmcu6at/vid1J7/2ZQRpx9yUBpts7e53HdjXkcTDhW5d002ueBKoGX9aYhOlA
         x9Pdp33wU1adhPGXAxKmLG+0eQJtYZy6NwTONlwVfU4uC5NcjX84HhWwGpG5Z0GJ+IdO
         Ku7g==
X-Gm-Message-State: AOJu0YwAD1HlYVzuRKN3WczGKP4ac/8cuqOV+5RzNDaDBMIa2uUSuiI9
	btbCq1in/+RBbI7BrzSwP8kycv71k5Qe4sRS5Qe7Az+lA5CK/HzPsFIWBWQlC2Ay7AqOpBXxNH+
	YT9f4Uj4WBwwJdMchHu5x9SHyyKkIMNg=
X-Gm-Gg: AeBDievVdofFzf2Bf5GeHxy4fmaIvm0mxWf1F2UnvD56p1vMznUS43e5BP1GaWwkCW8
	F0OOw4l13N+LNFUqN7Adq8vkygV8SgS63grNqp006tBtdgWtoTAkvSLT88otU0yINeFJbKmNvc9
	SkHtzsR4iwcxOu5PKjbXvorKSBgiugc3Vu8p5MviItumGLp9wsU/f7SGC4rlYhvOvZCqSULw98j
	RxVBo0arfzJPqSqRixNwvLyDv5gWgK1ffVRNapSxtFeabT4+HCG9GVfE8inRWBqkKms/HyMHAMo
	3QZ8nZUBOytKQU/O4RmhfW8MKDqyK7WzcPZnR1C5MxIKgpmHeQdv9ty5dklmpZSmrOA8f+h4tQb
	c9kasNFVl7nPaTZ8+M3wjALCGVXjsjZ8QlWNnGdMeXt48FxAJ
X-Received: by 2002:a05:6402:1585:b0:678:a507:e80d with SMTP id
 4fb4d7f45d1cf-679bb092bd7mr2495499a12.22.1777419578002; Tue, 28 Apr 2026
 16:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428223058.113013-1-rosenp@gmail.com> <0f704ce2-e936-4bc1-8ab2-144de9e74af8@lunn.ch>
In-Reply-To: <0f704ce2-e936-4bc1-8ab2-144de9e74af8@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 28 Apr 2026 16:39:26 -0700
X-Gm-Features: AVHnY4L1iilQvPglaae7zScEeH8Oe32ld24xdiIF8FmCA8V-ahGeppChZScG9YQ
Message-ID: <CAKxU2N8yb9-M9zELSxdEjLz02GKFZ2mOmgHhc7NbW+oJsvtGXg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: gianfar: use alloc_ethdev_mqs
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CAE3448DA6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282143-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, Apr 28, 2026 at 4:13=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Apr 28, 2026 at 03:30:58PM -0700, Rosen Penev wrote:
> > >From looking at git history, mqs was introduced after mq and after thi=
s
> > code was written. Having said that, mqs can be used as there is already
> > an RX queue variable in place. Not only that, mqs already sets the
> > num_xx_queues members. No need to open code this.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/ethernet/freescale/gianfar.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/eth=
ernet/freescale/gianfar.c
> > index 3271de5844f8..7b47c7c49c08 100644
> > --- a/drivers/net/ethernet/freescale/gianfar.c
> > +++ b/drivers/net/ethernet/freescale/gianfar.c
> > @@ -669,7 +669,7 @@ static int gfar_of_init(struct platform_device *ofd=
ev, struct net_device **pdev)
> >               return -EINVAL;
> >       }
> >
> > -     *pdev =3D alloc_etherdev_mq(sizeof(*priv), num_tx_qs);
> > +     *pdev =3D alloc_etherdev_mqs(sizeof(*priv), num_tx_qs, num_rx_qs)=
;
> >       dev =3D *pdev;
> >       if (NULL =3D=3D dev)
> >               return -ENOMEM;
> > @@ -679,10 +679,6 @@ static int gfar_of_init(struct platform_device *of=
dev, struct net_device **pdev)
> >
> >       priv->mode =3D mode;
> >
> > -     priv->num_tx_queues =3D num_tx_qs;
> > -     netif_set_real_num_rx_queues(dev, num_rx_qs);
> > -     priv->num_rx_queues =3D num_rx_qs;
>
> Please add to the commit message an explanation of why these two
> assignments can be removed, because it is not obvious.
I didn't explain that _mqs sets them?
>
>     Andrew
>
> ---
> pw-bot: cr

