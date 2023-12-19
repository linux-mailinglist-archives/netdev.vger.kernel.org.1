Return-Path: <netdev+bounces-59082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9143819494
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 00:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F7D1C24E00
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 23:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFE340C08;
	Tue, 19 Dec 2023 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiulKk3x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9AF3D0DF
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3b9e6262fccso3565534b6e.3
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 15:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703028304; x=1703633104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ks1zhdwj1d70+EiLvtnBREaHOQjAAlhVMmSBKU52Vg=;
        b=XiulKk3xbc7WwHjpeRWmwVCGNK6V3fDmwxr4/0YGvsV7zNVXOt1OwmLOYGtDUDEn4L
         Deu3x091MzwIiwP3+Bjz3GMVpJE8HLIn+ZhYS6NCMlaJqqLK02/dOaz3OocM6ZNDYSqy
         sQBmsH8Fc7NeSirSLKzWxwHOAST/gbgbUO+vbrPwTDlM/nyxhgw7hc9fiOipbJZRrG6w
         vC7xojcCD3iYQvZTiS2xEOz/giZPzDHnZJcvJX0oBIr/FgtUlrjwF/GoSp4XQA7nN8tm
         up+OUKpsMP5jXRhCqhuaeQFcY/bzWbQgWsU9TEwzW/MMYOg5Znq+3g0TI97zkyT1qDAq
         MBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703028304; x=1703633104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ks1zhdwj1d70+EiLvtnBREaHOQjAAlhVMmSBKU52Vg=;
        b=PbHV8i7AkkqtqSNoWVlpX9HHAZfRStqG3zckatlq7qDnYxpCrEm5bvvcgvTNQociUd
         HAbLEs00AQZveoe3eqUPLDqMfgsza/9jaxf7YEQchKoAvKceIVCvPDVUR4WdtzxUmYiH
         GIFYFg8UGAD25+yU4onXIm1+03ejbW7K7ObM1gSWTMsvqDcQpM2WOln/HS1aBstpazdw
         k1s3tPGZ7GaGIGpF198g3G3sbB61CNVJ0CwI5c3Dv2CDhiBouFa17Qt+/544JtVBc1li
         FmvkuRchRiwXa+fC+NHdhPJmNIwkPox8Y4BjoLb9rTgjdDzKGtAqKbUjMQl2Z5Jyw9CW
         c6aw==
X-Gm-Message-State: AOJu0YwwSBquXOrJLcVJ7WelqzCbWL4/d9JLbIWPFaJ4ko376BX29rf+
	HyWt02hnPKuTemd0JcQtChY=
X-Google-Smtp-Source: AGHT+IFOqimQM3XPTjMhfXevZG8mFgE3Jvz5EZFUJVuND9db4nTbc/DMYI807vq2XKB3VPet/J9m5w==
X-Received: by 2002:a05:6808:30a3:b0:3b9:e8f4:a488 with SMTP id bl35-20020a05680830a300b003b9e8f4a488mr22661174oib.26.1703028304002;
        Tue, 19 Dec 2023 15:25:04 -0800 (PST)
Received: from pek-khao-d3 (unknown-105-121.windriver.com. [147.11.105.121])
        by smtp.gmail.com with ESMTPSA id k15-20020a05621414ef00b0067f62f08483sm712692qvw.22.2023.12.19.15.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 15:25:03 -0800 (PST)
Date: Wed, 20 Dec 2023 07:24:57 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH net-next] net: pktgen: Use wait_event_freezable_timeout()
 for freezable kthread
Message-ID: <ZYImSUWevaY88ApH@pek-khao-d3>
References: <20231216112632.2255398-1-haokexin@gmail.com>
 <38f6b7856f8060f9770ec0ea2a163c5960d9eed9.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gg9xUr6vZlP9SsgP"
Content-Disposition: inline
In-Reply-To: <38f6b7856f8060f9770ec0ea2a163c5960d9eed9.camel@redhat.com>


--gg9xUr6vZlP9SsgP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 01:37:23PM +0100, Paolo Abeni wrote:
> On Sat, 2023-12-16 at 19:26 +0800, Kevin Hao wrote:
> > A freezable kernel thread can enter frozen state during freezing by
> > either calling try_to_freeze() or using wait_event_freezable() and its
> > variants. So for the following snippet of code in a kernel thread loop:
> >   wait_event_interruptible_timeout();
> >   try_to_freeze();
> >=20
> > We can change it to a simple wait_event_freezable_timeout() and then
> > eliminate a function call.
> >=20
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> >  net/core/pktgen.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> > index 57cea67b7562..2b59fc66fe26 100644
> > --- a/net/core/pktgen.c
> > +++ b/net/core/pktgen.c
> > @@ -3669,10 +3669,8 @@ static int pktgen_thread_worker(void *arg)
> >  		if (unlikely(!pkt_dev && t->control =3D=3D 0)) {
> >  			if (t->net->pktgen_exiting)
> >  				break;
> > -			wait_event_interruptible_timeout(t->queue,
> > -							 t->control !=3D 0,
> > -							 HZ/10);
> > -			try_to_freeze();
> > +			wait_event_freezable_timeout(t->queue,
> > +						     t->control !=3D 0, HZ/10);
>=20
> The patch looks functionally correct to me, so I'm sorry to nit-pick.=A0
>=20
> Since you touch the last line just for a 'cosmetic' change, please make
> checkpatch happy, too:  please replace 'HZ/10' with 'HZ / 10'.

Yes, I saw the complaint from checkpatch before sending this patch, but I
thought I should keep it as it is. :-)
Anyway, v2 is coming.

Thanks,
Kevin
>=20
> Thanks!
>=20
> Paolo
>=20

--gg9xUr6vZlP9SsgP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmWCJkkACgkQk1jtMN6u
sXGZdAf/WDT8RbjI0JrTEHdgjOV9HHvxkHKh34XkIyB78B3wklPOrYugCdIcOQ6o
DykaM448e1uGid9+SYwiRIt30kNBfSepCKQYSUJVOa35mHtjdv/VNxi1G1sBTxtR
LKvMIVnSV6l0LzjmYzO9laDhd3q+MyETTflkjN5gM3AyEF1AExGombY+pThr1AhY
E+HRFeMcDzXXsOASus+xUM3xh1R2RYQ0YFZ5oQw6ySkJTX6u7DBbh4WI4Y7mjOwL
xtonFx2InaWhXkSxhfZiRIWRxqVfjWV6po2Af2/WIeFM9deGsRFQRUohfZY0ZJLO
V7gSdCZj0g36SOpAUfCn7tpSccjT9w==
=qzlt
-----END PGP SIGNATURE-----

--gg9xUr6vZlP9SsgP--

