Return-Path: <netdev+bounces-291187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C0PAcwFE2rU6AYAu9opvQ
	(envelope-from <netdev+bounces-291187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 16:06:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A71355C2A66
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 16:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22AA7300AB22
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78349392C52;
	Sun, 24 May 2026 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyTeYXKE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44752DCF55
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779631558; cv=pass; b=ud9NCoui7IkZuv/QPvdVMXP+Id/8yMNxfSHnimlEAQWloRDpvBvYwMUqoqWL8I8+Ad2rW+CkFCcXRzy5DMvY5G9xqz0E4xRdHVn7EpT4IK3Ph3AezVkdTuhsyxU83dl4lshu1lBJg1sZ2tU2Z+ChSWRPkG+UUj8GHIbqdrRZeHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779631558; c=relaxed/simple;
	bh=8TQjkN5esIY4JTkBWoE3kbw8zEGScDUqZgudxPBLziU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8SP626KwA7hgovZmbx9KdOqjDC+R1RywJ2ed8mjEgBsaXztbi1oMnn1KWCs/hOE2W0Fw9NTo5wXY9AyAXu/sOyVD5TWmQtq9liwyzUouG3Zv/vfN1g28K+KTjNwjMP5ikm+hcSbzDQZVUIUutn2nQfCbcAOqxzKULAWqd11dT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyTeYXKE; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39394e1e8f3so84286711fa.1
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 07:05:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779631555; cv=none;
        d=google.com; s=arc-20240605;
        b=WWWPKafbwBOB++3RnCeXaQefAwkeLP5CYRFMz93awQHjLFofHNhfwoD6kbxwfeOROR
         eMasAoa1LvL29i8pUnJhQ4ZY02Liq2KnwWYS4IW4YE3sdB6NCiu38/bvR0eAmaG5q+zM
         rjPsO3G18+kNP44xiRNIScPm6IkaDLaWeSL6PS/nBUr4RkbwyYTI16Hsx8xZXvKGWjqt
         TSKotHlT3v1O2nocbQ6odVCmjuv70FfnEnY/Z0wlqgXcsPIjIzZDZ5gYzQronYGgmCtT
         bvEtHmHmjBpOTizLJBhCu+Eb5384NcjGLk5OV1YOgqD4DaLe62r5xUnuzNDH4twfmSZG
         +bOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bdZwTivBnLw8YN6rzJBlkMLCMU1ux19W3OI491gIMvA=;
        fh=pX1MLrLh4qS9s3SYNntMEwhmAhGZImmbWJsHiFoUEOY=;
        b=CEiBWKo0XyvFWJ/ptGppPdZEOpxfxbqOM5a2wt6OK5Y+mR6rih+4m6Ovf9fy+gwpI0
         uFDIVPHFVl8ULLIrslDTvPTOuPs1wVBRRkAMQzFEC0KSa2zJyg01OEInUye1aUlSJcZt
         /hO8q7+anURMmaPKEYKCku4zW04z/3i7B9uhXqFqFlDcNs/8JgulIFXuhqWp7zC6gVjn
         AjvE6hSmGrxUq9+MfJoIe0WBnZNprjD89S+JdCC/jltgA1EO7BHmDmdMitXefrKAoRzc
         0Q2h9LELtXHw5MmKZ1KLo5YD8/lTmzHMWa9cl6pP1OMhWp2dNFuO7iOppl0eXtYVXcoc
         E1Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779631555; x=1780236355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdZwTivBnLw8YN6rzJBlkMLCMU1ux19W3OI491gIMvA=;
        b=PyTeYXKEnDYryCe3Uf4m0Ry0tQSsiiXuU8lYOlmFSevojg5rbohBjMuird80Ct7qqt
         /izAsxF1DqMHAZsDlTP2VdFslzQndhO+d0Jx4ckWyzIaMXImfJaRiFgwIE8Giz01ushQ
         b0TEXGg5OaJwLxS4nOXDgdysxmSXS+9GZJgzhULDBvatH1EFAB4aZRTtwCclwyW9Abc3
         TuAypxlvC3H8WerKYfCtl4T2a0Pu3mhux5b2SSmNFG9pW2WsSziMLD8Gx6WfLfUebt5s
         XmzUokhdlDfW1Fu4I+wsDvSVAcEQMey2CPsqpFLzx0BbS03rrrG1MfJGQXZxrMuq1zH7
         2K/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779631555; x=1780236355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bdZwTivBnLw8YN6rzJBlkMLCMU1ux19W3OI491gIMvA=;
        b=RLISgRQwu4K8Q5rzCVuK68sWnwZO42z03JP76nB2J7tB9iHKpDXQpkbRh3fJsUwI/X
         I6+4tPMEYpNn4X+VQXxaZPe/87rcdGe2ZpguMMweL3thkobgdnI73RoomtT5x1qAGM+O
         y3x+vOcTbDRU54x51oM5B1FxhKKRJ9t+/1sueSrnda9zDOrYtQ0Z3SYrV1ADZgvGyuRH
         0WelgtN47zIv6B/63TIZzpjiacmd5rubQfirmnZa4iM6SyB6L0Ojv9d9rzm2Be9XxH4f
         pnH84IOvVajN91R2XBg2YEagPgHmw4NWQfjshhdY6klswFQ2gU11Y11qTxIyZGkOiNZP
         mNcA==
X-Forwarded-Encrypted: i=1; AFNElJ/NFsQuHLOxEIfYMc5yPrVrv1DbRA68aMFAFFAMGtcm0UnKJodTELKzbb+CgeMoMPaU1Y8F9b0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPskYIxM5aFAPGXXfCPKsU+PYVz+mlhn5ja5akEl6oDNjc2iKG
	ypygwoudU73lntQ3fLESJyuvcfdyqBrixjIfME63mduM6TKE3DY5o7yTkx1w+a0TLxyY5zxWgNS
	BbxXKFrt4A2He9Sq1nRzwvxabcjQpY3U=
X-Gm-Gg: Acq92OFbl22/Dtj8/fitG9QOQ2jPZXSa/VT49J6l/PpaPkfwRKZ4XhOX180ICsqlKCo
	Ejaz5IAXgC8T+kz6QLrvEkeTsOJ8WyEfC2xNJKCXuXdLtC8KqK5V8smJqRWUAJ9mRpJ/sN4g7eT
	TsZEa61nnOAHkZUrAjiE3KLMOnmI3834xUyKLRTPGv3BMYqCiO9/8VYZrzY8wY+nEDS3nokhvaK
	5KrFV5D1GhT6u08svgHoSvJEQY3tRoXJbSojbE67Yet0gn/x4eM2Pk21IWK3BDa0cbbRogAURLy
	LGyRFfq8bFWWLuH1wDMGxbrzMwEt95bX3q6NCmv0
X-Received: by 2002:a2e:940f:0:b0:395:7b52:6b09 with SMTP id
 38308e7fff4ca-395d8d62838mr25850021fa.26.1779631554617; Sun, 24 May 2026
 07:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522093906.39764-1-sigefriedhyy@gmail.com> <20260524135938.GA86099@shredder>
In-Reply-To: <20260524135938.GA86099@shredder>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Sun, 24 May 2026 23:05:43 +0900
X-Gm-Features: AVHnY4Kqvee_yxbiE5R0nFswj8TtcIKzHC4McO20sgJpwTUIO-vbgk5TbvB2Vz0
Message-ID: <CA+7S2vJc7F__vWiprT9bT__+CUwSN_=jssAiu=GiLZG-Ho662Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2] ipv4: igmp: annotate data-races around im->users
To: Ido Schimmel <idosch@nvidia.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-291187-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: A71355C2A66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>This one isn't necessary since the object was just allocated and not yet
>published

