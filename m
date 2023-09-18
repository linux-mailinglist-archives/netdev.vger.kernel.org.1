Return-Path: <netdev+bounces-34838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 895FB7A55FE
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 01:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337022819F5
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D7428E0F;
	Mon, 18 Sep 2023 23:01:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A492E286B1
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 23:01:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5411291
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 16:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695078089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84tq1/HWKdqyn9xUbNRRu/FsaxXpGe6unkYsbFc8YX4=;
	b=BCRuWQc8BQFnPVDMQ394FXqfMD5KYrV4rMEjwmBaEQur0efqn4at7oPBA9V0rO1Zb/9M1Q
	KWDbZZ93c10ScbBZe8t+6cfsXK+E0jcJ01CRD2/B08eMVSFrsC/nnHDKrBnWNPgH3ZGYad
	30xnAH/EgATzXhDKES1EO9fIZEAIyU0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-PkDdnvRkOcy-nbdbkg9_jw-1; Mon, 18 Sep 2023 19:01:27 -0400
X-MC-Unique: PkDdnvRkOcy-nbdbkg9_jw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a34d3e5ebso327262866b.3
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 16:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695078086; x=1695682886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84tq1/HWKdqyn9xUbNRRu/FsaxXpGe6unkYsbFc8YX4=;
        b=fG2E1JWd2foCAbDIWzWjyaobyHQjl7SzxEW6MVwNnBjYl8Qvuf+fnt0+Z9JZVDfL0O
         svYg6loAkbFLhCyaqMWWKiERUQPLb61inwmmy+MYCe1Bru5ot7s8FIJ1ynYzkmuzEUlE
         m1XPH2OuZ0ZYZ5815NPAmTkA8sy8TN9mb6ABAIjfYfc1IL6tEjiJQhfN0HLRonPbRrC1
         YcPDQHdnhKJGwhiNCS0Mb0HnlXgnzi4E7J4hvvIUjeE2WmOeRaN0c737Hi+PAAgpRwgn
         nClKHyMXtwAVl0iUpVVWpZjGMYvTIv0YkWVTOKRzTRBldy3zAVt/G1nAVlX4Ho3vB3d1
         OSQw==
X-Gm-Message-State: AOJu0YzS5MhRExET+wH6Mrj3EBAkJso6OKqNos7Pr6Hi8MlzH/rZ+XXi
	PHdIZH6+ec91e/EerutL67n5TZpNIAksnJGfPHNMCSiLiGEfsG9c/qDVkV+tq/jJ3QBuCCiPS51
	aQL509xMDBIlmcPZYB3CJf7ckMHPbQ7nS
X-Received: by 2002:a17:906:23f1:b0:9ad:e18a:734 with SMTP id j17-20020a17090623f100b009ade18a0734mr7659075ejg.26.1695078085931;
        Mon, 18 Sep 2023 16:01:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZb740y3CJWM79Ipv7jWnaLd2HvL5Ms/v2bRprk8HjmElljLYl0tycSr2t52+5ywuSL2GObd4afK6ypcux+7E=
X-Received: by 2002:a17:906:23f1:b0:9ad:e18a:734 with SMTP id
 j17-20020a17090623f100b009ade18a0734mr7659068ejg.26.1695078085662; Mon, 18
 Sep 2023 16:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230901170501.1066321-1-miquel.raynal@bootlin.com>
 <20230901170501.1066321-3-miquel.raynal@bootlin.com> <32cfbf0f-7ac8-5a4c-d9cd-9650a64fc0ea@datenfreihafen.org>
 <CAK-6q+h1rbG+6=M+ZZfUznHq9GxOwtA1i0c=C9dgQH1qC7sQ=A@mail.gmail.com>
 <20230918110102.19a43db1@xps-13> <CAK-6q+gcqr=Sgswgzd1pzMQoPEV1jG=_0m51+HsKU_=1b7NYUg@mail.gmail.com>
 <20230918161502.69818794@xps-13>
In-Reply-To: <20230918161502.69818794@xps-13>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 18 Sep 2023 19:01:14 -0400
Message-ID: <CAK-6q+g5d=LNfqTLpFTTPcscjHqoGGyUOtb+M9unTbE-Jpwxbg@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 02/11] ieee802154: Internal PAN management
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>, Alexander Aring <alex.aring@gmail.com>, 
	linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	netdev@vger.kernel.org, David Girault <david.girault@qorvo.com>, 
	Romuald Despres <romuald.despres@qorvo.com>, Frederic Blain <frederic.blain@qorvo.com>, 
	Nicolas Schodet <nico@ni.fr.eu.org>, Guilhem Imberton <guilhem.imberton@qorvo.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Mon, Sep 18, 2023 at 10:15=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
>
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +/*
> > > > > > + * IEEE 802.15.4 PAN management
> > > > > > + *
> > > > > > + * Copyright (C) 2021 Qorvo US, Inc
> > > > > > + * Authors:
> > > > > > + *   - David Girault <david.girault@qorvo.com>
> > > > > > + *   - Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/kernel.h>
> > > > > > +#include <net/cfg802154.h>
> > > > > > +#include <net/af_ieee802154.h>
> > > > > > +
> > > > > > +static bool cfg802154_same_addr(struct ieee802154_pan_device *=
a,
> > > > > > +                             struct ieee802154_addr *b)
> > > > > > +{
> > > > > > +     if (!a || !b)
> > > > > > +             return false;
> > > > > > +
> > > > > > +     switch (b->mode) {
> > > > > > +     case IEEE802154_ADDR_SHORT:
> > > > > > +             return a->short_addr =3D=3D b->short_addr;
> > > > > > +     case IEEE802154_ADDR_LONG:
> > > > > > +             return a->extended_addr =3D=3D b->extended_addr;
> > > > > > +     default:
> > > > > > +             return false;
> > > > > > +     }
> > > > > > +}
> > > > >
> > > > > Don't we already have such a helper already?
> > > >
> > > > There must also be a check on (a->mode !=3D b->mode) because short_=
addr
> > > > and extended_addr share memory in this struct.
> > >
> > > True.
> > >
> > > Actually the ieee802154_addr structure uses an enum to store either
> > > the short address or the extended addres, while at the MAC level I'd
> > > like to compare with what I call a ieee802154_pan_device: the PAN
> > > device is part of a list defining the associated neighbors and contai=
ns
> > > both an extended address and a short address once associated.
> > >
> > > I do not want to compare the PAN ID here and I do not need to compare
> > > if the modes are different because the device the code is running on
> > > is known to have both an extended address and a short address field
> > > which have been initialized.
> > >
> >
> > I see, so it is guaranteed that the mode value is the same?
>
> I looked more carefully at the code of the association section,
> we will always know the extended address of the devices which are
> associated to us, however there may be situations where the second
> device to compare with this list only comes with a short address and pan
> ID, so your initial comment needs to be addressed.
>
> > > With all these constraints, I think it would require more code to
> > > re-use that small function than just writing a slightly different one
> > > here which fully covers the "under association/disassociation" case, =
no?
> > >
> >
> > I am questioning here currently myself if it's enough to uniquely
> > identify devices with only short or extended. For extended I would say
> > yes, for short I would say no.
>
> As long as we know the PAN ID, it should be fine.
>

yep, so you will add a check of panid when mode is short address type?

- Alex


