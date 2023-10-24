Return-Path: <netdev+bounces-43750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6302E7D489D
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 09:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9141C20AC7
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 07:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56A814A94;
	Tue, 24 Oct 2023 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV2QE2bv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DACA749C
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 07:35:18 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E78BC;
	Tue, 24 Oct 2023 00:35:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b2018a11efso4037881b3a.0;
        Tue, 24 Oct 2023 00:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698132916; x=1698737716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zAk87fwfB4GPS4RdbkGXzLRDRuyTfms5QnKn3W1HC/4=;
        b=mV2QE2bvzFtzXTN5CsGJQ8iZXBJnqw/94T9MmANkzmD+zSxTNPnCIoOqiLL7ziCchx
         OvIFQUrwEL0shfHf9PBjOccvFxm2xNsGI4IwA/TZ50mbsxMTOHkZfqPw/WDfHCiPT7TB
         NMpU86Xvow4rvN9heHAHvrZnI8BW+7Bux6+rnNTeW8+OYruywQZwHzyvCxQfhvrt19RY
         nYwLnkT3zBQZmAFjUIhXpMBpOLaD1pih3zE2DOBWK2yyWNctZxbbz4DVcgHSUNvZbMal
         Jj93kVN5fsywlU3H1X/ZdSluVMu9Q592XowcsssuEcFzizUm0eBOlBoyrPONz0xvfvAw
         bnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698132916; x=1698737716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAk87fwfB4GPS4RdbkGXzLRDRuyTfms5QnKn3W1HC/4=;
        b=ElW1iE7AZuoCYF66gklB0CHIPGHXpCvqsSoIS9dDlEzhGSXLDCuR22g7wgDmK1I+1l
         1It1tYEwWTx4xfiUxONJJbx+bDtgz60hiJkmJEpzoK7KhzzqdEeUiiqlrWKv3XcuBw+G
         WfmeJneEPhvuTkqme/D0GkizBtlmkGU8whUu9G055JA8hNBhmmumNCwYenS+YWp76bGM
         /Mi7qzn3XzOtGoGkPG94kicq2u6pvyB/Fb1NgHbO+VNqIl8gyFe1KNjGeq7h1upPDOIP
         ys9zze+IMlZfw677U0Wtf5+hdFZ56ySC5rJQgt7ymQmfSygXSCmGyhXdXsu+JkDVUpeF
         8A3g==
X-Gm-Message-State: AOJu0YzKuay0zpuVMIgDAB13Y+rC4sJw+34VigtXO2D4ukId2TQDcgse
	QGuWXIJpQghu7uqPl1Ci7u0=
X-Google-Smtp-Source: AGHT+IE0Uq7uqHz1oIbdcOd9FYHSG1Olp2Da/FFL1UVSedr0nGPlznlaUKbQJg69OM208RfsD/qvBw==
X-Received: by 2002:a05:6a20:7f81:b0:15a:3eaa:b7ea with SMTP id d1-20020a056a207f8100b0015a3eaab7eamr2295242pzj.5.1698132916411;
        Tue, 24 Oct 2023 00:35:16 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ik21-20020a170902ab1500b001c73f3a9b88sm7166353plb.110.2023.10.24.00.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 00:35:15 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id ACD0B8126624; Tue, 24 Oct 2023 14:35:11 +0700 (WIB)
Date: Tue, 24 Oct 2023 14:35:11 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2 1/2] MAINTAINERS: Move M Chetan Kumar to CREDITS
Message-ID: <ZTdzr3Dz_9K9P05E@debian.me>
References: <20231023032905.22515-2-bagasdotme@gmail.com>
 <20231023032905.22515-3-bagasdotme@gmail.com>
 <20231023093837.49c7cb35@kernel.org>
 <e1b1f477-e41d-4834-984b-0db219342e5b@gmail.com>
 <20231023185221.2eb7cb38@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EJ5R83yBRmw8TuIA"
Content-Disposition: inline
In-Reply-To: <20231023185221.2eb7cb38@kernel.org>


--EJ5R83yBRmw8TuIA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 06:52:21PM -0700, Jakub Kicinski wrote:
> On Tue, 24 Oct 2023 07:11:12 +0700 Bagas Sanjaya wrote:
> > > 14 patches authored and 15 signed off?
> > > Let me be more clear this time - nak, please drop this patch. =20
> >=20
> > Or maybe as well drop INTEL WWAN IOSM DRIVER entry (and let
> > WWAN subsystem maintainers handle it)? I don't want
> > people get their inboxes spammed with bounces against
> > his addresses, though.
>=20
> Right, sorry, still delete him from the MAINTAINERS.
> Just don't add him to the CREDITS.
>=20
> > He's now in a state of limbo. He has significant contribution
> > (and gets listed by get_maintainer script with (AFAIK) no way
> > to filter him out), yet emails to him bounces. What will be
> > the resolution then?
>=20
> Yes :( Not much we can do about that (even if we drop him from
> maintainers all fixes will CC him based on the sign-off tags).

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--EJ5R83yBRmw8TuIA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZTdznwAKCRD2uYlJVVFO
o59DAP9J8AHNIFE/ww3V6sUQCSy3mqudmTHC3okZi6VFrBgIrgEAkkPnSd/WY5bY
FSYTbkxlya1gKz04k/oSNi6z3O6LSws=
=vZXK
-----END PGP SIGNATURE-----

--EJ5R83yBRmw8TuIA--