Thanks for the comment. I did consider not modifying it when writing
the patch, but decided to keep it for consistency, it makes the code
easier to reason about later. If you feel strongly about removing it,
I'm happy to send a v3.

On Sun, May 24, 2026 at 10:59=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> w=
rote:
>
> On Fri, May 22, 2026 at 06:39:06PM +0900, Yuyang Huang wrote:
> > /proc/net/igmp walks IPv4 multicast memberships under RCU and
> > prints im->users without holding RTNL, while multicast join and leave
> > paths update the field while holding RTNL. Annotate this intentional
> > lockless snapshot with READ_ONCE() and the matching writers with
> > WRITE_ONCE().
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>
> > ---
> > Changes in v2:
> >   - Added Fixes: tag
> >
> >  net/ipv4/igmp.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> > index 27d120183779..f2aca659b29c 100644
> > --- a/net/ipv4/igmp.c
> > +++ b/net/ipv4/igmp.c
> > @@ -1541,7 +1541,7 @@ static void ____ip_mc_inc_group(struct in_device =
*in_dev, __be32 addr,
> >       }
> >
> >       if  (im) {
> > -             im->users++;
> > +             WRITE_ONCE(im->users, im->users + 1);
> >               ip_mc_add_src(in_dev, &addr, mode, 0, NULL, 0);
> >               goto out;
> >       }
> > @@ -1550,7 +1550,7 @@ static void ____ip_mc_inc_group(struct in_device =
*in_dev, __be32 addr,
> >       if (!im)
> >               goto out;
> >
> > -     im->users =3D 1;
> > +     WRITE_ONCE(im->users, 1);
>
> This one isn't necessary since the object was just allocated and not yet
> published

