Return-Path: <netdev+bounces-271810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKGtN62YxGkk1QQAu9opvQ
	(envelope-from <netdev+bounces-271810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:23:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D218332E582
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C97CC300C7FA
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 02:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539943783D8;
	Thu, 26 Mar 2026 02:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpyrGKNr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E724F326928
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774491816; cv=pass; b=eXu5R9IGHp83rgJ4XG+LE898q2BD5r5jOmXstDlU7QfISNhwl4l7i8PzNv2KPVceu2vBjrMAnBNwjKiTXAYak9h44bgWpkNn1+znDrWKkmUYKnRWOWgYvPTjp0YrP9DEBlxSmP1N396ceF4jmVaD8O8z2Z1Cn8f6yGf3w9BYHZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774491816; c=relaxed/simple;
	bh=BI/2ZzBnY7PxSi9Tr8bBTb2UihcEEreGXl3MBqk5W/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5WfbCPWh+od3KcEcJ1mMb+DgxnBqkzUeCUp1MKyWt9v1gqtyY77xx0w2MB1blyH8vxpkJKYNprYzgHz70clj2IVPlMEydEXLZJzPWga6PVB7geyKhULbzlNelxfBIyL2S2Jv6MkCOWE7OvfVqLf/aKAMiF/ZScBITRPhu5EzF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpyrGKNr; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9825ba7e8dso64280066b.3
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 19:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774491813; cv=none;
        d=google.com; s=arc-20240605;
        b=icoGSlBmk7H/zSP//BmclWoIEl2r0YRxzmf4eCNn7VxqZ3p8VyqBZ7WDNSthXsxgoq
         S4V2biSSpEWcwNOm6xCKC8ef1mXs5/aPqeFZW8sAj1P2AsL3CnsEvVWgX72Ir4GuCriz
         qzejKNFCqRflRQE75YG/TEufc5Gflg2cFiE8X04cciouyyvd+q6CWT06LE/mFCjhWcDR
         mgnHGNaC01CdNxqJARrlEOg6or9rTKilyFBc5+1mTe20Ai1dp+678uqtYMr5sCHoKRVS
         zOhxD0sKF2PvAuXcIv5sHSxtNYDO53W2rDix0X+XbRM1KrunB9VMNHh25EOe5Mu5LDCp
         KQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0s9BYVcUXYfDOp1vglCDYA9VUszvYb7bPcrqX3W0hQs=;
        fh=zlqKpO/M/Nh3x5f2ePMi6+5TOLzRSK0ARQmC6K8dpLg=;
        b=V0/Yv1oRu9gQWfSE64zMNOdcBEHsIUHQFWoQFT1M5AVFBUr9YPnBg/VNHMI5/8bRtj
         L4UZY70BqSoKCI9n6r4MTXj53/7ka9+231uqVknQNJIfFQ+BK530aM3iM2RyUv4NQHb1
         5z93O4kcXUeByAJ7INp5YkKgqnJVsCzOLbBVs8VY/TttmTUZEWhLdKcnedgnBalnNwev
         VO3bW4UD4vbbtumqRXI+vn5HJspTbLoP7EuIiv2K/o+PHQN6lKKvJJcq7gdmNvEOABNv
         eBeCVFhC3Yh/2QcTBryUYAGHWEOwLR4tfcvaemjTmx9l7tGaMWUU3KDRZOWipPwleqwr
         4L4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774491813; x=1775096613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0s9BYVcUXYfDOp1vglCDYA9VUszvYb7bPcrqX3W0hQs=;
        b=EpyrGKNrM+85hsIy6olGYgk14PcgGp6/QT4GAFwdhp3bZeT7Tx1PZQyDHYBUr8su8e
         cjuUMYIPh16KzW58qnhm++qZDIrA0LMdgjuaeHGmzFSq3kmQ99+Drj/DfEFwlGTr/oAM
         IMLGAXT+KcjHcMtdofRoz3aU7jSGMqT2ZuRIzS/gU/MaF92sZECytkTS4QvX66EV5MjV
         2MkryB0kd55PQgluXu/ufrinME/ejzVYYM2gRnolWYunlodsWUfPjLjxaBN7m3+gZFip
         j4pE+avSs/uIDimNscQWuDKieUw04gtzmUWgL89t6fZw6kGCSljDrLv0/nqpce1bxGMK
         vmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774491813; x=1775096613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0s9BYVcUXYfDOp1vglCDYA9VUszvYb7bPcrqX3W0hQs=;
        b=h6QLx9DWnOhOYGoJLDAiSR07jw8Py+p07hlns6fq2cupmtcciYN7bR/XGwLpRRWJlo
         JHV10N1sRubos3XOCB1/upfCP3C4FyG1GWyoaTdm3iBEA6l/BxhnVb7KRRHRuzaU/EHx
         pJx31wfZU5ceWmgIhl9n4EACnmVvM2d8DjBZZvbDoW/E2KRg2ZRM38e4K/3IREXMfQFN
         LGyEeivBxkbJ3sNF2oSfqDP+tfew9v/+/Y70WNCDv5LKM6Uq/t7k2PRydJBLLt/xPQqT
         i/HUvOIJeJ9l5CUqikTHK99loQsQlfeFuCJfHCebSLwtia7YyGdae9e0XV38wLldwNSB
         485A==
X-Forwarded-Encrypted: i=1; AJvYcCVJmyMqTrxTEXgfcpxcXHJWcF9Xx7pwE1m5O+JQeXALtan3c8Ui3pTRINQZnO4oyAHD2Nv9y18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp0GUqBg9z5p/4W35QxXEEYwqXc0sFD23pG9sgI4YGnMBJPDMX
	Mo5/fXQGE6JfjmCoPhw1HsTfk4hOSmBQk7UIjTXBgLCPh84Pq8GJOc9MNgQ8LVzaG+JvzvspdcV
	nu0ABN0h/l87MMbW2Nqiu3DlEd7p7N/o=
X-Gm-Gg: ATEYQzzHFF/kr1BtVaanIQEexkJmagOoPtsnmdkSPtY/CvN8IohJsf63ITlIlWXsIu6
	GCoKYQNVTMGHfoIKKD+fA5DKh8Rf842k6QIM2owqwomW+f6JOgwly1Xp0avHFQI0rR/LdQsJEef
	YYAAs9KgvFYTTBi45+F8JwtV2hIxqOz+4YJNZN+L9AK5jSpic8jkF6VU+oMR16dXPgb+nr2Abiv
	WGjz2tRQmzY2R34UJipdc4ETvXKjLNooStDdAgkQgWUXoVlkpno5TOX5thR+/Xr8AkHPMRBZmAL
	WpjO1/LLI0QON/m2eMadVhpfeIgHOSs0IW9+IHGXy6O9dtb4zKs1U2lpx08bCGfwRp0kEzcc2mP
	Ab9prrQ==
X-Received: by 2002:a17:906:ee8e:b0:b94:cfd:f37b with SMTP id
 a640c23a62f3a-b9a5426928dmr370259166b.45.1774491813119; Wed, 25 Mar 2026
 19:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324032243.26387-1-rosenp@gmail.com> <20260325172734.GA334461@horms.kernel.org>
In-Reply-To: <20260325172734.GA334461@horms.kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 25 Mar 2026 19:23:21 -0700
X-Gm-Features: AQROBzDvM9KixCzVDe_3rsnW2weihEvz36neZ5eOgzFxNGkIRclOewKV8fXC478
Message-ID: <CAKxU2N9RJ520QS=rsXujp1RUs=1=DvyC_JF_PNBwnCn4fkpN3A@mail.gmail.com>
Subject: Re: [PATCH] atm: nicstar: simplify allocation
To: Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, Chas Williams <3chas3@gmail.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"moderated list:ATM" <linux-atm-general@lists.sourceforge.net>, 
	"open list:ATM" <netdev@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271810-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,lists.sourceforge.net];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D218332E582
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 10:27=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Mon, Mar 23, 2026 at 08:22:43PM -0700, Rosen Penev wrote:
> > Use a flexible array member with kzalloc_flex to combine allocations
> > into one.
> >
> > Add __counted_by for extra runtime analysis. Move counting variable
> > assignment to right after allocation as required by __counted_by.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> To be honest I'd prefer that we discussed deprecating and removing ATM
> rather than cleaning it up. Is anyone using it?
Beats me.
>
> > ---
> >  drivers/atm/nicstar.c | 17 +++++------------
> >  drivers/atm/nicstar.h |  4 ++--
> >  2 files changed, 7 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
> > index 24e51343df15..2f6a3637aeab 100644
> > --- a/drivers/atm/nicstar.c
> > +++ b/drivers/atm/nicstar.c
> > @@ -867,23 +867,17 @@ static scq_info *get_scq(ns_dev *card, int size, =
u32 scd)
> >       if (size !=3D VBR_SCQSIZE && size !=3D CBR_SCQSIZE)
> >               return NULL;
> >
> > -     scq =3D kmalloc_obj(*scq);
> > +     scq =3D kmalloc_flex(*scq, skb, size / NS_SCQE_SIZE);
> >       if (!scq)
> >               return NULL;
> > -        scq->org =3D dma_alloc_coherent(&card->pcidev->dev,
> > -                                   2 * size,  &scq->dma, GFP_KERNEL);
> > +
> > +     scq->num_entries =3D size / NS_SCQE_SIZE;
> > +
> > +     scq->org =3D dma_alloc_coherent(&card->pcidev->dev, 2 * size, &sc=
q->dma, GFP_KERNEL);
> >       if (!scq->org) {
> >               kfree(scq);
> >               return NULL;
> >       }
> > -     scq->skb =3D kzalloc_objs(*scq->skb, size / NS_SCQE_SIZE);
> > -     if (!scq->skb) {
> > -             dma_free_coherent(&card->pcidev->dev,
> > -                               2 * size, scq->org, scq->dma);
> > -             kfree(scq);
> > -             return NULL;
> > -     }
> > -     scq->num_entries =3D size / NS_SCQE_SIZE;
>
> AI review points out that previously the skb array was zeroed on allocati=
on,
> which is relied on by the code. But that is no longer the case.
Will fix.
>
> --
> pw-bot: changes requested

