Return-Path: <netdev+bounces-36950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B29F97B2975
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 02:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 968781C2093E
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 00:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D1B19C;
	Fri, 29 Sep 2023 00:22:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C220188
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 00:22:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E3C180
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 17:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695946959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=666yXX+Rj9/y3DrZAVThOB3jlkyaoQEETt9yyPl70zw=;
	b=ROs3jLrmEKkSTrnCqZtal1FYxbeWdZfXwxphCtVTjCjFSATOpilrsvRySUrVLBm7mOSUWS
	FGckKwx4PdrmpB7IZbStWFfv1ARIBaGYxae2LumFePtqEPMTIBpfCKyHCXuJLh/UmFrRRx
	gFt/OsttWfcwfoGb/pYODBFzAXRCeTc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-xf8YEGaiN3S4T2SSLft1Dw-1; Thu, 28 Sep 2023 20:22:37 -0400
X-MC-Unique: xf8YEGaiN3S4T2SSLft1Dw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-53498ce5aceso2960800a12.3
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 17:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695946956; x=1696551756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=666yXX+Rj9/y3DrZAVThOB3jlkyaoQEETt9yyPl70zw=;
        b=MgDwbzqFMcYVxUSyg4WQ26ePa9FRX20XigF28PkV3U0UAB9g7L73KYWu/dcOAyBLSo
         T/jhnFlw44+qxGtUTtIv7sxaGgFkn+gl/P8xPHraJH6h8njrCmpRN74ZL+25seKlgpwL
         Bd3AmWMJQb6Ay8A4Co8jjYjcdpqAD/hWX+tzKdTaUjYa5N/lnp8B5fbL/HaTKLNdz47z
         QOVyH7A0QhkhtYleOg18U96JTAaYInwCOl89NH6xwJ9aba4b+R8EuRmBGmHWblpLqrpx
         fZyVy2McQGhnEkKukGIkCRDVcVCgvIcLBdheiZiQ49qvAQK0m+rqAIrhJ3HOUfOf17By
         i0gQ==
X-Gm-Message-State: AOJu0Yym4mW/r25eHRvly8/YXOkHScSGj1cXze6qpBN+Ml1FS1lS7AEy
	n9nGVGcZLppeHuqoPrhVmJK20Zq01OScLsa8PllTKMYMdOhcwey3+/jOQbod+PikUwGcA0lhkhe
	ThDU6e+6TONwYlclqTTsUhzw62MHZesFS
X-Received: by 2002:a17:906:6a19:b0:9a9:eef6:434a with SMTP id qw25-20020a1709066a1900b009a9eef6434amr3035479ejc.36.1695946935883;
        Thu, 28 Sep 2023 17:22:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuppoHwvTpg1KFZiUtD4X/AbtaNHLSnQmyb2ostcKahHEJUcmjUOWI8ySL6L2H5t5oBG/K96u1mTGkfAeXB9Y=
X-Received: by 2002:a17:906:6a19:b0:9a9:eef6:434a with SMTP id
 qw25-20020a1709066a1900b009a9eef6434amr3035448ejc.36.1695946935564; Thu, 28
 Sep 2023 17:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922155029.592018-1-miquel.raynal@bootlin.com>
 <20230922155029.592018-3-miquel.raynal@bootlin.com> <CAK-6q+h_03Gnb+kz3NgumcxS99TV=W_0de2TCLXAk4uPg5W7BA@mail.gmail.com>
 <20230927175635.2404e28a@xps-13>
In-Reply-To: <20230927175635.2404e28a@xps-13>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 28 Sep 2023 20:22:04 -0400
Message-ID: <CAK-6q+iWit1KoHfz-sQOLD3MiONcaHXAJHbL02V3srLx4C7X2Q@mail.gmail.com>
Subject: Re: [PATCH wpan-next v4 02/11] ieee802154: Internal PAN management
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
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

On Wed, Sep 27, 2023 at 12:10=E2=80=AFPM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <net/cfg802154.h>
> > > +#include <net/af_ieee802154.h>
> > > +
> > > +/* Checks whether a device address matches one from the PAN list.
> > > + * This helper is meant to be used only during PAN management, when =
we expect
> > > + * extended addresses to be used.
> > > + */
> > > +static bool cfg802154_device_in_pan(struct ieee802154_pan_device *pa=
n_dev,
> > > +                                   struct ieee802154_addr *ext_dev)
> > > +{
> > > +       if (!pan_dev || !ext_dev)
> > > +               return false;
> > > +
> > > +       if (ext_dev->mode =3D=3D IEEE802154_ADDR_SHORT)
> > > +               return false;
> > > +
> > > +       switch (ext_dev->mode) {
> > > +       case IEEE802154_ADDR_SHORT:
> > > +               return pan_dev->short_addr =3D=3D ext_dev->short_addr=
;
> >
> > This is dead code now, it will never be reached, it's checked above
> > (Or I don't see it)? I want to help you here. What exactly do you try
> > to reach here again?
>
> It's a left over. All association/disassociation operation so far which
> need these checks are operated using extended addressing (from the
> spec). I will simplify further this helper.
>

I see, it makes sense to me.

>
> > > +bool cfg802154_device_is_parent(struct wpan_dev *wpan_dev,
> > > +                               struct ieee802154_addr *target)
> > > +{
> > > +       lockdep_assert_held(&wpan_dev->association_lock);
> > > +
> > > +       if (cfg802154_device_in_pan(wpan_dev->parent, target))
> > > +               return true;
> > > +
> > > +       return false;
> >
> > return cfg802154_device_in_pan(...); Why isn't checkpatch warning about=
 that?
>
> checkpatch does not care I guess, but I can definitely simplify this
> return path as well, you're right.
>

ok. Was a nitpick.

Thanks.

- Alex


